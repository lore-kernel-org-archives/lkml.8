Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940BAC35669
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:22:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFFF20707
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 05:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Ly2Ke5kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgBVFWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 00:22:19 -0500
Received: from lb2-smtp-cloud9.xs4all.net ([194.109.24.26]:60479 "EHLO
        lb2-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726151AbgBVFWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 00:22:19 -0500
Received: from surfplank2.hierzo ([IPv6:2001:981:a812:0:b62e:99ff:fe92:5264])
        by smtp-cloud9.xs4all.net with ESMTPA
        id 5NF1jOjmtyIme5NF2jstMT; Sat, 22 Feb 2020 06:22:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1582348936; bh=CkTqarJ/J7Z6ilmv1H156s3T423lWb/DYD7SNEWZvE0=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=Ly2Ke5kUpagluvA1LZOI0nROKBdFyqqp8LM4KNKdJ7D7whP5Vj5oI2DvQGdm3L/z3
         stcva6OXFbFD0CU4EWjHtX4LyUP8zoVP0d6WoPXQU1n91ejHtmYxR40aNNW3u1c1Zx
         g0RxJEW9fv1z4X5GCaQ1unGHrp0JTb1GoZlhFiG7PWBD0PweTTlosE8w+S7zaj1M/r
         J97iwoaOEvBC5mrmscC2ms7b8jPINvfnTt91zD+hjehC+iq+Q2LFKsF+D4ymWJ5ESA
         qDvnx8Xl/VoR2TkUl37gqOdXDNT9EcyRwaFJ4G3j7+foZ7XrdQx5OBRr4HPHA3K1Tt
         Lu+vVclNciOlQ==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.3.18: BUG: kernel NULL pointer dereference
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 mQINBFTtuO0BEACwwf5qDINuMWL9poNLJdZh/FM5RxwfCFgfbM29Aip4wAUD3CaQHRLILtNO
 Oo4JwIPtDp7fXZ3MB82tqhBRU3W3HVHodSzvUk2VzV0dE1prJiVizpPtIeYRRDr4KnWTvJOx
 Fd3I7CiLv8oTH9j5yPTMfZ58Prp6Fgssarv66EdPWpKjQMY4mS8sl7/3SytvXiACeFTYPBON
 1I2yPIeYK4pKoMq9y/zQ9RjGai5dg2nuiCvvHANzKLJJ2dzfnQNGaCTxdEAuCbmMQDb5M+Gs
 8AT+cf0IWNO4xpExo61aRDT9N7dUPm/URcLjCAGenX10kPdeJP6I3RauEUU+QEDReYCMRnOM
 +nSiW7C/hUIIbiVEBn9QlgmoFINO3o5uAxpQ2mYViNbG76fnsEgxySnasVQ57ROXdEfgBcgv
 YSl4anSKyCVLoFUFCUif4NznkbrKkh7gi26aNmD8umK94E3a9kPWwXV9LkbEucFne/B7jHnH
 QM6rZImF+I/Xm5qiwo3p2MU4XjWJ1hhf4RBA3ZN9QVgn5zqluGHjGChg/WxhZVRdBl8Un3AY
 uixd0Rd9jFSUhZm/rcgoKyeW6c1Vkh8a2F+joZ/8wzxk6A8keiWq/pE00Lo9/Ed2w5dVBe1p
 N7rNh2+7DjAqpCSshYIsHYs0l5Q2W+0zYfuPM1kRbUdQF1PK0wARAQABtCVVZG8gdmFuIGRl
 biBIZXV2ZWwgPHVkb3ZkaEB4czRhbGwubmw+iQJiBBMBAgBMJhpodHRwOi8vcGluZGFyb3Rz
 LnhzNGFsbC5ubC9wb2xpY3kudHh0AhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAUCVkiW
 pwIZAQAKCRCOFcDCBOMObsjdD/oDH+DvcAFakVThGdFi00o1W0j7fFcPhrP34Ulf+5idkgJm
 RzarJrz7Av7L6fwCS3JtrzfEJ+qoP84ONxnhNhj5ItHpVUlxyRWPBisklNlGJWK277Naw3BT
 mql2edPRIcR5Ypd8O7DBXIypG0CigjOVWfWLspjLmEGlinqpjHWuv4/LJ3qwSbbpW0rXpb44
 xSWB+u605pfrO3vDox5ORGCLktN8IXWISm9mS6vSXAi797KHwVX55OsiKqCbNkSM3bl6XfHh
 CPUpbOHXHzZXvP7JTINZfSfTPJx0iWCn3KArcsy7MzSwpUpUpDizrWwVRW1XySQydb8m+lnl
 8IVpJFiXiFEYGhFYU9HbUFSNGku134O5tf3VurfpOXmxGyeoyXWt4m9l7fcSaBAZq21iJT+S
 VCSmsI0JfhxMHjMbwdghPQ3UYK4q95TOcVRUkH0h+b2cZPirol4htc+ZCSzPKI++AGjXWIc5
 ZyQbthmFesrYGGttNIFFWsj3RUkyB58toDE7gXmarkhBg74tsSGbCyJp8/foy5hrci5sSi5P
 cygZxEDytCTNw1Dno/EAHUOpI2lJsVN8ACws16a6vh/UgQnBPsVFgVd0HSnlEX9XLO65lHlX
 aXo0zXomy+DDYD1sKARt8sKJk/H/VGs3SMRH3QtSBtWcUQKyJXMafWP/8A1Bz7kCDQRU7bjt
 ARAAwdK6VLsLLfyqYuA2/X+agquHh3U44IVxuRGAjQ7NSec9il+ENpbsaK6QGFBlyaWHkqcL
 e2u7DWTmG1uBqU9XqXGgeQJiOY8aof0rMsOVd1yYZsQO7+t2yfMOuS9+eRDxxj5l8gZXOKl3
 eQ5akqlKIWJy4G4D5pwCKuA5XFphpikPLm84Fb4V8IgRuiHaeHjeZyfkwYhKqxiyneGZ387b
 S3r4pMKprXlvFzWTr+x2TxexAECP3Tjg9ZakOIaVmgvFtl8L12ib6YJke7HxY/a3P3Glt+Zl
 5r/qcbWQoqyKBX+flWAjCPw+9EbdQNjBnIes3sPTTZ4YP4s2qC9rd/afeTSy3iUJhjGrEF+5
 d0AB1F+ZipmnZkGFF7tlvu6T/66JzsndOiEaLBYUa4VqJ+T0pvgX+MkbueYaQlsDl9eB24sC
 HTwfexUnvK5sUKnFFn5ZYZoIein2XHXb8EjbiT1G3G0Yj/q/DrRH1T7EiP6JPIIFdVVccnth
 j6rinWVJPiXRC8Gby/uSZP8t7HmQRYKV+xCESfRb4ZEfZqVm1/3wo3wYL5ek71yLEZC57+Hb
 RWgjaZuQg7Pn59Bh+M6cx5xTdyQ3PSeR14uXWLvMnVO2yF5pd6Ou2ySWatgtqmeTd77MpJ9+
 mPZTSG/lDGXpL2s1P6GiroiY0g3aicCgObwzr/MAEQEAAYkCRgQYAQIAMAUCVO247SYaaHR0
 cDovL3BpbmRhcm90cy54czRhbGwubmwvcG9saWN5LnR4dAIbDAAKCRCOFcDCBOMObqXID/9+
 lT7u4VJlreAFpSXOxwRlAtN88rzap3sZyQ1Z4YCxEZLHg4Ew2X0xS8w6t5jM4atOiuUW6fHY
 nI5KiYV7GARWWhZe/zsTjSs/tZVC68Q9qNwE1Ck+tuBV7d59l8qLBgQITsl6HCiYBaGJR2BF
 RdhP8a/aC6i3MWP8umK0yLJrV7gvP0sL8EKuz1zBARL5WuvzgsTA72QsilEQ/ZGYXwWnPOiI
 vTrGxZHD9apKOacSoY+CT+W+xe+tAKT0I8k4Ejda/hg6jMnaNNONX6rtiQEoUxv3R+iRhnaA
 NIsdTpUoZAbvFwStnRWgn+LgIMvKa5uW0Mjk0ynd14UxFluPs7J3saUukF4jXJGiWS2APD2K
 nNc7sAZraeSk/JFy0Y0WFCCr/UHzVLZnwdWpdw3inoIQeKtN2jWpuPP2l+4fgLybHJVnrDAs
 jujgAUTyaLDYoUryBiodY8G8gdZxTZvXk0RA9ux2TnFJJvdw8rR1sej5Lax1CZnQYwXNLvIi
 OcFUtIrTXnUj2uK2teab0RBIE4QedGoTGGHPuua8WqFpvVzC9iCIQlVtfGw6CVvq92icqbdz
 QYrlFbsVCXOM9TvO5ppqJowfdKmqFUjQPAsO40bwbphkt1NBalgZaxMCinpqEggVm/rGqbj2
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <601bc039-30d9-1248-9c04-70371f3b5f10@xs4all.nl>
Date:   Sat, 22 Feb 2020 06:22:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJG3sS4pBtlHEm3sEtCXhBHHHYAtzXUzyfFZqMf5I6tiIL6BmFN9wz2lX4mJ6UYxLOok65h6CEnRwfTUS0F4oNojRoiinNKwXob52AokSUz4yDgkUtRh
 Wo6VaNXhWhS1tmP3BOeij9tE7xO1IoZHRKw4GWiU2E3o3YoxyfuTfmKjdzXK4KoBLM6D6hf0FaUiigmhdFxW53bOR0XOAyk8qfutnc/sRBXCH8avacT4PjvZ
 1Ya6CG3/DmXC6Dx+bNUYyg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please find below a BUG in 5.3.18:


[481577.016513] Web Content[1254426]: segfault at 20 ip 00007fd9b8a3294b
sp 00007ffea3895e90 error 4 in libxul.so[7fd9b891c000+4b0d000]
[481577.088180] Code: 64 24 20 48 b8 00 00 00 00 01 00 02 00 4c 89 6c 24
20 48 89 44 24 28 f6 47 08 01 0f 85 16 02 00 00 48 85 ed 0f 84 a2 01 00
00 <48> 8b 45 00 4c 8d 74 24 18 48 89 ef 48 c7 44 24 18 00 00 00 00 4c
[482245.299834] BUG: kernel NULL pointer dereference, address:
0000000000000028
[482245.342065] #PF: supervisor read access in kernel mode
[482245.373364] #PF: error_code(0x0000) - not-present page
[482245.404662] PGD 0 P4D 0
[482245.420342] Oops: 0000 [#1] PREEMPT SMP NOPTI
[482245.446958] CPU: 3 PID: 4702 Comm: transmission-gt Tainted: G
W         5.3.18 #25
[482245.496500] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[482245.555389] RIP: 0010:find_get_entry+0x80/0x130
[482245.583045] Code: 00 e8 f4 56 57 00 48 89 c2 48 3d 06 04 00 00 74 e4
48 3d 02 04 00 00 74 dc 48 85 c0 0f 84 a2 00 00 00 a8 01 0f 85 9f 00 00
00 <48> 8b 40 08 48 8d 78 ff a8 01 48 0f 44 fa 8b 47 34 85 c0 74 b6 8d
[482245.696112] RSP: 0018:ffffab0183b9bce8 EFLAGS: 00010246
[482245.727932] RAX: 0000000000000020 RBX: 0000000000000000 RCX:
ffff967bffdaa240
[482245.771211] RDX: 0000000000000020 RSI: 0000000000000000 RDI:
ffffab0183b9bce8
[482245.814489] RBP: ffff967cab6ad488 R08: 0000000000004000 R09:
0000000000000000
[482245.857770] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff967cab6ad488
[482245.901048] R13: 00000000000bbbe9 R14: 0000000000000000 R15:
00000000000bbbe9
[482245.944334] FS:  00007f1c5b7fe700(0000) GS:ffff967cdf0c0000(0000)
knlGS:0000000000000000
[482245.993336] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[482246.028286] CR2: 0000000000000028 CR3: 00000003ccde4000 CR4:
00000000003406e0
[482246.071564] Call Trace:
[482246.086725]  pagecache_get_page+0x22/0x220
[482246.111771]  generic_file_read_iter+0x175/0x7d0
[482246.139428]  new_sync_read+0x106/0x1a0
[482246.162399]  vfs_read+0x98/0x120
[482246.182243]  ksys_pread64+0x60/0xa0
[482246.203644]  do_syscall_64+0x5f/0x2d0
[482246.226093]  ? schedule+0x48/0xc0
[482246.246453]  ? switch_fpu_return+0x24/0xc0
[482246.271504]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[482246.302284] RIP: 0033:0x7f1c6faca1af
[482246.324213] Code: 08 89 3c 24 48 89 4c 24 18 e8 4d f3 ff ff 4c 8b 54
24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 04 24 e8 7d f3 ff ff 48 8b
[482246.437279] RSP: 002b:00007f1c5b7fc2a0 EFLAGS: 00000293 ORIG_RAX:
0000000000000011
[482246.483162] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f1c6faca1af
[482246.526444] RDX: 0000000000004000 RSI: 00007f1c488373dd RDI:
000000000000003d
[482246.569721] RBP: 00007f1c5b7fc350 R08: 0000000000000000 R09:
00007f1c5b7fc350
[482246.613004] R10: 00000000bbbe7fe1 R11: 0000000000000293 R12:
0000000000004000
[482246.656284] R13: 0000000000000001 R14: 00007f1c4801ce18 R15:
00007f1c4806e6d0
[482246.699562] Modules linked in: nls_utf8 exfat usb_storage fuse
mq_deadline xt_MASQUERADE iptable_nat nf_nat ipt_REJECT nf_reject_ipv4
xt_u32 xt_multiport iptable_filter nf_conntrack_netbios_ns
nf_conntrack_broadcast ip6t_REJECT nf_reject_ipv6 xt_tcpudp xt_state
it87 xt_conntrack hwmon_vid nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
msr ip6table_filter ip6_tables snd_hda_codec_realtek
snd_hda_codec_generic uvcvideo snd_usb_audio videobuf2_vmalloc
videobuf2_memops snd_hda_intel videobuf2_v4l2 snd_hwdep snd_usbmidi_lib
videodev snd_hda_codec snd_rawmidi videobuf2_common snd_hda_core snd_seq
snd_seq_device cdc_acm snd_pcm k10temp snd_timer i2c_piix4 snd bfq evdev
acpi_cpufreq binfmt_misc ip_tables x_tables amdgpu sr_mod backlight
gpu_sched cdrom aesni_intel ttm hid_generic usbhid i2c_dev autofs4
[482247.119959] CR2: 0000000000000028
[482247.140322] ---[ end trace 52775a3c267c2839 ]---
[482247.168503] RIP: 0010:find_get_entry+0x80/0x130
[482247.196154] Code: 00 e8 f4 56 57 00 48 89 c2 48 3d 06 04 00 00 74 e4
48 3d 02 04 00 00 74 dc 48 85 c0 0f 84 a2 00 00 00 a8 01 0f 85 9f 00 00
00 <48> 8b 40 08 48 8d 78 ff a8 01 48 0f 44 fa 8b 47 34 85 c0 74 b6 8d
[482247.309219] RSP: 0018:ffffab0183b9bce8 EFLAGS: 00010246
[482247.341043] RAX: 0000000000000020 RBX: 0000000000000000 RCX:
ffff967bffdaa240
[482247.384320] RDX: 0000000000000020 RSI: 0000000000000000 RDI:
ffffab0183b9bce8
[482247.427606] RBP: ffff967cab6ad488 R08: 0000000000004000 R09:
0000000000000000
[482247.470884] R10: 0000000000000000 R11: 0000000000000000 R12:
ffff967cab6ad488
[482247.514161] R13: 00000000000bbbe9 R14: 0000000000000000 R15:
00000000000bbbe9
[482247.557441] FS:  00007f1c5b7fe700(0000) GS:ffff967cdf0c0000(0000)
knlGS:0000000000000000
[482247.606450] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[482247.641395] CR2: 0000000000000028 CR3: 00000003ccde4000 CR4:
00000000003406e0

Please fix if not already fixed.

Kind regards,
Udo
