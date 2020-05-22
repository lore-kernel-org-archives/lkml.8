Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E52020723
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sPb7l+mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgEVQbG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730031AbgEVQbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:31:04 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3965C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:31:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id z5so13744898ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=sp0LB8/JtTFX40nAZorxLiFPeoTP/27fdaTacIpuy3c=;
        b=sPb7l+muIEojTJn74VgujGj6lag+21YJIUYZXLEmKjjwSpb5JhEsZO3MICbmhCKe5f
         UI3AaXSazf5Uoch82+JeEuH1ZsHJEAQVjAI1tAn8Nij6PYewg/IEjycv2DYATpCWCvuh
         WuTRJjWs8r+RRH52Hd/4O4qq13v0hxWRHPilgPfbjG6Vt8FnGz3/zVCw+VlzzLnOsAV7
         4F1FpdpRXKQg/JecRzc5onM/r4xh13P+FUaeX0z8NV/ZDXZBhCEOSgZ3tgoi9XlcFzIF
         qnInPBVqETZW8LzPcaOfqqj0RcJMIzifljSXA8iGn9/hzVIAPDDU9FsNxZwm4as1AUYV
         mg8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=sp0LB8/JtTFX40nAZorxLiFPeoTP/27fdaTacIpuy3c=;
        b=jzROp131+TXRqcFt2V+UNCAcEk8zF3dUNEEwShGV09ZFLM2HXVPXT2V1UrGo+giFDG
         fD4rEQYplLuYzgYpeaFTI35xD+8JM446T7OhoXqroVEm27kpTaYRmtFdeSVT0M1tXCeR
         u4G5FJHiEStrvGIQics/WlCVhFMYjF921n6m5G57CK3awI91Th4AjlHpKsZACWNInfHv
         C6gOMoluUaXsEC8s9Fz0BwOcbEV+3JpaZsG2X4+/0JlQ1VMr8tZeFAunW0NhRgdpJvTB
         lgZnhi0AqbvPO6onfnUZRjHtI9l6ikZBRy9rvV0WMRs0oCC8A/NN2OZkdC6sTYhjUGf4
         7x2A==
X-Gm-Message-State: AOAM533vtw+B0IR3Ka747CMyaQqV3dOANubVpegc9G6uDE6vI3SNRNTB
        KeVXyKRfYNJF9oAFVIzDPsWBZw9quW4=
X-Google-Smtp-Source: ABdhPJw/NZH8tg2AhQ79wtQCyl2h0E3/EE5iKPCTs5vAMEL9Ms6L9QwhopzPyJjIUl22RI0ljrkEcA==
X-Received: by 2002:a17:906:cecb:: with SMTP id si11mr8743136ejb.122.1590165058198;
        Fri, 22 May 2020 09:30:58 -0700 (PDT)
Received: from t2b3 ([5.56.225.192])
        by smtp.gmail.com with ESMTPSA id 96sm1779246edq.56.2020.05.22.09.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 09:30:57 -0700 (PDT)
Date:   Fri, 22 May 2020 18:30:52 +0200
From:   "Tobias S. Predel" <tobias.predel@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, bigeasy@linutronix.de, namit@vmware.com
Subject: Regression in linux-next 20200521 / Kernel Ring Buffer full of
 warnings
Message-ID: <20200522163052.GA8791@t2b3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

since two days I experience some kind of loop/pause on my user interface
with linux-next. That didn't happen before.

I am using linux-next 20200521 (ge8f3274774b4) and I get messages like=20
the following ones while user interface is almost not usable.
(Touchpad gestures aren't shown. Video gets stuck and fast-forwards after a=
 while)

The whole things starts after a while in graphical user session=20
(Desktop environement Sway), not immediately after startup.

I would be glad if someone could look into this or if this is reproducable
also on other computers apart from mine (HP ProBook 430 G5).

Thanks in advance!

Regards,
Tobias

$ dmesg

[ 1941.377075]  irq_exit+0xab/0x120
[ 1941.377077]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377080]  apic_timer_interrupt+0xf/0x20
[ 1941.377080]  </IRQ>
[ 1941.377082] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377084] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377085] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377086] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377087] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377110] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377189]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377193]  </IRQ>
[ 1941.377194] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377196] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377197] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377198] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377199] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377223] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377296]  __do_softirq+0x10f/0x366
[ 1941.377299]  ? sched_clock_cpu+0xe/0xd0
[ 1941.377302]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377305]  apic_timer_interrupt+0xf/0x20
[ 1941.377306]  </IRQ>
[ 1941.377307] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377309] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377311] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377312] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377313] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377335] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377415]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.377418]  </IRQ>
[ 1941.377419] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377421] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377422] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377423] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377424] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377445] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377518]  ? sched_clock_cpu+0xe/0xd0
[ 1941.377522]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377525]  apic_timer_interrupt+0xf/0x20
[ 1941.377526]  </IRQ>
[ 1941.377527] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377529] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377531] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377531] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377532] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377554] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377632]  irq_exit+0xab/0x120
[ 1941.377633]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377636]  apic_timer_interrupt+0xf/0x20
[ 1941.377637]  </IRQ>
[ 1941.377639] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377641] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377642] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377643] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377643] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377665] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377739]  __do_softirq+0x10f/0x366
[ 1941.377741]  ? sched_clock_cpu+0xe/0xd0
[ 1941.377745]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377748]  apic_timer_interrupt+0xf/0x20
[ 1941.377749]  </IRQ>
[ 1941.377750] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377752] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377754] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377755] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377755] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377778] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377854]  ? sched_clock_cpu+0xe/0xd0
[ 1941.377858]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377861]  </IRQ>
[ 1941.377863] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377865] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377866] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377867] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377868] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.377891] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.377969]  irq_exit+0xab/0x120
[ 1941.377970]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.377974]  </IRQ>
[ 1941.377976] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.377978] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.377979] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.377980] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.377980] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378003] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378077]  __do_softirq+0x10f/0x366
[ 1941.378079]  ? sched_clock_cpu+0xe/0xd0
[ 1941.378083]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.378087]  </IRQ>
[ 1941.378088] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378090] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378092] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378092] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378093] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378117] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378185]  ? call_function_single_interrupt+0xa/0x20
[ 1941.378192]  ? sched_clock_cpu+0xe/0xd0
[ 1941.378196]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.378199]  apic_timer_interrupt+0xf/0x20
[ 1941.378200]  </IRQ>
[ 1941.378201] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378203] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378204] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378205] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378206] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378230] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378305]  ? sched_clock_cpu+0xe/0xd0
[ 1941.378308]  irq_exit+0xab/0x120
[ 1941.378309]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.378313]  </IRQ>
[ 1941.378314] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378317] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378318] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378319] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378320] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378342] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378415]  __do_softirq+0x10f/0x366
[ 1941.378417]  ? sched_clock_cpu+0xe/0xd0
[ 1941.378421]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.378424]  apic_timer_interrupt+0xf/0x20
[ 1941.378425]  </IRQ>
[ 1941.378426] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378428] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378430] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378431] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378431] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378454] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378535]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.378538]  </IRQ>
[ 1941.378540] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378542] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378543] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378544] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378545] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378567] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378640]  __do_softirq+0x10f/0x366
[ 1941.378644]  irq_exit+0xab/0x120
[ 1941.378646]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.378649]  </IRQ>
[ 1941.378650] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378652] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378653] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378653] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378654] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378675] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378749]  __do_softirq+0x10f/0x366
[ 1941.378753]  irq_exit+0xab/0x120
[ 1941.378754]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.378757]  apic_timer_interrupt+0xf/0x20
[ 1941.378758]  </IRQ>
[ 1941.378759] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.378760] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378762] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.378762] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.378763] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.378807]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.378860]  irq_exit+0xab/0x120
[ 1941.378868] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378872] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.378876]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.378879]  cpuidle_enter+0x29/0x40
[ 1941.378881]  do_idle+0x1d3/0x260
[ 1941.378884]  cpu_startup_entry+0x19/0x20
[ 1941.378893] ------------[ cut here ]------------
[ 1941.378894] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.378895] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.378965]  _nohz_idle_balance+0xe8/0x220
[ 1941.378972]  irq_exit+0xab/0x120
[ 1941.378981] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.378984] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.378988]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.378990]  cpuidle_enter+0x29/0x40
[ 1941.378992]  do_idle+0x1d3/0x260
[ 1941.378995]  cpu_startup_entry+0x19/0x20
[ 1941.379004] ------------[ cut here ]------------
[ 1941.379006] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379006] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379080]  __do_softirq+0x10f/0x366
[ 1941.379085]  irq_exit+0xab/0x120
[ 1941.379093] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.379097] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.379101]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379103]  cpuidle_enter+0x29/0x40
[ 1941.379106]  do_idle+0x1d3/0x260
[ 1941.379109]  cpu_startup_entry+0x19/0x20
[ 1941.379118] ------------[ cut here ]------------
[ 1941.379119] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379120] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379194]  ? sched_clock_cpu+0xe/0xd0
[ 1941.379199]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.379205] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.379208] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.379210]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379214]  do_idle+0x1d3/0x260
[ 1941.379217]  cpu_startup_entry+0x19/0x20
[ 1941.379226] ------------[ cut here ]------------
[ 1941.379228] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379229] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379302]  __do_softirq+0x10f/0x366
[ 1941.379306]  irq_exit+0xab/0x120
[ 1941.379309]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.379315] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.379318] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.379321]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379325]  do_idle+0x1d3/0x260
[ 1941.379327]  cpu_startup_entry+0x19/0x20
[ 1941.379335] ------------[ cut here ]------------
[ 1941.379336] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379337] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379413]  irq_exit+0xab/0x120
[ 1941.379421] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.379425] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.379429]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379431]  cpuidle_enter+0x29/0x40
[ 1941.379434]  do_idle+0x1d3/0x260
[ 1941.379436]  cpu_startup_entry+0x19/0x20
[ 1941.379445] ------------[ cut here ]------------
[ 1941.379446] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379447] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379517]  _nohz_idle_balance+0xe8/0x220
[ 1941.379522]  ? sched_clock_cpu+0xe/0xd0
[ 1941.379527]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.379534] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.379537] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.379541]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379545]  do_idle+0x1d3/0x260
[ 1941.379548]  cpu_startup_entry+0x19/0x20
[ 1941.379557] ------------[ cut here ]------------
[ 1941.379558] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379559] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379631]  _nohz_idle_balance+0xe8/0x220
[ 1941.379633]  __do_softirq+0x10f/0x366
[ 1941.379637]  irq_exit+0xab/0x120
[ 1941.379646] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.379650] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.379654]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379656]  cpuidle_enter+0x29/0x40
[ 1941.379660]  do_idle+0x1d3/0x260
[ 1941.379662]  cpu_startup_entry+0x19/0x20
[ 1941.379671] ------------[ cut here ]------------
[ 1941.379673] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379673] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379750]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.379757] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.379760] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.379763]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379765]  cpuidle_enter+0x29/0x40
[ 1941.379767]  do_idle+0x1d3/0x260
[ 1941.379769]  cpu_startup_entry+0x19/0x20
[ 1941.379778] ------------[ cut here ]------------
[ 1941.379780] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379781] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379852]  __do_softirq+0x10f/0x366
[ 1941.379857]  irq_exit+0xab/0x120
[ 1941.379859]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.379867] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.379870] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.379873]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379877]  do_idle+0x1d3/0x260
[ 1941.379880]  cpu_startup_entry+0x19/0x20
[ 1941.379889] ------------[ cut here ]------------
[ 1941.379890] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.379891] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.379964]  ? sched_clock_cpu+0xe/0xd0
[ 1941.379969]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.379975] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.379978] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.379981]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.379987]  cpu_startup_entry+0x19/0x20
[ 1941.379996] ------------[ cut here ]------------
[ 1941.379998] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380000] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380074]  ? sched_clock_cpu+0xe/0xd0
[ 1941.380079]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.380086] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.380090] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.380093]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380097]  do_idle+0x1d3/0x260
[ 1941.380100]  cpu_startup_entry+0x19/0x20
[ 1941.380109] ------------[ cut here ]------------
[ 1941.380111] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380111] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380183]  _nohz_idle_balance+0xe8/0x220
[ 1941.380188]  ? sched_clock_cpu+0xe/0xd0
[ 1941.380193]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.380200] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.380203] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.380206]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380211]  do_idle+0x1d3/0x260
[ 1941.380214]  cpu_startup_entry+0x19/0x20
[ 1941.380223] ------------[ cut here ]------------
[ 1941.380224] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380225] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380300]  ? sched_clock_cpu+0xe/0xd0
[ 1941.380305]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.380313] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.380316] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.380319]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380323]  do_idle+0x1d3/0x260
[ 1941.380326]  cpu_startup_entry+0x19/0x20
[ 1941.380335] ------------[ cut here ]------------
[ 1941.380337] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380337] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380410]  __do_softirq+0x10f/0x366
[ 1941.380414]  irq_exit+0xab/0x120
[ 1941.380422] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.380425] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.380428]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380431]  cpuidle_enter+0x29/0x40
[ 1941.380432]  do_idle+0x1d3/0x260
[ 1941.380435]  cpu_startup_entry+0x19/0x20
[ 1941.380443] ------------[ cut here ]------------
[ 1941.380444] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380445] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380515]  _nohz_idle_balance+0xe8/0x220
[ 1941.380519]  ? sched_clock_cpu+0xe/0xd0
[ 1941.380524]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.380531] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.380535] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.380537]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380542]  do_idle+0x1d3/0x260
[ 1941.380545]  cpu_startup_entry+0x19/0x20
[ 1941.380554] ------------[ cut here ]------------
[ 1941.380555] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380556] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380633]  irq_exit+0xab/0x120
[ 1941.380641] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.380644] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.380647]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380650]  cpuidle_enter+0x29/0x40
[ 1941.380651]  do_idle+0x1d3/0x260
[ 1941.380654]  cpu_startup_entry+0x19/0x20
[ 1941.380662] ------------[ cut here ]------------
[ 1941.380663] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380664] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380733]  _nohz_idle_balance+0xe8/0x220
[ 1941.380740]  irq_exit+0xab/0x120
[ 1941.380749] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.380753] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.380757]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380759]  cpuidle_enter+0x29/0x40
[ 1941.380764]  cpu_startup_entry+0x19/0x20
[ 1941.380773] ------------[ cut here ]------------
[ 1941.380775] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380775] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380848]  __do_softirq+0x10f/0x366
[ 1941.380852]  irq_exit+0xab/0x120
[ 1941.380861] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.380865] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.380874]  do_idle+0x1d3/0x260
[ 1941.380877]  cpu_startup_entry+0x19/0x20
[ 1941.380885] ------------[ cut here ]------------
[ 1941.380887] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.380888] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.380961]  __do_softirq+0x10f/0x366
[ 1941.380965]  irq_exit+0xab/0x120
[ 1941.380974] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.380978] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.380982]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.380984]  cpuidle_enter+0x29/0x40
[ 1941.380986]  do_idle+0x1d3/0x260
[ 1941.380989]  cpu_startup_entry+0x19/0x20
[ 1941.380998] ------------[ cut here ]------------
[ 1941.380999] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.381000] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.381070]  _nohz_idle_balance+0xe8/0x220
[ 1941.381075]  ? sched_clock_cpu+0xe/0xd0
[ 1941.381080]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.381086] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381089] R13: ffff999d582b7748 R14: 0000000000000004 R15: 000001a13a8=
142d5
[ 1941.381091]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.381095]  do_idle+0x1d3/0x260
[ 1941.381098]  cpu_startup_entry+0x19/0x20
[ 1941.381106] ------------[ cut here ]------------
[ 1941.381107] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.381108] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.381187]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.381192] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381196] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.381199]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.381201]  cpuidle_enter+0x29/0x40
[ 1941.381203]  do_idle+0x1d3/0x260
[ 1941.381205]  cpu_startup_entry+0x19/0x20
[ 1941.381213] ------------[ cut here ]------------
[ 1941.381215] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.381215] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.381286]  __do_softirq+0x10f/0x366
[ 1941.381291]  irq_exit+0xab/0x120
[ 1941.381299] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381303] R10: 0000000000000757 R11: 0000000000000f97 R12: 00000000000=
00004
[ 1941.381307]  ? cpuidle_enter_state+0xa4/0x430
[ 1941.381309]  cpuidle_enter+0x29/0x40
[ 1941.381312]  do_idle+0x1d3/0x260
[ 1941.381314]  cpu_startup_entry+0x19/0x20
[ 1941.381323] ------------[ cut here ]------------
[ 1941.381324] WARNING: CPU: 2 PID: 0 at kernel/smp.c:127 flush_smp_call_fu=
nction_queue+0x8d/0xf0
[ 1941.381325] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.381387] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.381388] RAX: 0000000000000000 RBX: 0000000100071a21 RCX: 00000000000=
00000
[ 1941.381402]  irq_exit+0xab/0x120
[ 1941.381405]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.381407]  apic_timer_interrupt+0xf/0x20
[ 1941.381412] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.381413] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381414] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381415] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.381463]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.381500] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.381506]  ? call_function_single_interrupt+0xa/0x20
[ 1941.381519]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.381520]  apic_timer_interrupt+0xf/0x20
[ 1941.381525] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.381526] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381528] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381528] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.381576]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.381612] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.381617] R13: ffff999d5832d300 R14: 000000000002d300 R15: 00000000000=
00004
[ 1941.381632]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.381634]  apic_timer_interrupt+0xf/0x20
[ 1941.381638] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.381639] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381641] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381642] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.381689]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.381726] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.381732]  ? call_function_single_interrupt+0xa/0x20
[ 1941.381747]  apic_timer_interrupt+0xf/0x20
[ 1941.381748]  </IRQ>
[ 1941.381751] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.381752] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381753] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381754] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.381800]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.381837] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.381840] RBP: 0000000000000002 R08: 0000019de4d6a217 R09: 00000000000=
001a8
[ 1941.381852]  irq_exit+0xab/0x120
[ 1941.381858]  apic_timer_interrupt+0xf/0x20
[ 1941.381859]  </IRQ>
[ 1941.381863] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.381863] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381865] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381866] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.381913]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.381949] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.381952] RBP: 0000000000000002 R08: 0000019de4d6a217 R09: 00000000000=
001a8
[ 1941.381965]  irq_exit+0xab/0x120
[ 1941.381970]  apic_timer_interrupt+0xf/0x20
[ 1941.381971]  </IRQ>
[ 1941.381974] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.381975] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.381977] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.381978] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382025]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382062] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382078]  irq_exit+0xab/0x120
[ 1941.382082]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.382084]  apic_timer_interrupt+0xf/0x20
[ 1941.382089] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382089] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382090] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382091] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382140]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382177] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382186]  _nohz_idle_balance+0xe8/0x220
[ 1941.382197]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.382199]  apic_timer_interrupt+0xf/0x20
[ 1941.382203] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382205] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382206] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382207] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382253]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382290] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382293] RBP: 0000000000000002 R08: 0000019de4d6a217 R09: 00000000000=
001a8
[ 1941.382306]  irq_exit+0xab/0x120
[ 1941.382311]  apic_timer_interrupt+0xf/0x20
[ 1941.382311]  </IRQ>
[ 1941.382315] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382316] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382318] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382319] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382367]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382403] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382417]  ? sched_clock_cpu+0xe/0xd0
[ 1941.382423]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.382425]  apic_timer_interrupt+0xf/0x20
[ 1941.382427]  </IRQ>
[ 1941.382430] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382431] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382432] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382433] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382481]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382517] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382533]  irq_exit+0xab/0x120
[ 1941.382536]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.382538]  apic_timer_interrupt+0xf/0x20
[ 1941.382542] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382543] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382544] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382545] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382591]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382628] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382644]  irq_exit+0xab/0x120
[ 1941.382647]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.382649]  apic_timer_interrupt+0xf/0x20
[ 1941.382650]  </IRQ>
[ 1941.382653] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382654] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382655] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382705]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382741] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382744] RBP: 0000000000000002 R08: 0000019de4d6a217 R09: 00000000000=
001a8
[ 1941.382757]  irq_exit+0xab/0x120
[ 1941.382763]  apic_timer_interrupt+0xf/0x20
[ 1941.382764]  </IRQ>
[ 1941.382767] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382768] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382769] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382770] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382817]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382854] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.382870]  irq_exit+0xab/0x120
[ 1941.382872]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.382875]  apic_timer_interrupt+0xf/0x20
[ 1941.382879] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382880] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382881] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382882] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.382930]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.382969] RBP: 0000000000000002 R08: 0000019de4d6a217 R09: 00000000000=
001a8
[ 1941.382982]  irq_exit+0xab/0x120
[ 1941.382987]  apic_timer_interrupt+0xf/0x20
[ 1941.382989]  </IRQ>
[ 1941.382991] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.382993] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.382994] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.382995] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383042]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383079] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.383092]  ? sched_clock_cpu+0xe/0xd0
[ 1941.383099]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.383101]  apic_timer_interrupt+0xf/0x20
[ 1941.383105] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383106] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383107] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383108] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383155]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383192] Code: 00 00 00 f0 0f b1 13 75 02 5b c3 89 c6 48 89 df e8 f4 =
c2 6f ff 66 90 5b c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57 9d <0f=
> 1f 44 00 00 bf 01 00 00 00 e8 80 db 6c ff 65 8b 05 31 48 62 46
[ 1941.383211]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.383213]  apic_timer_interrupt+0xf/0x20
[ 1941.383217] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383219] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383220] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383221] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383268]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383305] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.383313]  _nohz_idle_balance+0xe8/0x220
[ 1941.383320]  irq_exit+0xab/0x120
[ 1941.383325]  apic_timer_interrupt+0xf/0x20
[ 1941.383327]  </IRQ>
[ 1941.383329] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383330] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383332] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383333] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383380]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383418] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.383426]  _nohz_idle_balance+0xe8/0x220
[ 1941.383437]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.383439]  apic_timer_interrupt+0xf/0x20
[ 1941.383443] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383445] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383446] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383447] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383492]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383529] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.383532] RBP: 0000000000000002 R08: 0000019de4d6a217 R09: 00000000000=
001a8
[ 1941.383545]  irq_exit+0xab/0x120
[ 1941.383550]  apic_timer_interrupt+0xf/0x20
[ 1941.383551]  </IRQ>
[ 1941.383554] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383555] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383556] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383605]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383641] Code: 00 00 00 f0 0f b1 13 75 02 5b c3 89 c6 48 89 df e8 f4 =
c2 6f ff 66 90 5b c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57 9d <0f=
> 1f 44 00 00 bf 01 00 00 00 e8 80 db 6c ff 65 8b 05 31 48 62 46
[ 1941.383661]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.383663]  apic_timer_interrupt+0xf/0x20
[ 1941.383664]  </IRQ>
[ 1941.383667] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383668] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383669] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383670] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383718]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383754] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.383770]  irq_exit+0xab/0x120
[ 1941.383772]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.383774]  apic_timer_interrupt+0xf/0x20
[ 1941.383779] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383779] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383782] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383783] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383830]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383866] RSP: 0018:ffffb116001bced0 EFLAGS: 00000286 ORIG_RAX: ffffff=
ffffffff04
[ 1941.383882]  irq_exit+0xab/0x120
[ 1941.383887]  apic_timer_interrupt+0xf/0x20
[ 1941.383888]  </IRQ>
[ 1941.383891] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.383892] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.383894] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.383895] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.383942]  snd_hwdep snd_pcm intel_uncore i2c_algo_bit nls_iso8859_1 n=
ls_cp437 vfat intel_rapl_perf drm_kms_helper fat snd_timer psmouse pcspkr i=
nput_leds snd r8169 cec realtek i2c_i801 soundcore libphy rfkill rc_core li=
barc4 mei_me intel_lpss_pci intel_lpss mei tpm_crb intel_gtt idma64 process=
or_thermal_device syscopyarea sysfillrect intel_rapl_common intel_xhci_usb_=
role_switch i2c_hid roles tpm_tis intel_pch_thermal sysimgblt tpm_tis_core =
intel_soc_dts_iosf fb_sys_fops hid wmi tpm int3403_thermal int3400_thermal =
evdev int340x_thermal_zone acpi_thermal_rel hp_accel rng_core battery lis3l=
v02d hp_wireless mac_hid ac drm agpgart crypto_user ip_tables x_tables ext4=
 crc32c_generic crc16 mbcache jbd2 rtsx_pci_sdmmc mmc_core xhci_pci xhci_hc=
d serio_raw atkbd libps2 rtsx_pci crc32c_intel i8042 serio
[ 1941.383977] Code: 00 00 00 f0 0f b1 13 75 02 5b c3 89 c6 48 89 df e8 f4 =
c2 6f ff 66 90 5b c3 0f 1f 44 00 00 c6 07 00 0f 1f 40 00 48 89 f7 57 9d <0f=
> 1f 44 00 00 bf 01 00 00 00 e8 80 db 6c ff 65 8b 05 31 48 62 46
[ 1941.383995]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.383999]  apic_timer_interrupt+0xf/0x20
[ 1941.384001]  </IRQ>
[ 1941.384002] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.384004] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384006] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384006] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.384007] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.384027] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384093]  ? call_function_single_interrupt+0xa/0x20
[ 1941.384103]  irq_exit+0xab/0x120
[ 1941.384106]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.384108]  apic_timer_interrupt+0xf/0x20
[ 1941.384109]  </IRQ>
[ 1941.384112] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384113] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384114] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384137] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384218]  </IRQ>
[ 1941.384221] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384222] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384223] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384245] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384310] R13: ffff999d5832d300 R14: 000000000002d300 R15: 00000000000=
00004
[ 1941.384320]  irq_exit+0xab/0x120
[ 1941.384323]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.384324]  apic_timer_interrupt+0xf/0x20
[ 1941.384326]  </IRQ>
[ 1941.384329] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384329] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384331] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384356] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384420] R13: ffff999d5832d300 R14: 000000000002d300 R15: 00000000000=
00004
[ 1941.384430]  irq_exit+0xab/0x120
[ 1941.384434]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.384435]  apic_timer_interrupt+0xf/0x20
[ 1941.384436]  </IRQ>
[ 1941.384438] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384439] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384465] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384537]  ? sched_clock_cpu+0xe/0xd0
[ 1941.384539]  irq_exit+0xab/0x120
[ 1941.384542]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.384544]  apic_timer_interrupt+0xf/0x20
[ 1941.384547] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384547] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384549] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384550] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.384574] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384650]  irq_exit+0xab/0x120
[ 1941.384653]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.384655]  apic_timer_interrupt+0xf/0x20
[ 1941.384658]  </IRQ>
[ 1941.384660] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384661] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384662] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384684] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384759]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.384762]  apic_timer_interrupt+0xf/0x20
[ 1941.384763]  </IRQ>
[ 1941.384765] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.384768] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384769] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384770] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.384771] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.384792] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384864]  ? sched_clock_cpu+0xe/0xd0
[ 1941.384868]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.384871]  apic_timer_interrupt+0xf/0x20
[ 1941.384872]  </IRQ>
[ 1941.384873] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.384876] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384878] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.384879] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.384880] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.384900] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.384972]  ? sched_clock_cpu+0xe/0xd0
[ 1941.384974]  irq_exit+0xab/0x120
[ 1941.384977]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.384979]  apic_timer_interrupt+0xf/0x20
[ 1941.384980]  </IRQ>
[ 1941.384983] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.384984] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.384985] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385011] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385088]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.385092]  apic_timer_interrupt+0xf/0x20
[ 1941.385092]  </IRQ>
[ 1941.385094] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.385095] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385097] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385098] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.385099] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.385121] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385191]  ? sched_clock_cpu+0xe/0xd0
[ 1941.385195]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.385198]  apic_timer_interrupt+0xf/0x20
[ 1941.385199]  </IRQ>
[ 1941.385201] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.385202] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385203] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385227] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385299]  ? sched_clock_cpu+0xe/0xd0
[ 1941.385301]  irq_exit+0xab/0x120
[ 1941.385304]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.385306]  apic_timer_interrupt+0xf/0x20
[ 1941.385309] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.385310] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385311] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385336] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385409]  irq_exit+0xab/0x120
[ 1941.385411]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.385413]  apic_timer_interrupt+0xf/0x20
[ 1941.385417] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.385417] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385418] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385442] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385517]  irq_exit+0xab/0x120
[ 1941.385518]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.385521]  apic_timer_interrupt+0xf/0x20
[ 1941.385522]  </IRQ>
[ 1941.385523] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.385525] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385527] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385527] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.385528] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.385551] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385623]  ? sched_clock_cpu+0xe/0xd0
[ 1941.385627]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.385630]  apic_timer_interrupt+0xf/0x20
[ 1941.385630]  </IRQ>
[ 1941.385632] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.385633] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385634] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385635] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.385636] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.385658] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385732]  ? sched_clock_cpu+0xe/0xd0
[ 1941.385734]  irq_exit+0xab/0x120
[ 1941.385737]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.385739]  apic_timer_interrupt+0xf/0x20
[ 1941.385740]  </IRQ>
[ 1941.385742] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.385743] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385744] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385766] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385840]  ? sched_clock_cpu+0xe/0xd0
[ 1941.385844]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.385846]  apic_timer_interrupt+0xf/0x20
[ 1941.385848]  </IRQ>
[ 1941.385849] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.385851] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385852] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385852] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.385853] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.385877] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.385954]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.385955]  apic_timer_interrupt+0xf/0x20
[ 1941.385956]  </IRQ>
[ 1941.385958] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.385959] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.385960] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.385985] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386057]  ? sched_clock_cpu+0xe/0xd0
[ 1941.386059]  irq_exit+0xab/0x120
[ 1941.386062]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.386063]  apic_timer_interrupt+0xf/0x20
[ 1941.386064]  </IRQ>
[ 1941.386066] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.386067] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386069] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386092] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386164]  ? sched_clock_cpu+0xe/0xd0
[ 1941.386168]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386171]  apic_timer_interrupt+0xf/0x20
[ 1941.386172]  </IRQ>
[ 1941.386174] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386175] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386176] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.386177] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.386200] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386264]  ? call_function_single_interrupt+0xa/0x20
[ 1941.386273]  irq_exit+0xab/0x120
[ 1941.386276]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.386278]  apic_timer_interrupt+0xf/0x20
[ 1941.386278]  </IRQ>
[ 1941.386281] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.386281] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386282] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386307] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386382]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386385]  apic_timer_interrupt+0xf/0x20
[ 1941.386386]  </IRQ>
[ 1941.386388] Code: 20 62 83 46 e8 eb 06 8f ff 49 89 c7 0f 1f 44 00 00 31 =
ff e8 9c 15 8f ff 80 7c 24 0f 00 0f 85 1a 02 00 00 fb 66 0f 1f 44 00 00 <45=
> 85 e4 0f 88 fd 01 00 00 49 63 d4 4c 2b 7c 24 10 48 8d 04 52 48
[ 1941.386389] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386390] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386414] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386489]  irq_exit+0xab/0x120
[ 1941.386490]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386495]  </IRQ>
[ 1941.386496] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.386498] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386499] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386499] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.386500] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.386523] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386596]  __do_softirq+0x10f/0x366
[ 1941.386598]  ? sched_clock_cpu+0xe/0xd0
[ 1941.386602]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386606]  </IRQ>
[ 1941.386607] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.386609] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386610] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386611] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.386612] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.386636] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386710]  ? sched_clock_cpu+0xe/0xd0
[ 1941.386713]  irq_exit+0xab/0x120
[ 1941.386714]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386717]  apic_timer_interrupt+0xf/0x20
[ 1941.386718]  </IRQ>
[ 1941.386719] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.386721] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386722] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386723] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.386724] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.386747] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386821]  ? sched_clock_cpu+0xe/0xd0
[ 1941.386824]  irq_exit+0xab/0x120
[ 1941.386825]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386828]  apic_timer_interrupt+0xf/0x20
[ 1941.386829]  </IRQ>
[ 1941.386830] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.386833] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386834] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386835] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.386836] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.386859] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.386931]  __do_softirq+0x10f/0x366
[ 1941.386936]  irq_exit+0xab/0x120
[ 1941.386937]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.386940]  apic_timer_interrupt+0xf/0x20
[ 1941.386941]  </IRQ>
[ 1941.386942] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.386944] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.386945] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.386947] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.386948] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.386971] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387043]  __do_softirq+0x10f/0x366
[ 1941.387049]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387052]  apic_timer_interrupt+0xf/0x20
[ 1941.387052]  </IRQ>
[ 1941.387053] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387055] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387056] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387057] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387057] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387078] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387150]  __do_softirq+0x10f/0x366
[ 1941.387152]  ? sched_clock_cpu+0xe/0xd0
[ 1941.387156]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387160]  </IRQ>
[ 1941.387161] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387163] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387164] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387165] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387166] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387189] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387260]  __do_softirq+0x10f/0x366
[ 1941.387265]  irq_exit+0xab/0x120
[ 1941.387266]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387269]  apic_timer_interrupt+0xf/0x20
[ 1941.387270]  </IRQ>
[ 1941.387272] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387273] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387275] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387275] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387276] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387301] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387374]  ? sched_clock_cpu+0xe/0xd0
[ 1941.387378]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387380]  apic_timer_interrupt+0xf/0x20
[ 1941.387381]  </IRQ>
[ 1941.387382] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387384] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387385] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387386] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387386] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387409] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387598]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387601]  </IRQ>
[ 1941.387603] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387605] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387606] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387607] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387607] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387631] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387710]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387713]  </IRQ>
[ 1941.387714] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387716] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387717] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387718] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387718] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387738] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387821] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387822] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387823] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387824] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387825] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387845] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.387924]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.387927]  </IRQ>
[ 1941.387928] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.387930] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.387931] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.387932] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.387932] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.387952] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388028]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.388032]  </IRQ>
[ 1941.388033] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388035] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388036] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388037] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388063] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388141]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.388145]  </IRQ>
[ 1941.388146] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388148] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388150] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388150] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388151] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388177] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388255]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.388259]  </IRQ>
[ 1941.388260] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388262] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388264] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388264] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388265] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388288] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388364]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.388369] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388371] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388372] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388372] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388373] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388396] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388475]  apic_timer_interrupt+0xf/0x20
[ 1941.388477] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388478] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388479] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388480] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388481] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388502] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388581]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.388583]  </IRQ>
[ 1941.388584] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388587] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388588] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388589] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388589] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388613] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388694]  </IRQ>
[ 1941.388695] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388697] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388698] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388699] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388700] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388720] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388800]  ? rcu_dynticks_eqs_enter+0xd/0x30
[ 1941.388802]  </IRQ>
[ 1941.388804] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388806] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388807] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388808] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388808] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388832] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core videodev snd_soc_acpi_intel_match snd_soc_acpi snd=
_soc_core kvm snd_compress ac97_bus snd_pcm_dmaengine snd_hda_intel joydev =
snd_intel_dspcfg mc uas ecdh_generic mousedev irqbypass snd_hda_codec crct1=
0dif_pclmul usbhid ecc crc32_pclmul ghash_clmulni_intel hid_multitouch aesn=
i_intel crypto_simd hp_wmi iTCO_wdt hid_generic iTCO_vendor_support mei_hdc=
p sparse_keymap intel_rapl_msr wmi_bmof cryptd usb_storage snd_hda_core glu=
e_helper cfg80211 intel_cstate
[ 1941.388908]  smp_apic_timer_interrupt+0xaa/0x1d0
[ 1941.388911]  </IRQ>
[ 1941.388912] RIP: 0010:cpuidle_enter_state+0xb6/0x430
[ 1941.388914] RSP: 0018:ffffb11600113e68 EFLAGS: 00000246 ORIG_RAX: ffffff=
ffffffff13
[ 1941.388915] RAX: ffff999d58280000 RBX: ffff999d582b7748 RCX: 00000000000=
0001f
[ 1941.388916] RDX: 0000000000000000 RSI: ffffffffba158f77 RDI: ffffffffba1=
6300c
[ 1941.388917] RBP: ffffffffba4b8f80 R08: 000001a13a8142d5 R09: 00000000000=
00018
[ 1941.388938] Modules linked in: rfcomm fuse 8021q garp mrp stp llc ccm sn=
d_hda_codec_hdmi snd_hda_codec_conexant snd_hda_codec_generic ledtrig_audio=
 i915 cmac algif_hash algif_skcipher af_alg rtw88_8822be rtw88_8822b rtw88_=
pci rtw88_core bnep ebtable_filter ebtables ip6table_filter x86_pkg_temp_th=
ermal ip6_tables mac80211 intel_powerclamp iptable_filter uvcvideo coretemp=
 kvm_intel btusb btrtl btbcm snd_soc_skl btintel videobuf2_vmalloc bluetoot=
h videobuf2_memops videobuf2_v4l2 snd_soc_sst_ipc videobuf2_common snd_soc_=
sst_dsp snd_hda_ext_core v

Some of the affect code lines are (according to gdb / debug kernel build):

(gdb) l *flush_smp_call_function_queue+0x8d/0xf0
0xffffffff8113d650 is in flush_smp_call_function_queue (kernel/smp.c:211).
206      *
207      * Loop through the call_single_queue and run all the queued callba=
cks.
208      * Must be called with interrupts disabled.
209      */
210     static void flush_smp_call_function_queue(bool warn_cpu_offline)
211     {
212             struct llist_head *head;
213             struct llist_node *entry;
214             call_single_data_t *csd, *csd_next;
215             static bool warned;
(gdb)
216
217             lockdep_assert_irqs_disabled();
218
219             head =3D this_cpu_ptr(&call_single_queue);
220             entry =3D llist_del_all(head);
221             entry =3D llist_reverse_order(entry);
222
223             /* There shouldn't be any pending callbacks on an offline C=
PU. */
224             if (unlikely(warn_cpu_offline && !cpu_online(smp_processor_=
id()) &&
225                          !warned && !llist_empty(head))) {

also

(gdb) l *cpuidle_enter_state+0xa4/0x430
0xffffffff817dc190 is in cpuidle_enter_state (drivers/cpuidle/cpuidle.c:204=
).
199      * @drv: cpuidle driver for this cpu
200      * @index: index into the states table in @drv of the state to enter
201      */
202     int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_=
driver *drv,
203                             int index)
204     {
205             int entered_state;
206
207             struct cpuidle_state *target_state =3D &drv->states[index];
208             bool broadcast =3D !!(target_state->flags & CPUIDLE_FLAG_TI=
MER_STOP);
(gdb)
209             ktime_t time_start, time_end;
210
211             /*
212              * Tell the time framework to switch to a broadcast timer b=
ecause our
213              * local timer will be shut down.  If a local timer is used=
 from another
214              * CPU as a broadcast timer, this call may fail if it is no=
t available.
215              */
216             if (broadcast && tick_broadcast_enter()) {
217                     index =3D find_deepest_state(drv, dev, target_state=
->exit_latency_ns,
218                                                CPUIDLE_FLAG_TIMER_STOP,=
 false);

and

(gdb) l *__do_softirq+0x10f/0x366
0xffffffff81c00000 is in __do_softirq (kernel/softirq.c:250).
245     static inline bool lockdep_softirq_start(void) { return false; }
246     static inline void lockdep_softirq_end(bool in_hardirq) { }
247     #endif
248
249     asmlinkage __visible void __softirq_entry __do_softirq(void)
250     {
251             unsigned long end =3D jiffies + MAX_SOFTIRQ_TIME;
252             unsigned long old_flags =3D current->flags;
253             int max_restart =3D MAX_SOFTIRQ_RESTART;
254             struct softirq_action *h;
(gdb)
255             bool in_hardirq;
256             __u32 pending;
257             int softirq_bit;
258
259             /*
260              * Mask out PF_MEMALLOC as the current task context is borr=
owed for the
261              * softirq. A softirq handled, such as network RX, might se=
t PF_MEMALLOC
262              * again if the socket is related to swapping.
263              */
264             current->flags &=3D ~PF_MEMALLOC;

and

(gdb) l *irq_exit+0xab/0x120
0xffffffff810986a0 is in irq_exit (kernel/softirq.c:404).
399
400     /*
401      * Exit an interrupt context. Process softirqs if needed and possib=
le:
402      */
403     void irq_exit(void)
404     {
405     #ifndef __ARCH_IRQ_EXIT_IRQS_DISABLED
406             local_irq_disable();
407     #else
408             lockdep_assert_irqs_disabled();
(gdb)
409     #endif
410             account_irq_exit_time(current);
411             preempt_count_sub(HARDIRQ_OFFSET);
412             if (!in_interrupt() && local_softirq_pending())
413                     invoke_softirq();
414
415             tick_irq_exit();
416             rcu_irq_exit();
417              /* must be last! */
418             lockdep_hardirq_exit();

My configuration

# lsusb -vv

Bus 002 Device 003: ID 0781:5581 SanDisk Corp. Ultra
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            0=20
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         9
  idVendor           0x0781 SanDisk Corp.
  idProduct          0x5581 Ultra
  bcdDevice            1.00
  iManufacturer           1 SanDisk
  iProduct                2 Ultra
  iSerial                 3 4C530001131025108094
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x002c
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              896mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         8 Mass Storage
      bInterfaceSubClass      6 SCSI
      bInterfaceProtocol     80 Bulk-Only
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               0
        bMaxBurst              15
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x0016
  bNumDeviceCaps          2
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000002
      HIRD Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat         256 micro seconds
Device Status:     0x000c
  (Bus Powered)
  U1 Enabled
  U2 Enabled

Bus 002 Device 002: ID 05e3:0626 Genesys Logic, Inc. USB3.1 Hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         3=20
  bMaxPacketSize0         9
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0626=20
  bcdDevice            6.54
  iManufacturer           1 GenesysLogic
  iProduct                2 USB3.1 Hub
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x001f
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              1 GenesysLogic
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes           19
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Feedback
        wMaxPacketSize     0x0002  1x 2 bytes
        bInterval               8
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             4
  wHubCharacteristic 0x0000
    Ganged power switching
    Ganged overcurrent protection
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    576 milli Ampere
  bHubDecLat          0.4 micro seconds
  wHubDelay          1508 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.0203 lowspeed enable connect
   Port 2: 0000.02a0 lowspeed L1
   Port 3: 0000.02a0 lowspeed L1
   Port 4: 0000.02a0 lowspeed L1
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x002a
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000006
      BESL Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           8 micro seconds
    bU2DevExitLat         190 micro seconds
  Container ID Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType      4
    bReserved               0
    ContainerID             {9f4b56f0-1df6-11e0-ac64-0800200c9a66}
Device Status:     0x000d
  Self Powered
  U1 Enabled
  U2 Enabled

Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               3.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         3=20
  bMaxPacketSize0         9
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0003 3.0 root hub
  bcdDevice            5.07
  iManufacturer           3 Linux 5.7.0-rc6-1-mainline xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:14.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x001f
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
        bMaxBurst               0
Hub Descriptor:
  bLength              12
  bDescriptorType      42
  nNbrPorts             6
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  bHubDecLat          0.0 micro seconds
  wHubDelay             0 nano seconds
  DeviceRemovable    0x00
 Hub Port Status:
   Port 1: 0000.02a0 5Gbps power Rx.Detect
   Port 2: 0000.0203 5Gbps power U0 enable connect
   Port 3: 0000.02a0 5Gbps power Rx.Detect
   Port 4: 0000.02a0 5Gbps power Rx.Detect
   Port 5: 0000.02a0 5Gbps power Rx.Detect
   Port 6: 0000.02a0 5Gbps power Rx.Detect
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x000f
  bNumDeviceCaps          1
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x02
      Latency Tolerance Messages (LTM) Supported
    wSpeedsSupported   0x0008
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   3
      Lowest fully-functional device speed is SuperSpeed (5Gbps)
    bU1DevExitLat          10 micro seconds
    bU2DevExitLat         512 micro seconds
Device Status:     0x0001
  Self Powered

Bus 001 Device 006: ID 138a:003f Validity Sensors, Inc. VFS495 Fingerprint =
Reader
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass        18=20
  bDeviceProtocol       255=20
  bMaxPacketSize0         8
  idVendor           0x138a Validity Sensors, Inc.
  idProduct          0x003f VFS495 Fingerprint Reader
  bcdDevice            1.04
  iManufacturer           0=20
  iProduct                0=20
  iSerial                 1 00a0467fc0a4
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x002e
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           4
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval               4
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 005: ID 0bda:b00b Realtek Semiconductor Corp. Bluetooth Radi=
o=20
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x0bda Realtek Semiconductor Corp.
  idProduct          0xb00b=20
  bcdDevice            1.10
  iManufacturer           1 Realtek=20
  iProduct                2 Bluetooth Radio=20
  iSerial                 3 00e04c000001
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x00b1
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              4 Bluetooth Radio
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
Device Status:     0x0001
  Self Powered

Bus 001 Device 003: ID 04ca:706e Lite-On Technology Corp. HP HD Camera
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2=20
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  idVendor           0x04ca Lite-On Technology Corp.
  idProduct          0x706e=20
  bcdDevice            0.05
  iManufacturer           3 DHCYRA1BIBAAXV
  iProduct                1 HP HD Camera
  iSerial                 2 200901010001
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x02e8
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          4 USB Camera
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         0
      bInterfaceCount         2
      bFunctionClass         14 Video
      bFunctionSubClass       3 Video Interface Collection
      bFunctionProtocol       0=20
      iFunction               5 HP HD Camera
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      1 Video Control
      bInterfaceProtocol      0=20
      iInterface              5 HP HD Camera
      VideoControl Interface Descriptor:
        bLength                13
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdUVC               1.00
        wTotalLength       0x004e
        dwClockFrequency       15.000000MHz
        bInCollection           1
        baInterfaceNr( 0)       1
      VideoControl Interface Descriptor:
        bLength                18
        bDescriptorType        36
        bDescriptorSubtype      2 (INPUT_TERMINAL)
        bTerminalID             1
        wTerminalType      0x0201 Camera Sensor
        bAssocTerminal          0
        iTerminal               0=20
        wObjectiveFocalLengthMin      0
        wObjectiveFocalLengthMax      0
        wOcularFocalLength            0
        bControlSize                  3
        bmControls           0x0000000e
          Auto-Exposure Mode
          Auto-Exposure Priority
          Exposure Time (Absolute)
      VideoControl Interface Descriptor:
        bLength                11
        bDescriptorType        36
        bDescriptorSubtype      5 (PROCESSING_UNIT)
      Warning: Descriptor too short
        bUnitID                 2
        bSourceID               1
        wMaxMultiplier          0
        bControlSize            2
        bmControls     0x0000177f
          Brightness
          Contrast
          Hue
          Saturation
          Sharpness
          Gamma
          White Balance Temperature
          Backlight Compensation
          Gain
          Power Line Frequency
          White Balance Temperature, Auto
        iProcessing             0=20
        bmVideoStandards     0x09
          None
          SECAM - 625/50
      VideoControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      3 (OUTPUT_TERMINAL)
        bTerminalID             3
        wTerminalType      0x0101 USB Streaming
        bAssocTerminal          0
        bSourceID               4
        iTerminal               0=20
      VideoControl Interface Descriptor:
        bLength                27
        bDescriptorType        36
        bDescriptorSubtype      6 (EXTENSION_UNIT)
        bUnitID                 4
        guidExtensionCode         {1229a78c-47b4-4094-b0ce-db07386fb938}
        bNumControl             2
        bNrPins                 1
        baSourceID( 0)          2
        bControlSize            2
        bmControls( 0)       0x00
        bmControls( 1)       0x06
        iExtension              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               6
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      VideoStreaming Interface Descriptor:
        bLength                            15
        bDescriptorType                    36
        bDescriptorSubtype                  1 (INPUT_HEADER)
        bNumFormats                         2
        wTotalLength                   0x01fb
        bEndPointAddress                  129
        bmInfo                              0
        bTerminalLink                       3
        bStillCaptureMethod                 1
        bTriggerSupport                     1
        bTriggerUsage                       0
        bControlSize                        1
        bmaControls( 0)                     0
        bmaControls( 1)                     0
      VideoStreaming Interface Descriptor:
        bLength                            27
        bDescriptorType                    36
        bDescriptorSubtype                  4 (FORMAT_UNCOMPRESSED)
        bFormatIndex                        1
        bNumFrameDescriptors                5
        guidFormat                            {32595559-0000-0010-8000-00aa=
00389b71}
        bBitsPerPixel                      16
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 2 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 73728000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         2
        bmCapabilities                   0x01
          Still image supported
        wWidth                            320
        wHeight                           180
        dwMinBitRate                 13824000
        dwMaxBitRate                 27648000
        dwMaxVideoFrameBufferSize      115200
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         3
        bmCapabilities                   0x01
          Still image supported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                 18432000
        dwMaxBitRate                 36864000
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         4
        bmCapabilities                   0x01
          Still image supported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                 24422400
        dwMaxBitRate                 48844800
        dwMaxVideoFrameBufferSize      203520
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  5 (FRAME_UNCOMPRESSED)
        bFrameIndex                         5
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 55296000
        dwMaxBitRate                110592000
        dwMaxVideoFrameBufferSize      460800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
      VideoStreaming Interface Descriptor:
        bLength                            11
        bDescriptorType                    36
        bDescriptorSubtype                  6 (FORMAT_MJPEG)
        bFormatIndex                        2
        bNumFrameDescriptors                8
        bFlags                              1
          Fixed-size samples: Yes
        bDefaultFrameIndex                  1
        bAspectRatioX                       0
        bAspectRatioY                       0
        bmInterlaceFlags                 0x00
          Interlaced stream or variable: No
          Fields per frame: 1 fields
          Field 1 first: No
          Field pattern: Field 1 only
        bCopyProtect                        0
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         1
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           480
        dwMinBitRate                 73728000
        dwMaxBitRate                147456000
        dwMaxVideoFrameBufferSize      614400
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         2
        bmCapabilities                   0x01
          Still image supported
        wWidth                            320
        wHeight                           180
        dwMinBitRate                 13824000
        dwMaxBitRate                 27648000
        dwMaxVideoFrameBufferSize      115200
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         3
        bmCapabilities                   0x01
          Still image supported
        wWidth                            320
        wHeight                           240
        dwMinBitRate                 18432000
        dwMaxBitRate                 36864000
        dwMaxVideoFrameBufferSize      153600
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         4
        bmCapabilities                   0x01
          Still image supported
        wWidth                            424
        wHeight                           240
        dwMinBitRate                 24422400
        dwMaxBitRate                 48844800
        dwMaxVideoFrameBufferSize      203520
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         5
        bmCapabilities                   0x01
          Still image supported
        wWidth                            640
        wHeight                           360
        dwMinBitRate                 55296000
        dwMaxBitRate                110592000
        dwMaxVideoFrameBufferSize      460800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         6
        bmCapabilities                   0x01
          Still image supported
        wWidth                            848
        wHeight                           480
        dwMinBitRate                 97689600
        dwMaxBitRate                195379200
        dwMaxVideoFrameBufferSize      814080
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         7
        bmCapabilities                   0x01
          Still image supported
        wWidth                            960
        wHeight                           540
        dwMinBitRate                124416000
        dwMaxBitRate                248832000
        dwMaxVideoFrameBufferSize     1036800
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                            34
        bDescriptorType                    36
        bDescriptorSubtype                  7 (FRAME_MJPEG)
        bFrameIndex                         8
        bmCapabilities                   0x01
          Still image supported
        wWidth                           1280
        wHeight                           720
        dwMinBitRate                221184000
        dwMaxBitRate                442368000
        dwMaxVideoFrameBufferSize     1843200
        dwDefaultFrameInterval         333333
        bFrameIntervalType                  2
        dwFrameInterval( 0)            333333
        dwFrameInterval( 1)            666666
      VideoStreaming Interface Descriptor:
        bLength                             6
        bDescriptorType                    36
        bDescriptorSubtype                 13 (COLORFORMAT)
        bColorPrimaries                     1 (BT.709,sRGB)
        bTransferCharacteristics            1 (BT.709)
        bMatrixCoefficients                 4 (SMPTE 170M (BT.601))
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0080  1x 128 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0200  1x 512 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0400  1x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0b00  2x 768 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x0c00  2x 1024 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       6
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1380  3x 896 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       7
      bNumEndpoints           1
      bInterfaceClass        14 Video
      bInterfaceSubClass      2 Video Streaming
      bInterfaceProtocol      0=20
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            5
          Transfer Type            Isochronous
          Synch Type               Asynchronous
          Usage Type               Data
        wMaxPacketSize     0x1400  3x 1024 bytes
        bInterval               1
Device Qualifier (for other device speed):
  bLength                10
  bDescriptorType         6
  bcdUSB               2.00
  bDeviceClass          239 Miscellaneous Device
  bDeviceSubClass         2=20
  bDeviceProtocol         1 Interface Association
  bMaxPacketSize0        64
  bNumConfigurations      1
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 004: ID 046d:c077 Logitech, Inc. M105 Optical Mouse
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0=20
  bDeviceSubClass         0=20
  bDeviceProtocol         0=20
  bMaxPacketSize0         8
  idVendor           0x046d Logitech, Inc.
  idProduct          0xc077 M105 Optical Mouse
  bcdDevice           72.00
  iManufacturer           1 Logitech
  iProduct                2 USB Optical Mouse
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0022
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xa0
      (Bus Powered)
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         3 Human Interface Device
      bInterfaceSubClass      1 Boot Interface Subclass
      bInterfaceProtocol      2 Mouse
      iInterface              0=20
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.11
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      46
         Report Descriptors:=20
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              10
Device Status:     0x0000
  (Bus Powered)

Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.10
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x05e3 Genesys Logic, Inc.
  idProduct          0x0610 4-port hub
  bcdDevice            6.54
  iManufacturer           1 GenesysLogic
  iProduct                2 USB2.1 Hub
  iSerial                 0=20
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0019
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0001  1x 1 bytes
        bInterval              12
Hub Descriptor:
  bLength               9
  bDescriptorType      41
  nNbrPorts             4
  wHubCharacteristic 0x00e0
    Ganged power switching
    Ganged overcurrent protection
    TT think time 32 FS bits
    Port indicators
  bPwrOn2PwrGood       50 * 2 milli seconds
  bHubContrCurrent    100 milli Ampere
  DeviceRemovable    0x00
  PortPwrCtrlMask    0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0100 power
   Port 3: 0000.0303 lowspeed power enable connect
   Port 4: 0000.0100 power
Binary Object Store Descriptor:
  bLength                 5
  bDescriptorType        15
  wTotalLength       0x002a
  bNumDeviceCaps          3
  USB 2.0 Extension Device Capability:
    bLength                 7
    bDescriptorType        16
    bDevCapabilityType      2
    bmAttributes   0x00000006
      BESL Link Power Management (LPM) Supported
  SuperSpeed USB Device Capability:
    bLength                10
    bDescriptorType        16
    bDevCapabilityType      3
    bmAttributes         0x00
    wSpeedsSupported   0x000e
      Device can operate at Full Speed (12Mbps)
      Device can operate at High Speed (480Mbps)
      Device can operate at SuperSpeed (5Gbps)
    bFunctionalitySupport   1
      Lowest fully-functional device speed is Full Speed (12Mbps)
    bU1DevExitLat           8 micro seconds
    bU2DevExitLat         190 micro seconds
  Container ID Device Capability:
    bLength                20
    bDescriptorType        16
    bDevCapabilityType      4
    bReserved               0
    ContainerID             {9f4b56f0-1df6-11e0-ac64-0800200c9a66}
Device Status:     0x0001
  Self Powered

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0=20
  bDeviceProtocol         1 Single TT
  bMaxPacketSize0        64
  idVendor           0x1d6b Linux Foundation
  idProduct          0x0002 2.0 root hub
  bcdDevice            5.07
  iManufacturer           3 Linux 5.7.0-rc6-1-mainline xhci-hcd
  iProduct                2 xHCI Host Controller
  iSerial                 1 0000:00:14.0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0019
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0=20
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0=20
      bInterfaceProtocol      0 Full speed (or root) hub
      iInterface              0=20
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0004  1x 4 bytes
        bInterval              12
Hub Descriptor:
  bLength              11
  bDescriptorType      41
  nNbrPorts            12
  wHubCharacteristic 0x000a
    No power switching (usb 1.0)
    Per-port overcurrent protection
    TT think time 8 FS bits
  bPwrOn2PwrGood       10 * 2 milli seconds
  bHubContrCurrent      0 milli Ampere
  DeviceRemovable    0x00 0x00
  PortPwrCtrlMask    0xff 0xff
 Hub Port Status:
   Port 1: 0000.0100 power
   Port 2: 0000.0503 highspeed power enable connect
   Port 3: 0000.0100 power
   Port 4: 0000.0100 power
   Port 5: 0000.0100 power
   Port 6: 0000.0503 highspeed power enable connect
   Port 7: 0000.0103 power enable connect
   Port 8: 0000.0103 power enable connect
   Port 9: 0000.0100 power
   Port 10: 0000.0100 power
   Port 11: 0000.0100 power
   Port 12: 0000.0100 power
Device Status:     0x0001
  Self Powered

Used kernel config (DEBUG altered later):

#
# Automatically generated file; DO NOT EDIT.
# Linux/x86 5.6.14-arch1 Kernel Configuration
#

#
# Compiler: gcc (GCC) 10.1.0
#
CONFIG_CC_IS_GCC=3Dy
CONFIG_GCC_VERSION=3D100100
CONFIG_CLANG_VERSION=3D0
CONFIG_CC_CAN_LINK=3Dy
CONFIG_CC_HAS_ASM_GOTO=3Dy
CONFIG_CC_HAS_ASM_INLINE=3Dy
CONFIG_IRQ_WORK=3Dy
CONFIG_BUILDTIME_TABLE_SORT=3Dy
CONFIG_THREAD_INFO_IN_TASK=3Dy

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=3D32
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=3D""
CONFIG_LOCALVERSION_AUTO=3Dy
CONFIG_BUILD_SALT=3D""
CONFIG_HAVE_KERNEL_GZIP=3Dy
CONFIG_HAVE_KERNEL_BZIP2=3Dy
CONFIG_HAVE_KERNEL_LZMA=3Dy
CONFIG_HAVE_KERNEL_XZ=3Dy
CONFIG_HAVE_KERNEL_LZO=3Dy
CONFIG_HAVE_KERNEL_LZ4=3Dy
# CONFIG_KERNEL_GZIP is not set
# CONFIG_KERNEL_BZIP2 is not set
# CONFIG_KERNEL_LZMA is not set
CONFIG_KERNEL_XZ=3Dy
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME=3D"archlinux"
CONFIG_SWAP=3Dy
CONFIG_SYSVIPC=3Dy
CONFIG_SYSVIPC_SYSCTL=3Dy
CONFIG_POSIX_MQUEUE=3Dy
CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
CONFIG_CROSS_MEMORY_ATTACH=3Dy
# CONFIG_USELIB is not set
CONFIG_AUDIT=3Dy
CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
CONFIG_AUDITSYSCALL=3Dy

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=3Dy
CONFIG_GENERIC_IRQ_SHOW=3Dy
CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
CONFIG_GENERIC_PENDING_IRQ=3Dy
CONFIG_GENERIC_IRQ_MIGRATION=3Dy
CONFIG_GENERIC_IRQ_CHIP=3Dy
CONFIG_IRQ_DOMAIN=3Dy
CONFIG_IRQ_SIM=3Dy
CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
CONFIG_GENERIC_MSI_IRQ=3Dy
CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
CONFIG_IRQ_MSI_IOMMU=3Dy
CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
CONFIG_IRQ_FORCED_THREADING=3Dy
CONFIG_SPARSE_IRQ=3Dy
# CONFIG_GENERIC_IRQ_DEBUGFS is not set
# end of IRQ subsystem

CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
CONFIG_ARCH_CLOCKSOURCE_DATA=3Dy
CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
CONFIG_GENERIC_TIME_VSYSCALL=3Dy
CONFIG_GENERIC_CLOCKEVENTS=3Dy
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
CONFIG_GENERIC_CMOS_UPDATE=3Dy

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=3Dy
CONFIG_NO_HZ_COMMON=3Dy
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=3Dy
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=3Dy
CONFIG_HIGH_RES_TIMERS=3Dy
# end of Timers subsystem

# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=3Dy
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
CONFIG_IRQ_TIME_ACCOUNTING=3Dy
CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
CONFIG_BSD_PROCESS_ACCT=3Dy
CONFIG_BSD_PROCESS_ACCT_V3=3Dy
CONFIG_TASKSTATS=3Dy
CONFIG_TASK_DELAY_ACCT=3Dy
CONFIG_TASK_XACCT=3Dy
CONFIG_TASK_IO_ACCOUNTING=3Dy
CONFIG_PSI=3Dy
# CONFIG_PSI_DEFAULT_DISABLED is not set
# end of CPU/Task time and stats accounting

CONFIG_CPU_ISOLATION=3Dy

#
# RCU Subsystem
#
CONFIG_TREE_RCU=3Dy
CONFIG_PREEMPT_RCU=3Dy
CONFIG_RCU_EXPERT=3Dy
CONFIG_SRCU=3Dy
CONFIG_TREE_SRCU=3Dy
CONFIG_TASKS_RCU=3Dy
CONFIG_RCU_STALL_COMMON=3Dy
CONFIG_RCU_NEED_SEGCBLIST=3Dy
CONFIG_RCU_FANOUT=3D64
CONFIG_RCU_FANOUT_LEAF=3D16
CONFIG_RCU_FAST_NO_HZ=3Dy
CONFIG_RCU_BOOST=3Dy
CONFIG_RCU_BOOST_DELAY=3D500
# CONFIG_RCU_NOCB_CPU is not set
# end of RCU Subsystem

CONFIG_BUILD_BIN2C=3Dy
CONFIG_IKCONFIG=3Dy
CONFIG_IKCONFIG_PROC=3Dy
# CONFIG_IKHEADERS is not set
CONFIG_LOG_BUF_SHIFT=3D17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy

#
# Scheduler features
#
CONFIG_UCLAMP_TASK=3Dy
CONFIG_UCLAMP_BUCKETS_COUNT=3D5
# end of Scheduler features

CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
CONFIG_CC_HAS_INT128=3Dy
CONFIG_ARCH_SUPPORTS_INT128=3Dy
CONFIG_NUMA_BALANCING=3Dy
CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
CONFIG_CGROUPS=3Dy
CONFIG_PAGE_COUNTER=3Dy
CONFIG_MEMCG=3Dy
CONFIG_MEMCG_SWAP=3Dy
CONFIG_MEMCG_SWAP_ENABLED=3Dy
CONFIG_MEMCG_KMEM=3Dy
CONFIG_BLK_CGROUP=3Dy
CONFIG_CGROUP_WRITEBACK=3Dy
CONFIG_CGROUP_SCHED=3Dy
CONFIG_FAIR_GROUP_SCHED=3Dy
CONFIG_CFS_BANDWIDTH=3Dy
# CONFIG_RT_GROUP_SCHED is not set
CONFIG_UCLAMP_TASK_GROUP=3Dy
CONFIG_CGROUP_PIDS=3Dy
CONFIG_CGROUP_RDMA=3Dy
CONFIG_CGROUP_FREEZER=3Dy
CONFIG_CGROUP_HUGETLB=3Dy
CONFIG_CPUSETS=3Dy
CONFIG_PROC_PID_CPUSET=3Dy
CONFIG_CGROUP_DEVICE=3Dy
CONFIG_CGROUP_CPUACCT=3Dy
CONFIG_CGROUP_PERF=3Dy
CONFIG_CGROUP_BPF=3Dy
# CONFIG_CGROUP_DEBUG is not set
CONFIG_SOCK_CGROUP_DATA=3Dy
CONFIG_NAMESPACES=3Dy
CONFIG_UTS_NS=3Dy
CONFIG_TIME_NS=3Dy
CONFIG_IPC_NS=3Dy
CONFIG_USER_NS=3Dy
CONFIG_USER_NS_UNPRIVILEGED=3Dy
CONFIG_PID_NS=3Dy
CONFIG_NET_NS=3Dy
CONFIG_CHECKPOINT_RESTORE=3Dy
CONFIG_SCHED_AUTOGROUP=3Dy
# CONFIG_SYSFS_DEPRECATED is not set
CONFIG_RELAY=3Dy
CONFIG_BLK_DEV_INITRD=3Dy
CONFIG_INITRAMFS_SOURCE=3D""
CONFIG_RD_GZIP=3Dy
CONFIG_RD_BZIP2=3Dy
CONFIG_RD_LZMA=3Dy
CONFIG_RD_XZ=3Dy
CONFIG_RD_LZO=3Dy
CONFIG_RD_LZ4=3Dy
CONFIG_BOOT_CONFIG=3Dy
CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=3Dy
CONFIG_HAVE_UID16=3Dy
CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
CONFIG_BPF=3Dy
CONFIG_EXPERT=3Dy
# CONFIG_UID16 is not set
CONFIG_MULTIUSER=3Dy
CONFIG_SGETMASK_SYSCALL=3Dy
# CONFIG_SYSFS_SYSCALL is not set
CONFIG_FHANDLE=3Dy
CONFIG_POSIX_TIMERS=3Dy
CONFIG_PRINTK=3Dy
CONFIG_PRINTK_NMI=3Dy
CONFIG_BUG=3Dy
CONFIG_ELF_CORE=3Dy
CONFIG_PCSPKR_PLATFORM=3Dy
CONFIG_BASE_FULL=3Dy
CONFIG_FUTEX=3Dy
CONFIG_FUTEX_PI=3Dy
CONFIG_EPOLL=3Dy
CONFIG_SIGNALFD=3Dy
CONFIG_TIMERFD=3Dy
CONFIG_EVENTFD=3Dy
CONFIG_SHMEM=3Dy
CONFIG_AIO=3Dy
CONFIG_IO_URING=3Dy
CONFIG_ADVISE_SYSCALLS=3Dy
CONFIG_MEMBARRIER=3Dy
CONFIG_KALLSYMS=3Dy
CONFIG_KALLSYMS_ALL=3Dy
CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
CONFIG_BPF_SYSCALL=3Dy
CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
CONFIG_BPF_JIT_ALWAYS_ON=3Dy
CONFIG_BPF_JIT_DEFAULT_ON=3Dy
# CONFIG_USERFAULTFD is not set
CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
CONFIG_RSEQ=3Dy
# CONFIG_DEBUG_RSEQ is not set
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=3Dy
# CONFIG_PC104 is not set

#
# Kernel Performance Events And Counters
#
CONFIG_PERF_EVENTS=3Dy
# CONFIG_DEBUG_PERF_USE_VMALLOC is not set
# end of Kernel Performance Events And Counters

CONFIG_VM_EVENT_COUNTERS=3Dy
CONFIG_SLUB_DEBUG=3Dy
# CONFIG_SLUB_MEMCG_SYSFS_ON is not set
# CONFIG_COMPAT_BRK is not set
# CONFIG_SLAB is not set
CONFIG_SLUB=3Dy
# CONFIG_SLOB is not set
CONFIG_SLAB_MERGE_DEFAULT=3Dy
CONFIG_SLAB_FREELIST_RANDOM=3Dy
CONFIG_SLAB_FREELIST_HARDENED=3Dy
CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
CONFIG_SLUB_CPU_PARTIAL=3Dy
CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
CONFIG_PROFILING=3Dy
CONFIG_TRACEPOINTS=3Dy
# end of General setup

CONFIG_64BIT=3Dy
CONFIG_X86_64=3Dy
CONFIG_X86=3Dy
CONFIG_INSTRUCTION_DECODER=3Dy
CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
CONFIG_ARCH_DEFCONFIG=3D"arch/x86/configs/x86_64_defconfig"
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_STACKTRACE_SUPPORT=3Dy
CONFIG_MMU=3Dy
CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
CONFIG_GENERIC_ISA_DMA=3Dy
CONFIG_GENERIC_BUG=3Dy
CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
CONFIG_ARCH_HAS_CPU_RELAX=3Dy
CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
CONFIG_ARCH_HAS_FILTER_PGPROT=3Dy
CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
CONFIG_ZONE_DMA32=3Dy
CONFIG_AUDIT_ARCH=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_HAVE_INTEL_TXT=3Dy
CONFIG_X86_64_SMP=3Dy
CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
CONFIG_FIX_EARLYCON_MEM=3Dy
CONFIG_DYNAMIC_PHYSICAL_MASK=3Dy
CONFIG_PGTABLE_LEVELS=3D5
CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy

#
# Processor type and features
#
CONFIG_ZONE_DMA=3Dy
CONFIG_SMP=3Dy
CONFIG_X86_FEATURE_NAMES=3Dy
CONFIG_X86_X2APIC=3Dy
CONFIG_X86_MPPARSE=3Dy
# CONFIG_GOLDFISH is not set
CONFIG_RETPOLINE=3Dy
CONFIG_X86_CPU_RESCTRL=3Dy
# CONFIG_X86_EXTENDED_PLATFORM is not set
CONFIG_X86_INTEL_LPSS=3Dy
CONFIG_X86_AMD_PLATFORM_DEVICE=3Dy
CONFIG_IOSF_MBI=3Dy
# CONFIG_IOSF_MBI_DEBUG is not set
CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
CONFIG_HYPERVISOR_GUEST=3Dy
CONFIG_PARAVIRT=3Dy
CONFIG_PARAVIRT_XXL=3Dy
# CONFIG_PARAVIRT_DEBUG is not set
CONFIG_PARAVIRT_SPINLOCKS=3Dy
CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
CONFIG_XEN=3Dy
CONFIG_XEN_PV=3Dy
CONFIG_XEN_PV_SMP=3Dy
CONFIG_XEN_DOM0=3Dy
CONFIG_XEN_PVHVM=3Dy
CONFIG_XEN_PVHVM_SMP=3Dy
CONFIG_XEN_512GB=3Dy
CONFIG_XEN_SAVE_RESTORE=3Dy
# CONFIG_XEN_DEBUG_FS is not set
CONFIG_XEN_PVH=3Dy
CONFIG_KVM_GUEST=3Dy
CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
CONFIG_PVH=3Dy
# CONFIG_KVM_DEBUG_FS is not set
CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
CONFIG_PARAVIRT_CLOCK=3Dy
CONFIG_JAILHOUSE_GUEST=3Dy
CONFIG_ACRN_GUEST=3Dy
# CONFIG_MK8 is not set
# CONFIG_MPSC is not set
# CONFIG_MCORE2 is not set
# CONFIG_MATOM is not set
CONFIG_GENERIC_CPU=3Dy
CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
CONFIG_X86_L1_CACHE_SHIFT=3D6
CONFIG_X86_TSC=3Dy
CONFIG_X86_CMPXCHG64=3Dy
CONFIG_X86_CMOV=3Dy
CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_IA32_FEAT_CTL=3Dy
CONFIG_X86_VMX_FEATURE_NAMES=3Dy
CONFIG_PROCESSOR_SELECT=3Dy
CONFIG_CPU_SUP_INTEL=3Dy
CONFIG_CPU_SUP_AMD=3Dy
CONFIG_CPU_SUP_HYGON=3Dy
CONFIG_CPU_SUP_CENTAUR=3Dy
CONFIG_CPU_SUP_ZHAOXIN=3Dy
CONFIG_HPET_TIMER=3Dy
CONFIG_HPET_EMULATE_RTC=3Dy
CONFIG_DMI=3Dy
CONFIG_GART_IOMMU=3Dy
# CONFIG_MAXSMP is not set
CONFIG_NR_CPUS_RANGE_BEGIN=3D2
CONFIG_NR_CPUS_RANGE_END=3D512
CONFIG_NR_CPUS_DEFAULT=3D64
CONFIG_NR_CPUS=3D320
CONFIG_SCHED_SMT=3Dy
CONFIG_SCHED_MC=3Dy
CONFIG_SCHED_MC_PRIO=3Dy
CONFIG_X86_LOCAL_APIC=3Dy
CONFIG_X86_IO_APIC=3Dy
CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
CONFIG_X86_MCE=3Dy
# CONFIG_X86_MCELOG_LEGACY is not set
CONFIG_X86_MCE_INTEL=3Dy
CONFIG_X86_MCE_AMD=3Dy
CONFIG_X86_MCE_THRESHOLD=3Dy
CONFIG_X86_MCE_INJECT=3Dm
CONFIG_X86_THERMAL_VECTOR=3Dy

#
# Performance monitoring
#
CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm
CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
CONFIG_PERF_EVENTS_AMD_POWER=3Dm
# end of Performance monitoring

CONFIG_X86_16BIT=3Dy
CONFIG_X86_ESPFIX64=3Dy
CONFIG_X86_VSYSCALL_EMULATION=3Dy
CONFIG_X86_IOPL_IOPERM=3Dy
CONFIG_I8K=3Dm
CONFIG_MICROCODE=3Dy
CONFIG_MICROCODE_INTEL=3Dy
CONFIG_MICROCODE_AMD=3Dy
CONFIG_MICROCODE_OLD_INTERFACE=3Dy
CONFIG_X86_MSR=3Dm
CONFIG_X86_CPUID=3Dm
CONFIG_X86_5LEVEL=3Dy
CONFIG_X86_DIRECT_GBPAGES=3Dy
# CONFIG_X86_CPA_STATISTICS is not set
CONFIG_AMD_MEM_ENCRYPT=3Dy
# CONFIG_AMD_MEM_ENCRYPT_ACTIVE_BY_DEFAULT is not set
CONFIG_NUMA=3Dy
CONFIG_AMD_NUMA=3Dy
CONFIG_X86_64_ACPI_NUMA=3Dy
CONFIG_NODES_SPAN_OTHER_NODES=3Dy
# CONFIG_NUMA_EMU is not set
CONFIG_NODES_SHIFT=3D5
CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
CONFIG_ARCH_MEMORY_PROBE=3Dy
CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
CONFIG_X86_PMEM_LEGACY=3Dm
CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK=3Dy
CONFIG_X86_RESERVE_LOW=3D64
CONFIG_MTRR=3Dy
CONFIG_MTRR_SANITIZER=3Dy
CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D0
CONFIG_X86_PAT=3Dy
CONFIG_ARCH_USES_PG_UNCACHED=3Dy
CONFIG_ARCH_RANDOM=3Dy
CONFIG_X86_SMAP=3Dy
CONFIG_X86_UMIP=3Dy
CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
# CONFIG_X86_INTEL_TSX_MODE_OFF is not set
# CONFIG_X86_INTEL_TSX_MODE_ON is not set
CONFIG_X86_INTEL_TSX_MODE_AUTO=3Dy
CONFIG_EFI=3Dy
CONFIG_EFI_STUB=3Dy
CONFIG_EFI_MIXED=3Dy
CONFIG_SECCOMP=3Dy
# CONFIG_HZ_100 is not set
# CONFIG_HZ_250 is not set
CONFIG_HZ_300=3Dy
# CONFIG_HZ_1000 is not set
CONFIG_HZ=3D300
CONFIG_SCHED_HRTICK=3Dy
CONFIG_KEXEC=3Dy
CONFIG_KEXEC_FILE=3Dy
CONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy
# CONFIG_KEXEC_SIG is not set
CONFIG_CRASH_DUMP=3Dy
CONFIG_KEXEC_JUMP=3Dy
CONFIG_PHYSICAL_START=3D0x1000000
CONFIG_RELOCATABLE=3Dy
CONFIG_RANDOMIZE_BASE=3Dy
CONFIG_X86_NEED_RELOCS=3Dy
CONFIG_PHYSICAL_ALIGN=3D0x200000
CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
CONFIG_RANDOMIZE_MEMORY=3Dy
CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0x1
CONFIG_HOTPLUG_CPU=3Dy
# CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
# CONFIG_DEBUG_HOTPLUG_CPU0 is not set
# CONFIG_COMPAT_VDSO is not set
# CONFIG_LEGACY_VSYSCALL_EMULATE is not set
CONFIG_LEGACY_VSYSCALL_XONLY=3Dy
# CONFIG_LEGACY_VSYSCALL_NONE is not set
# CONFIG_CMDLINE_BOOL is not set
CONFIG_MODIFY_LDT_SYSCALL=3Dy
CONFIG_HAVE_LIVEPATCH=3Dy
# CONFIG_LIVEPATCH is not set
# end of Processor type and features

CONFIG_ARCH_HAS_ADD_PAGES=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy

#
# Power management and ACPI options
#
CONFIG_ARCH_HIBERNATION_HEADER=3Dy
CONFIG_SUSPEND=3Dy
CONFIG_SUSPEND_FREEZER=3Dy
# CONFIG_SUSPEND_SKIP_SYNC is not set
CONFIG_HIBERNATE_CALLBACKS=3Dy
CONFIG_HIBERNATION=3Dy
CONFIG_PM_STD_PARTITION=3D""
CONFIG_PM_SLEEP=3Dy
CONFIG_PM_SLEEP_SMP=3Dy
CONFIG_PM_AUTOSLEEP=3Dy
CONFIG_PM_WAKELOCKS=3Dy
CONFIG_PM_WAKELOCKS_LIMIT=3D100
CONFIG_PM_WAKELOCKS_GC=3Dy
CONFIG_PM=3Dy
CONFIG_PM_DEBUG=3Dy
CONFIG_PM_ADVANCED_DEBUG=3Dy
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=3Dy
# CONFIG_DPM_WATCHDOG is not set
CONFIG_PM_TRACE=3Dy
CONFIG_PM_TRACE_RTC=3Dy
CONFIG_PM_CLK=3Dy
CONFIG_PM_GENERIC_DOMAINS=3Dy
CONFIG_WQ_POWER_EFFICIENT_DEFAULT=3Dy
CONFIG_PM_GENERIC_DOMAINS_SLEEP=3Dy
CONFIG_PM_GENERIC_DOMAINS_OF=3Dy
CONFIG_ENERGY_MODEL=3Dy
CONFIG_ARCH_SUPPORTS_ACPI=3Dy
CONFIG_ACPI=3Dy
CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
# CONFIG_ACPI_DEBUGGER is not set
CONFIG_ACPI_SPCR_TABLE=3Dy
CONFIG_ACPI_LPIT=3Dy
CONFIG_ACPI_SLEEP=3Dy
# CONFIG_ACPI_PROCFS_POWER is not set
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
CONFIG_ACPI_EC_DEBUGFS=3Dy
CONFIG_ACPI_AC=3Dm
CONFIG_ACPI_BATTERY=3Dm
CONFIG_ACPI_BUTTON=3Dy
CONFIG_ACPI_VIDEO=3Dy
CONFIG_ACPI_FAN=3Dy
CONFIG_ACPI_TAD=3Dm
CONFIG_ACPI_DOCK=3Dy
CONFIG_ACPI_CPU_FREQ_PSS=3Dy
CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
CONFIG_ACPI_PROCESSOR_IDLE=3Dy
CONFIG_ACPI_CPPC_LIB=3Dy
CONFIG_ACPI_PROCESSOR=3Dy
CONFIG_ACPI_IPMI=3Dm
CONFIG_ACPI_HOTPLUG_CPU=3Dy
CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dy
CONFIG_ACPI_THERMAL=3Dy
CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
CONFIG_ACPI_TABLE_UPGRADE=3Dy
CONFIG_ACPI_DEBUG=3Dy
CONFIG_ACPI_PCI_SLOT=3Dy
CONFIG_ACPI_CONTAINER=3Dy
CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
CONFIG_ACPI_SBS=3Dm
CONFIG_ACPI_HED=3Dy
CONFIG_ACPI_CUSTOM_METHOD=3Dm
CONFIG_ACPI_BGRT=3Dy
# CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
CONFIG_ACPI_NFIT=3Dm
# CONFIG_NFIT_SECURITY_DEBUG is not set
CONFIG_ACPI_NUMA=3Dy
CONFIG_ACPI_HMAT=3Dy
CONFIG_HAVE_ACPI_APEI=3Dy
CONFIG_HAVE_ACPI_APEI_NMI=3Dy
CONFIG_ACPI_APEI=3Dy
CONFIG_ACPI_APEI_GHES=3Dy
CONFIG_ACPI_APEI_PCIEAER=3Dy
CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
CONFIG_ACPI_APEI_EINJ=3Dm
CONFIG_ACPI_APEI_ERST_DEBUG=3Dm
CONFIG_DPTF_POWER=3Dm
CONFIG_ACPI_WATCHDOG=3Dy
CONFIG_ACPI_EXTLOG=3Dm
CONFIG_ACPI_ADXL=3Dy
CONFIG_PMIC_OPREGION=3Dy
CONFIG_BYTCRC_PMIC_OPREGION=3Dy
CONFIG_CHTCRC_PMIC_OPREGION=3Dy
CONFIG_XPOWER_PMIC_OPREGION=3Dy
CONFIG_BXT_WC_PMIC_OPREGION=3Dy
CONFIG_CHT_WC_PMIC_OPREGION=3Dy
CONFIG_CHT_DC_TI_PMIC_OPREGION=3Dy
CONFIG_ACPI_CONFIGFS=3Dm
CONFIG_TPS68470_PMIC_OPREGION=3Dy
CONFIG_X86_PM_TIMER=3Dy
CONFIG_SFI=3Dy

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=3Dy
CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
CONFIG_CPU_FREQ_GOV_COMMON=3Dy
CONFIG_CPU_FREQ_STAT=3Dy
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=3Dy
CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dm
CONFIG_CPU_FREQ_GOV_USERSPACE=3Dm
CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dm
CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dm
CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=3Dm
CONFIG_CPUFREQ_DT_PLATDEV=3Dy
CONFIG_X86_INTEL_PSTATE=3Dy
CONFIG_X86_PCC_CPUFREQ=3Dm
CONFIG_X86_ACPI_CPUFREQ=3Dm
CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
CONFIG_X86_POWERNOW_K8=3Dm
CONFIG_X86_AMD_FREQ_SENSITIVITY=3Dm
# CONFIG_X86_SPEEDSTEP_CENTRINO is not set
CONFIG_X86_P4_CLOCKMOD=3Dm

#
# shared options
#
CONFIG_X86_SPEEDSTEP_LIB=3Dm
# end of CPU Frequency scaling

#
# CPU Idle
#
CONFIG_CPU_IDLE=3Dy
CONFIG_CPU_IDLE_GOV_LADDER=3Dy
CONFIG_CPU_IDLE_GOV_MENU=3Dy
CONFIG_CPU_IDLE_GOV_TEO=3Dy
CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy
CONFIG_HALTPOLL_CPUIDLE=3Dm
# end of CPU Idle

CONFIG_INTEL_IDLE=3Dy
# end of Power management and ACPI options

#
# Bus options (PCI etc.)
#
CONFIG_PCI_DIRECT=3Dy
CONFIG_PCI_MMCONFIG=3Dy
CONFIG_PCI_XEN=3Dy
CONFIG_MMCONF_FAM10H=3Dy
# CONFIG_PCI_CNB20LE_QUIRK is not set
# CONFIG_ISA_BUS is not set
CONFIG_ISA_DMA_API=3Dy
CONFIG_AMD_NB=3Dy
# CONFIG_X86_SYSFB is not set
# end of Bus options (PCI etc.)

#
# Binary Emulations
#
CONFIG_IA32_EMULATION=3Dy
# CONFIG_X86_X32 is not set
CONFIG_COMPAT_32=3Dy
CONFIG_COMPAT=3Dy
CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
CONFIG_SYSVIPC_COMPAT=3Dy
# end of Binary Emulations

#
# Firmware Drivers
#
CONFIG_EDD=3Dm
# CONFIG_EDD_OFF is not set
CONFIG_FIRMWARE_MEMMAP=3Dy
CONFIG_DMIID=3Dy
CONFIG_DMI_SYSFS=3Dm
CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
CONFIG_ISCSI_IBFT_FIND=3Dy
CONFIG_ISCSI_IBFT=3Dm
CONFIG_FW_CFG_SYSFS=3Dm
# CONFIG_FW_CFG_SYSFS_CMDLINE is not set
CONFIG_GOOGLE_FIRMWARE=3Dy
# CONFIG_GOOGLE_SMI is not set
CONFIG_GOOGLE_COREBOOT_TABLE=3Dm
CONFIG_GOOGLE_MEMCONSOLE=3Dm
# CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT=3Dm
CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=3Dm
CONFIG_GOOGLE_VPD=3Dm

#
# EFI (Extensible Firmware Interface) Support
#
# CONFIG_EFI_VARS is not set
CONFIG_EFI_ESRT=3Dy
CONFIG_EFI_RUNTIME_MAP=3Dy
# CONFIG_EFI_FAKE_MEMMAP is not set
CONFIG_EFI_SOFT_RESERVE=3Dy
CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
CONFIG_EFI_CAPSULE_LOADER=3Dm
# CONFIG_EFI_TEST is not set
CONFIG_APPLE_PROPERTIES=3Dy
# CONFIG_RESET_ATTACK_MITIGATION is not set
CONFIG_EFI_RCI2_TABLE=3Dy
# CONFIG_EFI_DISABLE_PCI_DMA is not set
# end of EFI (Extensible Firmware Interface) Support

CONFIG_UEFI_CPER=3Dy
CONFIG_UEFI_CPER_X86=3Dy
CONFIG_EFI_DEV_PATH_PARSER=3Dy
CONFIG_EFI_EARLYCON=3Dy

#
# Tegra firmware driver
#
# end of Tegra firmware driver
# end of Firmware Drivers

CONFIG_HAVE_KVM=3Dy
CONFIG_HAVE_KVM_IRQCHIP=3Dy
CONFIG_HAVE_KVM_IRQFD=3Dy
CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
CONFIG_HAVE_KVM_EVENTFD=3Dy
CONFIG_KVM_MMIO=3Dy
CONFIG_KVM_ASYNC_PF=3Dy
CONFIG_HAVE_KVM_MSI=3Dy
CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
CONFIG_KVM_VFIO=3Dy
CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
CONFIG_KVM_COMPAT=3Dy
CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
CONFIG_HAVE_KVM_NO_POLL=3Dy
CONFIG_VIRTUALIZATION=3Dy
CONFIG_KVM=3Dm
CONFIG_KVM_WERROR=3Dy
CONFIG_KVM_INTEL=3Dm
CONFIG_KVM_AMD=3Dm
CONFIG_KVM_AMD_SEV=3Dy
CONFIG_KVM_MMU_AUDIT=3Dy
CONFIG_VHOST_NET=3Dm
CONFIG_VHOST_SCSI=3Dm
CONFIG_VHOST_VSOCK=3Dm
CONFIG_VHOST=3Dm
# CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set

#
# General architecture-dependent options
#
CONFIG_CRASH_CORE=3Dy
CONFIG_KEXEC_CORE=3Dy
CONFIG_HOTPLUG_SMT=3Dy
CONFIG_OPROFILE=3Dm
# CONFIG_OPROFILE_EVENT_MULTIPLEX is not set
CONFIG_HAVE_OPROFILE=3Dy
CONFIG_OPROFILE_NMI_TIMER=3Dy
CONFIG_KPROBES=3Dy
CONFIG_JUMP_LABEL=3Dy
# CONFIG_STATIC_KEYS_SELFTEST is not set
CONFIG_OPTPROBES=3Dy
CONFIG_KPROBES_ON_FTRACE=3Dy
CONFIG_UPROBES=3Dy
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
CONFIG_KRETPROBES=3Dy
CONFIG_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_IOREMAP_PROT=3Dy
CONFIG_HAVE_KPROBES=3Dy
CONFIG_HAVE_KRETPROBES=3Dy
CONFIG_HAVE_OPTPROBES=3Dy
CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
CONFIG_HAVE_NMI=3Dy
CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
CONFIG_ARCH_HAS_SET_MEMORY=3Dy
CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
CONFIG_HAVE_ASM_MODVERSIONS=3Dy
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
CONFIG_HAVE_RSEQ=3Dy
CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
CONFIG_HAVE_CLK=3Dy
CONFIG_HAVE_HW_BREAKPOINT=3Dy
CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HAVE_PERF_REGS=3Dy
CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
CONFIG_MMU_GATHER_TABLE_FREE=3Dy
CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
CONFIG_SECCOMP_FILTER=3Dy
CONFIG_HAVE_ARCH_STACKLEAK=3Dy
CONFIG_HAVE_STACKPROTECTOR=3Dy
CONFIG_CC_HAS_STACKPROTECTOR_NONE=3Dy
CONFIG_STACKPROTECTOR=3Dy
CONFIG_STACKPROTECTOR_STRONG=3Dy
CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
CONFIG_HAVE_CONTEXT_TRACKING=3Dy
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
CONFIG_HAVE_MOVE_PMD=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
CONFIG_MODULES_USE_ELF_RELA=3Dy
CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
CONFIG_HAVE_EXIT_THREAD=3Dy
CONFIG_ARCH_MMAP_RND_BITS=3D28
CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
CONFIG_HAVE_COPY_THREAD_TLS=3Dy
CONFIG_HAVE_STACK_VALIDATION=3Dy
CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
CONFIG_ISA_BUS_API=3Dy
CONFIG_OLD_SIGSUSPEND3=3Dy
CONFIG_COMPAT_OLD_SIGACTION=3Dy
CONFIG_COMPAT_32BIT_TIME=3Dy
CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
CONFIG_VMAP_STACK=3Dy
CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
CONFIG_STRICT_KERNEL_RWX=3Dy
CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
CONFIG_STRICT_MODULE_RWX=3Dy
CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
CONFIG_LOCK_EVENT_COUNTS=3Dy
CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
# end of GCOV-based kernel profiling

CONFIG_PLUGIN_HOSTCC=3D"g++"
CONFIG_HAVE_GCC_PLUGINS=3Dy
CONFIG_GCC_PLUGINS=3Dy
# CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
# CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
# CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
# end of General architecture-dependent options

CONFIG_RT_MUTEXES=3Dy
CONFIG_BASE_SMALL=3D0
CONFIG_MODULE_SIG_FORMAT=3Dy
CONFIG_MODULES=3Dy
CONFIG_MODULE_FORCE_LOAD=3Dy
CONFIG_MODULE_UNLOAD=3Dy
CONFIG_MODULE_FORCE_UNLOAD=3Dy
# CONFIG_MODVERSIONS is not set
CONFIG_MODULE_SRCVERSION_ALL=3Dy
CONFIG_MODULE_SIG=3Dy
# CONFIG_MODULE_SIG_FORCE is not set
CONFIG_MODULE_SIG_ALL=3Dy
# CONFIG_MODULE_SIG_SHA1 is not set
# CONFIG_MODULE_SIG_SHA224 is not set
# CONFIG_MODULE_SIG_SHA256 is not set
# CONFIG_MODULE_SIG_SHA384 is not set
CONFIG_MODULE_SIG_SHA512=3Dy
CONFIG_MODULE_SIG_HASH=3D"sha512"
CONFIG_MODULE_COMPRESS=3Dy
# CONFIG_MODULE_COMPRESS_GZIP is not set
CONFIG_MODULE_COMPRESS_XZ=3Dy
CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS=3Dy
CONFIG_UNUSED_SYMBOLS=3Dy
CONFIG_MODULES_TREE_LOOKUP=3Dy
CONFIG_BLOCK=3Dy
CONFIG_BLK_RQ_ALLOC_TIME=3Dy
CONFIG_BLK_SCSI_REQUEST=3Dy
CONFIG_BLK_CGROUP_RWSTAT=3Dy
CONFIG_BLK_DEV_BSG=3Dy
CONFIG_BLK_DEV_BSGLIB=3Dy
CONFIG_BLK_DEV_INTEGRITY=3Dy
CONFIG_BLK_DEV_INTEGRITY_T10=3Dy
CONFIG_BLK_DEV_ZONED=3Dy
CONFIG_BLK_DEV_THROTTLING=3Dy
CONFIG_BLK_DEV_THROTTLING_LOW=3Dy
# CONFIG_BLK_CMDLINE_PARSER is not set
CONFIG_BLK_WBT=3Dy
CONFIG_BLK_CGROUP_IOLATENCY=3Dy
CONFIG_BLK_CGROUP_IOCOST=3Dy
CONFIG_BLK_WBT_MQ=3Dy
CONFIG_BLK_DEBUG_FS=3Dy
CONFIG_BLK_DEBUG_FS_ZONED=3Dy
CONFIG_BLK_SED_OPAL=3Dy

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=3Dy
# CONFIG_ACORN_PARTITION is not set
CONFIG_AIX_PARTITION=3Dy
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
CONFIG_MAC_PARTITION=3Dy
CONFIG_MSDOS_PARTITION=3Dy
CONFIG_BSD_DISKLABEL=3Dy
CONFIG_MINIX_SUBPARTITION=3Dy
CONFIG_SOLARIS_X86_PARTITION=3Dy
# CONFIG_UNIXWARE_DISKLABEL is not set
CONFIG_LDM_PARTITION=3Dy
# CONFIG_LDM_DEBUG is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
CONFIG_KARMA_PARTITION=3Dy
CONFIG_EFI_PARTITION=3Dy
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set
# end of Partition Types

CONFIG_BLOCK_COMPAT=3Dy
CONFIG_BLK_MQ_PCI=3Dy
CONFIG_BLK_MQ_VIRTIO=3Dy
CONFIG_BLK_MQ_RDMA=3Dy
CONFIG_BLK_PM=3Dy

#
# IO Schedulers
#
CONFIG_MQ_IOSCHED_DEADLINE=3Dy
CONFIG_MQ_IOSCHED_KYBER=3Dy
CONFIG_IOSCHED_BFQ=3Dy
CONFIG_BFQ_GROUP_IOSCHED=3Dy
# CONFIG_BFQ_CGROUP_DEBUG is not set
# end of IO Schedulers

CONFIG_PREEMPT_NOTIFIERS=3Dy
CONFIG_PADATA=3Dy
CONFIG_ASN1=3Dy
CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
CONFIG_LOCK_SPIN_ON_OWNER=3Dy
CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
CONFIG_QUEUED_SPINLOCKS=3Dy
CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
CONFIG_QUEUED_RWLOCKS=3Dy
CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
CONFIG_FREEZER=3Dy

#
# Executable file formats
#
CONFIG_BINFMT_ELF=3Dy
CONFIG_COMPAT_BINFMT_ELF=3Dy
CONFIG_ELFCORE=3Dy
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
CONFIG_BINFMT_SCRIPT=3Dy
CONFIG_BINFMT_MISC=3Dy
CONFIG_COREDUMP=3Dy
# end of Executable file formats

#
# Memory Management options
#
CONFIG_SELECT_MEMORY_MODEL=3Dy
CONFIG_SPARSEMEM_MANUAL=3Dy
CONFIG_SPARSEMEM=3Dy
CONFIG_NEED_MULTIPLE_NODES=3Dy
CONFIG_HAVE_MEMORY_PRESENT=3Dy
CONFIG_SPARSEMEM_EXTREME=3Dy
CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
CONFIG_SPARSEMEM_VMEMMAP=3Dy
CONFIG_HAVE_MEMBLOCK_NODE_MAP=3Dy
CONFIG_HAVE_FAST_GUP=3Dy
CONFIG_MEMORY_ISOLATION=3Dy
CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
CONFIG_MEMORY_HOTPLUG=3Dy
CONFIG_MEMORY_HOTPLUG_SPARSE=3Dy
CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE=3Dy
CONFIG_MEMORY_HOTREMOVE=3Dy
CONFIG_SPLIT_PTLOCK_CPUS=3D4
CONFIG_MEMORY_BALLOON=3Dy
CONFIG_BALLOON_COMPACTION=3Dy
CONFIG_COMPACTION=3Dy
CONFIG_MIGRATION=3Dy
CONFIG_CONTIG_ALLOC=3Dy
CONFIG_PHYS_ADDR_T_64BIT=3Dy
CONFIG_BOUNCE=3Dy
CONFIG_VIRT_TO_BUS=3Dy
CONFIG_MMU_NOTIFIER=3Dy
CONFIG_KSM=3Dy
CONFIG_DEFAULT_MMAP_MIN_ADDR=3D65536
CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
CONFIG_MEMORY_FAILURE=3Dy
CONFIG_HWPOISON_INJECT=3Dm
CONFIG_TRANSPARENT_HUGEPAGE=3Dy
# CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
CONFIG_ARCH_WANTS_THP_SWAP=3Dy
CONFIG_THP_SWAP=3Dy
CONFIG_TRANSPARENT_HUGE_PAGECACHE=3Dy
CONFIG_CLEANCACHE=3Dy
CONFIG_FRONTSWAP=3Dy
# CONFIG_CMA is not set
# CONFIG_MEM_SOFT_DIRTY is not set
CONFIG_ZSWAP=3Dy
CONFIG_ZPOOL=3Dy
CONFIG_ZBUD=3Dy
CONFIG_Z3FOLD=3Dy
CONFIG_ZSMALLOC=3Dy
# CONFIG_PGTABLE_MAPPING is not set
# CONFIG_ZSMALLOC_STAT is not set
CONFIG_GENERIC_EARLY_IOREMAP=3Dy
# CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
CONFIG_ZONE_DEVICE=3Dy
CONFIG_DEV_PAGEMAP_OPS=3Dy
CONFIG_HMM_MIRROR=3Dy
CONFIG_DEVICE_PRIVATE=3Dy
CONFIG_FRAME_VECTOR=3Dy
CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
CONFIG_ARCH_HAS_PKEYS=3Dy
# CONFIG_PERCPU_STATS is not set
# CONFIG_GUP_BENCHMARK is not set
CONFIG_READ_ONLY_THP_FOR_FS=3Dy
CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
CONFIG_MAPPING_DIRTY_HELPERS=3Dy
# end of Memory Management options

CONFIG_NET=3Dy
CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
CONFIG_NET_INGRESS=3Dy
CONFIG_NET_EGRESS=3Dy
CONFIG_NET_REDIRECT=3Dy
CONFIG_SKB_EXTENSIONS=3Dy

#
# Networking options
#
CONFIG_PACKET=3Dy
CONFIG_PACKET_DIAG=3Dy
CONFIG_UNIX=3Dy
CONFIG_UNIX_SCM=3Dy
CONFIG_UNIX_DIAG=3Dy
CONFIG_TLS=3Dm
CONFIG_TLS_DEVICE=3Dy
# CONFIG_TLS_TOE is not set
CONFIG_XFRM=3Dy
CONFIG_XFRM_OFFLOAD=3Dy
CONFIG_XFRM_ALGO=3Dm
CONFIG_XFRM_USER=3Dm
CONFIG_XFRM_INTERFACE=3Dm
CONFIG_XFRM_SUB_POLICY=3Dy
CONFIG_XFRM_MIGRATE=3Dy
CONFIG_XFRM_STATISTICS=3Dy
CONFIG_XFRM_IPCOMP=3Dm
CONFIG_NET_KEY=3Dm
CONFIG_NET_KEY_MIGRATE=3Dy
CONFIG_SMC=3Dm
CONFIG_SMC_DIAG=3Dm
CONFIG_XDP_SOCKETS=3Dy
CONFIG_XDP_SOCKETS_DIAG=3Dy
CONFIG_INET=3Dy
CONFIG_IP_MULTICAST=3Dy
CONFIG_IP_ADVANCED_ROUTER=3Dy
# CONFIG_IP_FIB_TRIE_STATS is not set
CONFIG_IP_MULTIPLE_TABLES=3Dy
CONFIG_IP_ROUTE_MULTIPATH=3Dy
CONFIG_IP_ROUTE_VERBOSE=3Dy
CONFIG_IP_ROUTE_CLASSID=3Dy
# CONFIG_IP_PNP is not set
CONFIG_NET_IPIP=3Dm
CONFIG_NET_IPGRE_DEMUX=3Dm
CONFIG_NET_IP_TUNNEL=3Dm
CONFIG_NET_IPGRE=3Dm
# CONFIG_NET_IPGRE_BROADCAST is not set
CONFIG_IP_MROUTE_COMMON=3Dy
CONFIG_IP_MROUTE=3Dy
CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IP_PIMSM_V1=3Dy
CONFIG_IP_PIMSM_V2=3Dy
CONFIG_SYN_COOKIES=3Dy
CONFIG_NET_IPVTI=3Dm
CONFIG_NET_UDP_TUNNEL=3Dm
CONFIG_NET_FOU=3Dm
CONFIG_NET_FOU_IP_TUNNELS=3Dy
CONFIG_INET_AH=3Dm
CONFIG_INET_ESP=3Dm
CONFIG_INET_ESP_OFFLOAD=3Dm
CONFIG_INET_ESPINTCP=3Dy
CONFIG_INET_IPCOMP=3Dm
CONFIG_INET_XFRM_TUNNEL=3Dm
CONFIG_INET_TUNNEL=3Dm
CONFIG_INET_DIAG=3Dm
CONFIG_INET_TCP_DIAG=3Dm
CONFIG_INET_UDP_DIAG=3Dm
CONFIG_INET_RAW_DIAG=3Dm
CONFIG_INET_DIAG_DESTROY=3Dy
CONFIG_TCP_CONG_ADVANCED=3Dy
CONFIG_TCP_CONG_BIC=3Dm
CONFIG_TCP_CONG_CUBIC=3Dy
CONFIG_TCP_CONG_WESTWOOD=3Dm
CONFIG_TCP_CONG_HTCP=3Dm
CONFIG_TCP_CONG_HSTCP=3Dm
CONFIG_TCP_CONG_HYBLA=3Dm
CONFIG_TCP_CONG_VEGAS=3Dm
CONFIG_TCP_CONG_NV=3Dm
CONFIG_TCP_CONG_SCALABLE=3Dm
CONFIG_TCP_CONG_LP=3Dm
CONFIG_TCP_CONG_VENO=3Dm
CONFIG_TCP_CONG_YEAH=3Dm
CONFIG_TCP_CONG_ILLINOIS=3Dm
CONFIG_TCP_CONG_DCTCP=3Dm
CONFIG_TCP_CONG_CDG=3Dm
CONFIG_TCP_CONG_BBR=3Dm
CONFIG_DEFAULT_CUBIC=3Dy
# CONFIG_DEFAULT_RENO is not set
CONFIG_DEFAULT_TCP_CONG=3D"cubic"
CONFIG_TCP_MD5SIG=3Dy
CONFIG_IPV6=3Dy
CONFIG_IPV6_ROUTER_PREF=3Dy
CONFIG_IPV6_ROUTE_INFO=3Dy
CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
CONFIG_INET6_AH=3Dm
CONFIG_INET6_ESP=3Dm
CONFIG_INET6_ESP_OFFLOAD=3Dm
CONFIG_INET6_IPCOMP=3Dm
CONFIG_IPV6_MIP6=3Dm
CONFIG_IPV6_ILA=3Dm
CONFIG_INET6_XFRM_TUNNEL=3Dm
CONFIG_INET6_TUNNEL=3Dm
CONFIG_IPV6_VTI=3Dm
CONFIG_IPV6_SIT=3Dm
CONFIG_IPV6_SIT_6RD=3Dy
CONFIG_IPV6_NDISC_NODETYPE=3Dy
CONFIG_IPV6_TUNNEL=3Dm
CONFIG_IPV6_GRE=3Dm
CONFIG_IPV6_FOU=3Dm
CONFIG_IPV6_FOU_TUNNEL=3Dm
CONFIG_IPV6_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_SUBTREES=3Dy
CONFIG_IPV6_MROUTE=3Dy
CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
CONFIG_IPV6_PIMSM_V2=3Dy
CONFIG_IPV6_SEG6_LWTUNNEL=3Dy
CONFIG_IPV6_SEG6_HMAC=3Dy
CONFIG_IPV6_SEG6_BPF=3Dy
CONFIG_NETLABEL=3Dy
CONFIG_MPTCP=3Dy
CONFIG_MPTCP_IPV6=3Dy
# CONFIG_MPTCP_HMAC_TEST is not set
CONFIG_NETWORK_SECMARK=3Dy
CONFIG_NET_PTP_CLASSIFY=3Dy
CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
CONFIG_NETFILTER=3Dy
CONFIG_NETFILTER_ADVANCED=3Dy
CONFIG_BRIDGE_NETFILTER=3Dm

#
# Core Netfilter Configuration
#
CONFIG_NETFILTER_INGRESS=3Dy
CONFIG_NETFILTER_NETLINK=3Dm
CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
CONFIG_NETFILTER_FAMILY_ARP=3Dy
CONFIG_NETFILTER_NETLINK_ACCT=3Dm
CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
CONFIG_NETFILTER_NETLINK_LOG=3Dm
CONFIG_NETFILTER_NETLINK_OSF=3Dm
CONFIG_NF_CONNTRACK=3Dm
CONFIG_NF_LOG_COMMON=3Dm
CONFIG_NF_LOG_NETDEV=3Dm
CONFIG_NETFILTER_CONNCOUNT=3Dm
CONFIG_NF_CONNTRACK_MARK=3Dy
CONFIG_NF_CONNTRACK_SECMARK=3Dy
CONFIG_NF_CONNTRACK_ZONES=3Dy
CONFIG_NF_CONNTRACK_PROCFS=3Dy
CONFIG_NF_CONNTRACK_EVENTS=3Dy
CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
CONFIG_NF_CONNTRACK_LABELS=3Dy
CONFIG_NF_CT_PROTO_DCCP=3Dy
CONFIG_NF_CT_PROTO_GRE=3Dy
CONFIG_NF_CT_PROTO_SCTP=3Dy
CONFIG_NF_CT_PROTO_UDPLITE=3Dy
CONFIG_NF_CONNTRACK_AMANDA=3Dm
CONFIG_NF_CONNTRACK_FTP=3Dm
CONFIG_NF_CONNTRACK_H323=3Dm
CONFIG_NF_CONNTRACK_IRC=3Dm
CONFIG_NF_CONNTRACK_BROADCAST=3Dm
CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
CONFIG_NF_CONNTRACK_SNMP=3Dm
CONFIG_NF_CONNTRACK_PPTP=3Dm
CONFIG_NF_CONNTRACK_SANE=3Dm
CONFIG_NF_CONNTRACK_SIP=3Dm
CONFIG_NF_CONNTRACK_TFTP=3Dm
CONFIG_NF_CT_NETLINK=3Dm
CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
CONFIG_NF_CT_NETLINK_HELPER=3Dm
CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
CONFIG_NF_NAT=3Dm
CONFIG_NF_NAT_AMANDA=3Dm
CONFIG_NF_NAT_FTP=3Dm
CONFIG_NF_NAT_IRC=3Dm
CONFIG_NF_NAT_SIP=3Dm
CONFIG_NF_NAT_TFTP=3Dm
CONFIG_NF_NAT_REDIRECT=3Dy
CONFIG_NF_NAT_MASQUERADE=3Dy
CONFIG_NETFILTER_SYNPROXY=3Dm
CONFIG_NF_TABLES=3Dm
CONFIG_NF_TABLES_SET=3Dm
CONFIG_NF_TABLES_INET=3Dy
CONFIG_NF_TABLES_NETDEV=3Dy
CONFIG_NFT_NUMGEN=3Dm
CONFIG_NFT_CT=3Dm
CONFIG_NFT_FLOW_OFFLOAD=3Dm
CONFIG_NFT_COUNTER=3Dm
CONFIG_NFT_CONNLIMIT=3Dm
CONFIG_NFT_LOG=3Dm
CONFIG_NFT_LIMIT=3Dm
CONFIG_NFT_MASQ=3Dm
CONFIG_NFT_REDIR=3Dm
CONFIG_NFT_NAT=3Dm
CONFIG_NFT_TUNNEL=3Dm
CONFIG_NFT_OBJREF=3Dm
CONFIG_NFT_QUEUE=3Dm
CONFIG_NFT_QUOTA=3Dm
CONFIG_NFT_REJECT=3Dm
CONFIG_NFT_REJECT_INET=3Dm
CONFIG_NFT_COMPAT=3Dm
CONFIG_NFT_HASH=3Dm
CONFIG_NFT_FIB=3Dm
CONFIG_NFT_FIB_INET=3Dm
CONFIG_NFT_XFRM=3Dm
CONFIG_NFT_SOCKET=3Dm
CONFIG_NFT_OSF=3Dm
CONFIG_NFT_TPROXY=3Dm
CONFIG_NFT_SYNPROXY=3Dm
CONFIG_NF_DUP_NETDEV=3Dm
CONFIG_NFT_DUP_NETDEV=3Dm
CONFIG_NFT_FWD_NETDEV=3Dm
CONFIG_NFT_FIB_NETDEV=3Dm
CONFIG_NF_FLOW_TABLE_INET=3Dm
CONFIG_NF_FLOW_TABLE=3Dm
CONFIG_NETFILTER_XTABLES=3Dm

#
# Xtables combined modules
#
CONFIG_NETFILTER_XT_MARK=3Dm
CONFIG_NETFILTER_XT_CONNMARK=3Dm
CONFIG_NETFILTER_XT_SET=3Dm

#
# Xtables targets
#
CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_CT=3Dm
CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
CONFIG_NETFILTER_XT_TARGET_HL=3Dm
CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
CONFIG_NETFILTER_XT_TARGET_LED=3Dm
CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
CONFIG_NETFILTER_XT_NAT=3Dm
CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm

#
# Xtables matches
#
CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
CONFIG_NETFILTER_XT_MATCH_HL=3Dm
CONFIG_NETFILTER_XT_MATCH_IPCOMP=3Dm
CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
CONFIG_NETFILTER_XT_MATCH_L2TP=3Dm
CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dm
CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
CONFIG_NETFILTER_XT_MATCH_TIME=3Dm
CONFIG_NETFILTER_XT_MATCH_U32=3Dm
# end of Core Netfilter Configuration

CONFIG_IP_SET=3Dm
CONFIG_IP_SET_MAX=3D256
CONFIG_IP_SET_BITMAP_IP=3Dm
CONFIG_IP_SET_BITMAP_IPMAC=3Dm
CONFIG_IP_SET_BITMAP_PORT=3Dm
CONFIG_IP_SET_HASH_IP=3Dm
CONFIG_IP_SET_HASH_IPMARK=3Dm
CONFIG_IP_SET_HASH_IPPORT=3Dm
CONFIG_IP_SET_HASH_IPPORTIP=3Dm
CONFIG_IP_SET_HASH_IPPORTNET=3Dm
CONFIG_IP_SET_HASH_IPMAC=3Dm
CONFIG_IP_SET_HASH_MAC=3Dm
CONFIG_IP_SET_HASH_NETPORTNET=3Dm
CONFIG_IP_SET_HASH_NET=3Dm
CONFIG_IP_SET_HASH_NETNET=3Dm
CONFIG_IP_SET_HASH_NETPORT=3Dm
CONFIG_IP_SET_HASH_NETIFACE=3Dm
CONFIG_IP_SET_LIST_SET=3Dm
CONFIG_IP_VS=3Dm
CONFIG_IP_VS_IPV6=3Dy
# CONFIG_IP_VS_DEBUG is not set
CONFIG_IP_VS_TAB_BITS=3D15

#
# IPVS transport protocol load balancing support
#
CONFIG_IP_VS_PROTO_TCP=3Dy
CONFIG_IP_VS_PROTO_UDP=3Dy
CONFIG_IP_VS_PROTO_AH_ESP=3Dy
CONFIG_IP_VS_PROTO_ESP=3Dy
CONFIG_IP_VS_PROTO_AH=3Dy
CONFIG_IP_VS_PROTO_SCTP=3Dy

#
# IPVS scheduler
#
CONFIG_IP_VS_RR=3Dm
CONFIG_IP_VS_WRR=3Dm
CONFIG_IP_VS_LC=3Dm
CONFIG_IP_VS_WLC=3Dm
CONFIG_IP_VS_FO=3Dm
CONFIG_IP_VS_OVF=3Dm
CONFIG_IP_VS_LBLC=3Dm
CONFIG_IP_VS_LBLCR=3Dm
CONFIG_IP_VS_DH=3Dm
CONFIG_IP_VS_SH=3Dm
CONFIG_IP_VS_MH=3Dm
CONFIG_IP_VS_SED=3Dm
CONFIG_IP_VS_NQ=3Dm

#
# IPVS SH scheduler
#
CONFIG_IP_VS_SH_TAB_BITS=3D8

#
# IPVS MH scheduler
#
CONFIG_IP_VS_MH_TAB_INDEX=3D12

#
# IPVS application helper
#
CONFIG_IP_VS_FTP=3Dm
CONFIG_IP_VS_NFCT=3Dy
CONFIG_IP_VS_PE_SIP=3Dm

#
# IP: Netfilter Configuration
#
CONFIG_NF_DEFRAG_IPV4=3Dm
CONFIG_NF_SOCKET_IPV4=3Dm
CONFIG_NF_TPROXY_IPV4=3Dm
CONFIG_NF_TABLES_IPV4=3Dy
CONFIG_NFT_REJECT_IPV4=3Dm
CONFIG_NFT_DUP_IPV4=3Dm
CONFIG_NFT_FIB_IPV4=3Dm
CONFIG_NF_TABLES_ARP=3Dy
CONFIG_NF_FLOW_TABLE_IPV4=3Dm
CONFIG_NF_DUP_IPV4=3Dm
CONFIG_NF_LOG_ARP=3Dm
CONFIG_NF_LOG_IPV4=3Dm
CONFIG_NF_REJECT_IPV4=3Dm
CONFIG_NF_NAT_SNMP_BASIC=3Dm
CONFIG_NF_NAT_PPTP=3Dm
CONFIG_NF_NAT_H323=3Dm
CONFIG_IP_NF_IPTABLES=3Dm
CONFIG_IP_NF_MATCH_AH=3Dm
CONFIG_IP_NF_MATCH_ECN=3Dm
CONFIG_IP_NF_MATCH_RPFILTER=3Dm
CONFIG_IP_NF_MATCH_TTL=3Dm
CONFIG_IP_NF_FILTER=3Dm
CONFIG_IP_NF_TARGET_REJECT=3Dm
CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
CONFIG_IP_NF_NAT=3Dm
CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP_NF_TARGET_NETMAP=3Dm
CONFIG_IP_NF_TARGET_REDIRECT=3Dm
CONFIG_IP_NF_MANGLE=3Dm
CONFIG_IP_NF_TARGET_CLUSTERIP=3Dm
CONFIG_IP_NF_TARGET_ECN=3Dm
CONFIG_IP_NF_TARGET_TTL=3Dm
CONFIG_IP_NF_RAW=3Dm
CONFIG_IP_NF_SECURITY=3Dm
CONFIG_IP_NF_ARPTABLES=3Dm
CONFIG_IP_NF_ARPFILTER=3Dm
CONFIG_IP_NF_ARP_MANGLE=3Dm
# end of IP: Netfilter Configuration

#
# IPv6: Netfilter Configuration
#
CONFIG_NF_SOCKET_IPV6=3Dm
CONFIG_NF_TPROXY_IPV6=3Dm
CONFIG_NF_TABLES_IPV6=3Dy
CONFIG_NFT_REJECT_IPV6=3Dm
CONFIG_NFT_DUP_IPV6=3Dm
CONFIG_NFT_FIB_IPV6=3Dm
CONFIG_NF_FLOW_TABLE_IPV6=3Dm
CONFIG_NF_DUP_IPV6=3Dm
CONFIG_NF_REJECT_IPV6=3Dm
CONFIG_NF_LOG_IPV6=3Dm
CONFIG_IP6_NF_IPTABLES=3Dm
CONFIG_IP6_NF_MATCH_AH=3Dm
CONFIG_IP6_NF_MATCH_EUI64=3Dm
CONFIG_IP6_NF_MATCH_FRAG=3Dm
CONFIG_IP6_NF_MATCH_OPTS=3Dm
CONFIG_IP6_NF_MATCH_HL=3Dm
CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
CONFIG_IP6_NF_MATCH_MH=3Dm
CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
CONFIG_IP6_NF_MATCH_RT=3Dm
CONFIG_IP6_NF_MATCH_SRH=3Dm
CONFIG_IP6_NF_TARGET_HL=3Dm
CONFIG_IP6_NF_FILTER=3Dm
CONFIG_IP6_NF_TARGET_REJECT=3Dm
CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
CONFIG_IP6_NF_MANGLE=3Dm
CONFIG_IP6_NF_RAW=3Dm
CONFIG_IP6_NF_SECURITY=3Dm
CONFIG_IP6_NF_NAT=3Dm
CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
CONFIG_IP6_NF_TARGET_NPT=3Dm
# end of IPv6: Netfilter Configuration

CONFIG_NF_DEFRAG_IPV6=3Dm
CONFIG_NF_TABLES_BRIDGE=3Dm
CONFIG_NFT_BRIDGE_META=3Dm
CONFIG_NFT_BRIDGE_REJECT=3Dm
CONFIG_NF_LOG_BRIDGE=3Dm
CONFIG_NF_CONNTRACK_BRIDGE=3Dm
CONFIG_BRIDGE_NF_EBTABLES=3Dm
CONFIG_BRIDGE_EBT_BROUTE=3Dm
CONFIG_BRIDGE_EBT_T_FILTER=3Dm
CONFIG_BRIDGE_EBT_T_NAT=3Dm
CONFIG_BRIDGE_EBT_802_3=3Dm
CONFIG_BRIDGE_EBT_AMONG=3Dm
CONFIG_BRIDGE_EBT_ARP=3Dm
CONFIG_BRIDGE_EBT_IP=3Dm
CONFIG_BRIDGE_EBT_IP6=3Dm
CONFIG_BRIDGE_EBT_LIMIT=3Dm
CONFIG_BRIDGE_EBT_MARK=3Dm
CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
CONFIG_BRIDGE_EBT_STP=3Dm
CONFIG_BRIDGE_EBT_VLAN=3Dm
CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
CONFIG_BRIDGE_EBT_DNAT=3Dm
CONFIG_BRIDGE_EBT_MARK_T=3Dm
CONFIG_BRIDGE_EBT_REDIRECT=3Dm
CONFIG_BRIDGE_EBT_SNAT=3Dm
CONFIG_BRIDGE_EBT_LOG=3Dm
CONFIG_BRIDGE_EBT_NFLOG=3Dm
# CONFIG_BPFILTER is not set
CONFIG_IP_DCCP=3Dm
CONFIG_INET_DCCP_DIAG=3Dm

#
# DCCP CCIDs Configuration
#
# CONFIG_IP_DCCP_CCID2_DEBUG is not set
CONFIG_IP_DCCP_CCID3=3Dy
# CONFIG_IP_DCCP_CCID3_DEBUG is not set
CONFIG_IP_DCCP_TFRC_LIB=3Dy
# end of DCCP CCIDs Configuration

#
# DCCP Kernel Hacking
#
# CONFIG_IP_DCCP_DEBUG is not set
# end of DCCP Kernel Hacking

CONFIG_IP_SCTP=3Dm
# CONFIG_SCTP_DBG_OBJCNT is not set
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
# CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
CONFIG_INET_SCTP_DIAG=3Dm
CONFIG_RDS=3Dm
CONFIG_RDS_RDMA=3Dm
CONFIG_RDS_TCP=3Dm
# CONFIG_RDS_DEBUG is not set
CONFIG_TIPC=3Dm
CONFIG_TIPC_MEDIA_IB=3Dy
CONFIG_TIPC_MEDIA_UDP=3Dy
CONFIG_TIPC_CRYPTO=3Dy
CONFIG_TIPC_DIAG=3Dm
CONFIG_ATM=3Dm
CONFIG_ATM_CLIP=3Dm
# CONFIG_ATM_CLIP_NO_ICMP is not set
CONFIG_ATM_LANE=3Dm
CONFIG_ATM_MPOA=3Dm
CONFIG_ATM_BR2684=3Dm
# CONFIG_ATM_BR2684_IPFILTER is not set
CONFIG_L2TP=3Dm
# CONFIG_L2TP_DEBUGFS is not set
CONFIG_L2TP_V3=3Dy
CONFIG_L2TP_IP=3Dm
CONFIG_L2TP_ETH=3Dm
CONFIG_STP=3Dm
CONFIG_GARP=3Dm
CONFIG_MRP=3Dm
CONFIG_BRIDGE=3Dm
CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
CONFIG_BRIDGE_VLAN_FILTERING=3Dy
CONFIG_HAVE_NET_DSA=3Dy
CONFIG_NET_DSA=3Dm
CONFIG_NET_DSA_TAG_8021Q=3Dm
CONFIG_NET_DSA_TAG_AR9331=3Dm
CONFIG_NET_DSA_TAG_BRCM_COMMON=3Dm
CONFIG_NET_DSA_TAG_BRCM=3Dm
CONFIG_NET_DSA_TAG_BRCM_PREPEND=3Dm
CONFIG_NET_DSA_TAG_GSWIP=3Dm
CONFIG_NET_DSA_TAG_DSA=3Dm
CONFIG_NET_DSA_TAG_EDSA=3Dm
CONFIG_NET_DSA_TAG_MTK=3Dm
CONFIG_NET_DSA_TAG_KSZ=3Dm
CONFIG_NET_DSA_TAG_OCELOT=3Dm
CONFIG_NET_DSA_TAG_QCA=3Dm
CONFIG_NET_DSA_TAG_LAN9303=3Dm
CONFIG_NET_DSA_TAG_SJA1105=3Dm
CONFIG_NET_DSA_TAG_TRAILER=3Dm
CONFIG_VLAN_8021Q=3Dm
CONFIG_VLAN_8021Q_GVRP=3Dy
CONFIG_VLAN_8021Q_MVRP=3Dy
# CONFIG_DECNET is not set
CONFIG_LLC=3Dm
CONFIG_LLC2=3Dm
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
CONFIG_PHONET=3Dm
CONFIG_6LOWPAN=3Dm
# CONFIG_6LOWPAN_DEBUGFS is not set
CONFIG_6LOWPAN_NHC=3Dm
CONFIG_6LOWPAN_NHC_DEST=3Dm
CONFIG_6LOWPAN_NHC_FRAGMENT=3Dm
CONFIG_6LOWPAN_NHC_HOP=3Dm
CONFIG_6LOWPAN_NHC_IPV6=3Dm
CONFIG_6LOWPAN_NHC_MOBILITY=3Dm
CONFIG_6LOWPAN_NHC_ROUTING=3Dm
CONFIG_6LOWPAN_NHC_UDP=3Dm
CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=3Dm
CONFIG_6LOWPAN_GHC_UDP=3Dm
CONFIG_6LOWPAN_GHC_ICMPV6=3Dm
CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=3Dm
CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=3Dm
CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=3Dm
CONFIG_IEEE802154=3Dm
CONFIG_IEEE802154_NL802154_EXPERIMENTAL=3Dy
CONFIG_IEEE802154_SOCKET=3Dm
CONFIG_IEEE802154_6LOWPAN=3Dm
CONFIG_MAC802154=3Dm
CONFIG_NET_SCHED=3Dy

#
# Queueing/Scheduling
#
CONFIG_NET_SCH_CBQ=3Dm
CONFIG_NET_SCH_HTB=3Dm
CONFIG_NET_SCH_HFSC=3Dm
CONFIG_NET_SCH_ATM=3Dm
CONFIG_NET_SCH_PRIO=3Dm
CONFIG_NET_SCH_MULTIQ=3Dm
CONFIG_NET_SCH_RED=3Dm
CONFIG_NET_SCH_SFB=3Dm
CONFIG_NET_SCH_SFQ=3Dm
CONFIG_NET_SCH_TEQL=3Dm
CONFIG_NET_SCH_TBF=3Dm
CONFIG_NET_SCH_CBS=3Dm
CONFIG_NET_SCH_ETF=3Dm
CONFIG_NET_SCH_TAPRIO=3Dm
CONFIG_NET_SCH_GRED=3Dm
CONFIG_NET_SCH_DSMARK=3Dm
CONFIG_NET_SCH_NETEM=3Dm
CONFIG_NET_SCH_DRR=3Dm
CONFIG_NET_SCH_MQPRIO=3Dm
CONFIG_NET_SCH_SKBPRIO=3Dm
CONFIG_NET_SCH_CHOKE=3Dm
CONFIG_NET_SCH_QFQ=3Dm
CONFIG_NET_SCH_CODEL=3Dm
CONFIG_NET_SCH_FQ_CODEL=3Dy
CONFIG_NET_SCH_CAKE=3Dm
CONFIG_NET_SCH_FQ=3Dm
CONFIG_NET_SCH_HHF=3Dm
CONFIG_NET_SCH_PIE=3Dm
CONFIG_NET_SCH_FQ_PIE=3Dm
CONFIG_NET_SCH_INGRESS=3Dm
CONFIG_NET_SCH_PLUG=3Dm
CONFIG_NET_SCH_ETS=3Dm
CONFIG_NET_SCH_DEFAULT=3Dy
# CONFIG_DEFAULT_FQ is not set
# CONFIG_DEFAULT_CODEL is not set
CONFIG_DEFAULT_FQ_CODEL=3Dy
# CONFIG_DEFAULT_SFQ is not set
# CONFIG_DEFAULT_PFIFO_FAST is not set
CONFIG_DEFAULT_NET_SCH=3D"fq_codel"

#
# Classification
#
CONFIG_NET_CLS=3Dy
CONFIG_NET_CLS_BASIC=3Dm
CONFIG_NET_CLS_TCINDEX=3Dm
CONFIG_NET_CLS_ROUTE4=3Dm
CONFIG_NET_CLS_FW=3Dm
CONFIG_NET_CLS_U32=3Dm
CONFIG_CLS_U32_PERF=3Dy
CONFIG_CLS_U32_MARK=3Dy
CONFIG_NET_CLS_RSVP=3Dm
CONFIG_NET_CLS_RSVP6=3Dm
CONFIG_NET_CLS_FLOW=3Dm
CONFIG_NET_CLS_CGROUP=3Dm
CONFIG_NET_CLS_BPF=3Dm
CONFIG_NET_CLS_FLOWER=3Dm
CONFIG_NET_CLS_MATCHALL=3Dm
CONFIG_NET_EMATCH=3Dy
CONFIG_NET_EMATCH_STACK=3D32
CONFIG_NET_EMATCH_CMP=3Dm
CONFIG_NET_EMATCH_NBYTE=3Dm
CONFIG_NET_EMATCH_U32=3Dm
CONFIG_NET_EMATCH_META=3Dm
CONFIG_NET_EMATCH_TEXT=3Dm
CONFIG_NET_EMATCH_CANID=3Dm
CONFIG_NET_EMATCH_IPSET=3Dm
CONFIG_NET_EMATCH_IPT=3Dm
CONFIG_NET_CLS_ACT=3Dy
CONFIG_NET_ACT_POLICE=3Dm
CONFIG_NET_ACT_GACT=3Dm
CONFIG_GACT_PROB=3Dy
CONFIG_NET_ACT_MIRRED=3Dm
CONFIG_NET_ACT_SAMPLE=3Dm
CONFIG_NET_ACT_IPT=3Dm
CONFIG_NET_ACT_NAT=3Dm
CONFIG_NET_ACT_PEDIT=3Dm
CONFIG_NET_ACT_SIMP=3Dm
CONFIG_NET_ACT_SKBEDIT=3Dm
CONFIG_NET_ACT_CSUM=3Dm
CONFIG_NET_ACT_MPLS=3Dm
CONFIG_NET_ACT_VLAN=3Dm
CONFIG_NET_ACT_BPF=3Dm
CONFIG_NET_ACT_CONNMARK=3Dm
CONFIG_NET_ACT_CTINFO=3Dm
CONFIG_NET_ACT_SKBMOD=3Dm
CONFIG_NET_ACT_IFE=3Dm
CONFIG_NET_ACT_TUNNEL_KEY=3Dm
CONFIG_NET_ACT_CT=3Dm
CONFIG_NET_IFE_SKBMARK=3Dm
CONFIG_NET_IFE_SKBPRIO=3Dm
CONFIG_NET_IFE_SKBTCINDEX=3Dm
CONFIG_NET_TC_SKB_EXT=3Dy
CONFIG_NET_SCH_FIFO=3Dy
CONFIG_DCB=3Dy
CONFIG_DNS_RESOLVER=3Dm
CONFIG_BATMAN_ADV=3Dm
CONFIG_BATMAN_ADV_BATMAN_V=3Dy
CONFIG_BATMAN_ADV_BLA=3Dy
CONFIG_BATMAN_ADV_DAT=3Dy
CONFIG_BATMAN_ADV_NC=3Dy
CONFIG_BATMAN_ADV_MCAST=3Dy
CONFIG_BATMAN_ADV_DEBUGFS=3Dy
# CONFIG_BATMAN_ADV_DEBUG is not set
CONFIG_BATMAN_ADV_SYSFS=3Dy
# CONFIG_BATMAN_ADV_TRACING is not set
CONFIG_OPENVSWITCH=3Dm
CONFIG_OPENVSWITCH_GRE=3Dm
CONFIG_OPENVSWITCH_VXLAN=3Dm
CONFIG_OPENVSWITCH_GENEVE=3Dm
CONFIG_VSOCKETS=3Dm
CONFIG_VSOCKETS_DIAG=3Dm
CONFIG_VSOCKETS_LOOPBACK=3Dm
CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
CONFIG_VIRTIO_VSOCKETS=3Dm
CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
CONFIG_HYPERV_VSOCKETS=3Dm
CONFIG_NETLINK_DIAG=3Dm
CONFIG_MPLS=3Dy
CONFIG_NET_MPLS_GSO=3Dm
CONFIG_MPLS_ROUTING=3Dm
CONFIG_MPLS_IPTUNNEL=3Dm
CONFIG_NET_NSH=3Dm
CONFIG_HSR=3Dm
CONFIG_NET_SWITCHDEV=3Dy
CONFIG_NET_L3_MASTER_DEV=3Dy
CONFIG_NET_NCSI=3Dy
CONFIG_NCSI_OEM_CMD_GET_MAC=3Dy
CONFIG_RPS=3Dy
CONFIG_RFS_ACCEL=3Dy
CONFIG_XPS=3Dy
CONFIG_CGROUP_NET_PRIO=3Dy
CONFIG_CGROUP_NET_CLASSID=3Dy
CONFIG_NET_RX_BUSY_POLL=3Dy
CONFIG_BQL=3Dy
CONFIG_BPF_JIT=3Dy
CONFIG_BPF_STREAM_PARSER=3Dy
CONFIG_NET_FLOW_LIMIT=3Dy

#
# Network testing
#
CONFIG_NET_PKTGEN=3Dm
CONFIG_NET_DROP_MONITOR=3Dy
# end of Network testing
# end of Networking options

CONFIG_HAMRADIO=3Dy

#
# Packet Radio protocols
#
CONFIG_AX25=3Dm
CONFIG_AX25_DAMA_SLAVE=3Dy
CONFIG_NETROM=3Dm
CONFIG_ROSE=3Dm

#
# AX.25 network device drivers
#
CONFIG_MKISS=3Dm
CONFIG_6PACK=3Dm
CONFIG_BPQETHER=3Dm
CONFIG_BAYCOM_SER_FDX=3Dm
CONFIG_BAYCOM_SER_HDX=3Dm
CONFIG_BAYCOM_PAR=3Dm
CONFIG_YAM=3Dm
# end of AX.25 network device drivers

CONFIG_CAN=3Dm
CONFIG_CAN_RAW=3Dm
CONFIG_CAN_BCM=3Dm
CONFIG_CAN_GW=3Dm
CONFIG_CAN_J1939=3Dm

#
# CAN Device Drivers
#
CONFIG_CAN_VCAN=3Dm
CONFIG_CAN_VXCAN=3Dm
CONFIG_CAN_SLCAN=3Dm
CONFIG_CAN_DEV=3Dm
CONFIG_CAN_CALC_BITTIMING=3Dy
CONFIG_CAN_FLEXCAN=3Dm
CONFIG_CAN_GRCAN=3Dm
CONFIG_CAN_JANZ_ICAN3=3Dm
CONFIG_CAN_KVASER_PCIEFD=3Dm
CONFIG_CAN_C_CAN=3Dm
CONFIG_CAN_C_CAN_PLATFORM=3Dm
CONFIG_CAN_C_CAN_PCI=3Dm
CONFIG_CAN_CC770=3Dm
# CONFIG_CAN_CC770_ISA is not set
CONFIG_CAN_CC770_PLATFORM=3Dm
CONFIG_CAN_IFI_CANFD=3Dm
CONFIG_CAN_M_CAN=3Dm
CONFIG_CAN_M_CAN_PLATFORM=3Dm
CONFIG_CAN_M_CAN_TCAN4X5X=3Dm
CONFIG_CAN_PEAK_PCIEFD=3Dm
CONFIG_CAN_SJA1000=3Dm
CONFIG_CAN_EMS_PCI=3Dm
# CONFIG_CAN_EMS_PCMCIA is not set
CONFIG_CAN_F81601=3Dm
CONFIG_CAN_KVASER_PCI=3Dm
CONFIG_CAN_PEAK_PCI=3Dm
CONFIG_CAN_PEAK_PCIEC=3Dy
CONFIG_CAN_PEAK_PCMCIA=3Dm
CONFIG_CAN_PLX_PCI=3Dm
# CONFIG_CAN_SJA1000_ISA is not set
CONFIG_CAN_SJA1000_PLATFORM=3Dm
CONFIG_CAN_SOFTING=3Dm
CONFIG_CAN_SOFTING_CS=3Dm

#
# CAN SPI interfaces
#
CONFIG_CAN_HI311X=3Dm
CONFIG_CAN_MCP251X=3Dm
# end of CAN SPI interfaces

#
# CAN USB interfaces
#
CONFIG_CAN_8DEV_USB=3Dm
CONFIG_CAN_EMS_USB=3Dm
CONFIG_CAN_ESD_USB2=3Dm
CONFIG_CAN_GS_USB=3Dm
CONFIG_CAN_KVASER_USB=3Dm
CONFIG_CAN_MCBA_USB=3Dm
CONFIG_CAN_PEAK_USB=3Dm
CONFIG_CAN_UCAN=3Dm
# end of CAN USB interfaces

# CONFIG_CAN_DEBUG_DEVICES is not set
# end of CAN Device Drivers

CONFIG_BT=3Dm
CONFIG_BT_BREDR=3Dy
CONFIG_BT_RFCOMM=3Dm
CONFIG_BT_RFCOMM_TTY=3Dy
CONFIG_BT_BNEP=3Dm
CONFIG_BT_BNEP_MC_FILTER=3Dy
CONFIG_BT_BNEP_PROTO_FILTER=3Dy
CONFIG_BT_CMTP=3Dm
CONFIG_BT_HIDP=3Dm
CONFIG_BT_HS=3Dy
CONFIG_BT_LE=3Dy
CONFIG_BT_6LOWPAN=3Dm
CONFIG_BT_LEDS=3Dy
# CONFIG_BT_SELFTEST is not set
CONFIG_BT_DEBUGFS=3Dy

#
# Bluetooth device drivers
#
CONFIG_BT_INTEL=3Dm
CONFIG_BT_BCM=3Dm
CONFIG_BT_RTL=3Dm
CONFIG_BT_QCA=3Dm
CONFIG_BT_HCIBTUSB=3Dm
CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy
CONFIG_BT_HCIBTUSB_BCM=3Dy
CONFIG_BT_HCIBTUSB_MTK=3Dy
CONFIG_BT_HCIBTUSB_RTL=3Dy
CONFIG_BT_HCIBTSDIO=3Dm
CONFIG_BT_HCIUART=3Dm
CONFIG_BT_HCIUART_SERDEV=3Dy
CONFIG_BT_HCIUART_H4=3Dy
CONFIG_BT_HCIUART_NOKIA=3Dm
CONFIG_BT_HCIUART_BCSP=3Dy
CONFIG_BT_HCIUART_ATH3K=3Dy
CONFIG_BT_HCIUART_LL=3Dy
CONFIG_BT_HCIUART_3WIRE=3Dy
CONFIG_BT_HCIUART_INTEL=3Dy
CONFIG_BT_HCIUART_BCM=3Dy
CONFIG_BT_HCIUART_RTL=3Dy
CONFIG_BT_HCIUART_QCA=3Dy
CONFIG_BT_HCIUART_AG6XX=3Dy
CONFIG_BT_HCIUART_MRVL=3Dy
CONFIG_BT_HCIBCM203X=3Dm
CONFIG_BT_HCIBPA10X=3Dm
CONFIG_BT_HCIBFUSB=3Dm
CONFIG_BT_HCIDTL1=3Dm
CONFIG_BT_HCIBT3C=3Dm
CONFIG_BT_HCIBLUECARD=3Dm
CONFIG_BT_HCIVHCI=3Dm
CONFIG_BT_MRVL=3Dm
CONFIG_BT_MRVL_SDIO=3Dm
CONFIG_BT_ATH3K=3Dm
CONFIG_BT_MTKSDIO=3Dm
CONFIG_BT_MTKUART=3Dm
CONFIG_BT_HCIRSI=3Dm
# end of Bluetooth device drivers

CONFIG_AF_RXRPC=3Dm
CONFIG_AF_RXRPC_IPV6=3Dy
# CONFIG_AF_RXRPC_INJECT_LOSS is not set
CONFIG_AF_RXRPC_DEBUG=3Dy
CONFIG_RXKAD=3Dy
CONFIG_AF_KCM=3Dm
CONFIG_STREAM_PARSER=3Dy
CONFIG_FIB_RULES=3Dy
CONFIG_WIRELESS=3Dy
CONFIG_WIRELESS_EXT=3Dy
CONFIG_WEXT_CORE=3Dy
CONFIG_WEXT_PROC=3Dy
CONFIG_WEXT_SPY=3Dy
CONFIG_WEXT_PRIV=3Dy
CONFIG_CFG80211=3Dm
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_CERTIFICATION_ONUS is not set
CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
CONFIG_CFG80211_DEFAULT_PS=3Dy
CONFIG_CFG80211_DEBUGFS=3Dy
CONFIG_CFG80211_CRDA_SUPPORT=3Dy
CONFIG_CFG80211_WEXT=3Dy
CONFIG_CFG80211_WEXT_EXPORT=3Dy
CONFIG_LIB80211=3Dm
CONFIG_LIB80211_CRYPT_WEP=3Dm
CONFIG_LIB80211_CRYPT_CCMP=3Dm
CONFIG_LIB80211_CRYPT_TKIP=3Dm
# CONFIG_LIB80211_DEBUG is not set
CONFIG_MAC80211=3Dm
CONFIG_MAC80211_HAS_RC=3Dy
CONFIG_MAC80211_RC_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
CONFIG_MAC80211_MESH=3Dy
CONFIG_MAC80211_LEDS=3Dy
CONFIG_MAC80211_DEBUGFS=3Dy
# CONFIG_MAC80211_MESSAGE_TRACING is not set
# CONFIG_MAC80211_DEBUG_MENU is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
CONFIG_WIMAX=3Dm
CONFIG_WIMAX_DEBUG_LEVEL=3D8
CONFIG_RFKILL=3Dm
CONFIG_RFKILL_LEDS=3Dy
CONFIG_RFKILL_INPUT=3Dy
CONFIG_RFKILL_GPIO=3Dm
CONFIG_NET_9P=3Dm
CONFIG_NET_9P_VIRTIO=3Dm
CONFIG_NET_9P_XEN=3Dm
CONFIG_NET_9P_RDMA=3Dm
# CONFIG_NET_9P_DEBUG is not set
CONFIG_CAIF=3Dm
# CONFIG_CAIF_DEBUG is not set
CONFIG_CAIF_NETDEV=3Dm
CONFIG_CAIF_USB=3Dm
CONFIG_CEPH_LIB=3Dm
CONFIG_CEPH_LIB_PRETTYDEBUG=3Dy
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
CONFIG_NFC=3Dm
CONFIG_NFC_DIGITAL=3Dm
CONFIG_NFC_NCI=3Dm
CONFIG_NFC_NCI_SPI=3Dm
CONFIG_NFC_NCI_UART=3Dm
CONFIG_NFC_HCI=3Dm
CONFIG_NFC_SHDLC=3Dy

#
# Near Field Communication (NFC) devices
#
CONFIG_NFC_TRF7970A=3Dm
CONFIG_NFC_MEI_PHY=3Dm
CONFIG_NFC_SIM=3Dm
CONFIG_NFC_PORT100=3Dm
CONFIG_NFC_FDP=3Dm
CONFIG_NFC_FDP_I2C=3Dm
CONFIG_NFC_PN544=3Dm
CONFIG_NFC_PN544_I2C=3Dm
CONFIG_NFC_PN544_MEI=3Dm
CONFIG_NFC_PN533=3Dm
CONFIG_NFC_PN533_USB=3Dm
CONFIG_NFC_PN533_I2C=3Dm
CONFIG_NFC_PN532_UART=3Dm
CONFIG_NFC_MICROREAD=3Dm
CONFIG_NFC_MICROREAD_I2C=3Dm
CONFIG_NFC_MICROREAD_MEI=3Dm
CONFIG_NFC_MRVL=3Dm
CONFIG_NFC_MRVL_USB=3Dm
CONFIG_NFC_MRVL_UART=3Dm
CONFIG_NFC_MRVL_I2C=3Dm
CONFIG_NFC_MRVL_SPI=3Dm
CONFIG_NFC_ST21NFCA=3Dm
CONFIG_NFC_ST21NFCA_I2C=3Dm
CONFIG_NFC_ST_NCI=3Dm
CONFIG_NFC_ST_NCI_I2C=3Dm
CONFIG_NFC_ST_NCI_SPI=3Dm
CONFIG_NFC_NXP_NCI=3Dm
CONFIG_NFC_NXP_NCI_I2C=3Dm
CONFIG_NFC_S3FWRN5=3Dm
CONFIG_NFC_S3FWRN5_I2C=3Dm
CONFIG_NFC_ST95HF=3Dm
# end of Near Field Communication (NFC) devices

CONFIG_PSAMPLE=3Dm
CONFIG_NET_IFE=3Dm
CONFIG_LWTUNNEL=3Dy
CONFIG_LWTUNNEL_BPF=3Dy
CONFIG_DST_CACHE=3Dy
CONFIG_GRO_CELLS=3Dy
CONFIG_SOCK_VALIDATE_XMIT=3Dy
CONFIG_NET_SOCK_MSG=3Dy
CONFIG_NET_DEVLINK=3Dy
CONFIG_PAGE_POOL=3Dy
CONFIG_FAILOVER=3Dm
CONFIG_ETHTOOL_NETLINK=3Dy
CONFIG_HAVE_EBPF_JIT=3Dy

#
# Device Drivers
#
CONFIG_HAVE_EISA=3Dy
# CONFIG_EISA is not set
CONFIG_HAVE_PCI=3Dy
CONFIG_PCI=3Dy
CONFIG_PCI_DOMAINS=3Dy
CONFIG_PCIEPORTBUS=3Dy
CONFIG_HOTPLUG_PCI_PCIE=3Dy
CONFIG_PCIEAER=3Dy
# CONFIG_PCIEAER_INJECT is not set
CONFIG_PCIE_ECRC=3Dy
CONFIG_PCIEASPM=3Dy
CONFIG_PCIEASPM_DEFAULT=3Dy
# CONFIG_PCIEASPM_POWERSAVE is not set
# CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
# CONFIG_PCIEASPM_PERFORMANCE is not set
CONFIG_PCIE_PME=3Dy
CONFIG_PCIE_DPC=3Dy
CONFIG_PCIE_PTM=3Dy
# CONFIG_PCIE_BW is not set
CONFIG_PCI_MSI=3Dy
CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
CONFIG_PCI_QUIRKS=3Dy
# CONFIG_PCI_DEBUG is not set
CONFIG_PCI_REALLOC_ENABLE_AUTO=3Dy
CONFIG_PCI_STUB=3Dy
CONFIG_PCI_PF_STUB=3Dm
CONFIG_XEN_PCIDEV_FRONTEND=3Dm
CONFIG_PCI_ATS=3Dy
CONFIG_PCI_ECAM=3Dy
CONFIG_PCI_LOCKLESS_CONFIG=3Dy
CONFIG_PCI_IOV=3Dy
CONFIG_PCI_PRI=3Dy
CONFIG_PCI_PASID=3Dy
CONFIG_PCI_P2PDMA=3Dy
CONFIG_PCI_LABEL=3Dy
CONFIG_PCI_HYPERV=3Dm
CONFIG_HOTPLUG_PCI=3Dy
CONFIG_HOTPLUG_PCI_ACPI=3Dy
CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
CONFIG_HOTPLUG_PCI_CPCI=3Dy
CONFIG_HOTPLUG_PCI_CPCI_ZT5550=3Dm
CONFIG_HOTPLUG_PCI_CPCI_GENERIC=3Dm
CONFIG_HOTPLUG_PCI_SHPC=3Dy

#
# PCI controller drivers
#
CONFIG_PCI_FTPCI100=3Dy
CONFIG_PCI_HOST_COMMON=3Dy
CONFIG_PCI_HOST_GENERIC=3Dy
CONFIG_PCIE_XILINX=3Dy
CONFIG_VMD=3Dm
CONFIG_PCI_HYPERV_INTERFACE=3Dm

#
# DesignWare PCI Core Support
#
CONFIG_PCIE_DW=3Dy
CONFIG_PCIE_DW_HOST=3Dy
CONFIG_PCIE_DW_EP=3Dy
CONFIG_PCIE_DW_PLAT=3Dy
CONFIG_PCIE_DW_PLAT_HOST=3Dy
CONFIG_PCIE_DW_PLAT_EP=3Dy
CONFIG_PCIE_INTEL_GW=3Dy
CONFIG_PCI_MESON=3Dy
# end of DesignWare PCI Core Support

#
# Cadence PCIe controllers support
#
CONFIG_PCIE_CADENCE=3Dy
CONFIG_PCIE_CADENCE_HOST=3Dy
CONFIG_PCIE_CADENCE_EP=3Dy
CONFIG_PCIE_CADENCE_PLAT=3Dy
CONFIG_PCIE_CADENCE_PLAT_HOST=3Dy
CONFIG_PCIE_CADENCE_PLAT_EP=3Dy
# end of Cadence PCIe controllers support
# end of PCI controller drivers

#
# PCI Endpoint
#
CONFIG_PCI_ENDPOINT=3Dy
CONFIG_PCI_ENDPOINT_CONFIGFS=3Dy
# CONFIG_PCI_EPF_TEST is not set
# end of PCI Endpoint

#
# PCI switch controller drivers
#
CONFIG_PCI_SW_SWITCHTEC=3Dm
# end of PCI switch controller drivers

CONFIG_PCCARD=3Dm
CONFIG_PCMCIA=3Dm
CONFIG_PCMCIA_LOAD_CIS=3Dy
CONFIG_CARDBUS=3Dy

#
# PC-card bridges
#
CONFIG_YENTA=3Dm
CONFIG_YENTA_O2=3Dy
CONFIG_YENTA_RICOH=3Dy
CONFIG_YENTA_TI=3Dy
CONFIG_YENTA_ENE_TUNE=3Dy
CONFIG_YENTA_TOSHIBA=3Dy
CONFIG_PD6729=3Dm
CONFIG_I82092=3Dm
CONFIG_PCCARD_NONSTATIC=3Dy
CONFIG_RAPIDIO=3Dm
CONFIG_RAPIDIO_TSI721=3Dm
CONFIG_RAPIDIO_DISC_TIMEOUT=3D30
CONFIG_RAPIDIO_ENABLE_RX_TX_PORTS=3Dy
CONFIG_RAPIDIO_DMA_ENGINE=3Dy
# CONFIG_RAPIDIO_DEBUG is not set
CONFIG_RAPIDIO_ENUM_BASIC=3Dm
CONFIG_RAPIDIO_CHMAN=3Dm
CONFIG_RAPIDIO_MPORT_CDEV=3Dm

#
# RapidIO Switch drivers
#
CONFIG_RAPIDIO_TSI57X=3Dm
CONFIG_RAPIDIO_CPS_XX=3Dm
CONFIG_RAPIDIO_TSI568=3Dm
CONFIG_RAPIDIO_CPS_GEN2=3Dm
CONFIG_RAPIDIO_RXS_GEN3=3Dm
# end of RapidIO Switch drivers

#
# Generic Driver Options
#
# CONFIG_UEVENT_HELPER is not set
CONFIG_DEVTMPFS=3Dy
CONFIG_DEVTMPFS_MOUNT=3Dy
CONFIG_STANDALONE=3Dy
CONFIG_PREVENT_FIRMWARE_BUILD=3Dy

#
# Firmware loader
#
CONFIG_FW_LOADER=3Dy
CONFIG_FW_LOADER_PAGED_BUF=3Dy
CONFIG_EXTRA_FIRMWARE=3D""
# CONFIG_FW_LOADER_USER_HELPER is not set
CONFIG_FW_LOADER_COMPRESS=3Dy
CONFIG_FW_CACHE=3Dy
# end of Firmware loader

CONFIG_WANT_DEV_COREDUMP=3Dy
CONFIG_ALLOW_DEV_COREDUMP=3Dy
CONFIG_DEV_COREDUMP=3Dy
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
CONFIG_HMEM_REPORTING=3Dy
# CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
CONFIG_SYS_HYPERVISOR=3Dy
CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
CONFIG_REGMAP=3Dy
CONFIG_REGMAP_I2C=3Dy
CONFIG_REGMAP_SLIMBUS=3Dm
CONFIG_REGMAP_SPI=3Dy
CONFIG_REGMAP_SPMI=3Dm
CONFIG_REGMAP_W1=3Dm
CONFIG_REGMAP_MMIO=3Dy
CONFIG_REGMAP_IRQ=3Dy
CONFIG_REGMAP_SOUNDWIRE=3Dm
CONFIG_REGMAP_SCCB=3Dm
CONFIG_REGMAP_I3C=3Dm
CONFIG_DMA_SHARED_BUFFER=3Dy
# CONFIG_DMA_FENCE_TRACE is not set
# end of Generic Driver Options

#
# Bus devices
#
CONFIG_MOXTET=3Dm
CONFIG_SIMPLE_PM_BUS=3Dy
# end of Bus devices

CONFIG_CONNECTOR=3Dy
CONFIG_PROC_EVENTS=3Dy
CONFIG_GNSS=3Dm
CONFIG_GNSS_SERIAL=3Dm
CONFIG_GNSS_MTK_SERIAL=3Dm
CONFIG_GNSS_SIRF_SERIAL=3Dm
CONFIG_GNSS_UBX_SERIAL=3Dm
CONFIG_MTD=3Dm
CONFIG_MTD_TESTS=3Dm

#
# Partition parsers
#
CONFIG_MTD_AR7_PARTS=3Dm
CONFIG_MTD_CMDLINE_PARTS=3Dm
CONFIG_MTD_OF_PARTS=3Dm
CONFIG_MTD_REDBOOT_PARTS=3Dm
CONFIG_MTD_REDBOOT_DIRECTORY_BLOCK=3D-1
# CONFIG_MTD_REDBOOT_PARTS_UNALLOCATED is not set
# CONFIG_MTD_REDBOOT_PARTS_READONLY is not set
# end of Partition parsers

#
# User Modules And Translation Layers
#
CONFIG_MTD_BLKDEVS=3Dm
CONFIG_MTD_BLOCK=3Dm
CONFIG_MTD_BLOCK_RO=3Dm
CONFIG_FTL=3Dm
CONFIG_NFTL=3Dm
CONFIG_NFTL_RW=3Dy
CONFIG_INFTL=3Dm
CONFIG_RFD_FTL=3Dm
CONFIG_SSFDC=3Dm
CONFIG_SM_FTL=3Dm
CONFIG_MTD_OOPS=3Dm
CONFIG_MTD_SWAP=3Dm
CONFIG_MTD_PARTITIONED_MASTER=3Dy

#
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=3Dm
CONFIG_MTD_JEDECPROBE=3Dm
CONFIG_MTD_GEN_PROBE=3Dm
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
CONFIG_MTD_CFI_I1=3Dy
CONFIG_MTD_CFI_I2=3Dy
CONFIG_MTD_CFI_INTELEXT=3Dm
CONFIG_MTD_CFI_AMDSTD=3Dm
CONFIG_MTD_CFI_STAA=3Dm
CONFIG_MTD_CFI_UTIL=3Dm
CONFIG_MTD_RAM=3Dm
CONFIG_MTD_ROM=3Dm
CONFIG_MTD_ABSENT=3Dm
# end of RAM/ROM/Flash chip drivers

#
# Mapping drivers for chip access
#
CONFIG_MTD_COMPLEX_MAPPINGS=3Dy
CONFIG_MTD_PHYSMAP=3Dm
# CONFIG_MTD_PHYSMAP_COMPAT is not set
CONFIG_MTD_PHYSMAP_OF=3Dy
CONFIG_MTD_PHYSMAP_VERSATILE=3Dy
CONFIG_MTD_PHYSMAP_GEMINI=3Dy
CONFIG_MTD_PHYSMAP_GPIO_ADDR=3Dy
CONFIG_MTD_SBC_GXX=3Dm
CONFIG_MTD_AMD76XROM=3Dm
CONFIG_MTD_ICHXROM=3Dm
CONFIG_MTD_ESB2ROM=3Dm
CONFIG_MTD_CK804XROM=3Dm
CONFIG_MTD_SCB2_FLASH=3Dm
CONFIG_MTD_NETtel=3Dm
CONFIG_MTD_L440GX=3Dm
CONFIG_MTD_PCI=3Dm
CONFIG_MTD_PCMCIA=3Dm
# CONFIG_MTD_PCMCIA_ANONYMOUS is not set
CONFIG_MTD_INTEL_VR_NOR=3Dm
CONFIG_MTD_PLATRAM=3Dm
# end of Mapping drivers for chip access

#
# Self-contained MTD device drivers
#
CONFIG_MTD_PMC551=3Dm
# CONFIG_MTD_PMC551_BUGFIX is not set
# CONFIG_MTD_PMC551_DEBUG is not set
CONFIG_MTD_DATAFLASH=3Dm
# CONFIG_MTD_DATAFLASH_WRITE_VERIFY is not set
CONFIG_MTD_DATAFLASH_OTP=3Dy
CONFIG_MTD_MCHP23K256=3Dm
CONFIG_MTD_SST25L=3Dm
CONFIG_MTD_SLRAM=3Dm
CONFIG_MTD_PHRAM=3Dm
CONFIG_MTD_MTDRAM=3Dm
CONFIG_MTDRAM_TOTAL_SIZE=3D4096
CONFIG_MTDRAM_ERASE_SIZE=3D128
CONFIG_MTD_BLOCK2MTD=3Dm

#
# Disk-On-Chip Device Drivers
#
CONFIG_MTD_DOCG3=3Dm
CONFIG_BCH_CONST_M=3D14
CONFIG_BCH_CONST_T=3D4
# end of Self-contained MTD device drivers

CONFIG_MTD_NAND_CORE=3Dm
CONFIG_MTD_ONENAND=3Dm
# CONFIG_MTD_ONENAND_VERIFY_WRITE is not set
CONFIG_MTD_ONENAND_GENERIC=3Dm
CONFIG_MTD_ONENAND_OTP=3Dy
CONFIG_MTD_ONENAND_2X_PROGRAM=3Dy
CONFIG_MTD_NAND_ECC_SW_HAMMING=3Dm
CONFIG_MTD_NAND_ECC_SW_HAMMING_SMC=3Dy
CONFIG_MTD_RAW_NAND=3Dm
CONFIG_MTD_NAND_ECC_SW_BCH=3Dy

#
# Raw/parallel NAND flash controllers
#
CONFIG_MTD_NAND_DENALI=3Dm
CONFIG_MTD_NAND_DENALI_PCI=3Dm
CONFIG_MTD_NAND_DENALI_DT=3Dm
CONFIG_MTD_NAND_CAFE=3Dm
CONFIG_MTD_NAND_MXIC=3Dm
CONFIG_MTD_NAND_GPIO=3Dm
CONFIG_MTD_NAND_PLATFORM=3Dm
CONFIG_MTD_NAND_CADENCE=3Dm

#
# Misc
#
CONFIG_MTD_SM_COMMON=3Dm
CONFIG_MTD_NAND_NANDSIM=3Dm
CONFIG_MTD_NAND_RICOH=3Dm
CONFIG_MTD_NAND_DISKONCHIP=3Dm
# CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADVANCED is not set
CONFIG_MTD_NAND_DISKONCHIP_PROBE_ADDRESS=3D0
CONFIG_MTD_NAND_DISKONCHIP_BBTWRITE=3Dy
CONFIG_MTD_SPI_NAND=3Dm

#
# LPDDR & LPDDR2 PCM memory drivers
#
CONFIG_MTD_LPDDR=3Dm
CONFIG_MTD_QINFO_PROBE=3Dm
# end of LPDDR & LPDDR2 PCM memory drivers

CONFIG_MTD_SPI_NOR=3Dm
CONFIG_MTD_SPI_NOR_USE_4K_SECTORS=3Dy
CONFIG_SPI_MTK_QUADSPI=3Dm
CONFIG_SPI_INTEL_SPI=3Dm
CONFIG_SPI_INTEL_SPI_PCI=3Dm
CONFIG_SPI_INTEL_SPI_PLATFORM=3Dm
CONFIG_MTD_UBI=3Dm
CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
CONFIG_MTD_UBI_BEB_LIMIT=3D20
CONFIG_MTD_UBI_FASTMAP=3Dy
CONFIG_MTD_UBI_GLUEBI=3Dm
CONFIG_MTD_UBI_BLOCK=3Dy
CONFIG_MTD_HYPERBUS=3Dm
CONFIG_DTC=3Dy
CONFIG_OF=3Dy
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=3Dy
CONFIG_OF_KOBJ=3Dy
CONFIG_OF_DYNAMIC=3Dy
CONFIG_OF_ADDRESS=3Dy
CONFIG_OF_IRQ=3Dy
CONFIG_OF_NET=3Dy
CONFIG_OF_MDIO=3Dm
CONFIG_OF_RESOLVE=3Dy
CONFIG_OF_OVERLAY=3Dy
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
CONFIG_PARPORT=3Dm
CONFIG_PARPORT_PC=3Dm
CONFIG_PARPORT_SERIAL=3Dm
CONFIG_PARPORT_PC_FIFO=3Dy
CONFIG_PARPORT_PC_SUPERIO=3Dy
CONFIG_PARPORT_PC_PCMCIA=3Dm
CONFIG_PARPORT_AX88796=3Dm
CONFIG_PARPORT_1284=3Dy
CONFIG_PARPORT_NOT_PC=3Dy
CONFIG_PNP=3Dy
CONFIG_PNP_DEBUG_MESSAGES=3Dy

#
# Protocols
#
CONFIG_PNPACPI=3Dy
CONFIG_BLK_DEV=3Dy
# CONFIG_BLK_DEV_NULL_BLK is not set
CONFIG_BLK_DEV_FD=3Dm
CONFIG_CDROM=3Dm
# CONFIG_PARIDE is not set
CONFIG_BLK_DEV_PCIESSD_MTIP32XX=3Dm
CONFIG_ZRAM=3Dm
CONFIG_ZRAM_WRITEBACK=3Dy
# CONFIG_ZRAM_MEMORY_TRACKING is not set
CONFIG_BLK_DEV_UMEM=3Dm
CONFIG_BLK_DEV_LOOP=3Dm
CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D8
CONFIG_BLK_DEV_CRYPTOLOOP=3Dm
CONFIG_BLK_DEV_DRBD=3Dm
# CONFIG_DRBD_FAULT_INJECTION is not set
CONFIG_BLK_DEV_NBD=3Dm
CONFIG_BLK_DEV_SKD=3Dm
CONFIG_BLK_DEV_SX8=3Dm
CONFIG_BLK_DEV_RAM=3Dm
CONFIG_BLK_DEV_RAM_COUNT=3D16
CONFIG_BLK_DEV_RAM_SIZE=3D16384
CONFIG_CDROM_PKTCDVD=3Dm
CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
# CONFIG_CDROM_PKTCDVD_WCACHE is not set
CONFIG_ATA_OVER_ETH=3Dm
CONFIG_XEN_BLKDEV_FRONTEND=3Dm
CONFIG_XEN_BLKDEV_BACKEND=3Dm
CONFIG_VIRTIO_BLK=3Dm
CONFIG_BLK_DEV_RBD=3Dm
CONFIG_BLK_DEV_RSXX=3Dm

#
# NVME Support
#
CONFIG_NVME_CORE=3Dy
CONFIG_BLK_DEV_NVME=3Dy
CONFIG_NVME_MULTIPATH=3Dy
CONFIG_NVME_HWMON=3Dy
CONFIG_NVME_FABRICS=3Dm
CONFIG_NVME_RDMA=3Dm
CONFIG_NVME_FC=3Dm
CONFIG_NVME_TCP=3Dm
CONFIG_NVME_TARGET=3Dm
CONFIG_NVME_TARGET_LOOP=3Dm
CONFIG_NVME_TARGET_RDMA=3Dm
CONFIG_NVME_TARGET_FC=3Dm
CONFIG_NVME_TARGET_FCLOOP=3Dm
CONFIG_NVME_TARGET_TCP=3Dm
# end of NVME Support

#
# Misc devices
#
CONFIG_SENSORS_LIS3LV02D=3Dm
CONFIG_AD525X_DPOT=3Dm
CONFIG_AD525X_DPOT_I2C=3Dm
CONFIG_AD525X_DPOT_SPI=3Dm
# CONFIG_DUMMY_IRQ is not set
CONFIG_IBM_ASM=3Dm
CONFIG_PHANTOM=3Dm
CONFIG_TIFM_CORE=3Dm
CONFIG_TIFM_7XX1=3Dm
CONFIG_ICS932S401=3Dm
CONFIG_ENCLOSURE_SERVICES=3Dm
CONFIG_HP_ILO=3Dm
CONFIG_APDS9802ALS=3Dm
CONFIG_ISL29003=3Dm
CONFIG_ISL29020=3Dm
CONFIG_SENSORS_TSL2550=3Dm
CONFIG_SENSORS_BH1770=3Dm
CONFIG_SENSORS_APDS990X=3Dm
CONFIG_HMC6352=3Dm
CONFIG_DS1682=3Dm
CONFIG_VMWARE_BALLOON=3Dm
CONFIG_LATTICE_ECP3_CONFIG=3Dm
# CONFIG_SRAM is not set
CONFIG_PCI_ENDPOINT_TEST=3Dm
CONFIG_XILINX_SDFEC=3Dm
CONFIG_MISC_RTSX=3Dm
CONFIG_PVPANIC=3Dm
CONFIG_C2PORT=3Dm
CONFIG_C2PORT_DURAMAR_2150=3Dm

#
# EEPROM support
#
CONFIG_EEPROM_AT24=3Dm
# CONFIG_EEPROM_AT25 is not set
CONFIG_EEPROM_LEGACY=3Dm
CONFIG_EEPROM_MAX6875=3Dm
CONFIG_EEPROM_93CX6=3Dm
# CONFIG_EEPROM_93XX46 is not set
CONFIG_EEPROM_IDT_89HPESX=3Dm
CONFIG_EEPROM_EE1004=3Dm
# end of EEPROM support

CONFIG_CB710_CORE=3Dm
# CONFIG_CB710_DEBUG is not set
CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy

#
# Texas Instruments shared transport line discipline
#
CONFIG_TI_ST=3Dm
# end of Texas Instruments shared transport line discipline

CONFIG_SENSORS_LIS3_I2C=3Dm
CONFIG_ALTERA_STAPL=3Dm
CONFIG_INTEL_MEI=3Dm
CONFIG_INTEL_MEI_ME=3Dm
CONFIG_INTEL_MEI_TXE=3Dm
CONFIG_INTEL_MEI_HDCP=3Dm
CONFIG_VMWARE_VMCI=3Dm

#
# Intel MIC & related support
#
CONFIG_INTEL_MIC_BUS=3Dm
CONFIG_SCIF_BUS=3Dm
CONFIG_VOP_BUS=3Dm
CONFIG_INTEL_MIC_HOST=3Dm
CONFIG_INTEL_MIC_CARD=3Dm
CONFIG_SCIF=3Dm
CONFIG_MIC_COSM=3Dm
CONFIG_VOP=3Dm
CONFIG_VHOST_RING=3Dm
# end of Intel MIC & related support

CONFIG_GENWQE=3Dm
CONFIG_GENWQE_PLATFORM_ERROR_RECOVERY=3D0
CONFIG_ECHO=3Dm
CONFIG_MISC_ALCOR_PCI=3Dm
CONFIG_MISC_RTSX_PCI=3Dm
CONFIG_MISC_RTSX_USB=3Dm
CONFIG_HABANA_AI=3Dm
# end of Misc devices

CONFIG_HAVE_IDE=3Dy
# CONFIG_IDE is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=3Dy
CONFIG_RAID_ATTRS=3Dm
CONFIG_SCSI=3Dy
CONFIG_SCSI_DMA=3Dy
CONFIG_SCSI_NETLINK=3Dy
CONFIG_SCSI_PROC_FS=3Dy

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=3Dy
CONFIG_CHR_DEV_ST=3Dm
CONFIG_BLK_DEV_SR=3Dm
CONFIG_BLK_DEV_SR_VENDOR=3Dy
CONFIG_CHR_DEV_SG=3Dm
CONFIG_CHR_DEV_SCH=3Dm
CONFIG_SCSI_ENCLOSURE=3Dm
CONFIG_SCSI_CONSTANTS=3Dy
CONFIG_SCSI_LOGGING=3Dy
CONFIG_SCSI_SCAN_ASYNC=3Dy

#
# SCSI Transports
#
CONFIG_SCSI_SPI_ATTRS=3Dm
CONFIG_SCSI_FC_ATTRS=3Dm
CONFIG_SCSI_ISCSI_ATTRS=3Dm
CONFIG_SCSI_SAS_ATTRS=3Dm
CONFIG_SCSI_SAS_LIBSAS=3Dm
CONFIG_SCSI_SAS_ATA=3Dy
CONFIG_SCSI_SAS_HOST_SMP=3Dy
CONFIG_SCSI_SRP_ATTRS=3Dm
# end of SCSI Transports

CONFIG_SCSI_LOWLEVEL=3Dy
CONFIG_ISCSI_TCP=3Dm
CONFIG_ISCSI_BOOT_SYSFS=3Dm
CONFIG_SCSI_CXGB3_ISCSI=3Dm
CONFIG_SCSI_CXGB4_ISCSI=3Dm
CONFIG_SCSI_BNX2_ISCSI=3Dm
CONFIG_SCSI_BNX2X_FCOE=3Dm
CONFIG_BE2ISCSI=3Dm
CONFIG_BLK_DEV_3W_XXXX_RAID=3Dm
CONFIG_SCSI_HPSA=3Dm
CONFIG_SCSI_3W_9XXX=3Dm
CONFIG_SCSI_3W_SAS=3Dm
CONFIG_SCSI_ACARD=3Dm
CONFIG_SCSI_AACRAID=3Dm
CONFIG_SCSI_AIC7XXX=3Dm
CONFIG_AIC7XXX_CMDS_PER_DEVICE=3D32
CONFIG_AIC7XXX_RESET_DELAY_MS=3D15000
CONFIG_AIC7XXX_DEBUG_ENABLE=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC7XXX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC79XX=3Dm
CONFIG_AIC79XX_CMDS_PER_DEVICE=3D32
CONFIG_AIC79XX_RESET_DELAY_MS=3D15000
CONFIG_AIC79XX_DEBUG_ENABLE=3Dy
CONFIG_AIC79XX_DEBUG_MASK=3D0
CONFIG_AIC79XX_REG_PRETTY_PRINT=3Dy
CONFIG_SCSI_AIC94XX=3Dm
CONFIG_AIC94XX_DEBUG=3Dy
CONFIG_SCSI_MVSAS=3Dm
CONFIG_SCSI_MVSAS_DEBUG=3Dy
CONFIG_SCSI_MVSAS_TASKLET=3Dy
CONFIG_SCSI_MVUMI=3Dm
CONFIG_SCSI_DPT_I2O=3Dm
CONFIG_SCSI_ADVANSYS=3Dm
CONFIG_SCSI_ARCMSR=3Dm
CONFIG_SCSI_ESAS2R=3Dm
CONFIG_MEGARAID_NEWGEN=3Dy
CONFIG_MEGARAID_MM=3Dm
CONFIG_MEGARAID_MAILBOX=3Dm
CONFIG_MEGARAID_LEGACY=3Dm
CONFIG_MEGARAID_SAS=3Dm
CONFIG_SCSI_MPT3SAS=3Dm
CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
CONFIG_SCSI_MPT2SAS=3Dm
CONFIG_SCSI_SMARTPQI=3Dm
CONFIG_SCSI_UFSHCD=3Dm
CONFIG_SCSI_UFSHCD_PCI=3Dm
# CONFIG_SCSI_UFS_DWC_TC_PCI is not set
CONFIG_SCSI_UFSHCD_PLATFORM=3Dm
CONFIG_SCSI_UFS_CDNS_PLATFORM=3Dm
# CONFIG_SCSI_UFS_DWC_TC_PLATFORM is not set
CONFIG_SCSI_UFS_BSG=3Dy
CONFIG_SCSI_HPTIOP=3Dm
CONFIG_SCSI_BUSLOGIC=3Dm
CONFIG_SCSI_FLASHPOINT=3Dy
CONFIG_SCSI_MYRB=3Dm
CONFIG_SCSI_MYRS=3Dm
CONFIG_VMWARE_PVSCSI=3Dm
CONFIG_XEN_SCSI_FRONTEND=3Dm
CONFIG_HYPERV_STORAGE=3Dm
CONFIG_LIBFC=3Dm
CONFIG_LIBFCOE=3Dm
CONFIG_FCOE=3Dm
CONFIG_FCOE_FNIC=3Dm
CONFIG_SCSI_SNIC=3Dm
# CONFIG_SCSI_SNIC_DEBUG_FS is not set
CONFIG_SCSI_DMX3191D=3Dm
CONFIG_SCSI_FDOMAIN=3Dm
CONFIG_SCSI_FDOMAIN_PCI=3Dm
CONFIG_SCSI_GDTH=3Dm
CONFIG_SCSI_ISCI=3Dm
CONFIG_SCSI_IPS=3Dm
CONFIG_SCSI_INITIO=3Dm
CONFIG_SCSI_INIA100=3Dm
CONFIG_SCSI_PPA=3Dm
CONFIG_SCSI_IMM=3Dm
# CONFIG_SCSI_IZIP_EPP16 is not set
# CONFIG_SCSI_IZIP_SLOW_CTR is not set
CONFIG_SCSI_STEX=3Dm
CONFIG_SCSI_SYM53C8XX_2=3Dm
CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=3D1
CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=3D16
CONFIG_SCSI_SYM53C8XX_MAX_TAGS=3D64
CONFIG_SCSI_SYM53C8XX_MMIO=3Dy
CONFIG_SCSI_IPR=3Dm
CONFIG_SCSI_IPR_TRACE=3Dy
CONFIG_SCSI_IPR_DUMP=3Dy
CONFIG_SCSI_QLOGIC_1280=3Dm
CONFIG_SCSI_QLA_FC=3Dm
CONFIG_TCM_QLA2XXX=3Dm
# CONFIG_TCM_QLA2XXX_DEBUG is not set
CONFIG_SCSI_QLA_ISCSI=3Dm
CONFIG_QEDI=3Dm
CONFIG_QEDF=3Dm
CONFIG_SCSI_LPFC=3Dm
# CONFIG_SCSI_LPFC_DEBUG_FS is not set
CONFIG_SCSI_DC395x=3Dm
CONFIG_SCSI_AM53C974=3Dm
CONFIG_SCSI_WD719X=3Dm
CONFIG_SCSI_DEBUG=3Dm
CONFIG_SCSI_PMCRAID=3Dm
CONFIG_SCSI_PM8001=3Dm
CONFIG_SCSI_BFA_FC=3Dm
CONFIG_SCSI_VIRTIO=3Dm
CONFIG_SCSI_CHELSIO_FCOE=3Dm
CONFIG_SCSI_LOWLEVEL_PCMCIA=3Dy
CONFIG_PCMCIA_AHA152X=3Dm
CONFIG_PCMCIA_FDOMAIN=3Dm
CONFIG_PCMCIA_QLOGIC=3Dm
CONFIG_PCMCIA_SYM53C500=3Dm
CONFIG_SCSI_DH=3Dy
CONFIG_SCSI_DH_RDAC=3Dm
CONFIG_SCSI_DH_HP_SW=3Dm
CONFIG_SCSI_DH_EMC=3Dm
CONFIG_SCSI_DH_ALUA=3Dm
# end of SCSI device support

CONFIG_ATA=3Dy
CONFIG_ATA_VERBOSE_ERROR=3Dy
CONFIG_ATA_ACPI=3Dy
CONFIG_SATA_ZPODD=3Dy
CONFIG_SATA_PMP=3Dy

#
# Controllers with non-SFF native interface
#
CONFIG_SATA_AHCI=3Dy
CONFIG_SATA_MOBILE_LPM_POLICY=3D3
CONFIG_SATA_AHCI_PLATFORM=3Dm
CONFIG_AHCI_CEVA=3Dm
CONFIG_AHCI_QORIQ=3Dm
CONFIG_SATA_INIC162X=3Dm
CONFIG_SATA_ACARD_AHCI=3Dm
CONFIG_SATA_SIL24=3Dm
CONFIG_ATA_SFF=3Dy

#
# SFF controllers with custom DMA interface
#
CONFIG_PDC_ADMA=3Dm
CONFIG_SATA_QSTOR=3Dm
CONFIG_SATA_SX4=3Dm
CONFIG_ATA_BMDMA=3Dy

#
# SATA SFF controllers with BMDMA
#
CONFIG_ATA_PIIX=3Dm
CONFIG_SATA_DWC=3Dm
# CONFIG_SATA_DWC_OLD_DMA is not set
# CONFIG_SATA_DWC_DEBUG is not set
CONFIG_SATA_MV=3Dm
CONFIG_SATA_NV=3Dm
CONFIG_SATA_PROMISE=3Dm
CONFIG_SATA_SIL=3Dm
CONFIG_SATA_SIS=3Dm
CONFIG_SATA_SVW=3Dm
CONFIG_SATA_ULI=3Dm
CONFIG_SATA_VIA=3Dm
CONFIG_SATA_VITESSE=3Dm

#
# PATA SFF controllers with BMDMA
#
CONFIG_PATA_ALI=3Dm
CONFIG_PATA_AMD=3Dm
CONFIG_PATA_ARTOP=3Dm
CONFIG_PATA_ATIIXP=3Dm
CONFIG_PATA_ATP867X=3Dm
CONFIG_PATA_CMD64X=3Dm
CONFIG_PATA_CYPRESS=3Dm
CONFIG_PATA_EFAR=3Dm
CONFIG_PATA_HPT366=3Dm
CONFIG_PATA_HPT37X=3Dm
CONFIG_PATA_HPT3X2N=3Dm
CONFIG_PATA_HPT3X3=3Dm
CONFIG_PATA_HPT3X3_DMA=3Dy
CONFIG_PATA_IT8213=3Dm
CONFIG_PATA_IT821X=3Dm
CONFIG_PATA_JMICRON=3Dm
CONFIG_PATA_MARVELL=3Dm
CONFIG_PATA_NETCELL=3Dm
CONFIG_PATA_NINJA32=3Dm
CONFIG_PATA_NS87415=3Dm
CONFIG_PATA_OLDPIIX=3Dm
CONFIG_PATA_OPTIDMA=3Dm
CONFIG_PATA_PDC2027X=3Dm
CONFIG_PATA_PDC_OLD=3Dm
CONFIG_PATA_RADISYS=3Dm
CONFIG_PATA_RDC=3Dm
CONFIG_PATA_SCH=3Dm
CONFIG_PATA_SERVERWORKS=3Dm
CONFIG_PATA_SIL680=3Dm
CONFIG_PATA_SIS=3Dm
CONFIG_PATA_TOSHIBA=3Dm
CONFIG_PATA_TRIFLEX=3Dm
CONFIG_PATA_VIA=3Dm
CONFIG_PATA_WINBOND=3Dm

#
# PIO-only SFF controllers
#
CONFIG_PATA_CMD640_PCI=3Dm
CONFIG_PATA_MPIIX=3Dm
CONFIG_PATA_NS87410=3Dm
CONFIG_PATA_OPTI=3Dm
CONFIG_PATA_PCMCIA=3Dm
# CONFIG_PATA_PLATFORM is not set
CONFIG_PATA_RZ1000=3Dm

#
# Generic fallback / legacy drivers
#
CONFIG_PATA_ACPI=3Dm
CONFIG_ATA_GENERIC=3Dm
CONFIG_PATA_LEGACY=3Dm
CONFIG_MD=3Dy
CONFIG_BLK_DEV_MD=3Dm
CONFIG_MD_LINEAR=3Dm
CONFIG_MD_RAID0=3Dm
CONFIG_MD_RAID1=3Dm
CONFIG_MD_RAID10=3Dm
CONFIG_MD_RAID456=3Dm
CONFIG_MD_MULTIPATH=3Dm
CONFIG_MD_FAULTY=3Dm
CONFIG_MD_CLUSTER=3Dm
CONFIG_BCACHE=3Dm
# CONFIG_BCACHE_DEBUG is not set
# CONFIG_BCACHE_CLOSURES_DEBUG is not set
CONFIG_BLK_DEV_DM_BUILTIN=3Dy
CONFIG_BLK_DEV_DM=3Dm
CONFIG_DM_DEBUG=3Dy
CONFIG_DM_BUFIO=3Dm
# CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
CONFIG_DM_BIO_PRISON=3Dm
CONFIG_DM_PERSISTENT_DATA=3Dm
CONFIG_DM_UNSTRIPED=3Dm
CONFIG_DM_CRYPT=3Dm
CONFIG_DM_SNAPSHOT=3Dm
CONFIG_DM_THIN_PROVISIONING=3Dm
CONFIG_DM_CACHE=3Dm
CONFIG_DM_CACHE_SMQ=3Dm
CONFIG_DM_WRITECACHE=3Dm
CONFIG_DM_ERA=3Dm
CONFIG_DM_CLONE=3Dm
CONFIG_DM_MIRROR=3Dm
CONFIG_DM_LOG_USERSPACE=3Dm
CONFIG_DM_RAID=3Dm
CONFIG_DM_ZERO=3Dm
CONFIG_DM_MULTIPATH=3Dm
CONFIG_DM_MULTIPATH_QL=3Dm
CONFIG_DM_MULTIPATH_ST=3Dm
CONFIG_DM_DELAY=3Dm
CONFIG_DM_DUST=3Dm
CONFIG_DM_UEVENT=3Dy
CONFIG_DM_FLAKEY=3Dm
CONFIG_DM_VERITY=3Dm
CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=3Dy
CONFIG_DM_VERITY_FEC=3Dy
CONFIG_DM_SWITCH=3Dm
CONFIG_DM_LOG_WRITES=3Dm
CONFIG_DM_INTEGRITY=3Dm
CONFIG_DM_ZONED=3Dm
CONFIG_TARGET_CORE=3Dm
CONFIG_TCM_IBLOCK=3Dm
CONFIG_TCM_FILEIO=3Dm
CONFIG_TCM_PSCSI=3Dm
CONFIG_TCM_USER2=3Dm
CONFIG_LOOPBACK_TARGET=3Dm
CONFIG_TCM_FC=3Dm
CONFIG_ISCSI_TARGET=3Dm
CONFIG_ISCSI_TARGET_CXGB4=3Dm
CONFIG_SBP_TARGET=3Dm
CONFIG_FUSION=3Dy
CONFIG_FUSION_SPI=3Dm
CONFIG_FUSION_FC=3Dm
CONFIG_FUSION_SAS=3Dm
CONFIG_FUSION_MAX_SGE=3D128
CONFIG_FUSION_CTL=3Dm
CONFIG_FUSION_LAN=3Dm
# CONFIG_FUSION_LOGGING is not set

#
# IEEE 1394 (FireWire) support
#
CONFIG_FIREWIRE=3Dm
CONFIG_FIREWIRE_OHCI=3Dm
CONFIG_FIREWIRE_SBP2=3Dm
CONFIG_FIREWIRE_NET=3Dm
CONFIG_FIREWIRE_NOSY=3Dm
# end of IEEE 1394 (FireWire) support

CONFIG_MACINTOSH_DRIVERS=3Dy
CONFIG_MAC_EMUMOUSEBTN=3Dm
CONFIG_NETDEVICES=3Dy
CONFIG_MII=3Dm
CONFIG_NET_CORE=3Dy
CONFIG_BONDING=3Dm
CONFIG_DUMMY=3Dm
CONFIG_WIREGUARD=3Dm
# CONFIG_WIREGUARD_DEBUG is not set
CONFIG_EQUALIZER=3Dm
CONFIG_NET_FC=3Dy
CONFIG_IFB=3Dm
CONFIG_NET_TEAM=3Dm
CONFIG_NET_TEAM_MODE_BROADCAST=3Dm
CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dm
CONFIG_NET_TEAM_MODE_RANDOM=3Dm
CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dm
CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dm
CONFIG_MACVLAN=3Dm
CONFIG_MACVTAP=3Dm
CONFIG_IPVLAN_L3S=3Dy
CONFIG_IPVLAN=3Dm
CONFIG_IPVTAP=3Dm
CONFIG_VXLAN=3Dm
CONFIG_GENEVE=3Dm
CONFIG_GTP=3Dm
CONFIG_MACSEC=3Dm
CONFIG_NETCONSOLE=3Dm
CONFIG_NETCONSOLE_DYNAMIC=3Dy
CONFIG_NETPOLL=3Dy
CONFIG_NET_POLL_CONTROLLER=3Dy
CONFIG_NTB_NETDEV=3Dm
CONFIG_RIONET=3Dm
CONFIG_RIONET_TX_SIZE=3D128
CONFIG_RIONET_RX_SIZE=3D128
CONFIG_TUN=3Dm
CONFIG_TAP=3Dm
# CONFIG_TUN_VNET_CROSS_LE is not set
CONFIG_VETH=3Dm
CONFIG_VIRTIO_NET=3Dm
CONFIG_NLMON=3Dm
CONFIG_NET_VRF=3Dm
CONFIG_VSOCKMON=3Dm
CONFIG_SUNGEM_PHY=3Dm
# CONFIG_ARCNET is not set
CONFIG_ATM_DRIVERS=3Dy
# CONFIG_ATM_DUMMY is not set
CONFIG_ATM_TCP=3Dm
CONFIG_ATM_LANAI=3Dm
CONFIG_ATM_ENI=3Dm
# CONFIG_ATM_ENI_DEBUG is not set
# CONFIG_ATM_ENI_TUNE_BURST is not set
CONFIG_ATM_FIRESTREAM=3Dm
CONFIG_ATM_ZATM=3Dm
# CONFIG_ATM_ZATM_DEBUG is not set
CONFIG_ATM_NICSTAR=3Dm
# CONFIG_ATM_NICSTAR_USE_SUNI is not set
# CONFIG_ATM_NICSTAR_USE_IDT77105 is not set
CONFIG_ATM_IDT77252=3Dm
# CONFIG_ATM_IDT77252_DEBUG is not set
# CONFIG_ATM_IDT77252_RCV_ALL is not set
CONFIG_ATM_IDT77252_USE_SUNI=3Dy
CONFIG_ATM_AMBASSADOR=3Dm
# CONFIG_ATM_AMBASSADOR_DEBUG is not set
CONFIG_ATM_HORIZON=3Dm
# CONFIG_ATM_HORIZON_DEBUG is not set
CONFIG_ATM_IA=3Dm
# CONFIG_ATM_IA_DEBUG is not set
CONFIG_ATM_FORE200E=3Dm
CONFIG_ATM_FORE200E_USE_TASKLET=3Dy
CONFIG_ATM_FORE200E_TX_RETRY=3D16
CONFIG_ATM_FORE200E_DEBUG=3D0
CONFIG_ATM_HE=3Dm
CONFIG_ATM_HE_USE_SUNI=3Dy
CONFIG_ATM_SOLOS=3Dm
CONFIG_CAIF_DRIVERS=3Dy
CONFIG_CAIF_TTY=3Dm
CONFIG_CAIF_SPI_SLAVE=3Dm
CONFIG_CAIF_SPI_SYNC=3Dy
CONFIG_CAIF_HSI=3Dm
CONFIG_CAIF_VIRTIO=3Dm

#
# Distributed Switch Architecture drivers
#
CONFIG_B53=3Dm
# CONFIG_B53_SPI_DRIVER is not set
CONFIG_B53_MDIO_DRIVER=3Dm
CONFIG_B53_MMAP_DRIVER=3Dm
CONFIG_B53_SRAB_DRIVER=3Dm
CONFIG_B53_SERDES=3Dm
CONFIG_NET_DSA_BCM_SF2=3Dm
CONFIG_NET_DSA_LOOP=3Dm
CONFIG_NET_DSA_LANTIQ_GSWIP=3Dm
CONFIG_NET_DSA_MT7530=3Dm
CONFIG_NET_DSA_MV88E6060=3Dm
CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON=3Dm
CONFIG_NET_DSA_MICROCHIP_KSZ9477=3Dm
CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C=3Dm
CONFIG_NET_DSA_MICROCHIP_KSZ9477_SPI=3Dm
CONFIG_NET_DSA_MICROCHIP_KSZ8795=3Dm
CONFIG_NET_DSA_MICROCHIP_KSZ8795_SPI=3Dm
CONFIG_NET_DSA_MV88E6XXX=3Dm
CONFIG_NET_DSA_MV88E6XXX_GLOBAL2=3Dy
CONFIG_NET_DSA_MV88E6XXX_PTP=3Dy
CONFIG_NET_DSA_AR9331=3Dm
CONFIG_NET_DSA_SJA1105=3Dm
CONFIG_NET_DSA_SJA1105_PTP=3Dy
CONFIG_NET_DSA_SJA1105_TAS=3Dy
CONFIG_NET_DSA_QCA8K=3Dm
CONFIG_NET_DSA_REALTEK_SMI=3Dm
CONFIG_NET_DSA_SMSC_LAN9303=3Dm
CONFIG_NET_DSA_SMSC_LAN9303_I2C=3Dm
CONFIG_NET_DSA_SMSC_LAN9303_MDIO=3Dm
CONFIG_NET_DSA_VITESSE_VSC73XX=3Dm
CONFIG_NET_DSA_VITESSE_VSC73XX_SPI=3Dm
CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM=3Dm
# end of Distributed Switch Architecture drivers

CONFIG_ETHERNET=3Dy
CONFIG_MDIO=3Dm
CONFIG_NET_VENDOR_3COM=3Dy
CONFIG_PCMCIA_3C574=3Dm
CONFIG_PCMCIA_3C589=3Dm
CONFIG_VORTEX=3Dm
CONFIG_TYPHOON=3Dm
CONFIG_NET_VENDOR_ADAPTEC=3Dy
CONFIG_ADAPTEC_STARFIRE=3Dm
CONFIG_NET_VENDOR_AGERE=3Dy
CONFIG_ET131X=3Dm
CONFIG_NET_VENDOR_ALACRITECH=3Dy
CONFIG_SLICOSS=3Dm
CONFIG_NET_VENDOR_ALTEON=3Dy
CONFIG_ACENIC=3Dm
# CONFIG_ACENIC_OMIT_TIGON_I is not set
CONFIG_ALTERA_TSE=3Dm
CONFIG_NET_VENDOR_AMAZON=3Dy
CONFIG_ENA_ETHERNET=3Dm
CONFIG_NET_VENDOR_AMD=3Dy
CONFIG_AMD8111_ETH=3Dm
CONFIG_PCNET32=3Dm
CONFIG_PCMCIA_NMCLAN=3Dm
CONFIG_AMD_XGBE=3Dm
CONFIG_AMD_XGBE_DCB=3Dy
CONFIG_AMD_XGBE_HAVE_ECC=3Dy
CONFIG_NET_VENDOR_AQUANTIA=3Dy
CONFIG_AQTION=3Dm
CONFIG_NET_VENDOR_ARC=3Dy
CONFIG_NET_VENDOR_ATHEROS=3Dy
CONFIG_ATL2=3Dm
CONFIG_ATL1=3Dm
CONFIG_ATL1E=3Dm
CONFIG_ATL1C=3Dm
CONFIG_ALX=3Dm
CONFIG_NET_VENDOR_AURORA=3Dy
CONFIG_AURORA_NB8800=3Dm
CONFIG_NET_VENDOR_BROADCOM=3Dy
CONFIG_B44=3Dm
CONFIG_B44_PCI_AUTOSELECT=3Dy
CONFIG_B44_PCICORE_AUTOSELECT=3Dy
CONFIG_B44_PCI=3Dy
CONFIG_BCMGENET=3Dm
CONFIG_BNX2=3Dm
CONFIG_CNIC=3Dm
CONFIG_TIGON3=3Dm
CONFIG_TIGON3_HWMON=3Dy
CONFIG_BNX2X=3Dm
CONFIG_BNX2X_SRIOV=3Dy
CONFIG_SYSTEMPORT=3Dm
CONFIG_BNXT=3Dm
CONFIG_BNXT_SRIOV=3Dy
CONFIG_BNXT_FLOWER_OFFLOAD=3Dy
CONFIG_BNXT_DCB=3Dy
CONFIG_BNXT_HWMON=3Dy
CONFIG_NET_VENDOR_BROCADE=3Dy
CONFIG_BNA=3Dm
CONFIG_NET_VENDOR_CADENCE=3Dy
CONFIG_MACB=3Dm
CONFIG_MACB_USE_HWSTAMP=3Dy
CONFIG_MACB_PCI=3Dm
CONFIG_NET_VENDOR_CAVIUM=3Dy
CONFIG_THUNDER_NIC_PF=3Dm
CONFIG_THUNDER_NIC_VF=3Dm
CONFIG_THUNDER_NIC_BGX=3Dm
CONFIG_THUNDER_NIC_RGX=3Dm
CONFIG_CAVIUM_PTP=3Dm
CONFIG_LIQUIDIO=3Dm
CONFIG_LIQUIDIO_VF=3Dm
CONFIG_NET_VENDOR_CHELSIO=3Dy
CONFIG_CHELSIO_T1=3Dm
CONFIG_CHELSIO_T1_1G=3Dy
CONFIG_CHELSIO_T3=3Dm
CONFIG_CHELSIO_T4=3Dm
CONFIG_CHELSIO_T4_DCB=3Dy
CONFIG_CHELSIO_T4_FCOE=3Dy
CONFIG_CHELSIO_T4VF=3Dm
CONFIG_CHELSIO_LIB=3Dm
CONFIG_NET_VENDOR_CISCO=3Dy
CONFIG_ENIC=3Dm
CONFIG_NET_VENDOR_CORTINA=3Dy
CONFIG_GEMINI_ETHERNET=3Dm
CONFIG_CX_ECAT=3Dm
CONFIG_DNET=3Dm
CONFIG_NET_VENDOR_DEC=3Dy
CONFIG_NET_TULIP=3Dy
CONFIG_DE2104X=3Dm
CONFIG_DE2104X_DSL=3D0
CONFIG_TULIP=3Dm
CONFIG_TULIP_MWI=3Dy
CONFIG_TULIP_MMIO=3Dy
CONFIG_TULIP_NAPI=3Dy
CONFIG_TULIP_NAPI_HW_MITIGATION=3Dy
CONFIG_DE4X5=3Dm
CONFIG_WINBOND_840=3Dm
CONFIG_DM9102=3Dm
CONFIG_ULI526X=3Dm
CONFIG_PCMCIA_XIRCOM=3Dm
CONFIG_NET_VENDOR_DLINK=3Dy
CONFIG_DL2K=3Dm
CONFIG_SUNDANCE=3Dm
# CONFIG_SUNDANCE_MMIO is not set
CONFIG_NET_VENDOR_EMULEX=3Dy
CONFIG_BE2NET=3Dm
CONFIG_BE2NET_HWMON=3Dy
CONFIG_BE2NET_BE2=3Dy
CONFIG_BE2NET_BE3=3Dy
CONFIG_BE2NET_LANCER=3Dy
CONFIG_BE2NET_SKYHAWK=3Dy
CONFIG_NET_VENDOR_EZCHIP=3Dy
CONFIG_EZCHIP_NPS_MANAGEMENT_ENET=3Dm
CONFIG_NET_VENDOR_FUJITSU=3Dy
CONFIG_PCMCIA_FMVJ18X=3Dm
CONFIG_NET_VENDOR_GOOGLE=3Dy
CONFIG_GVE=3Dm
CONFIG_NET_VENDOR_HUAWEI=3Dy
CONFIG_HINIC=3Dm
CONFIG_NET_VENDOR_I825XX=3Dy
CONFIG_NET_VENDOR_INTEL=3Dy
CONFIG_E100=3Dm
CONFIG_E1000=3Dm
CONFIG_E1000E=3Dm
CONFIG_E1000E_HWTS=3Dy
CONFIG_IGB=3Dm
CONFIG_IGB_HWMON=3Dy
CONFIG_IGB_DCA=3Dy
CONFIG_IGBVF=3Dm
CONFIG_IXGB=3Dm
CONFIG_IXGBE=3Dm
CONFIG_IXGBE_HWMON=3Dy
CONFIG_IXGBE_DCA=3Dy
CONFIG_IXGBE_DCB=3Dy
# CONFIG_IXGBE_IPSEC is not set
CONFIG_IXGBEVF=3Dm
CONFIG_IXGBEVF_IPSEC=3Dy
CONFIG_I40E=3Dm
CONFIG_I40E_DCB=3Dy
CONFIG_IAVF=3Dm
CONFIG_I40EVF=3Dm
CONFIG_ICE=3Dm
CONFIG_FM10K=3Dm
CONFIG_IGC=3Dm
CONFIG_JME=3Dm
CONFIG_NET_VENDOR_MARVELL=3Dy
CONFIG_MVMDIO=3Dm
CONFIG_SKGE=3Dm
# CONFIG_SKGE_DEBUG is not set
CONFIG_SKGE_GENESIS=3Dy
CONFIG_SKY2=3Dm
# CONFIG_SKY2_DEBUG is not set
CONFIG_NET_VENDOR_MELLANOX=3Dy
CONFIG_MLX4_EN=3Dm
CONFIG_MLX4_EN_DCB=3Dy
CONFIG_MLX4_CORE=3Dm
CONFIG_MLX4_DEBUG=3Dy
CONFIG_MLX4_CORE_GEN2=3Dy
CONFIG_MLX5_CORE=3Dm
CONFIG_MLX5_ACCEL=3Dy
CONFIG_MLX5_FPGA=3Dy
CONFIG_MLX5_CORE_EN=3Dy
CONFIG_MLX5_EN_ARFS=3Dy
CONFIG_MLX5_EN_RXNFC=3Dy
CONFIG_MLX5_MPFS=3Dy
CONFIG_MLX5_ESWITCH=3Dy
CONFIG_MLX5_CORE_EN_DCB=3Dy
CONFIG_MLX5_CORE_IPOIB=3Dy
CONFIG_MLX5_FPGA_IPSEC=3Dy
CONFIG_MLX5_EN_IPSEC=3Dy
CONFIG_MLX5_FPGA_TLS=3Dy
CONFIG_MLX5_TLS=3Dy
CONFIG_MLX5_EN_TLS=3Dy
CONFIG_MLX5_SW_STEERING=3Dy
CONFIG_MLXSW_CORE=3Dm
CONFIG_MLXSW_CORE_HWMON=3Dy
CONFIG_MLXSW_CORE_THERMAL=3Dy
CONFIG_MLXSW_PCI=3Dm
CONFIG_MLXSW_I2C=3Dm
CONFIG_MLXSW_SWITCHIB=3Dm
CONFIG_MLXSW_SWITCHX2=3Dm
CONFIG_MLXSW_SPECTRUM=3Dm
CONFIG_MLXSW_SPECTRUM_DCB=3Dy
CONFIG_MLXSW_MINIMAL=3Dm
CONFIG_MLXFW=3Dm
CONFIG_NET_VENDOR_MICREL=3Dy
CONFIG_KS8842=3Dm
CONFIG_KS8851=3Dm
CONFIG_KS8851_MLL=3Dm
CONFIG_KSZ884X_PCI=3Dm
CONFIG_NET_VENDOR_MICROCHIP=3Dy
CONFIG_ENC28J60=3Dm
# CONFIG_ENC28J60_WRITEVERIFY is not set
CONFIG_ENCX24J600=3Dm
CONFIG_LAN743X=3Dm
CONFIG_NET_VENDOR_MICROSEMI=3Dy
CONFIG_MSCC_OCELOT_SWITCH=3Dm
CONFIG_MSCC_OCELOT_SWITCH_OCELOT=3Dm
CONFIG_NET_VENDOR_MYRI=3Dy
CONFIG_MYRI10GE=3Dm
CONFIG_MYRI10GE_DCA=3Dy
CONFIG_FEALNX=3Dm
CONFIG_NET_VENDOR_NATSEMI=3Dy
CONFIG_NATSEMI=3Dm
CONFIG_NS83820=3Dm
CONFIG_NET_VENDOR_NETERION=3Dy
CONFIG_S2IO=3Dm
CONFIG_VXGE=3Dm
# CONFIG_VXGE_DEBUG_TRACE_ALL is not set
CONFIG_NET_VENDOR_NETRONOME=3Dy
CONFIG_NFP=3Dm
CONFIG_NFP_APP_FLOWER=3Dy
CONFIG_NFP_APP_ABM_NIC=3Dy
# CONFIG_NFP_DEBUG is not set
CONFIG_NET_VENDOR_NI=3Dy
CONFIG_NI_XGE_MANAGEMENT_ENET=3Dm
CONFIG_NET_VENDOR_8390=3Dy
CONFIG_PCMCIA_AXNET=3Dm
CONFIG_NE2K_PCI=3Dm
CONFIG_PCMCIA_PCNET=3Dm
CONFIG_NET_VENDOR_NVIDIA=3Dy
CONFIG_FORCEDETH=3Dm
CONFIG_NET_VENDOR_OKI=3Dy
CONFIG_ETHOC=3Dm
CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
CONFIG_HAMACHI=3Dm
CONFIG_YELLOWFIN=3Dm
CONFIG_NET_VENDOR_PENSANDO=3Dy
CONFIG_IONIC=3Dm
CONFIG_NET_VENDOR_QLOGIC=3Dy
CONFIG_QLA3XXX=3Dm
CONFIG_QLCNIC=3Dm
CONFIG_QLCNIC_SRIOV=3Dy
CONFIG_QLCNIC_DCB=3Dy
CONFIG_QLCNIC_HWMON=3Dy
CONFIG_NETXEN_NIC=3Dm
CONFIG_QED=3Dm
CONFIG_QED_LL2=3Dy
CONFIG_QED_SRIOV=3Dy
CONFIG_QEDE=3Dm
CONFIG_QED_RDMA=3Dy
CONFIG_QED_ISCSI=3Dy
CONFIG_QED_FCOE=3Dy
CONFIG_QED_OOO=3Dy
CONFIG_NET_VENDOR_QUALCOMM=3Dy
CONFIG_QCA7000=3Dm
CONFIG_QCA7000_SPI=3Dm
CONFIG_QCA7000_UART=3Dm
CONFIG_QCOM_EMAC=3Dm
CONFIG_RMNET=3Dm
CONFIG_NET_VENDOR_RDC=3Dy
CONFIG_R6040=3Dm
CONFIG_NET_VENDOR_REALTEK=3Dy
CONFIG_ATP=3Dm
CONFIG_8139CP=3Dm
CONFIG_8139TOO=3Dm
# CONFIG_8139TOO_PIO is not set
CONFIG_8139TOO_TUNE_TWISTER=3Dy
CONFIG_8139TOO_8129=3Dy
# CONFIG_8139_OLD_RX_RESET is not set
CONFIG_R8169=3Dm
CONFIG_NET_VENDOR_RENESAS=3Dy
CONFIG_NET_VENDOR_ROCKER=3Dy
CONFIG_ROCKER=3Dm
CONFIG_NET_VENDOR_SAMSUNG=3Dy
CONFIG_SXGBE_ETH=3Dm
CONFIG_NET_VENDOR_SEEQ=3Dy
CONFIG_NET_VENDOR_SOLARFLARE=3Dy
CONFIG_SFC=3Dm
CONFIG_SFC_MTD=3Dy
CONFIG_SFC_MCDI_MON=3Dy
CONFIG_SFC_SRIOV=3Dy
CONFIG_SFC_MCDI_LOGGING=3Dy
CONFIG_SFC_FALCON=3Dm
CONFIG_SFC_FALCON_MTD=3Dy
CONFIG_NET_VENDOR_SILAN=3Dy
CONFIG_SC92031=3Dm
CONFIG_NET_VENDOR_SIS=3Dy
CONFIG_SIS900=3Dm
CONFIG_SIS190=3Dm
CONFIG_NET_VENDOR_SMSC=3Dy
CONFIG_PCMCIA_SMC91C92=3Dm
CONFIG_EPIC100=3Dm
CONFIG_SMSC911X=3Dm
CONFIG_SMSC9420=3Dm
CONFIG_NET_VENDOR_SOCIONEXT=3Dy
CONFIG_NET_VENDOR_STMICRO=3Dy
CONFIG_STMMAC_ETH=3Dm
# CONFIG_STMMAC_SELFTESTS is not set
CONFIG_STMMAC_PLATFORM=3Dm
CONFIG_DWMAC_DWC_QOS_ETH=3Dm
CONFIG_DWMAC_GENERIC=3Dm
CONFIG_STMMAC_PCI=3Dm
CONFIG_NET_VENDOR_SUN=3Dy
CONFIG_HAPPYMEAL=3Dm
CONFIG_SUNGEM=3Dm
CONFIG_CASSINI=3Dm
CONFIG_NIU=3Dm
CONFIG_NET_VENDOR_SYNOPSYS=3Dy
CONFIG_DWC_XLGMAC=3Dm
CONFIG_DWC_XLGMAC_PCI=3Dm
CONFIG_NET_VENDOR_TEHUTI=3Dy
CONFIG_TEHUTI=3Dm
CONFIG_NET_VENDOR_TI=3Dy
# CONFIG_TI_CPSW_PHY_SEL is not set
CONFIG_TLAN=3Dm
CONFIG_NET_VENDOR_VIA=3Dy
CONFIG_VIA_RHINE=3Dm
CONFIG_VIA_RHINE_MMIO=3Dy
CONFIG_VIA_VELOCITY=3Dm
CONFIG_NET_VENDOR_WIZNET=3Dy
CONFIG_WIZNET_W5100=3Dm
CONFIG_WIZNET_W5300=3Dm
# CONFIG_WIZNET_BUS_DIRECT is not set
# CONFIG_WIZNET_BUS_INDIRECT is not set
CONFIG_WIZNET_BUS_ANY=3Dy
CONFIG_WIZNET_W5100_SPI=3Dm
CONFIG_NET_VENDOR_XILINX=3Dy
CONFIG_XILINX_AXI_EMAC=3Dm
CONFIG_XILINX_LL_TEMAC=3Dm
CONFIG_NET_VENDOR_XIRCOM=3Dy
CONFIG_PCMCIA_XIRC2PS=3Dm
CONFIG_FDDI=3Dm
CONFIG_DEFXX=3Dm
CONFIG_DEFXX_MMIO=3Dy
CONFIG_SKFP=3Dm
# CONFIG_HIPPI is not set
CONFIG_NET_SB1000=3Dm
CONFIG_MDIO_DEVICE=3Dm
CONFIG_MDIO_BUS=3Dm
CONFIG_MDIO_BCM_UNIMAC=3Dm
CONFIG_MDIO_BITBANG=3Dm
CONFIG_MDIO_BUS_MUX=3Dm
CONFIG_MDIO_BUS_MUX_GPIO=3Dm
CONFIG_MDIO_BUS_MUX_MMIOREG=3Dm
CONFIG_MDIO_BUS_MUX_MULTIPLEXER=3Dm
CONFIG_MDIO_CAVIUM=3Dm
CONFIG_MDIO_GPIO=3Dm
CONFIG_MDIO_HISI_FEMAC=3Dm
CONFIG_MDIO_I2C=3Dm
CONFIG_MDIO_MSCC_MIIM=3Dm
CONFIG_MDIO_OCTEON=3Dm
CONFIG_MDIO_THUNDER=3Dm
CONFIG_PHYLINK=3Dm
CONFIG_PHYLIB=3Dm
CONFIG_SWPHY=3Dy
CONFIG_LED_TRIGGER_PHY=3Dy

#
# MII PHY device drivers
#
CONFIG_SFP=3Dm
CONFIG_ADIN_PHY=3Dm
CONFIG_AMD_PHY=3Dm
CONFIG_AQUANTIA_PHY=3Dm
CONFIG_AX88796B_PHY=3Dm
CONFIG_BCM7XXX_PHY=3Dm
CONFIG_BCM87XX_PHY=3Dm
CONFIG_BCM_NET_PHYLIB=3Dm
CONFIG_BROADCOM_PHY=3Dm
CONFIG_CICADA_PHY=3Dm
CONFIG_CORTINA_PHY=3Dm
CONFIG_DAVICOM_PHY=3Dm
CONFIG_DP83822_PHY=3Dm
CONFIG_DP83TC811_PHY=3Dm
CONFIG_DP83848_PHY=3Dm
CONFIG_DP83867_PHY=3Dm
CONFIG_DP83869_PHY=3Dm
CONFIG_FIXED_PHY=3Dm
CONFIG_ICPLUS_PHY=3Dm
CONFIG_INTEL_XWAY_PHY=3Dm
CONFIG_LSI_ET1011C_PHY=3Dm
CONFIG_LXT_PHY=3Dm
CONFIG_MARVELL_PHY=3Dm
CONFIG_MARVELL_10G_PHY=3Dm
CONFIG_MICREL_PHY=3Dm
CONFIG_MICROCHIP_PHY=3Dm
CONFIG_MICROCHIP_T1_PHY=3Dm
CONFIG_MICROSEMI_PHY=3Dm
CONFIG_NATIONAL_PHY=3Dm
CONFIG_NXP_TJA11XX_PHY=3Dm
CONFIG_AT803X_PHY=3Dm
CONFIG_QSEMI_PHY=3Dm
CONFIG_REALTEK_PHY=3Dm
CONFIG_RENESAS_PHY=3Dm
CONFIG_ROCKCHIP_PHY=3Dm
CONFIG_SMSC_PHY=3Dm
CONFIG_STE10XP=3Dm
CONFIG_TERANETICS_PHY=3Dm
CONFIG_VITESSE_PHY=3Dm
CONFIG_XILINX_GMII2RGMII=3Dm
CONFIG_MICREL_KS8995MA=3Dm
CONFIG_PLIP=3Dm
CONFIG_PPP=3Dm
CONFIG_PPP_BSDCOMP=3Dm
CONFIG_PPP_DEFLATE=3Dm
CONFIG_PPP_FILTER=3Dy
CONFIG_PPP_MPPE=3Dm
CONFIG_PPP_MULTILINK=3Dy
CONFIG_PPPOATM=3Dm
CONFIG_PPPOE=3Dm
CONFIG_PPTP=3Dm
CONFIG_PPPOL2TP=3Dm
CONFIG_PPP_ASYNC=3Dm
CONFIG_PPP_SYNC_TTY=3Dm
CONFIG_SLIP=3Dm
CONFIG_SLHC=3Dm
CONFIG_SLIP_COMPRESSED=3Dy
CONFIG_SLIP_SMART=3Dy
CONFIG_SLIP_MODE_SLIP6=3Dy
CONFIG_USB_NET_DRIVERS=3Dm
CONFIG_USB_CATC=3Dm
CONFIG_USB_KAWETH=3Dm
CONFIG_USB_PEGASUS=3Dm
CONFIG_USB_RTL8150=3Dm
CONFIG_USB_RTL8152=3Dm
CONFIG_USB_LAN78XX=3Dm
CONFIG_USB_USBNET=3Dm
CONFIG_USB_NET_AX8817X=3Dm
CONFIG_USB_NET_AX88179_178A=3Dm
CONFIG_USB_NET_CDCETHER=3Dm
CONFIG_USB_NET_CDC_EEM=3Dm
CONFIG_USB_NET_CDC_NCM=3Dm
CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dm
CONFIG_USB_NET_CDC_MBIM=3Dm
CONFIG_USB_NET_DM9601=3Dm
CONFIG_USB_NET_SR9700=3Dm
CONFIG_USB_NET_SR9800=3Dm
CONFIG_USB_NET_SMSC75XX=3Dm
CONFIG_USB_NET_SMSC95XX=3Dm
CONFIG_USB_NET_GL620A=3Dm
CONFIG_USB_NET_NET1080=3Dm
CONFIG_USB_NET_PLUSB=3Dm
CONFIG_USB_NET_MCS7830=3Dm
CONFIG_USB_NET_RNDIS_HOST=3Dm
CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dm
CONFIG_USB_NET_CDC_SUBSET=3Dm
CONFIG_USB_ALI_M5632=3Dy
CONFIG_USB_AN2720=3Dy
CONFIG_USB_BELKIN=3Dy
CONFIG_USB_ARMLINUX=3Dy
CONFIG_USB_EPSON2888=3Dy
CONFIG_USB_KC2190=3Dy
CONFIG_USB_NET_ZAURUS=3Dm
CONFIG_USB_NET_CX82310_ETH=3Dm
CONFIG_USB_NET_KALMIA=3Dm
CONFIG_USB_NET_QMI_WWAN=3Dm
CONFIG_USB_HSO=3Dm
CONFIG_USB_NET_INT51X1=3Dm
CONFIG_USB_CDC_PHONET=3Dm
CONFIG_USB_IPHETH=3Dm
CONFIG_USB_SIERRA_NET=3Dm
CONFIG_USB_VL600=3Dm
CONFIG_USB_NET_CH9200=3Dm
CONFIG_USB_NET_AQC111=3Dm
CONFIG_WLAN=3Dy
# CONFIG_WIRELESS_WDS is not set
CONFIG_WLAN_VENDOR_ADMTEK=3Dy
CONFIG_ADM8211=3Dm
CONFIG_ATH_COMMON=3Dm
CONFIG_WLAN_VENDOR_ATH=3Dy
# CONFIG_ATH_DEBUG is not set
CONFIG_ATH5K=3Dm
CONFIG_ATH5K_DEBUG=3Dy
CONFIG_ATH5K_TRACER=3Dy
CONFIG_ATH5K_PCI=3Dy
CONFIG_ATH9K_HW=3Dm
CONFIG_ATH9K_COMMON=3Dm
CONFIG_ATH9K_COMMON_DEBUG=3Dy
CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
CONFIG_ATH9K=3Dm
CONFIG_ATH9K_PCI=3Dy
CONFIG_ATH9K_AHB=3Dy
CONFIG_ATH9K_DEBUGFS=3Dy
CONFIG_ATH9K_STATION_STATISTICS=3Dy
CONFIG_ATH9K_DYNACK=3Dy
CONFIG_ATH9K_WOW=3Dy
CONFIG_ATH9K_RFKILL=3Dy
CONFIG_ATH9K_CHANNEL_CONTEXT=3Dy
CONFIG_ATH9K_PCOEM=3Dy
CONFIG_ATH9K_PCI_NO_EEPROM=3Dm
CONFIG_ATH9K_HTC=3Dm
CONFIG_ATH9K_HTC_DEBUGFS=3Dy
CONFIG_ATH9K_HWRNG=3Dy
CONFIG_ATH9K_COMMON_SPECTRAL=3Dy
CONFIG_CARL9170=3Dm
CONFIG_CARL9170_LEDS=3Dy
CONFIG_CARL9170_DEBUGFS=3Dy
CONFIG_CARL9170_WPC=3Dy
# CONFIG_CARL9170_HWRNG is not set
CONFIG_ATH6KL=3Dm
CONFIG_ATH6KL_SDIO=3Dm
CONFIG_ATH6KL_USB=3Dm
CONFIG_ATH6KL_DEBUG=3Dy
CONFIG_ATH6KL_TRACING=3Dy
CONFIG_AR5523=3Dm
CONFIG_WIL6210=3Dm
CONFIG_WIL6210_ISR_COR=3Dy
CONFIG_WIL6210_TRACING=3Dy
CONFIG_WIL6210_DEBUGFS=3Dy
CONFIG_ATH10K=3Dm
CONFIG_ATH10K_CE=3Dy
CONFIG_ATH10K_PCI=3Dm
CONFIG_ATH10K_AHB=3Dy
CONFIG_ATH10K_SDIO=3Dm
CONFIG_ATH10K_USB=3Dm
CONFIG_ATH10K_DEBUG=3Dy
CONFIG_ATH10K_DEBUGFS=3Dy
CONFIG_ATH10K_SPECTRAL=3Dy
CONFIG_ATH10K_TRACING=3Dy
CONFIG_WCN36XX=3Dm
CONFIG_WCN36XX_DEBUGFS=3Dy
CONFIG_WLAN_VENDOR_ATMEL=3Dy
CONFIG_ATMEL=3Dm
CONFIG_PCI_ATMEL=3Dm
CONFIG_PCMCIA_ATMEL=3Dm
CONFIG_AT76C50X_USB=3Dm
CONFIG_WLAN_VENDOR_BROADCOM=3Dy
CONFIG_B43=3Dm
CONFIG_B43_BCMA=3Dy
CONFIG_B43_SSB=3Dy
CONFIG_B43_BUSES_BCMA_AND_SSB=3Dy
# CONFIG_B43_BUSES_BCMA is not set
# CONFIG_B43_BUSES_SSB is not set
CONFIG_B43_PCI_AUTOSELECT=3Dy
CONFIG_B43_PCICORE_AUTOSELECT=3Dy
CONFIG_B43_SDIO=3Dy
CONFIG_B43_BCMA_PIO=3Dy
CONFIG_B43_PIO=3Dy
CONFIG_B43_PHY_G=3Dy
CONFIG_B43_PHY_N=3Dy
CONFIG_B43_PHY_LP=3Dy
CONFIG_B43_PHY_HT=3Dy
CONFIG_B43_LEDS=3Dy
CONFIG_B43_HWRNG=3Dy
# CONFIG_B43_DEBUG is not set
CONFIG_B43LEGACY=3Dm
CONFIG_B43LEGACY_PCI_AUTOSELECT=3Dy
CONFIG_B43LEGACY_PCICORE_AUTOSELECT=3Dy
CONFIG_B43LEGACY_LEDS=3Dy
CONFIG_B43LEGACY_HWRNG=3Dy
CONFIG_B43LEGACY_DEBUG=3Dy
CONFIG_B43LEGACY_DMA=3Dy
CONFIG_B43LEGACY_PIO=3Dy
CONFIG_B43LEGACY_DMA_AND_PIO_MODE=3Dy
# CONFIG_B43LEGACY_DMA_MODE is not set
# CONFIG_B43LEGACY_PIO_MODE is not set
CONFIG_BRCMUTIL=3Dm
CONFIG_BRCMSMAC=3Dm
CONFIG_BRCMFMAC=3Dm
CONFIG_BRCMFMAC_PROTO_BCDC=3Dy
CONFIG_BRCMFMAC_PROTO_MSGBUF=3Dy
CONFIG_BRCMFMAC_SDIO=3Dy
CONFIG_BRCMFMAC_USB=3Dy
CONFIG_BRCMFMAC_PCIE=3Dy
CONFIG_BRCM_TRACING=3Dy
CONFIG_BRCMDBG=3Dy
CONFIG_WLAN_VENDOR_CISCO=3Dy
CONFIG_AIRO=3Dm
CONFIG_AIRO_CS=3Dm
CONFIG_WLAN_VENDOR_INTEL=3Dy
CONFIG_IPW2100=3Dm
CONFIG_IPW2100_MONITOR=3Dy
# CONFIG_IPW2100_DEBUG is not set
CONFIG_IPW2200=3Dm
CONFIG_IPW2200_MONITOR=3Dy
CONFIG_IPW2200_RADIOTAP=3Dy
CONFIG_IPW2200_PROMISCUOUS=3Dy
CONFIG_IPW2200_QOS=3Dy
# CONFIG_IPW2200_DEBUG is not set
CONFIG_LIBIPW=3Dm
# CONFIG_LIBIPW_DEBUG is not set
CONFIG_IWLEGACY=3Dm
CONFIG_IWL4965=3Dm
CONFIG_IWL3945=3Dm

#
# iwl3945 / iwl4965 Debugging Options
#
CONFIG_IWLEGACY_DEBUG=3Dy
CONFIG_IWLEGACY_DEBUGFS=3Dy
# end of iwl3945 / iwl4965 Debugging Options

CONFIG_IWLWIFI=3Dm
CONFIG_IWLWIFI_LEDS=3Dy
CONFIG_IWLDVM=3Dm
CONFIG_IWLMVM=3Dm
CONFIG_IWLWIFI_OPMODE_MODULAR=3Dy
# CONFIG_IWLWIFI_BCAST_FILTERING is not set

#
# Debugging Options
#
CONFIG_IWLWIFI_DEBUG=3Dy
CONFIG_IWLWIFI_DEBUGFS=3Dy
CONFIG_IWLWIFI_DEVICE_TRACING=3Dy
# end of Debugging Options

CONFIG_WLAN_VENDOR_INTERSIL=3Dy
CONFIG_HOSTAP=3Dm
CONFIG_HOSTAP_FIRMWARE=3Dy
CONFIG_HOSTAP_FIRMWARE_NVRAM=3Dy
CONFIG_HOSTAP_PLX=3Dm
CONFIG_HOSTAP_PCI=3Dm
CONFIG_HOSTAP_CS=3Dm
CONFIG_HERMES=3Dm
CONFIG_HERMES_PRISM=3Dy
CONFIG_HERMES_CACHE_FW_ON_INIT=3Dy
CONFIG_PLX_HERMES=3Dm
CONFIG_TMD_HERMES=3Dm
CONFIG_NORTEL_HERMES=3Dm
CONFIG_PCI_HERMES=3Dm
CONFIG_PCMCIA_HERMES=3Dm
CONFIG_PCMCIA_SPECTRUM=3Dm
CONFIG_ORINOCO_USB=3Dm
CONFIG_P54_COMMON=3Dm
CONFIG_P54_USB=3Dm
CONFIG_P54_PCI=3Dm
CONFIG_P54_SPI=3Dm
# CONFIG_P54_SPI_DEFAULT_EEPROM is not set
CONFIG_P54_LEDS=3Dy
CONFIG_PRISM54=3Dm
CONFIG_WLAN_VENDOR_MARVELL=3Dy
CONFIG_LIBERTAS=3Dm
CONFIG_LIBERTAS_USB=3Dm
CONFIG_LIBERTAS_CS=3Dm
CONFIG_LIBERTAS_SDIO=3Dm
CONFIG_LIBERTAS_SPI=3Dm
# CONFIG_LIBERTAS_DEBUG is not set
CONFIG_LIBERTAS_MESH=3Dy
CONFIG_LIBERTAS_THINFIRM=3Dm
# CONFIG_LIBERTAS_THINFIRM_DEBUG is not set
CONFIG_LIBERTAS_THINFIRM_USB=3Dm
CONFIG_MWIFIEX=3Dm
CONFIG_MWIFIEX_SDIO=3Dm
CONFIG_MWIFIEX_PCIE=3Dm
CONFIG_MWIFIEX_USB=3Dm
CONFIG_MWL8K=3Dm
CONFIG_WLAN_VENDOR_MEDIATEK=3Dy
CONFIG_MT7601U=3Dm
CONFIG_MT76_CORE=3Dm
CONFIG_MT76_LEDS=3Dy
CONFIG_MT76_USB=3Dm
CONFIG_MT76x02_LIB=3Dm
CONFIG_MT76x02_USB=3Dm
CONFIG_MT76x0_COMMON=3Dm
CONFIG_MT76x0U=3Dm
CONFIG_MT76x0E=3Dm
CONFIG_MT76x2_COMMON=3Dm
CONFIG_MT76x2E=3Dm
CONFIG_MT76x2U=3Dm
CONFIG_MT7603E=3Dm
CONFIG_MT7615E=3Dm
CONFIG_WLAN_VENDOR_RALINK=3Dy
CONFIG_RT2X00=3Dm
CONFIG_RT2400PCI=3Dm
CONFIG_RT2500PCI=3Dm
CONFIG_RT61PCI=3Dm
CONFIG_RT2800PCI=3Dm
CONFIG_RT2800PCI_RT33XX=3Dy
CONFIG_RT2800PCI_RT35XX=3Dy
CONFIG_RT2800PCI_RT53XX=3Dy
CONFIG_RT2800PCI_RT3290=3Dy
CONFIG_RT2500USB=3Dm
CONFIG_RT73USB=3Dm
CONFIG_RT2800USB=3Dm
CONFIG_RT2800USB_RT33XX=3Dy
CONFIG_RT2800USB_RT35XX=3Dy
CONFIG_RT2800USB_RT3573=3Dy
CONFIG_RT2800USB_RT53XX=3Dy
CONFIG_RT2800USB_RT55XX=3Dy
CONFIG_RT2800USB_UNKNOWN=3Dy
CONFIG_RT2800_LIB=3Dm
CONFIG_RT2800_LIB_MMIO=3Dm
CONFIG_RT2X00_LIB_MMIO=3Dm
CONFIG_RT2X00_LIB_PCI=3Dm
CONFIG_RT2X00_LIB_USB=3Dm
CONFIG_RT2X00_LIB=3Dm
CONFIG_RT2X00_LIB_FIRMWARE=3Dy
CONFIG_RT2X00_LIB_CRYPTO=3Dy
CONFIG_RT2X00_LIB_LEDS=3Dy
CONFIG_RT2X00_LIB_DEBUGFS=3Dy
# CONFIG_RT2X00_DEBUG is not set
CONFIG_WLAN_VENDOR_REALTEK=3Dy
CONFIG_RTL8180=3Dm
CONFIG_RTL8187=3Dm
CONFIG_RTL8187_LEDS=3Dy
CONFIG_RTL_CARDS=3Dm
CONFIG_RTL8192CE=3Dm
CONFIG_RTL8192SE=3Dm
CONFIG_RTL8192DE=3Dm
CONFIG_RTL8723AE=3Dm
CONFIG_RTL8723BE=3Dm
CONFIG_RTL8188EE=3Dm
CONFIG_RTL8192EE=3Dm
CONFIG_RTL8821AE=3Dm
CONFIG_RTL8192CU=3Dm
CONFIG_RTLWIFI=3Dm
CONFIG_RTLWIFI_PCI=3Dm
CONFIG_RTLWIFI_USB=3Dm
CONFIG_RTLWIFI_DEBUG=3Dy
CONFIG_RTL8192C_COMMON=3Dm
CONFIG_RTL8723_COMMON=3Dm
CONFIG_RTLBTCOEXIST=3Dm
CONFIG_RTL8XXXU=3Dm
CONFIG_RTL8XXXU_UNTESTED=3Dy
CONFIG_RTW88=3Dm
CONFIG_RTW88_CORE=3Dm
CONFIG_RTW88_PCI=3Dm
CONFIG_RTW88_8822BE=3Dy
CONFIG_RTW88_8822CE=3Dy
CONFIG_RTW88_DEBUG=3Dy
CONFIG_RTW88_DEBUGFS=3Dy
CONFIG_WLAN_VENDOR_RSI=3Dy
CONFIG_RSI_91X=3Dm
CONFIG_RSI_DEBUGFS=3Dy
CONFIG_RSI_SDIO=3Dm
CONFIG_RSI_USB=3Dm
CONFIG_RSI_COEX=3Dy
CONFIG_WLAN_VENDOR_ST=3Dy
CONFIG_CW1200=3Dm
CONFIG_CW1200_WLAN_SDIO=3Dm
CONFIG_CW1200_WLAN_SPI=3Dm
CONFIG_WLAN_VENDOR_TI=3Dy
CONFIG_WL1251=3Dm
CONFIG_WL1251_SPI=3Dm
CONFIG_WL1251_SDIO=3Dm
CONFIG_WL12XX=3Dm
CONFIG_WL18XX=3Dm
CONFIG_WLCORE=3Dm
CONFIG_WLCORE_SPI=3Dm
CONFIG_WLCORE_SDIO=3Dm
CONFIG_WILINK_PLATFORM_DATA=3Dy
CONFIG_WLAN_VENDOR_ZYDAS=3Dy
CONFIG_USB_ZD1201=3Dm
CONFIG_ZD1211RW=3Dm
# CONFIG_ZD1211RW_DEBUG is not set
CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
CONFIG_QTNFMAC=3Dm
CONFIG_QTNFMAC_PCIE=3Dm
CONFIG_PCMCIA_RAYCS=3Dm
CONFIG_PCMCIA_WL3501=3Dm
CONFIG_MAC80211_HWSIM=3Dm
CONFIG_USB_NET_RNDIS_WLAN=3Dm
CONFIG_VIRT_WIFI=3Dm

#
# WiMAX Wireless Broadband devices
#
CONFIG_WIMAX_I2400M=3Dm
CONFIG_WIMAX_I2400M_USB=3Dm
CONFIG_WIMAX_I2400M_DEBUG_LEVEL=3D8
# end of WiMAX Wireless Broadband devices

# CONFIG_WAN is not set
CONFIG_IEEE802154_DRIVERS=3Dm
CONFIG_IEEE802154_FAKELB=3Dm
CONFIG_IEEE802154_AT86RF230=3Dm
# CONFIG_IEEE802154_AT86RF230_DEBUGFS is not set
CONFIG_IEEE802154_MRF24J40=3Dm
CONFIG_IEEE802154_CC2520=3Dm
CONFIG_IEEE802154_ATUSB=3Dm
CONFIG_IEEE802154_ADF7242=3Dm
CONFIG_IEEE802154_CA8210=3Dm
# CONFIG_IEEE802154_CA8210_DEBUGFS is not set
CONFIG_IEEE802154_MCR20A=3Dm
CONFIG_IEEE802154_HWSIM=3Dm
CONFIG_XEN_NETDEV_FRONTEND=3Dm
CONFIG_XEN_NETDEV_BACKEND=3Dm
CONFIG_VMXNET3=3Dm
CONFIG_FUJITSU_ES=3Dm
CONFIG_USB4_NET=3Dm
CONFIG_HYPERV_NET=3Dm
CONFIG_NETDEVSIM=3Dm
CONFIG_NET_FAILOVER=3Dm
CONFIG_ISDN=3Dy
CONFIG_ISDN_CAPI=3Dy
CONFIG_CAPI_TRACE=3Dy
CONFIG_ISDN_CAPI_MIDDLEWARE=3Dy
CONFIG_MISDN=3Dm
CONFIG_MISDN_DSP=3Dm
CONFIG_MISDN_L1OIP=3Dm

#
# mISDN hardware drivers
#
CONFIG_MISDN_HFCPCI=3Dm
CONFIG_MISDN_HFCMULTI=3Dm
CONFIG_MISDN_HFCUSB=3Dm
CONFIG_MISDN_AVMFRITZ=3Dm
CONFIG_MISDN_SPEEDFAX=3Dm
CONFIG_MISDN_INFINEON=3Dm
CONFIG_MISDN_W6692=3Dm
CONFIG_MISDN_NETJET=3Dm
CONFIG_MISDN_HDLC=3Dm
CONFIG_MISDN_IPAC=3Dm
CONFIG_MISDN_ISAR=3Dm
CONFIG_NVM=3Dy
CONFIG_NVM_PBLK=3Dm
# CONFIG_NVM_PBLK_DEBUG is not set

#
# Input device support
#
CONFIG_INPUT=3Dy
CONFIG_INPUT_LEDS=3Dm
CONFIG_INPUT_FF_MEMLESS=3Dm
CONFIG_INPUT_POLLDEV=3Dm
CONFIG_INPUT_SPARSEKMAP=3Dm
CONFIG_INPUT_MATRIXKMAP=3Dm

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=3Dm
CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
CONFIG_INPUT_JOYDEV=3Dm
CONFIG_INPUT_EVDEV=3Dm
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=3Dy
CONFIG_KEYBOARD_ADC=3Dm
CONFIG_KEYBOARD_ADP5520=3Dm
CONFIG_KEYBOARD_ADP5588=3Dm
CONFIG_KEYBOARD_ADP5589=3Dm
CONFIG_KEYBOARD_APPLESPI=3Dm
CONFIG_KEYBOARD_ATKBD=3Dm
CONFIG_KEYBOARD_QT1050=3Dm
CONFIG_KEYBOARD_QT1070=3Dm
CONFIG_KEYBOARD_QT2160=3Dm
CONFIG_KEYBOARD_DLINK_DIR685=3Dm
CONFIG_KEYBOARD_LKKBD=3Dm
CONFIG_KEYBOARD_GPIO=3Dm
CONFIG_KEYBOARD_GPIO_POLLED=3Dm
CONFIG_KEYBOARD_TCA6416=3Dm
CONFIG_KEYBOARD_TCA8418=3Dm
CONFIG_KEYBOARD_MATRIX=3Dm
CONFIG_KEYBOARD_LM8323=3Dm
CONFIG_KEYBOARD_LM8333=3Dm
CONFIG_KEYBOARD_MAX7359=3Dm
CONFIG_KEYBOARD_MCS=3Dm
CONFIG_KEYBOARD_MPR121=3Dm
CONFIG_KEYBOARD_NEWTON=3Dm
CONFIG_KEYBOARD_OPENCORES=3Dm
CONFIG_KEYBOARD_SAMSUNG=3Dm
CONFIG_KEYBOARD_STOWAWAY=3Dm
CONFIG_KEYBOARD_SUNKBD=3Dm
CONFIG_KEYBOARD_STMPE=3Dm
CONFIG_KEYBOARD_OMAP4=3Dm
CONFIG_KEYBOARD_TC3589X=3Dm
CONFIG_KEYBOARD_TM2_TOUCHKEY=3Dm
CONFIG_KEYBOARD_TWL4030=3Dm
CONFIG_KEYBOARD_XTKBD=3Dm
CONFIG_KEYBOARD_CROS_EC=3Dm
CONFIG_KEYBOARD_CAP11XX=3Dm
CONFIG_KEYBOARD_BCM=3Dm
CONFIG_KEYBOARD_MTK_PMIC=3Dm
CONFIG_INPUT_MOUSE=3Dy
CONFIG_MOUSE_PS2=3Dm
CONFIG_MOUSE_PS2_ALPS=3Dy
CONFIG_MOUSE_PS2_BYD=3Dy
CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
CONFIG_MOUSE_PS2_CYPRESS=3Dy
CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
CONFIG_MOUSE_PS2_ELANTECH=3Dy
CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
CONFIG_MOUSE_PS2_SENTELIC=3Dy
CONFIG_MOUSE_PS2_TOUCHKIT=3Dy
CONFIG_MOUSE_PS2_FOCALTECH=3Dy
CONFIG_MOUSE_PS2_VMMOUSE=3Dy
CONFIG_MOUSE_PS2_SMBUS=3Dy
CONFIG_MOUSE_SERIAL=3Dm
CONFIG_MOUSE_APPLETOUCH=3Dm
CONFIG_MOUSE_BCM5974=3Dm
CONFIG_MOUSE_CYAPA=3Dm
CONFIG_MOUSE_ELAN_I2C=3Dm
CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
CONFIG_MOUSE_VSXXXAA=3Dm
CONFIG_MOUSE_GPIO=3Dm
CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
CONFIG_MOUSE_SYNAPTICS_USB=3Dm
CONFIG_INPUT_JOYSTICK=3Dy
CONFIG_JOYSTICK_ANALOG=3Dm
CONFIG_JOYSTICK_A3D=3Dm
CONFIG_JOYSTICK_ADI=3Dm
CONFIG_JOYSTICK_COBRA=3Dm
CONFIG_JOYSTICK_GF2K=3Dm
CONFIG_JOYSTICK_GRIP=3Dm
CONFIG_JOYSTICK_GRIP_MP=3Dm
CONFIG_JOYSTICK_GUILLEMOT=3Dm
CONFIG_JOYSTICK_INTERACT=3Dm
CONFIG_JOYSTICK_SIDEWINDER=3Dm
CONFIG_JOYSTICK_TMDC=3Dm
CONFIG_JOYSTICK_IFORCE=3Dm
CONFIG_JOYSTICK_IFORCE_USB=3Dm
CONFIG_JOYSTICK_IFORCE_232=3Dm
CONFIG_JOYSTICK_WARRIOR=3Dm
CONFIG_JOYSTICK_MAGELLAN=3Dm
CONFIG_JOYSTICK_SPACEORB=3Dm
CONFIG_JOYSTICK_SPACEBALL=3Dm
CONFIG_JOYSTICK_STINGER=3Dm
CONFIG_JOYSTICK_TWIDJOY=3Dm
CONFIG_JOYSTICK_ZHENHUA=3Dm
CONFIG_JOYSTICK_DB9=3Dm
CONFIG_JOYSTICK_GAMECON=3Dm
CONFIG_JOYSTICK_TURBOGRAFX=3Dm
CONFIG_JOYSTICK_AS5011=3Dm
CONFIG_JOYSTICK_JOYDUMP=3Dm
CONFIG_JOYSTICK_XPAD=3Dm
CONFIG_JOYSTICK_XPAD_FF=3Dy
CONFIG_JOYSTICK_XPAD_LEDS=3Dy
CONFIG_JOYSTICK_WALKERA0701=3Dm
CONFIG_JOYSTICK_PSXPAD_SPI=3Dm
CONFIG_JOYSTICK_PSXPAD_SPI_FF=3Dy
CONFIG_JOYSTICK_PXRC=3Dm
CONFIG_JOYSTICK_FSIA6B=3Dm
CONFIG_INPUT_TABLET=3Dy
CONFIG_TABLET_USB_ACECAD=3Dm
CONFIG_TABLET_USB_AIPTEK=3Dm
CONFIG_TABLET_USB_GTCO=3Dm
CONFIG_TABLET_USB_HANWANG=3Dm
CONFIG_TABLET_USB_KBTAB=3Dm
CONFIG_TABLET_USB_PEGASUS=3Dm
CONFIG_TABLET_SERIAL_WACOM4=3Dm
CONFIG_INPUT_TOUCHSCREEN=3Dy
CONFIG_TOUCHSCREEN_PROPERTIES=3Dy
CONFIG_TOUCHSCREEN_88PM860X=3Dm
CONFIG_TOUCHSCREEN_ADS7846=3Dm
CONFIG_TOUCHSCREEN_AD7877=3Dm
CONFIG_TOUCHSCREEN_AD7879=3Dm
CONFIG_TOUCHSCREEN_AD7879_I2C=3Dm
CONFIG_TOUCHSCREEN_AD7879_SPI=3Dm
CONFIG_TOUCHSCREEN_ADC=3Dm
CONFIG_TOUCHSCREEN_AR1021_I2C=3Dm
CONFIG_TOUCHSCREEN_ATMEL_MXT=3Dm
CONFIG_TOUCHSCREEN_ATMEL_MXT_T37=3Dy
CONFIG_TOUCHSCREEN_AUO_PIXCIR=3Dm
CONFIG_TOUCHSCREEN_BU21013=3Dm
CONFIG_TOUCHSCREEN_BU21029=3Dm
CONFIG_TOUCHSCREEN_CHIPONE_ICN8318=3Dm
CONFIG_TOUCHSCREEN_CHIPONE_ICN8505=3Dm
CONFIG_TOUCHSCREEN_CY8CTMG110=3Dm
CONFIG_TOUCHSCREEN_CYTTSP_CORE=3Dm
CONFIG_TOUCHSCREEN_CYTTSP_I2C=3Dm
CONFIG_TOUCHSCREEN_CYTTSP_SPI=3Dm
CONFIG_TOUCHSCREEN_CYTTSP4_CORE=3Dm
CONFIG_TOUCHSCREEN_CYTTSP4_I2C=3Dm
CONFIG_TOUCHSCREEN_CYTTSP4_SPI=3Dm
CONFIG_TOUCHSCREEN_DA9034=3Dm
CONFIG_TOUCHSCREEN_DA9052=3Dm
CONFIG_TOUCHSCREEN_DYNAPRO=3Dm
CONFIG_TOUCHSCREEN_HAMPSHIRE=3Dm
CONFIG_TOUCHSCREEN_EETI=3Dm
CONFIG_TOUCHSCREEN_EGALAX=3Dm
CONFIG_TOUCHSCREEN_EGALAX_SERIAL=3Dm
CONFIG_TOUCHSCREEN_EXC3000=3Dm
CONFIG_TOUCHSCREEN_FUJITSU=3Dm
CONFIG_TOUCHSCREEN_GOODIX=3Dm
CONFIG_TOUCHSCREEN_HIDEEP=3Dm
CONFIG_TOUCHSCREEN_ILI210X=3Dm
CONFIG_TOUCHSCREEN_S6SY761=3Dm
CONFIG_TOUCHSCREEN_GUNZE=3Dm
CONFIG_TOUCHSCREEN_EKTF2127=3Dm
CONFIG_TOUCHSCREEN_ELAN=3Dm
CONFIG_TOUCHSCREEN_ELO=3Dm
CONFIG_TOUCHSCREEN_WACOM_W8001=3Dm
CONFIG_TOUCHSCREEN_WACOM_I2C=3Dm
CONFIG_TOUCHSCREEN_MAX11801=3Dm
CONFIG_TOUCHSCREEN_MCS5000=3Dm
CONFIG_TOUCHSCREEN_MMS114=3Dm
CONFIG_TOUCHSCREEN_MELFAS_MIP4=3Dm
CONFIG_TOUCHSCREEN_MTOUCH=3Dm
CONFIG_TOUCHSCREEN_IMX6UL_TSC=3Dm
CONFIG_TOUCHSCREEN_INEXIO=3Dm
CONFIG_TOUCHSCREEN_MK712=3Dm
CONFIG_TOUCHSCREEN_PENMOUNT=3Dm
CONFIG_TOUCHSCREEN_EDT_FT5X06=3Dm
CONFIG_TOUCHSCREEN_TOUCHRIGHT=3Dm
CONFIG_TOUCHSCREEN_TOUCHWIN=3Dm
CONFIG_TOUCHSCREEN_TI_AM335X_TSC=3Dm
CONFIG_TOUCHSCREEN_UCB1400=3Dm
CONFIG_TOUCHSCREEN_PIXCIR=3Dm
CONFIG_TOUCHSCREEN_WDT87XX_I2C=3Dm
CONFIG_TOUCHSCREEN_WM831X=3Dm
CONFIG_TOUCHSCREEN_WM97XX=3Dm
CONFIG_TOUCHSCREEN_WM9705=3Dy
CONFIG_TOUCHSCREEN_WM9712=3Dy
CONFIG_TOUCHSCREEN_WM9713=3Dy
CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dm
CONFIG_TOUCHSCREEN_MC13783=3Dm
CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
CONFIG_TOUCHSCREEN_USB_3M=3Dy
CONFIG_TOUCHSCREEN_USB_ITM=3Dy
CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
CONFIG_TOUCHSCREEN_USB_ELO=3Dy
CONFIG_TOUCHSCREEN_USB_E2I=3Dy
CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy
CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy
CONFIG_TOUCHSCREEN_TOUCHIT213=3Dm
CONFIG_TOUCHSCREEN_TSC_SERIO=3Dm
CONFIG_TOUCHSCREEN_TSC200X_CORE=3Dm
CONFIG_TOUCHSCREEN_TSC2004=3Dm
CONFIG_TOUCHSCREEN_TSC2005=3Dm
CONFIG_TOUCHSCREEN_TSC2007=3Dm
CONFIG_TOUCHSCREEN_TSC2007_IIO=3Dy
CONFIG_TOUCHSCREEN_PCAP=3Dm
CONFIG_TOUCHSCREEN_RM_TS=3Dm
CONFIG_TOUCHSCREEN_SILEAD=3Dm
CONFIG_TOUCHSCREEN_SIS_I2C=3Dm
CONFIG_TOUCHSCREEN_ST1232=3Dm
CONFIG_TOUCHSCREEN_STMFTS=3Dm
CONFIG_TOUCHSCREEN_STMPE=3Dm
CONFIG_TOUCHSCREEN_SUR40=3Dm
CONFIG_TOUCHSCREEN_SURFACE3_SPI=3Dm
CONFIG_TOUCHSCREEN_SX8654=3Dm
CONFIG_TOUCHSCREEN_TPS6507X=3Dm
CONFIG_TOUCHSCREEN_ZET6223=3Dm
CONFIG_TOUCHSCREEN_ZFORCE=3Dm
CONFIG_TOUCHSCREEN_COLIBRI_VF50=3Dm
CONFIG_TOUCHSCREEN_ROHM_BU21023=3Dm
CONFIG_TOUCHSCREEN_IQS5XX=3Dm
CONFIG_INPUT_MISC=3Dy
CONFIG_INPUT_88PM860X_ONKEY=3Dm
CONFIG_INPUT_88PM80X_ONKEY=3Dm
CONFIG_INPUT_AD714X=3Dm
CONFIG_INPUT_AD714X_I2C=3Dm
CONFIG_INPUT_AD714X_SPI=3Dm
CONFIG_INPUT_ARIZONA_HAPTICS=3Dm
CONFIG_INPUT_ATMEL_CAPTOUCH=3Dm
CONFIG_INPUT_BMA150=3Dm
CONFIG_INPUT_E3X0_BUTTON=3Dm
CONFIG_INPUT_MSM_VIBRATOR=3Dm
CONFIG_INPUT_PCSPKR=3Dm
CONFIG_INPUT_MAX77650_ONKEY=3Dm
CONFIG_INPUT_MAX77693_HAPTIC=3Dm
CONFIG_INPUT_MAX8925_ONKEY=3Dm
CONFIG_INPUT_MAX8997_HAPTIC=3Dm
CONFIG_INPUT_MC13783_PWRBUTTON=3Dm
CONFIG_INPUT_MMA8450=3Dm
CONFIG_INPUT_APANEL=3Dm
CONFIG_INPUT_GP2A=3Dm
CONFIG_INPUT_GPIO_BEEPER=3Dm
CONFIG_INPUT_GPIO_DECODER=3Dm
CONFIG_INPUT_GPIO_VIBRA=3Dm
CONFIG_INPUT_CPCAP_PWRBUTTON=3Dm
CONFIG_INPUT_ATLAS_BTNS=3Dm
CONFIG_INPUT_ATI_REMOTE2=3Dm
CONFIG_INPUT_KEYSPAN_REMOTE=3Dm
CONFIG_INPUT_KXTJ9=3Dm
CONFIG_INPUT_POWERMATE=3Dm
CONFIG_INPUT_YEALINK=3Dm
CONFIG_INPUT_CM109=3Dm
CONFIG_INPUT_REGULATOR_HAPTIC=3Dm
CONFIG_INPUT_RETU_PWRBUTTON=3Dm
CONFIG_INPUT_TPS65218_PWRBUTTON=3Dm
CONFIG_INPUT_AXP20X_PEK=3Dm
CONFIG_INPUT_TWL4030_PWRBUTTON=3Dm
CONFIG_INPUT_TWL4030_VIBRA=3Dm
CONFIG_INPUT_TWL6040_VIBRA=3Dm
CONFIG_INPUT_UINPUT=3Dm
CONFIG_INPUT_PALMAS_PWRBUTTON=3Dm
CONFIG_INPUT_PCF50633_PMU=3Dm
CONFIG_INPUT_PCF8574=3Dm
CONFIG_INPUT_PWM_BEEPER=3Dm
CONFIG_INPUT_PWM_VIBRA=3Dm
CONFIG_INPUT_RK805_PWRKEY=3Dm
CONFIG_INPUT_GPIO_ROTARY_ENCODER=3Dm
CONFIG_INPUT_DA9052_ONKEY=3Dm
CONFIG_INPUT_DA9055_ONKEY=3Dm
CONFIG_INPUT_DA9063_ONKEY=3Dm
CONFIG_INPUT_WM831X_ON=3Dm
CONFIG_INPUT_PCAP=3Dm
CONFIG_INPUT_ADXL34X=3Dm
CONFIG_INPUT_ADXL34X_I2C=3Dm
CONFIG_INPUT_ADXL34X_SPI=3Dm
CONFIG_INPUT_IMS_PCU=3Dm
CONFIG_INPUT_CMA3000=3Dm
CONFIG_INPUT_CMA3000_I2C=3Dm
CONFIG_INPUT_XEN_KBDDEV_FRONTEND=3Dm
CONFIG_INPUT_IDEAPAD_SLIDEBAR=3Dm
CONFIG_INPUT_SOC_BUTTON_ARRAY=3Dm
CONFIG_INPUT_DRV260X_HAPTICS=3Dm
CONFIG_INPUT_DRV2665_HAPTICS=3Dm
CONFIG_INPUT_DRV2667_HAPTICS=3Dm
CONFIG_INPUT_RAVE_SP_PWRBUTTON=3Dm
CONFIG_INPUT_STPMIC1_ONKEY=3Dm
CONFIG_RMI4_CORE=3Dm
CONFIG_RMI4_I2C=3Dm
CONFIG_RMI4_SPI=3Dm
CONFIG_RMI4_SMB=3Dm
CONFIG_RMI4_F03=3Dy
CONFIG_RMI4_F03_SERIO=3Dm
CONFIG_RMI4_2D_SENSOR=3Dy
CONFIG_RMI4_F11=3Dy
CONFIG_RMI4_F12=3Dy
CONFIG_RMI4_F30=3Dy
CONFIG_RMI4_F34=3Dy
# CONFIG_RMI4_F54 is not set
CONFIG_RMI4_F55=3Dy

#
# Hardware I/O ports
#
CONFIG_SERIO=3Dm
CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
CONFIG_SERIO_I8042=3Dm
CONFIG_SERIO_SERPORT=3Dm
CONFIG_SERIO_CT82C710=3Dm
CONFIG_SERIO_PARKBD=3Dm
CONFIG_SERIO_PCIPS2=3Dm
CONFIG_SERIO_LIBPS2=3Dm
CONFIG_SERIO_RAW=3Dm
CONFIG_SERIO_ALTERA_PS2=3Dm
CONFIG_SERIO_PS2MULT=3Dm
CONFIG_SERIO_ARC_PS2=3Dm
# CONFIG_SERIO_APBPS2 is not set
CONFIG_HYPERV_KEYBOARD=3Dm
CONFIG_SERIO_GPIO_PS2=3Dm
CONFIG_USERIO=3Dm
CONFIG_GAMEPORT=3Dm
CONFIG_GAMEPORT_NS558=3Dm
CONFIG_GAMEPORT_L4=3Dm
CONFIG_GAMEPORT_EMU10K1=3Dm
CONFIG_GAMEPORT_FM801=3Dm
# end of Hardware I/O ports
# end of Input device support

#
# Character devices
#
CONFIG_TTY=3Dy
CONFIG_VT=3Dy
CONFIG_CONSOLE_TRANSLATIONS=3Dy
CONFIG_VT_CONSOLE=3Dy
CONFIG_VT_CONSOLE_SLEEP=3Dy
CONFIG_HW_CONSOLE=3Dy
CONFIG_VT_HW_CONSOLE_BINDING=3Dy
CONFIG_UNIX98_PTYS=3Dy
# CONFIG_LEGACY_PTYS is not set
CONFIG_SERIAL_NONSTANDARD=3Dy
CONFIG_ROCKETPORT=3Dm
CONFIG_CYCLADES=3Dm
CONFIG_CYZ_INTR=3Dy
CONFIG_MOXA_INTELLIO=3Dm
CONFIG_MOXA_SMARTIO=3Dm
CONFIG_SYNCLINK=3Dm
CONFIG_SYNCLINKMP=3Dm
CONFIG_SYNCLINK_GT=3Dm
CONFIG_NOZOMI=3Dm
CONFIG_ISI=3Dm
CONFIG_N_HDLC=3Dm
CONFIG_N_GSM=3Dm
CONFIG_TRACE_ROUTER=3Dm
CONFIG_TRACE_SINK=3Dm
CONFIG_NULL_TTY=3Dm
CONFIG_LDISC_AUTOLOAD=3Dy
CONFIG_DEVMEM=3Dy
# CONFIG_DEVKMEM is not set

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=3Dy
CONFIG_SERIAL_8250=3Dy
# CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
CONFIG_SERIAL_8250_PNP=3Dy
# CONFIG_SERIAL_8250_16550A_VARIANTS is not set
CONFIG_SERIAL_8250_FINTEK=3Dy
CONFIG_SERIAL_8250_CONSOLE=3Dy
CONFIG_SERIAL_8250_DMA=3Dy
CONFIG_SERIAL_8250_PCI=3Dy
CONFIG_SERIAL_8250_EXAR=3Dm
CONFIG_SERIAL_8250_CS=3Dm
CONFIG_SERIAL_8250_MEN_MCB=3Dm
CONFIG_SERIAL_8250_NR_UARTS=3D32
CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
CONFIG_SERIAL_8250_EXTENDED=3Dy
CONFIG_SERIAL_8250_MANY_PORTS=3Dy
CONFIG_SERIAL_8250_ASPEED_VUART=3Dm
CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
# CONFIG_SERIAL_8250_DETECT_IRQ is not set
CONFIG_SERIAL_8250_RSA=3Dy
CONFIG_SERIAL_8250_DWLIB=3Dy
CONFIG_SERIAL_8250_DW=3Dm
CONFIG_SERIAL_8250_RT288X=3Dy
CONFIG_SERIAL_8250_LPSS=3Dy
CONFIG_SERIAL_8250_MID=3Dy
CONFIG_SERIAL_OF_PLATFORM=3Dm

#
# Non-8250 serial port support
#
CONFIG_SERIAL_MAX3100=3Dm
CONFIG_SERIAL_MAX310X=3Dm
CONFIG_SERIAL_UARTLITE=3Dm
CONFIG_SERIAL_UARTLITE_NR_UARTS=3D1
CONFIG_SERIAL_CORE=3Dy
CONFIG_SERIAL_CORE_CONSOLE=3Dy
CONFIG_SERIAL_JSM=3Dm
CONFIG_SERIAL_SIFIVE=3Dm
CONFIG_SERIAL_SCCNXP=3Dm
CONFIG_SERIAL_SC16IS7XX_CORE=3Dm
CONFIG_SERIAL_SC16IS7XX=3Dm
CONFIG_SERIAL_SC16IS7XX_I2C=3Dy
CONFIG_SERIAL_SC16IS7XX_SPI=3Dy
CONFIG_SERIAL_ALTERA_JTAGUART=3Dm
CONFIG_SERIAL_ALTERA_UART=3Dm
CONFIG_SERIAL_ALTERA_UART_MAXPORTS=3D4
CONFIG_SERIAL_ALTERA_UART_BAUDRATE=3D115200
CONFIG_SERIAL_IFX6X60=3Dm
CONFIG_SERIAL_XILINX_PS_UART=3Dm
CONFIG_SERIAL_ARC=3Dm
CONFIG_SERIAL_ARC_NR_PORTS=3D1
CONFIG_SERIAL_RP2=3Dm
CONFIG_SERIAL_RP2_NR_UARTS=3D32
CONFIG_SERIAL_FSL_LPUART=3Dm
CONFIG_SERIAL_FSL_LINFLEXUART=3Dm
CONFIG_SERIAL_CONEXANT_DIGICOLOR=3Dm
CONFIG_SERIAL_MEN_Z135=3Dm
# end of Serial drivers

CONFIG_SERIAL_MCTRL_GPIO=3Dy
CONFIG_SERIAL_DEV_BUS=3Dy
CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy
# CONFIG_TTY_PRINTK is not set
CONFIG_PRINTER=3Dm
# CONFIG_LP_CONSOLE is not set
CONFIG_PPDEV=3Dm
CONFIG_HVC_DRIVER=3Dy
CONFIG_HVC_IRQ=3Dy
CONFIG_HVC_XEN=3Dy
CONFIG_HVC_XEN_FRONTEND=3Dy
CONFIG_VIRTIO_CONSOLE=3Dm
CONFIG_IPMI_HANDLER=3Dm
CONFIG_IPMI_DMI_DECODE=3Dy
CONFIG_IPMI_PLAT_DATA=3Dy
# CONFIG_IPMI_PANIC_EVENT is not set
CONFIG_IPMI_DEVICE_INTERFACE=3Dm
CONFIG_IPMI_SI=3Dm
CONFIG_IPMI_SSIF=3Dm
CONFIG_IPMI_WATCHDOG=3Dm
CONFIG_IPMI_POWEROFF=3Dm
CONFIG_IPMB_DEVICE_INTERFACE=3Dm
CONFIG_HW_RANDOM=3Dm
CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
CONFIG_HW_RANDOM_INTEL=3Dm
CONFIG_HW_RANDOM_AMD=3Dm
CONFIG_HW_RANDOM_VIA=3Dm
CONFIG_HW_RANDOM_VIRTIO=3Dm
CONFIG_NVRAM=3Dm
CONFIG_APPLICOM=3Dm

#
# PCMCIA character devices
#
CONFIG_SYNCLINK_CS=3Dm
CONFIG_CARDMAN_4000=3Dm
CONFIG_CARDMAN_4040=3Dm
CONFIG_SCR24X=3Dm
CONFIG_IPWIRELESS=3Dm
# end of PCMCIA character devices

CONFIG_MWAVE=3Dm
CONFIG_RAW_DRIVER=3Dm
CONFIG_MAX_RAW_DEVS=3D256
CONFIG_HPET=3Dy
CONFIG_HPET_MMAP=3Dy
CONFIG_HPET_MMAP_DEFAULT=3Dy
CONFIG_HANGCHECK_TIMER=3Dm
CONFIG_TCG_TPM=3Dm
CONFIG_HW_RANDOM_TPM=3Dy
CONFIG_TCG_TIS_CORE=3Dm
CONFIG_TCG_TIS=3Dm
CONFIG_TCG_TIS_SPI=3Dm
CONFIG_TCG_TIS_SPI_CR50=3Dy
CONFIG_TCG_TIS_I2C_ATMEL=3Dm
CONFIG_TCG_TIS_I2C_INFINEON=3Dm
CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
CONFIG_TCG_NSC=3Dm
CONFIG_TCG_ATMEL=3Dm
CONFIG_TCG_INFINEON=3Dm
CONFIG_TCG_XEN=3Dm
CONFIG_TCG_CRB=3Dm
CONFIG_TCG_VTPM_PROXY=3Dm
CONFIG_TCG_TIS_ST33ZP24=3Dm
CONFIG_TCG_TIS_ST33ZP24_I2C=3Dm
CONFIG_TCG_TIS_ST33ZP24_SPI=3Dm
CONFIG_TELCLOCK=3Dm
CONFIG_DEVPORT=3Dy
CONFIG_XILLYBUS=3Dm
CONFIG_XILLYBUS_PCIE=3Dm
CONFIG_XILLYBUS_OF=3Dm
# end of Character devices

# CONFIG_RANDOM_TRUST_CPU is not set
# CONFIG_RANDOM_TRUST_BOOTLOADER is not set

#
# I2C support
#
CONFIG_I2C=3Dy
CONFIG_ACPI_I2C_OPREGION=3Dy
CONFIG_I2C_BOARDINFO=3Dy
CONFIG_I2C_COMPAT=3Dy
CONFIG_I2C_CHARDEV=3Dm
CONFIG_I2C_MUX=3Dm

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=3Dm
CONFIG_I2C_MUX_GPIO=3Dm
CONFIG_I2C_MUX_GPMUX=3Dm
CONFIG_I2C_MUX_LTC4306=3Dm
CONFIG_I2C_MUX_PCA9541=3Dm
CONFIG_I2C_MUX_PCA954x=3Dm
CONFIG_I2C_MUX_PINCTRL=3Dm
CONFIG_I2C_MUX_REG=3Dm
CONFIG_I2C_DEMUX_PINCTRL=3Dm
CONFIG_I2C_MUX_MLXCPLD=3Dm
# end of Multiplexer I2C Chip support

CONFIG_I2C_HELPER_AUTO=3Dy
CONFIG_I2C_SMBUS=3Dm
CONFIG_I2C_ALGOBIT=3Dm
CONFIG_I2C_ALGOPCA=3Dm

#
# I2C Hardware Bus support
#

#
# PC SMBus host controller drivers
#
CONFIG_I2C_ALI1535=3Dm
CONFIG_I2C_ALI1563=3Dm
CONFIG_I2C_ALI15X3=3Dm
CONFIG_I2C_AMD756=3Dm
CONFIG_I2C_AMD756_S4882=3Dm
CONFIG_I2C_AMD8111=3Dm
CONFIG_I2C_AMD_MP2=3Dm
CONFIG_I2C_I801=3Dm
CONFIG_I2C_ISCH=3Dm
CONFIG_I2C_ISMT=3Dm
CONFIG_I2C_PIIX4=3Dm
CONFIG_I2C_CHT_WC=3Dm
CONFIG_I2C_NFORCE2=3Dm
CONFIG_I2C_NFORCE2_S4985=3Dm
CONFIG_I2C_NVIDIA_GPU=3Dm
CONFIG_I2C_SIS5595=3Dm
CONFIG_I2C_SIS630=3Dm
CONFIG_I2C_SIS96X=3Dm
CONFIG_I2C_VIA=3Dm
CONFIG_I2C_VIAPRO=3Dm

#
# ACPI drivers
#
CONFIG_I2C_SCMI=3Dm

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
CONFIG_I2C_CBUS_GPIO=3Dm
CONFIG_I2C_DESIGNWARE_CORE=3Dy
CONFIG_I2C_DESIGNWARE_PLATFORM=3Dy
CONFIG_I2C_DESIGNWARE_SLAVE=3Dy
CONFIG_I2C_DESIGNWARE_PCI=3Dm
CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
CONFIG_I2C_EMEV2=3Dm
CONFIG_I2C_GPIO=3Dm
# CONFIG_I2C_GPIO_FAULT_INJECTOR is not set
CONFIG_I2C_KEMPLD=3Dm
CONFIG_I2C_OCORES=3Dm
CONFIG_I2C_PCA_PLATFORM=3Dm
CONFIG_I2C_RK3X=3Dm
CONFIG_I2C_SIMTEC=3Dm
CONFIG_I2C_XILINX=3Dm

#
# External I2C/SMBus adapter drivers
#
CONFIG_I2C_DIOLAN_U2C=3Dm
CONFIG_I2C_DLN2=3Dm
CONFIG_I2C_PARPORT=3Dm
CONFIG_I2C_ROBOTFUZZ_OSIF=3Dm
CONFIG_I2C_TAOS_EVM=3Dm
CONFIG_I2C_TINY_USB=3Dm
CONFIG_I2C_VIPERBOARD=3Dm

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_MLXCPLD=3Dm
CONFIG_I2C_CROS_EC_TUNNEL=3Dm
CONFIG_I2C_FSI=3Dm
# end of I2C Hardware Bus support

CONFIG_I2C_STUB=3Dm
CONFIG_I2C_SLAVE=3Dy
CONFIG_I2C_SLAVE_EEPROM=3Dm
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
# end of I2C support

CONFIG_I3C=3Dm
CONFIG_CDNS_I3C_MASTER=3Dm
CONFIG_DW_I3C_MASTER=3Dm
CONFIG_SPI=3Dy
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=3Dy
CONFIG_SPI_MEM=3Dy

#
# SPI Master Controller Drivers
#
CONFIG_SPI_ALTERA=3Dm
CONFIG_SPI_AXI_SPI_ENGINE=3Dm
CONFIG_SPI_BITBANG=3Dm
CONFIG_SPI_BUTTERFLY=3Dm
CONFIG_SPI_CADENCE=3Dm
CONFIG_SPI_DESIGNWARE=3Dm
CONFIG_SPI_DW_PCI=3Dm
CONFIG_SPI_DW_MID_DMA=3Dy
CONFIG_SPI_DW_MMIO=3Dm
CONFIG_SPI_DLN2=3Dm
CONFIG_SPI_NXP_FLEXSPI=3Dm
CONFIG_SPI_GPIO=3Dm
CONFIG_SPI_LM70_LLP=3Dm
CONFIG_SPI_FSL_LIB=3Dm
CONFIG_SPI_FSL_SPI=3Dm
CONFIG_SPI_OC_TINY=3Dm
CONFIG_SPI_PXA2XX=3Dm
CONFIG_SPI_PXA2XX_PCI=3Dm
CONFIG_SPI_ROCKCHIP=3Dm
CONFIG_SPI_SC18IS602=3Dm
CONFIG_SPI_SIFIVE=3Dm
CONFIG_SPI_MXIC=3Dm
CONFIG_SPI_XCOMM=3Dm
CONFIG_SPI_XILINX=3Dm
CONFIG_SPI_ZYNQMP_GQSPI=3Dm

#
# SPI Protocol Masters
#
CONFIG_SPI_SPIDEV=3Dm
CONFIG_SPI_LOOPBACK_TEST=3Dm
CONFIG_SPI_TLE62X0=3Dm
CONFIG_SPI_SLAVE=3Dy
CONFIG_SPI_SLAVE_TIME=3Dm
CONFIG_SPI_SLAVE_SYSTEM_CONTROL=3Dm
CONFIG_SPMI=3Dm
CONFIG_HSI=3Dm
CONFIG_HSI_BOARDINFO=3Dy

#
# HSI controllers
#

#
# HSI clients
#
CONFIG_HSI_CHAR=3Dm
CONFIG_PPS=3Dy
# CONFIG_PPS_DEBUG is not set

#
# PPS clients support
#
CONFIG_PPS_CLIENT_KTIMER=3Dm
CONFIG_PPS_CLIENT_LDISC=3Dm
CONFIG_PPS_CLIENT_PARPORT=3Dm
CONFIG_PPS_CLIENT_GPIO=3Dm

#
# PPS generators support
#

#
# PTP clock support
#
CONFIG_PTP_1588_CLOCK=3Dy
CONFIG_DP83640_PHY=3Dm
CONFIG_PTP_1588_CLOCK_INES=3Dm
CONFIG_PTP_1588_CLOCK_KVM=3Dm
CONFIG_PTP_1588_CLOCK_IDTCM=3Dm
# end of PTP clock support

CONFIG_PINCTRL=3Dy
CONFIG_GENERIC_PINCTRL_GROUPS=3Dy
CONFIG_PINMUX=3Dy
CONFIG_GENERIC_PINMUX_FUNCTIONS=3Dy
CONFIG_PINCONF=3Dy
CONFIG_GENERIC_PINCONF=3Dy
# CONFIG_DEBUG_PINCTRL is not set
CONFIG_PINCTRL_AS3722=3Dm
CONFIG_PINCTRL_AXP209=3Dm
CONFIG_PINCTRL_AMD=3Dm
CONFIG_PINCTRL_MCP23S08=3Dm
CONFIG_PINCTRL_SINGLE=3Dm
CONFIG_PINCTRL_SX150X=3Dy
CONFIG_PINCTRL_STMFX=3Dm
CONFIG_PINCTRL_MAX77620=3Dm
CONFIG_PINCTRL_PALMAS=3Dm
CONFIG_PINCTRL_RK805=3Dm
CONFIG_PINCTRL_OCELOT=3Dy
CONFIG_PINCTRL_BAYTRAIL=3Dy
CONFIG_PINCTRL_CHERRYVIEW=3Dy
CONFIG_PINCTRL_LYNXPOINT=3Dy
CONFIG_PINCTRL_INTEL=3Dy
CONFIG_PINCTRL_BROXTON=3Dy
CONFIG_PINCTRL_CANNONLAKE=3Dy
CONFIG_PINCTRL_CEDARFORK=3Dy
CONFIG_PINCTRL_DENVERTON=3Dy
CONFIG_PINCTRL_GEMINILAKE=3Dy
CONFIG_PINCTRL_ICELAKE=3Dy
CONFIG_PINCTRL_LEWISBURG=3Dy
CONFIG_PINCTRL_SUNRISEPOINT=3Dy
CONFIG_PINCTRL_TIGERLAKE=3Dy
CONFIG_PINCTRL_LOCHNAGAR=3Dm
CONFIG_PINCTRL_MADERA=3Dm
CONFIG_PINCTRL_CS47L15=3Dy
CONFIG_PINCTRL_CS47L35=3Dy
CONFIG_PINCTRL_CS47L85=3Dy
CONFIG_PINCTRL_CS47L90=3Dy
CONFIG_PINCTRL_CS47L92=3Dy
CONFIG_PINCTRL_EQUILIBRIUM=3Dm
CONFIG_GPIOLIB=3Dy
CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
CONFIG_OF_GPIO=3Dy
CONFIG_GPIO_ACPI=3Dy
CONFIG_GPIOLIB_IRQCHIP=3Dy
# CONFIG_DEBUG_GPIO is not set
CONFIG_GPIO_SYSFS=3Dy
CONFIG_GPIO_GENERIC=3Dy
CONFIG_GPIO_MAX730X=3Dm

#
# Memory mapped GPIO drivers
#
CONFIG_GPIO_74XX_MMIO=3Dm
CONFIG_GPIO_ALTERA=3Dm
CONFIG_GPIO_AMDPT=3Dm
CONFIG_GPIO_CADENCE=3Dm
CONFIG_GPIO_DWAPB=3Dm
CONFIG_GPIO_EXAR=3Dm
CONFIG_GPIO_FTGPIO010=3Dy
CONFIG_GPIO_GENERIC_PLATFORM=3Dm
CONFIG_GPIO_GRGPIO=3Dm
CONFIG_GPIO_HLWD=3Dm
CONFIG_GPIO_ICH=3Dm
CONFIG_GPIO_LOGICVC=3Dm
CONFIG_GPIO_MB86S7X=3Dm
CONFIG_GPIO_MENZ127=3Dm
CONFIG_GPIO_SAMA5D2_PIOBU=3Dm
CONFIG_GPIO_SIFIVE=3Dy
CONFIG_GPIO_SIOX=3Dm
CONFIG_GPIO_SYSCON=3Dm
CONFIG_GPIO_VX855=3Dm
CONFIG_GPIO_WCD934X=3Dm
CONFIG_GPIO_XILINX=3Dm
CONFIG_GPIO_AMD_FCH=3Dm
# end of Memory mapped GPIO drivers

#
# Port-mapped I/O GPIO drivers
#
CONFIG_GPIO_F7188X=3Dm
CONFIG_GPIO_IT87=3Dm
CONFIG_GPIO_SCH=3Dm
CONFIG_GPIO_SCH311X=3Dm
CONFIG_GPIO_WINBOND=3Dm
CONFIG_GPIO_WS16C48=3Dm
# end of Port-mapped I/O GPIO drivers

#
# I2C GPIO expanders
#
CONFIG_GPIO_ADP5588=3Dm
CONFIG_GPIO_ADNP=3Dm
CONFIG_GPIO_GW_PLD=3Dm
CONFIG_GPIO_MAX7300=3Dm
CONFIG_GPIO_MAX732X=3Dm
CONFIG_GPIO_PCA953X=3Dm
CONFIG_GPIO_PCF857X=3Dm
CONFIG_GPIO_TPIC2810=3Dm
# end of I2C GPIO expanders

#
# MFD GPIO expanders
#
CONFIG_GPIO_ADP5520=3Dm
CONFIG_GPIO_ARIZONA=3Dm
CONFIG_GPIO_BD70528=3Dm
CONFIG_GPIO_BD71828=3Dm
CONFIG_GPIO_BD9571MWV=3Dm
CONFIG_GPIO_CRYSTAL_COVE=3Dm
CONFIG_GPIO_DA9052=3Dm
CONFIG_GPIO_DA9055=3Dm
CONFIG_GPIO_DLN2=3Dm
CONFIG_GPIO_JANZ_TTL=3Dm
CONFIG_GPIO_KEMPLD=3Dm
CONFIG_GPIO_LP3943=3Dm
CONFIG_GPIO_LP873X=3Dm
CONFIG_GPIO_LP87565=3Dm
CONFIG_GPIO_MADERA=3Dm
CONFIG_GPIO_MAX77620=3Dm
CONFIG_GPIO_MAX77650=3Dm
CONFIG_GPIO_PALMAS=3Dy
CONFIG_GPIO_RC5T583=3Dy
CONFIG_GPIO_STMPE=3Dy
CONFIG_GPIO_TC3589X=3Dy
CONFIG_GPIO_TPS65086=3Dm
CONFIG_GPIO_TPS65218=3Dm
CONFIG_GPIO_TPS6586X=3Dy
CONFIG_GPIO_TPS65910=3Dy
CONFIG_GPIO_TPS65912=3Dm
CONFIG_GPIO_TPS68470=3Dy
CONFIG_GPIO_TQMX86=3Dm
CONFIG_GPIO_TWL4030=3Dm
CONFIG_GPIO_TWL6040=3Dm
CONFIG_GPIO_UCB1400=3Dm
CONFIG_GPIO_WHISKEY_COVE=3Dm
CONFIG_GPIO_WM831X=3Dm
CONFIG_GPIO_WM8350=3Dm
CONFIG_GPIO_WM8994=3Dm
# end of MFD GPIO expanders

#
# PCI GPIO expanders
#
CONFIG_GPIO_AMD8111=3Dm
CONFIG_GPIO_ML_IOH=3Dm
CONFIG_GPIO_PCI_IDIO_16=3Dm
CONFIG_GPIO_PCIE_IDIO_24=3Dm
CONFIG_GPIO_RDC321X=3Dm
CONFIG_GPIO_SODAVILLE=3Dy
# end of PCI GPIO expanders

#
# SPI GPIO expanders
#
CONFIG_GPIO_74X164=3Dm
CONFIG_GPIO_MAX3191X=3Dm
CONFIG_GPIO_MAX7301=3Dm
CONFIG_GPIO_MC33880=3Dm
CONFIG_GPIO_PISOSR=3Dm
CONFIG_GPIO_XRA1403=3Dm
CONFIG_GPIO_MOXTET=3Dm
# end of SPI GPIO expanders

#
# USB GPIO expanders
#
CONFIG_GPIO_VIPERBOARD=3Dm
# end of USB GPIO expanders

CONFIG_GPIO_MOCKUP=3Dm
CONFIG_W1=3Dm
CONFIG_W1_CON=3Dy

#
# 1-wire Bus Masters
#
CONFIG_W1_MASTER_MATROX=3Dm
CONFIG_W1_MASTER_DS2490=3Dm
CONFIG_W1_MASTER_DS2482=3Dm
CONFIG_W1_MASTER_DS1WM=3Dm
CONFIG_W1_MASTER_GPIO=3Dm
CONFIG_W1_MASTER_SGI=3Dm
# end of 1-wire Bus Masters

#
# 1-wire Slaves
#
CONFIG_W1_SLAVE_THERM=3Dm
CONFIG_W1_SLAVE_SMEM=3Dm
CONFIG_W1_SLAVE_DS2405=3Dm
CONFIG_W1_SLAVE_DS2408=3Dm
# CONFIG_W1_SLAVE_DS2408_READBACK is not set
CONFIG_W1_SLAVE_DS2413=3Dm
CONFIG_W1_SLAVE_DS2406=3Dm
CONFIG_W1_SLAVE_DS2423=3Dm
CONFIG_W1_SLAVE_DS2805=3Dm
CONFIG_W1_SLAVE_DS2430=3Dm
CONFIG_W1_SLAVE_DS2431=3Dm
CONFIG_W1_SLAVE_DS2433=3Dm
# CONFIG_W1_SLAVE_DS2433_CRC is not set
CONFIG_W1_SLAVE_DS2438=3Dm
CONFIG_W1_SLAVE_DS250X=3Dm
CONFIG_W1_SLAVE_DS2780=3Dm
CONFIG_W1_SLAVE_DS2781=3Dm
CONFIG_W1_SLAVE_DS28E04=3Dm
CONFIG_W1_SLAVE_DS28E17=3Dm
# end of 1-wire Slaves

CONFIG_POWER_AVS=3Dy
CONFIG_QCOM_CPR=3Dm
CONFIG_POWER_RESET=3Dy
CONFIG_POWER_RESET_AS3722=3Dy
CONFIG_POWER_RESET_GPIO=3Dy
CONFIG_POWER_RESET_GPIO_RESTART=3Dy
CONFIG_POWER_RESET_LTC2952=3Dy
CONFIG_POWER_RESET_MT6323=3Dy
CONFIG_POWER_RESET_RESTART=3Dy
CONFIG_POWER_RESET_SYSCON=3Dy
CONFIG_POWER_RESET_SYSCON_POWEROFF=3Dy
CONFIG_REBOOT_MODE=3Dm
CONFIG_SYSCON_REBOOT_MODE=3Dm
CONFIG_NVMEM_REBOOT_MODE=3Dm
CONFIG_POWER_SUPPLY=3Dy
# CONFIG_POWER_SUPPLY_DEBUG is not set
CONFIG_POWER_SUPPLY_HWMON=3Dy
CONFIG_PDA_POWER=3Dm
CONFIG_GENERIC_ADC_BATTERY=3Dm
CONFIG_MAX8925_POWER=3Dm
CONFIG_WM831X_BACKUP=3Dm
CONFIG_WM831X_POWER=3Dm
CONFIG_WM8350_POWER=3Dm
CONFIG_TEST_POWER=3Dm
CONFIG_BATTERY_88PM860X=3Dm
CONFIG_CHARGER_ADP5061=3Dm
CONFIG_BATTERY_ACT8945A=3Dm
CONFIG_BATTERY_CPCAP=3Dm
CONFIG_BATTERY_DS2760=3Dm
CONFIG_BATTERY_DS2780=3Dm
CONFIG_BATTERY_DS2781=3Dm
CONFIG_BATTERY_DS2782=3Dm
CONFIG_BATTERY_LEGO_EV3=3Dm
CONFIG_BATTERY_SBS=3Dm
CONFIG_CHARGER_SBS=3Dm
CONFIG_MANAGER_SBS=3Dm
CONFIG_BATTERY_BQ27XXX=3Dm
CONFIG_BATTERY_BQ27XXX_I2C=3Dm
CONFIG_BATTERY_BQ27XXX_HDQ=3Dm
# CONFIG_BATTERY_BQ27XXX_DT_UPDATES_NVM is not set
CONFIG_BATTERY_DA9030=3Dm
CONFIG_BATTERY_DA9052=3Dm
CONFIG_CHARGER_DA9150=3Dm
CONFIG_BATTERY_DA9150=3Dm
CONFIG_CHARGER_AXP20X=3Dm
CONFIG_BATTERY_AXP20X=3Dm
CONFIG_AXP20X_POWER=3Dm
CONFIG_AXP288_CHARGER=3Dm
CONFIG_AXP288_FUEL_GAUGE=3Dm
CONFIG_BATTERY_MAX17040=3Dm
CONFIG_BATTERY_MAX17042=3Dm
CONFIG_BATTERY_MAX1721X=3Dm
CONFIG_BATTERY_TWL4030_MADC=3Dm
CONFIG_CHARGER_88PM860X=3Dm
CONFIG_CHARGER_PCF50633=3Dm
CONFIG_BATTERY_RX51=3Dm
CONFIG_CHARGER_ISP1704=3Dm
CONFIG_CHARGER_MAX8903=3Dm
CONFIG_CHARGER_TWL4030=3Dm
CONFIG_CHARGER_LP8727=3Dm
CONFIG_CHARGER_LP8788=3Dm
CONFIG_CHARGER_GPIO=3Dm
CONFIG_CHARGER_MANAGER=3Dy
CONFIG_CHARGER_LT3651=3Dm
CONFIG_CHARGER_MAX14577=3Dm
CONFIG_CHARGER_DETECTOR_MAX14656=3Dm
CONFIG_CHARGER_MAX77650=3Dm
CONFIG_CHARGER_MAX77693=3Dm
CONFIG_CHARGER_MAX8997=3Dm
CONFIG_CHARGER_MAX8998=3Dm
CONFIG_CHARGER_BQ2415X=3Dm
CONFIG_CHARGER_BQ24190=3Dm
CONFIG_CHARGER_BQ24257=3Dm
CONFIG_CHARGER_BQ24735=3Dm
CONFIG_CHARGER_BQ25890=3Dm
CONFIG_CHARGER_SMB347=3Dm
CONFIG_CHARGER_TPS65090=3Dm
CONFIG_CHARGER_TPS65217=3Dm
CONFIG_BATTERY_GAUGE_LTC2941=3Dm
CONFIG_BATTERY_RT5033=3Dm
CONFIG_CHARGER_RT9455=3Dm
CONFIG_CHARGER_CROS_USBPD=3Dm
CONFIG_CHARGER_UCS1002=3Dm
CONFIG_CHARGER_BD70528=3Dm
CONFIG_CHARGER_WILCO=3Dm
CONFIG_HWMON=3Dy
CONFIG_HWMON_VID=3Dm
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
CONFIG_SENSORS_ABITUGURU=3Dm
CONFIG_SENSORS_ABITUGURU3=3Dm
CONFIG_SENSORS_AD7314=3Dm
CONFIG_SENSORS_AD7414=3Dm
CONFIG_SENSORS_AD7418=3Dm
CONFIG_SENSORS_ADM1021=3Dm
CONFIG_SENSORS_ADM1025=3Dm
CONFIG_SENSORS_ADM1026=3Dm
CONFIG_SENSORS_ADM1029=3Dm
CONFIG_SENSORS_ADM1031=3Dm
CONFIG_SENSORS_ADM1177=3Dm
CONFIG_SENSORS_ADM9240=3Dm
CONFIG_SENSORS_ADT7X10=3Dm
CONFIG_SENSORS_ADT7310=3Dm
CONFIG_SENSORS_ADT7410=3Dm
CONFIG_SENSORS_ADT7411=3Dm
CONFIG_SENSORS_ADT7462=3Dm
CONFIG_SENSORS_ADT7470=3Dm
CONFIG_SENSORS_ADT7475=3Dm
CONFIG_SENSORS_AS370=3Dm
CONFIG_SENSORS_ASC7621=3Dm
CONFIG_SENSORS_K8TEMP=3Dm
CONFIG_SENSORS_K10TEMP=3Dm
CONFIG_SENSORS_FAM15H_POWER=3Dm
CONFIG_SENSORS_APPLESMC=3Dm
CONFIG_SENSORS_ASB100=3Dm
CONFIG_SENSORS_ASPEED=3Dm
CONFIG_SENSORS_ATXP1=3Dm
CONFIG_SENSORS_DRIVETEMP=3Dm
CONFIG_SENSORS_DS620=3Dm
CONFIG_SENSORS_DS1621=3Dm
CONFIG_SENSORS_DELL_SMM=3Dm
CONFIG_SENSORS_DA9052_ADC=3Dm
CONFIG_SENSORS_DA9055=3Dm
CONFIG_SENSORS_I5K_AMB=3Dm
CONFIG_SENSORS_F71805F=3Dm
CONFIG_SENSORS_F71882FG=3Dm
CONFIG_SENSORS_F75375S=3Dm
CONFIG_SENSORS_MC13783_ADC=3Dm
CONFIG_SENSORS_FSCHMD=3Dm
CONFIG_SENSORS_FTSTEUTATES=3Dm
CONFIG_SENSORS_GL518SM=3Dm
CONFIG_SENSORS_GL520SM=3Dm
CONFIG_SENSORS_G760A=3Dm
CONFIG_SENSORS_G762=3Dm
CONFIG_SENSORS_GPIO_FAN=3Dm
CONFIG_SENSORS_HIH6130=3Dm
CONFIG_SENSORS_IBMAEM=3Dm
CONFIG_SENSORS_IBMPEX=3Dm
CONFIG_SENSORS_IIO_HWMON=3Dm
CONFIG_SENSORS_I5500=3Dm
CONFIG_SENSORS_CORETEMP=3Dm
CONFIG_SENSORS_IT87=3Dm
CONFIG_SENSORS_JC42=3Dm
CONFIG_SENSORS_POWR1220=3Dm
CONFIG_SENSORS_LINEAGE=3Dm
CONFIG_SENSORS_LOCHNAGAR=3Dm
CONFIG_SENSORS_LTC2945=3Dm
CONFIG_SENSORS_LTC2947=3Dm
CONFIG_SENSORS_LTC2947_I2C=3Dm
CONFIG_SENSORS_LTC2947_SPI=3Dm
CONFIG_SENSORS_LTC2990=3Dm
CONFIG_SENSORS_LTC4151=3Dm
CONFIG_SENSORS_LTC4215=3Dm
CONFIG_SENSORS_LTC4222=3Dm
CONFIG_SENSORS_LTC4245=3Dm
CONFIG_SENSORS_LTC4260=3Dm
CONFIG_SENSORS_LTC4261=3Dm
CONFIG_SENSORS_MAX1111=3Dm
CONFIG_SENSORS_MAX16065=3Dm
CONFIG_SENSORS_MAX1619=3Dm
CONFIG_SENSORS_MAX1668=3Dm
CONFIG_SENSORS_MAX197=3Dm
CONFIG_SENSORS_MAX31722=3Dm
CONFIG_SENSORS_MAX31730=3Dm
CONFIG_SENSORS_MAX6621=3Dm
CONFIG_SENSORS_MAX6639=3Dm
CONFIG_SENSORS_MAX6642=3Dm
CONFIG_SENSORS_MAX6650=3Dm
CONFIG_SENSORS_MAX6697=3Dm
CONFIG_SENSORS_MAX31790=3Dm
CONFIG_SENSORS_MCP3021=3Dm
CONFIG_SENSORS_MLXREG_FAN=3Dm
CONFIG_SENSORS_TC654=3Dm
CONFIG_SENSORS_MENF21BMC_HWMON=3Dm
CONFIG_SENSORS_ADCXX=3Dm
CONFIG_SENSORS_LM63=3Dm
CONFIG_SENSORS_LM70=3Dm
CONFIG_SENSORS_LM73=3Dm
CONFIG_SENSORS_LM75=3Dm
CONFIG_SENSORS_LM77=3Dm
CONFIG_SENSORS_LM78=3Dm
CONFIG_SENSORS_LM80=3Dm
CONFIG_SENSORS_LM83=3Dm
CONFIG_SENSORS_LM85=3Dm
CONFIG_SENSORS_LM87=3Dm
CONFIG_SENSORS_LM90=3Dm
CONFIG_SENSORS_LM92=3Dm
CONFIG_SENSORS_LM93=3Dm
CONFIG_SENSORS_LM95234=3Dm
CONFIG_SENSORS_LM95241=3Dm
CONFIG_SENSORS_LM95245=3Dm
CONFIG_SENSORS_PC87360=3Dm
CONFIG_SENSORS_PC87427=3Dm
CONFIG_SENSORS_NTC_THERMISTOR=3Dm
CONFIG_SENSORS_NCT6683=3Dm
CONFIG_SENSORS_NCT6775=3Dm
CONFIG_SENSORS_NCT7802=3Dm
CONFIG_SENSORS_NCT7904=3Dm
CONFIG_SENSORS_NPCM7XX=3Dm
CONFIG_SENSORS_PCF8591=3Dm
CONFIG_PMBUS=3Dm
CONFIG_SENSORS_PMBUS=3Dm
CONFIG_SENSORS_ADM1275=3Dm
CONFIG_SENSORS_BEL_PFE=3Dm
CONFIG_SENSORS_IBM_CFFPS=3Dm
CONFIG_SENSORS_INSPUR_IPSPS=3Dm
CONFIG_SENSORS_IR35221=3Dm
CONFIG_SENSORS_IR38064=3Dm
CONFIG_SENSORS_IRPS5401=3Dm
CONFIG_SENSORS_ISL68137=3Dm
CONFIG_SENSORS_LM25066=3Dm
CONFIG_SENSORS_LTC2978=3Dm
# CONFIG_SENSORS_LTC2978_REGULATOR is not set
CONFIG_SENSORS_LTC3815=3Dm
CONFIG_SENSORS_MAX16064=3Dm
CONFIG_SENSORS_MAX20730=3Dm
CONFIG_SENSORS_MAX20751=3Dm
CONFIG_SENSORS_MAX31785=3Dm
CONFIG_SENSORS_MAX34440=3Dm
CONFIG_SENSORS_MAX8688=3Dm
CONFIG_SENSORS_PXE1610=3Dm
CONFIG_SENSORS_TPS40422=3Dm
CONFIG_SENSORS_TPS53679=3Dm
CONFIG_SENSORS_UCD9000=3Dm
CONFIG_SENSORS_UCD9200=3Dm
CONFIG_SENSORS_XDPE122=3Dm
CONFIG_SENSORS_ZL6100=3Dm
CONFIG_SENSORS_PWM_FAN=3Dm
CONFIG_SENSORS_SHT15=3Dm
CONFIG_SENSORS_SHT21=3Dm
CONFIG_SENSORS_SHT3x=3Dm
CONFIG_SENSORS_SHTC1=3Dm
CONFIG_SENSORS_SIS5595=3Dm
CONFIG_SENSORS_DME1737=3Dm
CONFIG_SENSORS_EMC1403=3Dm
CONFIG_SENSORS_EMC2103=3Dm
CONFIG_SENSORS_EMC6W201=3Dm
CONFIG_SENSORS_SMSC47M1=3Dm
CONFIG_SENSORS_SMSC47M192=3Dm
CONFIG_SENSORS_SMSC47B397=3Dm
CONFIG_SENSORS_SCH56XX_COMMON=3Dm
CONFIG_SENSORS_SCH5627=3Dm
CONFIG_SENSORS_SCH5636=3Dm
CONFIG_SENSORS_STTS751=3Dm
CONFIG_SENSORS_SMM665=3Dm
CONFIG_SENSORS_ADC128D818=3Dm
CONFIG_SENSORS_ADS7828=3Dm
CONFIG_SENSORS_ADS7871=3Dm
CONFIG_SENSORS_AMC6821=3Dm
CONFIG_SENSORS_INA209=3Dm
CONFIG_SENSORS_INA2XX=3Dm
CONFIG_SENSORS_INA3221=3Dm
CONFIG_SENSORS_TC74=3Dm
CONFIG_SENSORS_THMC50=3Dm
CONFIG_SENSORS_TMP102=3Dm
CONFIG_SENSORS_TMP103=3Dm
CONFIG_SENSORS_TMP108=3Dm
CONFIG_SENSORS_TMP401=3Dm
CONFIG_SENSORS_TMP421=3Dm
CONFIG_SENSORS_TMP513=3Dm
CONFIG_SENSORS_VIA_CPUTEMP=3Dm
CONFIG_SENSORS_VIA686A=3Dm
CONFIG_SENSORS_VT1211=3Dm
CONFIG_SENSORS_VT8231=3Dm
CONFIG_SENSORS_W83773G=3Dm
CONFIG_SENSORS_W83781D=3Dm
CONFIG_SENSORS_W83791D=3Dm
CONFIG_SENSORS_W83792D=3Dm
CONFIG_SENSORS_W83793=3Dm
CONFIG_SENSORS_W83795=3Dm
# CONFIG_SENSORS_W83795_FANCTRL is not set
CONFIG_SENSORS_W83L785TS=3Dm
CONFIG_SENSORS_W83L786NG=3Dm
CONFIG_SENSORS_W83627HF=3Dm
CONFIG_SENSORS_W83627EHF=3Dm
CONFIG_SENSORS_WM831X=3Dm
CONFIG_SENSORS_WM8350=3Dm
CONFIG_SENSORS_XGENE=3Dm

#
# ACPI drivers
#
CONFIG_SENSORS_ACPI_POWER=3Dm
CONFIG_SENSORS_ATK0110=3Dm
CONFIG_THERMAL=3Dy
# CONFIG_THERMAL_STATISTICS is not set
CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D100
CONFIG_THERMAL_HWMON=3Dy
CONFIG_THERMAL_OF=3Dy
CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
CONFIG_THERMAL_GOV_STEP_WISE=3Dy
CONFIG_THERMAL_GOV_BANG_BANG=3Dy
CONFIG_THERMAL_GOV_USER_SPACE=3Dy
CONFIG_THERMAL_GOV_POWER_ALLOCATOR=3Dy
CONFIG_CPU_THERMAL=3Dy
CONFIG_CPU_FREQ_THERMAL=3Dy
CONFIG_CPU_IDLE_THERMAL=3Dy
CONFIG_CLOCK_THERMAL=3Dy
CONFIG_DEVFREQ_THERMAL=3Dy
# CONFIG_THERMAL_EMULATION is not set
CONFIG_THERMAL_MMIO=3Dm
CONFIG_MAX77620_THERMAL=3Dm
CONFIG_QORIQ_THERMAL=3Dm
CONFIG_DA9062_THERMAL=3Dm

#
# Intel thermal drivers
#
CONFIG_INTEL_POWERCLAMP=3Dm
CONFIG_X86_PKG_TEMP_THERMAL=3Dm
CONFIG_INTEL_SOC_DTS_IOSF_CORE=3Dm
CONFIG_INTEL_SOC_DTS_THERMAL=3Dm

#
# ACPI INT340X thermal drivers
#
CONFIG_INT340X_THERMAL=3Dm
CONFIG_ACPI_THERMAL_REL=3Dm
CONFIG_INT3406_THERMAL=3Dm
CONFIG_PROC_THERMAL_MMIO_RAPL=3Dy
# end of ACPI INT340X thermal drivers

CONFIG_INTEL_BXT_PMIC_THERMAL=3Dm
CONFIG_INTEL_PCH_THERMAL=3Dm
# end of Intel thermal drivers

CONFIG_GENERIC_ADC_THERMAL=3Dm
CONFIG_WATCHDOG=3Dy
CONFIG_WATCHDOG_CORE=3Dy
# CONFIG_WATCHDOG_NOWAYOUT is not set
CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
CONFIG_WATCHDOG_SYSFS=3Dy

#
# Watchdog Pretimeout Governors
#
CONFIG_WATCHDOG_PRETIMEOUT_GOV=3Dy
CONFIG_WATCHDOG_PRETIMEOUT_GOV_SEL=3Dm
CONFIG_WATCHDOG_PRETIMEOUT_GOV_NOOP=3Dm
CONFIG_WATCHDOG_PRETIMEOUT_GOV_PANIC=3Dy
# CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_NOOP is not set
CONFIG_WATCHDOG_PRETIMEOUT_DEFAULT_GOV_PANIC=3Dy

#
# Watchdog Device Drivers
#
CONFIG_SOFT_WATCHDOG=3Dm
# CONFIG_SOFT_WATCHDOG_PRETIMEOUT is not set
CONFIG_BD70528_WATCHDOG=3Dm
CONFIG_DA9052_WATCHDOG=3Dm
CONFIG_DA9055_WATCHDOG=3Dm
CONFIG_DA9063_WATCHDOG=3Dm
CONFIG_DA9062_WATCHDOG=3Dm
CONFIG_GPIO_WATCHDOG=3Dm
CONFIG_MENF21BMC_WATCHDOG=3Dm
CONFIG_MENZ069_WATCHDOG=3Dm
CONFIG_WDAT_WDT=3Dm
CONFIG_WM831X_WATCHDOG=3Dm
CONFIG_WM8350_WATCHDOG=3Dm
CONFIG_XILINX_WATCHDOG=3Dm
CONFIG_ZIIRAVE_WATCHDOG=3Dm
CONFIG_RAVE_SP_WATCHDOG=3Dm
CONFIG_MLX_WDT=3Dm
CONFIG_CADENCE_WATCHDOG=3Dm
CONFIG_DW_WATCHDOG=3Dm
CONFIG_RN5T618_WATCHDOG=3Dm
CONFIG_TWL4030_WATCHDOG=3Dm
CONFIG_MAX63XX_WATCHDOG=3Dm
CONFIG_MAX77620_WATCHDOG=3Dm
CONFIG_RETU_WATCHDOG=3Dm
CONFIG_STPMIC1_WATCHDOG=3Dm
CONFIG_ACQUIRE_WDT=3Dm
CONFIG_ADVANTECH_WDT=3Dm
CONFIG_ALIM1535_WDT=3Dm
CONFIG_ALIM7101_WDT=3Dm
CONFIG_EBC_C384_WDT=3Dm
CONFIG_F71808E_WDT=3Dm
CONFIG_SP5100_TCO=3Dm
CONFIG_SBC_FITPC2_WATCHDOG=3Dm
CONFIG_EUROTECH_WDT=3Dm
CONFIG_IB700_WDT=3Dm
CONFIG_IBMASR=3Dm
CONFIG_WAFER_WDT=3Dm
CONFIG_I6300ESB_WDT=3Dm
CONFIG_IE6XX_WDT=3Dm
CONFIG_ITCO_WDT=3Dm
CONFIG_ITCO_VENDOR_SUPPORT=3Dy
CONFIG_IT8712F_WDT=3Dm
CONFIG_IT87_WDT=3Dm
CONFIG_HP_WATCHDOG=3Dm
CONFIG_HPWDT_NMI_DECODING=3Dy
CONFIG_KEMPLD_WDT=3Dm
CONFIG_SC1200_WDT=3Dm
CONFIG_PC87413_WDT=3Dm
CONFIG_NV_TCO=3Dm
CONFIG_60XX_WDT=3Dm
CONFIG_CPU5_WDT=3Dm
CONFIG_SMSC_SCH311X_WDT=3Dm
CONFIG_SMSC37B787_WDT=3Dm
CONFIG_TQMX86_WDT=3Dm
CONFIG_VIA_WDT=3Dm
CONFIG_W83627HF_WDT=3Dm
CONFIG_W83877F_WDT=3Dm
CONFIG_W83977F_WDT=3Dm
CONFIG_MACHZ_WDT=3Dm
CONFIG_SBC_EPX_C3_WATCHDOG=3Dm
CONFIG_INTEL_MEI_WDT=3Dm
CONFIG_NI903X_WDT=3Dm
CONFIG_NIC7018_WDT=3Dm
CONFIG_MEN_A21_WDT=3Dm
CONFIG_XEN_WDT=3Dm

#
# PCI-based Watchdog Cards
#
CONFIG_PCIPCWATCHDOG=3Dm
CONFIG_WDTPCI=3Dm

#
# USB-based Watchdog Cards
#
CONFIG_USBPCWATCHDOG=3Dm
CONFIG_SSB_POSSIBLE=3Dy
CONFIG_SSB=3Dm
CONFIG_SSB_SPROM=3Dy
CONFIG_SSB_BLOCKIO=3Dy
CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
CONFIG_SSB_PCIHOST=3Dy
CONFIG_SSB_B43_PCI_BRIDGE=3Dy
CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
CONFIG_SSB_PCMCIAHOST=3Dy
CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
CONFIG_SSB_SDIOHOST=3Dy
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=3Dy
CONFIG_SSB_DRIVER_PCICORE=3Dy
CONFIG_SSB_DRIVER_GPIO=3Dy
CONFIG_BCMA_POSSIBLE=3Dy
CONFIG_BCMA=3Dm
CONFIG_BCMA_BLOCKIO=3Dy
CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
CONFIG_BCMA_HOST_PCI=3Dy
# CONFIG_BCMA_HOST_SOC is not set
CONFIG_BCMA_DRIVER_PCI=3Dy
CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
CONFIG_BCMA_DRIVER_GPIO=3Dy
# CONFIG_BCMA_DEBUG is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=3Dy
CONFIG_MFD_ACT8945A=3Dm
CONFIG_MFD_AS3711=3Dy
CONFIG_MFD_AS3722=3Dm
CONFIG_PMIC_ADP5520=3Dy
CONFIG_MFD_AAT2870_CORE=3Dy
CONFIG_MFD_ATMEL_FLEXCOM=3Dm
CONFIG_MFD_ATMEL_HLCDC=3Dm
CONFIG_MFD_BCM590XX=3Dm
CONFIG_MFD_BD9571MWV=3Dm
CONFIG_MFD_AXP20X=3Dm
CONFIG_MFD_AXP20X_I2C=3Dm
CONFIG_MFD_CROS_EC_DEV=3Dm
CONFIG_MFD_MADERA=3Dm
CONFIG_MFD_MADERA_I2C=3Dm
CONFIG_MFD_MADERA_SPI=3Dm
CONFIG_MFD_CS47L15=3Dy
CONFIG_MFD_CS47L35=3Dy
CONFIG_MFD_CS47L85=3Dy
CONFIG_MFD_CS47L90=3Dy
CONFIG_MFD_CS47L92=3Dy
CONFIG_PMIC_DA903X=3Dy
CONFIG_PMIC_DA9052=3Dy
CONFIG_MFD_DA9052_SPI=3Dy
CONFIG_MFD_DA9052_I2C=3Dy
CONFIG_MFD_DA9055=3Dy
CONFIG_MFD_DA9062=3Dm
CONFIG_MFD_DA9063=3Dm
CONFIG_MFD_DA9150=3Dm
CONFIG_MFD_DLN2=3Dm
CONFIG_MFD_MC13XXX=3Dm
CONFIG_MFD_MC13XXX_SPI=3Dm
CONFIG_MFD_MC13XXX_I2C=3Dm
CONFIG_MFD_HI6421_PMIC=3Dm
CONFIG_HTC_PASIC3=3Dm
CONFIG_HTC_I2CPLD=3Dy
CONFIG_MFD_INTEL_QUARK_I2C_GPIO=3Dm
CONFIG_LPC_ICH=3Dm
CONFIG_LPC_SCH=3Dm
CONFIG_INTEL_SOC_PMIC=3Dy
CONFIG_INTEL_SOC_PMIC_BXTWC=3Dm
CONFIG_INTEL_SOC_PMIC_CHTWC=3Dy
CONFIG_INTEL_SOC_PMIC_CHTDC_TI=3Dm
CONFIG_MFD_INTEL_LPSS=3Dm
CONFIG_MFD_INTEL_LPSS_ACPI=3Dm
CONFIG_MFD_INTEL_LPSS_PCI=3Dm
CONFIG_MFD_JANZ_CMODIO=3Dm
CONFIG_MFD_KEMPLD=3Dm
CONFIG_MFD_88PM800=3Dm
CONFIG_MFD_88PM805=3Dm
CONFIG_MFD_88PM860X=3Dy
CONFIG_MFD_MAX14577=3Dm
CONFIG_MFD_MAX77620=3Dy
CONFIG_MFD_MAX77650=3Dm
CONFIG_MFD_MAX77686=3Dm
CONFIG_MFD_MAX77693=3Dm
CONFIG_MFD_MAX77843=3Dy
CONFIG_MFD_MAX8907=3Dm
CONFIG_MFD_MAX8925=3Dy
CONFIG_MFD_MAX8997=3Dy
CONFIG_MFD_MAX8998=3Dy
CONFIG_MFD_MT6397=3Dm
CONFIG_MFD_MENF21BMC=3Dm
CONFIG_EZX_PCAP=3Dy
CONFIG_MFD_CPCAP=3Dm
CONFIG_MFD_VIPERBOARD=3Dm
CONFIG_MFD_RETU=3Dm
CONFIG_MFD_PCF50633=3Dm
CONFIG_PCF50633_ADC=3Dm
CONFIG_PCF50633_GPIO=3Dm
CONFIG_UCB1400_CORE=3Dm
CONFIG_MFD_RDC321X=3Dm
CONFIG_MFD_RT5033=3Dm
CONFIG_MFD_RC5T583=3Dy
CONFIG_MFD_RK808=3Dm
CONFIG_MFD_RN5T618=3Dm
CONFIG_MFD_SEC_CORE=3Dy
CONFIG_MFD_SI476X_CORE=3Dm
CONFIG_MFD_SM501=3Dm
CONFIG_MFD_SM501_GPIO=3Dy
CONFIG_MFD_SKY81452=3Dm
CONFIG_MFD_SMSC=3Dy
CONFIG_ABX500_CORE=3Dy
CONFIG_AB3100_CORE=3Dy
CONFIG_AB3100_OTP=3Dy
CONFIG_MFD_STMPE=3Dy

#
# STMicroelectronics STMPE Interface Drivers
#
CONFIG_STMPE_I2C=3Dy
CONFIG_STMPE_SPI=3Dy
# end of STMicroelectronics STMPE Interface Drivers

CONFIG_MFD_SYSCON=3Dy
CONFIG_MFD_TI_AM335X_TSCADC=3Dm
CONFIG_MFD_LP3943=3Dm
CONFIG_MFD_LP8788=3Dy
CONFIG_MFD_TI_LMU=3Dm
CONFIG_MFD_PALMAS=3Dy
CONFIG_TPS6105X=3Dm
CONFIG_TPS65010=3Dm
CONFIG_TPS6507X=3Dm
CONFIG_MFD_TPS65086=3Dm
CONFIG_MFD_TPS65090=3Dy
CONFIG_MFD_TPS65217=3Dm
CONFIG_MFD_TPS68470=3Dy
CONFIG_MFD_TI_LP873X=3Dm
CONFIG_MFD_TI_LP87565=3Dm
CONFIG_MFD_TPS65218=3Dm
CONFIG_MFD_TPS6586X=3Dy
CONFIG_MFD_TPS65910=3Dy
CONFIG_MFD_TPS65912=3Dm
CONFIG_MFD_TPS65912_I2C=3Dm
CONFIG_MFD_TPS65912_SPI=3Dm
CONFIG_MFD_TPS80031=3Dy
CONFIG_TWL4030_CORE=3Dy
CONFIG_MFD_TWL4030_AUDIO=3Dy
CONFIG_TWL6040_CORE=3Dy
CONFIG_MFD_WL1273_CORE=3Dm
CONFIG_MFD_LM3533=3Dm
CONFIG_MFD_TC3589X=3Dy
CONFIG_MFD_TQMX86=3Dm
CONFIG_MFD_VX855=3Dm
CONFIG_MFD_LOCHNAGAR=3Dy
CONFIG_MFD_ARIZONA=3Dy
CONFIG_MFD_ARIZONA_I2C=3Dm
CONFIG_MFD_ARIZONA_SPI=3Dm
CONFIG_MFD_CS47L24=3Dy
CONFIG_MFD_WM5102=3Dy
CONFIG_MFD_WM5110=3Dy
CONFIG_MFD_WM8997=3Dy
CONFIG_MFD_WM8998=3Dy
CONFIG_MFD_WM8400=3Dy
CONFIG_MFD_WM831X=3Dy
CONFIG_MFD_WM831X_I2C=3Dy
CONFIG_MFD_WM831X_SPI=3Dy
CONFIG_MFD_WM8350=3Dy
CONFIG_MFD_WM8350_I2C=3Dy
CONFIG_MFD_WM8994=3Dm
CONFIG_MFD_ROHM_BD718XX=3Dm
CONFIG_MFD_ROHM_BD70528=3Dm
CONFIG_MFD_ROHM_BD71828=3Dm
CONFIG_MFD_STPMIC1=3Dm
CONFIG_MFD_STMFX=3Dm
CONFIG_MFD_WCD934X=3Dm
CONFIG_RAVE_SP_CORE=3Dm
# end of Multifunction device drivers

CONFIG_REGULATOR=3Dy
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=3Dm
CONFIG_REGULATOR_VIRTUAL_CONSUMER=3Dm
CONFIG_REGULATOR_USERSPACE_CONSUMER=3Dm
CONFIG_REGULATOR_88PG86X=3Dm
CONFIG_REGULATOR_88PM800=3Dm
CONFIG_REGULATOR_88PM8607=3Dm
CONFIG_REGULATOR_ACT8865=3Dm
CONFIG_REGULATOR_ACT8945A=3Dm
CONFIG_REGULATOR_AD5398=3Dm
CONFIG_REGULATOR_ANATOP=3Dm
CONFIG_REGULATOR_AAT2870=3Dm
CONFIG_REGULATOR_AB3100=3Dm
CONFIG_REGULATOR_ARIZONA_LDO1=3Dm
CONFIG_REGULATOR_ARIZONA_MICSUPP=3Dm
CONFIG_REGULATOR_AS3711=3Dm
CONFIG_REGULATOR_AS3722=3Dm
CONFIG_REGULATOR_AXP20X=3Dm
CONFIG_REGULATOR_BCM590XX=3Dm
CONFIG_REGULATOR_BD70528=3Dm
CONFIG_REGULATOR_BD71828=3Dm
CONFIG_REGULATOR_BD718XX=3Dm
CONFIG_REGULATOR_BD9571MWV=3Dm
CONFIG_REGULATOR_CPCAP=3Dm
CONFIG_REGULATOR_DA903X=3Dm
CONFIG_REGULATOR_DA9052=3Dm
CONFIG_REGULATOR_DA9055=3Dm
CONFIG_REGULATOR_DA9062=3Dm
CONFIG_REGULATOR_DA9063=3Dm
CONFIG_REGULATOR_DA9210=3Dm
CONFIG_REGULATOR_DA9211=3Dm
CONFIG_REGULATOR_FAN53555=3Dm
CONFIG_REGULATOR_GPIO=3Dm
CONFIG_REGULATOR_HI6421=3Dm
CONFIG_REGULATOR_HI6421V530=3Dm
CONFIG_REGULATOR_ISL9305=3Dm
CONFIG_REGULATOR_ISL6271A=3Dm
CONFIG_REGULATOR_LM363X=3Dm
CONFIG_REGULATOR_LOCHNAGAR=3Dm
CONFIG_REGULATOR_LP3971=3Dm
CONFIG_REGULATOR_LP3972=3Dm
CONFIG_REGULATOR_LP872X=3Dm
CONFIG_REGULATOR_LP873X=3Dm
CONFIG_REGULATOR_LP8755=3Dm
CONFIG_REGULATOR_LP87565=3Dm
CONFIG_REGULATOR_LP8788=3Dm
CONFIG_REGULATOR_LTC3589=3Dm
CONFIG_REGULATOR_LTC3676=3Dm
CONFIG_REGULATOR_MAX14577=3Dm
CONFIG_REGULATOR_MAX1586=3Dm
CONFIG_REGULATOR_MAX77620=3Dm
CONFIG_REGULATOR_MAX77650=3Dm
CONFIG_REGULATOR_MAX8649=3Dm
CONFIG_REGULATOR_MAX8660=3Dm
CONFIG_REGULATOR_MAX8907=3Dm
CONFIG_REGULATOR_MAX8925=3Dm
CONFIG_REGULATOR_MAX8952=3Dm
CONFIG_REGULATOR_MAX8973=3Dm
CONFIG_REGULATOR_MAX8997=3Dm
CONFIG_REGULATOR_MAX8998=3Dm
CONFIG_REGULATOR_MAX77686=3Dm
CONFIG_REGULATOR_MAX77693=3Dm
CONFIG_REGULATOR_MAX77802=3Dm
CONFIG_REGULATOR_MC13XXX_CORE=3Dm
CONFIG_REGULATOR_MC13783=3Dm
CONFIG_REGULATOR_MC13892=3Dm
CONFIG_REGULATOR_MCP16502=3Dm
CONFIG_REGULATOR_MP8859=3Dm
CONFIG_REGULATOR_MPQ7920=3Dm
CONFIG_REGULATOR_MT6311=3Dm
CONFIG_REGULATOR_MT6323=3Dm
CONFIG_REGULATOR_MT6397=3Dm
CONFIG_REGULATOR_PALMAS=3Dm
CONFIG_REGULATOR_PCAP=3Dm
CONFIG_REGULATOR_PCF50633=3Dm
CONFIG_REGULATOR_PFUZE100=3Dm
CONFIG_REGULATOR_PV88060=3Dm
CONFIG_REGULATOR_PV88080=3Dm
CONFIG_REGULATOR_PV88090=3Dm
CONFIG_REGULATOR_PWM=3Dm
CONFIG_REGULATOR_QCOM_SPMI=3Dm
CONFIG_REGULATOR_RC5T583=3Dm
CONFIG_REGULATOR_RK808=3Dm
CONFIG_REGULATOR_RN5T618=3Dm
CONFIG_REGULATOR_ROHM=3Dm
CONFIG_REGULATOR_RT5033=3Dm
CONFIG_REGULATOR_S2MPA01=3Dm
CONFIG_REGULATOR_S2MPS11=3Dm
CONFIG_REGULATOR_S5M8767=3Dm
CONFIG_REGULATOR_SKY81452=3Dm
CONFIG_REGULATOR_SLG51000=3Dm
CONFIG_REGULATOR_STPMIC1=3Dm
CONFIG_REGULATOR_SY8106A=3Dm
CONFIG_REGULATOR_SY8824X=3Dm
CONFIG_REGULATOR_TPS51632=3Dm
CONFIG_REGULATOR_TPS6105X=3Dm
CONFIG_REGULATOR_TPS62360=3Dm
CONFIG_REGULATOR_TPS65023=3Dm
CONFIG_REGULATOR_TPS6507X=3Dm
CONFIG_REGULATOR_TPS65086=3Dm
CONFIG_REGULATOR_TPS65090=3Dm
CONFIG_REGULATOR_TPS65132=3Dm
CONFIG_REGULATOR_TPS65217=3Dm
CONFIG_REGULATOR_TPS65218=3Dm
CONFIG_REGULATOR_TPS6524X=3Dm
CONFIG_REGULATOR_TPS6586X=3Dm
CONFIG_REGULATOR_TPS65910=3Dm
CONFIG_REGULATOR_TPS65912=3Dm
CONFIG_REGULATOR_TPS80031=3Dm
CONFIG_REGULATOR_TWL4030=3Dm
CONFIG_REGULATOR_VCTRL=3Dm
CONFIG_REGULATOR_WM831X=3Dm
CONFIG_REGULATOR_WM8350=3Dm
CONFIG_REGULATOR_WM8400=3Dm
CONFIG_REGULATOR_WM8994=3Dm
CONFIG_CEC_CORE=3Dm
CONFIG_CEC_NOTIFIER=3Dy
CONFIG_CEC_PIN=3Dy
CONFIG_RC_CORE=3Dm
CONFIG_RC_MAP=3Dm
CONFIG_LIRC=3Dy
CONFIG_RC_DECODERS=3Dy
CONFIG_IR_NEC_DECODER=3Dm
CONFIG_IR_RC5_DECODER=3Dm
CONFIG_IR_RC6_DECODER=3Dm
CONFIG_IR_JVC_DECODER=3Dm
CONFIG_IR_SONY_DECODER=3Dm
CONFIG_IR_SANYO_DECODER=3Dm
CONFIG_IR_SHARP_DECODER=3Dm
CONFIG_IR_MCE_KBD_DECODER=3Dm
CONFIG_IR_XMP_DECODER=3Dm
CONFIG_IR_IMON_DECODER=3Dm
CONFIG_IR_RCMM_DECODER=3Dm
CONFIG_RC_DEVICES=3Dy
CONFIG_RC_ATI_REMOTE=3Dm
CONFIG_IR_ENE=3Dm
CONFIG_IR_HIX5HD2=3Dm
CONFIG_IR_IMON=3Dm
CONFIG_IR_IMON_RAW=3Dm
CONFIG_IR_MCEUSB=3Dm
CONFIG_IR_ITE_CIR=3Dm
CONFIG_IR_FINTEK=3Dm
CONFIG_IR_NUVOTON=3Dm
CONFIG_IR_REDRAT3=3Dm
CONFIG_IR_SPI=3Dm
CONFIG_IR_STREAMZAP=3Dm
CONFIG_IR_WINBOND_CIR=3Dm
CONFIG_IR_IGORPLUGUSB=3Dm
CONFIG_IR_IGUANA=3Dm
CONFIG_IR_TTUSBIR=3Dm
CONFIG_RC_LOOPBACK=3Dm
CONFIG_IR_GPIO_CIR=3Dm
CONFIG_IR_GPIO_TX=3Dm
CONFIG_IR_PWM_TX=3Dm
CONFIG_IR_SERIAL=3Dm
CONFIG_IR_SERIAL_TRANSMITTER=3Dy
CONFIG_IR_SIR=3Dm
CONFIG_RC_XBOX_DVD=3Dm
CONFIG_MEDIA_SUPPORT=3Dm

#
# Multimedia core support
#
CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy
CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy
CONFIG_MEDIA_RADIO_SUPPORT=3Dy
CONFIG_MEDIA_SDR_SUPPORT=3Dy
CONFIG_MEDIA_CEC_SUPPORT=3Dy
CONFIG_MEDIA_CEC_RC=3Dy
# CONFIG_CEC_PIN_ERROR_INJ is not set
CONFIG_MEDIA_CONTROLLER=3Dy
CONFIG_MEDIA_CONTROLLER_DVB=3Dy
# CONFIG_MEDIA_CONTROLLER_REQUEST_API is not set
CONFIG_VIDEO_DEV=3Dm
CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
CONFIG_VIDEO_V4L2=3Dm
CONFIG_VIDEO_V4L2_I2C=3Dy
# CONFIG_VIDEO_ADV_DEBUG is not set
# CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
CONFIG_VIDEO_TUNER=3Dm
CONFIG_V4L2_MEM2MEM_DEV=3Dm
CONFIG_V4L2_FLASH_LED_CLASS=3Dm
CONFIG_V4L2_FWNODE=3Dm
CONFIG_VIDEOBUF_GEN=3Dm
CONFIG_VIDEOBUF_DMA_SG=3Dm
CONFIG_VIDEOBUF_VMALLOC=3Dm
CONFIG_DVB_CORE=3Dm
CONFIG_DVB_MMAP=3Dy
CONFIG_DVB_NET=3Dy
CONFIG_TTPCI_EEPROM=3Dm
CONFIG_DVB_MAX_ADAPTERS=3D16
# CONFIG_DVB_DYNAMIC_MINORS is not set
# CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
# CONFIG_DVB_ULE_DEBUG is not set

#
# Media drivers
#
CONFIG_MEDIA_USB_SUPPORT=3Dy

#
# Webcam devices
#
CONFIG_USB_VIDEO_CLASS=3Dm
CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
CONFIG_USB_GSPCA=3Dm
CONFIG_USB_M5602=3Dm
CONFIG_USB_STV06XX=3Dm
CONFIG_USB_GL860=3Dm
CONFIG_USB_GSPCA_BENQ=3Dm
CONFIG_USB_GSPCA_CONEX=3Dm
CONFIG_USB_GSPCA_CPIA1=3Dm
CONFIG_USB_GSPCA_DTCS033=3Dm
CONFIG_USB_GSPCA_ETOMS=3Dm
CONFIG_USB_GSPCA_FINEPIX=3Dm
CONFIG_USB_GSPCA_JEILINJ=3Dm
CONFIG_USB_GSPCA_JL2005BCD=3Dm
CONFIG_USB_GSPCA_KINECT=3Dm
CONFIG_USB_GSPCA_KONICA=3Dm
CONFIG_USB_GSPCA_MARS=3Dm
CONFIG_USB_GSPCA_MR97310A=3Dm
CONFIG_USB_GSPCA_NW80X=3Dm
CONFIG_USB_GSPCA_OV519=3Dm
CONFIG_USB_GSPCA_OV534=3Dm
CONFIG_USB_GSPCA_OV534_9=3Dm
CONFIG_USB_GSPCA_PAC207=3Dm
CONFIG_USB_GSPCA_PAC7302=3Dm
CONFIG_USB_GSPCA_PAC7311=3Dm
CONFIG_USB_GSPCA_SE401=3Dm
CONFIG_USB_GSPCA_SN9C2028=3Dm
CONFIG_USB_GSPCA_SN9C20X=3Dm
CONFIG_USB_GSPCA_SONIXB=3Dm
CONFIG_USB_GSPCA_SONIXJ=3Dm
CONFIG_USB_GSPCA_SPCA500=3Dm
CONFIG_USB_GSPCA_SPCA501=3Dm
CONFIG_USB_GSPCA_SPCA505=3Dm
CONFIG_USB_GSPCA_SPCA506=3Dm
CONFIG_USB_GSPCA_SPCA508=3Dm
CONFIG_USB_GSPCA_SPCA561=3Dm
CONFIG_USB_GSPCA_SPCA1528=3Dm
CONFIG_USB_GSPCA_SQ905=3Dm
CONFIG_USB_GSPCA_SQ905C=3Dm
CONFIG_USB_GSPCA_SQ930X=3Dm
CONFIG_USB_GSPCA_STK014=3Dm
CONFIG_USB_GSPCA_STK1135=3Dm
CONFIG_USB_GSPCA_STV0680=3Dm
CONFIG_USB_GSPCA_SUNPLUS=3Dm
CONFIG_USB_GSPCA_T613=3Dm
CONFIG_USB_GSPCA_TOPRO=3Dm
CONFIG_USB_GSPCA_TOUPTEK=3Dm
CONFIG_USB_GSPCA_TV8532=3Dm
CONFIG_USB_GSPCA_VC032X=3Dm
CONFIG_USB_GSPCA_VICAM=3Dm
CONFIG_USB_GSPCA_XIRLINK_CIT=3Dm
CONFIG_USB_GSPCA_ZC3XX=3Dm
CONFIG_USB_PWC=3Dm
# CONFIG_USB_PWC_DEBUG is not set
CONFIG_USB_PWC_INPUT_EVDEV=3Dy
CONFIG_VIDEO_CPIA2=3Dm
CONFIG_USB_ZR364XX=3Dm
CONFIG_USB_STKWEBCAM=3Dm
CONFIG_USB_S2255=3Dm
CONFIG_VIDEO_USBTV=3Dm

#
# Analog TV USB devices
#
CONFIG_VIDEO_PVRUSB2=3Dm
CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
CONFIG_VIDEO_PVRUSB2_DVB=3Dy
# CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
CONFIG_VIDEO_HDPVR=3Dm
CONFIG_VIDEO_USBVISION=3Dm
CONFIG_VIDEO_STK1160_COMMON=3Dm
CONFIG_VIDEO_STK1160=3Dm
CONFIG_VIDEO_GO7007=3Dm
CONFIG_VIDEO_GO7007_USB=3Dm
CONFIG_VIDEO_GO7007_LOADER=3Dm
CONFIG_VIDEO_GO7007_USB_S2250_BOARD=3Dm

#
# Analog/digital TV USB devices
#
CONFIG_VIDEO_AU0828=3Dm
CONFIG_VIDEO_AU0828_V4L2=3Dy
CONFIG_VIDEO_AU0828_RC=3Dy
CONFIG_VIDEO_CX231XX=3Dm
CONFIG_VIDEO_CX231XX_RC=3Dy
CONFIG_VIDEO_CX231XX_ALSA=3Dm
CONFIG_VIDEO_CX231XX_DVB=3Dm
CONFIG_VIDEO_TM6000=3Dm
CONFIG_VIDEO_TM6000_ALSA=3Dm
CONFIG_VIDEO_TM6000_DVB=3Dm

#
# Digital TV USB devices
#
CONFIG_DVB_USB=3Dm
# CONFIG_DVB_USB_DEBUG is not set
CONFIG_DVB_USB_DIB3000MC=3Dm
CONFIG_DVB_USB_A800=3Dm
CONFIG_DVB_USB_DIBUSB_MB=3Dm
CONFIG_DVB_USB_DIBUSB_MB_FAULTY=3Dy
CONFIG_DVB_USB_DIBUSB_MC=3Dm
CONFIG_DVB_USB_DIB0700=3Dm
CONFIG_DVB_USB_UMT_010=3Dm
CONFIG_DVB_USB_CXUSB=3Dm
CONFIG_DVB_USB_CXUSB_ANALOG=3Dy
CONFIG_DVB_USB_M920X=3Dm
CONFIG_DVB_USB_DIGITV=3Dm
CONFIG_DVB_USB_VP7045=3Dm
CONFIG_DVB_USB_VP702X=3Dm
CONFIG_DVB_USB_GP8PSK=3Dm
CONFIG_DVB_USB_NOVA_T_USB2=3Dm
CONFIG_DVB_USB_TTUSB2=3Dm
CONFIG_DVB_USB_DTT200U=3Dm
CONFIG_DVB_USB_OPERA1=3Dm
CONFIG_DVB_USB_AF9005=3Dm
CONFIG_DVB_USB_AF9005_REMOTE=3Dm
CONFIG_DVB_USB_PCTV452E=3Dm
CONFIG_DVB_USB_DW2102=3Dm
CONFIG_DVB_USB_CINERGY_T2=3Dm
CONFIG_DVB_USB_DTV5100=3Dm
CONFIG_DVB_USB_AZ6027=3Dm
CONFIG_DVB_USB_TECHNISAT_USB2=3Dm
CONFIG_DVB_USB_V2=3Dm
CONFIG_DVB_USB_AF9015=3Dm
CONFIG_DVB_USB_AF9035=3Dm
CONFIG_DVB_USB_ANYSEE=3Dm
CONFIG_DVB_USB_AU6610=3Dm
CONFIG_DVB_USB_AZ6007=3Dm
CONFIG_DVB_USB_CE6230=3Dm
CONFIG_DVB_USB_EC168=3Dm
CONFIG_DVB_USB_GL861=3Dm
CONFIG_DVB_USB_LME2510=3Dm
CONFIG_DVB_USB_MXL111SF=3Dm
CONFIG_DVB_USB_RTL28XXU=3Dm
CONFIG_DVB_USB_DVBSKY=3Dm
CONFIG_DVB_USB_ZD1301=3Dm
CONFIG_DVB_TTUSB_BUDGET=3Dm
CONFIG_DVB_TTUSB_DEC=3Dm
CONFIG_SMS_USB_DRV=3Dm
CONFIG_DVB_B2C2_FLEXCOP_USB=3Dm
# CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
CONFIG_DVB_AS102=3Dm

#
# Webcam, TV (analog/digital) USB devices
#
CONFIG_VIDEO_EM28XX=3Dm
CONFIG_VIDEO_EM28XX_V4L2=3Dm
CONFIG_VIDEO_EM28XX_ALSA=3Dm
CONFIG_VIDEO_EM28XX_DVB=3Dm
CONFIG_VIDEO_EM28XX_RC=3Dm

#
# Software defined radio USB devices
#
CONFIG_USB_AIRSPY=3Dm
CONFIG_USB_HACKRF=3Dm
CONFIG_USB_MSI2500=3Dm

#
# USB HDMI CEC adapters
#
CONFIG_USB_PULSE8_CEC=3Dm
CONFIG_USB_RAINSHADOW_CEC=3Dm
CONFIG_MEDIA_PCI_SUPPORT=3Dy

#
# Media capture support
#
CONFIG_VIDEO_MEYE=3Dm
CONFIG_VIDEO_SOLO6X10=3Dm
CONFIG_VIDEO_TW5864=3Dm
CONFIG_VIDEO_TW68=3Dm
CONFIG_VIDEO_TW686X=3Dm

#
# Media capture/analog TV support
#
CONFIG_VIDEO_IVTV=3Dm
# CONFIG_VIDEO_IVTV_DEPRECATED_IOCTLS is not set
CONFIG_VIDEO_IVTV_ALSA=3Dm
CONFIG_VIDEO_FB_IVTV=3Dm
# CONFIG_VIDEO_FB_IVTV_FORCE_PAT is not set
CONFIG_VIDEO_HEXIUM_GEMINI=3Dm
CONFIG_VIDEO_HEXIUM_ORION=3Dm
CONFIG_VIDEO_MXB=3Dm
CONFIG_VIDEO_DT3155=3Dm

#
# Media capture/analog/hybrid TV support
#
CONFIG_VIDEO_CX18=3Dm
CONFIG_VIDEO_CX18_ALSA=3Dm
CONFIG_VIDEO_CX23885=3Dm
CONFIG_MEDIA_ALTERA_CI=3Dm
CONFIG_VIDEO_CX25821=3Dm
CONFIG_VIDEO_CX25821_ALSA=3Dm
CONFIG_VIDEO_CX88=3Dm
CONFIG_VIDEO_CX88_ALSA=3Dm
CONFIG_VIDEO_CX88_BLACKBIRD=3Dm
CONFIG_VIDEO_CX88_DVB=3Dm
CONFIG_VIDEO_CX88_ENABLE_VP3054=3Dy
CONFIG_VIDEO_CX88_VP3054=3Dm
CONFIG_VIDEO_CX88_MPEG=3Dm
CONFIG_VIDEO_BT848=3Dm
CONFIG_DVB_BT8XX=3Dm
CONFIG_VIDEO_SAA7134=3Dm
CONFIG_VIDEO_SAA7134_ALSA=3Dm
CONFIG_VIDEO_SAA7134_RC=3Dy
CONFIG_VIDEO_SAA7134_DVB=3Dm
CONFIG_VIDEO_SAA7134_GO7007=3Dm
CONFIG_VIDEO_SAA7164=3Dm

#
# Media digital TV PCI Adapters
#
CONFIG_DVB_AV7110_IR=3Dy
CONFIG_DVB_AV7110=3Dm
CONFIG_DVB_AV7110_OSD=3Dy
CONFIG_DVB_BUDGET_CORE=3Dm
CONFIG_DVB_BUDGET=3Dm
CONFIG_DVB_BUDGET_CI=3Dm
CONFIG_DVB_BUDGET_AV=3Dm
CONFIG_DVB_BUDGET_PATCH=3Dm
CONFIG_DVB_B2C2_FLEXCOP_PCI=3Dm
# CONFIG_DVB_B2C2_FLEXCOP_PCI_DEBUG is not set
CONFIG_DVB_PLUTO2=3Dm
CONFIG_DVB_DM1105=3Dm
CONFIG_DVB_PT1=3Dm
CONFIG_DVB_PT3=3Dm
CONFIG_MANTIS_CORE=3Dm
CONFIG_DVB_MANTIS=3Dm
CONFIG_DVB_HOPPER=3Dm
CONFIG_DVB_NGENE=3Dm
CONFIG_DVB_DDBRIDGE=3Dm
# CONFIG_DVB_DDBRIDGE_MSIENABLE is not set
CONFIG_DVB_SMIPCIE=3Dm
CONFIG_DVB_NETUP_UNIDVB=3Dm
CONFIG_VIDEO_IPU3_CIO2=3Dm
CONFIG_V4L_PLATFORM_DRIVERS=3Dy
CONFIG_VIDEO_CAFE_CCIC=3Dm
CONFIG_VIDEO_CADENCE=3Dy
CONFIG_VIDEO_CADENCE_CSI2RX=3Dm
CONFIG_VIDEO_CADENCE_CSI2TX=3Dm
CONFIG_VIDEO_ASPEED=3Dm
CONFIG_VIDEO_MUX=3Dm
CONFIG_VIDEO_XILINX=3Dm
CONFIG_VIDEO_XILINX_TPG=3Dm
CONFIG_VIDEO_XILINX_VTC=3Dm
CONFIG_V4L_MEM2MEM_DRIVERS=3Dy
CONFIG_VIDEO_MEM2MEM_DEINTERLACE=3Dm
CONFIG_VIDEO_SH_VEU=3Dm
CONFIG_V4L_TEST_DRIVERS=3Dy
CONFIG_VIDEO_VIMC=3Dm
CONFIG_VIDEO_VIVID=3Dm
CONFIG_VIDEO_VIVID_CEC=3Dy
CONFIG_VIDEO_VIVID_MAX_DEVS=3D64
CONFIG_VIDEO_VIM2M=3Dm
CONFIG_VIDEO_VICODEC=3Dm
CONFIG_DVB_PLATFORM_DRIVERS=3Dy
CONFIG_CEC_PLATFORM_DRIVERS=3Dy
CONFIG_VIDEO_CROS_EC_CEC=3Dm
CONFIG_CEC_GPIO=3Dm
CONFIG_VIDEO_SECO_CEC=3Dm
CONFIG_VIDEO_SECO_RC=3Dy
CONFIG_SDR_PLATFORM_DRIVERS=3Dy

#
# Supported MMC/SDIO adapters
#
CONFIG_SMS_SDIO_DRV=3Dm
CONFIG_RADIO_ADAPTERS=3Dy
CONFIG_RADIO_TEA575X=3Dm
CONFIG_RADIO_SI470X=3Dm
CONFIG_USB_SI470X=3Dm
CONFIG_I2C_SI470X=3Dm
CONFIG_RADIO_SI4713=3Dm
CONFIG_USB_SI4713=3Dm
CONFIG_PLATFORM_SI4713=3Dm
CONFIG_I2C_SI4713=3Dm
CONFIG_RADIO_SI476X=3Dm
CONFIG_USB_MR800=3Dm
CONFIG_USB_DSBR=3Dm
CONFIG_RADIO_MAXIRADIO=3Dm
CONFIG_RADIO_SHARK=3Dm
CONFIG_RADIO_SHARK2=3Dm
CONFIG_USB_KEENE=3Dm
CONFIG_USB_RAREMONO=3Dm
CONFIG_USB_MA901=3Dm
CONFIG_RADIO_TEA5764=3Dm
CONFIG_RADIO_SAA7706H=3Dm
CONFIG_RADIO_TEF6862=3Dm
CONFIG_RADIO_WL1273=3Dm

#
# Texas Instruments WL128x FM driver (ST based)
#
CONFIG_RADIO_WL128X=3Dm
# end of Texas Instruments WL128x FM driver (ST based)

#
# Supported FireWire (IEEE 1394) Adapters
#
CONFIG_DVB_FIREDTV=3Dm
CONFIG_DVB_FIREDTV_INPUT=3Dy
CONFIG_MEDIA_COMMON_OPTIONS=3Dy

#
# common driver options
#
CONFIG_VIDEO_CX2341X=3Dm
CONFIG_VIDEO_TVEEPROM=3Dm
CONFIG_CYPRESS_FIRMWARE=3Dm
CONFIG_VIDEOBUF2_CORE=3Dm
CONFIG_VIDEOBUF2_V4L2=3Dm
CONFIG_VIDEOBUF2_MEMOPS=3Dm
CONFIG_VIDEOBUF2_DMA_CONTIG=3Dm
CONFIG_VIDEOBUF2_VMALLOC=3Dm
CONFIG_VIDEOBUF2_DMA_SG=3Dm
CONFIG_VIDEOBUF2_DVB=3Dm
CONFIG_DVB_B2C2_FLEXCOP=3Dm
CONFIG_VIDEO_SAA7146=3Dm
CONFIG_VIDEO_SAA7146_VV=3Dm
CONFIG_SMS_SIANO_MDTV=3Dm
CONFIG_SMS_SIANO_RC=3Dy
# CONFIG_SMS_SIANO_DEBUGFS is not set
CONFIG_VIDEO_V4L2_TPG=3Dm

#
# Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
#
CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
CONFIG_MEDIA_ATTACH=3Dy
CONFIG_VIDEO_IR_I2C=3Dm

#
# I2C Encoders, decoders, sensors and other helper chips
#

#
# Audio decoders, processors and mixers
#
CONFIG_VIDEO_TVAUDIO=3Dm
CONFIG_VIDEO_TDA7432=3Dm
CONFIG_VIDEO_TDA9840=3Dm
CONFIG_VIDEO_TDA1997X=3Dm
CONFIG_VIDEO_TEA6415C=3Dm
CONFIG_VIDEO_TEA6420=3Dm
CONFIG_VIDEO_MSP3400=3Dm
CONFIG_VIDEO_CS3308=3Dm
CONFIG_VIDEO_CS5345=3Dm
CONFIG_VIDEO_CS53L32A=3Dm
CONFIG_VIDEO_TLV320AIC23B=3Dm
CONFIG_VIDEO_UDA1342=3Dm
CONFIG_VIDEO_WM8775=3Dm
CONFIG_VIDEO_WM8739=3Dm
CONFIG_VIDEO_VP27SMPX=3Dm
CONFIG_VIDEO_SONY_BTF_MPX=3Dm

#
# RDS decoders
#
CONFIG_VIDEO_SAA6588=3Dm

#
# Video decoders
#
CONFIG_VIDEO_ADV7180=3Dm
CONFIG_VIDEO_ADV7183=3Dm
CONFIG_VIDEO_ADV748X=3Dm
CONFIG_VIDEO_ADV7604=3Dm
CONFIG_VIDEO_ADV7604_CEC=3Dy
CONFIG_VIDEO_ADV7842=3Dm
CONFIG_VIDEO_ADV7842_CEC=3Dy
CONFIG_VIDEO_BT819=3Dm
CONFIG_VIDEO_BT856=3Dm
CONFIG_VIDEO_BT866=3Dm
CONFIG_VIDEO_KS0127=3Dm
CONFIG_VIDEO_ML86V7667=3Dm
CONFIG_VIDEO_SAA7110=3Dm
CONFIG_VIDEO_SAA711X=3Dm
CONFIG_VIDEO_TC358743=3Dm
CONFIG_VIDEO_TC358743_CEC=3Dy
CONFIG_VIDEO_TVP514X=3Dm
CONFIG_VIDEO_TVP5150=3Dm
CONFIG_VIDEO_TVP7002=3Dm
CONFIG_VIDEO_TW2804=3Dm
CONFIG_VIDEO_TW9903=3Dm
CONFIG_VIDEO_TW9906=3Dm
CONFIG_VIDEO_TW9910=3Dm
CONFIG_VIDEO_VPX3220=3Dm

#
# Video and audio decoders
#
CONFIG_VIDEO_SAA717X=3Dm
CONFIG_VIDEO_CX25840=3Dm

#
# Video encoders
#
CONFIG_VIDEO_SAA7127=3Dm
CONFIG_VIDEO_SAA7185=3Dm
CONFIG_VIDEO_ADV7170=3Dm
CONFIG_VIDEO_ADV7175=3Dm
CONFIG_VIDEO_ADV7343=3Dm
CONFIG_VIDEO_ADV7393=3Dm
CONFIG_VIDEO_AD9389B=3Dm
CONFIG_VIDEO_AK881X=3Dm
CONFIG_VIDEO_THS8200=3Dm

#
# Camera sensor devices
#
CONFIG_VIDEO_APTINA_PLL=3Dm
CONFIG_VIDEO_SMIAPP_PLL=3Dm
CONFIG_VIDEO_HI556=3Dm
CONFIG_VIDEO_IMX214=3Dm
CONFIG_VIDEO_IMX258=3Dm
CONFIG_VIDEO_IMX274=3Dm
CONFIG_VIDEO_IMX290=3Dm
CONFIG_VIDEO_IMX319=3Dm
CONFIG_VIDEO_IMX355=3Dm
CONFIG_VIDEO_OV2640=3Dm
CONFIG_VIDEO_OV2659=3Dm
CONFIG_VIDEO_OV2680=3Dm
CONFIG_VIDEO_OV2685=3Dm
CONFIG_VIDEO_OV5640=3Dm
CONFIG_VIDEO_OV5645=3Dm
CONFIG_VIDEO_OV5647=3Dm
CONFIG_VIDEO_OV6650=3Dm
CONFIG_VIDEO_OV5670=3Dm
CONFIG_VIDEO_OV5675=3Dm
CONFIG_VIDEO_OV5695=3Dm
CONFIG_VIDEO_OV7251=3Dm
CONFIG_VIDEO_OV772X=3Dm
CONFIG_VIDEO_OV7640=3Dm
CONFIG_VIDEO_OV7670=3Dm
CONFIG_VIDEO_OV7740=3Dm
CONFIG_VIDEO_OV8856=3Dm
CONFIG_VIDEO_OV9640=3Dm
CONFIG_VIDEO_OV9650=3Dm
CONFIG_VIDEO_OV13858=3Dm
CONFIG_VIDEO_VS6624=3Dm
CONFIG_VIDEO_MT9M001=3Dm
CONFIG_VIDEO_MT9M032=3Dm
CONFIG_VIDEO_MT9M111=3Dm
CONFIG_VIDEO_MT9P031=3Dm
CONFIG_VIDEO_MT9T001=3Dm
CONFIG_VIDEO_MT9T112=3Dm
CONFIG_VIDEO_MT9V011=3Dm
CONFIG_VIDEO_MT9V032=3Dm
CONFIG_VIDEO_MT9V111=3Dm
CONFIG_VIDEO_SR030PC30=3Dm
CONFIG_VIDEO_NOON010PC30=3Dm
CONFIG_VIDEO_M5MOLS=3Dm
CONFIG_VIDEO_RJ54N1=3Dm
CONFIG_VIDEO_S5K6AA=3Dm
CONFIG_VIDEO_S5K6A3=3Dm
CONFIG_VIDEO_S5K4ECGX=3Dm
CONFIG_VIDEO_S5K5BAF=3Dm
CONFIG_VIDEO_SMIAPP=3Dm
CONFIG_VIDEO_ET8EK8=3Dm
CONFIG_VIDEO_S5C73M3=3Dm

#
# Lens drivers
#
CONFIG_VIDEO_AD5820=3Dm
CONFIG_VIDEO_AK7375=3Dm
CONFIG_VIDEO_DW9714=3Dm
CONFIG_VIDEO_DW9807_VCM=3Dm

#
# Flash devices
#
CONFIG_VIDEO_ADP1653=3Dm
CONFIG_VIDEO_LM3560=3Dm
CONFIG_VIDEO_LM3646=3Dm

#
# Video improvement chips
#
CONFIG_VIDEO_UPD64031A=3Dm
CONFIG_VIDEO_UPD64083=3Dm

#
# Audio/Video compression chips
#
CONFIG_VIDEO_SAA6752HS=3Dm

#
# SDR tuner chips
#
CONFIG_SDR_MAX2175=3Dm

#
# Miscellaneous helper chips
#
CONFIG_VIDEO_THS7303=3Dm
CONFIG_VIDEO_M52790=3Dm
CONFIG_VIDEO_I2C=3Dm
CONFIG_VIDEO_ST_MIPID02=3Dm
# end of I2C Encoders, decoders, sensors and other helper chips

#
# SPI helper chips
#
CONFIG_VIDEO_GS1662=3Dm
# end of SPI helper chips

#
# Media SPI Adapters
#
CONFIG_CXD2880_SPI_DRV=3Dm
# end of Media SPI Adapters

CONFIG_MEDIA_TUNER=3Dm

#
# Customize TV tuners
#
CONFIG_MEDIA_TUNER_SIMPLE=3Dm
CONFIG_MEDIA_TUNER_TDA18250=3Dm
CONFIG_MEDIA_TUNER_TDA8290=3Dm
CONFIG_MEDIA_TUNER_TDA827X=3Dm
CONFIG_MEDIA_TUNER_TDA18271=3Dm
CONFIG_MEDIA_TUNER_TDA9887=3Dm
CONFIG_MEDIA_TUNER_TEA5761=3Dm
CONFIG_MEDIA_TUNER_TEA5767=3Dm
CONFIG_MEDIA_TUNER_MSI001=3Dm
CONFIG_MEDIA_TUNER_MT20XX=3Dm
CONFIG_MEDIA_TUNER_MT2060=3Dm
CONFIG_MEDIA_TUNER_MT2063=3Dm
CONFIG_MEDIA_TUNER_MT2266=3Dm
CONFIG_MEDIA_TUNER_MT2131=3Dm
CONFIG_MEDIA_TUNER_QT1010=3Dm
CONFIG_MEDIA_TUNER_XC2028=3Dm
CONFIG_MEDIA_TUNER_XC5000=3Dm
CONFIG_MEDIA_TUNER_XC4000=3Dm
CONFIG_MEDIA_TUNER_MXL5005S=3Dm
CONFIG_MEDIA_TUNER_MXL5007T=3Dm
CONFIG_MEDIA_TUNER_MC44S803=3Dm
CONFIG_MEDIA_TUNER_MAX2165=3Dm
CONFIG_MEDIA_TUNER_TDA18218=3Dm
CONFIG_MEDIA_TUNER_FC0011=3Dm
CONFIG_MEDIA_TUNER_FC0012=3Dm
CONFIG_MEDIA_TUNER_FC0013=3Dm
CONFIG_MEDIA_TUNER_TDA18212=3Dm
CONFIG_MEDIA_TUNER_E4000=3Dm
CONFIG_MEDIA_TUNER_FC2580=3Dm
CONFIG_MEDIA_TUNER_M88RS6000T=3Dm
CONFIG_MEDIA_TUNER_TUA9001=3Dm
CONFIG_MEDIA_TUNER_SI2157=3Dm
CONFIG_MEDIA_TUNER_IT913X=3Dm
CONFIG_MEDIA_TUNER_R820T=3Dm
CONFIG_MEDIA_TUNER_MXL301RF=3Dm
CONFIG_MEDIA_TUNER_QM1D1C0042=3Dm
CONFIG_MEDIA_TUNER_QM1D1B0004=3Dm
# end of Customize TV tuners

#
# Customise DVB Frontends
#

#
# Multistandard (satellite) frontends
#
CONFIG_DVB_STB0899=3Dm
CONFIG_DVB_STB6100=3Dm
CONFIG_DVB_STV090x=3Dm
CONFIG_DVB_STV0910=3Dm
CONFIG_DVB_STV6110x=3Dm
CONFIG_DVB_STV6111=3Dm
CONFIG_DVB_MXL5XX=3Dm
CONFIG_DVB_M88DS3103=3Dm

#
# Multistandard (cable + terrestrial) frontends
#
CONFIG_DVB_DRXK=3Dm
CONFIG_DVB_TDA18271C2DD=3Dm
CONFIG_DVB_SI2165=3Dm
CONFIG_DVB_MN88472=3Dm
CONFIG_DVB_MN88473=3Dm

#
# DVB-S (satellite) frontends
#
CONFIG_DVB_CX24110=3Dm
CONFIG_DVB_CX24123=3Dm
CONFIG_DVB_MT312=3Dm
CONFIG_DVB_ZL10036=3Dm
CONFIG_DVB_ZL10039=3Dm
CONFIG_DVB_S5H1420=3Dm
CONFIG_DVB_STV0288=3Dm
CONFIG_DVB_STB6000=3Dm
CONFIG_DVB_STV0299=3Dm
CONFIG_DVB_STV6110=3Dm
CONFIG_DVB_STV0900=3Dm
CONFIG_DVB_TDA8083=3Dm
CONFIG_DVB_TDA10086=3Dm
CONFIG_DVB_TDA8261=3Dm
CONFIG_DVB_VES1X93=3Dm
CONFIG_DVB_TUNER_ITD1000=3Dm
CONFIG_DVB_TUNER_CX24113=3Dm
CONFIG_DVB_TDA826X=3Dm
CONFIG_DVB_TUA6100=3Dm
CONFIG_DVB_CX24116=3Dm
CONFIG_DVB_CX24117=3Dm
CONFIG_DVB_CX24120=3Dm
CONFIG_DVB_SI21XX=3Dm
CONFIG_DVB_TS2020=3Dm
CONFIG_DVB_DS3000=3Dm
CONFIG_DVB_MB86A16=3Dm
CONFIG_DVB_TDA10071=3Dm

#
# DVB-T (terrestrial) frontends
#
CONFIG_DVB_SP8870=3Dm
CONFIG_DVB_SP887X=3Dm
CONFIG_DVB_CX22700=3Dm
CONFIG_DVB_CX22702=3Dm
CONFIG_DVB_S5H1432=3Dm
CONFIG_DVB_DRXD=3Dm
CONFIG_DVB_L64781=3Dm
CONFIG_DVB_TDA1004X=3Dm
CONFIG_DVB_NXT6000=3Dm
CONFIG_DVB_MT352=3Dm
CONFIG_DVB_ZL10353=3Dm
CONFIG_DVB_DIB3000MB=3Dm
CONFIG_DVB_DIB3000MC=3Dm
CONFIG_DVB_DIB7000M=3Dm
CONFIG_DVB_DIB7000P=3Dm
CONFIG_DVB_DIB9000=3Dm
CONFIG_DVB_TDA10048=3Dm
CONFIG_DVB_AF9013=3Dm
CONFIG_DVB_EC100=3Dm
CONFIG_DVB_STV0367=3Dm
CONFIG_DVB_CXD2820R=3Dm
CONFIG_DVB_CXD2841ER=3Dm
CONFIG_DVB_RTL2830=3Dm
CONFIG_DVB_RTL2832=3Dm
CONFIG_DVB_RTL2832_SDR=3Dm
CONFIG_DVB_SI2168=3Dm
CONFIG_DVB_AS102_FE=3Dm
CONFIG_DVB_ZD1301_DEMOD=3Dm
CONFIG_DVB_GP8PSK_FE=3Dm
CONFIG_DVB_CXD2880=3Dm

#
# DVB-C (cable) frontends
#
CONFIG_DVB_VES1820=3Dm
CONFIG_DVB_TDA10021=3Dm
CONFIG_DVB_TDA10023=3Dm
CONFIG_DVB_STV0297=3Dm

#
# ATSC (North American/Korean Terrestrial/Cable DTV) frontends
#
CONFIG_DVB_NXT200X=3Dm
CONFIG_DVB_OR51211=3Dm
CONFIG_DVB_OR51132=3Dm
CONFIG_DVB_BCM3510=3Dm
CONFIG_DVB_LGDT330X=3Dm
CONFIG_DVB_LGDT3305=3Dm
CONFIG_DVB_LGDT3306A=3Dm
CONFIG_DVB_LG2160=3Dm
CONFIG_DVB_S5H1409=3Dm
CONFIG_DVB_AU8522=3Dm
CONFIG_DVB_AU8522_DTV=3Dm
CONFIG_DVB_AU8522_V4L=3Dm
CONFIG_DVB_S5H1411=3Dm

#
# ISDB-T (terrestrial) frontends
#
CONFIG_DVB_S921=3Dm
CONFIG_DVB_DIB8000=3Dm
CONFIG_DVB_MB86A20S=3Dm

#
# ISDB-S (satellite) & ISDB-T (terrestrial) frontends
#
CONFIG_DVB_TC90522=3Dm
CONFIG_DVB_MN88443X=3Dm

#
# Digital terrestrial only tuners/PLL
#
CONFIG_DVB_PLL=3Dm
CONFIG_DVB_TUNER_DIB0070=3Dm
CONFIG_DVB_TUNER_DIB0090=3Dm

#
# SEC control devices for DVB-S
#
CONFIG_DVB_DRX39XYJ=3Dm
CONFIG_DVB_LNBH25=3Dm
CONFIG_DVB_LNBH29=3Dm
CONFIG_DVB_LNBP21=3Dm
CONFIG_DVB_LNBP22=3Dm
CONFIG_DVB_ISL6405=3Dm
CONFIG_DVB_ISL6421=3Dm
CONFIG_DVB_ISL6423=3Dm
CONFIG_DVB_A8293=3Dm
CONFIG_DVB_LGS8GL5=3Dm
CONFIG_DVB_LGS8GXX=3Dm
CONFIG_DVB_ATBM8830=3Dm
CONFIG_DVB_TDA665x=3Dm
CONFIG_DVB_IX2505V=3Dm
CONFIG_DVB_M88RS2000=3Dm
CONFIG_DVB_AF9033=3Dm
CONFIG_DVB_HORUS3A=3Dm
CONFIG_DVB_ASCOT2E=3Dm
CONFIG_DVB_HELENE=3Dm

#
# Common Interface (EN50221) controller drivers
#
CONFIG_DVB_CXD2099=3Dm
CONFIG_DVB_SP2=3Dm

#
# Tools to develop new frontends
#
CONFIG_DVB_DUMMY_FE=3Dm
# end of Customise DVB Frontends

#
# Graphics support
#
CONFIG_AGP=3Dm
CONFIG_AGP_AMD64=3Dm
CONFIG_AGP_INTEL=3Dm
CONFIG_AGP_SIS=3Dm
CONFIG_AGP_VIA=3Dm
CONFIG_INTEL_GTT=3Dm
CONFIG_VGA_ARB=3Dy
CONFIG_VGA_ARB_MAX_GPUS=3D10
CONFIG_VGA_SWITCHEROO=3Dy
CONFIG_DRM=3Dm
CONFIG_DRM_MIPI_DBI=3Dm
CONFIG_DRM_MIPI_DSI=3Dy
CONFIG_DRM_DP_AUX_CHARDEV=3Dy
# CONFIG_DRM_DEBUG_SELFTEST is not set
CONFIG_DRM_KMS_HELPER=3Dm
CONFIG_DRM_KMS_FB_HELPER=3Dy
# CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
CONFIG_DRM_FBDEV_EMULATION=3Dy
CONFIG_DRM_FBDEV_OVERALLOC=3D100
# CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
CONFIG_DRM_DP_CEC=3Dy
CONFIG_DRM_TTM=3Dm
CONFIG_DRM_TTM_DMA_PAGE_POOL=3Dy
CONFIG_DRM_VRAM_HELPER=3Dm
CONFIG_DRM_TTM_HELPER=3Dm
CONFIG_DRM_GEM_CMA_HELPER=3Dy
CONFIG_DRM_KMS_CMA_HELPER=3Dy
CONFIG_DRM_GEM_SHMEM_HELPER=3Dy
CONFIG_DRM_SCHED=3Dm

#
# I2C encoder or helper chips
#
CONFIG_DRM_I2C_CH7006=3Dm
CONFIG_DRM_I2C_SIL164=3Dm
CONFIG_DRM_I2C_NXP_TDA998X=3Dm
CONFIG_DRM_I2C_NXP_TDA9950=3Dm
# end of I2C encoder or helper chips

#
# ARM devices
#
CONFIG_DRM_KOMEDA=3Dm
# end of ARM devices

CONFIG_DRM_RADEON=3Dm
CONFIG_DRM_RADEON_USERPTR=3Dy
CONFIG_DRM_AMDGPU=3Dm
CONFIG_DRM_AMDGPU_SI=3Dy
CONFIG_DRM_AMDGPU_CIK=3Dy
CONFIG_DRM_AMDGPU_USERPTR=3Dy
# CONFIG_DRM_AMDGPU_GART_DEBUGFS is not set

#
# ACP (Audio CoProcessor) Configuration
#
CONFIG_DRM_AMD_ACP=3Dy
# end of ACP (Audio CoProcessor) Configuration

#
# Display Engine Configuration
#
CONFIG_DRM_AMD_DC=3Dy
CONFIG_DRM_AMD_DC_DCN=3Dy
CONFIG_DRM_AMD_DC_HDCP=3Dy
# CONFIG_DEBUG_KERNEL_DC is not set
# end of Display Engine Configuration

CONFIG_HSA_AMD=3Dy
CONFIG_DRM_NOUVEAU=3Dm
# CONFIG_NOUVEAU_LEGACY_CTX_SUPPORT is not set
CONFIG_NOUVEAU_DEBUG=3D5
CONFIG_NOUVEAU_DEBUG_DEFAULT=3D3
# CONFIG_NOUVEAU_DEBUG_MMU is not set
CONFIG_DRM_NOUVEAU_BACKLIGHT=3Dy
CONFIG_DRM_NOUVEAU_SVM=3Dy
CONFIG_DRM_I915=3Dm
CONFIG_DRM_I915_ALPHA_SUPPORT=3Dy
CONFIG_DRM_I915_FORCE_PROBE=3D"*"
CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
CONFIG_DRM_I915_USERPTR=3Dy
CONFIG_DRM_I915_GVT=3Dy
CONFIG_DRM_I915_GVT_KVMGT=3Dm

#
# drm/i915 Debugging
#
# CONFIG_DRM_I915_WERROR is not set
# CONFIG_DRM_I915_DEBUG is not set
# CONFIG_DRM_I915_DEBUG_MMIO is not set
# CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
# CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
# CONFIG_DRM_I915_DEBUG_GUC is not set
# CONFIG_DRM_I915_SELFTEST is not set
# CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
# CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
# CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
# end of drm/i915 Debugging

#
# drm/i915 Profile Guided Optimisation
#
CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
CONFIG_DRM_I915_SPIN_REQUEST=3D5
CONFIG_DRM_I915_STOP_TIMEOUT=3D100
CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
# end of drm/i915 Profile Guided Optimisation

CONFIG_DRM_VGEM=3Dm
CONFIG_DRM_VKMS=3Dm
CONFIG_DRM_VMWGFX=3Dm
CONFIG_DRM_VMWGFX_FBCON=3Dy
CONFIG_DRM_GMA500=3Dm
CONFIG_DRM_GMA600=3Dy
CONFIG_DRM_GMA3600=3Dy
CONFIG_DRM_UDL=3Dm
CONFIG_DRM_AST=3Dm
CONFIG_DRM_MGAG200=3Dm
CONFIG_DRM_CIRRUS_QEMU=3Dm
CONFIG_DRM_RCAR_DW_HDMI=3Dm
CONFIG_DRM_RCAR_LVDS=3Dm
CONFIG_DRM_QXL=3Dm
CONFIG_DRM_BOCHS=3Dm
CONFIG_DRM_VIRTIO_GPU=3Dm
CONFIG_DRM_PANEL=3Dy

#
# Display Panels
#
CONFIG_DRM_PANEL_ARM_VERSATILE=3Dm
CONFIG_DRM_PANEL_BOE_HIMAX8279D=3Dm
CONFIG_DRM_PANEL_LVDS=3Dm
CONFIG_DRM_PANEL_SIMPLE=3Dm
CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D=3Dm
CONFIG_DRM_PANEL_ILITEK_IL9322=3Dm
CONFIG_DRM_PANEL_ILITEK_ILI9881C=3Dm
CONFIG_DRM_PANEL_INNOLUX_P079ZCA=3Dm
CONFIG_DRM_PANEL_JDI_LT070ME05000=3Dm
CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04=3Dm
CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829=3Dm
CONFIG_DRM_PANEL_SAMSUNG_LD9040=3Dm
CONFIG_DRM_PANEL_LG_LB035Q02=3Dm
CONFIG_DRM_PANEL_LG_LG4573=3Dm
CONFIG_DRM_PANEL_NEC_NL8048HL11=3Dm
CONFIG_DRM_PANEL_NOVATEK_NT39016=3Dm
CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO=3Dm
CONFIG_DRM_PANEL_ORISETECH_OTM8009A=3Dm
CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS=3Dm
CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00=3Dm
CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN=3Dm
CONFIG_DRM_PANEL_RAYDIUM_RM67191=3Dm
CONFIG_DRM_PANEL_RAYDIUM_RM68200=3Dm
CONFIG_DRM_PANEL_ROCKTECH_JH057N00900=3Dm
CONFIG_DRM_PANEL_RONBO_RB070D30=3Dm
CONFIG_DRM_PANEL_SAMSUNG_S6D16D0=3Dm
CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2=3Dm
CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03=3Dm
CONFIG_DRM_PANEL_SAMSUNG_S6E63M0=3Dm
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=3Dm
CONFIG_DRM_PANEL_SEIKO_43WVF1G=3Dm
CONFIG_DRM_PANEL_SHARP_LQ101R1SX01=3Dm
CONFIG_DRM_PANEL_SHARP_LS037V7DW01=3Dm
CONFIG_DRM_PANEL_SHARP_LS043T1LE01=3Dm
CONFIG_DRM_PANEL_SITRONIX_ST7701=3Dm
CONFIG_DRM_PANEL_SITRONIX_ST7789V=3Dm
CONFIG_DRM_PANEL_SONY_ACX424AKP=3Dm
CONFIG_DRM_PANEL_SONY_ACX565AKM=3Dm
CONFIG_DRM_PANEL_TPO_TD028TTEC1=3Dm
CONFIG_DRM_PANEL_TPO_TD043MTEA1=3Dm
CONFIG_DRM_PANEL_TPO_TPG110=3Dm
CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA=3Dm
CONFIG_DRM_PANEL_XINPENG_XPP055C272=3Dm
# end of Display Panels

CONFIG_DRM_BRIDGE=3Dy
CONFIG_DRM_PANEL_BRIDGE=3Dy

#
# Display Interface Bridges
#
CONFIG_DRM_CDNS_DSI=3Dm
CONFIG_DRM_DUMB_VGA_DAC=3Dm
CONFIG_DRM_LVDS_CODEC=3Dm
CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW=3Dm
CONFIG_DRM_NXP_PTN3460=3Dm
CONFIG_DRM_PARADE_PS8622=3Dm
CONFIG_DRM_SIL_SII8620=3Dm
CONFIG_DRM_SII902X=3Dm
CONFIG_DRM_SII9234=3Dm
CONFIG_DRM_THINE_THC63LVD1024=3Dm
CONFIG_DRM_TOSHIBA_TC358764=3Dm
CONFIG_DRM_TOSHIBA_TC358767=3Dm
CONFIG_DRM_TI_TFP410=3Dm
CONFIG_DRM_TI_SN65DSI86=3Dm
CONFIG_DRM_ANALOGIX_ANX6345=3Dm
CONFIG_DRM_ANALOGIX_ANX78XX=3Dm
CONFIG_DRM_ANALOGIX_DP=3Dm
CONFIG_DRM_I2C_ADV7511=3Dm
CONFIG_DRM_I2C_ADV7511_AUDIO=3Dy
CONFIG_DRM_I2C_ADV7533=3Dy
CONFIG_DRM_I2C_ADV7511_CEC=3Dy
CONFIG_DRM_DW_HDMI=3Dm
CONFIG_DRM_DW_HDMI_AHB_AUDIO=3Dm
CONFIG_DRM_DW_HDMI_I2S_AUDIO=3Dm
CONFIG_DRM_DW_HDMI_CEC=3Dm
# end of Display Interface Bridges

# CONFIG_DRM_ETNAVIV is not set
CONFIG_DRM_ARCPGU=3Dm
CONFIG_DRM_MXS=3Dy
CONFIG_DRM_MXSFB=3Dm
CONFIG_DRM_GM12U320=3Dm
CONFIG_TINYDRM_HX8357D=3Dm
CONFIG_TINYDRM_ILI9225=3Dm
CONFIG_TINYDRM_ILI9341=3Dm
CONFIG_TINYDRM_MI0283QT=3Dm
CONFIG_TINYDRM_REPAPER=3Dm
CONFIG_TINYDRM_ST7586=3Dm
CONFIG_TINYDRM_ST7735R=3Dm
CONFIG_DRM_XEN=3Dy
CONFIG_DRM_XEN_FRONTEND=3Dm
CONFIG_DRM_VBOXVIDEO=3Dm
# CONFIG_DRM_LEGACY is not set
CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy

#
# Frame buffer Devices
#
CONFIG_FB_CMDLINE=3Dy
CONFIG_FB_NOTIFY=3Dy
CONFIG_FB=3Dy
CONFIG_FIRMWARE_EDID=3Dy
CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
CONFIG_FB_CFB_FILLRECT=3Dy
CONFIG_FB_CFB_COPYAREA=3Dy
CONFIG_FB_CFB_IMAGEBLIT=3Dy
CONFIG_FB_SYS_FILLRECT=3Dm
CONFIG_FB_SYS_COPYAREA=3Dm
CONFIG_FB_SYS_IMAGEBLIT=3Dm
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=3Dm
CONFIG_FB_DEFERRED_IO=3Dy
CONFIG_FB_BACKLIGHT=3Dm
CONFIG_FB_MODE_HELPERS=3Dy
CONFIG_FB_TILEBLITTING=3Dy

#
# Frame buffer hardware drivers
#
# CONFIG_FB_CIRRUS is not set
# CONFIG_FB_PM2 is not set
# CONFIG_FB_CYBER2000 is not set
# CONFIG_FB_ARC is not set
# CONFIG_FB_ASILIANT is not set
# CONFIG_FB_IMSTT is not set
# CONFIG_FB_VGA16 is not set
# CONFIG_FB_UVESA is not set
CONFIG_FB_VESA=3Dy
CONFIG_FB_EFI=3Dy
# CONFIG_FB_N411 is not set
# CONFIG_FB_HGA is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_NVIDIA is not set
# CONFIG_FB_RIVA is not set
# CONFIG_FB_I740 is not set
# CONFIG_FB_LE80578 is not set
# CONFIG_FB_INTEL is not set
# CONFIG_FB_MATROX is not set
# CONFIG_FB_RADEON is not set
# CONFIG_FB_ATY128 is not set
# CONFIG_FB_ATY is not set
# CONFIG_FB_S3 is not set
# CONFIG_FB_SAVAGE is not set
# CONFIG_FB_SIS is not set
# CONFIG_FB_VIA is not set
# CONFIG_FB_NEOMAGIC is not set
# CONFIG_FB_KYRO is not set
# CONFIG_FB_3DFX is not set
# CONFIG_FB_VOODOO1 is not set
# CONFIG_FB_VT8623 is not set
# CONFIG_FB_TRIDENT is not set
# CONFIG_FB_ARK is not set
# CONFIG_FB_PM3 is not set
# CONFIG_FB_CARMINE is not set
# CONFIG_FB_SM501 is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_IBM_GXT4500 is not set
# CONFIG_FB_VIRTUAL is not set
CONFIG_XEN_FBDEV_FRONTEND=3Dm
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_MB862XX is not set
CONFIG_FB_HYPERV=3Dm
CONFIG_FB_SIMPLE=3Dy
# CONFIG_FB_SSD1307 is not set
# CONFIG_FB_SM712 is not set
# end of Frame buffer Devices

#
# Backlight & LCD device support
#
CONFIG_LCD_CLASS_DEVICE=3Dm
CONFIG_LCD_L4F00242T03=3Dm
CONFIG_LCD_LMS283GF05=3Dm
CONFIG_LCD_LTV350QV=3Dm
CONFIG_LCD_ILI922X=3Dm
CONFIG_LCD_ILI9320=3Dm
CONFIG_LCD_TDO24M=3Dm
CONFIG_LCD_VGG2432A4=3Dm
CONFIG_LCD_PLATFORM=3Dm
CONFIG_LCD_AMS369FG06=3Dm
CONFIG_LCD_LMS501KF03=3Dm
CONFIG_LCD_HX8357=3Dm
CONFIG_LCD_OTM3225A=3Dm
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
CONFIG_BACKLIGHT_GENERIC=3Dm
CONFIG_BACKLIGHT_LM3533=3Dm
CONFIG_BACKLIGHT_PWM=3Dm
CONFIG_BACKLIGHT_DA903X=3Dm
CONFIG_BACKLIGHT_DA9052=3Dm
CONFIG_BACKLIGHT_MAX8925=3Dm
CONFIG_BACKLIGHT_APPLE=3Dm
CONFIG_BACKLIGHT_QCOM_WLED=3Dm
CONFIG_BACKLIGHT_SAHARA=3Dm
CONFIG_BACKLIGHT_WM831X=3Dm
CONFIG_BACKLIGHT_ADP5520=3Dm
CONFIG_BACKLIGHT_ADP8860=3Dm
CONFIG_BACKLIGHT_ADP8870=3Dm
CONFIG_BACKLIGHT_88PM860X=3Dm
CONFIG_BACKLIGHT_PCF50633=3Dm
CONFIG_BACKLIGHT_AAT2870=3Dm
CONFIG_BACKLIGHT_LM3630A=3Dm
CONFIG_BACKLIGHT_LM3639=3Dm
CONFIG_BACKLIGHT_LP855X=3Dm
CONFIG_BACKLIGHT_LP8788=3Dm
CONFIG_BACKLIGHT_PANDORA=3Dm
CONFIG_BACKLIGHT_SKY81452=3Dm
CONFIG_BACKLIGHT_TPS65217=3Dm
CONFIG_BACKLIGHT_AS3711=3Dm
CONFIG_BACKLIGHT_GPIO=3Dm
CONFIG_BACKLIGHT_LV5207LP=3Dm
CONFIG_BACKLIGHT_BD6107=3Dm
CONFIG_BACKLIGHT_ARCXCNN=3Dm
CONFIG_BACKLIGHT_RAVE_SP=3Dm
CONFIG_BACKLIGHT_LED=3Dm
# end of Backlight & LCD device support

CONFIG_VIDEOMODE_HELPERS=3Dy
CONFIG_HDMI=3Dy

#
# Console display driver support
#
CONFIG_VGA_CONSOLE=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK=3Dy
CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=3D64
# CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
CONFIG_DUMMY_CONSOLE=3Dy
CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
CONFIG_DUMMY_CONSOLE_ROWS=3D25
CONFIG_FRAMEBUFFER_CONSOLE=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER=3Dy
# end of Console display driver support

# CONFIG_LOGO is not set
# end of Graphics support

CONFIG_SOUND=3Dm
CONFIG_SOUND_OSS_CORE=3Dy
# CONFIG_SOUND_OSS_CORE_PRECLAIM is not set
CONFIG_SND=3Dm
CONFIG_SND_TIMER=3Dm
CONFIG_SND_PCM=3Dm
CONFIG_SND_PCM_ELD=3Dy
CONFIG_SND_PCM_IEC958=3Dy
CONFIG_SND_DMAENGINE_PCM=3Dm
CONFIG_SND_HWDEP=3Dm
CONFIG_SND_SEQ_DEVICE=3Dm
CONFIG_SND_RAWMIDI=3Dm
CONFIG_SND_COMPRESS_OFFLOAD=3Dm
CONFIG_SND_JACK=3Dy
CONFIG_SND_JACK_INPUT_DEV=3Dy
CONFIG_SND_OSSEMUL=3Dy
CONFIG_SND_MIXER_OSS=3Dm
CONFIG_SND_PCM_OSS=3Dm
CONFIG_SND_PCM_OSS_PLUGINS=3Dy
CONFIG_SND_PCM_TIMER=3Dy
CONFIG_SND_HRTIMER=3Dm
CONFIG_SND_DYNAMIC_MINORS=3Dy
CONFIG_SND_MAX_CARDS=3D32
# CONFIG_SND_SUPPORT_OLD_API is not set
CONFIG_SND_PROC_FS=3Dy
CONFIG_SND_VERBOSE_PROCFS=3Dy
CONFIG_SND_VERBOSE_PRINTK=3Dy
CONFIG_SND_DEBUG=3Dy
# CONFIG_SND_DEBUG_VERBOSE is not set
# CONFIG_SND_PCM_XRUN_DEBUG is not set
# CONFIG_SND_CTL_VALIDATION is not set
CONFIG_SND_VMASTER=3Dy
CONFIG_SND_DMA_SGBUF=3Dy
CONFIG_SND_SEQUENCER=3Dm
CONFIG_SND_SEQ_DUMMY=3Dm
CONFIG_SND_SEQUENCER_OSS=3Dm
CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
CONFIG_SND_SEQ_MIDI_EVENT=3Dm
CONFIG_SND_SEQ_MIDI=3Dm
CONFIG_SND_SEQ_MIDI_EMUL=3Dm
CONFIG_SND_SEQ_VIRMIDI=3Dm
CONFIG_SND_MPU401_UART=3Dm
CONFIG_SND_OPL3_LIB=3Dm
CONFIG_SND_OPL3_LIB_SEQ=3Dm
CONFIG_SND_VX_LIB=3Dm
CONFIG_SND_AC97_CODEC=3Dm
CONFIG_SND_DRIVERS=3Dy
# CONFIG_SND_PCSP is not set
CONFIG_SND_DUMMY=3Dm
CONFIG_SND_ALOOP=3Dm
CONFIG_SND_VIRMIDI=3Dm
CONFIG_SND_MTPAV=3Dm
CONFIG_SND_MTS64=3Dm
CONFIG_SND_SERIAL_U16550=3Dm
CONFIG_SND_MPU401=3Dm
CONFIG_SND_PORTMAN2X4=3Dm
CONFIG_SND_AC97_POWER_SAVE=3Dy
CONFIG_SND_AC97_POWER_SAVE_DEFAULT=3D0
CONFIG_SND_SB_COMMON=3Dm
CONFIG_SND_PCI=3Dy
CONFIG_SND_AD1889=3Dm
CONFIG_SND_ALS300=3Dm
CONFIG_SND_ALS4000=3Dm
CONFIG_SND_ALI5451=3Dm
CONFIG_SND_ASIHPI=3Dm
CONFIG_SND_ATIIXP=3Dm
CONFIG_SND_ATIIXP_MODEM=3Dm
CONFIG_SND_AU8810=3Dm
CONFIG_SND_AU8820=3Dm
CONFIG_SND_AU8830=3Dm
CONFIG_SND_AW2=3Dm
CONFIG_SND_AZT3328=3Dm
CONFIG_SND_BT87X=3Dm
# CONFIG_SND_BT87X_OVERCLOCK is not set
CONFIG_SND_CA0106=3Dm
CONFIG_SND_CMIPCI=3Dm
CONFIG_SND_OXYGEN_LIB=3Dm
CONFIG_SND_OXYGEN=3Dm
CONFIG_SND_CS4281=3Dm
CONFIG_SND_CS46XX=3Dm
CONFIG_SND_CS46XX_NEW_DSP=3Dy
CONFIG_SND_CTXFI=3Dm
CONFIG_SND_DARLA20=3Dm
CONFIG_SND_GINA20=3Dm
CONFIG_SND_LAYLA20=3Dm
CONFIG_SND_DARLA24=3Dm
CONFIG_SND_GINA24=3Dm
CONFIG_SND_LAYLA24=3Dm
CONFIG_SND_MONA=3Dm
CONFIG_SND_MIA=3Dm
CONFIG_SND_ECHO3G=3Dm
CONFIG_SND_INDIGO=3Dm
CONFIG_SND_INDIGOIO=3Dm
CONFIG_SND_INDIGODJ=3Dm
CONFIG_SND_INDIGOIOX=3Dm
CONFIG_SND_INDIGODJX=3Dm
CONFIG_SND_EMU10K1=3Dm
CONFIG_SND_EMU10K1_SEQ=3Dm
CONFIG_SND_EMU10K1X=3Dm
CONFIG_SND_ENS1370=3Dm
CONFIG_SND_ENS1371=3Dm
CONFIG_SND_ES1938=3Dm
CONFIG_SND_ES1968=3Dm
CONFIG_SND_ES1968_INPUT=3Dy
CONFIG_SND_ES1968_RADIO=3Dy
CONFIG_SND_FM801=3Dm
CONFIG_SND_FM801_TEA575X_BOOL=3Dy
CONFIG_SND_HDSP=3Dm
CONFIG_SND_HDSPM=3Dm
CONFIG_SND_ICE1712=3Dm
CONFIG_SND_ICE1724=3Dm
CONFIG_SND_INTEL8X0=3Dm
CONFIG_SND_INTEL8X0M=3Dm
CONFIG_SND_KORG1212=3Dm
CONFIG_SND_LOLA=3Dm
CONFIG_SND_LX6464ES=3Dm
CONFIG_SND_MAESTRO3=3Dm
CONFIG_SND_MAESTRO3_INPUT=3Dy
CONFIG_SND_MIXART=3Dm
CONFIG_SND_NM256=3Dm
CONFIG_SND_PCXHR=3Dm
CONFIG_SND_RIPTIDE=3Dm
CONFIG_SND_RME32=3Dm
CONFIG_SND_RME96=3Dm
CONFIG_SND_RME9652=3Dm
CONFIG_SND_SONICVIBES=3Dm
CONFIG_SND_TRIDENT=3Dm
CONFIG_SND_VIA82XX=3Dm
CONFIG_SND_VIA82XX_MODEM=3Dm
CONFIG_SND_VIRTUOSO=3Dm
CONFIG_SND_VX222=3Dm
CONFIG_SND_YMFPCI=3Dm

#
# HD-Audio
#
CONFIG_SND_HDA=3Dm
CONFIG_SND_HDA_INTEL=3Dm
CONFIG_SND_HDA_HWDEP=3Dy
CONFIG_SND_HDA_RECONFIG=3Dy
CONFIG_SND_HDA_INPUT_BEEP=3Dy
CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
CONFIG_SND_HDA_PATCH_LOADER=3Dy
CONFIG_SND_HDA_CODEC_REALTEK=3Dm
CONFIG_SND_HDA_CODEC_ANALOG=3Dm
CONFIG_SND_HDA_CODEC_SIGMATEL=3Dm
CONFIG_SND_HDA_CODEC_VIA=3Dm
CONFIG_SND_HDA_CODEC_HDMI=3Dm
CONFIG_SND_HDA_CODEC_CIRRUS=3Dm
CONFIG_SND_HDA_CODEC_CONEXANT=3Dm
CONFIG_SND_HDA_CODEC_CA0110=3Dm
CONFIG_SND_HDA_CODEC_CA0132=3Dm
CONFIG_SND_HDA_CODEC_CA0132_DSP=3Dy
CONFIG_SND_HDA_CODEC_CMEDIA=3Dm
CONFIG_SND_HDA_CODEC_SI3054=3Dm
CONFIG_SND_HDA_GENERIC=3Dm
CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
# end of HD-Audio

CONFIG_SND_HDA_CORE=3Dm
CONFIG_SND_HDA_DSP_LOADER=3Dy
CONFIG_SND_HDA_COMPONENT=3Dy
CONFIG_SND_HDA_I915=3Dy
CONFIG_SND_HDA_EXT_CORE=3Dm
CONFIG_SND_HDA_PREALLOC_SIZE=3D0
CONFIG_SND_INTEL_NHLT=3Dy
CONFIG_SND_INTEL_DSP_CONFIG=3Dm
CONFIG_SND_SPI=3Dy
CONFIG_SND_USB=3Dy
CONFIG_SND_USB_AUDIO=3Dm
CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy
CONFIG_SND_USB_UA101=3Dm
CONFIG_SND_USB_USX2Y=3Dm
CONFIG_SND_USB_CAIAQ=3Dm
CONFIG_SND_USB_CAIAQ_INPUT=3Dy
CONFIG_SND_USB_US122L=3Dm
CONFIG_SND_USB_6FIRE=3Dm
CONFIG_SND_USB_HIFACE=3Dm
CONFIG_SND_BCD2000=3Dm
CONFIG_SND_USB_LINE6=3Dm
CONFIG_SND_USB_POD=3Dm
CONFIG_SND_USB_PODHD=3Dm
CONFIG_SND_USB_TONEPORT=3Dm
CONFIG_SND_USB_VARIAX=3Dm
CONFIG_SND_FIREWIRE=3Dy
CONFIG_SND_FIREWIRE_LIB=3Dm
CONFIG_SND_DICE=3Dm
CONFIG_SND_OXFW=3Dm
CONFIG_SND_ISIGHT=3Dm
CONFIG_SND_FIREWORKS=3Dm
CONFIG_SND_BEBOB=3Dm
CONFIG_SND_FIREWIRE_DIGI00X=3Dm
CONFIG_SND_FIREWIRE_TASCAM=3Dm
CONFIG_SND_FIREWIRE_MOTU=3Dm
CONFIG_SND_FIREFACE=3Dm
CONFIG_SND_PCMCIA=3Dy
CONFIG_SND_VXPOCKET=3Dm
CONFIG_SND_PDAUDIOCF=3Dm
CONFIG_SND_SOC=3Dm
CONFIG_SND_SOC_AC97_BUS=3Dy
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=3Dy
CONFIG_SND_SOC_COMPRESS=3Dy
CONFIG_SND_SOC_TOPOLOGY=3Dy
CONFIG_SND_SOC_ACPI=3Dm
CONFIG_SND_SOC_AMD_ACP=3Dm
CONFIG_SND_SOC_AMD_CZ_DA7219MX98357_MACH=3Dm
CONFIG_SND_SOC_AMD_CZ_RT5645_MACH=3Dm
CONFIG_SND_SOC_AMD_ACP3x=3Dm
CONFIG_SND_ATMEL_SOC=3Dm
CONFIG_SND_SOC_MIKROE_PROTO=3Dm
CONFIG_SND_DESIGNWARE_I2S=3Dm
CONFIG_SND_DESIGNWARE_PCM=3Dy

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_AUDMIX is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_FSL_MICFIL is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
# end of SoC Audio for Freescale CPUs

CONFIG_SND_I2S_HI6210_I2S=3Dm
CONFIG_SND_SOC_IMG=3Dy
CONFIG_SND_SOC_IMG_I2S_IN=3Dm
CONFIG_SND_SOC_IMG_I2S_OUT=3Dm
CONFIG_SND_SOC_IMG_PARALLEL_OUT=3Dm
CONFIG_SND_SOC_IMG_SPDIF_IN=3Dm
CONFIG_SND_SOC_IMG_SPDIF_OUT=3Dm
CONFIG_SND_SOC_IMG_PISTACHIO_INTERNAL_DAC=3Dm
CONFIG_SND_SOC_INTEL_SST_TOPLEVEL=3Dy
CONFIG_SND_SST_IPC=3Dm
CONFIG_SND_SST_IPC_PCI=3Dm
CONFIG_SND_SST_IPC_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SST_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SST=3Dm
CONFIG_SND_SOC_INTEL_SST_FIRMWARE=3Dm
CONFIG_SND_SOC_INTEL_HASWELL=3Dm
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM=3Dm
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_PCI=3Dm
CONFIG_SND_SST_ATOM_HIFI2_PLATFORM_ACPI=3Dm
CONFIG_SND_SOC_INTEL_SKYLAKE=3Dm
CONFIG_SND_SOC_INTEL_SKL=3Dm
CONFIG_SND_SOC_INTEL_APL=3Dm
CONFIG_SND_SOC_INTEL_KBL=3Dm
CONFIG_SND_SOC_INTEL_GLK=3Dm
CONFIG_SND_SOC_INTEL_CNL=3Dm
CONFIG_SND_SOC_INTEL_CFL=3Dm
CONFIG_SND_SOC_INTEL_CML_H=3Dm
CONFIG_SND_SOC_INTEL_CML_LP=3Dm
CONFIG_SND_SOC_INTEL_SKYLAKE_FAMILY=3Dm
CONFIG_SND_SOC_INTEL_SKYLAKE_SSP_CLK=3Dm
# CONFIG_SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC is not set
CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON=3Dm
CONFIG_SND_SOC_ACPI_INTEL_MATCH=3Dm
CONFIG_SND_SOC_INTEL_MACH=3Dy
# CONFIG_SND_SOC_INTEL_USER_FRIENDLY_LONG_NAMES is not set
CONFIG_SND_SOC_INTEL_HASWELL_MACH=3Dm
CONFIG_SND_SOC_INTEL_BDW_RT5650_MACH=3Dm
CONFIG_SND_SOC_INTEL_BDW_RT5677_MACH=3Dm
CONFIG_SND_SOC_INTEL_BROADWELL_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYTCR_RT5640_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYTCR_RT5651_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5672_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_RT5645_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_MAX98090_TI_MACH=3Dm
CONFIG_SND_SOC_INTEL_CHT_BSW_NAU8824_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_CHT_CX2072X_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_CHT_DA7213_MACH=3Dm
CONFIG_SND_SOC_INTEL_BYT_CHT_ES8316_MACH=3Dm
# CONFIG_SND_SOC_INTEL_BYT_CHT_NOCODEC_MACH is not set
CONFIG_SND_SOC_INTEL_SKL_RT286_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_SSM4567_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_NAU88L25_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_DA7219_MAX98357A_GENERIC=3Dm
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_COMMON=3Dm
CONFIG_SND_SOC_INTEL_BXT_DA7219_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_BXT_RT298_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_RT5663_MAX98927_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_RT5663_RT5514_MAX98927_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_DA7219_MAX98927_MACH=3Dm
CONFIG_SND_SOC_INTEL_KBL_RT5660_MACH=3Dm
CONFIG_SND_SOC_INTEL_GLK_DA7219_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_GLK_RT5682_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_SKL_HDA_DSP_GENERIC_MACH=3Dm
CONFIG_SND_SOC_INTEL_SOF_RT5682_MACH=3Dm
CONFIG_SND_SOC_INTEL_CML_LP_DA7219_MAX98357A_MACH=3Dm
CONFIG_SND_SOC_INTEL_SOF_CML_RT1011_RT5682_MACH=3Dm
CONFIG_SND_SOC_INTEL_SOF_DA7219_MAX98373_MACH=3Dm
CONFIG_SND_SOC_MTK_BTCVSD=3Dm
CONFIG_SND_SOC_SOF_TOPLEVEL=3Dy
CONFIG_SND_SOC_SOF_PCI=3Dm
CONFIG_SND_SOC_SOF_ACPI=3Dm
CONFIG_SND_SOC_SOF_OF=3Dm
# CONFIG_SND_SOC_SOF_DEVELOPER_SUPPORT is not set
CONFIG_SND_SOC_SOF=3Dm
CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE=3Dy
CONFIG_SND_SOC_SOF_INTEL_TOPLEVEL=3Dy
CONFIG_SND_SOC_SOF_INTEL_ACPI=3Dm
CONFIG_SND_SOC_SOF_INTEL_PCI=3Dm
CONFIG_SND_SOC_SOF_INTEL_HIFI_EP_IPC=3Dm
CONFIG_SND_SOC_SOF_INTEL_ATOM_HIFI_EP=3Dm
CONFIG_SND_SOC_SOF_INTEL_COMMON=3Dm
CONFIG_SND_SOC_SOF_MERRIFIELD_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_MERRIFIELD=3Dm
CONFIG_SND_SOC_SOF_APOLLOLAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_APOLLOLAKE=3Dm
CONFIG_SND_SOC_SOF_GEMINILAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_GEMINILAKE=3Dm
CONFIG_SND_SOC_SOF_CANNONLAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_CANNONLAKE=3Dm
CONFIG_SND_SOC_SOF_COFFEELAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_COFFEELAKE=3Dm
CONFIG_SND_SOC_SOF_ICELAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_ICELAKE=3Dm
CONFIG_SND_SOC_SOF_COMETLAKE_LP=3Dm
CONFIG_SND_SOC_SOF_COMETLAKE_LP_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_COMETLAKE_H=3Dm
CONFIG_SND_SOC_SOF_COMETLAKE_H_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_TIGERLAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_TIGERLAKE=3Dm
CONFIG_SND_SOC_SOF_ELKHARTLAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_ELKHARTLAKE=3Dm
CONFIG_SND_SOC_SOF_JASPERLAKE_SUPPORT=3Dy
CONFIG_SND_SOC_SOF_JASPERLAKE=3Dm
CONFIG_SND_SOC_SOF_HDA_COMMON=3Dm
CONFIG_SND_SOC_SOF_HDA_LINK=3Dy
CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC=3Dy
# CONFIG_SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1 is not set
CONFIG_SND_SOC_SOF_HDA_COMMON_HDMI_CODEC=3Dy
CONFIG_SND_SOC_SOF_HDA_LINK_BASELINE=3Dm
CONFIG_SND_SOC_SOF_HDA=3Dm
CONFIG_SND_SOC_SOF_XTENSA=3Dm

#
# STMicroelectronics STM32 SOC audio support
#
# end of STMicroelectronics STM32 SOC audio support

CONFIG_SND_SOC_XILINX_I2S=3Dm
CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER=3Dm
CONFIG_SND_SOC_XILINX_SPDIF=3Dm
CONFIG_SND_SOC_XTFPGA_I2S=3Dm
CONFIG_ZX_TDM=3Dm
CONFIG_SND_SOC_I2C_AND_SPI=3Dm

#
# CODEC drivers
#
CONFIG_SND_SOC_AC97_CODEC=3Dm
CONFIG_SND_SOC_ADAU_UTILS=3Dm
CONFIG_SND_SOC_ADAU1701=3Dm
CONFIG_SND_SOC_ADAU17X1=3Dm
CONFIG_SND_SOC_ADAU1761=3Dm
CONFIG_SND_SOC_ADAU1761_I2C=3Dm
CONFIG_SND_SOC_ADAU1761_SPI=3Dm
CONFIG_SND_SOC_ADAU7002=3Dm
CONFIG_SND_SOC_ADAU7118=3Dm
CONFIG_SND_SOC_ADAU7118_HW=3Dm
CONFIG_SND_SOC_ADAU7118_I2C=3Dm
CONFIG_SND_SOC_AK4104=3Dm
CONFIG_SND_SOC_AK4118=3Dm
CONFIG_SND_SOC_AK4458=3Dm
CONFIG_SND_SOC_AK4554=3Dm
CONFIG_SND_SOC_AK4613=3Dm
CONFIG_SND_SOC_AK4642=3Dm
CONFIG_SND_SOC_AK5386=3Dm
CONFIG_SND_SOC_AK5558=3Dm
CONFIG_SND_SOC_ALC5623=3Dm
CONFIG_SND_SOC_BD28623=3Dm
# CONFIG_SND_SOC_BT_SCO is not set
CONFIG_SND_SOC_CPCAP=3Dm
CONFIG_SND_SOC_CROS_EC_CODEC=3Dm
CONFIG_SND_SOC_CS35L32=3Dm
CONFIG_SND_SOC_CS35L33=3Dm
CONFIG_SND_SOC_CS35L34=3Dm
CONFIG_SND_SOC_CS35L35=3Dm
CONFIG_SND_SOC_CS35L36=3Dm
CONFIG_SND_SOC_CS42L42=3Dm
CONFIG_SND_SOC_CS42L51=3Dm
CONFIG_SND_SOC_CS42L51_I2C=3Dm
CONFIG_SND_SOC_CS42L52=3Dm
CONFIG_SND_SOC_CS42L56=3Dm
CONFIG_SND_SOC_CS42L73=3Dm
CONFIG_SND_SOC_CS4265=3Dm
CONFIG_SND_SOC_CS4270=3Dm
CONFIG_SND_SOC_CS4271=3Dm
CONFIG_SND_SOC_CS4271_I2C=3Dm
CONFIG_SND_SOC_CS4271_SPI=3Dm
CONFIG_SND_SOC_CS42XX8=3Dm
CONFIG_SND_SOC_CS42XX8_I2C=3Dm
CONFIG_SND_SOC_CS43130=3Dm
CONFIG_SND_SOC_CS4341=3Dm
CONFIG_SND_SOC_CS4349=3Dm
CONFIG_SND_SOC_CS53L30=3Dm
CONFIG_SND_SOC_CX2072X=3Dm
CONFIG_SND_SOC_DA7213=3Dm
CONFIG_SND_SOC_DA7219=3Dm
CONFIG_SND_SOC_DMIC=3Dm
CONFIG_SND_SOC_HDMI_CODEC=3Dm
CONFIG_SND_SOC_ES7134=3Dm
CONFIG_SND_SOC_ES7241=3Dm
CONFIG_SND_SOC_ES8316=3Dm
CONFIG_SND_SOC_ES8328=3Dm
CONFIG_SND_SOC_ES8328_I2C=3Dm
CONFIG_SND_SOC_ES8328_SPI=3Dm
CONFIG_SND_SOC_GTM601=3Dm
CONFIG_SND_SOC_HDAC_HDMI=3Dm
CONFIG_SND_SOC_HDAC_HDA=3Dm
CONFIG_SND_SOC_INNO_RK3036=3Dm
CONFIG_SND_SOC_LOCHNAGAR_SC=3Dm
CONFIG_SND_SOC_MAX98088=3Dm
CONFIG_SND_SOC_MAX98090=3Dm
CONFIG_SND_SOC_MAX98357A=3Dm
CONFIG_SND_SOC_MAX98504=3Dm
CONFIG_SND_SOC_MAX9867=3Dm
CONFIG_SND_SOC_MAX98927=3Dm
CONFIG_SND_SOC_MAX98373=3Dm
CONFIG_SND_SOC_MAX9860=3Dm
CONFIG_SND_SOC_MSM8916_WCD_ANALOG=3Dm
CONFIG_SND_SOC_MSM8916_WCD_DIGITAL=3Dm
CONFIG_SND_SOC_PCM1681=3Dm
CONFIG_SND_SOC_PCM1789=3Dm
CONFIG_SND_SOC_PCM1789_I2C=3Dm
CONFIG_SND_SOC_PCM179X=3Dm
CONFIG_SND_SOC_PCM179X_I2C=3Dm
CONFIG_SND_SOC_PCM179X_SPI=3Dm
CONFIG_SND_SOC_PCM186X=3Dm
CONFIG_SND_SOC_PCM186X_I2C=3Dm
CONFIG_SND_SOC_PCM186X_SPI=3Dm
CONFIG_SND_SOC_PCM3060=3Dm
CONFIG_SND_SOC_PCM3060_I2C=3Dm
CONFIG_SND_SOC_PCM3060_SPI=3Dm
CONFIG_SND_SOC_PCM3168A=3Dm
CONFIG_SND_SOC_PCM3168A_I2C=3Dm
CONFIG_SND_SOC_PCM3168A_SPI=3Dm
CONFIG_SND_SOC_PCM512x=3Dm
CONFIG_SND_SOC_PCM512x_I2C=3Dm
CONFIG_SND_SOC_PCM512x_SPI=3Dm
CONFIG_SND_SOC_RK3328=3Dm
CONFIG_SND_SOC_RL6231=3Dm
CONFIG_SND_SOC_RL6347A=3Dm
CONFIG_SND_SOC_RT286=3Dm
CONFIG_SND_SOC_RT298=3Dm
CONFIG_SND_SOC_RT1011=3Dm
CONFIG_SND_SOC_RT1308_SDW=3Dm
CONFIG_SND_SOC_RT5514=3Dm
CONFIG_SND_SOC_RT5514_SPI=3Dm
CONFIG_SND_SOC_RT5616=3Dm
CONFIG_SND_SOC_RT5631=3Dm
CONFIG_SND_SOC_RT5640=3Dm
CONFIG_SND_SOC_RT5645=3Dm
CONFIG_SND_SOC_RT5651=3Dm
CONFIG_SND_SOC_RT5660=3Dm
CONFIG_SND_SOC_RT5663=3Dm
CONFIG_SND_SOC_RT5670=3Dm
CONFIG_SND_SOC_RT5677=3Dm
CONFIG_SND_SOC_RT5677_SPI=3Dm
CONFIG_SND_SOC_RT5682=3Dm
CONFIG_SND_SOC_RT700=3Dm
CONFIG_SND_SOC_RT700_SDW=3Dm
CONFIG_SND_SOC_RT711=3Dm
CONFIG_SND_SOC_RT711_SDW=3Dm
CONFIG_SND_SOC_RT715=3Dm
CONFIG_SND_SOC_RT715_SDW=3Dm
CONFIG_SND_SOC_SGTL5000=3Dm
CONFIG_SND_SOC_SI476X=3Dm
CONFIG_SND_SOC_SIGMADSP=3Dm
CONFIG_SND_SOC_SIGMADSP_I2C=3Dm
CONFIG_SND_SOC_SIGMADSP_REGMAP=3Dm
CONFIG_SND_SOC_SIMPLE_AMPLIFIER=3Dm
CONFIG_SND_SOC_SIRF_AUDIO_CODEC=3Dm
CONFIG_SND_SOC_SPDIF=3Dm
CONFIG_SND_SOC_SSM2305=3Dm
CONFIG_SND_SOC_SSM2602=3Dm
CONFIG_SND_SOC_SSM2602_SPI=3Dm
CONFIG_SND_SOC_SSM2602_I2C=3Dm
CONFIG_SND_SOC_SSM4567=3Dm
CONFIG_SND_SOC_STA32X=3Dm
CONFIG_SND_SOC_STA350=3Dm
CONFIG_SND_SOC_STI_SAS=3Dm
CONFIG_SND_SOC_TAS2552=3Dm
CONFIG_SND_SOC_TAS2562=3Dm
CONFIG_SND_SOC_TAS2770=3Dm
CONFIG_SND_SOC_TAS5086=3Dm
CONFIG_SND_SOC_TAS571X=3Dm
CONFIG_SND_SOC_TAS5720=3Dm
CONFIG_SND_SOC_TAS6424=3Dm
CONFIG_SND_SOC_TDA7419=3Dm
CONFIG_SND_SOC_TFA9879=3Dm
CONFIG_SND_SOC_TLV320AIC23=3Dm
CONFIG_SND_SOC_TLV320AIC23_I2C=3Dm
CONFIG_SND_SOC_TLV320AIC23_SPI=3Dm
CONFIG_SND_SOC_TLV320AIC31XX=3Dm
CONFIG_SND_SOC_TLV320AIC32X4=3Dm
CONFIG_SND_SOC_TLV320AIC32X4_I2C=3Dm
CONFIG_SND_SOC_TLV320AIC32X4_SPI=3Dm
CONFIG_SND_SOC_TLV320AIC3X=3Dm
CONFIG_SND_SOC_TS3A227E=3Dm
CONFIG_SND_SOC_TSCS42XX=3Dm
CONFIG_SND_SOC_TSCS454=3Dm
CONFIG_SND_SOC_UDA1334=3Dm
CONFIG_SND_SOC_WCD9335=3Dm
CONFIG_SND_SOC_WCD934X=3Dm
CONFIG_SND_SOC_WM8510=3Dm
CONFIG_SND_SOC_WM8523=3Dm
CONFIG_SND_SOC_WM8524=3Dm
CONFIG_SND_SOC_WM8580=3Dm
CONFIG_SND_SOC_WM8711=3Dm
CONFIG_SND_SOC_WM8728=3Dm
CONFIG_SND_SOC_WM8731=3Dm
CONFIG_SND_SOC_WM8737=3Dm
CONFIG_SND_SOC_WM8741=3Dm
CONFIG_SND_SOC_WM8750=3Dm
CONFIG_SND_SOC_WM8753=3Dm
CONFIG_SND_SOC_WM8770=3Dm
CONFIG_SND_SOC_WM8776=3Dm
CONFIG_SND_SOC_WM8782=3Dm
CONFIG_SND_SOC_WM8804=3Dm
CONFIG_SND_SOC_WM8804_I2C=3Dm
CONFIG_SND_SOC_WM8804_SPI=3Dm
CONFIG_SND_SOC_WM8903=3Dm
CONFIG_SND_SOC_WM8904=3Dm
CONFIG_SND_SOC_WM8960=3Dm
CONFIG_SND_SOC_WM8962=3Dm
CONFIG_SND_SOC_WM8974=3Dm
CONFIG_SND_SOC_WM8978=3Dm
CONFIG_SND_SOC_WM8985=3Dm
CONFIG_SND_SOC_WSA881X=3Dm
CONFIG_SND_SOC_ZX_AUD96P22=3Dm
CONFIG_SND_SOC_MAX9759=3Dm
CONFIG_SND_SOC_MT6351=3Dm
CONFIG_SND_SOC_MT6358=3Dm
CONFIG_SND_SOC_MT6660=3Dm
CONFIG_SND_SOC_NAU8540=3Dm
CONFIG_SND_SOC_NAU8810=3Dm
CONFIG_SND_SOC_NAU8822=3Dm
CONFIG_SND_SOC_NAU8824=3Dm
CONFIG_SND_SOC_NAU8825=3Dm
CONFIG_SND_SOC_TPA6130A2=3Dm
# end of CODEC drivers

CONFIG_SND_SIMPLE_CARD_UTILS=3Dm
CONFIG_SND_SIMPLE_CARD=3Dm
CONFIG_SND_AUDIO_GRAPH_CARD=3Dm
CONFIG_SND_X86=3Dy
CONFIG_HDMI_LPE_AUDIO=3Dm
CONFIG_SND_SYNTH_EMUX=3Dm
CONFIG_SND_XEN_FRONTEND=3Dm
CONFIG_AC97_BUS=3Dm

#
# HID support
#
CONFIG_HID=3Dm
CONFIG_HID_BATTERY_STRENGTH=3Dy
CONFIG_HIDRAW=3Dy
CONFIG_UHID=3Dm
CONFIG_HID_GENERIC=3Dm

#
# Special HID drivers
#
CONFIG_HID_A4TECH=3Dm
CONFIG_HID_ACCUTOUCH=3Dm
CONFIG_HID_ACRUX=3Dm
CONFIG_HID_ACRUX_FF=3Dy
CONFIG_HID_APPLE=3Dm
CONFIG_HID_APPLEIR=3Dm
CONFIG_HID_ASUS=3Dm
CONFIG_HID_AUREAL=3Dm
CONFIG_HID_BELKIN=3Dm
CONFIG_HID_BETOP_FF=3Dm
CONFIG_HID_BIGBEN_FF=3Dm
CONFIG_HID_CHERRY=3Dm
CONFIG_HID_CHICONY=3Dm
CONFIG_HID_CORSAIR=3Dm
CONFIG_HID_COUGAR=3Dm
CONFIG_HID_MACALLY=3Dm
CONFIG_HID_PRODIKEYS=3Dm
CONFIG_HID_CMEDIA=3Dm
CONFIG_HID_CP2112=3Dm
CONFIG_HID_CREATIVE_SB0540=3Dm
CONFIG_HID_CYPRESS=3Dm
CONFIG_HID_DRAGONRISE=3Dm
CONFIG_DRAGONRISE_FF=3Dy
CONFIG_HID_EMS_FF=3Dm
CONFIG_HID_ELAN=3Dm
CONFIG_HID_ELECOM=3Dm
CONFIG_HID_ELO=3Dm
CONFIG_HID_EZKEY=3Dm
CONFIG_HID_GEMBIRD=3Dm
CONFIG_HID_GFRM=3Dm
CONFIG_HID_HOLTEK=3Dm
CONFIG_HOLTEK_FF=3Dy
CONFIG_HID_GOOGLE_HAMMER=3Dm
CONFIG_HID_GT683R=3Dm
CONFIG_HID_KEYTOUCH=3Dm
CONFIG_HID_KYE=3Dm
CONFIG_HID_UCLOGIC=3Dm
CONFIG_HID_WALTOP=3Dm
CONFIG_HID_VIEWSONIC=3Dm
CONFIG_HID_GYRATION=3Dm
CONFIG_HID_ICADE=3Dm
CONFIG_HID_ITE=3Dm
CONFIG_HID_JABRA=3Dm
CONFIG_HID_TWINHAN=3Dm
CONFIG_HID_KENSINGTON=3Dm
CONFIG_HID_LCPOWER=3Dm
CONFIG_HID_LED=3Dm
CONFIG_HID_LENOVO=3Dm
CONFIG_HID_LOGITECH=3Dm
CONFIG_HID_LOGITECH_DJ=3Dm
CONFIG_HID_LOGITECH_HIDPP=3Dm
CONFIG_LOGITECH_FF=3Dy
CONFIG_LOGIRUMBLEPAD2_FF=3Dy
CONFIG_LOGIG940_FF=3Dy
CONFIG_LOGIWHEELS_FF=3Dy
CONFIG_HID_MAGICMOUSE=3Dm
CONFIG_HID_MALTRON=3Dm
CONFIG_HID_MAYFLASH=3Dm
CONFIG_HID_REDRAGON=3Dm
CONFIG_HID_MICROSOFT=3Dm
CONFIG_HID_MONTEREY=3Dm
CONFIG_HID_MULTITOUCH=3Dm
CONFIG_HID_NTI=3Dm
CONFIG_HID_NTRIG=3Dm
CONFIG_HID_ORTEK=3Dm
CONFIG_HID_PANTHERLORD=3Dm
CONFIG_PANTHERLORD_FF=3Dy
CONFIG_HID_PENMOUNT=3Dm
CONFIG_HID_PETALYNX=3Dm
CONFIG_HID_PICOLCD=3Dm
CONFIG_HID_PICOLCD_FB=3Dy
CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
CONFIG_HID_PICOLCD_LCD=3Dy
CONFIG_HID_PICOLCD_LEDS=3Dy
CONFIG_HID_PICOLCD_CIR=3Dy
CONFIG_HID_PLANTRONICS=3Dm
CONFIG_HID_PRIMAX=3Dm
CONFIG_HID_RETRODE=3Dm
CONFIG_HID_ROCCAT=3Dm
CONFIG_HID_SAITEK=3Dm
CONFIG_HID_SAMSUNG=3Dm
CONFIG_HID_SONY=3Dm
CONFIG_SONY_FF=3Dy
CONFIG_HID_SPEEDLINK=3Dm
CONFIG_HID_STEAM=3Dm
CONFIG_HID_STEELSERIES=3Dm
CONFIG_HID_SUNPLUS=3Dm
CONFIG_HID_RMI=3Dm
CONFIG_HID_GREENASIA=3Dm
CONFIG_GREENASIA_FF=3Dy
CONFIG_HID_HYPERV_MOUSE=3Dm
CONFIG_HID_SMARTJOYPLUS=3Dm
CONFIG_SMARTJOYPLUS_FF=3Dy
CONFIG_HID_TIVO=3Dm
CONFIG_HID_TOPSEED=3Dm
CONFIG_HID_THINGM=3Dm
CONFIG_HID_THRUSTMASTER=3Dm
CONFIG_THRUSTMASTER_FF=3Dy
CONFIG_HID_UDRAW_PS3=3Dm
CONFIG_HID_U2FZERO=3Dm
CONFIG_HID_WACOM=3Dm
CONFIG_HID_WIIMOTE=3Dm
CONFIG_HID_XINMO=3Dm
CONFIG_HID_ZEROPLUS=3Dm
CONFIG_ZEROPLUS_FF=3Dy
CONFIG_HID_ZYDACRON=3Dm
CONFIG_HID_SENSOR_HUB=3Dm
# CONFIG_HID_SENSOR_CUSTOM_SENSOR is not set
CONFIG_HID_ALPS=3Dm
# end of Special HID drivers

#
# USB HID support
#
CONFIG_USB_HID=3Dm
CONFIG_HID_PID=3Dy
CONFIG_USB_HIDDEV=3Dy

#
# USB HID Boot Protocol drivers
#
# CONFIG_USB_KBD is not set
# CONFIG_USB_MOUSE is not set
# end of USB HID Boot Protocol drivers
# end of USB HID support

#
# I2C HID support
#
CONFIG_I2C_HID=3Dm
# end of I2C HID support

#
# Intel ISH HID support
#
CONFIG_INTEL_ISH_HID=3Dm
CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=3Dm
# end of Intel ISH HID support
# end of HID support

CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
CONFIG_USB_SUPPORT=3Dy
CONFIG_USB_COMMON=3Dy
CONFIG_USB_LED_TRIG=3Dy
CONFIG_USB_ULPI_BUS=3Dm
CONFIG_USB_CONN_GPIO=3Dm
CONFIG_USB_ARCH_HAS_HCD=3Dy
CONFIG_USB=3Dy
CONFIG_USB_PCI=3Dy
CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=3Dy
CONFIG_USB_DYNAMIC_MINORS=3Dy
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_BLACKLIST_HUB is not set
CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dm
CONFIG_USB_AUTOSUSPEND_DELAY=3D2
CONFIG_USB_MON=3Dm

#
# USB Host Controller Drivers
#
CONFIG_USB_C67X00_HCD=3Dm
CONFIG_USB_XHCI_HCD=3Dm
# CONFIG_USB_XHCI_DBGCAP is not set
CONFIG_USB_XHCI_PCI=3Dm
CONFIG_USB_XHCI_PLATFORM=3Dm
CONFIG_USB_EHCI_HCD=3Dm
CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
CONFIG_USB_EHCI_PCI=3Dm
CONFIG_USB_EHCI_FSL=3Dm
CONFIG_USB_EHCI_HCD_PLATFORM=3Dm
CONFIG_USB_OXU210HP_HCD=3Dm
CONFIG_USB_ISP116X_HCD=3Dm
CONFIG_USB_FOTG210_HCD=3Dm
CONFIG_USB_MAX3421_HCD=3Dm
CONFIG_USB_OHCI_HCD=3Dm
CONFIG_USB_OHCI_HCD_PCI=3Dm
# CONFIG_USB_OHCI_HCD_SSB is not set
CONFIG_USB_OHCI_HCD_PLATFORM=3Dm
CONFIG_USB_UHCI_HCD=3Dm
CONFIG_USB_U132_HCD=3Dm
CONFIG_USB_SL811_HCD=3Dm
# CONFIG_USB_SL811_HCD_ISO is not set
CONFIG_USB_SL811_CS=3Dm
CONFIG_USB_R8A66597_HCD=3Dm
CONFIG_USB_HCD_BCMA=3Dm
CONFIG_USB_HCD_SSB=3Dm
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
CONFIG_USB_ACM=3Dm
CONFIG_USB_PRINTER=3Dm
CONFIG_USB_WDM=3Dm
CONFIG_USB_TMC=3Dm

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=3Dm
# CONFIG_USB_STORAGE_DEBUG is not set
CONFIG_USB_STORAGE_REALTEK=3Dm
CONFIG_REALTEK_AUTOPM=3Dy
CONFIG_USB_STORAGE_DATAFAB=3Dm
CONFIG_USB_STORAGE_FREECOM=3Dm
CONFIG_USB_STORAGE_ISD200=3Dm
CONFIG_USB_STORAGE_USBAT=3Dm
CONFIG_USB_STORAGE_SDDR09=3Dm
CONFIG_USB_STORAGE_SDDR55=3Dm
CONFIG_USB_STORAGE_JUMPSHOT=3Dm
CONFIG_USB_STORAGE_ALAUDA=3Dm
CONFIG_USB_STORAGE_ONETOUCH=3Dm
CONFIG_USB_STORAGE_KARMA=3Dm
CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dm
CONFIG_USB_STORAGE_ENE_UB6250=3Dm
CONFIG_USB_UAS=3Dm

#
# USB Imaging devices
#
CONFIG_USB_MDC800=3Dm
CONFIG_USB_MICROTEK=3Dm
CONFIG_USBIP_CORE=3Dm
CONFIG_USBIP_VHCI_HCD=3Dm
CONFIG_USBIP_VHCI_HC_PORTS=3D8
CONFIG_USBIP_VHCI_NR_HCS=3D1
CONFIG_USBIP_HOST=3Dm
CONFIG_USBIP_VUDC=3Dm
# CONFIG_USBIP_DEBUG is not set
CONFIG_USB_CDNS3=3Dm
CONFIG_USB_CDNS3_GADGET=3Dy
CONFIG_USB_CDNS3_HOST=3Dy
CONFIG_USB_CDNS3_PCI_WRAP=3Dm
CONFIG_USB_MUSB_HDRC=3Dm
# CONFIG_USB_MUSB_HOST is not set
# CONFIG_USB_MUSB_GADGET is not set
CONFIG_USB_MUSB_DUAL_ROLE=3Dy

#
# Platform Glue Layer
#

#
# MUSB DMA mode
#
# CONFIG_MUSB_PIO_ONLY is not set
CONFIG_USB_DWC3=3Dm
CONFIG_USB_DWC3_ULPI=3Dy
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=3Dy

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_PCI=3Dm
CONFIG_USB_DWC3_HAPS=3Dm
CONFIG_USB_DWC3_OF_SIMPLE=3Dm
CONFIG_USB_DWC2=3Dm
# CONFIG_USB_DWC2_HOST is not set

#
# Gadget/Dual-role mode requires USB Gadget support to be enabled
#
# CONFIG_USB_DWC2_PERIPHERAL is not set
CONFIG_USB_DWC2_DUAL_ROLE=3Dy
CONFIG_USB_DWC2_PCI=3Dm
# CONFIG_USB_DWC2_DEBUG is not set
# CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
CONFIG_USB_CHIPIDEA=3Dm
CONFIG_USB_CHIPIDEA_OF=3Dm
CONFIG_USB_CHIPIDEA_PCI=3Dm
CONFIG_USB_CHIPIDEA_UDC=3Dy
CONFIG_USB_CHIPIDEA_HOST=3Dy
CONFIG_USB_ISP1760=3Dm
CONFIG_USB_ISP1760_HCD=3Dy
CONFIG_USB_ISP1761_UDC=3Dy
# CONFIG_USB_ISP1760_HOST_ROLE is not set
# CONFIG_USB_ISP1760_GADGET_ROLE is not set
CONFIG_USB_ISP1760_DUAL_ROLE=3Dy

#
# USB port drivers
#
CONFIG_USB_USS720=3Dm
CONFIG_USB_SERIAL=3Dy
CONFIG_USB_SERIAL_CONSOLE=3Dy
CONFIG_USB_SERIAL_GENERIC=3Dy
CONFIG_USB_SERIAL_SIMPLE=3Dm
CONFIG_USB_SERIAL_AIRCABLE=3Dm
CONFIG_USB_SERIAL_ARK3116=3Dm
CONFIG_USB_SERIAL_BELKIN=3Dm
CONFIG_USB_SERIAL_CH341=3Dm
CONFIG_USB_SERIAL_WHITEHEAT=3Dm
CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dm
CONFIG_USB_SERIAL_CP210X=3Dm
CONFIG_USB_SERIAL_CYPRESS_M8=3Dm
CONFIG_USB_SERIAL_EMPEG=3Dm
CONFIG_USB_SERIAL_FTDI_SIO=3Dm
CONFIG_USB_SERIAL_VISOR=3Dm
CONFIG_USB_SERIAL_IPAQ=3Dm
CONFIG_USB_SERIAL_IR=3Dm
CONFIG_USB_SERIAL_EDGEPORT=3Dm
CONFIG_USB_SERIAL_EDGEPORT_TI=3Dm
CONFIG_USB_SERIAL_F81232=3Dm
CONFIG_USB_SERIAL_F8153X=3Dm
CONFIG_USB_SERIAL_GARMIN=3Dm
CONFIG_USB_SERIAL_IPW=3Dm
CONFIG_USB_SERIAL_IUU=3Dm
CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dm
CONFIG_USB_SERIAL_KEYSPAN=3Dm
CONFIG_USB_SERIAL_KLSI=3Dm
CONFIG_USB_SERIAL_KOBIL_SCT=3Dm
CONFIG_USB_SERIAL_MCT_U232=3Dm
CONFIG_USB_SERIAL_METRO=3Dm
CONFIG_USB_SERIAL_MOS7720=3Dm
CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
CONFIG_USB_SERIAL_MOS7840=3Dm
CONFIG_USB_SERIAL_MXUPORT=3Dm
CONFIG_USB_SERIAL_NAVMAN=3Dm
CONFIG_USB_SERIAL_PL2303=3Dm
CONFIG_USB_SERIAL_OTI6858=3Dm
CONFIG_USB_SERIAL_QCAUX=3Dm
CONFIG_USB_SERIAL_QUALCOMM=3Dm
CONFIG_USB_SERIAL_SPCP8X5=3Dm
CONFIG_USB_SERIAL_SAFE=3Dm
# CONFIG_USB_SERIAL_SAFE_PADDED is not set
CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dm
CONFIG_USB_SERIAL_SYMBOL=3Dm
CONFIG_USB_SERIAL_TI=3Dm
CONFIG_USB_SERIAL_CYBERJACK=3Dm
CONFIG_USB_SERIAL_XIRCOM=3Dm
CONFIG_USB_SERIAL_WWAN=3Dm
CONFIG_USB_SERIAL_OPTION=3Dm
CONFIG_USB_SERIAL_OMNINET=3Dm
CONFIG_USB_SERIAL_OPTICON=3Dm
CONFIG_USB_SERIAL_XSENS_MT=3Dm
CONFIG_USB_SERIAL_WISHBONE=3Dm
CONFIG_USB_SERIAL_SSU100=3Dm
CONFIG_USB_SERIAL_QT2=3Dm
CONFIG_USB_SERIAL_UPD78F0730=3Dm
CONFIG_USB_SERIAL_DEBUG=3Dm

#
# USB Miscellaneous drivers
#
CONFIG_USB_EMI62=3Dm
CONFIG_USB_EMI26=3Dm
CONFIG_USB_ADUTUX=3Dm
CONFIG_USB_SEVSEG=3Dm
CONFIG_USB_LEGOTOWER=3Dm
CONFIG_USB_LCD=3Dm
CONFIG_USB_CYPRESS_CY7C63=3Dm
CONFIG_USB_CYTHERM=3Dm
CONFIG_USB_IDMOUSE=3Dm
CONFIG_USB_FTDI_ELAN=3Dm
CONFIG_USB_APPLEDISPLAY=3Dm
CONFIG_USB_SISUSBVGA=3Dm
CONFIG_USB_SISUSBVGA_CON=3Dy
CONFIG_USB_LD=3Dm
CONFIG_USB_TRANCEVIBRATOR=3Dm
CONFIG_USB_IOWARRIOR=3Dm
CONFIG_USB_TEST=3Dm
CONFIG_USB_EHSET_TEST_FIXTURE=3Dm
CONFIG_USB_ISIGHTFW=3Dm
CONFIG_USB_YUREX=3Dm
CONFIG_USB_EZUSB_FX2=3Dm
CONFIG_USB_HUB_USB251XB=3Dm
CONFIG_USB_HSIC_USB3503=3Dm
CONFIG_USB_HSIC_USB4604=3Dm
CONFIG_USB_LINK_LAYER_TEST=3Dm
CONFIG_USB_CHAOSKEY=3Dm
CONFIG_USB_ATM=3Dm
CONFIG_USB_SPEEDTOUCH=3Dm
CONFIG_USB_CXACRU=3Dm
CONFIG_USB_UEAGLEATM=3Dm
CONFIG_USB_XUSBATM=3Dm

#
# USB Physical Layer drivers
#
CONFIG_USB_PHY=3Dy
CONFIG_NOP_USB_XCEIV=3Dm
CONFIG_USB_GPIO_VBUS=3Dm
CONFIG_TAHVO_USB=3Dm
# CONFIG_TAHVO_USB_HOST_BY_DEFAULT is not set
CONFIG_USB_ISP1301=3Dm
# end of USB Physical Layer drivers

CONFIG_USB_GADGET=3Dm
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=3D2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2
CONFIG_U_SERIAL_CONSOLE=3Dy

#
# USB Peripheral Controller
#
CONFIG_USB_FOTG210_UDC=3Dm
CONFIG_USB_GR_UDC=3Dm
CONFIG_USB_R8A66597=3Dm
CONFIG_USB_PXA27X=3Dm
CONFIG_USB_MV_UDC=3Dm
CONFIG_USB_MV_U3D=3Dm
CONFIG_USB_SNP_CORE=3Dm
CONFIG_USB_SNP_UDC_PLAT=3Dm
CONFIG_USB_M66592=3Dm
CONFIG_USB_BDC_UDC=3Dm

#
# Platform Support
#
CONFIG_USB_BDC_PCI=3Dm
CONFIG_USB_AMD5536UDC=3Dm
CONFIG_USB_NET2272=3Dm
CONFIG_USB_NET2272_DMA=3Dy
CONFIG_USB_NET2280=3Dm
CONFIG_USB_GOKU=3Dm
CONFIG_USB_EG20T=3Dm
CONFIG_USB_GADGET_XILINX=3Dm
CONFIG_USB_DUMMY_HCD=3Dm
# end of USB Peripheral Controller

CONFIG_USB_LIBCOMPOSITE=3Dm
CONFIG_USB_F_ACM=3Dm
CONFIG_USB_F_SS_LB=3Dm
CONFIG_USB_U_SERIAL=3Dm
CONFIG_USB_U_ETHER=3Dm
CONFIG_USB_U_AUDIO=3Dm
CONFIG_USB_F_SERIAL=3Dm
CONFIG_USB_F_OBEX=3Dm
CONFIG_USB_F_NCM=3Dm
CONFIG_USB_F_ECM=3Dm
CONFIG_USB_F_PHONET=3Dm
CONFIG_USB_F_EEM=3Dm
CONFIG_USB_F_SUBSET=3Dm
CONFIG_USB_F_RNDIS=3Dm
CONFIG_USB_F_MASS_STORAGE=3Dm
CONFIG_USB_F_FS=3Dm
CONFIG_USB_F_UAC1=3Dm
CONFIG_USB_F_UAC1_LEGACY=3Dm
CONFIG_USB_F_UAC2=3Dm
CONFIG_USB_F_UVC=3Dm
CONFIG_USB_F_MIDI=3Dm
CONFIG_USB_F_HID=3Dm
CONFIG_USB_F_PRINTER=3Dm
CONFIG_USB_F_TCM=3Dm
CONFIG_USB_CONFIGFS=3Dm
CONFIG_USB_CONFIGFS_SERIAL=3Dy
CONFIG_USB_CONFIGFS_ACM=3Dy
CONFIG_USB_CONFIGFS_OBEX=3Dy
CONFIG_USB_CONFIGFS_NCM=3Dy
CONFIG_USB_CONFIGFS_ECM=3Dy
CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy
CONFIG_USB_CONFIGFS_RNDIS=3Dy
CONFIG_USB_CONFIGFS_EEM=3Dy
CONFIG_USB_CONFIGFS_PHONET=3Dy
CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
CONFIG_USB_CONFIGFS_F_LB_SS=3Dy
CONFIG_USB_CONFIGFS_F_FS=3Dy
CONFIG_USB_CONFIGFS_F_UAC1=3Dy
CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=3Dy
CONFIG_USB_CONFIGFS_F_UAC2=3Dy
CONFIG_USB_CONFIGFS_F_MIDI=3Dy
CONFIG_USB_CONFIGFS_F_HID=3Dy
CONFIG_USB_CONFIGFS_F_UVC=3Dy
CONFIG_USB_CONFIGFS_F_PRINTER=3Dy
CONFIG_USB_CONFIGFS_F_TCM=3Dy
CONFIG_USB_ZERO=3Dm
CONFIG_USB_AUDIO=3Dm
# CONFIG_GADGET_UAC1 is not set
CONFIG_USB_ETH=3Dm
CONFIG_USB_ETH_RNDIS=3Dy
CONFIG_USB_ETH_EEM=3Dy
CONFIG_USB_G_NCM=3Dm
CONFIG_USB_GADGETFS=3Dm
CONFIG_USB_FUNCTIONFS=3Dm
CONFIG_USB_FUNCTIONFS_ETH=3Dy
CONFIG_USB_FUNCTIONFS_RNDIS=3Dy
CONFIG_USB_FUNCTIONFS_GENERIC=3Dy
CONFIG_USB_MASS_STORAGE=3Dm
CONFIG_USB_GADGET_TARGET=3Dm
CONFIG_USB_G_SERIAL=3Dm
CONFIG_USB_MIDI_GADGET=3Dm
CONFIG_USB_G_PRINTER=3Dm
CONFIG_USB_CDC_COMPOSITE=3Dm
CONFIG_USB_G_NOKIA=3Dm
CONFIG_USB_G_ACM_MS=3Dm
CONFIG_USB_G_MULTI=3Dm
CONFIG_USB_G_MULTI_RNDIS=3Dy
CONFIG_USB_G_MULTI_CDC=3Dy
CONFIG_USB_G_HID=3Dm
CONFIG_USB_G_DBGP=3Dm
# CONFIG_USB_G_DBGP_PRINTK is not set
CONFIG_USB_G_DBGP_SERIAL=3Dy
CONFIG_USB_G_WEBCAM=3Dm
CONFIG_TYPEC=3Dm
CONFIG_TYPEC_TCPM=3Dm
CONFIG_TYPEC_TCPCI=3Dm
CONFIG_TYPEC_RT1711H=3Dm
CONFIG_TYPEC_FUSB302=3Dm
CONFIG_TYPEC_WCOVE=3Dm
CONFIG_TYPEC_UCSI=3Dm
CONFIG_UCSI_CCG=3Dm
CONFIG_UCSI_ACPI=3Dm
CONFIG_TYPEC_HD3SS3220=3Dm
CONFIG_TYPEC_TPS6598X=3Dm

#
# USB Type-C Multiplexer/DeMultiplexer Switch support
#
CONFIG_TYPEC_MUX_PI3USB30532=3Dm
# end of USB Type-C Multiplexer/DeMultiplexer Switch support

#
# USB Type-C Alternate Mode drivers
#
CONFIG_TYPEC_DP_ALTMODE=3Dm
CONFIG_TYPEC_NVIDIA_ALTMODE=3Dm
# end of USB Type-C Alternate Mode drivers

CONFIG_USB_ROLE_SWITCH=3Dm
CONFIG_USB_ROLES_INTEL_XHCI=3Dm
CONFIG_MMC=3Dm
CONFIG_PWRSEQ_EMMC=3Dm
CONFIG_PWRSEQ_SD8787=3Dm
CONFIG_PWRSEQ_SIMPLE=3Dm
CONFIG_MMC_BLOCK=3Dm
CONFIG_MMC_BLOCK_MINORS=3D8
CONFIG_SDIO_UART=3Dm
CONFIG_MMC_TEST=3Dm

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_DEBUG is not set
CONFIG_MMC_SDHCI=3Dm
CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
CONFIG_MMC_SDHCI_PCI=3Dm
CONFIG_MMC_RICOH_MMC=3Dy
CONFIG_MMC_SDHCI_ACPI=3Dm
CONFIG_MMC_SDHCI_PLTFM=3Dm
CONFIG_MMC_SDHCI_OF_ARASAN=3Dm
CONFIG_MMC_SDHCI_OF_ASPEED=3Dm
CONFIG_MMC_SDHCI_OF_AT91=3Dm
CONFIG_MMC_SDHCI_OF_DWCMSHC=3Dm
CONFIG_MMC_SDHCI_CADENCE=3Dm
CONFIG_MMC_SDHCI_F_SDH30=3Dm
CONFIG_MMC_SDHCI_MILBEAUT=3Dm
CONFIG_MMC_WBSD=3Dm
CONFIG_MMC_ALCOR=3Dm
CONFIG_MMC_TIFM_SD=3Dm
CONFIG_MMC_SPI=3Dm
CONFIG_MMC_SDRICOH_CS=3Dm
CONFIG_MMC_CB710=3Dm
CONFIG_MMC_VIA_SDMMC=3Dm
CONFIG_MMC_VUB300=3Dm
CONFIG_MMC_USHC=3Dm
CONFIG_MMC_USDHI6ROL0=3Dm
CONFIG_MMC_REALTEK_PCI=3Dm
CONFIG_MMC_REALTEK_USB=3Dm
CONFIG_MMC_CQHCI=3Dm
CONFIG_MMC_TOSHIBA_PCI=3Dm
CONFIG_MMC_MTK=3Dm
CONFIG_MMC_SDHCI_XENON=3Dm
CONFIG_MMC_SDHCI_OMAP=3Dm
CONFIG_MMC_SDHCI_AM654=3Dm
CONFIG_MMC_SDHCI_EXTERNAL_DMA=3Dy
CONFIG_MEMSTICK=3Dm
# CONFIG_MEMSTICK_DEBUG is not set

#
# MemoryStick drivers
#
# CONFIG_MEMSTICK_UNSAFE_RESUME is not set
CONFIG_MSPRO_BLOCK=3Dm
CONFIG_MS_BLOCK=3Dm

#
# MemoryStick Host Controller Drivers
#
CONFIG_MEMSTICK_TIFM_MS=3Dm
CONFIG_MEMSTICK_JMICRON_38X=3Dm
CONFIG_MEMSTICK_R592=3Dm
CONFIG_MEMSTICK_REALTEK_PCI=3Dm
CONFIG_MEMSTICK_REALTEK_USB=3Dm
CONFIG_NEW_LEDS=3Dy
CONFIG_LEDS_CLASS=3Dy
CONFIG_LEDS_CLASS_FLASH=3Dm
CONFIG_LEDS_BRIGHTNESS_HW_CHANGED=3Dy

#
# LED drivers
#
CONFIG_LEDS_88PM860X=3Dm
CONFIG_LEDS_AAT1290=3Dm
CONFIG_LEDS_AN30259A=3Dm
CONFIG_LEDS_APU=3Dm
CONFIG_LEDS_AS3645A=3Dm
CONFIG_LEDS_BCM6328=3Dm
CONFIG_LEDS_BCM6358=3Dm
CONFIG_LEDS_CPCAP=3Dm
CONFIG_LEDS_CR0014114=3Dm
CONFIG_LEDS_EL15203000=3Dm
CONFIG_LEDS_LM3530=3Dm
CONFIG_LEDS_LM3532=3Dm
CONFIG_LEDS_LM3533=3Dm
CONFIG_LEDS_LM3642=3Dm
CONFIG_LEDS_LM3692X=3Dm
CONFIG_LEDS_LM3601X=3Dm
CONFIG_LEDS_MT6323=3Dm
CONFIG_LEDS_PCA9532=3Dm
CONFIG_LEDS_PCA9532_GPIO=3Dy
CONFIG_LEDS_GPIO=3Dm
CONFIG_LEDS_LP3944=3Dm
CONFIG_LEDS_LP3952=3Dm
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
CONFIG_LEDS_LP8788=3Dm
CONFIG_LEDS_LP8860=3Dm
CONFIG_LEDS_CLEVO_MAIL=3Dm
CONFIG_LEDS_PCA955X=3Dm
CONFIG_LEDS_PCA955X_GPIO=3Dy
CONFIG_LEDS_PCA963X=3Dm
CONFIG_LEDS_WM831X_STATUS=3Dm
CONFIG_LEDS_WM8350=3Dm
CONFIG_LEDS_DA903X=3Dm
CONFIG_LEDS_DA9052=3Dm
CONFIG_LEDS_DAC124S085=3Dm
CONFIG_LEDS_PWM=3Dm
CONFIG_LEDS_REGULATOR=3Dm
CONFIG_LEDS_BD2802=3Dm
CONFIG_LEDS_INTEL_SS4200=3Dm
CONFIG_LEDS_LT3593=3Dm
CONFIG_LEDS_ADP5520=3Dm
CONFIG_LEDS_MC13783=3Dm
CONFIG_LEDS_TCA6507=3Dm
CONFIG_LEDS_TLC591XX=3Dm
CONFIG_LEDS_MAX77650=3Dm
CONFIG_LEDS_MAX77693=3Dm
CONFIG_LEDS_MAX8997=3Dm
CONFIG_LEDS_LM355x=3Dm
CONFIG_LEDS_MENF21BMC=3Dm
CONFIG_LEDS_KTD2692=3Dm
CONFIG_LEDS_IS31FL319X=3Dm
CONFIG_LEDS_IS31FL32XX=3Dm

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THI=
NGM)
#
CONFIG_LEDS_BLINKM=3Dm
CONFIG_LEDS_SYSCON=3Dy
CONFIG_LEDS_MLXCPLD=3Dm
CONFIG_LEDS_MLXREG=3Dm
CONFIG_LEDS_USER=3Dm
CONFIG_LEDS_NIC78BX=3Dm
CONFIG_LEDS_SPI_BYTE=3Dm
CONFIG_LEDS_TI_LMU_COMMON=3Dm
CONFIG_LEDS_LM3697=3Dm
CONFIG_LEDS_LM36274=3Dm
CONFIG_LEDS_TPS6105X=3Dm

#
# LED Triggers
#
CONFIG_LEDS_TRIGGERS=3Dy
CONFIG_LEDS_TRIGGER_TIMER=3Dm
CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
CONFIG_LEDS_TRIGGER_DISK=3Dy
CONFIG_LEDS_TRIGGER_MTD=3Dy
CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
CONFIG_LEDS_TRIGGER_CPU=3Dy
CONFIG_LEDS_TRIGGER_ACTIVITY=3Dm
CONFIG_LEDS_TRIGGER_GPIO=3Dm
CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm

#
# iptables trigger is under Netfilter config (LED target)
#
CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
CONFIG_LEDS_TRIGGER_CAMERA=3Dm
CONFIG_LEDS_TRIGGER_PANIC=3Dy
CONFIG_LEDS_TRIGGER_NETDEV=3Dm
CONFIG_LEDS_TRIGGER_PATTERN=3Dm
CONFIG_LEDS_TRIGGER_AUDIO=3Dm
CONFIG_ACCESSIBILITY=3Dy
CONFIG_A11Y_BRAILLE_CONSOLE=3Dy
CONFIG_INFINIBAND=3Dm
CONFIG_INFINIBAND_USER_MAD=3Dm
CONFIG_INFINIBAND_USER_ACCESS=3Dm
# CONFIG_INFINIBAND_EXP_LEGACY_VERBS_NEW_UAPI is not set
CONFIG_INFINIBAND_USER_MEM=3Dy
CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
CONFIG_INFINIBAND_ADDR_TRANS=3Dy
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
CONFIG_INFINIBAND_MTHCA=3Dm
CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
CONFIG_INFINIBAND_QIB=3Dm
CONFIG_INFINIBAND_QIB_DCA=3Dy
CONFIG_INFINIBAND_CXGB4=3Dm
CONFIG_INFINIBAND_EFA=3Dm
CONFIG_INFINIBAND_I40IW=3Dm
CONFIG_MLX4_INFINIBAND=3Dm
CONFIG_MLX5_INFINIBAND=3Dm
CONFIG_INFINIBAND_OCRDMA=3Dm
CONFIG_INFINIBAND_VMWARE_PVRDMA=3Dm
CONFIG_INFINIBAND_USNIC=3Dm
CONFIG_INFINIBAND_BNXT_RE=3Dm
CONFIG_INFINIBAND_HFI1=3Dm
# CONFIG_HFI1_DEBUG_SDMA_ORDER is not set
# CONFIG_SDMA_VERBOSITY is not set
CONFIG_INFINIBAND_QEDR=3Dm
CONFIG_INFINIBAND_RDMAVT=3Dm
CONFIG_RDMA_RXE=3Dm
CONFIG_RDMA_SIW=3Dm
CONFIG_INFINIBAND_IPOIB=3Dm
CONFIG_INFINIBAND_IPOIB_CM=3Dy
CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=3Dm
CONFIG_INFINIBAND_SRPT=3Dm
CONFIG_INFINIBAND_ISER=3Dm
CONFIG_INFINIBAND_ISERT=3Dm
CONFIG_INFINIBAND_OPA_VNIC=3Dm
CONFIG_EDAC_ATOMIC_SCRUB=3Dy
CONFIG_EDAC_SUPPORT=3Dy
CONFIG_EDAC=3Dy
CONFIG_EDAC_LEGACY_SYSFS=3Dy
# CONFIG_EDAC_DEBUG is not set
CONFIG_EDAC_DECODE_MCE=3Dm
CONFIG_EDAC_GHES=3Dy
CONFIG_EDAC_AMD64=3Dm
# CONFIG_EDAC_AMD64_ERROR_INJECTION is not set
CONFIG_EDAC_E752X=3Dm
CONFIG_EDAC_I82975X=3Dm
CONFIG_EDAC_I3000=3Dm
CONFIG_EDAC_I3200=3Dm
CONFIG_EDAC_IE31200=3Dm
CONFIG_EDAC_X38=3Dm
CONFIG_EDAC_I5400=3Dm
CONFIG_EDAC_I7CORE=3Dm
CONFIG_EDAC_I5000=3Dm
CONFIG_EDAC_I5100=3Dm
CONFIG_EDAC_I7300=3Dm
CONFIG_EDAC_SBRIDGE=3Dm
CONFIG_EDAC_SKX=3Dm
CONFIG_EDAC_I10NM=3Dm
CONFIG_EDAC_PND2=3Dm
CONFIG_RTC_LIB=3Dy
CONFIG_RTC_MC146818_LIB=3Dy
CONFIG_RTC_CLASS=3Dy
CONFIG_RTC_HCTOSYS=3Dy
CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
CONFIG_RTC_SYSTOHC=3Dy
CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
# CONFIG_RTC_DEBUG is not set
CONFIG_RTC_NVMEM=3Dy

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=3Dy
CONFIG_RTC_INTF_PROC=3Dy
CONFIG_RTC_INTF_DEV=3Dy
CONFIG_RTC_INTF_DEV_UIE_EMUL=3Dy
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
CONFIG_RTC_DRV_88PM860X=3Dm
CONFIG_RTC_DRV_88PM80X=3Dm
CONFIG_RTC_DRV_ABB5ZES3=3Dm
CONFIG_RTC_DRV_ABEOZ9=3Dm
CONFIG_RTC_DRV_ABX80X=3Dm
CONFIG_RTC_DRV_AS3722=3Dm
CONFIG_RTC_DRV_DS1307=3Dm
CONFIG_RTC_DRV_DS1307_CENTURY=3Dy
CONFIG_RTC_DRV_DS1374=3Dm
CONFIG_RTC_DRV_DS1374_WDT=3Dy
CONFIG_RTC_DRV_DS1672=3Dm
CONFIG_RTC_DRV_HYM8563=3Dm
CONFIG_RTC_DRV_LP8788=3Dm
CONFIG_RTC_DRV_MAX6900=3Dm
CONFIG_RTC_DRV_MAX8907=3Dm
CONFIG_RTC_DRV_MAX8925=3Dm
CONFIG_RTC_DRV_MAX8998=3Dm
CONFIG_RTC_DRV_MAX8997=3Dm
CONFIG_RTC_DRV_MAX77686=3Dm
CONFIG_RTC_DRV_RK808=3Dm
CONFIG_RTC_DRV_RS5C372=3Dm
CONFIG_RTC_DRV_ISL1208=3Dm
CONFIG_RTC_DRV_ISL12022=3Dm
CONFIG_RTC_DRV_ISL12026=3Dm
CONFIG_RTC_DRV_X1205=3Dm
CONFIG_RTC_DRV_PCF8523=3Dm
CONFIG_RTC_DRV_PCF85063=3Dm
CONFIG_RTC_DRV_PCF85363=3Dm
CONFIG_RTC_DRV_PCF8563=3Dm
CONFIG_RTC_DRV_PCF8583=3Dm
CONFIG_RTC_DRV_M41T80=3Dm
CONFIG_RTC_DRV_M41T80_WDT=3Dy
CONFIG_RTC_DRV_BD70528=3Dm
CONFIG_RTC_DRV_BQ32K=3Dm
CONFIG_RTC_DRV_TWL4030=3Dm
CONFIG_RTC_DRV_PALMAS=3Dm
CONFIG_RTC_DRV_TPS6586X=3Dm
CONFIG_RTC_DRV_TPS65910=3Dm
CONFIG_RTC_DRV_TPS80031=3Dm
CONFIG_RTC_DRV_RC5T583=3Dm
CONFIG_RTC_DRV_S35390A=3Dm
CONFIG_RTC_DRV_FM3130=3Dm
CONFIG_RTC_DRV_RX8010=3Dm
CONFIG_RTC_DRV_RX8581=3Dm
CONFIG_RTC_DRV_RX8025=3Dm
CONFIG_RTC_DRV_EM3027=3Dm
CONFIG_RTC_DRV_RV3028=3Dm
CONFIG_RTC_DRV_RV8803=3Dm
CONFIG_RTC_DRV_S5M=3Dm
CONFIG_RTC_DRV_SD3078=3Dm

#
# SPI RTC drivers
#
CONFIG_RTC_DRV_M41T93=3Dm
CONFIG_RTC_DRV_M41T94=3Dm
CONFIG_RTC_DRV_DS1302=3Dm
CONFIG_RTC_DRV_DS1305=3Dm
CONFIG_RTC_DRV_DS1343=3Dm
CONFIG_RTC_DRV_DS1347=3Dm
CONFIG_RTC_DRV_DS1390=3Dm
CONFIG_RTC_DRV_MAX6916=3Dm
CONFIG_RTC_DRV_R9701=3Dm
CONFIG_RTC_DRV_RX4581=3Dm
CONFIG_RTC_DRV_RX6110=3Dm
CONFIG_RTC_DRV_RS5C348=3Dm
CONFIG_RTC_DRV_MAX6902=3Dm
CONFIG_RTC_DRV_PCF2123=3Dm
CONFIG_RTC_DRV_MCP795=3Dm
CONFIG_RTC_I2C_AND_SPI=3Dy

#
# SPI and I2C RTC drivers
#
CONFIG_RTC_DRV_DS3232=3Dm
CONFIG_RTC_DRV_DS3232_HWMON=3Dy
CONFIG_RTC_DRV_PCF2127=3Dm
CONFIG_RTC_DRV_RV3029C2=3Dm
CONFIG_RTC_DRV_RV3029_HWMON=3Dy

#
# Platform RTC drivers
#
CONFIG_RTC_DRV_CMOS=3Dy
CONFIG_RTC_DRV_DS1286=3Dm
CONFIG_RTC_DRV_DS1511=3Dm
CONFIG_RTC_DRV_DS1553=3Dm
CONFIG_RTC_DRV_DS1685_FAMILY=3Dm
CONFIG_RTC_DRV_DS1685=3Dy
# CONFIG_RTC_DRV_DS1689 is not set
# CONFIG_RTC_DRV_DS17285 is not set
# CONFIG_RTC_DRV_DS17485 is not set
# CONFIG_RTC_DRV_DS17885 is not set
CONFIG_RTC_DRV_DS1742=3Dm
CONFIG_RTC_DRV_DS2404=3Dm
CONFIG_RTC_DRV_DA9052=3Dm
CONFIG_RTC_DRV_DA9055=3Dm
CONFIG_RTC_DRV_DA9063=3Dm
CONFIG_RTC_DRV_STK17TA8=3Dm
CONFIG_RTC_DRV_M48T86=3Dm
CONFIG_RTC_DRV_M48T35=3Dm
CONFIG_RTC_DRV_M48T59=3Dm
CONFIG_RTC_DRV_MSM6242=3Dm
CONFIG_RTC_DRV_BQ4802=3Dm
CONFIG_RTC_DRV_RP5C01=3Dm
CONFIG_RTC_DRV_V3020=3Dm
CONFIG_RTC_DRV_WM831X=3Dm
CONFIG_RTC_DRV_WM8350=3Dm
CONFIG_RTC_DRV_PCF50633=3Dm
CONFIG_RTC_DRV_AB3100=3Dm
CONFIG_RTC_DRV_ZYNQMP=3Dm
CONFIG_RTC_DRV_CROS_EC=3Dm

#
# on-CPU RTC drivers
#
CONFIG_RTC_DRV_CADENCE=3Dm
CONFIG_RTC_DRV_FTRTC010=3Dm
CONFIG_RTC_DRV_PCAP=3Dm
CONFIG_RTC_DRV_MC13XXX=3Dm
CONFIG_RTC_DRV_SNVS=3Dm
CONFIG_RTC_DRV_MT6397=3Dm
CONFIG_RTC_DRV_R7301=3Dm
CONFIG_RTC_DRV_CPCAP=3Dm

#
# HID Sensor RTC drivers
#
CONFIG_RTC_DRV_HID_SENSOR_TIME=3Dm
CONFIG_RTC_DRV_WILCO_EC=3Dm
CONFIG_DMADEVICES=3Dy
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=3Dy
CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
CONFIG_DMA_ACPI=3Dy
CONFIG_DMA_OF=3Dy
CONFIG_ALTERA_MSGDMA=3Dm
CONFIG_DW_AXI_DMAC=3Dm
CONFIG_FSL_EDMA=3Dm
CONFIG_INTEL_IDMA64=3Dm
CONFIG_INTEL_IDXD=3Dm
CONFIG_INTEL_IOATDMA=3Dm
CONFIG_INTEL_MIC_X100_DMA=3Dm
CONFIG_PLX_DMA=3Dm
CONFIG_QCOM_HIDMA_MGMT=3Dm
CONFIG_QCOM_HIDMA=3Dm
CONFIG_DW_DMAC_CORE=3Dy
CONFIG_DW_DMAC=3Dy
CONFIG_DW_DMAC_PCI=3Dy
CONFIG_DW_EDMA=3Dm
CONFIG_DW_EDMA_PCIE=3Dm
CONFIG_HSU_DMA=3Dy
CONFIG_SF_PDMA=3Dm

#
# DMA Clients
#
CONFIG_ASYNC_TX_DMA=3Dy
# CONFIG_DMATEST is not set
CONFIG_DMA_ENGINE_RAID=3Dy

#
# DMABUF options
#
CONFIG_SYNC_FILE=3Dy
# CONFIG_SW_SYNC is not set
CONFIG_UDMABUF=3Dy
# CONFIG_DMABUF_SELFTESTS is not set
CONFIG_DMABUF_HEAPS=3Dy
CONFIG_DMABUF_HEAPS_SYSTEM=3Dy
# end of DMABUF options

CONFIG_DCA=3Dm
CONFIG_AUXDISPLAY=3Dy
CONFIG_HD44780=3Dm
CONFIG_KS0108=3Dm
CONFIG_KS0108_PORT=3D0x378
CONFIG_KS0108_DELAY=3D2
CONFIG_CFAG12864B=3Dm
CONFIG_CFAG12864B_RATE=3D20
CONFIG_IMG_ASCII_LCD=3Dm
CONFIG_HT16K33=3Dm
CONFIG_PARPORT_PANEL=3Dm
CONFIG_PANEL_PARPORT=3D0
CONFIG_PANEL_PROFILE=3D5
# CONFIG_PANEL_CHANGE_MESSAGE is not set
# CONFIG_CHARLCD_BL_OFF is not set
# CONFIG_CHARLCD_BL_ON is not set
CONFIG_CHARLCD_BL_FLASH=3Dy
CONFIG_PANEL=3Dm
CONFIG_CHARLCD=3Dm
CONFIG_UIO=3Dm
CONFIG_UIO_CIF=3Dm
CONFIG_UIO_PDRV_GENIRQ=3Dm
CONFIG_UIO_DMEM_GENIRQ=3Dm
CONFIG_UIO_AEC=3Dm
CONFIG_UIO_SERCOS3=3Dm
CONFIG_UIO_PCI_GENERIC=3Dm
CONFIG_UIO_NETX=3Dm
CONFIG_UIO_PRUSS=3Dm
CONFIG_UIO_MF624=3Dm
CONFIG_UIO_HV_GENERIC=3Dm
CONFIG_VFIO_IOMMU_TYPE1=3Dm
CONFIG_VFIO_VIRQFD=3Dm
CONFIG_VFIO=3Dm
# CONFIG_VFIO_NOIOMMU is not set
CONFIG_VFIO_PCI=3Dm
CONFIG_VFIO_PCI_VGA=3Dy
CONFIG_VFIO_PCI_MMAP=3Dy
CONFIG_VFIO_PCI_INTX=3Dy
CONFIG_VFIO_PCI_IGD=3Dy
CONFIG_VFIO_MDEV=3Dm
CONFIG_VFIO_MDEV_DEVICE=3Dm
CONFIG_IRQ_BYPASS_MANAGER=3Dm
CONFIG_VIRT_DRIVERS=3Dy
CONFIG_VBOXGUEST=3Dm
CONFIG_VIRTIO=3Dy
CONFIG_VIRTIO_MENU=3Dy
CONFIG_VIRTIO_PCI=3Dm
CONFIG_VIRTIO_PCI_LEGACY=3Dy
CONFIG_VIRTIO_PMEM=3Dm
CONFIG_VIRTIO_BALLOON=3Dm
CONFIG_VIRTIO_INPUT=3Dm
CONFIG_VIRTIO_MMIO=3Dm
CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy

#
# Microsoft Hyper-V guest support
#
CONFIG_HYPERV=3Dm
CONFIG_HYPERV_TIMER=3Dy
CONFIG_HYPERV_UTILS=3Dm
CONFIG_HYPERV_BALLOON=3Dm
# end of Microsoft Hyper-V guest support

#
# Xen driver support
#
CONFIG_XEN_BALLOON=3Dy
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG=3Dy
CONFIG_XEN_BALLOON_MEMORY_HOTPLUG_LIMIT=3D512
CONFIG_XEN_SCRUB_PAGES_DEFAULT=3Dy
CONFIG_XEN_DEV_EVTCHN=3Dm
CONFIG_XEN_BACKEND=3Dy
CONFIG_XENFS=3Dm
CONFIG_XEN_COMPAT_XENFS=3Dy
CONFIG_XEN_SYS_HYPERVISOR=3Dy
CONFIG_XEN_XENBUS_FRONTEND=3Dy
CONFIG_XEN_GNTDEV=3Dm
CONFIG_XEN_GNTDEV_DMABUF=3Dy
CONFIG_XEN_GRANT_DEV_ALLOC=3Dm
CONFIG_XEN_GRANT_DMA_ALLOC=3Dy
CONFIG_SWIOTLB_XEN=3Dy
CONFIG_XEN_PCIDEV_BACKEND=3Dm
CONFIG_XEN_PVCALLS_FRONTEND=3Dm
CONFIG_XEN_PVCALLS_BACKEND=3Dy
CONFIG_XEN_SCSI_BACKEND=3Dm
CONFIG_XEN_PRIVCMD=3Dm
CONFIG_XEN_ACPI_PROCESSOR=3Dm
CONFIG_XEN_MCE_LOG=3Dy
CONFIG_XEN_HAVE_PVMMU=3Dy
CONFIG_XEN_EFI=3Dy
CONFIG_XEN_AUTO_XLATE=3Dy
CONFIG_XEN_ACPI=3Dy
CONFIG_XEN_SYMS=3Dy
CONFIG_XEN_HAVE_VPMU=3Dy
CONFIG_XEN_FRONT_PGDIR_SHBUF=3Dm
# end of Xen driver support

# CONFIG_GREYBUS is not set
CONFIG_STAGING=3Dy
CONFIG_PRISM2_USB=3Dm
CONFIG_COMEDI=3Dm
# CONFIG_COMEDI_DEBUG is not set
CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048
CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480
CONFIG_COMEDI_MISC_DRIVERS=3Dy
CONFIG_COMEDI_BOND=3Dm
CONFIG_COMEDI_TEST=3Dm
CONFIG_COMEDI_PARPORT=3Dm
# CONFIG_COMEDI_ISA_DRIVERS is not set
CONFIG_COMEDI_PCI_DRIVERS=3Dm
CONFIG_COMEDI_8255_PCI=3Dm
CONFIG_COMEDI_ADDI_WATCHDOG=3Dm
CONFIG_COMEDI_ADDI_APCI_1032=3Dm
CONFIG_COMEDI_ADDI_APCI_1500=3Dm
CONFIG_COMEDI_ADDI_APCI_1516=3Dm
CONFIG_COMEDI_ADDI_APCI_1564=3Dm
CONFIG_COMEDI_ADDI_APCI_16XX=3Dm
CONFIG_COMEDI_ADDI_APCI_2032=3Dm
CONFIG_COMEDI_ADDI_APCI_2200=3Dm
CONFIG_COMEDI_ADDI_APCI_3120=3Dm
CONFIG_COMEDI_ADDI_APCI_3501=3Dm
CONFIG_COMEDI_ADDI_APCI_3XXX=3Dm
CONFIG_COMEDI_ADL_PCI6208=3Dm
CONFIG_COMEDI_ADL_PCI7X3X=3Dm
CONFIG_COMEDI_ADL_PCI8164=3Dm
CONFIG_COMEDI_ADL_PCI9111=3Dm
CONFIG_COMEDI_ADL_PCI9118=3Dm
CONFIG_COMEDI_ADV_PCI1710=3Dm
CONFIG_COMEDI_ADV_PCI1720=3Dm
CONFIG_COMEDI_ADV_PCI1723=3Dm
CONFIG_COMEDI_ADV_PCI1724=3Dm
CONFIG_COMEDI_ADV_PCI1760=3Dm
CONFIG_COMEDI_ADV_PCI_DIO=3Dm
CONFIG_COMEDI_AMPLC_DIO200_PCI=3Dm
CONFIG_COMEDI_AMPLC_PC236_PCI=3Dm
CONFIG_COMEDI_AMPLC_PC263_PCI=3Dm
CONFIG_COMEDI_AMPLC_PCI224=3Dm
CONFIG_COMEDI_AMPLC_PCI230=3Dm
CONFIG_COMEDI_CONTEC_PCI_DIO=3Dm
CONFIG_COMEDI_DAS08_PCI=3Dm
CONFIG_COMEDI_DT3000=3Dm
CONFIG_COMEDI_DYNA_PCI10XX=3Dm
CONFIG_COMEDI_GSC_HPDI=3Dm
CONFIG_COMEDI_MF6X4=3Dm
CONFIG_COMEDI_ICP_MULTI=3Dm
CONFIG_COMEDI_DAQBOARD2000=3Dm
CONFIG_COMEDI_JR3_PCI=3Dm
CONFIG_COMEDI_KE_COUNTER=3Dm
CONFIG_COMEDI_CB_PCIDAS64=3Dm
CONFIG_COMEDI_CB_PCIDAS=3Dm
CONFIG_COMEDI_CB_PCIDDA=3Dm
CONFIG_COMEDI_CB_PCIMDAS=3Dm
CONFIG_COMEDI_CB_PCIMDDA=3Dm
CONFIG_COMEDI_ME4000=3Dm
CONFIG_COMEDI_ME_DAQ=3Dm
CONFIG_COMEDI_NI_6527=3Dm
CONFIG_COMEDI_NI_65XX=3Dm
CONFIG_COMEDI_NI_660X=3Dm
CONFIG_COMEDI_NI_670X=3Dm
CONFIG_COMEDI_NI_LABPC_PCI=3Dm
CONFIG_COMEDI_NI_PCIDIO=3Dm
CONFIG_COMEDI_NI_PCIMIO=3Dm
CONFIG_COMEDI_RTD520=3Dm
CONFIG_COMEDI_S626=3Dm
CONFIG_COMEDI_MITE=3Dm
CONFIG_COMEDI_NI_TIOCMD=3Dm
CONFIG_COMEDI_PCMCIA_DRIVERS=3Dm
CONFIG_COMEDI_CB_DAS16_CS=3Dm
CONFIG_COMEDI_DAS08_CS=3Dm
CONFIG_COMEDI_NI_DAQ_700_CS=3Dm
CONFIG_COMEDI_NI_DAQ_DIO24_CS=3Dm
CONFIG_COMEDI_NI_LABPC_CS=3Dm
CONFIG_COMEDI_NI_MIO_CS=3Dm
CONFIG_COMEDI_QUATECH_DAQP_CS=3Dm
CONFIG_COMEDI_USB_DRIVERS=3Dm
CONFIG_COMEDI_DT9812=3Dm
CONFIG_COMEDI_NI_USB6501=3Dm
CONFIG_COMEDI_USBDUX=3Dm
CONFIG_COMEDI_USBDUXFAST=3Dm
CONFIG_COMEDI_USBDUXSIGMA=3Dm
CONFIG_COMEDI_VMK80XX=3Dm
CONFIG_COMEDI_8254=3Dm
CONFIG_COMEDI_8255=3Dm
CONFIG_COMEDI_8255_SA=3Dm
CONFIG_COMEDI_KCOMEDILIB=3Dm
CONFIG_COMEDI_AMPLC_DIO200=3Dm
CONFIG_COMEDI_AMPLC_PC236=3Dm
CONFIG_COMEDI_DAS08=3Dm
CONFIG_COMEDI_NI_LABPC=3Dm
CONFIG_COMEDI_NI_TIO=3Dm
CONFIG_COMEDI_NI_ROUTING=3Dm
CONFIG_RTL8192U=3Dm
CONFIG_RTLLIB=3Dm
CONFIG_RTLLIB_CRYPTO_CCMP=3Dm
CONFIG_RTLLIB_CRYPTO_TKIP=3Dm
CONFIG_RTLLIB_CRYPTO_WEP=3Dm
CONFIG_RTL8192E=3Dm
CONFIG_RTL8723BS=3Dm
CONFIG_R8712U=3Dm
CONFIG_R8188EU=3Dm
CONFIG_88EU_AP_MODE=3Dy
CONFIG_RTS5208=3Dm
CONFIG_VT6655=3Dm
CONFIG_VT6656=3Dm

#
# IIO staging drivers
#

#
# Accelerometers
#
CONFIG_ADIS16203=3Dm
CONFIG_ADIS16240=3Dm
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD7816=3Dm
CONFIG_AD7192=3Dm
CONFIG_AD7280=3Dm
# end of Analog to digital converters

#
# Analog digital bi-direction converters
#
CONFIG_ADT7316=3Dm
CONFIG_ADT7316_SPI=3Dm
CONFIG_ADT7316_I2C=3Dm
# end of Analog digital bi-direction converters

#
# Capacitance to digital converters
#
CONFIG_AD7150=3Dm
CONFIG_AD7746=3Dm
# end of Capacitance to digital converters

#
# Direct Digital Synthesis
#
CONFIG_AD9832=3Dm
CONFIG_AD9834=3Dm
# end of Direct Digital Synthesis

#
# Network Analyzer, Impedance Converters
#
CONFIG_AD5933=3Dm
# end of Network Analyzer, Impedance Converters

#
# Active energy metering IC
#
CONFIG_ADE7854=3Dm
CONFIG_ADE7854_I2C=3Dm
CONFIG_ADE7854_SPI=3Dm
# end of Active energy metering IC

#
# Resolver to digital converters
#
CONFIG_AD2S1210=3Dm
# end of Resolver to digital converters
# end of IIO staging drivers

# CONFIG_FB_SM750 is not set

#
# Speakup console speech
#
CONFIG_SPEAKUP=3Dm
CONFIG_SPEAKUP_SYNTH_ACNTSA=3Dm
CONFIG_SPEAKUP_SYNTH_APOLLO=3Dm
CONFIG_SPEAKUP_SYNTH_AUDPTR=3Dm
CONFIG_SPEAKUP_SYNTH_BNS=3Dm
CONFIG_SPEAKUP_SYNTH_DECTLK=3Dm
CONFIG_SPEAKUP_SYNTH_DECEXT=3Dm
CONFIG_SPEAKUP_SYNTH_LTLK=3Dm
CONFIG_SPEAKUP_SYNTH_SOFT=3Dm
CONFIG_SPEAKUP_SYNTH_SPKOUT=3Dm
CONFIG_SPEAKUP_SYNTH_TXPRT=3Dm
CONFIG_SPEAKUP_SYNTH_DUMMY=3Dm
# end of Speakup console speech

CONFIG_STAGING_MEDIA=3Dy
CONFIG_VIDEO_IPU3_IMGU=3Dm

#
# soc_camera sensor drivers
#

#
# Android
#
# end of Android

CONFIG_STAGING_BOARD=3Dy
CONFIG_LTE_GDM724X=3Dm
CONFIG_FIREWIRE_SERIAL=3Dm
CONFIG_FWTTY_MAX_TOTAL_PORTS=3D64
CONFIG_FWTTY_MAX_CARD_PORTS=3D32
CONFIG_GS_FPGABOOT=3Dm
CONFIG_UNISYSSPAR=3Dy
CONFIG_UNISYS_VISORNIC=3Dm
CONFIG_UNISYS_VISORINPUT=3Dm
CONFIG_UNISYS_VISORHBA=3Dm
CONFIG_COMMON_CLK_XLNX_CLKWZRD=3Dm
# CONFIG_FB_TFT is not set
CONFIG_WILC1000=3Dm
CONFIG_WILC1000_SDIO=3Dm
CONFIG_WILC1000_SPI=3Dm
# CONFIG_WILC1000_HW_OOB_INTR is not set
CONFIG_MOST=3Dm
CONFIG_MOST_CDEV=3Dm
CONFIG_MOST_NET=3Dm
CONFIG_MOST_SOUND=3Dm
CONFIG_MOST_VIDEO=3Dm
CONFIG_MOST_DIM2=3Dm
CONFIG_MOST_I2C=3Dm
CONFIG_MOST_USB=3Dm
CONFIG_KS7010=3Dm
CONFIG_PI433=3Dm

#
# Gasket devices
#
CONFIG_STAGING_GASKET_FRAMEWORK=3Dm
CONFIG_STAGING_APEX_DRIVER=3Dm
# end of Gasket devices

CONFIG_XIL_AXIS_FIFO=3Dm
CONFIG_FIELDBUS_DEV=3Dm
CONFIG_HMS_ANYBUSS_BUS=3Dm
CONFIG_ARCX_ANYBUS_CONTROLLER=3Dm
CONFIG_HMS_PROFINET=3Dm
CONFIG_KPC2000=3Dy
CONFIG_KPC2000_CORE=3Dm
CONFIG_KPC2000_SPI=3Dm
CONFIG_KPC2000_I2C=3Dm
CONFIG_KPC2000_DMA=3Dm
CONFIG_USB_WUSB=3Dm
CONFIG_USB_WUSB_CBAF=3Dm
# CONFIG_USB_WUSB_CBAF_DEBUG is not set
CONFIG_USB_WHCI_HCD=3Dm
CONFIG_USB_HWA_HCD=3Dm
CONFIG_UWB=3Dm
CONFIG_UWB_HWA=3Dm
CONFIG_UWB_WHCI=3Dm
CONFIG_UWB_I1480U=3Dm
CONFIG_STAGING_EXFAT_FS=3Dm
CONFIG_STAGING_EXFAT_DISCARD=3Dy
# CONFIG_STAGING_EXFAT_DELAYED_SYNC is not set
# CONFIG_STAGING_EXFAT_KERNEL_DEBUG is not set
# CONFIG_STAGING_EXFAT_DEBUG_MSG is not set
CONFIG_STAGING_EXFAT_DEFAULT_CODEPAGE=3D437
CONFIG_STAGING_EXFAT_DEFAULT_IOCHARSET=3D"utf8"
CONFIG_QLGE=3Dm
CONFIG_NET_VENDOR_HP=3Dy
CONFIG_HP100=3Dm
CONFIG_WFX=3Dm
CONFIG_X86_PLATFORM_DEVICES=3Dy
CONFIG_ACER_WMI=3Dm
CONFIG_ACER_WIRELESS=3Dm
CONFIG_ACERHDF=3Dm
CONFIG_ALIENWARE_WMI=3Dm
CONFIG_ASUS_LAPTOP=3Dm
CONFIG_DCDBAS=3Dm
CONFIG_DELL_SMBIOS=3Dm
CONFIG_DELL_SMBIOS_WMI=3Dy
CONFIG_DELL_SMBIOS_SMM=3Dy
CONFIG_DELL_LAPTOP=3Dm
CONFIG_DELL_WMI=3Dm
CONFIG_DELL_WMI_DESCRIPTOR=3Dm
CONFIG_DELL_WMI_AIO=3Dm
CONFIG_DELL_WMI_LED=3Dm
CONFIG_DELL_SMO8800=3Dm
CONFIG_DELL_RBTN=3Dm
# CONFIG_DELL_RBU is not set
CONFIG_FUJITSU_LAPTOP=3Dm
CONFIG_FUJITSU_TABLET=3Dm
CONFIG_AMILO_RFKILL=3Dm
CONFIG_GPD_POCKET_FAN=3Dm
CONFIG_HP_ACCEL=3Dm
CONFIG_HP_WIRELESS=3Dm
CONFIG_HP_WMI=3Dm
CONFIG_LG_LAPTOP=3Dm
CONFIG_MSI_LAPTOP=3Dm
CONFIG_PANASONIC_LAPTOP=3Dm
CONFIG_COMPAL_LAPTOP=3Dm
CONFIG_SONY_LAPTOP=3Dm
CONFIG_SONYPI_COMPAT=3Dy
CONFIG_IDEAPAD_LAPTOP=3Dm
CONFIG_SURFACE3_WMI=3Dm
CONFIG_THINKPAD_ACPI=3Dm
CONFIG_THINKPAD_ACPI_ALSA_SUPPORT=3Dy
# CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
# CONFIG_THINKPAD_ACPI_DEBUG is not set
# CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
CONFIG_THINKPAD_ACPI_VIDEO=3Dy
CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
CONFIG_SENSORS_HDAPS=3Dm
CONFIG_INTEL_MENLOW=3Dm
CONFIG_EEEPC_LAPTOP=3Dm
CONFIG_ASUS_WMI=3Dm
CONFIG_ASUS_NB_WMI=3Dm
CONFIG_EEEPC_WMI=3Dm
CONFIG_ASUS_WIRELESS=3Dm
CONFIG_ACPI_WMI=3Dm
CONFIG_WMI_BMOF=3Dm
CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
CONFIG_XIAOMI_WMI=3Dm
CONFIG_MSI_WMI=3Dm
CONFIG_PEAQ_WMI=3Dm
CONFIG_TOPSTAR_LAPTOP=3Dm
CONFIG_ACPI_TOSHIBA=3Dm
CONFIG_TOSHIBA_BT_RFKILL=3Dm
CONFIG_TOSHIBA_HAPS=3Dm
CONFIG_TOSHIBA_WMI=3Dm
CONFIG_ACPI_CMPC=3Dm
CONFIG_INTEL_CHT_INT33FE=3Dm
CONFIG_INTEL_INT0002_VGPIO=3Dm
CONFIG_INTEL_HID_EVENT=3Dm
CONFIG_INTEL_VBTN=3Dm
CONFIG_INTEL_IPS=3Dm
CONFIG_INTEL_PMC_CORE=3Dy
CONFIG_IBM_RTL=3Dm
CONFIG_SAMSUNG_LAPTOP=3Dm
CONFIG_MXM_WMI=3Dm
CONFIG_INTEL_OAKTRAIL=3Dm
CONFIG_SAMSUNG_Q10=3Dm
CONFIG_APPLE_GMUX=3Dm
CONFIG_INTEL_RST=3Dm
CONFIG_INTEL_SMARTCONNECT=3Dm
CONFIG_INTEL_PMC_IPC=3Dm
CONFIG_INTEL_BXTWC_PMIC_TMU=3Dm
CONFIG_SURFACE_PRO3_BUTTON=3Dm
CONFIG_SURFACE_3_BUTTON=3Dm
CONFIG_INTEL_PUNIT_IPC=3Dm
CONFIG_INTEL_TELEMETRY=3Dm
CONFIG_MLX_PLATFORM=3Dm
CONFIG_INTEL_TURBO_MAX_3=3Dy
CONFIG_TOUCHSCREEN_DMI=3Dy
CONFIG_INTEL_CHTDC_TI_PWRBTN=3Dm
CONFIG_I2C_MULTI_INSTANTIATE=3Dm
CONFIG_INTEL_ATOMISP2_PM=3Dm
CONFIG_HUAWEI_WMI=3Dm
CONFIG_PCENGINES_APU2=3Dm
CONFIG_INTEL_UNCORE_FREQ_CONTROL=3Dm

#
# Intel Speed Select Technology interface support
#
CONFIG_INTEL_SPEED_SELECT_INTERFACE=3Dm
# end of Intel Speed Select Technology interface support

CONFIG_SYSTEM76_ACPI=3Dm
CONFIG_PMC_ATOM=3Dy
CONFIG_MFD_CROS_EC=3Dm
CONFIG_CHROME_PLATFORMS=3Dy
CONFIG_CHROMEOS_LAPTOP=3Dm
CONFIG_CHROMEOS_PSTORE=3Dm
CONFIG_CHROMEOS_TBMC=3Dm
CONFIG_CROS_EC=3Dm
CONFIG_CROS_EC_I2C=3Dm
CONFIG_CROS_EC_RPMSG=3Dm
CONFIG_CROS_EC_ISHTP=3Dm
CONFIG_CROS_EC_SPI=3Dm
CONFIG_CROS_EC_LPC=3Dm
CONFIG_CROS_EC_PROTO=3Dy
CONFIG_CROS_KBD_LED_BACKLIGHT=3Dm
CONFIG_CROS_EC_CHARDEV=3Dm
CONFIG_CROS_EC_LIGHTBAR=3Dm
CONFIG_CROS_EC_VBC=3Dm
CONFIG_CROS_EC_DEBUGFS=3Dm
CONFIG_CROS_EC_SENSORHUB=3Dm
CONFIG_CROS_EC_SYSFS=3Dm
CONFIG_CROS_USBPD_LOGGER=3Dm
CONFIG_WILCO_EC=3Dm
CONFIG_WILCO_EC_DEBUGFS=3Dm
CONFIG_WILCO_EC_EVENTS=3Dm
CONFIG_WILCO_EC_TELEMETRY=3Dm
CONFIG_MELLANOX_PLATFORM=3Dy
CONFIG_MLXREG_HOTPLUG=3Dm
CONFIG_MLXREG_IO=3Dm
CONFIG_CLKDEV_LOOKUP=3Dy
CONFIG_HAVE_CLK_PREPARE=3Dy
CONFIG_COMMON_CLK=3Dy

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_WM831X=3Dm
CONFIG_CLK_HSDK=3Dy
CONFIG_COMMON_CLK_MAX77686=3Dm
CONFIG_COMMON_CLK_MAX9485=3Dm
CONFIG_COMMON_CLK_RK808=3Dm
CONFIG_COMMON_CLK_SI5341=3Dm
CONFIG_COMMON_CLK_SI5351=3Dm
CONFIG_COMMON_CLK_SI514=3Dm
CONFIG_COMMON_CLK_SI544=3Dm
CONFIG_COMMON_CLK_SI570=3Dm
CONFIG_COMMON_CLK_CDCE706=3Dm
CONFIG_COMMON_CLK_CDCE925=3Dm
CONFIG_COMMON_CLK_CS2000_CP=3Dm
CONFIG_COMMON_CLK_S2MPS11=3Dm
CONFIG_CLK_TWL6040=3Dm
CONFIG_COMMON_CLK_LOCHNAGAR=3Dm
CONFIG_COMMON_CLK_PALMAS=3Dm
CONFIG_COMMON_CLK_PWM=3Dm
CONFIG_COMMON_CLK_VC5=3Dm
CONFIG_COMMON_CLK_BD718XX=3Dm
CONFIG_COMMON_CLK_FIXED_MMIO=3Dy
# end of Common Clock Framework

CONFIG_HWSPINLOCK=3Dy

#
# Clock Source drivers
#
CONFIG_CLKEVT_I8253=3Dy
CONFIG_I8253_LOCK=3Dy
CONFIG_CLKBLD_I8253=3Dy
CONFIG_CLKSRC_MMIO=3Dy
CONFIG_MICROCHIP_PIT64B=3Dy
# end of Clock Source drivers

CONFIG_MAILBOX=3Dy
CONFIG_PLATFORM_MHU=3Dm
CONFIG_PCC=3Dy
CONFIG_ALTERA_MBOX=3Dm
CONFIG_MAILBOX_TEST=3Dm
CONFIG_IOMMU_IOVA=3Dy
CONFIG_IOASID=3Dy
CONFIG_IOMMU_API=3Dy
CONFIG_IOMMU_SUPPORT=3Dy

#
# Generic IOMMU Pagetable Support
#
# end of Generic IOMMU Pagetable Support

# CONFIG_IOMMU_DEBUGFS is not set
# CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
CONFIG_OF_IOMMU=3Dy
CONFIG_IOMMU_DMA=3Dy
CONFIG_AMD_IOMMU=3Dy
CONFIG_AMD_IOMMU_V2=3Dy
CONFIG_DMAR_TABLE=3Dy
CONFIG_INTEL_IOMMU=3Dy
CONFIG_INTEL_IOMMU_SVM=3Dy
# CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
# CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON is not set
CONFIG_IRQ_REMAP=3Dy
CONFIG_HYPERV_IOMMU=3Dy

#
# Remoteproc drivers
#
CONFIG_REMOTEPROC=3Dy
# end of Remoteproc drivers

#
# Rpmsg drivers
#
CONFIG_RPMSG=3Dm
CONFIG_RPMSG_CHAR=3Dm
CONFIG_RPMSG_QCOM_GLINK_NATIVE=3Dm
CONFIG_RPMSG_QCOM_GLINK_RPM=3Dm
CONFIG_RPMSG_VIRTIO=3Dm
# end of Rpmsg drivers

CONFIG_SOUNDWIRE=3Dm

#
# SoundWire Devices
#
CONFIG_SOUNDWIRE_CADENCE=3Dm
CONFIG_SOUNDWIRE_INTEL=3Dm
CONFIG_SOUNDWIRE_QCOM=3Dm

#
# SOC (System On Chip) specific Drivers
#

#
# Amlogic SoC drivers
#
# end of Amlogic SoC drivers

#
# Aspeed SoC drivers
#
# end of Aspeed SoC drivers

#
# Broadcom SoC drivers
#
# end of Broadcom SoC drivers

#
# NXP/Freescale QorIQ SoC drivers
#
# end of NXP/Freescale QorIQ SoC drivers

#
# i.MX SoC drivers
#
# end of i.MX SoC drivers

#
# Qualcomm SoC drivers
#
# end of Qualcomm SoC drivers

CONFIG_SOC_TI=3Dy

#
# Xilinx SoC drivers
#
CONFIG_XILINX_VCU=3Dm
# end of Xilinx SoC drivers
# end of SOC (System On Chip) specific Drivers

CONFIG_PM_DEVFREQ=3Dy

#
# DEVFREQ Governors
#
CONFIG_DEVFREQ_GOV_SIMPLE_ONDEMAND=3Dm
CONFIG_DEVFREQ_GOV_PERFORMANCE=3Dm
CONFIG_DEVFREQ_GOV_POWERSAVE=3Dm
CONFIG_DEVFREQ_GOV_USERSPACE=3Dm
CONFIG_DEVFREQ_GOV_PASSIVE=3Dm

#
# DEVFREQ Drivers
#
CONFIG_PM_DEVFREQ_EVENT=3Dy
CONFIG_EXTCON=3Dy

#
# Extcon Device Drivers
#
CONFIG_EXTCON_ADC_JACK=3Dm
CONFIG_EXTCON_ARIZONA=3Dm
CONFIG_EXTCON_AXP288=3Dm
CONFIG_EXTCON_FSA9480=3Dm
CONFIG_EXTCON_GPIO=3Dm
CONFIG_EXTCON_INTEL_INT3496=3Dm
CONFIG_EXTCON_INTEL_CHT_WC=3Dm
CONFIG_EXTCON_MAX14577=3Dm
CONFIG_EXTCON_MAX3355=3Dm
CONFIG_EXTCON_MAX77693=3Dm
CONFIG_EXTCON_MAX77843=3Dm
CONFIG_EXTCON_MAX8997=3Dm
CONFIG_EXTCON_PALMAS=3Dm
CONFIG_EXTCON_PTN5150=3Dm
CONFIG_EXTCON_RT8973A=3Dm
CONFIG_EXTCON_SM5502=3Dm
CONFIG_EXTCON_USB_GPIO=3Dm
CONFIG_EXTCON_USBC_CROS_EC=3Dm
CONFIG_MEMORY=3Dy
CONFIG_IIO=3Dm
CONFIG_IIO_BUFFER=3Dy
CONFIG_IIO_BUFFER_CB=3Dm
CONFIG_IIO_BUFFER_HW_CONSUMER=3Dm
CONFIG_IIO_KFIFO_BUF=3Dm
CONFIG_IIO_TRIGGERED_BUFFER=3Dm
CONFIG_IIO_CONFIGFS=3Dm
CONFIG_IIO_TRIGGER=3Dy
CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
CONFIG_IIO_SW_DEVICE=3Dm
CONFIG_IIO_SW_TRIGGER=3Dm
CONFIG_IIO_TRIGGERED_EVENT=3Dm

#
# Accelerometers
#
CONFIG_ADIS16201=3Dm
CONFIG_ADIS16209=3Dm
CONFIG_ADXL372=3Dm
CONFIG_ADXL372_SPI=3Dm
CONFIG_ADXL372_I2C=3Dm
CONFIG_BMA180=3Dm
CONFIG_BMA220=3Dm
CONFIG_BMA400=3Dm
CONFIG_BMA400_I2C=3Dm
CONFIG_BMC150_ACCEL=3Dm
CONFIG_BMC150_ACCEL_I2C=3Dm
CONFIG_BMC150_ACCEL_SPI=3Dm
CONFIG_DA280=3Dm
CONFIG_DA311=3Dm
CONFIG_DMARD06=3Dm
CONFIG_DMARD09=3Dm
CONFIG_DMARD10=3Dm
CONFIG_HID_SENSOR_ACCEL_3D=3Dm
CONFIG_IIO_CROS_EC_ACCEL_LEGACY=3Dm
CONFIG_IIO_ST_ACCEL_3AXIS=3Dm
CONFIG_IIO_ST_ACCEL_I2C_3AXIS=3Dm
CONFIG_IIO_ST_ACCEL_SPI_3AXIS=3Dm
CONFIG_KXSD9=3Dm
CONFIG_KXSD9_SPI=3Dm
CONFIG_KXSD9_I2C=3Dm
CONFIG_KXCJK1013=3Dm
CONFIG_MC3230=3Dm
CONFIG_MMA7455=3Dm
CONFIG_MMA7455_I2C=3Dm
CONFIG_MMA7455_SPI=3Dm
CONFIG_MMA7660=3Dm
CONFIG_MMA8452=3Dm
CONFIG_MMA9551_CORE=3Dm
CONFIG_MMA9551=3Dm
CONFIG_MMA9553=3Dm
CONFIG_MXC4005=3Dm
CONFIG_MXC6255=3Dm
CONFIG_SCA3000=3Dm
CONFIG_STK8312=3Dm
CONFIG_STK8BA50=3Dm
# end of Accelerometers

#
# Analog to digital converters
#
CONFIG_AD_SIGMA_DELTA=3Dm
CONFIG_AD7091R5=3Dm
CONFIG_AD7124=3Dm
CONFIG_AD7266=3Dm
CONFIG_AD7291=3Dm
CONFIG_AD7292=3Dm
CONFIG_AD7298=3Dm
CONFIG_AD7476=3Dm
CONFIG_AD7606=3Dm
CONFIG_AD7606_IFACE_PARALLEL=3Dm
CONFIG_AD7606_IFACE_SPI=3Dm
CONFIG_AD7766=3Dm
CONFIG_AD7768_1=3Dm
CONFIG_AD7780=3Dm
CONFIG_AD7791=3Dm
CONFIG_AD7793=3Dm
CONFIG_AD7887=3Dm
CONFIG_AD7923=3Dm
CONFIG_AD7949=3Dm
CONFIG_AD799X=3Dm
CONFIG_AXP20X_ADC=3Dm
CONFIG_AXP288_ADC=3Dm
CONFIG_CC10001_ADC=3Dm
CONFIG_CPCAP_ADC=3Dm
CONFIG_DA9150_GPADC=3Dm
CONFIG_DLN2_ADC=3Dm
CONFIG_ENVELOPE_DETECTOR=3Dm
CONFIG_HI8435=3Dm
CONFIG_HX711=3Dm
CONFIG_INA2XX_ADC=3Dm
CONFIG_LP8788_ADC=3Dm
CONFIG_LTC2471=3Dm
CONFIG_LTC2485=3Dm
CONFIG_LTC2496=3Dm
CONFIG_LTC2497=3Dm
CONFIG_MAX1027=3Dm
CONFIG_MAX11100=3Dm
CONFIG_MAX1118=3Dm
CONFIG_MAX1363=3Dm
CONFIG_MAX9611=3Dm
CONFIG_MCP320X=3Dm
CONFIG_MCP3422=3Dm
CONFIG_MCP3911=3Dm
CONFIG_MEN_Z188_ADC=3Dm
CONFIG_NAU7802=3Dm
CONFIG_PALMAS_GPADC=3Dm
CONFIG_QCOM_VADC_COMMON=3Dm
CONFIG_QCOM_SPMI_IADC=3Dm
CONFIG_QCOM_SPMI_VADC=3Dm
CONFIG_QCOM_SPMI_ADC5=3Dm
CONFIG_SD_ADC_MODULATOR=3Dm
CONFIG_STMPE_ADC=3Dm
CONFIG_TI_ADC081C=3Dm
CONFIG_TI_ADC0832=3Dm
CONFIG_TI_ADC084S021=3Dm
CONFIG_TI_ADC12138=3Dm
CONFIG_TI_ADC108S102=3Dm
CONFIG_TI_ADC128S052=3Dm
CONFIG_TI_ADC161S626=3Dm
CONFIG_TI_ADS1015=3Dm
CONFIG_TI_ADS7950=3Dm
CONFIG_TI_ADS8344=3Dm
CONFIG_TI_ADS8688=3Dm
CONFIG_TI_ADS124S08=3Dm
CONFIG_TI_AM335X_ADC=3Dm
CONFIG_TI_TLC4541=3Dm
CONFIG_TWL4030_MADC=3Dm
CONFIG_TWL6030_GPADC=3Dm
CONFIG_VF610_ADC=3Dm
CONFIG_VIPERBOARD_ADC=3Dm
CONFIG_XILINX_XADC=3Dm
# end of Analog to digital converters

#
# Analog Front Ends
#
CONFIG_IIO_RESCALE=3Dm
# end of Analog Front Ends

#
# Amplifiers
#
CONFIG_AD8366=3Dm
# end of Amplifiers

#
# Chemical Sensors
#
CONFIG_ATLAS_PH_SENSOR=3Dm
CONFIG_BME680=3Dm
CONFIG_BME680_I2C=3Dm
CONFIG_BME680_SPI=3Dm
CONFIG_CCS811=3Dm
CONFIG_IAQCORE=3Dm
CONFIG_PMS7003=3Dm
CONFIG_SENSIRION_SGP30=3Dm
CONFIG_SPS30=3Dm
CONFIG_VZ89X=3Dm
# end of Chemical Sensors

CONFIG_IIO_CROS_EC_SENSORS_CORE=3Dm
CONFIG_IIO_CROS_EC_SENSORS=3Dm
CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE=3Dm

#
# Hid Sensor IIO Common
#
CONFIG_HID_SENSOR_IIO_COMMON=3Dm
CONFIG_HID_SENSOR_IIO_TRIGGER=3Dm
# end of Hid Sensor IIO Common

CONFIG_IIO_MS_SENSORS_I2C=3Dm

#
# SSP Sensor Common
#
CONFIG_IIO_SSP_SENSORS_COMMONS=3Dm
CONFIG_IIO_SSP_SENSORHUB=3Dm
# end of SSP Sensor Common

CONFIG_IIO_ST_SENSORS_I2C=3Dm
CONFIG_IIO_ST_SENSORS_SPI=3Dm
CONFIG_IIO_ST_SENSORS_CORE=3Dm

#
# Digital to analog converters
#
CONFIG_AD5064=3Dm
CONFIG_AD5360=3Dm
CONFIG_AD5380=3Dm
CONFIG_AD5421=3Dm
CONFIG_AD5446=3Dm
CONFIG_AD5449=3Dm
CONFIG_AD5592R_BASE=3Dm
CONFIG_AD5592R=3Dm
CONFIG_AD5593R=3Dm
CONFIG_AD5504=3Dm
CONFIG_AD5624R_SPI=3Dm
CONFIG_LTC1660=3Dm
CONFIG_LTC2632=3Dm
CONFIG_AD5686=3Dm
CONFIG_AD5686_SPI=3Dm
CONFIG_AD5696_I2C=3Dm
CONFIG_AD5755=3Dm
CONFIG_AD5758=3Dm
CONFIG_AD5761=3Dm
CONFIG_AD5764=3Dm
CONFIG_AD5791=3Dm
CONFIG_AD7303=3Dm
CONFIG_AD8801=3Dm
CONFIG_DPOT_DAC=3Dm
CONFIG_DS4424=3Dm
CONFIG_M62332=3Dm
CONFIG_MAX517=3Dm
CONFIG_MAX5821=3Dm
CONFIG_MCP4725=3Dm
CONFIG_MCP4922=3Dm
CONFIG_TI_DAC082S085=3Dm
CONFIG_TI_DAC5571=3Dm
CONFIG_TI_DAC7311=3Dm
CONFIG_TI_DAC7612=3Dm
CONFIG_VF610_DAC=3Dm
# end of Digital to analog converters

#
# IIO dummy driver
#
# CONFIG_IIO_SIMPLE_DUMMY is not set
# end of IIO dummy driver

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
CONFIG_AD9523=3Dm
# end of Clock Generator/Distribution

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
CONFIG_ADF4350=3Dm
CONFIG_ADF4371=3Dm
# end of Phase-Locked Loop (PLL) frequency synthesizers
# end of Frequency Synthesizers DDS/PLL

#
# Digital gyroscope sensors
#
CONFIG_ADIS16080=3Dm
CONFIG_ADIS16130=3Dm
CONFIG_ADIS16136=3Dm
CONFIG_ADIS16260=3Dm
CONFIG_ADXRS450=3Dm
CONFIG_BMG160=3Dm
CONFIG_BMG160_I2C=3Dm
CONFIG_BMG160_SPI=3Dm
CONFIG_FXAS21002C=3Dm
CONFIG_FXAS21002C_I2C=3Dm
CONFIG_FXAS21002C_SPI=3Dm
CONFIG_HID_SENSOR_GYRO_3D=3Dm
CONFIG_MPU3050=3Dm
CONFIG_MPU3050_I2C=3Dm
CONFIG_IIO_ST_GYRO_3AXIS=3Dm
CONFIG_IIO_ST_GYRO_I2C_3AXIS=3Dm
CONFIG_IIO_ST_GYRO_SPI_3AXIS=3Dm
CONFIG_ITG3200=3Dm
# end of Digital gyroscope sensors

#
# Health Sensors
#

#
# Heart Rate Monitors
#
CONFIG_AFE4403=3Dm
CONFIG_AFE4404=3Dm
CONFIG_MAX30100=3Dm
CONFIG_MAX30102=3Dm
# end of Heart Rate Monitors
# end of Health Sensors

#
# Humidity sensors
#
CONFIG_AM2315=3Dm
CONFIG_DHT11=3Dm
CONFIG_HDC100X=3Dm
CONFIG_HID_SENSOR_HUMIDITY=3Dm
CONFIG_HTS221=3Dm
CONFIG_HTS221_I2C=3Dm
CONFIG_HTS221_SPI=3Dm
CONFIG_HTU21=3Dm
CONFIG_SI7005=3Dm
CONFIG_SI7020=3Dm
# end of Humidity sensors

#
# Inertial measurement units
#
CONFIG_ADIS16400=3Dm
CONFIG_ADIS16460=3Dm
CONFIG_ADIS16480=3Dm
CONFIG_BMI160=3Dm
CONFIG_BMI160_I2C=3Dm
CONFIG_BMI160_SPI=3Dm
CONFIG_FXOS8700=3Dm
CONFIG_FXOS8700_I2C=3Dm
CONFIG_FXOS8700_SPI=3Dm
CONFIG_KMX61=3Dm
CONFIG_INV_MPU6050_IIO=3Dm
CONFIG_INV_MPU6050_I2C=3Dm
CONFIG_INV_MPU6050_SPI=3Dm
CONFIG_IIO_ST_LSM6DSX=3Dm
CONFIG_IIO_ST_LSM6DSX_I2C=3Dm
CONFIG_IIO_ST_LSM6DSX_SPI=3Dm
CONFIG_IIO_ST_LSM6DSX_I3C=3Dm
# end of Inertial measurement units

CONFIG_IIO_ADIS_LIB=3Dm
CONFIG_IIO_ADIS_LIB_BUFFER=3Dy

#
# Light sensors
#
CONFIG_ACPI_ALS=3Dm
CONFIG_ADJD_S311=3Dm
CONFIG_ADUX1020=3Dm
CONFIG_AL3320A=3Dm
CONFIG_APDS9300=3Dm
CONFIG_APDS9960=3Dm
CONFIG_BH1750=3Dm
CONFIG_BH1780=3Dm
CONFIG_CM32181=3Dm
CONFIG_CM3232=3Dm
CONFIG_CM3323=3Dm
CONFIG_CM3605=3Dm
CONFIG_CM36651=3Dm
CONFIG_IIO_CROS_EC_LIGHT_PROX=3Dm
CONFIG_GP2AP020A00F=3Dm
CONFIG_SENSORS_ISL29018=3Dm
CONFIG_SENSORS_ISL29028=3Dm
CONFIG_ISL29125=3Dm
CONFIG_HID_SENSOR_ALS=3Dm
CONFIG_HID_SENSOR_PROX=3Dm
CONFIG_JSA1212=3Dm
CONFIG_RPR0521=3Dm
CONFIG_SENSORS_LM3533=3Dm
CONFIG_LTR501=3Dm
CONFIG_LV0104CS=3Dm
CONFIG_MAX44000=3Dm
CONFIG_MAX44009=3Dm
CONFIG_NOA1305=3Dm
CONFIG_OPT3001=3Dm
CONFIG_PA12203001=3Dm
CONFIG_SI1133=3Dm
CONFIG_SI1145=3Dm
CONFIG_STK3310=3Dm
CONFIG_ST_UVIS25=3Dm
CONFIG_ST_UVIS25_I2C=3Dm
CONFIG_ST_UVIS25_SPI=3Dm
CONFIG_TCS3414=3Dm
CONFIG_TCS3472=3Dm
CONFIG_SENSORS_TSL2563=3Dm
CONFIG_TSL2583=3Dm
CONFIG_TSL2772=3Dm
CONFIG_TSL4531=3Dm
CONFIG_US5182D=3Dm
CONFIG_VCNL4000=3Dm
CONFIG_VCNL4035=3Dm
CONFIG_VEML6030=3Dm
CONFIG_VEML6070=3Dm
CONFIG_VL6180=3Dm
CONFIG_ZOPT2201=3Dm
# end of Light sensors

#
# Magnetometer sensors
#
CONFIG_AK8974=3Dm
CONFIG_AK8975=3Dm
CONFIG_AK09911=3Dm
CONFIG_BMC150_MAGN=3Dm
CONFIG_BMC150_MAGN_I2C=3Dm
CONFIG_BMC150_MAGN_SPI=3Dm
CONFIG_MAG3110=3Dm
CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dm
CONFIG_MMC35240=3Dm
CONFIG_IIO_ST_MAGN_3AXIS=3Dm
CONFIG_IIO_ST_MAGN_I2C_3AXIS=3Dm
CONFIG_IIO_ST_MAGN_SPI_3AXIS=3Dm
CONFIG_SENSORS_HMC5843=3Dm
CONFIG_SENSORS_HMC5843_I2C=3Dm
CONFIG_SENSORS_HMC5843_SPI=3Dm
CONFIG_SENSORS_RM3100=3Dm
CONFIG_SENSORS_RM3100_I2C=3Dm
CONFIG_SENSORS_RM3100_SPI=3Dm
# end of Magnetometer sensors

#
# Multiplexers
#
CONFIG_IIO_MUX=3Dm
# end of Multiplexers

#
# Inclinometer sensors
#
CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dm
CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dm
# end of Inclinometer sensors

#
# Triggers - standalone
#
CONFIG_IIO_HRTIMER_TRIGGER=3Dm
CONFIG_IIO_INTERRUPT_TRIGGER=3Dm
CONFIG_IIO_TIGHTLOOP_TRIGGER=3Dm
CONFIG_IIO_SYSFS_TRIGGER=3Dm
# end of Triggers - standalone

#
# Digital potentiometers
#
CONFIG_AD5272=3Dm
CONFIG_DS1803=3Dm
CONFIG_MAX5432=3Dm
CONFIG_MAX5481=3Dm
CONFIG_MAX5487=3Dm
CONFIG_MCP4018=3Dm
CONFIG_MCP4131=3Dm
CONFIG_MCP4531=3Dm
CONFIG_MCP41010=3Dm
CONFIG_TPL0102=3Dm
# end of Digital potentiometers

#
# Digital potentiostats
#
CONFIG_LMP91000=3Dm
# end of Digital potentiostats

#
# Pressure sensors
#
CONFIG_ABP060MG=3Dm
CONFIG_BMP280=3Dm
CONFIG_BMP280_I2C=3Dm
CONFIG_BMP280_SPI=3Dm
CONFIG_IIO_CROS_EC_BARO=3Dm
CONFIG_DLHL60D=3Dm
CONFIG_DPS310=3Dm
CONFIG_HID_SENSOR_PRESS=3Dm
CONFIG_HP03=3Dm
CONFIG_MPL115=3Dm
CONFIG_MPL115_I2C=3Dm
CONFIG_MPL115_SPI=3Dm
CONFIG_MPL3115=3Dm
CONFIG_MS5611=3Dm
CONFIG_MS5611_I2C=3Dm
CONFIG_MS5611_SPI=3Dm
CONFIG_MS5637=3Dm
CONFIG_IIO_ST_PRESS=3Dm
CONFIG_IIO_ST_PRESS_I2C=3Dm
CONFIG_IIO_ST_PRESS_SPI=3Dm
CONFIG_T5403=3Dm
CONFIG_HP206C=3Dm
CONFIG_ZPA2326=3Dm
CONFIG_ZPA2326_I2C=3Dm
CONFIG_ZPA2326_SPI=3Dm
# end of Pressure sensors

#
# Lightning sensors
#
CONFIG_AS3935=3Dm
# end of Lightning sensors

#
# Proximity and distance sensors
#
CONFIG_ISL29501=3Dm
CONFIG_LIDAR_LITE_V2=3Dm
CONFIG_MB1232=3Dm
CONFIG_PING=3Dm
CONFIG_RFD77402=3Dm
CONFIG_SRF04=3Dm
CONFIG_SX9500=3Dm
CONFIG_SRF08=3Dm
CONFIG_VL53L0X_I2C=3Dm
# end of Proximity and distance sensors

#
# Resolver to digital converters
#
CONFIG_AD2S90=3Dm
CONFIG_AD2S1200=3Dm
# end of Resolver to digital converters

#
# Temperature sensors
#
CONFIG_LTC2983=3Dm
CONFIG_MAXIM_THERMOCOUPLE=3Dm
CONFIG_HID_SENSOR_TEMP=3Dm
CONFIG_MLX90614=3Dm
CONFIG_MLX90632=3Dm
CONFIG_TMP006=3Dm
CONFIG_TMP007=3Dm
CONFIG_TSYS01=3Dm
CONFIG_TSYS02D=3Dm
CONFIG_MAX31856=3Dm
# end of Temperature sensors

CONFIG_NTB=3Dm
CONFIG_NTB_MSI=3Dy
CONFIG_NTB_AMD=3Dm
CONFIG_NTB_IDT=3Dm
CONFIG_NTB_INTEL=3Dm
CONFIG_NTB_SWITCHTEC=3Dm
# CONFIG_NTB_PINGPONG is not set
# CONFIG_NTB_TOOL is not set
# CONFIG_NTB_PERF is not set
# CONFIG_NTB_MSI_TEST is not set
CONFIG_NTB_TRANSPORT=3Dm
CONFIG_VME_BUS=3Dy

#
# VME Bridge Drivers
#
CONFIG_VME_CA91CX42=3Dm
CONFIG_VME_TSI148=3Dm
# CONFIG_VME_FAKE is not set

#
# VME Board Drivers
#
CONFIG_VMIVME_7805=3Dm

#
# VME Device Drivers
#
CONFIG_VME_USER=3Dm
CONFIG_PWM=3Dy
CONFIG_PWM_SYSFS=3Dy
CONFIG_PWM_ATMEL_HLCDC_PWM=3Dm
CONFIG_PWM_CRC=3Dy
CONFIG_PWM_CROS_EC=3Dm
CONFIG_PWM_FSL_FTM=3Dm
CONFIG_PWM_LP3943=3Dm
CONFIG_PWM_LPSS=3Dm
CONFIG_PWM_LPSS_PCI=3Dm
CONFIG_PWM_LPSS_PLATFORM=3Dm
CONFIG_PWM_PCA9685=3Dm
CONFIG_PWM_STMPE=3Dy
CONFIG_PWM_TWL=3Dm
CONFIG_PWM_TWL_LED=3Dm

#
# IRQ chip support
#
CONFIG_IRQCHIP=3Dy
CONFIG_AL_FIC=3Dy
CONFIG_MADERA_IRQ=3Dm
# end of IRQ chip support

CONFIG_IPACK_BUS=3Dm
CONFIG_BOARD_TPCI200=3Dm
CONFIG_SERIAL_IPOCTAL=3Dm
CONFIG_RESET_CONTROLLER=3Dy
CONFIG_RESET_BRCMSTB_RESCAL=3Dy
CONFIG_RESET_INTEL_GW=3Dy
CONFIG_RESET_TI_SYSCON=3Dm

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=3Dy
CONFIG_GENERIC_PHY_MIPI_DPHY=3Dy
CONFIG_BCM_KONA_USB2_PHY=3Dm
CONFIG_PHY_CADENCE_DP=3Dm
CONFIG_PHY_CADENCE_DPHY=3Dm
CONFIG_PHY_CADENCE_SIERRA=3Dm
CONFIG_PHY_FSL_IMX8MQ_USB=3Dm
CONFIG_PHY_MIXEL_MIPI_DPHY=3Dm
CONFIG_PHY_PXA_28NM_HSIC=3Dm
CONFIG_PHY_PXA_28NM_USB2=3Dm
CONFIG_PHY_CPCAP_USB=3Dm
CONFIG_PHY_MAPPHONE_MDM6600=3Dm
CONFIG_PHY_OCELOT_SERDES=3Dm
CONFIG_PHY_QCOM_USB_HS=3Dm
CONFIG_PHY_QCOM_USB_HSIC=3Dm
CONFIG_PHY_SAMSUNG_USB2=3Dm
CONFIG_PHY_TUSB1210=3Dm
CONFIG_PHY_INTEL_EMMC=3Dm
# end of PHY Subsystem

CONFIG_POWERCAP=3Dy
CONFIG_INTEL_RAPL_CORE=3Dm
CONFIG_INTEL_RAPL=3Dm
CONFIG_IDLE_INJECT=3Dy
CONFIG_MCB=3Dm
CONFIG_MCB_PCI=3Dm
CONFIG_MCB_LPC=3Dm

#
# Performance monitor support
#
# end of Performance monitor support

CONFIG_RAS=3Dy
CONFIG_RAS_CEC=3Dy
# CONFIG_RAS_CEC_DEBUG is not set
CONFIG_USB4=3Dm

#
# Android
#
# CONFIG_ANDROID is not set
# end of Android

CONFIG_LIBNVDIMM=3Dy
CONFIG_BLK_DEV_PMEM=3Dm
CONFIG_ND_BLK=3Dm
CONFIG_ND_CLAIM=3Dy
CONFIG_ND_BTT=3Dm
CONFIG_BTT=3Dy
CONFIG_ND_PFN=3Dm
CONFIG_NVDIMM_PFN=3Dy
CONFIG_NVDIMM_DAX=3Dy
CONFIG_OF_PMEM=3Dm
CONFIG_DAX_DRIVER=3Dy
CONFIG_DAX=3Dy
CONFIG_DEV_DAX=3Dm
CONFIG_DEV_DAX_PMEM=3Dm
CONFIG_DEV_DAX_HMEM=3Dm
CONFIG_DEV_DAX_KMEM=3Dm
CONFIG_DEV_DAX_PMEM_COMPAT=3Dm
CONFIG_NVMEM=3Dy
CONFIG_NVMEM_SYSFS=3Dy
CONFIG_NVMEM_SPMI_SDAM=3Dm
CONFIG_RAVE_SP_EEPROM=3Dm

#
# HW tracing support
#
CONFIG_STM=3Dm
CONFIG_STM_PROTO_BASIC=3Dm
CONFIG_STM_PROTO_SYS_T=3Dm
# CONFIG_STM_DUMMY is not set
CONFIG_STM_SOURCE_CONSOLE=3Dm
CONFIG_STM_SOURCE_HEARTBEAT=3Dm
CONFIG_STM_SOURCE_FTRACE=3Dm
CONFIG_INTEL_TH=3Dm
CONFIG_INTEL_TH_PCI=3Dm
CONFIG_INTEL_TH_ACPI=3Dm
CONFIG_INTEL_TH_GTH=3Dm
CONFIG_INTEL_TH_STH=3Dm
CONFIG_INTEL_TH_MSU=3Dm
CONFIG_INTEL_TH_PTI=3Dm
# CONFIG_INTEL_TH_DEBUG is not set
# end of HW tracing support

CONFIG_FPGA=3Dm
CONFIG_ALTERA_PR_IP_CORE=3Dm
CONFIG_ALTERA_PR_IP_CORE_PLAT=3Dm
CONFIG_FPGA_MGR_ALTERA_PS_SPI=3Dm
CONFIG_FPGA_MGR_ALTERA_CVP=3Dm
CONFIG_FPGA_MGR_XILINX_SPI=3Dm
CONFIG_FPGA_MGR_ICE40_SPI=3Dm
CONFIG_FPGA_MGR_MACHXO2_SPI=3Dm
CONFIG_FPGA_BRIDGE=3Dm
CONFIG_ALTERA_FREEZE_BRIDGE=3Dm
CONFIG_XILINX_PR_DECOUPLER=3Dm
CONFIG_FPGA_REGION=3Dm
CONFIG_OF_FPGA_REGION=3Dm
CONFIG_FPGA_DFL=3Dm
CONFIG_FPGA_DFL_FME=3Dm
CONFIG_FPGA_DFL_FME_MGR=3Dm
CONFIG_FPGA_DFL_FME_BRIDGE=3Dm
CONFIG_FPGA_DFL_FME_REGION=3Dm
CONFIG_FPGA_DFL_AFU=3Dm
CONFIG_FPGA_DFL_PCI=3Dm
CONFIG_FSI=3Dm
CONFIG_FSI_NEW_DEV_NODE=3Dy
CONFIG_FSI_MASTER_GPIO=3Dm
CONFIG_FSI_MASTER_HUB=3Dm
CONFIG_FSI_MASTER_ASPEED=3Dm
CONFIG_FSI_SCOM=3Dm
CONFIG_FSI_SBEFIFO=3Dm
CONFIG_FSI_OCC=3Dm
CONFIG_TEE=3Dm

#
# TEE drivers
#
CONFIG_AMDTEE=3Dm
# end of TEE drivers

CONFIG_MULTIPLEXER=3Dm

#
# Multiplexer drivers
#
CONFIG_MUX_ADG792A=3Dm
CONFIG_MUX_ADGS1408=3Dm
CONFIG_MUX_GPIO=3Dm
CONFIG_MUX_MMIO=3Dm
# end of Multiplexer drivers

CONFIG_PM_OPP=3Dy
CONFIG_UNISYS_VISORBUS=3Dm
CONFIG_SIOX=3Dm
CONFIG_SIOX_BUS_GPIO=3Dm
CONFIG_SLIMBUS=3Dm
CONFIG_SLIM_QCOM_CTRL=3Dm
CONFIG_INTERCONNECT=3Dm
CONFIG_COUNTER=3Dm
CONFIG_FTM_QUADDEC=3Dm
# end of Device Drivers

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=3Dy
CONFIG_VALIDATE_FS_PARSER=3Dy
CONFIG_FS_IOMAP=3Dy
# CONFIG_EXT2_FS is not set
# CONFIG_EXT3_FS is not set
CONFIG_EXT4_FS=3Dm
CONFIG_EXT4_USE_FOR_EXT2=3Dy
CONFIG_EXT4_FS_POSIX_ACL=3Dy
CONFIG_EXT4_FS_SECURITY=3Dy
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=3Dm
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=3Dm
CONFIG_REISERFS_FS=3Dm
# CONFIG_REISERFS_CHECK is not set
CONFIG_REISERFS_PROC_INFO=3Dy
CONFIG_REISERFS_FS_XATTR=3Dy
CONFIG_REISERFS_FS_POSIX_ACL=3Dy
CONFIG_REISERFS_FS_SECURITY=3Dy
CONFIG_JFS_FS=3Dm
CONFIG_JFS_POSIX_ACL=3Dy
CONFIG_JFS_SECURITY=3Dy
# CONFIG_JFS_DEBUG is not set
CONFIG_JFS_STATISTICS=3Dy
CONFIG_XFS_FS=3Dm
CONFIG_XFS_QUOTA=3Dy
CONFIG_XFS_POSIX_ACL=3Dy
CONFIG_XFS_RT=3Dy
CONFIG_XFS_ONLINE_SCRUB=3Dy
CONFIG_XFS_ONLINE_REPAIR=3Dy
# CONFIG_XFS_WARN is not set
# CONFIG_XFS_DEBUG is not set
CONFIG_GFS2_FS=3Dm
CONFIG_GFS2_FS_LOCKING_DLM=3Dy
CONFIG_OCFS2_FS=3Dm
CONFIG_OCFS2_FS_O2CB=3Dm
CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
CONFIG_OCFS2_FS_STATS=3Dy
CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
# CONFIG_OCFS2_DEBUG_FS is not set
CONFIG_BTRFS_FS=3Dm
CONFIG_BTRFS_FS_POSIX_ACL=3Dy
# CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
# CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
# CONFIG_BTRFS_DEBUG is not set
# CONFIG_BTRFS_ASSERT is not set
# CONFIG_BTRFS_FS_REF_VERIFY is not set
CONFIG_NILFS2_FS=3Dm
CONFIG_F2FS_FS=3Dm
CONFIG_F2FS_STAT_FS=3Dy
CONFIG_F2FS_FS_XATTR=3Dy
CONFIG_F2FS_FS_POSIX_ACL=3Dy
CONFIG_F2FS_FS_SECURITY=3Dy
CONFIG_F2FS_CHECK_FS=3Dy
# CONFIG_F2FS_IO_TRACE is not set
# CONFIG_F2FS_FAULT_INJECTION is not set
CONFIG_F2FS_FS_COMPRESSION=3Dy
CONFIG_F2FS_FS_LZO=3Dy
CONFIG_F2FS_FS_LZ4=3Dy
CONFIG_ZONEFS_FS=3Dm
CONFIG_FS_DAX=3Dy
CONFIG_FS_DAX_PMD=3Dy
CONFIG_FS_POSIX_ACL=3Dy
CONFIG_EXPORTFS=3Dy
CONFIG_EXPORTFS_BLOCK_OPS=3Dy
CONFIG_FILE_LOCKING=3Dy
# CONFIG_MANDATORY_FILE_LOCKING is not set
CONFIG_FS_ENCRYPTION=3Dy
CONFIG_FS_ENCRYPTION_ALGS=3Dm
CONFIG_FS_VERITY=3Dy
# CONFIG_FS_VERITY_DEBUG is not set
CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dy
CONFIG_FSNOTIFY=3Dy
CONFIG_DNOTIFY=3Dy
CONFIG_INOTIFY_USER=3Dy
CONFIG_FANOTIFY=3Dy
CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
CONFIG_QUOTA=3Dy
CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
# CONFIG_PRINT_QUOTA_WARNING is not set
# CONFIG_QUOTA_DEBUG is not set
CONFIG_QUOTA_TREE=3Dm
CONFIG_QFMT_V1=3Dm
CONFIG_QFMT_V2=3Dm
CONFIG_QUOTACTL=3Dy
CONFIG_QUOTACTL_COMPAT=3Dy
CONFIG_AUTOFS4_FS=3Dy
CONFIG_AUTOFS_FS=3Dy
CONFIG_FUSE_FS=3Dm
CONFIG_CUSE=3Dm
CONFIG_VIRTIO_FS=3Dm
CONFIG_OVERLAY_FS=3Dm
CONFIG_OVERLAY_FS_REDIRECT_DIR=3Dy
# CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
CONFIG_OVERLAY_FS_INDEX=3Dy
CONFIG_OVERLAY_FS_XINO_AUTO=3Dy
CONFIG_OVERLAY_FS_METACOPY=3Dy

#
# Caches
#
CONFIG_FSCACHE=3Dm
CONFIG_FSCACHE_STATS=3Dy
CONFIG_FSCACHE_HISTOGRAM=3Dy
# CONFIG_FSCACHE_DEBUG is not set
# CONFIG_FSCACHE_OBJECT_LIST is not set
CONFIG_CACHEFILES=3Dm
# CONFIG_CACHEFILES_DEBUG is not set
# CONFIG_CACHEFILES_HISTOGRAM is not set
# end of Caches

#
# CD-ROM/DVD Filesystems
#
CONFIG_ISO9660_FS=3Dm
CONFIG_JOLIET=3Dy
CONFIG_ZISOFS=3Dy
CONFIG_UDF_FS=3Dm
# end of CD-ROM/DVD Filesystems

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=3Dm
CONFIG_MSDOS_FS=3Dm
CONFIG_VFAT_FS=3Dm
CONFIG_FAT_DEFAULT_CODEPAGE=3D437
CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
CONFIG_FAT_DEFAULT_UTF8=3Dy
CONFIG_NTFS_FS=3Dm
# CONFIG_NTFS_DEBUG is not set
CONFIG_NTFS_RW=3Dy
# end of DOS/FAT/NT Filesystems

#
# Pseudo filesystems
#
CONFIG_PROC_FS=3Dy
CONFIG_PROC_KCORE=3Dy
CONFIG_PROC_VMCORE=3Dy
CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
CONFIG_PROC_SYSCTL=3Dy
CONFIG_PROC_PAGE_MONITOR=3Dy
CONFIG_PROC_CHILDREN=3Dy
CONFIG_PROC_PID_ARCH_STATUS=3Dy
CONFIG_PROC_CPU_RESCTRL=3Dy
CONFIG_KERNFS=3Dy
CONFIG_SYSFS=3Dy
CONFIG_TMPFS=3Dy
CONFIG_TMPFS_POSIX_ACL=3Dy
CONFIG_TMPFS_XATTR=3Dy
CONFIG_HUGETLBFS=3Dy
CONFIG_HUGETLB_PAGE=3Dy
CONFIG_MEMFD_CREATE=3Dy
CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
CONFIG_CONFIGFS_FS=3Dy
CONFIG_EFIVAR_FS=3Dy
# end of Pseudo filesystems

CONFIG_MISC_FILESYSTEMS=3Dy
CONFIG_ORANGEFS_FS=3Dm
# CONFIG_ADFS_FS is not set
CONFIG_AFFS_FS=3Dm
CONFIG_ECRYPT_FS=3Dm
# CONFIG_ECRYPT_FS_MESSAGING is not set
CONFIG_HFS_FS=3Dm
CONFIG_HFSPLUS_FS=3Dm
CONFIG_BEFS_FS=3Dm
# CONFIG_BEFS_DEBUG is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
CONFIG_JFFS2_FS=3Dm
CONFIG_JFFS2_FS_DEBUG=3D0
CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
CONFIG_JFFS2_SUMMARY=3Dy
CONFIG_JFFS2_FS_XATTR=3Dy
CONFIG_JFFS2_FS_POSIX_ACL=3Dy
CONFIG_JFFS2_FS_SECURITY=3Dy
# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
CONFIG_JFFS2_ZLIB=3Dy
CONFIG_JFFS2_RTIME=3Dy
CONFIG_UBIFS_FS=3Dm
# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
CONFIG_UBIFS_FS_LZO=3Dy
CONFIG_UBIFS_FS_ZLIB=3Dy
CONFIG_UBIFS_FS_ZSTD=3Dy
CONFIG_UBIFS_ATIME_SUPPORT=3Dy
CONFIG_UBIFS_FS_XATTR=3Dy
CONFIG_UBIFS_FS_SECURITY=3Dy
CONFIG_UBIFS_FS_AUTHENTICATION=3Dy
CONFIG_CRAMFS=3Dm
CONFIG_CRAMFS_BLOCKDEV=3Dy
CONFIG_CRAMFS_MTD=3Dy
CONFIG_SQUASHFS=3Dm
# CONFIG_SQUASHFS_FILE_CACHE is not set
CONFIG_SQUASHFS_FILE_DIRECT=3Dy
# CONFIG_SQUASHFS_DECOMP_SINGLE is not set
CONFIG_SQUASHFS_DECOMP_MULTI=3Dy
# CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
CONFIG_SQUASHFS_XATTR=3Dy
CONFIG_SQUASHFS_ZLIB=3Dy
CONFIG_SQUASHFS_LZ4=3Dy
CONFIG_SQUASHFS_LZO=3Dy
CONFIG_SQUASHFS_XZ=3Dy
CONFIG_SQUASHFS_ZSTD=3Dy
# CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
# CONFIG_SQUASHFS_EMBEDDED is not set
CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
# CONFIG_VXFS_FS is not set
CONFIG_MINIX_FS=3Dm
CONFIG_OMFS_FS=3Dm
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=3Dm
CONFIG_ROMFS_BACKED_BY_BLOCK=3Dy
# CONFIG_ROMFS_BACKED_BY_MTD is not set
# CONFIG_ROMFS_BACKED_BY_BOTH is not set
CONFIG_ROMFS_ON_BLOCK=3Dy
CONFIG_PSTORE=3Dy
CONFIG_PSTORE_DEFLATE_COMPRESS=3Dm
CONFIG_PSTORE_LZO_COMPRESS=3Dm
CONFIG_PSTORE_LZ4_COMPRESS=3Dm
CONFIG_PSTORE_LZ4HC_COMPRESS=3Dm
# CONFIG_PSTORE_842_COMPRESS is not set
CONFIG_PSTORE_ZSTD_COMPRESS=3Dy
CONFIG_PSTORE_COMPRESS=3Dy
# CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZO_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4_COMPRESS_DEFAULT is not set
# CONFIG_PSTORE_LZ4HC_COMPRESS_DEFAULT is not set
CONFIG_PSTORE_ZSTD_COMPRESS_DEFAULT=3Dy
CONFIG_PSTORE_COMPRESS_DEFAULT=3D"zstd"
# CONFIG_PSTORE_CONSOLE is not set
# CONFIG_PSTORE_PMSG is not set
# CONFIG_PSTORE_FTRACE is not set
CONFIG_PSTORE_RAM=3Dy
# CONFIG_SYSV_FS is not set
CONFIG_UFS_FS=3Dm
# CONFIG_UFS_FS_WRITE is not set
# CONFIG_UFS_DEBUG is not set
CONFIG_EROFS_FS=3Dm
# CONFIG_EROFS_FS_DEBUG is not set
CONFIG_EROFS_FS_XATTR=3Dy
CONFIG_EROFS_FS_POSIX_ACL=3Dy
CONFIG_EROFS_FS_SECURITY=3Dy
CONFIG_EROFS_FS_ZIP=3Dy
CONFIG_EROFS_FS_CLUSTER_PAGE_LIMIT=3D2
CONFIG_VBOXSF_FS=3Dm
CONFIG_NETWORK_FILESYSTEMS=3Dy
CONFIG_NFS_FS=3Dm
CONFIG_NFS_V2=3Dm
CONFIG_NFS_V3=3Dm
CONFIG_NFS_V3_ACL=3Dy
CONFIG_NFS_V4=3Dm
CONFIG_NFS_SWAP=3Dy
CONFIG_NFS_V4_1=3Dy
CONFIG_NFS_V4_2=3Dy
CONFIG_PNFS_FILE_LAYOUT=3Dm
CONFIG_PNFS_BLOCK=3Dm
CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
CONFIG_NFS_V4_1_MIGRATION=3Dy
CONFIG_NFS_V4_SECURITY_LABEL=3Dy
CONFIG_NFS_FSCACHE=3Dy
# CONFIG_NFS_USE_LEGACY_DNS is not set
CONFIG_NFS_USE_KERNEL_DNS=3Dy
CONFIG_NFS_DEBUG=3Dy
# CONFIG_NFS_DISABLE_UDP_SUPPORT is not set
CONFIG_NFSD=3Dm
CONFIG_NFSD_V2_ACL=3Dy
CONFIG_NFSD_V3=3Dy
CONFIG_NFSD_V3_ACL=3Dy
CONFIG_NFSD_V4=3Dy
CONFIG_NFSD_PNFS=3Dy
CONFIG_NFSD_BLOCKLAYOUT=3Dy
CONFIG_NFSD_SCSILAYOUT=3Dy
# CONFIG_NFSD_FLEXFILELAYOUT is not set
CONFIG_NFSD_V4_2_INTER_SSC=3Dy
CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
CONFIG_GRACE_PERIOD=3Dm
CONFIG_LOCKD=3Dm
CONFIG_LOCKD_V4=3Dy
CONFIG_NFS_ACL_SUPPORT=3Dm
CONFIG_NFS_COMMON=3Dy
CONFIG_SUNRPC=3Dm
CONFIG_SUNRPC_GSS=3Dm
CONFIG_SUNRPC_BACKCHANNEL=3Dy
CONFIG_SUNRPC_SWAP=3Dy
CONFIG_RPCSEC_GSS_KRB5=3Dm
CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES=3Dy
CONFIG_SUNRPC_DEBUG=3Dy
CONFIG_SUNRPC_XPRT_RDMA=3Dm
CONFIG_CEPH_FS=3Dm
CONFIG_CEPH_FSCACHE=3Dy
CONFIG_CEPH_FS_POSIX_ACL=3Dy
CONFIG_CEPH_FS_SECURITY_LABEL=3Dy
CONFIG_CIFS=3Dm
# CONFIG_CIFS_STATS2 is not set
CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
# CONFIG_CIFS_WEAK_PW_HASH is not set
CONFIG_CIFS_UPCALL=3Dy
CONFIG_CIFS_XATTR=3Dy
CONFIG_CIFS_POSIX=3Dy
CONFIG_CIFS_DEBUG=3Dy
# CONFIG_CIFS_DEBUG2 is not set
# CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
CONFIG_CIFS_DFS_UPCALL=3Dy
# CONFIG_CIFS_SMB_DIRECT is not set
CONFIG_CIFS_FSCACHE=3Dy
CONFIG_CODA_FS=3Dm
CONFIG_AFS_FS=3Dm
# CONFIG_AFS_DEBUG is not set
CONFIG_AFS_FSCACHE=3Dy
# CONFIG_AFS_DEBUG_CURSOR is not set
CONFIG_9P_FS=3Dm
CONFIG_9P_FSCACHE=3Dy
CONFIG_9P_FS_POSIX_ACL=3Dy
CONFIG_9P_FS_SECURITY=3Dy
CONFIG_NLS=3Dy
CONFIG_NLS_DEFAULT=3D"utf8"
CONFIG_NLS_CODEPAGE_437=3Dm
CONFIG_NLS_CODEPAGE_737=3Dm
CONFIG_NLS_CODEPAGE_775=3Dm
CONFIG_NLS_CODEPAGE_850=3Dm
CONFIG_NLS_CODEPAGE_852=3Dm
CONFIG_NLS_CODEPAGE_855=3Dm
CONFIG_NLS_CODEPAGE_857=3Dm
CONFIG_NLS_CODEPAGE_860=3Dm
CONFIG_NLS_CODEPAGE_861=3Dm
CONFIG_NLS_CODEPAGE_862=3Dm
CONFIG_NLS_CODEPAGE_863=3Dm
CONFIG_NLS_CODEPAGE_864=3Dm
CONFIG_NLS_CODEPAGE_865=3Dm
CONFIG_NLS_CODEPAGE_866=3Dm
CONFIG_NLS_CODEPAGE_869=3Dm
CONFIG_NLS_CODEPAGE_936=3Dm
CONFIG_NLS_CODEPAGE_950=3Dm
CONFIG_NLS_CODEPAGE_932=3Dm
CONFIG_NLS_CODEPAGE_949=3Dm
CONFIG_NLS_CODEPAGE_874=3Dm
CONFIG_NLS_ISO8859_8=3Dm
CONFIG_NLS_CODEPAGE_1250=3Dm
CONFIG_NLS_CODEPAGE_1251=3Dm
CONFIG_NLS_ASCII=3Dm
CONFIG_NLS_ISO8859_1=3Dm
CONFIG_NLS_ISO8859_2=3Dm
CONFIG_NLS_ISO8859_3=3Dm
CONFIG_NLS_ISO8859_4=3Dm
CONFIG_NLS_ISO8859_5=3Dm
CONFIG_NLS_ISO8859_6=3Dm
CONFIG_NLS_ISO8859_7=3Dm
CONFIG_NLS_ISO8859_9=3Dm
CONFIG_NLS_ISO8859_13=3Dm
CONFIG_NLS_ISO8859_14=3Dm
CONFIG_NLS_ISO8859_15=3Dm
CONFIG_NLS_KOI8_R=3Dm
CONFIG_NLS_KOI8_U=3Dm
CONFIG_NLS_MAC_ROMAN=3Dm
CONFIG_NLS_MAC_CELTIC=3Dm
CONFIG_NLS_MAC_CENTEURO=3Dm
CONFIG_NLS_MAC_CROATIAN=3Dm
CONFIG_NLS_MAC_CYRILLIC=3Dm
CONFIG_NLS_MAC_GAELIC=3Dm
CONFIG_NLS_MAC_GREEK=3Dm
CONFIG_NLS_MAC_ICELAND=3Dm
CONFIG_NLS_MAC_INUIT=3Dm
CONFIG_NLS_MAC_ROMANIAN=3Dm
CONFIG_NLS_MAC_TURKISH=3Dm
CONFIG_NLS_UTF8=3Dm
CONFIG_DLM=3Dm
# CONFIG_DLM_DEBUG is not set
CONFIG_UNICODE=3Dy
# CONFIG_UNICODE_NORMALIZATION_SELFTEST is not set
CONFIG_IO_WQ=3Dy
# end of File systems

#
# Security options
#
CONFIG_KEYS=3Dy
CONFIG_KEYS_REQUEST_CACHE=3Dy
CONFIG_PERSISTENT_KEYRINGS=3Dy
CONFIG_BIG_KEYS=3Dy
CONFIG_TRUSTED_KEYS=3Dm
CONFIG_ENCRYPTED_KEYS=3Dm
CONFIG_KEY_DH_OPERATIONS=3Dy
# CONFIG_SECURITY_DMESG_RESTRICT is not set
CONFIG_SECURITY=3Dy
CONFIG_SECURITYFS=3Dy
CONFIG_SECURITY_NETWORK=3Dy
CONFIG_PAGE_TABLE_ISOLATION=3Dy
CONFIG_SECURITY_INFINIBAND=3Dy
CONFIG_SECURITY_NETWORK_XFRM=3Dy
CONFIG_SECURITY_PATH=3Dy
# CONFIG_INTEL_TXT is not set
CONFIG_LSM_MMAP_MIN_ADDR=3D65536
CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
CONFIG_HARDENED_USERCOPY=3Dy
CONFIG_HARDENED_USERCOPY_FALLBACK=3Dy
# CONFIG_HARDENED_USERCOPY_PAGESPAN is not set
CONFIG_FORTIFY_SOURCE=3Dy
# CONFIG_STATIC_USERMODEHELPER is not set
CONFIG_SECURITY_SELINUX=3Dy
CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
# CONFIG_SECURITY_SELINUX_DISABLE is not set
CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D0
CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
CONFIG_SECURITY_SMACK=3Dy
CONFIG_SECURITY_SMACK_BRINGUP=3Dy
CONFIG_SECURITY_SMACK_NETFILTER=3Dy
CONFIG_SECURITY_SMACK_APPEND_SIGNALS=3Dy
CONFIG_SECURITY_TOMOYO=3Dy
CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D2048
CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D1024
# CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER is not set
CONFIG_SECURITY_TOMOYO_POLICY_LOADER=3D"/sbin/tomoyo-init"
CONFIG_SECURITY_TOMOYO_ACTIVATION_TRIGGER=3D"/sbin/init"
# CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING is not set
CONFIG_SECURITY_APPARMOR=3Dy
CONFIG_SECURITY_APPARMOR_HASH=3Dy
CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
# CONFIG_SECURITY_APPARMOR_DEBUG is not set
# CONFIG_SECURITY_LOADPIN is not set
CONFIG_SECURITY_YAMA=3Dy
CONFIG_SECURITY_SAFESETID=3Dy
CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
# CONFIG_SECURITY_LOCKDOWN_LSM_EARLY is not set
CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy
# CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
# CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
# CONFIG_INTEGRITY is not set
# CONFIG_DEFAULT_SECURITY_SELINUX is not set
# CONFIG_DEFAULT_SECURITY_SMACK is not set
# CONFIG_DEFAULT_SECURITY_TOMOYO is not set
# CONFIG_DEFAULT_SECURITY_APPARMOR is not set
CONFIG_DEFAULT_SECURITY_DAC=3Dy
CONFIG_LSM=3D"lockdown,yama"

#
# Kernel hardening options
#
CONFIG_GCC_PLUGIN_STRUCTLEAK=3Dy

#
# Memory initialization
#
# CONFIG_INIT_STACK_NONE is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
# CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL=3Dy
# CONFIG_GCC_PLUGIN_STRUCTLEAK_VERBOSE is not set
# CONFIG_GCC_PLUGIN_STACKLEAK is not set
CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
# CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
# end of Memory initialization
# end of Kernel hardening options
# end of Security options

CONFIG_XOR_BLOCKS=3Dm
CONFIG_ASYNC_CORE=3Dm
CONFIG_ASYNC_MEMCPY=3Dm
CONFIG_ASYNC_XOR=3Dm
CONFIG_ASYNC_PQ=3Dm
CONFIG_ASYNC_RAID6_RECOV=3Dm
CONFIG_CRYPTO=3Dy

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=3Dy
CONFIG_CRYPTO_ALGAPI2=3Dy
CONFIG_CRYPTO_AEAD=3Dy
CONFIG_CRYPTO_AEAD2=3Dy
CONFIG_CRYPTO_SKCIPHER=3Dy
CONFIG_CRYPTO_SKCIPHER2=3Dy
CONFIG_CRYPTO_HASH=3Dy
CONFIG_CRYPTO_HASH2=3Dy
CONFIG_CRYPTO_RNG=3Dy
CONFIG_CRYPTO_RNG2=3Dy
CONFIG_CRYPTO_RNG_DEFAULT=3Dy
CONFIG_CRYPTO_AKCIPHER2=3Dy
CONFIG_CRYPTO_AKCIPHER=3Dy
CONFIG_CRYPTO_KPP2=3Dy
CONFIG_CRYPTO_KPP=3Dy
CONFIG_CRYPTO_ACOMP2=3Dy
CONFIG_CRYPTO_MANAGER=3Dy
CONFIG_CRYPTO_MANAGER2=3Dy
CONFIG_CRYPTO_USER=3Dm
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
CONFIG_CRYPTO_GF128MUL=3Dy
CONFIG_CRYPTO_NULL=3Dy
CONFIG_CRYPTO_NULL2=3Dy
CONFIG_CRYPTO_PCRYPT=3Dm
CONFIG_CRYPTO_CRYPTD=3Dm
CONFIG_CRYPTO_AUTHENC=3Dm
CONFIG_CRYPTO_TEST=3Dm
CONFIG_CRYPTO_SIMD=3Dm
CONFIG_CRYPTO_GLUE_HELPER_X86=3Dm
CONFIG_CRYPTO_ENGINE=3Dm

#
# Public-key cryptography
#
CONFIG_CRYPTO_RSA=3Dy
CONFIG_CRYPTO_DH=3Dy
CONFIG_CRYPTO_ECC=3Dm
CONFIG_CRYPTO_ECDH=3Dm
CONFIG_CRYPTO_ECRDSA=3Dm
CONFIG_CRYPTO_CURVE25519=3Dm
CONFIG_CRYPTO_CURVE25519_X86=3Dm

#
# Authenticated Encryption with Associated Data
#
CONFIG_CRYPTO_CCM=3Dm
CONFIG_CRYPTO_GCM=3Dy
CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
CONFIG_CRYPTO_AEGIS128=3Dm
CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=3Dm
CONFIG_CRYPTO_SEQIV=3Dy
CONFIG_CRYPTO_ECHAINIV=3Dm

#
# Block modes
#
CONFIG_CRYPTO_CBC=3Dy
CONFIG_CRYPTO_CFB=3Dm
CONFIG_CRYPTO_CTR=3Dy
CONFIG_CRYPTO_CTS=3Dy
CONFIG_CRYPTO_ECB=3Dy
CONFIG_CRYPTO_LRW=3Dm
CONFIG_CRYPTO_OFB=3Dm
CONFIG_CRYPTO_PCBC=3Dm
CONFIG_CRYPTO_XTS=3Dy
CONFIG_CRYPTO_KEYWRAP=3Dm
CONFIG_CRYPTO_NHPOLY1305=3Dm
CONFIG_CRYPTO_NHPOLY1305_SSE2=3Dm
CONFIG_CRYPTO_NHPOLY1305_AVX2=3Dm
CONFIG_CRYPTO_ADIANTUM=3Dm
CONFIG_CRYPTO_ESSIV=3Dm

#
# Hash modes
#
CONFIG_CRYPTO_CMAC=3Dm
CONFIG_CRYPTO_HMAC=3Dy
CONFIG_CRYPTO_XCBC=3Dm
CONFIG_CRYPTO_VMAC=3Dm

#
# Digest
#
CONFIG_CRYPTO_CRC32C=3Dm
CONFIG_CRYPTO_CRC32C_INTEL=3Dm
CONFIG_CRYPTO_CRC32=3Dm
CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
CONFIG_CRYPTO_XXHASH=3Dm
CONFIG_CRYPTO_BLAKE2B=3Dm
CONFIG_CRYPTO_BLAKE2S=3Dm
CONFIG_CRYPTO_BLAKE2S_X86=3Dm
CONFIG_CRYPTO_CRCT10DIF=3Dy
CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
CONFIG_CRYPTO_GHASH=3Dy
CONFIG_CRYPTO_POLY1305=3Dm
CONFIG_CRYPTO_POLY1305_X86_64=3Dm
CONFIG_CRYPTO_MD4=3Dm
CONFIG_CRYPTO_MD5=3Dy
CONFIG_CRYPTO_MICHAEL_MIC=3Dm
CONFIG_CRYPTO_RMD128=3Dm
CONFIG_CRYPTO_RMD160=3Dm
CONFIG_CRYPTO_RMD256=3Dm
CONFIG_CRYPTO_RMD320=3Dm
CONFIG_CRYPTO_SHA1=3Dy
CONFIG_CRYPTO_SHA1_SSSE3=3Dm
CONFIG_CRYPTO_SHA256_SSSE3=3Dm
CONFIG_CRYPTO_SHA512_SSSE3=3Dm
CONFIG_CRYPTO_SHA256=3Dy
CONFIG_CRYPTO_SHA512=3Dy
CONFIG_CRYPTO_SHA3=3Dm
CONFIG_CRYPTO_SM3=3Dm
CONFIG_CRYPTO_STREEBOG=3Dm
CONFIG_CRYPTO_TGR192=3Dm
CONFIG_CRYPTO_WP512=3Dm
CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm

#
# Ciphers
#
CONFIG_CRYPTO_AES=3Dy
CONFIG_CRYPTO_AES_TI=3Dm
CONFIG_CRYPTO_AES_NI_INTEL=3Dm
CONFIG_CRYPTO_ANUBIS=3Dm
CONFIG_CRYPTO_ARC4=3Dm
CONFIG_CRYPTO_BLOWFISH=3Dm
CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA=3Dm
CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
CONFIG_CRYPTO_CAST_COMMON=3Dm
CONFIG_CRYPTO_CAST5=3Dm
CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
CONFIG_CRYPTO_CAST6=3Dm
CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
CONFIG_CRYPTO_DES=3Dm
CONFIG_CRYPTO_DES3_EDE_X86_64=3Dm
CONFIG_CRYPTO_FCRYPT=3Dm
CONFIG_CRYPTO_KHAZAD=3Dm
CONFIG_CRYPTO_SALSA20=3Dm
CONFIG_CRYPTO_CHACHA20=3Dm
CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
CONFIG_CRYPTO_SEED=3Dm
CONFIG_CRYPTO_SERPENT=3Dm
CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
CONFIG_CRYPTO_SM4=3Dm
CONFIG_CRYPTO_TEA=3Dm
CONFIG_CRYPTO_TWOFISH=3Dm
CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm

#
# Compression
#
CONFIG_CRYPTO_DEFLATE=3Dm
CONFIG_CRYPTO_LZO=3Dy
CONFIG_CRYPTO_842=3Dm
CONFIG_CRYPTO_LZ4=3Dm
CONFIG_CRYPTO_LZ4HC=3Dm
CONFIG_CRYPTO_ZSTD=3Dy

#
# Random Number Generation
#
CONFIG_CRYPTO_ANSI_CPRNG=3Dm
CONFIG_CRYPTO_DRBG_MENU=3Dy
CONFIG_CRYPTO_DRBG_HMAC=3Dy
CONFIG_CRYPTO_DRBG_HASH=3Dy
CONFIG_CRYPTO_DRBG_CTR=3Dy
CONFIG_CRYPTO_DRBG=3Dy
CONFIG_CRYPTO_JITTERENTROPY=3Dy
CONFIG_CRYPTO_USER_API=3Dm
CONFIG_CRYPTO_USER_API_HASH=3Dm
CONFIG_CRYPTO_USER_API_SKCIPHER=3Dm
CONFIG_CRYPTO_USER_API_RNG=3Dm
CONFIG_CRYPTO_USER_API_AEAD=3Dm
# CONFIG_CRYPTO_STATS is not set
CONFIG_CRYPTO_HASH_INFO=3Dy

#
# Crypto library routines
#
CONFIG_CRYPTO_LIB_AES=3Dy
CONFIG_CRYPTO_LIB_ARC4=3Dm
CONFIG_CRYPTO_ARCH_HAVE_LIB_BLAKE2S=3Dm
CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dm
CONFIG_CRYPTO_LIB_BLAKE2S=3Dm
CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dm
CONFIG_CRYPTO_LIB_CHACHA=3Dm
CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519=3Dm
CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=3Dm
CONFIG_CRYPTO_LIB_CURVE25519=3Dm
CONFIG_CRYPTO_LIB_DES=3Dm
CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dm
CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dm
CONFIG_CRYPTO_LIB_POLY1305=3Dm
CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dm
CONFIG_CRYPTO_LIB_SHA256=3Dy
CONFIG_CRYPTO_HW=3Dy
CONFIG_CRYPTO_DEV_PADLOCK=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
CONFIG_CRYPTO_DEV_ATMEL_I2C=3Dm
CONFIG_CRYPTO_DEV_ATMEL_ECC=3Dm
CONFIG_CRYPTO_DEV_ATMEL_SHA204A=3Dm
CONFIG_CRYPTO_DEV_CCP=3Dy
CONFIG_CRYPTO_DEV_CCP_DD=3Dm
CONFIG_CRYPTO_DEV_SP_CCP=3Dy
CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
CONFIG_CRYPTO_DEV_SP_PSP=3Dy
CONFIG_CRYPTO_DEV_CCP_DEBUGFS=3Dy
CONFIG_CRYPTO_DEV_QAT=3Dm
CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
CONFIG_CRYPTO_DEV_NITROX=3Dm
CONFIG_CRYPTO_DEV_NITROX_CNN55XX=3Dm
CONFIG_CRYPTO_DEV_CHELSIO=3Dm
CONFIG_CHELSIO_IPSEC_INLINE=3Dy
CONFIG_CRYPTO_DEV_VIRTIO=3Dm
CONFIG_CRYPTO_DEV_SAFEXCEL=3Dm
CONFIG_CRYPTO_DEV_CCREE=3Dm
CONFIG_CRYPTO_DEV_AMLOGIC_GXL=3Dm
CONFIG_CRYPTO_DEV_AMLOGIC_GXL_DEBUG=3Dy
CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE=3Dm
CONFIG_X509_CERTIFICATE_PARSER=3Dy
CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dm
CONFIG_TPM_KEY_PARSER=3Dm
CONFIG_PKCS7_MESSAGE_PARSER=3Dy
# CONFIG_PKCS7_TEST_KEY is not set
CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy

#
# Certificates for signature checking
#
CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
CONFIG_SYSTEM_TRUSTED_KEYS=3D""
# CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
# end of Certificates for signature checking

CONFIG_BINARY_PRINTF=3Dy

#
# Library routines
#
CONFIG_RAID6_PQ=3Dm
CONFIG_RAID6_PQ_BENCHMARK=3Dy
CONFIG_PACKING=3Dy
CONFIG_BITREVERSE=3Dy
CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
CONFIG_GENERIC_STRNLEN_USER=3Dy
CONFIG_GENERIC_NET_UTILS=3Dy
CONFIG_GENERIC_FIND_FIRST_BIT=3Dy
CONFIG_CORDIC=3Dm
CONFIG_RATIONAL=3Dy
CONFIG_GENERIC_PCI_IOMAP=3Dy
CONFIG_GENERIC_IOMAP=3Dy
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
CONFIG_CRC_CCITT=3Dy
CONFIG_CRC16=3Dm
CONFIG_CRC_T10DIF=3Dy
CONFIG_CRC_ITU_T=3Dm
CONFIG_CRC32=3Dy
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=3Dy
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
CONFIG_CRC64=3Dm
CONFIG_CRC4=3Dm
CONFIG_CRC7=3Dm
CONFIG_LIBCRC32C=3Dm
CONFIG_CRC8=3Dm
CONFIG_XXHASH=3Dy
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_842_COMPRESS=3Dm
CONFIG_842_DECOMPRESS=3Dm
CONFIG_ZLIB_INFLATE=3Dy
CONFIG_ZLIB_DEFLATE=3Dy
CONFIG_LZO_COMPRESS=3Dy
CONFIG_LZO_DECOMPRESS=3Dy
CONFIG_LZ4_COMPRESS=3Dy
CONFIG_LZ4HC_COMPRESS=3Dm
CONFIG_LZ4_DECOMPRESS=3Dy
CONFIG_ZSTD_COMPRESS=3Dy
CONFIG_ZSTD_DECOMPRESS=3Dy
CONFIG_XZ_DEC=3Dy
CONFIG_XZ_DEC_X86=3Dy
CONFIG_XZ_DEC_POWERPC=3Dy
CONFIG_XZ_DEC_IA64=3Dy
CONFIG_XZ_DEC_ARM=3Dy
CONFIG_XZ_DEC_ARMTHUMB=3Dy
CONFIG_XZ_DEC_SPARC=3Dy
CONFIG_XZ_DEC_BCJ=3Dy
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=3Dy
CONFIG_DECOMPRESS_BZIP2=3Dy
CONFIG_DECOMPRESS_LZMA=3Dy
CONFIG_DECOMPRESS_XZ=3Dy
CONFIG_DECOMPRESS_LZO=3Dy
CONFIG_DECOMPRESS_LZ4=3Dy
CONFIG_GENERIC_ALLOCATOR=3Dy
CONFIG_REED_SOLOMON=3Dy
CONFIG_REED_SOLOMON_ENC8=3Dy
CONFIG_REED_SOLOMON_DEC8=3Dy
CONFIG_REED_SOLOMON_DEC16=3Dy
CONFIG_BCH=3Dm
CONFIG_TEXTSEARCH=3Dy
CONFIG_TEXTSEARCH_KMP=3Dm
CONFIG_TEXTSEARCH_BM=3Dm
CONFIG_TEXTSEARCH_FSM=3Dm
CONFIG_BTREE=3Dy
CONFIG_INTERVAL_TREE=3Dy
CONFIG_XARRAY_MULTI=3Dy
CONFIG_ASSOCIATIVE_ARRAY=3Dy
CONFIG_HAS_IOMEM=3Dy
CONFIG_HAS_IOPORT_MAP=3Dy
CONFIG_HAS_DMA=3Dy
CONFIG_NEED_SG_DMA_LENGTH=3Dy
CONFIG_NEED_DMA_MAP_STATE=3Dy
CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
CONFIG_ARCH_HAS_FORCE_DMA_UNENCRYPTED=3Dy
CONFIG_DMA_VIRT_OPS=3Dy
CONFIG_SWIOTLB=3Dy
# CONFIG_DMA_API_DEBUG is not set
CONFIG_SGL_ALLOC=3Dy
CONFIG_IOMMU_HELPER=3Dy
CONFIG_CHECK_SIGNATURE=3Dy
CONFIG_CPU_RMAP=3Dy
CONFIG_DQL=3Dy
CONFIG_GLOB=3Dy
# CONFIG_GLOB_SELFTEST is not set
CONFIG_NLATTR=3Dy
CONFIG_LRU_CACHE=3Dm
CONFIG_CLZ_TAB=3Dy
CONFIG_IRQ_POLL=3Dy
CONFIG_MPILIB=3Dy
CONFIG_DIMLIB=3Dy
CONFIG_LIBFDT=3Dy
CONFIG_OID_REGISTRY=3Dy
CONFIG_UCS2_STRING=3Dy
CONFIG_HAVE_GENERIC_VDSO=3Dy
CONFIG_GENERIC_GETTIMEOFDAY=3Dy
CONFIG_GENERIC_VDSO_TIME_NS=3Dy
CONFIG_FONT_SUPPORT=3Dy
CONFIG_FONTS=3Dy
# CONFIG_FONT_8x8 is not set
CONFIG_FONT_8x16=3Dy
# CONFIG_FONT_6x11 is not set
# CONFIG_FONT_7x14 is not set
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
CONFIG_FONT_TER16x32=3Dy
CONFIG_SG_POOL=3Dy
CONFIG_ARCH_HAS_PMEM_API=3Dy
CONFIG_MEMREGION=3Dy
CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
CONFIG_ARCH_HAS_UACCESS_MCSAFE=3Dy
CONFIG_ARCH_STACKWALK=3Dy
CONFIG_SBITMAP=3Dy
CONFIG_PARMAN=3Dm
CONFIG_OBJAGG=3Dm
# CONFIG_STRING_SELFTEST is not set
# end of Library routines

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=3Dy
# CONFIG_PRINTK_CALLER is not set
CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D4
CONFIG_CONSOLE_LOGLEVEL_QUIET=3D1
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=3Dy
CONFIG_SYMBOLIC_ERRNAME=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
# end of printk and dmesg options

#
# Compile-time checks and compiler options
#
# CONFIG_DEBUG_INFO is not set
# CONFIG_ENABLE_MUST_CHECK is not set
CONFIG_FRAME_WARN=3D2048
CONFIG_STRIP_ASM_SYMS=3Dy
# CONFIG_READABLE_ASM is not set
# CONFIG_HEADERS_INSTALL is not set
CONFIG_OPTIMIZE_INLINING=3Dy
# CONFIG_DEBUG_SECTION_MISMATCH is not set
CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
CONFIG_STACK_VALIDATION=3Dy
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
# end of Compile-time checks and compiler options

#
# Generic Kernel Debugging Instruments
#
CONFIG_MAGIC_SYSRQ=3Dy
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x0
CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
CONFIG_DEBUG_FS=3Dy
CONFIG_HAVE_ARCH_KGDB=3Dy
# CONFIG_KGDB is not set
CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
# CONFIG_UBSAN is not set
CONFIG_UBSAN_ALIGNMENT=3Dy
# end of Generic Kernel Debugging Instruments

CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_MISC=3Dy

#
# Memory Debugging
#
# CONFIG_PAGE_EXTENSION is not set
# CONFIG_DEBUG_PAGEALLOC is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_PAGE_POISONING=3Dy
CONFIG_PAGE_POISONING_NO_SANITY=3Dy
CONFIG_PAGE_POISONING_ZERO=3Dy
# CONFIG_DEBUG_PAGE_REF is not set
# CONFIG_DEBUG_RODATA_TEST is not set
CONFIG_GENERIC_PTDUMP=3Dy
CONFIG_PTDUMP_CORE=3Dy
# CONFIG_PTDUMP_DEBUGFS is not set
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
CONFIG_SCHED_STACK_END_CHECK=3Dy
# CONFIG_DEBUG_VM is not set
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
# CONFIG_DEBUG_VIRTUAL is not set
CONFIG_DEBUG_MEMORY_INIT=3Dy
# CONFIG_DEBUG_PER_CPU_MAPS is not set
CONFIG_HAVE_ARCH_KASAN=3Dy
CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
CONFIG_CC_HAS_KASAN_GENERIC=3Dy
# CONFIG_KASAN is not set
CONFIG_KASAN_STACK=3D1
# end of Memory Debugging

# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Oops, Lockups and Hangs
#
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=3D0
CONFIG_PANIC_TIMEOUT=3D0
CONFIG_LOCKUP_DETECTOR=3Dy
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
CONFIG_HARDLOCKUP_DETECTOR=3Dy
# CONFIG_BOOTPARAM_HARDLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D0
CONFIG_DETECT_HUNG_TASK=3Dy
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
# CONFIG_WQ_WATCHDOG is not set
# end of Debug Oops, Lockups and Hangs

#
# Scheduler Debugging
#
CONFIG_SCHED_DEBUG=3Dy
CONFIG_SCHED_INFO=3Dy
CONFIG_SCHEDSTATS=3Dy
# end of Scheduler Debugging

# CONFIG_DEBUG_TIMEKEEPING is not set
CONFIG_DEBUG_PREEMPT=3Dy

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
# CONFIG_PROVE_LOCKING is not set
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_RT_MUTEXES is not set
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_MUTEXES is not set
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
# CONFIG_DEBUG_RWSEMS is not set
# CONFIG_DEBUG_LOCK_ALLOC is not set
# CONFIG_DEBUG_ATOMIC_SLEEP is not set
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
# CONFIG_WW_MUTEX_SELFTEST is not set
# end of Lock Debugging (spinlocks, mutexes, etc...)

CONFIG_STACKTRACE=3Dy
# CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
# CONFIG_DEBUG_KOBJECT is not set

#
# Debug kernel data structures
#
# CONFIG_DEBUG_LIST is not set
# CONFIG_DEBUG_PLIST is not set
# CONFIG_DEBUG_SG is not set
# CONFIG_DEBUG_NOTIFIERS is not set
# CONFIG_BUG_ON_DATA_CORRUPTION is not set
# end of Debug kernel data structures

# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
# CONFIG_RCU_PERF_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# end of RCU Debugging

# CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
CONFIG_LATENCYTOP=3Dy
CONFIG_USER_STACKTRACE_SUPPORT=3Dy
CONFIG_NOP_TRACER=3Dy
CONFIG_HAVE_FUNCTION_TRACER=3Dy
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
CONFIG_HAVE_FENTRY=3Dy
CONFIG_HAVE_C_RECORDMCOUNT=3Dy
CONFIG_TRACER_MAX_TRACE=3Dy
CONFIG_TRACE_CLOCK=3Dy
CONFIG_RING_BUFFER=3Dy
CONFIG_EVENT_TRACING=3Dy
CONFIG_CONTEXT_SWITCH_TRACER=3Dy
CONFIG_RING_BUFFER_ALLOW_SWAP=3Dy
CONFIG_TRACING=3Dy
CONFIG_GENERIC_TRACER=3Dy
CONFIG_TRACING_SUPPORT=3Dy
CONFIG_FTRACE=3Dy
# CONFIG_BOOTTIME_TRACING is not set
CONFIG_FUNCTION_TRACER=3Dy
CONFIG_FUNCTION_GRAPH_TRACER=3Dy
CONFIG_DYNAMIC_FTRACE=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
CONFIG_FUNCTION_PROFILER=3Dy
CONFIG_STACK_TRACER=3Dy
# CONFIG_PREEMPTIRQ_EVENTS is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
CONFIG_SCHED_TRACER=3Dy
CONFIG_HWLAT_TRACER=3Dy
CONFIG_MMIOTRACE=3Dy
CONFIG_FTRACE_SYSCALLS=3Dy
CONFIG_TRACER_SNAPSHOT=3Dy
# CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
CONFIG_BRANCH_PROFILE_NONE=3Dy
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
CONFIG_BLK_DEV_IO_TRACE=3Dy
CONFIG_KPROBE_EVENTS=3Dy
# CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
CONFIG_UPROBE_EVENTS=3Dy
CONFIG_BPF_EVENTS=3Dy
CONFIG_DYNAMIC_EVENTS=3Dy
CONFIG_PROBE_EVENTS=3Dy
CONFIG_BPF_KPROBE_OVERRIDE=3Dy
CONFIG_FTRACE_MCOUNT_RECORD=3Dy
CONFIG_TRACING_MAP=3Dy
CONFIG_HIST_TRIGGERS=3Dy
# CONFIG_TRACE_EVENT_INJECT is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set
# CONFIG_RING_BUFFER_BENCHMARK is not set
# CONFIG_TRACE_EVAL_MAP_FILE is not set
# CONFIG_FTRACE_STARTUP_TEST is not set
# CONFIG_RING_BUFFER_STARTUP_TEST is not set
# CONFIG_MMIOTRACE_TEST is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set
# CONFIG_SYNTH_EVENT_GEN_TEST is not set
# CONFIG_KPROBE_EVENT_GEN_TEST is not set
# CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
# CONFIG_SAMPLES is not set
CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
CONFIG_STRICT_DEVMEM=3Dy
CONFIG_IO_STRICT_DEVMEM=3Dy

#
# x86 Debugging
#
CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
# CONFIG_X86_VERBOSE_BOOTUP is not set
CONFIG_EARLY_PRINTK=3Dy
# CONFIG_EARLY_PRINTK_DBGP is not set
# CONFIG_EARLY_PRINTK_USB_XDBC is not set
# CONFIG_EFI_PGT_DUMP is not set
CONFIG_DEBUG_WX=3Dy
CONFIG_DOUBLEFAULT=3Dy
# CONFIG_DEBUG_TLBFLUSH is not set
# CONFIG_IOMMU_DEBUG is not set
CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
# CONFIG_X86_DECODER_SELFTEST is not set
CONFIG_IO_DELAY_0X80=3Dy
# CONFIG_IO_DELAY_0XED is not set
# CONFIG_IO_DELAY_UDELAY is not set
# CONFIG_IO_DELAY_NONE is not set
CONFIG_DEBUG_BOOT_PARAMS=3Dy
# CONFIG_CPA_DEBUG is not set
# CONFIG_DEBUG_ENTRY is not set
# CONFIG_DEBUG_NMI_SELFTEST is not set
# CONFIG_X86_DEBUG_FPU is not set
# CONFIG_PUNIT_ATOM_DEBUG is not set
CONFIG_UNWINDER_ORC=3Dy
# CONFIG_UNWINDER_FRAME_POINTER is not set
# CONFIG_UNWINDER_GUESS is not set
# end of x86 Debugging

#
# Kernel Testing and Coverage
#
# CONFIG_KUNIT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
CONFIG_FUNCTION_ERROR_INJECTION=3Dy
# CONFIG_FAULT_INJECTION is not set
CONFIG_ARCH_HAS_KCOV=3Dy
CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
# CONFIG_KCOV is not set
CONFIG_RUNTIME_TESTING_MENU=3Dy
CONFIG_LKDTM=3Dm
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_TEST_SORT is not set
# CONFIG_KPROBES_SANITY_TEST is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_REED_SOLOMON_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_ASYNC_RAID6_TEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_STRSCPY is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_PRINTF is not set
# CONFIG_TEST_BITMAP is not set
# CONFIG_TEST_BITFIELD is not set
# CONFIG_TEST_UUID is not set
# CONFIG_TEST_XARRAY is not set
# CONFIG_TEST_OVERFLOW is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_TEST_HASH is not set
# CONFIG_TEST_IDA is not set
# CONFIG_TEST_PARMAN is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_VMALLOC is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_BLACKHOLE_DEV is not set
# CONFIG_FIND_BIT_BENCHMARK is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_SYSCTL is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_TEST_KMOD is not set
# CONFIG_TEST_MEMCAT_P is not set
# CONFIG_TEST_OBJAGG is not set
# CONFIG_TEST_STACKINIT is not set
# CONFIG_TEST_MEMINIT is not set
# CONFIG_MEMTEST is not set
# CONFIG_HYPERV_TESTING is not set
# end of Kernel Testing and Coverage
# end of Kernel hacking
--=20
Bitte denken Sie an die Umwelt, bevor Sie diese E-Mail ausdrucken.
