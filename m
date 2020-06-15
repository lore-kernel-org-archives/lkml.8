Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0EDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5499320768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 18:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592246896;
	bh=hcJgQjtGuEvyZJCWDTntqhhSC0sznb5z83dqyigtsY0=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=Q2jGdpci3b5pJmqNgUfZq97YChV01lrx1S/W15eNcGFg+22BxscM5hPLPo3ABE3TG
	 UJCLEi1fMSNX1Ht9uuaqWkG2iuxfXqRAzyv8dn/k9MP6teye83Oloui9lQ+JCzhZKP
	 rEz88pqrjjInhyr8/tx0dmmBkKv0FBdGTpWKWvHM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731367AbgFOSsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 14:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729354AbgFOSsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 14:48:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B289C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:48:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id s13so13918817otd.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 11:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=f8gpBxkd8Sk+831s8mFvTcPza4jDnAs2f+7XCKi5PL0=;
        b=D4nwOCi55DnM3uZh/DWOIGcuJcjSqq2TDZ5h6TvyaBfBSOqXAeMB1i/3K7dKrraPqy
         eGxvktGNbs7q0EqoC5rMzNN51LiIX2ahuPXq5qM+Z2mNAqh2VFeBhzESsqB+ZEmPIMCj
         5+aakzcp5WajkwEa435/KqnNcWY5F3w6Je42w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=f8gpBxkd8Sk+831s8mFvTcPza4jDnAs2f+7XCKi5PL0=;
        b=gdqE8v9iohz9U7OQVZcpZma180NLkaIYqHwMAoGfmHiJIz1KtO/AMk57W4akTZ3ynb
         CbeChMxGMg4w+iDmqgQIWvpYc+sNqgIWEmIoJJtChQ/ztWHnzg7i7emMlXmxqpz5g1V2
         +mrESN3555C6K5uxFbHyZeZwJPLHyrO36Q0+k8sCoO3VWwTxk52+Jb18SZFMbBx3oIBR
         qCSH2hpvNz5qqgSiI2iLV3QjUas4nFI2721x2B+/6lWG6fe/jJUWYikIL46G2FxEGSzu
         ZWpv6eEws8vuTopVQhH6lb3UIfc4PoBHdkTvbZhmFMrdFLWCtBbmLESuIaZjSjc0ZWVF
         KlGg==
X-Gm-Message-State: AOAM5327UQaL5fnB0T6L0oNSjluhugV2DKkwvDQaJuz40UtYUHrYnn4d
        OmSLjpACzMM3xOarujLHbG0W9Q==
X-Google-Smtp-Source: ABdhPJyD0wafqyIHwFtju2FpahW/CPlk0FXrGYCP0CBydq91YFwJz/49X02ne7dDmVyrkpzEs7bGgg==
X-Received: by 2002:a9d:6d8c:: with SMTP id x12mr5643675otp.86.1592246893136;
        Mon, 15 Jun 2020 11:48:13 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id 53sm3472630otv.22.2020.06.15.11.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 11:48:12 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Takashi Iwai <tiwai@suse.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        skhan@linuxfoundation.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
Message-ID: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
Date:   Mon, 15 Jun 2020 12:48:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing the following problem on my system. I haven't started debug
yet. Is this a known issue?

