Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A16C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB7C5206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506438AbgDOTRd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:17:33 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:53635 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505393AbgDOTRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:17:07 -0400
Received: by mail-io1-f72.google.com with SMTP id i26so3460974ioe.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=27lRhDxfW8W6M6dejA8p85FKRHl8wDHSL+ZRM2YuAKI=;
        b=maiCaqsPrApfAFD5iAnHJVcqND8vur39AEFm8hwyvG4fJ6mSyVIYLSjJeylIkrOZMa
         c9bVYPeKQ8T3biaw6jnMtNlZUrFs7Zhe+XQ6SBDyaH30kVn5WgRGNhHQ5FBsBmpu6kIG
         Goe2uTbuYMWzFW+8gQdt1xp+OKEG/aq3HtYMcUbkO6k6QoRCVEsTR6fpzTBGVJtR/3/0
         Tunm2lwGd8/1a4Z9iqTv5zvo4NGPnYpJpcjl2c8wUJ8yh4CS71MnaRnx4e2PnurF0TWZ
         bFBCHeY5mF+byIiEB44b0e9/y43l/LKn/0bpTw7pHqRSwo3hxf/56xIVwhPVvnavdv+3
         Gvpg==
X-Gm-Message-State: AGi0PuZKnXScrolwG1Pje7QCpwoKmO2C531dzQHozmcsvBhEpWIymq8L
        hZ0lrCDBazF54pCON+RALP8TNW47W3oANxemWWPCsm9LtbwN
X-Google-Smtp-Source: APiQypIE3/xNO+C52jEsLPsCCOubjMnkeNUQ4KPHWpT8bK0xUplJ3Y8aR/z00Z61yWe4KBL3RoiajOadr6SseZZ0AKQqP17eYwOt
MIME-Version: 1.0
X-Received: by 2002:a92:48cb:: with SMTP id j72mr6999387ilg.162.1586978223546;
 Wed, 15 Apr 2020 12:17:03 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:17:03 -0700
In-Reply-To: <CAM_iQpXw8UfR9=fAspibACedOpb6SCJiL5c3=07Rmr=FpxZg-w@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047e9ca05a359292b@google.com>
Subject: Re: BUG: MAX_LOCKDEP_CHAINS too low!
From:   syzbot <syzbot+aaa6fa4949cc5d9b7b25@syzkaller.appspotmail.com>
To:     dvyukov@google.com, linux-kernel@vger.kernel.org, mingo@kernel.org,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, will.deacon@arm.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot tried to test the proposed patch but build/boot failed:

