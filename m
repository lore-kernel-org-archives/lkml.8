Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A381AC10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 787C820684
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 18:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgCHSAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 14:00:04 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70]:36517 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726279AbgCHSAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 14:00:04 -0400
Received: by mail-io1-f70.google.com with SMTP id s66so2357284iod.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 11:00:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=PD9YtvkiAdBou32l4xORMmfBq9YGKm82n/Ap7zmjLDM=;
        b=OqtL0AiQwaDMn7O0qOETZJD92e9Kg6Uko91m5/THyXne1NQrAK/t96YSVN53bH3V9Q
         rq004qOCnEHsAZvnX3ncE92LJHY4s8LfyWExkcX/dhlttMWL5KF5t4WEcXLOaYPiQFc5
         iJKR4z/sP6dt+g1P4G9Yxqexsu18ip4yjbBIZ1UHTshYkC/Ya88hNtl3sQL0vjBqIGrs
         E7L18yG0Bx21au+mBy8YieXbaGd57FrJMR2Pu9cPQ8wOFOgJnd+41PQKMUk4DcpMoG7M
         /WQwKOxX9cPD6rBR3OUNfCVCU6Jweym+doWGRpQzDTpkAJEK+tFSM+6xWphZuNyBLYFj
         L52g==
X-Gm-Message-State: ANhLgQ2gLtimuE3qDs9o2VZhrb7K3XE8MXIrx7hhasDd+LvX5nQ1eLwy
        05D3UerPrjZy0y2rKS2D5dDHD/KAyeSiPkk8K5A3khDws0Rh
X-Google-Smtp-Source: ADFU+vtRdNgVv2LGxJkwwao0njyyGUc5ebD5Vr7Aqg0gWfoZAil0ohtetpbvMceYhJkEz+xSFgRgtyShJHoqH90HceN0OcmF/Tz7
MIME-Version: 1.0
X-Received: by 2002:a02:cc15:: with SMTP id n21mr3170355jap.108.1583690403397;
 Sun, 08 Mar 2020 11:00:03 -0700 (PDT)
Date:   Sun, 08 Mar 2020 11:00:03 -0700
In-Reply-To: <CAG48ez2TnPppWonr8K3POyg3hGosgNXU2-ZMjyaYN4tLYRiJiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000edc57c05a05ba7cb@google.com>
Subject: Re: general protection fault in syscall_return_slowpath
From:   syzbot <syzbot+cd66e43794b178bb5cd6@syzkaller.appspotmail.com>
To:     bp@alien8.de, hpa@zytor.com, jannh@google.com,
        linux-kernel@vger.kernel.org, luto@kernel.org, mingo@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

