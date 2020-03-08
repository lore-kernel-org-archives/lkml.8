Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C83C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13B9C2083E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCHV5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:57:03 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:34552 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726332AbgCHV5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:57:03 -0400
Received: by mail-io1-f71.google.com with SMTP id n26so2358183iop.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 14:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xtGAyHaiY5vNv4jLYxadKdLoBw6hAEy2iFOhzyGFuEc=;
        b=RnRBWw+ifgF+0uXnXdYspG0G+SCvoCDZXUhs49RVCeNA+eUZzayK6CpcL41ckbcBdD
         1kruHpD+MMms6X9OtjrXrwV1qApUPAl6Q1tPkGUM5jIWZfCXhE7z7UvgHyY8qVf9pmjP
         HLpnqawkpOwLeSSU7QYIVwPIdcjqQaljIW075BaaT2gUIHfkrsmDx0MqCq8enwWnDqVf
         w1ZyKS9KRVjepM/U0K4WIfjdWUttOXC4JE6V2JniokNxLFiUsPtBqkTULiFVVAmAMkhY
         scMn8eOMldoIFf0QE202gntFbkuPxUEqJPQRAJ0LX21zVh5bFP3lOAd5gbhKIjMuiQWx
         NoJQ==
X-Gm-Message-State: ANhLgQ3maAUR3SvyiNOJuJ7Y96GirPLj54tNLaRZ9HwFP+KaePZlVwPQ
        Sa3rVulXgZUQ4BkrZDWjdhQlQpeZqTiMaynXwP9LcL+9Cyvu
X-Google-Smtp-Source: ADFU+vtTZbohLIoP2Nv/M6NSGyKmL11d2YBQC5peUNzMr5h2lwyWdWpo7o5Tf/Ie1EHem31peEworHv9bo9EyeP+FM0kuidz2JmU
MIME-Version: 1.0
X-Received: by 2002:a92:8f46:: with SMTP id j67mr12591298ild.125.1583704622321;
 Sun, 08 Mar 2020 14:57:02 -0700 (PDT)
Date:   Sun, 08 Mar 2020 14:57:02 -0700
In-Reply-To: <CAG48ez02bt7V4+n68MNK3bmHpXxDnNmLZn8LpZ8r2w63ZhrkiQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007157fb05a05ef770@google.com>
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

