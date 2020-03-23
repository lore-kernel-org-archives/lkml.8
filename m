Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D3C10F26
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293B220732
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 04:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584936984;
	bh=2VPoavb3/Nh65+u7sn+FxjbORv9J9qX5wWi4UPuIvng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=p0pR5oB0mpYn7IkXvjWi2DSFlimZuJlZC1ALmO6FzETjw2qEFd2LAQJDxUrgrEUKw
	 vrzl8YjiPH8hjJjEJ4GtchziHLlffhwDK5XCANIhljaapmY+aal7c2VSX05WfLWADZ
	 Yf8CkW6QkBUYWvKRWKg0EkeF3dvuMQRy82t0jAyY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbgCWEQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 00:16:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:52516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgCWEQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 00:16:21 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4345620719;
        Mon, 23 Mar 2020 04:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584936980;
        bh=2VPoavb3/Nh65+u7sn+FxjbORv9J9qX5wWi4UPuIvng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WUCqFrmJGJ1z6rhNT/5V4ZIUm7ipQ7z18II1tlu9mk47y39o93IYNZvPKW49oB+Y6
         DrH3W2AubwKpH1D9rhGw5sikGCHIczjXruck9FdRpYrS4OgYMjWsRvC35ivB2csZYD
         MKn2DrUYWjISPK69Iz6nh9jvAMJb+kHY9bsheJ30=
Date:   Sun, 22 Mar 2020 21:16:19 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Ju Hyung Park <qkrwngud825@gmail.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2] f2fs: use kmem_cache pool during inline xattr lookups
Message-ID: <20200323041619.GD147648@google.com>
References: <20200225101710.40123-1-yuchao0@huawei.com>
 <CAD14+f3pi331-V0gzjtxcMRVaEn3tPacrC20wtRq9+6JY9_HVA@mail.gmail.com>
 <08d03473-9871-ba10-4626-58c4479ef9d1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08d03473-9871-ba10-4626-58c4479ef9d1@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/19, Chao Yu wrote:
> Hi Ju Hyung,
> 
> On 2020/3/18 20:14, Ju Hyung Park wrote:
> > Hi Chao.
> > 
> > I got the time around to test this patch.
> > The v2 patch seems to work just fine, and the code looks good.
> 
> Thanks a lot for the review and test.
> 
> > 
> > On Tue, Feb 25, 2020 at 7:17 PM Chao Yu <yuchao0@huawei.com> wrote:
> >> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> >> index a3360a97e624..e46a10eb0e42 100644
> >> --- a/fs/f2fs/xattr.c
> >> +++ b/fs/f2fs/xattr.c
> >> @@ -23,6 +23,25 @@
> >>  #include "xattr.h"
> >>  #include "segment.h"
> >>
> >> +static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
> >> +{
> >> +       *is_inline = (size == sbi->inline_xattr_slab_size);
> > 
> > Would it be meaningless to change this to the following code?
> > if (likely(size == sbi->inline_xattr_slab_size))
> >     *is_inline = true;
> > else
> >     *is_inline = false;
> 
> Yup, I guess it's very rare that user will change inline xattr size via remount,
> so I'm okay with this change.

Applied like this. Thanks,

 26 static void *xattr_alloc(struct f2fs_sb_info *sbi, int size, bool *is_inline)
 27 {
 28         if (likely(size == sbi->inline_xattr_slab_size)) {
 29                 *is_inline = true;
 30                 return kmem_cache_zalloc(sbi->inline_xattr_slab, GFP_NOFS);
 31         }
 32         *is_inline = false;
 33         return f2fs_kzalloc(sbi, size, GFP_NOFS);
 34 }

> 
> Jaegeuk,
> 
> Could you please help to update the patch in your git tree directly?
> 
> Thanks,
> 
> > 
> > The above statement seems to be only false during the initial mount
> > and the rest(millions) seems to be always true.
> > 
> > Thanks.
> > .
> > 
