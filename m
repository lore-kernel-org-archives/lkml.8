Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76536C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:58:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A59820659
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 15:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.ca header.i=@yahoo.ca header.b="cPwMoAgB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgFGP6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 11:58:33 -0400
Received: from sonic306-20.consmr.mail.gq1.yahoo.com ([98.137.68.83]:39587
        "EHLO sonic306-20.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726643AbgFGP6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 11:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1591545509; bh=gn35HSrHYOJAQb1YaX/sGMc9WwyDxI0ZEwhA1Fm0Nl0=; h=Date:From:Subject:To:References:In-Reply-To:From:Subject; b=cPwMoAgBFVNlX53Q97Is0Lh3Gp6Wp4ZbHd+PxQramaNkIggCiGKOmF705rbfh/C+YSAeOlEqu8hB7uD+tjbB3tIHFBPMu5pUoj1wSOy0DhKOR722pkzBIZ9sweMcGALklwZy+5MCUOa06/aTmPQcUX4cVk/5n8DkcuWGE2w4kbc3kywRCquEj3M/Myf5cX4U79q7K4fgGjMRACDBhFYgbRvbWfgJfBYAk3YDfuhGRTOq7JVjb4WAhs9dq1k864L5MFvmfCl7iE4snU3b5UKzyqcReMDy7pdDUj3dKb9gxLpAfP1u6xmNbq47wob+sjADxbi+jT4h/LKjRGxOQxopXA==
X-YMail-OSG: CH_y2LcVM1kni9prA9rHrkitoJn.snJUJHz8BF5dv_2gayrwZ_aHp9PmiN0tYkK
 4N5gG1LoFvL5zGaWm1iE7x05SeX7F.rifuz6xKRvbWxQ_4Pvb4eyzmYWET.tgl_jCEAmTOdh0DW4
 6pIj4Yi_FdisPZ7RabAi9iIQr47f1D_L4XyI4C5pHmXilB0ZAfpAXeNcx6HVKoaQKyq6c.iAeJ1q
 cwn3XssAbgz0NQrG8khXJ1XZIVsK0zqijyD7N630EJOZmW1FwZS.tNK0RdtEsuT3yx57DCFDiETU
 2A9hC2fAkX5aCmqnvLLl7QC5uP8fanwwlEqHZwUdJJBNvwSWtIrxRjpDEEDJ8u2bNlY2o2mHOEu9
 wgsgmQ6qEkvSoYQkDUbaO2h5w4eIxjox_hnzDapUJTWIZF2APYUsoiNXHoxfOBnn3tJ3WzlY7GyT
 7SIPnKRI2xmwiUOlgV16qRPFsjHGeg33C2jU4Y8XPejvY_LWhNQ781NbYfQ7Ht3IeIyuOXrgFSR.
 aDhMkWATK56cPZPTwNDejJBLZXOqYIIMa.qPmh6GYQBr24oVuYxa_uVHa8o0dWHV1UVlUS8Lo54t
 GFYMX.uX4kSrX9QfAx6sfZekOPOhsAfp7JhWYJCxz9az5dbbPQhaD8XVgG3Y5iQmPWIrZisJCfRo
 b0I9AWgQ4BFoLYsg7wedLG3Bht1P6z9iEnFD9H5CciXWESeG6m91anQ928r_utAsA455hZQ4Our0
 HD438m9PUHup7KDrMJfFF.Hg34kEgSqYl53w1NZRA65APFDedQz0DVI304Bp5wNuzQKdoTjxl1he
 WLcRTnh3r4kJtawl8jU50nq6LllEBY0FE5_soIochWY8msEStIACVW.aktbKj0pSuDNJ72KuB_wm
 7yns1igsn_aF.Gf6EigZ5cm31LGVmM4GSzDQCyUm.5v6UMOP04r99cG0o5nynv2T7O9HbPh86To4
 xREG9wC0HmjQF1d7qn7rY4xc3tA0JEf5DtMvEmwpR8Wx1aoS5LCq6OxDS5ARoN5e5MCQfnDuCC6z
 rSsShOWa59w8juClInAH4ownYTs0kQI86aOg3hsqa6QKzuUCP74lXk4T4NPOpqRBoaBWtERgDEBS
 q8K0teRq0thKyYqLIooc_EPrycv9znTyPrVvMOIyHGYFD5pL1A5.er0gFKl8o3htqbvYNdjRfZi3
 otLzsre32plq35WjLRrvTrvQzOyOF2Rt2_0uQDDiwp4GxpPgLxo4a45g_k5_wwUDyXshciyZJS64
 AfPNtGFH2uvqj9yocePGAMvBTBGb0gVTKL1T6EE4aSSpo01sKjeu9_8MHzzZbe60HL0Ep39egc5S
 tXWpc1hqGgGEpL..r.ygzA0itd63MiX.Iy6VJDnxgIzRQ.LHnbPTHGWgHq9SU6rdLaxgbzljP4y1
 1SQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sun, 7 Jun 2020 15:58:29 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 26ae148dccc7e2160186bcd03cf9103f;
          Sun, 07 Jun 2020 15:58:24 +0000 (UTC)
Date:   Sun, 07 Jun 2020 11:58:21 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: Re: next-0519 on thinkpad x60: sound related? window manager crash
To:     alsa-devel@alsa-project.org, bp@alien8.de, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        Pavel Machek <pavel@ucw.cz>, perex@perex.cz,
        tglx@linutronix.de, tiwai@suse.com, x86@kernel.org,
        rientjes@google.com, hch@lst.de, hch@infradead.org
References: <20200520111136.GA3802@amd>
In-Reply-To: <20200520111136.GA3802@amd>
MIME-Version: 1.0
Message-Id: <1591545088.74ii116nf2.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: WebService/1.1.16072 hermes_yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar issue, caused between aaa2faab4ed8 and b170290c2836.

[   20.263098] BUG: unable to handle page fault for address: ffffb2b582cc20=
00
[   20.263104] #PF: supervisor write access in kernel mode
[   20.263105] #PF: error_code(0x000b) - reserved bit violation
[   20.263107] PGD 3fd03b067 P4D 3fd03b067 PUD 3fd03c067 PMD 3f8822067 PTE =
8000273942ab2163
[   20.263113] Oops: 000b [#1] PREEMPT SMP
[   20.263117] CPU: 3 PID: 691 Comm: mpv Not tainted 5.7.0-11262-gb170290c2=
836 #1
[   20.263119] Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M.=
/B450 Pro4, BIOS P4.10 03/05/2020
[   20.263125] RIP: 0010:__memset+0x24/0x30
[   20.263128] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 =
e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3=
> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
[   20.263131] RSP: 0018:ffffb2b583d07e10 EFLAGS: 00010216
[   20.263133] RAX: 0000000000000000 RBX: ffff8b8000102c00 RCX: 00000000000=
04000
[   20.263134] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb2b582c=
c2000
[   20.263136] RBP: ffff8b8000101000 R08: 0000000000000000 R09: ffffb2b582c=
c2000
[   20.263137] R10: 0000000000005356 R11: ffff8b8000102c18 R12: 00000000000=
00000
[   20.263139] R13: 0000000000000000 R14: ffff8b8039944200 R15: ffffffff979=
4daa0
[   20.263141] FS:  00007f41aa4b4200(0000) GS:ffff8b803ecc0000(0000) knlGS:=
0000000000000000
[   20.263143] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.263144] CR2: ffffb2b582cc2000 CR3: 00000003b6731000 CR4: 00000000003=
406e0
[   20.263146] Call Trace:
[   20.263151]  ? snd_pcm_hw_params+0x3f3/0x47a
[   20.263154]  ? snd_pcm_common_ioctl+0xf2/0xf73
[   20.263158]  ? snd_pcm_ioctl+0x1e/0x29
[   20.263161]  ? ksys_ioctl+0x77/0x91
[   20.263163]  ? __x64_sys_ioctl+0x11/0x14
[   20.263166]  ? do_syscall_64+0x3d/0xf5
[   20.263170]  ? entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   20.263173] Modules linked in: uvcvideo videobuf2_vmalloc videobuf2_memo=
ps videobuf2_v4l2 videodev snd_usb_audio videobuf2_common snd_hwdep snd_usb=
midi_lib input_leds snd_rawmidi led_class
[   20.263182] CR2: ffffb2b582cc2000
[   20.263184] ---[ end trace c6b47a774b91f0a0 ]---
[   20.263187] RIP: 0010:__memset+0x24/0x30
[   20.263190] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 =
e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3=
> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
[   20.263192] RSP: 0018:ffffb2b583d07e10 EFLAGS: 00010216
[   20.263193] RAX: 0000000000000000 RBX: ffff8b8000102c00 RCX: 00000000000=
04000
[   20.263195] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffb2b582c=
c2000
[   20.263196] RBP: ffff8b8000101000 R08: 0000000000000000 R09: ffffb2b582c=
c2000
[   20.263197] R10: 0000000000005356 R11: ffff8b8000102c18 R12: 00000000000=
00000
[   20.263199] R13: 0000000000000000 R14: ffff8b8039944200 R15: ffffffff979=
4daa0
[   20.263201] FS:  00007f41aa4b4200(0000) GS:ffff8b803ecc0000(0000) knlGS:=
0000000000000000
[   20.263202] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.263204] CR2: ffffb2b582cc2000 CR3: 00000003b6731000 CR4: 00000000003=
406e0

I bisected this to 82fef0ad811f "x86/mm: unencrypted non-blocking DMA=20
allocations use coherent pools". Reverting 1ee18de92927 resolves the=20
issue.

Looks like Thinkpad X60 doesn't have VT-d, but could still be DMA=20
related.
