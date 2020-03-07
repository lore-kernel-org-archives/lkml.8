Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722F4C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CBB420674
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 17:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgCGRYX convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 12:24:23 -0500
Received: from mail-oln040092255073.outbound.protection.outlook.com ([40.92.255.73]:42736
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726109AbgCGRYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 12:24:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QEbRcDTBqpNTQ2t8FYLxyNt2Tsi9wW1VyFBXyCTPJYlijafAyK88NXcFZAXqJ2+wbQkYj6lc0/zhedYQ6nIwb7Um2hper0WoQjrqAwNL0kMClkXX9xvDW9JM8mzJiGtUY0ohh/aBYgBfzdoI4Ipz/rR1hJajkRRx6PnYk72Bdunuwas1Kkvzi/hETFzRd/yLLEUweWE/2G7mOK7YgY2rteHVr9UTG67Hy12++ICMck+RNjaibPWM4zTz0dcyZ/ZYldADMsDii8mRywZ04ObLdafgSJN0FblOVPUwOrWQjpXxOPpKR7ME0uGY3LKdL33F+2xIDvSS9ltU5L5Nmzucwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tszg2V2jeixee10Oj70ZOS/TDUOd20x4YdV/lCix7gI=;
 b=QVNl/pGHeBktfVTc8fgTnx9V4cZII0VkN7Gub8ymmdKBexCyjKQg20pNfm4IqB2BhdgoIpu/i16EW+/2iNOd7NjNMMvpsYM2Pn2xUfYv71g0vFVCc+OGWdQSKwQi+eqzGX+g8e3Quxxy54tL/KrZIz5HIzpmURweC7kr+OZt1UtknJsgqVjXFarRNWrmFuWyw1G+mVj34S0/vB3uq798zKhZAG4uxNPVoRkTvFkjp8Xf0vR7H0/UmXD96uLIXPpX0XwhrXn1GEfrEOkUqjA7k5tl2f8tYxu21OgNLWboarXXaiMDkAWc9qXJ98Dn9zhBXD3nLKLoBeSVvmd//dU7UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT034.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::3b) by
 HK2APC01HT229.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::320)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.11; Sat, 7 Mar
 2020 17:24:18 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.54) by
 HK2APC01FT034.mail.protection.outlook.com (10.152.248.191) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.11 via Frontend Transport; Sat, 7 Mar 2020 17:24:17 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2772.020; Sat, 7 Mar 2020
 17:24:17 +0000
Received: from nicholas-dell-linux (2001:44b8:605f:11:6375:33df:328c:d925) by ME2PR01CA0095.ausprd01.prod.outlook.com (2603:10c6:201:2d::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Sat, 7 Mar 2020 17:24:15 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     xinhui pan <xinhui.pan@amd.com>,
        =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>,
        Felix Kuehling <felix.kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: WARN_ON_ONCE triggered "drm/amdgpu: Remove kfd eviction fence before
 release bo (v2)"
Thread-Topic: WARN_ON_ONCE triggered "drm/amdgpu: Remove kfd eviction fence
 before release bo (v2)"
Thread-Index: AQHV9KU6//AyqegTvUSeSsHX4mpYgg==
Date:   Sat, 7 Mar 2020 17:24:17 +0000
Message-ID: <PSXP216MB0438CD7C87160211C08DC9AE80E00@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0095.ausprd01.prod.outlook.com
 (2603:10c6:201:2d::35) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:013A63E4E61CB68725738A554FFB09C27340E85A007E56AAE3C5E7E6E1BE3417;UpperCasedChecksum:C78260B0BAA6FB4658C1797DF97289FB7392ED68D7BD98450EC2B3180D5B4C2A;SizeAsReceived:7757;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [z4SCZKjD9+6UJWtuxZ7cYQJmWQEu7GrWh2qMDzkEcQfz8C4Hz1mEwqCGF9XxmiqB]
x-microsoft-original-message-id: <20200307172408.GA4379@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 01e34570-8a73-4b4e-263d-08d7c2bc5cf0
x-ms-traffictypediagnostic: HK2APC01HT229:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2cx2LnRyf6pSw/IDkENT2x9eVWOBChZW8GU5L31rN+AkSHFWkS38voGuc6ZqJuyE5F5eEWWfs/CNQtF8k6GkUkXN0M5k9AboovM/iuIXTFsRH/uU/3XdjT2MvCA6J8tsSF+KATTsiouxDTwQVYMslypS8/r2Dw8mxZCUlz/3ACH/k0NPzLD04DZOS/BOxlWz
x-ms-exchange-antispam-messagedata: rIa86WHvWyKrRIanb00wBsi57+jpHKFHA5VSafvRmKaf80jhMkKO/qE6HPrHeR0KDlYOMBg8HLjI8AbjXXNdzekEcB/uIrJiXlKV7I+Mx3iWkK1ay/h9flFP8h0fyXFmUDagHPBZ63CN9QXjR1l6cTFMgRKTDy1CE2OdAI/O0xd0c/EcVerSXbGIrKIDQ9e95WQtFsVeG1bP26zGeYxLFA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <84EA49691E5BE24D8BF8C206241F24F1@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e34570-8a73-4b4e-263d-08d7c2bc5cf0
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 17:24:17.3973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I could not find the messages regarding this commit to reply to on 
lore.kernel.org/lkml - so I started a new thread.

The commit f4a3c42b5c52 "drm/amdgpu: Remove kfd eviction fence before 
release bo (v2)" adds a WARN_ON_ONCE which is getting triggered when I 
hot-add an [1002:7300] Fiji XT GPU via Thunderbolt. It does not seem to 
do it if the GPU is present at boot time.

The WARN_ON_ONCE is at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c +1311.

I do not know what this means or if it is significant, but nevertheless 
I am alerting you to the fact. If this report results in any changes 
being required, I am more than happy to test those changes and confirm 
they solve the problem. If you need more information, just ask and I 
will provide. :)

