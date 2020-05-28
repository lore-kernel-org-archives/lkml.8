Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37907C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E0F8208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 01:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590629177;
	bh=FrkNrOnyuxxgqjKw18LCwgpFRO2g3jWI9Z3k+0njVXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gD1xY12su1iZWxc8eSAMXTcs1lP2xkxl7Q+cE0F9qQT8lscMIJJaxAxeybDVB2/aH
	 8cNWu+6hQP+qdcKSXlwCoGk3iFauy0o1iaY0WTG8MKGVzldfVRxzvnkju6zt4Q7Hsz
	 07k0npX2+0kp5WTam3rTFBK3kyjC34L6iwfJKmiY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgE1B0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 21:26:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:42928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725747AbgE1B0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 21:26:15 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82B1920888;
        Thu, 28 May 2020 01:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590629175;
        bh=FrkNrOnyuxxgqjKw18LCwgpFRO2g3jWI9Z3k+0njVXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NR0QGGZyrKSAieQ6Pte0JsOsZzZtDrD/6rX7sz1N5YPNmxprW3x2V4nULOEE1cWRG
         Dy4fT75efExtLjP7Zhl813wPkRRXrWe0utFYw/Ri3IeChB4nngDk6kCf0VN6dNqASl
         aGG0gQHe6NM6lFMSuH31TZ/qwV9LI8z5h6y4Es8A=
Date:   Wed, 27 May 2020 18:26:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: fix to cover meta flush with cp_lock
Message-ID: <20200528012615.GA232094@google.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
 <20200527102753.15743-3-yuchao0@huawei.com>
 <20200527210233.GC206249@google.com>
 <23245f6e-528d-43ab-57b6-4ca16db43fe5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23245f6e-528d-43ab-57b6-4ca16db43fe5@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28, Chao Yu wrote:
> On 2020/5/28 5:02, Jaegeuk Kim wrote:
> > On 05/27, Chao Yu wrote:
> >> meta inode page should be flushed under cp_lock, fix it.
> > 
> > It doesn't matter for this case, yes?
> 
> It's not related to discard issue.

I meant we really need this or not. :P

> 
> Now, I got some progress, I can reproduce that bug occasionally.
> 
> Thanks,
> 
> > 
> >>
> >> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >> ---
> >>  fs/f2fs/file.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >> index f7de2a1da528..0fcae4d90074 100644
> >> --- a/fs/f2fs/file.c
> >> +++ b/fs/f2fs/file.c
> >> @@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> >>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> >>  		break;
> >>  	case F2FS_GOING_DOWN_METAFLUSH:
> >> +		mutex_lock(&sbi->cp_mutex);
> >>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
> >> +		mutex_unlock(&sbi->cp_mutex);
> >>  		f2fs_stop_checkpoint(sbi, false);
> >>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> >>  		break;
> >> -- 
> >> 2.18.0.rc1
> > .
> > 
