Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938F1C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:31:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A65820857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 20:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgDTUbT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 16:31:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTUbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 16:31:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A06C3206E9;
        Mon, 20 Apr 2020 20:31:17 +0000 (UTC)
Date:   Mon, 20 Apr 2020 16:31:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Spin lock being taken in trace_intel_pipe_enable/disable() trace
 events
Message-ID: <20200420163116.4aa5eb2d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running tests on v5.4-rt, I triggered the following:

[  367.909200] 005: ------------[ cut here ]------------
[  367.909203] 005: WARNING: CPU: 5 PID: 1200 at drivers/gpu/drm/drm_vblank.c:637 drm_calc_vbltimestamp_from_scanoutpos+0x2e9/0x320 [drm]
[  367.909231] 005: Modules linked in: iptable_mangle xt_CHECKSUM tun ebtable_filter ebtables ipt_REJECT nf_reject_ipv4 iptable_filter ip6t_REJECT nf_reject_ipv6 xt_state xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6table_filter ip6_tables snd_hda_codec_hdmi intel_rapl_msr snd_hda_codec_realtek snd_hda_codec_generic hp_wmi intel_rapl_common ledtrig_audio sparse_keymap iTCO_wdt mei_wdt rfkill iTCO_vendor_support wmi_bmof snd_hda_intel snd_intel_nhlt snd_hda_codec x86_pkg_temp_thermal intel_powerclamp snd_hda_core coretemp snd_hwdep joydev i915 kvm_intel snd_seq kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel snd_seq_device snd_pcm intel_cstate intel_uncore snd_timer intel_gtt i2c_algo_bit snd intel_rapl_perf soundcore drm_kms_helper mei_me e1000e sr_mod mei syscopyarea sysfillrect serio_raw sysimgblt cdrom fb_sys_fops wmi drm lpc_ich i2c_i801 tpm_infineon video pcspkr ip_tables
[  367.909265] 005: CPU: 5 PID: 1200 Comm: gnome-shell Not tainted 5.4.28-test-rt19+ #235
[  367.909267] 005: Hardware name: Hewlett-Packard HP Compaq Pro 6300 SFF/339A, BIOS K01 v03.03 07/14/2016
[  367.909268] 005: RIP: 0010:drm_calc_vbltimestamp_from_scanoutpos+0x2e9/0x320 [drm]
[  367.909282] 005: Code: 43 20 8b 80 70 01 00 00 23 43 50 a8 10 75 1b 48 8b 83 28 03 00 00 48 85 c0 0f 84 5e fd ff ff 48 83 78 28 00 0f 84 53 fd ff ff <0f> 0b e9 4f fd ff ff 48 c7 c7 c8 40 41 c0 e8 84 ea ff ff e9 3e fd
[  367.909284] 005: RSP: 0018:ffff9f94c043f948 EFLAGS: 00010002
[  367.909284] 005: RAX: 000000000000003b RBX: ffff8f6418fa0000 RCX: 0000000000000000
[  367.909285] 005: RDX: 0000000000000001 RSI: ffffffffc0414100 RDI: 0000000000000001
[  367.909286] 005: RBP: ffff9f94c043f9a8 R08: 0000000000000000 R09: ffffffffc03e7fa0
[  367.909286] 005: R10: ffff8f64072d3e9c R11: ffffffffc082e6a0 R12: ffff8f6419ab4100
[  367.909287] 005: R13: 0000000000000001 R14: ffff8f6419ab41d8 R15: ffff9f94c043f9bc
[  367.909289] 005: FS:  00007f68e15bed00(0000) GS:ffff8f641a940000(0000) knlGS:0000000000000000
[  367.909290] 005: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  367.909290] 005: CR2: 00007f68a6c57004 CR3: 000000011889e001 CR4: 00000000001606e0
[  367.909292] 005: Call Trace:
[  367.909296] 005:  drm_get_last_vbltimestamp+0x4d/0x80 [drm]
[  367.909310] 005:  drm_update_vblank_count+0x85/0x250 [drm]
[  367.909323] 005:  drm_crtc_accurate_vblank_count+0x46/0xa0 [drm]
[  367.909336] 005:  intel_crtc_get_vblank_counter+0x3b/0x40 [i915]
[  367.909384] 005:  trace_event_raw_event_intel_pipe_disable+0x87/0x110 [i915]
[  367.909417] 005:  intel_disable_pipe+0x186/0x1d0 [i915]
[  367.909450] 005:  ironlake_crtc_disable+0x88/0x700 [i915]
[  367.909481] 005:  ? synchronize_irq+0x35/0xa0
[  367.909484] 005:  intel_atomic_commit_tail+0x258/0x1540 [i915]
[  367.909516] 005:  ? mutex_unlock+0x5/0x30
[  367.909519] 005:  ? flush_workqueue+0x190/0x440
[  367.909523] 005:  intel_atomic_commit+0x23f/0x2d0 [i915]
[  367.909554] 005:  drm_atomic_connector_commit_dpms+0xdb/0x100 [drm]
[  367.909567] 005:  drm_mode_obj_set_property_ioctl+0x18a/0x2b0 [drm]
[  367.909581] 005:  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
[  367.909594] 005:  drm_ioctl_kernel+0xac/0xf0 [drm]
[  367.909605] 005:  drm_ioctl+0x1f8/0x3b0 [drm]
[  367.909616] 005:  ? drm_mode_obj_find_prop_id+0x40/0x40 [drm]
[  367.909629] 005:  ? ring_buffer_unlock_commit+0x1e/0x120
[  367.909631] 005:  ? trace_buffer_unlock_commit_regs+0x4c/0x220
[  367.909633] 005:  ? ftrace_syscall_enter+0x1d0/0x2d0
[  367.909635] 005:  do_vfs_ioctl+0xa4/0x630
[  367.909639] 005:  ksys_ioctl+0x60/0x90
[  367.909641] 005:  __x64_sys_ioctl+0x16/0x20
[  367.909642] 005:  do_syscall_64+0x55/0x190
[  367.909645] 005:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  367.909647] 005: RIP: 0033:0x7f68e510a09b


And when looking into it, not only is there some race issue, I also found
that the trace events for trace_intel_pipe_disable() (and enable) take
spin_locks, which should *never* happen inside a trace event callback
(TP_fast_assign()).

The following has:

 trace_intel_pipe_disable()

	    TP_fast_assign(
			   struct drm_i915_private *dev_priv = to_i915(crtc->base.dev);
			   struct intel_crtc *it__;
			   for_each_intel_crtc(&dev_priv->drm, it__) {
				   __entry->frame[it__->pipe] = intel_crtc_get_vblank_counter(it__);
				   __entry->scanline[it__->pipe] = intel_get_crtc_scanline(it__);
			   }
			   __entry->pipe = crtc->pipe;
			   ),


Where we have:

  intel_crtc_get_vblank_counter() calls
     drm_crtc_accurate_vblank_count() which has:

spin_lock_irqsave(&dev->vblank_time_lock, flags);


Note that the trace_event handler (code in TP_fast_assign()) is called with
preemption disabled, and that on PREEMPT_RT, spin_lock_irqsave() turns into
a mutex.

But even without PREEMPT_RT(), its still very dangerous to have a spin lock
taken within a trace event, because it causes spin locks to be taken in
paths seldom tested (and often missed by lockdep). And these are a common
source of deadlocks.

Please, update this trace event (or any others that you know of), to
prevent spin locks (or any locks for that matter) from being taken from the
TP_fast_assign() code.

-- Steve
