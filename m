Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD275C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1F6720748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594353138;
	bh=xLvKF2sWDcGdNloTJLpeuSq/KhHOkOtOuMlIFvINFr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DQMN0pLNPH3YolgNjkcgOYR6SzVLXJ8IQ2ynq2oOIIlrO/KVRDZVAShqklLwoLgK8
	 eFNmCEpkfOwLQSTuJLdLEcALalz6jdtzBZoUfiZ/IWGjbKvybiSK80BcHmdUekaQv5
	 kb/6YjhDaZWbMWyFq+Z06+1xjA6qUuR/QVg15izE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJDwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:59494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgGJDwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:52:17 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EEC12072E;
        Fri, 10 Jul 2020 03:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594353136;
        bh=xLvKF2sWDcGdNloTJLpeuSq/KhHOkOtOuMlIFvINFr8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRUJV3hPsaC5eC2jDa4m2VO6wXQ533lEQU80iGsTlYYbaqYNMSvP6brBtcbxFuhcc
         x0NOGXCxuW0R+O8F9fOMVCP0vV94um/7aBKonAWbgBj6g62PIkGQRPtWXSMB9TVlkv
         DSv6R3fqXapSYwfxwYflnXu740Ivry6+HBR3vTF8=
Date:   Thu, 9 Jul 2020 20:52:15 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Daeho Jeong <daeho43@gmail.com>,
        Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: change the way of handling range.len in
 F2FS_IOC_SEC_TRIM_FILE
Message-ID: <20200710035215.GI545837@google.com>
References: <20200710021505.2405872-1-daeho43@gmail.com>
 <20200710030246.GA545837@google.com>
 <62c9dd7a-5d18-8bb6-8e43-c055fcff51cc@huawei.com>
 <20200710033100.GE545837@google.com>
 <ede6620c-6fc9-797d-e3ea-e630eb76b309@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ede6620c-6fc9-797d-e3ea-e630eb76b309@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Chao Yu wrote:
> On 2020/7/10 11:31, Jaegeuk Kim wrote:
> > On 07/10, Chao Yu wrote:
> >> On 2020/7/10 11:02, Jaegeuk Kim wrote:
> >>> On 07/10, Daeho Jeong wrote:
> >>>> From: Daeho Jeong <daehojeong@google.com>
> >>>>
> >>>> Changed the way of handling range.len of F2FS_IOC_SEC_TRIM_FILE.
> >>>>  1. Added -1 value support for range.len to signify the end of file.
> >>>>  2. If the end of the range passes over the end of file, it means until
> >>>>     the end of file.
> >>>>  3. ignored the case of that range.len is zero to prevent the function
> >>>>     from making end_addr zero and triggering different behaviour of
> >>>>     the function.
> >>>>
> >>>> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> >>>> ---
> >>>>  fs/f2fs/file.c | 16 +++++++---------
> >>>>  1 file changed, 7 insertions(+), 9 deletions(-)
> >>>>
> >>>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> >>>> index 368c80f8e2a1..1c4601f99326 100644
> >>>> --- a/fs/f2fs/file.c
> >>>> +++ b/fs/f2fs/file.c
> >>>> @@ -3813,21 +3813,19 @@ static int f2fs_sec_trim_file(struct file *filp, unsigned long arg)
> >>>>  	file_start_write(filp);
> >>>>  	inode_lock(inode);
> >>>>  
> >>>> -	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode)) {
> >>>> +	if (f2fs_is_atomic_file(inode) || f2fs_compressed_file(inode) ||
> >>>> +			range.start >= inode->i_size) {
> >>>>  		ret = -EINVAL;
> >>>>  		goto err;
> >>>>  	}
> >>>>  
> >>>> -	if (range.start >= inode->i_size) {
> >>>> -		ret = -EINVAL;
> >>>> +	if (range.len == 0)
> >>>>  		goto err;
> >>>> -	}
> >>>>  
> >>>> -	if (inode->i_size - range.start < range.len) {
> >>>> -		ret = -E2BIG;
> >>>> -		goto err;
> >>>> -	}
> >>>> -	end_addr = range.start + range.len;
> >>>> +	if (range.len == (u64)-1 || inode->i_size - range.start < range.len)
> >>>> +		end_addr = inode->i_size;
> >>
> >> We can remove 'range.len == (u64)-1' condition since later condition can cover
> >> this?
> >>
> >>>
> >>> Hmm, what if there are blocks beyond i_size? Do we need to check i_blocks for
> >>
> >> The blocks beyond i_size will never be written, there won't be any valid message
> >> there, so we don't need to worry about that.
> > 
> > I don't think we have a way to guarantee the order of i_size and block
> > allocation in f2fs. See f2fs_write_begin and f2fs_write_end.
> 
> However, write_begin & write_end are covered by inode_lock, it could not be
> racy with inode size check in f2fs_sec_trim_file() as it hold inode_lock as
> well?

Like Daeho said, write_begin -> checkpoint -> power-cut can give bigger i_blocks
than i_size.

> 
> > 
> >>
> >> Thanks,
> >>
> >>> ending criteria?
> >>>
> >>>> +	else
> >>>> +		end_addr = range.start + range.len;
> >>>>  
> >>>>  	to_end = (end_addr == inode->i_size);
> >>>>  	if (!IS_ALIGNED(range.start, F2FS_BLKSIZE) ||
> >>>> -- 
> >>>> 2.27.0.383.g050319c2ae-goog
> >>>>
> >>>>
> >>>>
> >>>> _______________________________________________
> >>>> Linux-f2fs-devel mailing list
> >>>> Linux-f2fs-devel@lists.sourceforge.net
> >>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> >>> .
> >>>
> > .
> > 
