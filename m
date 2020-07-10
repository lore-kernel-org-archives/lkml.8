Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886B3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60D3220748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594353056;
	bh=hObc9B15Ofq12aAQ4BtIME3uk1sIIW2p9hj83IUp0cw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZSaEgHmlFL65sUvn6cLTiMYD7Shu7P1OdEwW4pVTDUwKw0fV6TaMfID8TSpnr0+AS
	 UlPbKlIdgb0BQKXogrVEh24v171SQnCC6SVXMjNMWOfY+tO4gky16ZUq2Sj1A134zr
	 NnhcRKhoqbCyfyZwhv6qTVALnj/XVliPDzTL+Cyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGJDuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:59348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbgGJDuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:50:54 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F361D2072E;
        Fri, 10 Jul 2020 03:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594353054;
        bh=hObc9B15Ofq12aAQ4BtIME3uk1sIIW2p9hj83IUp0cw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DRMSHRXgW+6+9XZgjy5ubtuWyfVl2iQzIsm3m/Ihrvy+tdbGG18Tj92ewpb3jm47d
         v7GL054oxMje9ucMbtaSN1O/DXxSKJJCCK57sepC5g+T/dzJeJEYMfBFWX4IYlptg+
         ABM+NKjFFSwPFGYNqPC/yKDjTNmOXIzRvP3jurWQ=
Date:   Thu, 9 Jul 2020 20:50:53 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't skip writeback of quota data
Message-ID: <20200710035053.GH545837@google.com>
References: <20200709053027.351974-1-jaegeuk@kernel.org>
 <2f4207db-57d1-5b66-f1ee-3532feba5d1f@huawei.com>
 <20200709190545.GA3001066@google.com>
 <ae1a3e8a-6209-8d4b-7235-5c8897076501@huawei.com>
 <20200710032616.GC545837@google.com>
 <01d0db54-eee1-f6cd-76c3-ebe59a7abae4@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01d0db54-eee1-f6cd-76c3-ebe59a7abae4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10, Chao Yu wrote:
> On 2020/7/10 11:26, Jaegeuk Kim wrote:
> > On 07/10, Chao Yu wrote:
> >> On 2020/7/10 3:05, Jaegeuk Kim wrote:
> >>> On 07/09, Chao Yu wrote:
> >>>> On 2020/7/9 13:30, Jaegeuk Kim wrote:
> >>>>> It doesn't need to bypass flushing quota data in background.
> >>>>
> >>>> The condition is used to flush quota data in batch to avoid random
> >>>> small-sized udpate, did you hit any problem here?
> >>>
> >>> I suspect this causes fault injection test being stuck by waiting for inode
> >>> writeback completion. With this patch, it has been running w/o any issue so far.
> >>> I keep an eye on this.
> >>
> >> Hmmm.. so that this patch may not fix the root cause, and it may hiding the
> >> issue deeper.
> >>
> >> How about just keeping this patch in our private branch to let fault injection
> >> test not be stuck? until we find the root cause in upstream codes.
> > 
> > Well, I don't think this hides something. When the issue happens, I saw inodes
> > being stuck due to writeback while only quota has some dirty data. At that time,
> > there was no dirty data page from other inodes.
> 
> Okay,
> 
> > 
> > More specifically, I suspect __writeback_inodes_sb_nr() gives WB_SYNC_NONE and
> > waits for wb_wait_for_completion().
> 
> Did you record any callstack after the issue happened?

I found this.

[213389.297642]  __schedule+0x2dd/0x780^M
[213389.299224]  schedule+0x55/0xc0^M
[213389.300745]  wb_wait_for_completion+0x56/0x90^M
[213389.302469]  ? wait_woken+0x80/0x80^M
[213389.303997]  __writeback_inodes_sb_nr+0xa8/0xd0^M
[213389.305760]  writeback_inodes_sb+0x4b/0x60^M
[213389.307439]  sync_filesystem+0x2e/0xa0^M
[213389.308999]  generic_shutdown_super+0x27/0x110^M
[213389.310738]  kill_block_super+0x27/0x50^M
[213389.312327]  kill_f2fs_super+0x76/0xe0 [f2fs]^M
[213389.314014]  deactivate_locked_super+0x3b/0x80^M
[213389.315692]  deactivate_super+0x3e/0x50^M
[213389.317226]  cleanup_mnt+0x109/0x160^M
[213389.318718]  __cleanup_mnt+0x12/0x20^M
[213389.320177]  task_work_run+0x70/0xb0^M
[213389.321609]  exit_to_usermode_loop+0x131/0x160^M
[213389.323306]  do_syscall_64+0x170/0x1b0^M
[213389.324762]  entry_SYSCALL_64_after_hwframe+0x44/0xa9^M
[213389.326477] RIP: 0033:0x7fc4b5e6a35b^M

> 
> Still I'm confused that why directory's data written could be skipped, but
> quota's data couldn't, what's the difference?

I suspect different blocking timing from cp_error between quota and dentry.
e.g., we block dir operations right after cp_error, while quota can make
dirty pages in more fine granularity.

> 
> > 
> >>
> >> Thanks,
> >>
> >>>
> >>> Thanks,
> >>>
> >>>>
> >>>> Thanks,
> >>>>
> >>>>>
> >>>>> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> >>>>> ---
> >>>>>  fs/f2fs/data.c | 2 +-
> >>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>>
> >>>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>>>> index 44645f4f914b6..72e8b50e588c1 100644
> >>>>> --- a/fs/f2fs/data.c
> >>>>> +++ b/fs/f2fs/data.c
> >>>>> @@ -3148,7 +3148,7 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> >>>>>  	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
> >>>>>  		goto skip_write;
> >>>>>  
> >>>>> -	if ((S_ISDIR(inode->i_mode) || IS_NOQUOTA(inode)) &&
> >>>>> +	if (S_ISDIR(inode->i_mode) &&
> >>>>>  			wbc->sync_mode == WB_SYNC_NONE &&
> >>>>>  			get_dirty_pages(inode) < nr_pages_to_skip(sbi, DATA) &&
> >>>>>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
> >>>>>
> >>> .
> >>>
> > .
> > 
