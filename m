Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374AEC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10A3620775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595860302;
	bh=M4XB6A0Or7ENzp2Ogu+rq/XEJ+qLF4cqMriz9m8WTfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJ2mcgyhSrY+6BcpP/Y/FjxJ/rQqZxwJcVK+g5B39hwRmSLPJ0bDSIzf6bHhinS6G
	 LOwWLCySkEz6Ik4lhIsA9V5MFBTPd+txylyDPNO9BIdP5RBdcDZM02c//5FVTc7+IN
	 XtM7H+pVnkXX5LVf/D+5gZ4NOR6U3zGLE5Za5z7E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732575AbgG0Obk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731526AbgG0OUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:20:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E73520775;
        Mon, 27 Jul 2020 14:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859615;
        bh=M4XB6A0Or7ENzp2Ogu+rq/XEJ+qLF4cqMriz9m8WTfE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r26xTxCMXMnXc1rPKAW/XbbTKMJI0xhuXvrYExk59dRavBfxapkhU183nh1ZFjFdP
         XEVGwCPA+s/2kPPHUNy2dGjX/cePqznR+wYFeMxNDaAfGZyG+2en5feW9X40Slw7zQ
         r1BLQfKH2OXZOC8Ii7LslRxZ6PdBSj4NcnwnyLk0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Boris Burkov <boris@bur.io>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH 5.7 039/179] btrfs: fix mount failure caused by race with umount
Date:   Mon, 27 Jul 2020 16:03:34 +0200
Message-Id: <20200727134934.579218640@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134932.659499757@linuxfoundation.org>
References: <20200727134932.659499757@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boris Burkov <boris@bur.io>

commit 48cfa61b58a1fee0bc49eef04f8ccf31493b7cdd upstream.

It is possible to cause a btrfs mount to fail by racing it with a slow
umount. The crux of the sequence is generic_shutdown_super not yet
calling sop->put_super before btrfs_mount_root calls btrfs_open_devices.
If that occurs, btrfs_open_devices will decide the opened counter is
non-zero, increment it, and skip resetting fs_devices->total_rw_bytes to
0. From here, mount will call sget which will result in grab_super
trying to take the super block umount semaphore. That semaphore will be
held by the slow umount, so mount will block. Before up-ing the
semaphore, umount will delete the super block, resulting in mount's sget
reliably allocating a new one, which causes the mount path to dutifully
fill it out, and increment total_rw_bytes a second time, which causes
the mount to fail, as we see double the expected bytes.

Here is the sequence laid out in greater detail:

CPU0                                                    CPU1
down_write sb->s_umount
btrfs_kill_super
  kill_anon_super(sb)
    generic_shutdown_super(sb);
      shrink_dcache_for_umount(sb);
      sync_filesystem(sb);
      evict_inodes(sb); // SLOW

                                              btrfs_mount_root
                                                btrfs_scan_one_device
                                                fs_devices = device->fs_devices
                                                fs_info->fs_devices = fs_devices
                                                // fs_devices-opened makes this a no-op
                                                btrfs_open_devices(fs_devices, mode, fs_type)
                                                s = sget(fs_type, test, set, flags, fs_info);
                                                  find sb in s_instances
                                                  grab_super(sb);
                                                    down_write(&s->s_umount); // blocks

      sop->put_super(sb)
        // sb->fs_devices->opened == 2; no-op
      spin_lock(&sb_lock);
      hlist_del_init(&sb->s_instances);
      spin_unlock(&sb_lock);
      up_write(&sb->s_umount);
                                                    return 0;
                                                  retry lookup
                                                  don't find sb in s_instances (deleted by CPU0)
                                                  s = alloc_super
                                                  return s;
                                                btrfs_fill_super(s, fs_devices, data)
                                                  open_ctree // fs_devices total_rw_bytes improperly set!
                                                    btrfs_read_chunk_tree
                                                      read_one_dev // increment total_rw_bytes again!!
                                                      super_total_bytes < fs_devices->total_rw_bytes // ERROR!!!

To fix this, we clear total_rw_bytes from within btrfs_read_chunk_tree
before the calls to read_one_dev, while holding the sb umount semaphore
and the uuid mutex.

To reproduce, it is sufficient to dirty a decent number of inodes, then
quickly umount and mount.

  for i in $(seq 0 500)
  do
    dd if=/dev/zero of="/mnt/foo/$i" bs=1M count=1
  done
  umount /mnt/foo&
  mount /mnt/foo

does the trick for me.

CC: stable@vger.kernel.org # 4.4+
Signed-off-by: Boris Burkov <boris@bur.io>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/volumes.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -7056,6 +7056,14 @@ int btrfs_read_chunk_tree(struct btrfs_f
 	mutex_lock(&fs_info->chunk_mutex);
 
 	/*
+	 * It is possible for mount and umount to race in such a way that
+	 * we execute this code path, but open_fs_devices failed to clear
+	 * total_rw_bytes. We certainly want it cleared before reading the
+	 * device items, so clear it here.
+	 */
+	fs_info->fs_devices->total_rw_bytes = 0;
+
+	/*
 	 * Read all device items, and then all the chunk items. All
 	 * device items are found before any chunk item (their object id
 	 * is smaller than the lowest possible object id for a chunk