e.o
  CC      fs/xfs/libxfs/xfs_refcount.o
  CC      fs/ceph/cache.o
  CC      fs/ocfs2/sysfile.o
  CC      fs/nfs/nfs4trace.o
  CC      fs/btrfs/extent_io.o
  CC      fs/btrfs/volumes.o
  CC      net/mac80211/mesh_sync.o
  CC      drivers/gpu/drm/drm_auth.o
  CC      fs/gfs2/recovery.o
  CC      fs/gfs2/rgrp.o
  CC      fs/btrfs/async-thread.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_region.o
  CC      net/netfilter/xt_nat.o
  CC      fs/ocfs2/uptodate.o
  AR      net/vmw_vsock/built-in.a
  CC      fs/ocfs2/quota_local.o
  CC      fs/dcache.o
  CC      fs/inode.o
  CC      fs/afs/volume.o
  CC      fs/afs/write.o
  CC      fs/ceph/acl.o
  CC      fs/btrfs/ioctl.o
  CC      fs/btrfs/locking.o
  CC      fs/afs/xattr.o
  CC      net/netfilter/xt_AUDIT.o
  CC      fs/ocfs2/quota_global.o
  CC      fs/btrfs/orphan.o
  CC      fs/btrfs/export.o
  CC      net/netfilter/xt_CHECKSUM.o
  CC      fs/attr.o
  CC      net/netfilter/xt_CLASSIFY.o
  CC      drivers/gpu/drm/drm_cache.o
  CC      fs/bad_inode.o
  CC      fs/nfs/nfs4sysctl.o
  CC      drivers/gpu/drm/drm_file.o
  CC      fs/file.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_shmem.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_shrinker.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_stolen.o
  CC      fs/gfs2/super.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_throttle.o
  CC      fs/btrfs/tree-log.o
  CC      net/netfilter/xt_CONNSECMARK.o
  CC      fs/f2fs/xattr.o
  CC      fs/ocfs2/xattr.o
  CC      net/netfilter/xt_CT.o
  CC      net/mac80211/mesh_ps.o
  CC      fs/f2fs/acl.o
  CC      fs/filesystems.o
  AR      fs/erofs/built-in.a
  CC      fs/f2fs/verity.o
  CC      drivers/gpu/drm/drm_gem.o
  CC      fs/ocfs2/acl.o
  CC      fs/gfs2/sys.o
  CC      drivers/gpu/drm/drm_ioctl.o
  CC      fs/ocfs2/filecheck.o
  CC      fs/btrfs/free-space-cache.o
  CC      fs/namespace.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_tiling.o
  CC      drivers/gpu/drm/drm_irq.o
  CC      fs/ocfs2/stack_o2cb.o
  CC      fs/ocfs2/stackglue.o
  AR      fs/ceph/built-in.a
  CC      drivers/gpu/drm/drm_memory.o
  CC      fs/btrfs/zlib.o
  CC      fs/btrfs/lzo.o
  CC      fs/nfs/pnfs.o
  CC      fs/gfs2/trans.o
  CC      fs/gfs2/util.o
  CC      fs/ocfs2/stack_user.o
  CC      fs/xfs/libxfs/xfs_refcount_btree.o
  CC      fs/xfs/libxfs/xfs_sb.o
  CC      net/netfilter/xt_DSCP.o
  CC      net/netfilter/xt_HL.o
  CC      drivers/gpu/drm/drm_drv.o
  CC      drivers/gpu/drm/drm_sysfs.o
  CC      fs/afs/yfsclient.o
  CC      fs/btrfs/zstd.o
  CC      fs/afs/proc.o
  CC      fs/f2fs/compress.o
  CC      fs/seq_file.o
  CC      fs/xattr.o
  CC      net/netfilter/xt_HMARK.o
  CC      net/mac80211/pm.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_userptr.o
  CC      net/mac80211/rc80211_minstrel.o
  CC      net/mac80211/rc80211_minstrel_ht.o
  CC      fs/gfs2/lock_dlm.o
  CC      fs/nfs/pnfs_dev.o
  CC      fs/nfs/pnfs_nfs.o
  CC      fs/nfs/nfs42proc.o
  CC      fs/btrfs/compression.o
  CC      drivers/gpu/drm/i915/gem/i915_gem_wait.o
  CC      drivers/gpu/drm/i915/gem/i915_gemfs.o
  CC      net/mac80211/rc80211_minstrel_debugfs.o
  CC      net/mac80211/rc80211_minstrel_ht_debugfs.o
  CC      fs/btrfs/delayed-ref.o
  CC      drivers/gpu/drm/drm_hashtab.o
  CC      fs/xfs/libxfs/xfs_symlink_remote.o
  CC      fs/xfs/libxfs/xfs_trans_resv.o
  CC      net/netfilter/xt_LED.o
  CC      fs/xfs/libxfs/xfs_trans_inode.o
  CC      fs/xfs/libxfs/xfs_types.o
  CC      fs/btrfs/relocation.o
  CC      net/netfilter/xt_LOG.o
  CC      drivers/gpu/drm/drm_mm.o
  CC      net/netfilter/xt_NETMAP.o
  CC      net/netfilter/xt_NFLOG.o
  CC      net/netfilter/xt_NFQUEUE.o
  CC      net/netfilter/xt_RATEEST.o
  CC      drivers/gpu/drm/i915/i915_active.o
  CC      net/netfilter/xt_REDIRECT.o
  CC      fs/btrfs/delayed-inode.o
  CC      drivers/gpu/drm/i915/i915_buddy.o
  CC      fs/xfs/libxfs/xfs_rtbitmap.o
  CC      fs/btrfs/scrub.o
  CC      fs/libfs.o
  CC      drivers/gpu/drm/drm_crtc.o
  CC      drivers/gpu/drm/drm_fourcc.o
  CC      drivers/gpu/drm/drm_modes.o
  CC      drivers/gpu/drm/drm_edid.o
  CC      fs/fs-writeback.o
  CC      drivers/gpu/drm/i915/i915_cmd_parser.o
  CC      fs/pnode.o
  CC      fs/splice.o
  CC      drivers/gpu/drm/i915/i915_gem_evict.o
  CC      fs/sync.o
  CC      fs/utimes.o
  CC      fs/d_path.o
  AR      fs/gfs2/built-in.a
  CC      fs/xfs/xfs_aops.o
  CC      fs/xfs/xfs_attr_inactive.o
  CC      drivers/gpu/drm/i915/i915_gem_fence_reg.o
  CC      drivers/gpu/drm/i915/i915_gem_gtt.o
  CC      drivers/gpu/drm/i915/i915_gem.o
  CC      fs/btrfs/reada.o
  CC      fs/btrfs/backref.o
  CC      drivers/gpu/drm/drm_encoder_slave.o
  CC      drivers/gpu/drm/drm_trace_points.o
  CC      drivers/gpu/drm/drm_prime.o
  CC      drivers/gpu/drm/drm_rect.o
  CC      fs/stack.o
  CC      net/netfilter/xt_MASQUERADE.o
  CC      fs/xfs/xfs_attr_list.o
  CC      drivers/gpu/drm/drm_vma_manager.o
  CC      fs/xfs/xfs_bmap_util.o
  CC      fs/fs_struct.o
  CC      net/netfilter/xt_SECMARK.o
  CC      fs/xfs/xfs_bio_io.o
  CC      drivers/gpu/drm/i915/i915_globals.o
  CC      drivers/gpu/drm/i915/i915_query.o
  CC      fs/xfs/xfs_buf.o
  CC      fs/xfs/xfs_dir2_readdir.o
  CC      drivers/gpu/drm/i915/i915_request.o
  CC      drivers/gpu/drm/i915/i915_scheduler.o
  CC      drivers/gpu/drm/drm_flip_work.o
  CC      net/netfilter/xt_TPROXY.o
  CC      fs/statfs.o
  CC      fs/btrfs/ulist.o
  CC      drivers/gpu/drm/drm_modeset_lock.o
  CC      drivers/gpu/drm/drm_atomic.o
  CC      drivers/gpu/drm/drm_bridge.o
  CC      drivers/gpu/drm/drm_framebuffer.o
  AR      fs/afs/built-in.a
  CC      drivers/gpu/drm/drm_connector.o
  CC      drivers/gpu/drm/drm_blend.o
  CC      fs/xfs/xfs_discard.o
  CC      fs/fs_pin.o
  CC      drivers/gpu/drm/drm_encoder.o
  CC      fs/nsfs.o
  CC      drivers/gpu/drm/drm_mode_object.o
  CC      fs/fs_types.o
  CC      net/netfilter/xt_TCPMSS.o
  CC      fs/xfs/xfs_error.o
  AR      fs/f2fs/built-in.a
  CC      drivers/gpu/drm/drm_property.o
  CC      drivers/gpu/drm/i915/i915_trace_points.o
  CC      net/netfilter/xt_TCPOPTSTRIP.o
  CC      drivers/gpu/drm/i915/i915_vma.o
  CC      fs/btrfs/qgroup.o
  CC      fs/xfs/xfs_export.o
  CC      fs/xfs/xfs_extent_busy.o
  CC      drivers/gpu/drm/drm_plane.o
  CC      fs/fs_context.o
  CC      fs/fs_parser.o
  CC      fs/xfs/xfs_file.o
  CC      fs/btrfs/send.o
  CC      drivers/gpu/drm/drm_color_mgmt.o
  CC      fs/btrfs/dev-replace.o
  CC      drivers/gpu/drm/i915/intel_region_lmem.o
  CC      fs/buffer.o
  CC      fs/fsopen.o
  CC      fs/xfs/xfs_filestream.o
  CC      fs/xfs/xfs_fsmap.o
  CC      fs/block_dev.o
  CC      drivers/gpu/drm/i915/intel_wopcm.o
  CC      fs/btrfs/uuid-tree.o
  CC      fs/btrfs/raid56.o
  CC      drivers/gpu/drm/drm_print.o
  CC      fs/xfs/xfs_fsops.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_uc.o
  CC      net/netfilter/xt_TEE.o
  CC      net/netfilter/xt_TRACE.o
  CC      net/netfilter/xt_IDLETIMER.o
  CC      net/netfilter/xt_addrtype.o
  CC      drivers/gpu/drm/drm_dumb_buffers.o
  CC      fs/direct-io.o
  CC      net/netfilter/xt_bpf.o
  CC      net/netfilter/xt_cluster.o
  CC      drivers/gpu/drm/drm_mode_config.o
  CC      fs/btrfs/props.o
  CC      fs/xfs/xfs_globals.o
  CC      drivers/gpu/drm/drm_vblank.o
  AR      net/mac80211/built-in.a
  CC      fs/xfs/xfs_health.o
  CC      drivers/gpu/drm/drm_syncobj.o
  CC      fs/mpage.o
  CC      fs/xfs/xfs_icache.o
  CC      drivers/gpu/drm/drm_lease.o
  CC      fs/proc_namespace.o
  CC      fs/btrfs/free-space-tree.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_uc_fw.o
  CC      fs/eventpoll.o
  CC      fs/anon_inodes.o
  CC      fs/signalfd.o
  CC      fs/btrfs/tree-checker.o
  CC      fs/btrfs/space-info.o
  CC      fs/xfs/xfs_ioctl.o
  CC      fs/xfs/xfs_iomap.o
  CC      drivers/gpu/drm/drm_writeback.o
  CC      fs/btrfs/block-rsv.o
  CC      fs/xfs/xfs_iops.o
  CC      drivers/gpu/drm/drm_client.o
  CC      fs/xfs/xfs_inode.o
  CC      drivers/gpu/drm/drm_client_modeset.o
  CC      fs/xfs/xfs_itable.o
  CC      fs/btrfs/delalloc-space.o
  CC      drivers/gpu/drm/drm_atomic_uapi.o
  CC      net/netfilter/xt_comment.o
  CC      drivers/gpu/drm/drm_hdcp.o
  CC      net/netfilter/xt_connbytes.o
  CC      fs/xfs/xfs_iwalk.o
  AR      fs/nfs/built-in.a
  CC      drivers/gpu/drm/i915/gt/uc/intel_guc.o
  CC      drivers/gpu/drm/drm_ioc32.o
  CC      fs/btrfs/block-group.o
  CC      net/netfilter/xt_connlabel.o
  CC      fs/timerfd.o
  CC      net/netfilter/xt_connlimit.o
  CC      fs/xfs/xfs_message.o
  CC      fs/btrfs/discard.o
  CC      fs/btrfs/acl.o
  CC      drivers/gpu/drm/drm_gem_shmem_helper.o
  CC      fs/xfs/xfs_mount.o
  CC      fs/eventfd.o
  CC      drivers/gpu/drm/drm_panel.o
  CC      net/netfilter/xt_conntrack.o
  CC      drivers/gpu/drm/drm_agpsupport.o
  CC      fs/userfaultfd.o
  CC      net/netfilter/xt_cpu.o
  CC      net/netfilter/xt_devgroup.o
  CC      net/netfilter/xt_dccp.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_guc_ads.o
  CC      net/netfilter/xt_dscp.o
  CC      fs/aio.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_guc_ct.o
  CC      fs/xfs/xfs_mru_cache.o
  CC      fs/io_uring.o
  CC      drivers/gpu/drm/drm_pci.o
  CC      drivers/gpu/drm/drm_debugfs.o
  CC      net/netfilter/xt_ecn.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_guc_fw.o
  CC      fs/io-wq.o
  CC      drivers/gpu/drm/drm_debugfs_crc.o
  CC      fs/dax.o
  CC      fs/xfs/xfs_pwork.o
  CC      fs/xfs/xfs_reflink.o
  CC      drivers/gpu/drm/drm_mipi_dsi.o
  CC      fs/locks.o
  CC      fs/xfs/xfs_stats.o
  CC      net/netfilter/xt_esp.o
  CC      fs/xfs/xfs_super.o
  CC      net/netfilter/xt_hashlimit.o
  CC      fs/compat.o
  CC      net/netfilter/xt_helper.o
  CC      fs/binfmt_misc.o
  CC      drivers/gpu/drm/drm_panel_orientation_quirks.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_guc_log.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_guc_submission.o
  CC      net/netfilter/xt_hl.o
  CC      fs/binfmt_script.o
  CC      net/netfilter/xt_ipcomp.o
  CC      net/netfilter/xt_iprange.o
  CC      fs/binfmt_elf.o
  CC      fs/compat_binfmt_elf.o
  CC      net/netfilter/xt_ipvs.o
  CC      net/netfilter/xt_l2tp.o
  CC      fs/mbcache.o
  CC      net/netfilter/xt_length.o
  CC      net/netfilter/xt_limit.o
  CC      net/netfilter/xt_mac.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_huc.o
  CC      fs/posix_acl.o
  CC      fs/drop_caches.o
  CC      fs/coredump.o
  CC      drivers/gpu/drm/i915/gt/uc/intel_huc_fw.o
  CC      fs/xfs/xfs_symlink.o
  CC      fs/fhandle.o
  CC      drivers/gpu/drm/i915/display/intel_atomic.o
  CC      fs/dcookies.o
  CC      fs/xfs/xfs_sysfs.o
  CC      drivers/gpu/drm/i915/display/intel_atomic_plane.o
  CC      fs/xfs/xfs_trans.o
  CC      fs/xfs/xfs_xattr.o
  CC      net/netfilter/xt_multiport.o
  CC      net/netfilter/xt_nfacct.o
  CC      net/netfilter/xt_osf.o
  CC      drivers/gpu/drm/i915/display/intel_audio.o
  CC      net/netfilter/xt_owner.o
  CC      net/netfilter/xt_cgroup.o
  CC      fs/xfs/kmem.o
  CC      drivers/gpu/drm/i915/display/intel_bios.o
  AR      fs/ocfs2/built-in.a
  CC      fs/xfs/xfs_log.o
  CC      fs/xfs/xfs_log_cil.o
  CC      drivers/gpu/drm/i915/display/intel_bw.o
  CC      drivers/gpu/drm/i915/display/intel_cdclk.o
  CC      drivers/gpu/drm/i915/display/intel_color.o
  CC      fs/xfs/xfs_bmap_item.o
  CC      drivers/gpu/drm/i915/display/intel_combo_phy.o
  CC      fs/xfs/xfs_buf_item.o
  CC      net/netfilter/xt_physdev.o
  CC      drivers/gpu/drm/i915/display/intel_connector.o
  CC      fs/xfs/xfs_extfree_item.o
  CC      drivers/gpu/drm/i915/display/intel_display.o
  CC      net/netfilter/xt_pkttype.o
  CC      net/netfilter/xt_policy.o
  CC      drivers/gpu/drm/i915/display/intel_display_power.o
  CC      fs/xfs/xfs_icreate_item.o
  CC      fs/xfs/xfs_inode_item.o
  CC      drivers/gpu/drm/i915/display/intel_dpio_phy.o
  CC      drivers/gpu/drm/i915/display/intel_dpll_mgr.o
  CC      fs/xfs/xfs_refcount_item.o
  CC      net/netfilter/xt_quota.o
  CC      drivers/gpu/drm/i915/display/intel_dsb.o
  CC      net/netfilter/xt_rateest.o
  CC      net/netfilter/xt_realm.o
  CC      drivers/gpu/drm/i915/display/intel_fbc.o
  CC      drivers/gpu/drm/i915/display/intel_fifo_underrun.o
  CC      fs/xfs/xfs_rmap_item.o
  CC      fs/xfs/xfs_log_recover.o
  CC      net/netfilter/xt_recent.o
  CC      net/netfilter/xt_sctp.o
  CC      fs/xfs/xfs_trans_ail.o
  CC      net/netfilter/xt_socket.o
  CC      drivers/gpu/drm/i915/display/intel_frontbuffer.o
  CC      drivers/gpu/drm/i915/display/intel_hdcp.o
  CC      fs/xfs/xfs_trans_buf.o
  CC      net/netfilter/xt_state.o
  CC      drivers/gpu/drm/i915/display/intel_hotplug.o
  CC      net/netfilter/xt_statistic.o
  CC      fs/xfs/xfs_dquot.o
  CC      net/netfilter/xt_string.o
  CC      net/netfilter/xt_tcpmss.o
  CC      net/netfilter/xt_time.o
  CC      fs/xfs/xfs_dquot_item.o
  CC      fs/xfs/xfs_trans_dquot.o
  CC      fs/xfs/xfs_qm_syscalls.o
  CC      drivers/gpu/drm/i915/display/intel_lpe_audio.o
  CC      net/netfilter/xt_u32.o
  CC      fs/xfs/xfs_qm_bhv.o
  CC      drivers/gpu/drm/i915/display/intel_overlay.o
  CC      drivers/gpu/drm/i915/display/intel_psr.o
  CC      fs/xfs/xfs_qm.o
  CC      drivers/gpu/drm/i915/display/intel_quirks.o
  CC      fs/xfs/xfs_quotaops.o
  CC      fs/xfs/xfs_rtalloc.o
  CC      fs/xfs/xfs_acl.o
  CC      fs/xfs/xfs_sysctl.o
  CC      fs/xfs/xfs_ioctl32.o
  CC      fs/xfs/xfs_pnfs.o
  CC      drivers/gpu/drm/i915/display/intel_sprite.o
  CC      drivers/gpu/drm/i915/display/intel_tc.o
  CC      drivers/gpu/drm/i915/display/intel_vga.o
  CC      drivers/gpu/drm/i915/display/intel_acpi.o
  CC      drivers/gpu/drm/i915/display/intel_opregion.o
  CC      drivers/gpu/drm/i915/display/intel_fbdev.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7017.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7xxx.o
  CC      drivers/gpu/drm/i915/display/dvo_ivch.o
  CC      drivers/gpu/drm/i915/display/dvo_ns2501.o
  CC      drivers/gpu/drm/i915/display/dvo_sil164.o
  CC      drivers/gpu/drm/i915/display/dvo_tfp410.o
  CC      drivers/gpu/drm/i915/display/icl_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  AR      net/netfilter/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  AR      net/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_hsw.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bdw.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_chv.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt2.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt4.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bxt.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt2.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_glk.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt2.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_icl.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cnl.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_tgl.o
  AR      fs/btrfs/built-in.a
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  AR      fs/xfs/built-in.a
  AR      fs/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
Makefile:1681: recipe for target 'drivers' failed
make: *** [drivers] Error 2


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=148c5f29e00000


Tested on:

commit:         63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1336c0a9e00000

