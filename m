Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14ADEC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0FF20721
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="NlKKDWMO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgBCW0N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:26:13 -0500
Received: from mout.gmx.net ([212.227.17.21]:33845 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgBCW0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580768770;
        bh=AgLN+lJ0L+PWy2YQM8tqzAzPBjerQShki95L//N9cR4=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=NlKKDWMOOPYKsFzx9xQPFrrTxCimiqkmIuADCi5nNAMSgbS8ePZIQOjA2Sg4b3CNO
         I9DKg3J8jGleVdk9tXKTwZecJtjyPdzh4Qwf68sPsesLxhSeooE/m+CFvlUn4r55k8
         qa68Sqsv9ikcsuEuhC2ebaqy7nkZ3+ycY88BzUOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.24] ([77.0.210.224]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfHEJ-1jS0Fd1wuh-00gpcF for
 <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 23:26:10 +0100
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Autocrypt: addr=toralf.foerster@gmx.de; prefer-encrypt=mutual; keydata=
 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
To:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: kernel 5.5.1 : lost suddenly USB mouse + keyboard (<=5.4.17 was fine)
Message-ID: <48b10072-e1f8-e63b-2363-136d0023475d@gmx.de>
Date:   Mon, 3 Feb 2020 23:26:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aSeqV98chvA1daEyNoU6B/ohvvyo/48FZnNgI5QmJVqFrmigYDA
 95R489WZmH0zl1jm6J95Mdg+UvlrMSvuJGzmy6tgZbyAfnNImjC2dA2ZDgXDYypSJ+i0xV6
 eyDoKcu3sBmeJFOO+9yfJuprQhZNWlwzsxcFkv5Dd4mX1KbFvk18Ue2SFgUgkEr6wzkWVm9
 7XoA4NO2Rf3XjHTwcOnew==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RYlNuStDsSM=:OJKC2cTYfMxR5sIaQGznT7
 8dYoG7h9k3WIKfkqH/ddwY9l7+oKkFL0iUdvLRG08iJnVJ/ABtqQ5xUYVzMqfAlX6jnQYQh+E
 rXcZXdNZZuvZ/K6ZAkMwL/tJkscGCufPjNg99kIF7cGykK81EVGOVl3xkq2EhrOuWC7e5EFcH
 60QBVbVsGz4YkRov5TIWmaDxi6BMmvG61slJBAn1E6nexvS9psccVxNG5yMlqqv2Ey93wxmMn
 JRhvhcUPy8Z8zEkEbZYxem47yU3O/sBvLlBhRIkdVCdGMTXbUVL29/CUimcU621O20u42P137
 w6sId6kmLSxUJasO4qA3o+H0aOl3S1KjwfbET10Ol7U1Jf0XFkoXawBCibazXQV9Q/0Yl4HYE
 6hlX5abAt+KewzvJxijOzrAQnLo0heJMuq8V5HEg6AiKOdftCH3P9oKergEeQarpc6XAslZMX
 x3EIGSQ/SRkXmLkKqKejuaNnGlQuRXA6ZV7h99ey9IyJi4wmo6FeH4hINxQEFTGL94fCmOnvQ
 DWkEryCIj1RtoImc6v3YVzy9OtEktmdj47X+Do+KoMAt86F9DsMHgVHhmWlTOvK4Vm8X2o1/T
 Nx9XA/hSwrntPPd05HL1Hm0E5t5mHlAX1pACeig9CtxnEdz/ZkzNGWcSIW/h6eqdTlupRA3rZ
 EeOL3Y1h3w1/gvyQmTfcS4OWOoUuykzuZPGe4Sk1FtpC7//KOEPlyMmHlFKaGa85plR9+to14
 oKQz7ZYyTVjPrJKaGGPflVQWlvw1ffFK6m811HBVvoyQk5j1AJoxc/hd5NInljJpMhj42BUAX
 1W3rLmIr605FnGmw1D1pEr9GeX35S3YGEZOOPFugoFxcL5QnPT7ov2uXrdriWODILq922qUKs
 jVt02aYaa0FfwryN2KvhMs1UXN19+MRx0D0ipqEhZjmMe0oiHCY0c3+a7wXMXOT5a35Ucsi1K
 TW2I68DDa0l3bkW2H3NmaQABj6DqEoBEW2nEaBbulaqXkqh25stFseOeljhvdX6JRSpXz8yda
 6RwvYzQpmanWZHFWbffzsIL5jy2QxyrGP5i+47+tddk5PXn86bIwP/GgO05S9WRbca4/plin7
 eoN2OUwq5kZLXs3SlMx3nAl9GUSWgC+jXk+DWpeFLX52DM2pRnXN5OpfLN/CAQDxn56E2CwwE
 2SNh4ZoDuJ4OykDf4WcB4JrXo+46Eq0+UoOuk39qVDbWxSmDbvXgKOuASDUKrfyH30VQzxah0
 j6XB+2o57fyiP1uXZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

at a (5 year old) T440s  under a hardened Gentoo Linux I run 2x in the pas=
t 24 hours into a freeze for mouse and keyboard for this (docked) system:

	Linux t44 5.5.1 #6 SMP Sun Feb 2 17:25:06 CET 2020 x86_64 Intel(R) Core(T=
M) i5-4300U CPU @ 1.90GHz GenuineIntel GNU/Linux