int.o
  CC      net/nfc/hci/llc.o
  CC      fs/super.o
  CC      fs/char_dev.o
  CC      fs/f2fs/gc.o
  CC      net/netfilter/nf_flow_table_core.o
  CC      net/vmw_vsock/af_vsock.o
  CC      net/vmw_vsock/af_vsock_tap.o
  CC      net/mac80211/tx.o
  CC      fs/stat.o
  CC      fs/gfs2/export.o
  CC      fs/gfs2/file.o
  CC      fs/f2fs/data.o
  CC      net/openvswitch/dp_notify.o
  CC      lib/timerqueue.o
  CC      net/ceph/auth_none.o
  CC      lib/vsprintf.o
  CC      net/nfc/hci/llc_nop.o
  CC      net/openvswitch/flow.o
  CC      fs/gfs2/ops_fstype.o
  CC      fs/btrfs/transaction.o
  CC      fs/btrfs/inode.o
  CC      fs/gfs2/inode.o
  CC      net/ceph/crypto.o
  CC      lib/win_minmax.o
  CC      net/nfc/hci/llc_shdlc.o
  CC      net/ceph/armor.o
  CC      net/ceph/auth_x.o
  CC      net/netfilter/nf_flow_table_ip.o
  CC      fs/f2fs/node.o
  CC      net/ceph/ceph_hash.o
  CC      net/ceph/ceph_strings.o
  CC      net/ceph/pagevec.o
  CC      drivers/gpu/drm/i915/display/intel_sprite.o
  CC      fs/btrfs/file.o
  CC      net/mac80211/key.o
  CC      net/openvswitch/flow_netlink.o
  CC      fs/ceph/caps.o
  CC      fs/gfs2/quota.o
  CC      fs/ceph/snap.o
  CC      net/mac80211/util.o
  CC      net/ceph/snapshot.o
  CC      net/ceph/string_table.o
  CC      drivers/gpu/drm/i915/display/intel_tc.o
  CC      drivers/gpu/drm/i915/display/intel_vga.o
  CC      drivers/gpu/drm/i915/display/intel_acpi.o
  CC      fs/xfs/libxfs/xfs_dir2_data.o
  CC      fs/f2fs/segment.o
  CC      drivers/gpu/drm/i915/display/intel_opregion.o
  CC      fs/gfs2/recovery.o
  CC      fs/gfs2/rgrp.o
  CC      net/vmw_vsock/vsock_addr.o
  CC      fs/exec.o
  CC      lib/xarray.o
  CC      net/mac80211/wme.o
  CC      net/netfilter/nf_flow_table_offload.o
  CC      net/mac80211/chan.o
  CC      fs/gfs2/sys.o
  CC      fs/gfs2/super.o
  CC      net/openvswitch/flow_table.o
  AR      fs/erofs/built-in.a
  CC      net/openvswitch/meter.o
  AR      net/nfc/hci/built-in.a
  CC      fs/pipe.o
  CC      fs/gfs2/trans.o
  CC      net/mac80211/trace.o
  CC      net/nfc/af_nfc.o
  CC      fs/ceph/xattr.o
  CC      net/openvswitch/vport.o
  CC      fs/namei.o
  CC      fs/fcntl.o
  CC      fs/gfs2/util.o
  CC      net/openvswitch/vport-internal_dev.o
  CC      fs/xfs/libxfs/xfs_dir2_leaf.o
  CC      drivers/gpu/drm/i915/display/intel_fbdev.o
  CC      fs/xfs/libxfs/xfs_dir2_node.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7xxx.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7017.o
  CC      net/netfilter/nf_flow_table_inet.o
  CC      drivers/gpu/drm/i915/display/dvo_ivch.o
  CC      net/openvswitch/vport-netdev.o
  AR      net/batman-adv/built-in.a
  CC      net/vmw_vsock/diag.o
  CC      net/vmw_vsock/virtio_transport.o
  CC      fs/gfs2/lock_dlm.o
  CC      net/mpls/mpls_gso.o
  CC      fs/ceph/quota.o
  AR      net/ceph/built-in.a
  CC      fs/xfs/libxfs/xfs_dir2_sf.o
  CC      net/nfc/rawsock.o
  CC      net/openvswitch/conntrack.o
  CC      fs/xfs/libxfs/xfs_dquot_buf.o
  CC      net/nfc/llcp_core.o
  CC      net/netfilter/x_tables.o
  CC      net/netfilter/xt_tcpudp.o
  CC      net/nsh/nsh.o
  CC      net/mac80211/mlme.o
  CC      fs/f2fs/recovery.o
  CC      net/hsr/hsr_main.o
  CC      net/hsr/hsr_device.o
  CC      net/hsr/hsr_framereg.o
  CC      net/hsr/hsr_netlink.o
  CC      fs/f2fs/shrinker.o
  CC      net/mac80211/tdls.o
  CC      net/openvswitch/vport-geneve.o
  CC      net/openvswitch/vport-vxlan.o
  CC      drivers/gpu/drm/i915/display/dvo_ns2501.o
  CC      net/hsr/hsr_slave.o
  CC      net/netfilter/xt_mark.o
  GEN     lib/crc32table.h
  CC      net/openvswitch/vport-gre.o
  CC      net/mpls/af_mpls.o
  CC      fs/ceph/io.o
  GEN     lib/crc64table.h
  CC      fs/f2fs/extent_cache.o
  CC      fs/f2fs/sysfs.o
  CC      net/netfilter/xt_connmark.o
  CC      fs/ceph/mds_client.o
  CC      fs/ceph/strings.o
  CC      fs/ceph/mdsmap.o
  CC      fs/xfs/libxfs/xfs_ialloc.o
  CC      net/vmw_vsock/virtio_transport_common.o
  CC      fs/xfs/libxfs/xfs_ialloc_btree.o
  CC      fs/xfs/libxfs/xfs_iext_tree.o
  CC      fs/btrfs/tree-defrag.o
  CC      net/switchdev/switchdev.o
  CC      net/nfc/llcp_commands.o
  CC      net/nfc/llcp_sock.o
  CC      net/nfc/digital_core.o
  CC      net/nfc/digital_technology.o
  CC      net/nfc/digital_dep.o
  CC      fs/xfs/libxfs/xfs_inode_fork.o
  CC      fs/xfs/libxfs/xfs_inode_buf.o
  AR      fs/gfs2/built-in.a
  CC      fs/f2fs/debug.o
  CC      fs/btrfs/extent_map.o
  CC      net/hsr/hsr_forward.o
  CC      net/netfilter/xt_set.o
  CC      net/netfilter/xt_nat.o
  CC      net/mac80211/ocb.o
  CC      net/mac80211/airtime.o
  CC      fs/ceph/ceph_frag.o
  CC      lib/oid_registry.o
  AR      lib/lib.a
  AR      net/nsh/built-in.a
  CC      fs/xfs/libxfs/xfs_log_rlimit.o
  CC      drivers/gpu/drm/i915/display/dvo_sil164.o
  CC      fs/ceph/debugfs.o
  CC      net/hsr/hsr_debugfs.o
  CC      net/mac80211/led.o
  CC      net/mac80211/debugfs.o
  CC      fs/ceph/cache.o
  CC      fs/ceph/util.o
  CC      fs/f2fs/xattr.o
  CC      fs/btrfs/sysfs.o
  CC      fs/ceph/acl.o
  CC      fs/btrfs/struct-funcs.o
  CC      net/netfilter/xt_AUDIT.o
  CC      fs/f2fs/acl.o
  CC      net/netfilter/xt_CHECKSUM.o
  CC      fs/ioctl.o
  CC      net/netfilter/xt_CLASSIFY.o
  CC      net/netfilter/xt_CONNSECMARK.o
  CC      net/mac80211/debugfs_sta.o
  CC      fs/readdir.o
  CC      lib/crc32.o
  AR      net/openvswitch/built-in.a
  CC      fs/btrfs/xattr.o
  CC      fs/xfs/libxfs/xfs_ag_resv.o
  CC      fs/btrfs/ordered-data.o
  CC      net/mac80211/debugfs_netdev.o
  CC      net/mac80211/debugfs_key.o
  CC      fs/xfs/libxfs/xfs_rmap.o
  CC      fs/xfs/libxfs/xfs_rmap_btree.o
  AR      fs/ocfs2/built-in.a
  CC      net/mac80211/mesh.o
  CC      net/vmw_vsock/vsock_loopback.o
  CC      fs/xfs/libxfs/xfs_refcount.o
  AR      net/hsr/built-in.a
  CC      net/mpls/mpls_iptunnel.o
  CC      fs/f2fs/verity.o
  CC      net/mac80211/mesh_pathtbl.o
  CC      fs/f2fs/compress.o
  AR      net/nfc/built-in.a
  CC      net/netfilter/xt_CT.o
  CC      net/l3mdev/l3mdev.o
  EXPORTS lib/lib-ksyms.o
  CC      lib/crc64.o
  CC      net/mac80211/mesh_plink.o
  CC      net/mac80211/mesh_hwmp.o
  CC      drivers/gpu/drm/i915/display/dvo_tfp410.o
  CC      fs/xfs/libxfs/xfs_refcount_btree.o
  CC      net/netfilter/xt_DSCP.o
  CC      net/mac80211/mesh_sync.o
  CC      fs/select.o
  CC      net/mac80211/mesh_ps.o
  CC      net/netfilter/xt_HL.o
  CC      fs/xfs/libxfs/xfs_sb.o
  AR      net/switchdev/built-in.a
  CC      fs/xfs/libxfs/xfs_symlink_remote.o
  CC      fs/btrfs/extent_io.o
  CC      fs/btrfs/volumes.o
  CC      fs/btrfs/async-thread.o
  CC      fs/btrfs/ioctl.o
  CC      net/netfilter/xt_HMARK.o
  CC      net/mac80211/pm.o
  CC      fs/xfs/libxfs/xfs_trans_inode.o
  CC      fs/xfs/libxfs/xfs_trans_resv.o
  CC      fs/xfs/libxfs/xfs_types.o
  CC      fs/xfs/libxfs/xfs_rtbitmap.o
  AR      lib/built-in.a
  CC      net/netfilter/xt_LED.o
  CC      net/netfilter/xt_LOG.o
  CC      fs/btrfs/locking.o
  CC      fs/xfs/xfs_aops.o
  CC      fs/inode.o
  CC      fs/dcache.o
  CC      fs/attr.o
  AR      net/vmw_vsock/built-in.a
  CC      fs/bad_inode.o
  CC      net/mac80211/rc80211_minstrel.o
  CC      fs/file.o
  CC      fs/xfs/xfs_attr_inactive.o
  CC      fs/filesystems.o
  CC      fs/namespace.o
  CC      fs/seq_file.o
  CC      drivers/gpu/drm/i915/display/icl_dsi.o
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  AR      net/mpls/built-in.a
  CC      net/ncsi/ncsi-cmd.o
  CC      net/xdp/xsk.o
  CC      net/netfilter/xt_NETMAP.o
  AR      net/l3mdev/built-in.a
  CC      net/mptcp/protocol.o
  CC      fs/xfs/xfs_attr_list.o
  AR      fs/ceph/built-in.a
  CC      net/netfilter/xt_NFLOG.o
  CC      net/ncsi/ncsi-rsp.o
  CC      net/mptcp/subflow.o
  CC      net/mptcp/options.o
  CC      net/netfilter/xt_NFQUEUE.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      net/mac80211/rc80211_minstrel_ht.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      net/mac80211/rc80211_minstrel_debugfs.o
  CC      fs/xattr.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      net/netfilter/xt_RATEEST.o
  CC      fs/xfs/xfs_bmap_util.o
  CC      fs/btrfs/orphan.o
  CC      fs/xfs/xfs_bio_io.o
  CC      fs/btrfs/export.o
  CC      net/mac80211/rc80211_minstrel_ht_debugfs.o
  CC      fs/xfs/xfs_buf.o
  CC      fs/xfs/xfs_dir2_readdir.o
  CC      fs/xfs/xfs_discard.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      fs/btrfs/tree-log.o
  CC      fs/btrfs/free-space-cache.o
  CC      fs/xfs/xfs_error.o
  CC      fs/btrfs/zlib.o
  CC      fs/xfs/xfs_export.o
  AR      fs/f2fs/built-in.a
  CC      fs/btrfs/lzo.o
  CC      net/socket.o
  CC      net/compat.o
  CC      fs/libfs.o
  CC      fs/xfs/xfs_extent_busy.o
  CC      fs/xfs/xfs_file.o
  CC      fs/fs-writeback.o
  CC      fs/pnode.o
  CC      fs/xfs/xfs_filestream.o
  CC      net/netfilter/xt_REDIRECT.o
  CC      fs/xfs/xfs_fsmap.o
  CC      net/ncsi/ncsi-aen.o
  CC      net/xdp/xdp_umem.o
  CC      net/xdp/xsk_queue.o
  CC      net/xdp/xsk_diag.o
  CC      net/netfilter/xt_MASQUERADE.o
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      net/sysctl_net.o
  CC      net/netfilter/xt_SECMARK.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      fs/xfs/xfs_fsops.o
  CC      fs/xfs/xfs_globals.o
  CC      fs/xfs/xfs_health.o
  CC      fs/xfs/xfs_icache.o
  CC      fs/btrfs/zstd.o
  CC      net/mptcp/token.o
  CC      net/mptcp/crypto.o
  CC      net/ncsi/ncsi-manage.o
  CC      fs/xfs/xfs_ioctl.o
  CC      fs/xfs/xfs_iomap.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      fs/btrfs/compression.o
  CC      net/netfilter/xt_TPROXY.o
  CC      net/netfilter/xt_TCPMSS.o
  CC      net/ncsi/ncsi-netlink.o
  CC      fs/btrfs/delayed-ref.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      fs/btrfs/relocation.o
  CC      fs/btrfs/delayed-inode.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      net/mptcp/ctrl.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      fs/xfs/xfs_iops.o
  CC      fs/splice.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  CC      fs/xfs/xfs_inode.o
  CC      fs/xfs/xfs_itable.o
  CC      fs/btrfs/scrub.o
  CC      fs/btrfs/reada.o
  CC      fs/btrfs/backref.o
  CC      fs/sync.o
  CC      net/netfilter/xt_TCPOPTSTRIP.o
  CC      fs/utimes.o
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  CC      fs/btrfs/ulist.o
  CC      fs/xfs/xfs_iwalk.o
  CC      fs/xfs/xfs_message.o
  CC      fs/xfs/xfs_mount.o
  CC      fs/btrfs/qgroup.o
  CC      fs/btrfs/send.o
  CC      fs/d_path.o
  CC      fs/xfs/xfs_mru_cache.o
  CC      net/netfilter/xt_IDLETIMER.o
  CC      net/netfilter/xt_TRACE.o
  CC      net/netfilter/xt_TEE.o
  CC      net/netfilter/xt_addrtype.o
  CC      net/netfilter/xt_bpf.o
  CC      fs/stack.o
  CC      fs/xfs/xfs_pwork.o
  CC      fs/fs_struct.o
  CC      fs/btrfs/dev-replace.o
  AR      net/xdp/built-in.a
  CC      fs/btrfs/raid56.o
  CC      fs/btrfs/uuid-tree.o
  CC      fs/statfs.o
  CC      net/netfilter/xt_cluster.o
  CC      fs/xfs/xfs_reflink.o
  AR      net/mptcp/built-in.a
  CC      fs/xfs/xfs_stats.o
  AR      net/mac80211/built-in.a
  CC      fs/xfs/xfs_super.o
  CC      fs/fs_pin.o
  CC      net/netfilter/xt_comment.o
  CC      net/netfilter/xt_connbytes.o
  CC      net/netfilter/xt_connlabel.o
  CC      net/netfilter/xt_connlimit.o
  CC      fs/xfs/xfs_symlink.o
  CC      net/netfilter/xt_conntrack.o
  CC      fs/xfs/xfs_sysfs.o
  CC      fs/xfs/xfs_trans.o
  CC      fs/nsfs.o
  CC      fs/btrfs/props.o
  CC      fs/btrfs/free-space-tree.o
  CC      net/netfilter/xt_cpu.o
  CC      net/netfilter/xt_dccp.o
  CC      fs/btrfs/tree-checker.o
  CC      fs/fs_types.o
  CC      net/netfilter/xt_devgroup.o
  CC      fs/fs_context.o
  CC      fs/xfs/xfs_xattr.o
  CC      fs/btrfs/space-info.o
  CC      fs/fsopen.o
  CC      fs/fs_parser.o
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      fs/xfs/kmem.o
  CC      fs/btrfs/block-rsv.o
  CC      fs/xfs/xfs_log.o
  CC      fs/xfs/xfs_log_cil.o
  CC      fs/xfs/xfs_bmap_item.o
  CC      fs/btrfs/delalloc-space.o
  CC      fs/btrfs/block-group.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  AR      net/ncsi/built-in.a
  CC      net/netfilter/xt_dscp.o
  CC      fs/buffer.o
  CC      fs/xfs/xfs_buf_item.o
  CC      net/netfilter/xt_ecn.o
  CC      fs/btrfs/discard.o
  CC      fs/block_dev.o
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      fs/xfs/xfs_extfree_item.o
  CC      fs/xfs/xfs_icreate_item.o
  CC      fs/btrfs/acl.o
  CC      net/netfilter/xt_esp.o
  CC      net/netfilter/xt_hashlimit.o
  CC      fs/xfs/xfs_inode_item.o
  CC      fs/xfs/xfs_refcount_item.o
  CC      fs/xfs/xfs_rmap_item.o
  CC      fs/xfs/xfs_log_recover.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_hsw.o
  CC      fs/xfs/xfs_trans_ail.o
  CC      fs/xfs/xfs_trans_buf.o
  CC      fs/direct-io.o
  CC      fs/mpage.o
  CC      fs/proc_namespace.o
  CC      fs/eventpoll.o
  CC      fs/anon_inodes.o
  CC      fs/xfs/xfs_dquot.o
  CC      fs/signalfd.o
  CC      fs/timerfd.o
  CC      net/netfilter/xt_helper.o
  CC      fs/eventfd.o
  CC      net/netfilter/xt_hl.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bdw.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_chv.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt2.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt4.o
  CC      net/netfilter/xt_ipcomp.o
  CC      fs/xfs/xfs_dquot_item.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bxt.o
  CC      fs/xfs/xfs_trans_dquot.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt2.o
  CC      net/netfilter/xt_iprange.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_glk.o
  CC      fs/xfs/xfs_qm_syscalls.o
  CC      fs/userfaultfd.o
  CC      fs/aio.o
  CC      fs/io_uring.o
  CC      net/netfilter/xt_ipvs.o
  CC      net/netfilter/xt_l2tp.o
  CC      net/netfilter/xt_length.o
  CC      fs/xfs/xfs_qm_bhv.o
  CC      net/netfilter/xt_limit.o
  CC      fs/xfs/xfs_qm.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt2.o
  CC      fs/io-wq.o
  CC      net/netfilter/xt_mac.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cnl.o
  CC      net/netfilter/xt_multiport.o
  CC      fs/xfs/xfs_quotaops.o
  CC      net/netfilter/xt_osf.o
  CC      net/netfilter/xt_nfacct.o
  CC      fs/xfs/xfs_rtalloc.o
  CC      fs/xfs/xfs_acl.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_icl.o
  CC      net/netfilter/xt_owner.o
  CC      fs/dax.o
  CC      fs/locks.o
  CC      fs/compat.o
  CC      fs/binfmt_misc.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_tgl.o
  CC      net/netfilter/xt_physdev.o
  CC      net/netfilter/xt_cgroup.o
  CC      net/netfilter/xt_pkttype.o
  CC      net/netfilter/xt_quota.o
  CC      net/netfilter/xt_policy.o
  CC      fs/binfmt_script.o
  CC      net/netfilter/xt_rateest.o
  CC      fs/xfs/xfs_sysctl.o
  CC      net/netfilter/xt_realm.o
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      fs/xfs/xfs_ioctl32.o
  CC      fs/binfmt_elf.o
  CC      net/netfilter/xt_recent.o
  CC      net/netfilter/xt_sctp.o
  CC      net/netfilter/xt_socket.o
  CC      net/netfilter/xt_state.o
  CC      fs/xfs/xfs_pnfs.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  CC      fs/compat_binfmt_elf.o
  CC      fs/posix_acl.o
  CC      fs/mbcache.o
  CC      fs/coredump.o
  CC      net/netfilter/xt_statistic.o
  CC      fs/drop_caches.o
  CC      net/netfilter/xt_string.o
  CC      fs/fhandle.o
  CC      net/netfilter/xt_tcpmss.o
  CC      fs/dcookies.o
  CC      net/netfilter/xt_time.o
  CC      net/netfilter/xt_u32.o
  AR      net/netfilter/built-in.a
  AR      net/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
Makefile:1681: recipe for target 'drivers' failed
make: *** [drivers] Error 2
make: *** Waiting for unfinished jobs....
  AR      fs/btrfs/built-in.a
  AR      fs/xfs/built-in.a
  AR      fs/built-in.a


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=1771d70de00000


Tested on:

commit:         63623fd4 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux.git
dashboard link: https://syzkaller.appspot.com/bug?extid=cd66e43794b178bb5cd6
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1161a0b1e00000