[    9.791309] BUG: unable to handle page fault for address: 
ffffb1e78165d000
[    9.791328] #PF: supervisor write access in kernel mode
[    9.791330] #PF: error_code(0x000b) - reserved bit violation
[    9.791332] PGD 23dd5c067 P4D 23dd5c067 PUD 23dd5d067 PMD 22ba8e067 
PTE 80001a3681509163
[    9.791337] Oops: 000b [#1] SMP NOPTI
[    9.791340] CPU: 7 PID: 866 Comm: pulseaudio Not tainted 5.8.0-rc1 #1
[    9.791341] Hardware name: LENOVO 10VGCTO1WW/3130, BIOS M1XKT45A 
08/21/2019
[    9.791346] RIP: 0010:__memset+0x24/0x30
[    9.791348] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 
83 e2 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af 
c6 <f3> 48 ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
[    9.791350] RSP: 0018:ffffb1e7817a7dd0 EFLAGS: 00010216
[    9.791352] RAX: 0000000000000000 RBX: ffff97b32dfd7400 RCX: 
00000000000008a0
[    9.791354] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 
ffffb1e78165d000
[    9.791356] RBP: ffffb1e7817a7e00 R08: ffffb1e780000000 R09: 
ffffb1e78165d000
[    9.791358] R10: ffffffffffffffff R11: ffffb1e78165d000 R12: 
0000000000000000
[    9.791359] R13: ffff97b32dfd3000 R14: ffffffffc0b48880 R15: 
ffff97b33aa42600
[    9.791361] FS:  00007fa11cb34ec0(0000) GS:ffff97b33edc0000(0000) 
knlGS:0000000000000000
[    9.791363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    9.791365] CR2: ffffb1e78165d000 CR3: 0000000210db6000 CR4: 
00000000003406e0
[    9.791367] Call Trace:
[    9.791377]  ? snd_pcm_hw_params+0x3ca/0x440 [snd_pcm]
[    9.791383]  snd_pcm_common_ioctl+0x173/0xf20 [snd_pcm]
[    9.791389]  ? snd_ctl_ioctl+0x1c5/0x710 [snd]
[    9.791394]  snd_pcm_ioctl+0x27/0x40 [snd_pcm]
[    9.791398]  ksys_ioctl+0x9d/0xd0
[    9.791400]  __x64_sys_ioctl+0x1a/0x20
[    9.791404]  do_syscall_64+0x49/0xc0
[    9.791406]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    9.791408] RIP: 0033:0x7fa11d4c137b
[    9.791410] Code: Bad RIP value.
[    9.791412] RSP: 002b:00007ffe2fb4e308 EFLAGS: 00000246 ORIG_RAX: 
0000000000000010
[    9.791414] RAX: ffffffffffffffda RBX: 00007ffe2fb4e510 RCX: 
00007fa11d4c137b
[    9.791415] RDX: 00007ffe2fb4e510 RSI: 00000000c2604111 RDI: 
0000000000000012
[    9.791417] RBP: 000055e99f65a890 R08: 0000000000000000 R09: 
0000000000000000
[    9.791418] R10: 0000000000000004 R11: 0000000000000246 R12: 
000055e99f65a810
[    9.791420] R13: 00007ffe2fb4e344 R14: 0000000000000000 R15: 
00007ffe2fb4e510
[    9.791422] Modules linked in: cmac algif_hash algif_skcipher af_alg 
bnep binfmt_misc nls_iso8859_1 snd_hda_codec_realtek 
snd_hda_codec_generic ledtrig_audio snd_hda_codec_hdmi snd_hda_intel 
snd_usb_audio snd_intel_dspcfg snd_usbmidi_lib snd_hda_codec amdgpu mc 
snd_hda_core snd_hwdep snd_pcm edac_mce_amd iommu_v2 ath10k_pci 
snd_seq_midi gpu_sched snd_seq_midi_event kvm_amd kvm ttm snd_rawmidi 
ath10k_core irqbypass drm_kms_helper snd_seq cec i2c_algo_bit 
fb_sys_fops ath snd_seq_device syscopyarea snd_timer mac80211 
crct10dif_pclmul ghash_clmulni_intel btusb aesni_intel btrtl btbcm 
crypto_simd cryptd btintel serio_raw input_leds sysfillrect glue_helper 
bluetooth efi_pstore k10temp snd pl2303 wmi_bmof ecdh_generic ecc 
snd_pci_acp3x sysimgblt cfg80211 soundcore ccp libarc4 ipmi_devintf 
ipmi_msghandler mac_hid sch_fq_codel parport_pc ppdev lp parport drm 
ip_tables x_tables autofs4 hid_generic usbhid hid crc32_pclmul nvme ahci 
psmouse i2c_piix4 libahci nvme_core r8169 realtek wmi video
[    9.791463] CR2: ffffb1e78165d000
[    9.791465] ---[ end trace 7b22a028ccaf2e75 ]---

thanks,
-- Shuah