The log says:

Feb  3 23:10:15 t44 kernel: Oops: 0010 [#1] SMP PTI
Feb  3 23:10:15 t44 kernel: CPU: 2 PID: 3405 Comm: X Tainted: G           =
     T 5.5.1 #6
Feb  3 23:10:15 t44 kernel: Hardware name: LENOVO 20AQCTO1WW/20AQCTO1WW, B=
IOS GJET92WW (2.42 ) 03/03/2017
Feb  3 23:10:15 t44 kernel: RIP: 0010:0x0
Feb  3 23:10:15 t44 kernel: Code: Bad RIP value.
Feb  3 23:10:15 t44 kernel: RSP: 0018:ffff9cc100be3a40 EFLAGS: 00010083
Feb  3 23:10:15 t44 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RC=
X: 0000000000382642
Feb  3 23:10:15 t44 kernel: RDX: 0000000000000000 RSI: ffff89b3d5674c88 RD=
I: ffff89b50d248480
Feb  3 23:10:15 t44 kernel: RBP: ffff89b50d248480 R08: 0000000000000000 R0=
9: ffff89b3d5674e80
Feb  3 23:10:15 t44 kernel: R10: 0000000000000002 R11: 0000000000000005 R1=
2: ffff9cc100be3a48
Feb  3 23:10:15 t44 kernel: R13: 0000000000000000 R14: ffff89b5a4b66400 R1=
5: ffff89b5a0761e40
Feb  3 23:10:15 t44 kernel: FS:  00007fb227b938c0(0000) GS:ffff89b5b270000=
0(0000) knlGS:0000000000000000
Feb  3 23:10:15 t44 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
Feb  3 23:10:15 t44 kernel: CR2: ffffffffffffffd6 CR3: 0000000323c76006 CR=
4: 00000000001606e0
Feb  3 23:10:15 t44 kernel: Call Trace:
Feb  3 23:10:15 t44 kernel:  dma_fence_signal_locked+0x85/0xc0
Feb  3 23:10:15 t44 kernel:  i915_request_retire+0x259/0x2a0 [i915]
Feb  3 23:10:15 t44 kernel:  i915_request_create+0x3f/0xc0 [i915]
Feb  3 23:10:15 t44 kernel:  i915_gem_do_execbuffer+0x973/0x17d0 [i915]
Feb  3 23:10:15 t44 kernel:  i915_gem_execbuffer2_ioctl+0xe9/0x3a0 [i915]
Feb  3 23:10:15 t44 kernel:  ? i915_gem_execbuffer_ioctl+0x2c0/0x2c0 [i915=
]
Feb  3 23:10:15 t44 kernel:  drm_ioctl_kernel+0xae/0x100 [drm]
Feb  3 23:10:15 t44 kernel:  drm_ioctl+0x223/0x400 [drm]
Feb  3 23:10:15 t44 kernel:  ? i915_gem_execbuffer_ioctl+0x2c0/0x2c0 [i915=
]
Feb  3 23:10:15 t44 kernel:  do_vfs_ioctl+0x4b3/0x730
Feb  3 23:10:15 t44 kernel:  ksys_ioctl+0x5b/0x90
Feb  3 23:10:15 t44 kernel:  __x64_sys_ioctl+0x15/0x20
Feb  3 23:10:15 t44 kernel:  do_syscall_64+0x46/0x110
Feb  3 23:10:15 t44 kernel:  entry_SYSCALL_64_after_hwframe+0x44/0xa9
Feb  3 23:10:15 t44 kernel: RIP: 0033:0x7fb227dcc137
Feb  3 23:10:15 t44 kernel: Code: 00 00 00 75 0c 48 c7 c0 ff ff ff ff 48 8=
3 c4 18 c3 e8 2d d4 01 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 b8 10 00 =
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 19 ed 0c 00 f7 d8 64 89 =
01 48
Feb  3 23:10:15 t44 kernel: RSP: 002b:00007ffeee183b68 EFLAGS: 00000246 OR=
IG_RAX: 0000000000000010
Feb  3 23:10:15 t44 kernel: RAX: ffffffffffffffda RBX: 00007ffeee183bb0 RC=
X: 00007fb227dcc137
Feb  3 23:10:15 t44 kernel: RDX: 00007ffeee183bb0 RSI: 0000000040406469 RD=
I: 000000000000000d
Feb  3 23:10:15 t44 kernel: RBP: 0000000040406469 R08: 000056098c7d25d0 R0=
9: 0000000000000202
Feb  3 23:10:15 t44 kernel: R10: 0000000000000000 R11: 0000000000000246 R1=
2: 000056098c794fc0
Feb  3 23:10:15 t44 kernel: R13: 000000000000000d R14: 00007fb2275aac48 R1=
5: 0000000000000000
Feb  3 23:10:15 t44 kernel: Modules linked in: af_packet bridge stp llc ip=
6table_filter ip6_tables xt_MASQUERADE iptable_nat nf_nat nf_log_ipv4 nf_l=
og_common xt_LOG xt_limit xt_recent xt_conntrack nf_conntrack nf_defrag_ip=
v6 nf_defrag_i
pv4 iptable_filter ip_tables uvcvideo videobuf2_vmalloc videobuf2_memops v=
ideobuf2_v4l2 videodev videobuf2_common btusb btrtl btbcm btintel bluetoot=
h ecdh_generic ecc mousedev rmi_smbus rmi_core i915 x86_pkg_temp_thermal c=
oretemp kvm_in
tel kvm intel_gtt i2c_algo_bit drm_kms_helper irqbypass cfbfillrect syscop=
yarea snd_hda_codec_realtek cfbimgblt sysfillrect snd_hda_codec_generic sy=
simgblt fb_sys_fops snd_hda_intel snd_intel_dspcfg cfbcopyarea input_leds =
snd_hda_codec
drm wmi_bmof iwlmvm snd_hda_core snd_pcm iwlwifi thinkpad_acpi drm_panel_o=
rientation_quirks aesni_intel tpm_tis pcspkr glue_helper psmouse crypto_si=
md atkbd cryptd ledtrig_audio snd_timer agpgart i2c_i801 e1000e i2c_core t=
hermal ehci_pc
i ehci_hcd snd soundcore wmi tpm_tis_core ac tpm battery rng_core evdev
Feb  3 23:10:15 t44 kernel: CR2: 0000000000000000
Feb  3 23:10:15 t44 kernel: ---[ end trace 49d09109389554e0 ]---
Feb  3 23:10:15 t44 kernel: RIP: 0010:0x0
Feb  3 23:10:15 t44 kernel: Code: Bad RIP value.
Feb  3 23:10:15 t44 kernel: RSP: 0018:ffff9cc100be3a40 EFLAGS: 00010083
Feb  3 23:10:15 t44 kernel: RAX: 0000000000000000 RBX: 0000000000000000 RC=
X: 0000000000382642
Feb  3 23:10:15 t44 kernel: RDX: 0000000000000000 RSI: ffff89b3d5674c88 RD=
I: ffff89b50d248480
Feb  3 23:10:15 t44 kernel: RBP: ffff89b50d248480 R08: 0000000000000000 R0=
9: ffff89b3d5674e80
Feb  3 23:10:15 t44 kernel: R10: 0000000000000002 R11: 0000000000000005 R1=
2: ffff9cc100be3a48
Feb  3 23:10:15 t44 kernel: R13: 0000000000000000 R14: ffff89b5a4b66400 R1=
5: ffff89b5a0761e40
Feb  3 23:10:15 t44 kernel: FS:  00007fb227b938c0(0000) GS:ffff89b5b270000=
0(0000) knlGS:0000000000000000
Feb  3 23:10:15 t44 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050=
033
Feb  3 23:10:15 t44 kernel: CR2: ffffffffffffffd6 CR3: 0000000323c76006 CR=
4: 00000000001606e0
Feb  3 23:11:01 t44 CROND[19020]: (root) CMD (/usr/lib/sa/sa1 30 2 -S XALL=
)
Feb  3 23:12:01 t44 CROND[19056]: (root) CMD (/usr/lib/sa/sa1 30 2 -S XALL=
)

The 2 lines shows that the system is still running. But I could only power=
off it and poweron it to get it back.


=2D-
Toralf
