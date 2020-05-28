Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1C4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A1120721
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590692423;
	bh=IBEXcJa5SZhZ23qO9uJI7HCaq75DLLMpP4eqn+jfAFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Srdim9IfW4c8X/iCEbY2zRIaHx4PSW2dHb+jIYxgmsFcIzYvWBKY7/vbR/AMS4W/C
	 e4jiZeQrFElkTWPTEyok2U1Zm840aUhjwNeO8xRXlepN5GsVa34JoDCACdguJ/02ES
	 1OAUfP7c8dSf1lXoezaLgj9cZcXsNB8pu1FNIUlk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406093AbgE1TAW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:00:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:41786 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406018AbgE1TAM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:00:12 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D8DD208A7;
        Thu, 28 May 2020 19:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590692411;
        bh=IBEXcJa5SZhZ23qO9uJI7HCaq75DLLMpP4eqn+jfAFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YUCZZwbwvxE/dv74jVYYRkbAOdMaZ60UPrX80T8LV4B2i1Y88+ZdTIbc9gjcNbERe
         IDtz1LMY9A2VZT/seUPpll60XHOAGxnS8FDdWgpp2D1lemfr0XbzXzIY1eHT5v2rcz
         RyEXMS8zfSot99O/44ZbsAIWh53vW2KTlvSV/xIY=
Date:   Thu, 28 May 2020 12:00:10 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH 3/3] f2fs: fix to cover meta flush with cp_lock
Message-ID: <20200528190010.GA162605@google.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
 <20200527102753.15743-3-yuchao0@huawei.com>
 <20200527210233.GC206249@google.com>
 <23245f6e-528d-43ab-57b6-4ca16db43fe5@huawei.com>
 <20200528012615.GA232094@google.com>
 <8e30b18d-bf8e-dd2f-35fa-08bbfd1b507e@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e30b18d-bf8e-dd2f-35fa-08bbfd1b507e@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/28, Chao Yu wrote:
> On 2020/5/28 9:26, Jaegeuk Kim wrote:
> > On 05/28, Chao Yu wrote:
> >> On 2020/5/28 5:02, Jaegeuk Kim wrote:
> >>> On 05/27, Chao Yu wrote:
> >>>> meta inode page should be flushed under cp_lock, fix it.
> >>>
> >>> It doesn't matter for this case, yes?
> >>
> >> It's not related to discard issue.
> > 
> > I meant we really need this or not. :P
> 
> Yes, let's keep that rule: flush meta pages under cp_lock, otherwise
> checkpoint flush order may be broken due to race, right? as checkpoint
> should write 2rd cp park page after flushing all meta pages.

Well, this is for shutdown test, and thus we don't need to sync up here.

> 
> > 
> >>
> >> Now, I got some progress, I can reproduce that bug occasionally.
> >>
> >> Thanks,
> >>
> >>>
> >>>>
> >>>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> >>>> ---
> >>>>  fs/f2fs/file.c | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index f7de2a1da528..0fcae4d90074 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
> >>>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> >>>>  		break;
> >>>>  	case F2FS_GOING_DOWN_METAFLUSH:
> >>>> +		mutex_lock(&sbi->cp_mutex);
> >>>>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
> >>>> +		mutex_unlock(&sbi->cp_mutex);
> >>>>  		f2fs_stop_checkpoint(sbi, false);
> >>>>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
> >>>>  		break;
> >>>> -- 
> >>>> 2.18.0.rc1
> >>> .
> >>>
> > .
> > 
