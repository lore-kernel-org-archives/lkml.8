Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=CHARSET_FARAWAY_HEADER,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F05C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 03:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B62C20853
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 03:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbgFRD2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 23:28:24 -0400
Received: from mx.wingtech.com ([180.166.216.14]:35293 "EHLO mail.wingtech.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgFRD2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 23:28:23 -0400
Received: from mx.wingtech.com ([192.168.2.43])
        by mail.wingtech.com  with SMTP id 05I3SL7F005477-05I3SL7G005477
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 11:28:21 +0800
Received: from 192.168.51.143 (HELO ZHAOWUYUN); Thu, 18 Jun 2020 11:28:18 +0800
From:   "Zac" <zhaowuyun@wingtech.com>
To:     "'Chao Yu'" <yuchao0@huawei.com>, <jaegeuk@kernel.org>
Cc:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <1592384659-20203-1-git-send-email-zhaowuyun@wingtech.com> <86069ba3-cba3-7bc9-c90b-e931abd0dde5@huawei.com> <000001d64519$b05a1180$110e3480$@wingtech.com> <86c34c66-b370-6c6d-91fe-b9235f9c5785@huawei.com>
In-Reply-To: <86c34c66-b370-6c6d-91fe-b9235f9c5785@huawei.com>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIXSBmMmZzOiBmaXggYSByYWNlIGNvbg==?=
        =?gb2312?B?ZGl0aW9uIGJldHdlZW4gZjJmc193cml0ZV9lbmRfaW8gYW5kIGYyZg==?=
        =?gb2312?B?c19kZWxfZnN5bmNfbm9kZV9lbnRyeQ==?=
Date:   Thu, 18 Jun 2020 11:28:20 +0800
Message-ID: <002d01d64520$840b4750$8c21d5f0$@wingtech.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="gb2312"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJusS8b7G89rONhvQTSKQ9/POQtRgGSiybFAmikCJoCPxgJ/Kd7DCAw
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 2020/6/18 10:39, Zac wrote:
> >
> >> On 2020/6/17 17:04, zhaowuyun@wingtech.com wrote:
> >>> From: Wuyun Zhao <zhaowuyun@wingtech.com>
> >>>
> >>> Under some condition, the __write_node_page will submit a page which
> is
> >> not
> >>> f2fs_in_warm_node_list and will not call f2fs_add_fsync_node_entry.
> >>> f2fs_gc continue to run to invoke f2fs_iget -> do_read_inode to read
the
> >> same node page
> >>> and set code node, which make f2fs_in_warm_node_list become true,
> >>> that will cause f2fs_bug_on in f2fs_del_fsync_node_entry when
> >> f2fs_write_end_io called.
> >> Could you please add below race condition description into commit
> >> message?
> >>
> >> - f2fs_write_end_io
> >> 					- f2fs_iget
> >> 					 - do_read_inode
> >> 					  - set_cold_node
> >> 					  recover cold node flag
> >>  - f2fs_in_warm_node_list
> >>   - is_cold_node
> >>   if node is cold, assume we have added
> >>   node to fsync_node_list during writepages()
> >>  - f2fs_del_fsync_node_entry
> >>   - f2fs_bug_on() due to node page
> >>   is not in fsync_node_list
> >
> > Ok, will add the commit message.
> >
> >> BTW, I'm curious about why we can lose cold flag for non-dir inode?
> >> any clue to reproduce this bug (I mean losing cold flag)?
> >
> > it's a f2fs image with 25600MB
> > flash this image to device
> > the device will resize it according to the userdata partition size which
is
> > about 94GB
> > the device mount the f2fs partition
> > then hit this f2fs_bug_on
> >
> > seems that the cold flag is not been set when mkfs
> 
> Ah, I guess both mkfs/sload ignores setting cold node flag for non-dir
inode,
> could you please send another patch to fix this issue?

Patch v2 has been sent.

> >
> > I think the issue is that
> >
> > 1. the node page in the storage is without cold bit
> > 2. f2fs_disable_checkpoint -> f2fs_gc -> f2fs_get_node_page, this page
> won't
> > be set cold flag
> > 3. f2fs_move_node_page -> __write_node_page to write this page
> > 4. f2fs_gc -> f2fs_iget -> do_read_inode to read this page and set cold
flag
> 
> Clear enough, thanks for your explanation. :)
> 
> Thanks,
> 
> >
> >>>
> >>> [   34.966133] Call trace:
> >>> [   34.969902]  f2fs_del_fsync_node_entry+0x100/0x108
> >>> [   34.976071]  f2fs_write_end_io+0x1e0/0x288
> >>> [   34.981539]  bio_endio+0x248/0x270
> >>> [   34.986289]  blk_update_request+0x2b0/0x4d8
> >>> [   34.991841]  scsi_end_request+0x40/0x440
> >>> [   34.997126]  scsi_io_completion+0xa4/0x748
> >>> [   35.002593]  scsi_finish_command+0xdc/0x110
> >>> [   35.008143]  scsi_softirq_done+0x118/0x150
> >>> [   35.013610]  blk_done_softirq+0x8c/0xe8
> >>> [   35.018811]  __do_softirq+0x2e8/0x578
> >>> [   35.023828]  irq_exit+0xfc/0x120
> >>> [   35.028398]  handle_IPI+0x1d8/0x330
> >>> [   35.033233]  gic_handle_irq+0x110/0x1d4
> >>> [   35.038433]  el1_irq+0xb4/0x130
> >>> [   35.042917]  kmem_cache_alloc+0x3f0/0x418
> >>> [   35.048288]  radix_tree_node_alloc+0x50/0xf8
> >>> [   35.053933]  __radix_tree_create+0xf8/0x188
> >>> [   35.059484]  __radix_tree_insert+0x3c/0x128
> >>> [   35.065035]  add_gc_inode+0x90/0x118
> >>> [   35.069967]  f2fs_gc+0x1b80/0x2d70
> >>> [   35.074718]  f2fs_disable_checkpoint+0x94/0x1d0
> >>> [   35.080621]  f2fs_fill_super+0x10c4/0x1b88
> >>> [   35.086088]  mount_bdev+0x194/0x1e0
> >>> [   35.090923]  f2fs_mount+0x40/0x50
> >>> [   35.095589]  mount_fs+0xb4/0x190
> >>> [   35.100159]  vfs_kern_mount+0x80/0x1d8
> >>> [   35.105260]  do_mount+0x478/0xf18
> >>> [   35.109926]  ksys_mount+0x90/0xd0
> >>> [   35.114592]  __arm64_sys_mount+0x24/0x38
> >>>
> >>> Signed-off-by: Wuyun Zhao <zhaowuyun@wingtech.com>
> >>
> >> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> >>
> >> Thanks,
> >>
> >>> ---
> >>>  fs/f2fs/inode.c | 1 +
> >>>  1 file changed, 1 insertion(+)
> >>>
> >>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> >>> index be6ac33..0df5c8c 100644
> >>> --- a/fs/f2fs/inode.c
> >>> +++ b/fs/f2fs/inode.c
> >>> @@ -402,6 +402,7 @@ static int do_read_inode(struct inode *inode)
> >>>
> >>>  	/* try to recover cold bit for non-dir inode */
> >>>  	if (!S_ISDIR(inode->i_mode) && !is_cold_node(node_page)) {
> >>> +		f2fs_wait_on_page_writeback(node_page, NODE, true, true);
> >>>  		set_cold_node(node_page, false);
> >>>  		set_page_dirty(node_page);
> >>>  	}
> >>>
> >
> > .
> >