o-wq.o
  CC      drivers/hid/hid-ezkey.o
  CC      drivers/hid/hid-google-hammer.o
  CC      net/mac80211/rc80211_minstrel_ht.o
  CC      net/openvswitch/vport-internal_dev.o
  CC      drivers/infiniband/ulp/opa_vnic/opa_vnic_ethtool.o
  CC      net/mac80211/rc80211_minstrel_debugfs.o
  CC      net/mac80211/rc80211_minstrel_ht_debugfs.o
  CC      drivers/infiniband/ulp/opa_vnic/opa_vnic_vema.o
  CC      drivers/infiniband/ulp/opa_vnic/opa_vnic_vema_iface.o
  CC      net/mpls/mpls_gso.o
  CC      net/mpls/af_mpls.o
  AR      drivers/staging/media/built-in.a
  CC      drivers/infiniband/core/user_mad.o
  CC      drivers/infiniband/core/uverbs_main.o
  CC      drivers/staging/android/ion/ion.o
  CC      net/batman-adv/bat_v_ogm.o
  CC      fs/locks.o
  CC      net/vmw_vsock/vsock_loopback.o
  CC      net/vmw_vsock/virtio_transport.o
  CC      net/vmw_vsock/virtio_transport_common.o
  CC      net/nfc/digital_core.o
  CC      drivers/hid/hid-gyration.o
  CC      drivers/staging/android/ion/ion_heap.o
  CC      drivers/staging/android/ion/ion_page_pool.o
  CC      drivers/staging/android/ion/ion_system_heap.o
  AR      drivers/vhost/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_dpio_phy.o
  CC      drivers/gpu/drm/i915/display/intel_dpll_mgr.o
  CC      net/mpls/mpls_iptunnel.o
  CC      drivers/hid/hid-holtek-kbd.o
  CC      drivers/hid/hid-holtek-mouse.o
  CC      fs/compat.o
  CC      net/netfilter/xt_nat.o
  CC      net/openvswitch/vport-netdev.o
  CC      drivers/md/dm-log.o
  CC      net/nfc/digital_technology.o
  CC      net/nfc/digital_dep.o
  CC      net/netfilter/xt_AUDIT.o
  CC      net/netfilter/xt_CHECKSUM.o
  CC      net/netfilter/xt_CLASSIFY.o
  CC      drivers/hid/hid-holtekff.o
  CC      drivers/hid/hid-ite.o
  CC      net/openvswitch/conntrack.o
  CC      net/openvswitch/vport-vxlan.o
  CC      drivers/gpu/drm/i915/display/intel_dsb.o
  CC      net/wireless/pmsr.o
  CC      net/openvswitch/vport-geneve.o
  CC      drivers/staging/android/ion/ion_cma_heap.o
  CC      drivers/gpu/drm/i915/display/intel_fbc.o
  CC      net/wireless/debugfs.o
  CC      drivers/hid/hid-keytouch.o
  CC      fs/binfmt_misc.o
  CC      drivers/hid/hid-kensington.o
  CC      fs/binfmt_script.o
  CC      fs/binfmt_elf.o
  CC      fs/compat_binfmt_elf.o
  CC      drivers/gpu/drm/i915/display/intel_fifo_underrun.o
  CC      fs/posix_acl.o
  CC      fs/mbcache.o
  CC      drivers/hid/hid-kye.o
  CC      fs/coredump.o
  CC      drivers/md/dm-region-hash.o
  AR      drivers/infiniband/sw/rdmavt/built-in.a
  CC      fs/drop_caches.o
  CC      drivers/gpu/drm/i915/display/intel_frontbuffer.o
  AR      drivers/infiniband/sw/built-in.a
  CC      fs/fhandle.o
  CC      drivers/hid/hid-lcpower.o
  CC      net/wireless/wext-compat.o
  AR      drivers/infiniband/ulp/opa_vnic/built-in.a
  CC      fs/dcookies.o
  CC      drivers/platform/x86/eeepc-laptop.o
  AR      drivers/infiniband/ulp/built-in.a
  CC      drivers/staging/android/ashmem.o
  CC      drivers/platform/x86/intel_menlow.o
  CC      drivers/gpu/drm/i915/display/intel_global_state.o
  CC      net/netfilter/xt_CONNSECMARK.o
  CC      net/netfilter/xt_CT.o
  CC      drivers/platform/x86/i2c-multi-instantiate.o
  AR      drivers/staging/android/ion/built-in.a
  CC      drivers/mailbox/mailbox.o
  CC      net/batman-adv/bitarray.o
  CC      net/batman-adv/bridge_loop_avoidance.o
  CC      drivers/md/dm-zero.o
  CC      drivers/mailbox/pcc.o
  CC      net/netfilter/xt_DSCP.o
  CC      net/netfilter/xt_HL.o
  CC      net/openvswitch/vport-gre.o
  CC      drivers/infiniband/core/uverbs_cmd.o
  CC      drivers/gpu/drm/i915/display/intel_hdcp.o
  CC      net/wireless/wext-sme.o
  CC      drivers/hid/hid-lg.o
  GEN     net/wireless/shipped-certs.c
  AR      drivers/perf/built-in.a
  CC      drivers/extcon/devres.o
  CC      drivers/extcon/extcon.o
  AR      net/nfc/built-in.a
  CC      drivers/platform/chrome/chromeos_laptop.o
  CC      drivers/platform/chrome/chromeos_pstore.o
  CC      drivers/platform/chrome/chromeos_tbmc.o
  CC      drivers/platform/x86/pmc_atom.o
  CC      drivers/md/dm-raid.o
  CC      drivers/gpu/drm/i915/display/intel_hotplug.o
  CC      drivers/infiniband/core/uverbs_marshall.o
  CC      drivers/gpu/drm/i915/display/intel_lpe_audio.o
  CC      drivers/infiniband/core/rdma_core.o
  CC      drivers/infiniband/core/uverbs_std_types.o
  CC      drivers/infiniband/core/uverbs_ioctl.o
  CC      drivers/md/dm-thin.o
  CC      drivers/md/dm-thin-metadata.o
  CC      drivers/md/dm-verity-fec.o
  CC      net/nsh/nsh.o
  CC      net/wireless/wext-core.o
  CC      drivers/ras/ras.o
  CC      drivers/ras/debugfs.o
  CC      net/batman-adv/distributed-arp-table.o
  AR      drivers/hwtracing/intel_th/built-in.a
  CC      drivers/platform/chrome/cros_ec.o
  CC      drivers/infiniband/core/uverbs_std_types_cq.o
  CC      drivers/hid/hid-lgff.o
  CC      net/netfilter/xt_HMARK.o
  CC      drivers/gpu/drm/i915/display/intel_overlay.o
  CC      net/netfilter/xt_LED.o
  CC      net/netfilter/xt_LOG.o
  AR      drivers/staging/android/built-in.a
  AR      drivers/staging/built-in.a
  CC      net/netfilter/xt_NETMAP.o
  AR      drivers/mailbox/built-in.a
  CC      net/netfilter/xt_NFLOG.o
  CC      net/hsr/hsr_main.o
  CC      drivers/infiniband/core/uverbs_std_types_flow_action.o
  CC      drivers/android/binder_alloc.o
  CC      drivers/android/binder.o
  CC      net/netfilter/xt_NFQUEUE.o
  CC      net/netfilter/xt_RATEEST.o
  CC      drivers/counter/counter.o
  CC      net/netfilter/xt_REDIRECT.o
  CC      net/switchdev/switchdev.o
  AR      net/vmw_vsock/built-in.a
  CC      net/l3mdev/l3mdev.o
  CC      net/netfilter/xt_MASQUERADE.o
  CC      net/netfilter/xt_SECMARK.o
  CC      drivers/platform/chrome/cros_ec_proto.o
  CC      net/wireless/wext-proc.o
  CC      drivers/infiniband/core/uverbs_std_types_dm.o
  AR      drivers/platform/x86/built-in.a
  CC      net/wireless/shipped-certs.o
  CC      drivers/gpu/drm/i915/display/intel_psr.o
  CC      drivers/gpu/drm/i915/display/intel_quirks.o
  AR      drivers/net/built-in.a
  CC      drivers/infiniband/core/uverbs_std_types_mr.o
  CC      drivers/infiniband/core/uverbs_std_types_counters.o
  CC      drivers/infiniband/core/uverbs_uapi.o
  CC      drivers/hid/hid-lg2ff.o
  CC      drivers/hid/hid-lg3ff.o
  CC      net/netfilter/xt_TPROXY.o
  CC      net/netfilter/xt_TCPMSS.o
  CC      net/hsr/hsr_framereg.o
  CC      net/batman-adv/fragmentation.o
  CC      net/batman-adv/gateway_client.o
  CC      drivers/md/dm-verity-target.o
  AR      drivers/extcon/built-in.a
  CC      net/hsr/hsr_device.o
  CC      drivers/infiniband/core/uverbs_std_types_device.o
  AR      net/nsh/built-in.a
  CC      net/hsr/hsr_slave.o
  CC      net/hsr/hsr_netlink.o
  AR      net/openvswitch/built-in.a
  CC      net/hsr/hsr_forward.o
  CC      net/hsr/hsr_debugfs.o
  CC      drivers/infiniband/core/uverbs_std_types_async_fd.o
  CC      net/batman-adv/gateway_common.o
  CC      drivers/infiniband/core/umem.o
  AR      net/mpls/built-in.a
  CC      drivers/infiniband/core/umem_odp.o
  CC      drivers/gpu/drm/i915/display/intel_sprite.o
  CC      drivers/infiniband/core/ucma.o
  CC      net/netfilter/xt_TCPOPTSTRIP.o
  CC      drivers/md/dm-cache-target.o
  CC      drivers/gpu/drm/i915/display/intel_tc.o
  CC      drivers/gpu/drm/i915/display/intel_vga.o
  CC      net/batman-adv/hard-interface.o
  CC      net/netfilter/xt_TEE.o
  CC      drivers/gpu/drm/i915/display/intel_acpi.o
  CC      drivers/hid/hid-lg4ff.o
  CC      net/batman-adv/main.o
  CC      net/netfilter/xt_TRACE.o
  CC      net/batman-adv/hash.o
  CC      net/batman-adv/multicast.o
  CC      net/ncsi/ncsi-cmd.o
  CC      drivers/hid/hid-lg-g15.o
  CC      net/ncsi/ncsi-rsp.o
  CC      drivers/hid/hid-logitech-dj.o
  CC      net/netfilter/xt_IDLETIMER.o
  CC      drivers/hid/hid-logitech-hidpp.o
  AR      drivers/ras/built-in.a
  AR      net/l3mdev/built-in.a
  CC      net/xdp/xsk.o
  CC      net/batman-adv/netlink.o
  CC      drivers/platform/chrome/cros_ec_trace.o
  CC      net/xdp/xdp_umem.o
  CC      net/xdp/xsk_queue.o
  AR      drivers/counter/built-in.a
  CC      net/xdp/xsk_diag.o
  CC      drivers/gpu/drm/i915/display/intel_opregion.o
  CC      drivers/hid/hid-magicmouse.o
  CC      drivers/platform/chrome/cros_kbd_led_backlight.o
  CC      drivers/platform/chrome/cros_ec_chardev.o
  CC      drivers/platform/chrome/cros_ec_lightbar.o
  CC      drivers/platform/chrome/cros_ec_debugfs.o
  CC      drivers/gpu/drm/i915/display/intel_fbdev.o
  AR      net/switchdev/built-in.a
  CC      net/batman-adv/network-coding.o
  CC      net/batman-adv/originator.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7017.o
  CC      net/socket.o
  CC      net/ncsi/ncsi-aen.o
  CC      drivers/gpu/drm/i915/display/dvo_ch7xxx.o
  CC      drivers/gpu/drm/i915/display/dvo_ivch.o
  CC      drivers/gpu/drm/i915/display/dvo_ns2501.o
  CC      drivers/gpu/drm/i915/display/dvo_sil164.o
  CC      net/ncsi/ncsi-manage.o
  CC      drivers/gpu/drm/i915/display/dvo_tfp410.o
  CC      net/netfilter/xt_addrtype.o
  CC      drivers/hid/hid-microsoft.o
  CC      drivers/hid/hid-monterey.o
  CC      net/netfilter/xt_bpf.o
  AR      net/hsr/built-in.a
  CC      drivers/gpu/drm/i915/display/icl_dsi.o
  CC      net/netfilter/xt_cluster.o
  CC      net/compat.o
  CC      net/sysctl_net.o
  CC      drivers/platform/chrome/cros_ec_sensorhub.o
  CC      drivers/platform/chrome/cros_ec_sysfs.o
  CC      drivers/md/dm-cache-metadata.o
  CC      net/batman-adv/routing.o
  AR      net/mac80211/built-in.a
  CC      net/netfilter/xt_comment.o
  CC      drivers/md/dm-cache-policy.o
  CC      net/ncsi/ncsi-netlink.o
  CC      drivers/md/dm-cache-background-tracker.o
  CC      drivers/hid/hid-multitouch.o
  CC      drivers/hid/hid-ntrig.o
  CC      drivers/hid/hid-ortek.o
  CC      net/batman-adv/send.o
  CC      net/netfilter/xt_connbytes.o
  CC      drivers/hid/hid-prodikeys.o
  CC      net/netfilter/xt_connlabel.o
  CC      net/batman-adv/soft-interface.o
  CC      drivers/md/dm-cache-policy-smq.o
  CC      drivers/gpu/drm/i915/display/intel_crt.o
  CC      net/batman-adv/sysfs.o
  CC      drivers/hid/hid-pl.o
  CC      drivers/gpu/drm/i915/display/intel_ddi.o
  CC      drivers/md/dm-clone-target.o
  CC      net/batman-adv/tp_meter.o
  CC      drivers/gpu/drm/i915/display/intel_dp.o
  CC      drivers/gpu/drm/i915/display/intel_dp_aux_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dp_link_training.o
  CC      drivers/gpu/drm/i915/display/intel_dp_mst.o
  CC      net/batman-adv/translation-table.o
  CC      net/batman-adv/tvlv.o
  CC      net/netfilter/xt_conntrack.o
  CC      net/netfilter/xt_connlimit.o
  AR      drivers/platform/chrome/built-in.a
  CC      net/netfilter/xt_cpu.o
  CC      drivers/hid/hid-petalynx.o
  AR      drivers/platform/built-in.a
  CC      drivers/gpu/drm/i915/display/intel_dsi.o
  CC      drivers/hid/hid-picolcd_core.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_vbt.o
  CC      drivers/gpu/drm/i915/display/intel_dsi_dcs_backlight.o
  CC      drivers/gpu/drm/i915/display/intel_dvo.o
  CC      net/netfilter/xt_dccp.o
  CC      drivers/md/dm-clone-metadata.o
  CC      drivers/md/dm-integrity.o
  CC      net/netfilter/xt_devgroup.o
  CC      drivers/md/dm-zoned-metadata.o
  CC      drivers/md/dm-zoned-target.o
  CC      drivers/md/dm-zoned-reclaim.o
  CC      drivers/hid/hid-picolcd_debugfs.o
  CC      net/netfilter/xt_dscp.o
  CC      drivers/md/dm-writecache.o
  CC      net/netfilter/xt_ecn.o
  CC      net/netfilter/xt_esp.o
  CC      net/netfilter/xt_hashlimit.o
  CC      net/netfilter/xt_helper.o
  AR      drivers/infiniband/core/built-in.a
  CC      drivers/hid/hid-plantronics.o
  AR      drivers/infiniband/built-in.a
  CC      drivers/hid/hid-primax.o
  CC      drivers/gpu/drm/i915/display/intel_gmbus.o
  CC      net/netfilter/xt_hl.o
  CC      drivers/gpu/drm/i915/display/intel_hdmi.o
  CC      drivers/hid/hid-roccat.o
  CC      drivers/hid/hid-roccat-common.o
  CC      drivers/gpu/drm/i915/display/intel_lspcon.o
  CC      net/netfilter/xt_ipcomp.o
  CC      drivers/hid/hid-roccat-arvo.o
  CC      net/netfilter/xt_iprange.o
  CC      drivers/hid/hid-roccat-isku.o
  CC      drivers/hid/hid-roccat-kone.o
  CC      net/netfilter/xt_ipvs.o
  CC      drivers/hid/hid-roccat-koneplus.o
  CC      net/netfilter/xt_l2tp.o
  CC      net/netfilter/xt_length.o
  CC      drivers/gpu/drm/i915/display/intel_lvds.o
  CC      net/netfilter/xt_limit.o
  CC      drivers/hid/hid-roccat-konepure.o
  CC      drivers/hid/hid-roccat-kovaplus.o
  CC      net/netfilter/xt_mac.o
  CC      drivers/hid/hid-roccat-lua.o
  CC      drivers/gpu/drm/i915/display/intel_panel.o
  CC      net/netfilter/xt_multiport.o
  CC      net/netfilter/xt_nfacct.o
  CC      drivers/gpu/drm/i915/display/intel_sdvo.o
  CC      drivers/gpu/drm/i915/display/intel_tv.o
  CC      net/netfilter/xt_osf.o
  CC      drivers/hid/hid-roccat-pyra.o
  AR      net/xdp/built-in.a
  CC      net/netfilter/xt_owner.o
  CC      drivers/gpu/drm/i915/display/intel_vdsc.o
  CC      net/netfilter/xt_cgroup.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi.o
  CC      drivers/gpu/drm/i915/display/vlv_dsi_pll.o
  CC      net/netfilter/xt_physdev.o
  CC      net/netfilter/xt_pkttype.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_hsw.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bdw.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_chv.o
  CC      net/netfilter/xt_policy.o
  CC      net/netfilter/xt_rateest.o
  CC      net/netfilter/xt_quota.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt2.o
  CC      drivers/hid/hid-roccat-ryos.o
  CC      drivers/hid/hid-roccat-savu.o
  CC      drivers/hid/hid-rmi.o
  CC      net/netfilter/xt_realm.o
  CC      drivers/hid/hid-saitek.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt3.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_sklgt4.o
  CC      net/netfilter/xt_recent.o
  CC      drivers/hid/hid-samsung.o
  CC      drivers/hid/hid-sjoy.o
  CC      net/netfilter/xt_sctp.o
  CC      net/netfilter/xt_socket.o
  CC      net/netfilter/xt_state.o
  AR      net/ncsi/built-in.a
  CC      drivers/hid/hid-sony.o
  CC      net/netfilter/xt_string.o
  CC      drivers/hid/hid-speedlink.o
  CC      net/netfilter/xt_statistic.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_bxt.o
  CC      drivers/hid/hid-sunplus.o
  CC      net/netfilter/xt_tcpmss.o
  CC      drivers/hid/hid-gaff.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt2.o
  CC      net/netfilter/xt_time.o
  CC      drivers/hid/hid-tmff.o
  CC      net/netfilter/xt_u32.o
  CC      drivers/hid/hid-tivo.o
  CC      drivers/hid/hid-topseed.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_kblgt3.o
  CC      drivers/hid/hid-twinhan.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_glk.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt2.o
  AR      fs/built-in.a
  CC      drivers/gpu/drm/i915/oa/i915_oa_cflgt3.o
  CC      drivers/hid/hid-uclogic-rdesc.o
  CC      drivers/hid/hid-uclogic-core.o
  CC      drivers/hid/hid-uclogic-params.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_cnl.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_icl.o
  CC      drivers/hid/hid-zpff.o
  CC      drivers/hid/hid-led.o
  CC      drivers/hid/hid-zydacron.o
  CC      drivers/hid/wacom_sys.o
  CC      drivers/hid/wacom_wac.o
  CC      drivers/gpu/drm/i915/oa/i915_oa_tgl.o
  CC      drivers/hid/hid-waltop.o
  CC      drivers/gpu/drm/i915/i915_perf.o
  CC      drivers/gpu/drm/i915/i915_gpu_error.o
  CC      drivers/gpu/drm/i915/i915_vgpu.o
  CC      drivers/hid/hid-wiimote-core.o
  CC      drivers/hid/hid-wiimote-modules.o
  CC      drivers/hid/hid-wiimote-debug.o
  AR      net/netfilter/built-in.a
  AR      net/batman-adv/built-in.a
  AR      drivers/android/built-in.a
  AR      drivers/md/built-in.a
  AR      net/wireless/built-in.a
  AR      net/built-in.a
  AR      drivers/hid/built-in.a
  AR      drivers/gpu/drm/i915/built-in.a
  AR      drivers/gpu/drm/built-in.a
  AR      drivers/gpu/built-in.a
  AR      drivers/built-in.a
  GEN     .version
  CHK     include/generated/compile.h
  LD      vmlinux.o
  MODPOST vmlinux.o
  MODINFO modules.builtin.modinfo
  GEN     modules.builtin
BTF: .tmp_vmlinux.btf: pahole version v1.9 is too old, need at least v1.13
Failed to generate BTF for vmlinux
Try to disable CONFIG_DEBUG_INFO_BTF
Makefile:1086: recipe for target 'vmlinux' failed
make: *** [vmlinux] Error 1


Error text is too large and was truncated, full error text is at:
https://syzkaller.appspot.com/x/error.txt?x=1469749be00000


Tested on:

commit:         efa133f3 net: rewrite netif_addr_lock_nested() with dev->l..
git tree:       https://github.com/congwang/linux.git lockdep
dashboard link: https://syzkaller.appspot.com/bug?extid=aaa6fa4949cc5d9b7b25
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