Here is the dmesg:

------------[ cut here ]------------
WARNING: CPU: 1 PID: 2160 at drivers/gpu/drm/amd/amdgpu/amdgpu_object.c:1311 amdgpu_bo_release_notify+0x10c/0x130 [amdgpu]
Modules linked in: usbhid amdgpu amd_iommu_v2 gpu_sched ttm ccm rfcomm cmac algif_hash algif_skcipher af_alg snd_hda_codec_hdmi bnep hid_multitouch hid_generic uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common videodev mc btusb btrtl btbcm btintel cdc_acm bluetooth ecdh_generic ecc joydev snd_hda_codec_realtek snd_hda_codec_generic 8021q garp mrp stp llc msr x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel dell_laptop ledtrig_audio dell_wmi kvm dell_smbios mei_hdcp dcdbas intel_rapl_msr wmi_bmof dell_wmi_descriptor intel_wmi_thunderbolt iwlmvm snd_hda_intel snd_intel_dspcfg crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_hda_codec i915 mac80211 aesni_intel crypto_simd libarc4 snd_hda_core drm_kms_helper cryptd glue_helper intel_cstate snd_hwdep cec intel_rapl_perf psmouse input_leds iwlwifi rc_core pcspkr snd_pcm efi_pstore drm snd_timer snd i2c_algo_bit fb_sys_fops intel_lpss_pci soundcore intel_lpss i2c_i801 idma64
processor_thermal_device cfg80211 ucsi_acpi syscopyarea mei_me thunderbolt intel_xhci_usb_role_switch sysfillrect typec_ucsi intel_rapl_common sysimgblt mei roles virt_dma intel_pch_thermal intel_soc_dts_iosf wmi typec i2c_hid hid int3400_thermal acpi_thermal_rel pinctrl_sunrisepoint int3403_thermal intel_hid int340x_thermal_zone pinctrl_intel video acpi_pad sparse_keymap mac_hid sch_fq_codel crypto_user ip_tables x_tables autofs4 rtsx_pci_sdmmc nvme serio_raw nvme_core rtsx_pci
CPU: 1 PID: 2160 Comm: gnome-shel:cs0 Not tainted 5.6.0-rc4-next-20200305 #1
Hardware name: Dell Inc. XPS 13 9370/09DKKT, BIOS 1.12.1 12/11/2019
RIP: 0010:amdgpu_bo_release_notify+0x10c/0x130 [amdgpu]
Code: 74 17 48 8d 78 38 ba ff ff ff ff f0 0f c1 50 38 83 fa 01 74 1c 85 d2 7e 23 48 8b bb f0 00 00 00 e8 d9 f3 d1 fb e9 28 ff ff ff <0f> 0b e9 72 ff ff ff e8 c8 4a 9a fb eb e1 0f 0b eb dd be 03 00 00
RSP: 0018:ffff95b100f0bbf0 EFLAGS: 00010283
RAX: ffff889297600948 RBX: ffff889297600850 RCX: 0000000000000000
RDX: ffff88925dd097c0 RSI: ffff889297600948 RDI: ffff889297600850
RBP: ffff95b100f0bc10 R08: 0000000000000020 R09: ffff88929c807800
R10: ffff8892987e2140 R11: 0000000000000001 R12: ffff889297600800
R13: ffffffffc0fccf28 R14: ffff88925fc24f50 R15: 0000000000030480
FS:  00007fc8418e9700(0000) GS:ffff88929e640000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fc8418e9a08 CR3: 0000000458b0e006 CR4: 00000000003606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 ttm_bo_put+0x315/0x3f0 [ttm]
 amdgpu_bo_unref+0x1e/0x30 [amdgpu]
 amdgpu_gem_object_free+0x34/0x50 [amdgpu]
 drm_gem_object_free+0x41/0x70 [drm]
 drm_gem_object_put_unlocked+0x73/0x80 [drm]
 drm_gem_object_handle_put_unlocked+0x70/0xb0 [drm]
 drm_gem_object_release_handle+0x76/0xa0 [drm]
 drm_gem_handle_delete+0x59/0xa0 [drm]
 ? drm_gem_handle_create+0x40/0x40 [drm]
 drm_gem_close_ioctl+0x24/0x30 [drm]
 drm_ioctl_kernel+0xae/0xf0 [drm]
 drm_ioctl+0x234/0x3d0 [drm]
 ? drm_gem_handle_create+0x40/0x40 [drm]
 amdgpu_drm_ioctl+0x4e/0x80 [amdgpu]
 ksys_ioctl+0x9d/0xd0
 __x64_sys_ioctl+0x1a/0x20
 do_syscall_64+0x57/0x1b0
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7fc85aa1c2eb
Code: 0f 1e fa 48 8b 05 a5 8b 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 75 8b 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fc8418e86d8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc8418e8710 RCX: 00007fc85aa1c2eb
RDX: 00007fc8418e8710 RSI: 0000000040086409 RDI: 0000000000000012
RBP: 0000000040086409 R08: 00007fc8240008d2 R09: 0000000000000001
R10: 0000000000000007 R11: 0000000000000246 R12: 0000556d362b85a8
R13: 0000000000000012 R14: 0000556d362b914c R15: 00007fc8418e8740
---[ end trace 71c7143be8a94a69 ]---

Kind regards,
Nicholas Johnson
