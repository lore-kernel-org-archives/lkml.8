Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3C5C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA17420786
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IRWWeCXF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgHSSH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:07:26 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:6272
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726612AbgHSSHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:07:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wj4abg2LCa9e8LS+oPDb965th9JxWegKst0GTFtx8NYQvNQ0YDKQ9XIMGgWEhiCnCZ+KVvItyaaXTyjwEUNizZ9Y+9C8tNlKVzzTt5e8a3LF3othoDU3ecKhJh4q2+5Vcrcmefgz++pwA1KeE/8gzYpvZP8K/SrpwIql9GiQ6cghciEHiTPZriK08Ru8Ju3CaSorky+0EJ5qMpy/svFVyCPdqW+N/osI/FBeYrsaeJXRThuU+JnPfmDvPxirUv2low7amhApW2bg17f9HEZtV3vi73mUul5S0hvK2IMsNaidpJ6GUw+aIa4St5oRyyIxzVYTlEfXpAA3y0WPYivGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C9YXYT8onc2qmkUL3QszwfnZrPfZO9fjp0hv4SlJU0=;
 b=GWUYTyA7W6NgTp/KYPZlnKvRTconcX8FOnbi/TBgIxf8Z+mG9hFpIbMmKIx/1K36bAPjWdbK58E0B4rvD9kmrTFpwRw5/J4UCbAQ3TkRYzzDQ9tXvbPQ9eVxarhLq7nkOdwcf1v6ypy4jf8myuawDF4CnhfzKax6vDi6p+bG6RtBv5ywePJtOxAk9lphL0Z1ngZcqw24UgJeCaHT/hmaAcr3i8PStbF8DM1/rjl7qFMPZ4u9Iua2OnwQ6V20vfTOd2Gjw+ALfGdfPkOGazx7/75P2WbHRovr7r0N/ZpOMqFOnC1JnG9DiFoiJrybrE0jycG8XiSilEhZZHOwL4Om3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C9YXYT8onc2qmkUL3QszwfnZrPfZO9fjp0hv4SlJU0=;
 b=IRWWeCXFaCaAvvupiHH1XFgMyL5dwakVRLaygM0RlnD6AaBBfCXclYgjiTUYvvG8o3iTI1Ykepp1SjPJY63eC0Rcl3VdckNEPFjovzvCSaebxFOOyiZ+2aUJ5goawHo2iB3aoeBALAWqZIs+Hlc3ZboVBQa6VLV+m8fZhUJfIA8=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Wed, 19 Aug 2020 18:07:08 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 18:07:08 +0000
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Subject: FSGSBASE causing panic on 5.9-rc1
Message-ID: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
Date:   Wed, 19 Aug 2020 13:07:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0087.namprd05.prod.outlook.com
 (2603:10b6:803:22::25) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN4PR0501CA0087.namprd05.prod.outlook.com (2603:10b6:803:22::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.15 via Frontend Transport; Wed, 19 Aug 2020 18:07:07 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17d3671f-c7c4-4843-f7db-08d8446aaffd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4337:
X-Microsoft-Antispam-PRVS: <DM6PR12MB433767790124158141112A0AEC5D0@DM6PR12MB4337.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pfXL2oilH7HLnf6lNWx+Tx/KA6j0gLuGH31a3yhY3rgjIzrrxW4bkVpxvXK1boOpcwjO2doowjwT83u/nF0Lk2Dvdqn+c71B8kNCjNA6R7ka1ui9dimXW58Ll1/kFcUx3Up0BRIyuiwhxQjme/TxdOSYy7WN/0zANQBQpXTy1VfH+eMPpbGWXy6xE/Rd98gOJn/+tnKneYmHMNPT3/BQbqL4knldn4sl0SPJ1iZ81Rd7dKCKHj4LDJYyloAaUs1wc7NLODkOaf8qgtdru7W1EnlwNYV15CeAY6JIWxM6EBIBBpoxbrAz0m8EkxTaJ7cZA35n2GnuTzphOd7657sGFd8Js4z+y3ZKypuuoEiMRSRsItyI23tL0F9pt207GtUr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(54906003)(66476007)(5660300002)(86362001)(4326008)(66556008)(186003)(8936002)(16576012)(16526019)(26005)(316002)(36756003)(110136005)(66946007)(31686004)(8676002)(2616005)(52116002)(2906002)(478600001)(31696002)(6486002)(83380400001)(45080400002)(956004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Wve/Ua7ZI6QPH1jUx4utj/bqjGzGqctjqxb4bOn/B5GDdfhNA7mcdlJzFyKSlP4DSRaJ0GIDTPkgUEGCqPnA7ImSeqZRbWax6Y64S4RTVXrx6PU10//57oDpBK9XjC9avLsujysKWRf1z6XkyCU37MBnV8VcM+QxLID+PrP1lOL1RqCHxnsnrWccoKgU79AntG0Han0D1MZOdir2g36rexQKOYaYY/u2dmRWpsxacODkIjPVu8UuJm4m5+a6hcTgXATmBFczVX+raPNYHA7zc2EE+hFWMfBHTFbZXxG/B3QhTpYJ6okwp3zBRbUsJTFfWQecGR5d4ayczXM6vuuYX7/hTpAuUuYHe4TDfRz3IvmhyDXQr3bNwm0di7d+XX+2JVvUN475osoi/KqD4ActY1GyooVPiWiBkFKVltTiV9HWitaL2GOz6qrNtns41MQ/N8iC5kWJaodPi9YZlBNVVZV3xiBNXNKg+OTxeFtZ2lyGQZj93+uZUwFVSXnFpUIZzsS+asgnAY/vOWBbx3FPPyRqveq9p4aHHcyRD3MUL4cUT72uqmM+zEV6ufNhEO8gmiVoBeNvewi79e04WB31oTGS1ASID6gNFunK6MBUu338dhUZm9QPPAaPi+wRqBWOuE4p874SrYV/dAV5IoNTbw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17d3671f-c7c4-4843-f7db-08d8446aaffd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 18:07:08.4083
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8PrYcGguWhR+QxCnBeEIw6NSFp6v9yZl9fkL6ea8069wmRQPqZ2wdIoQ+R0dbkEEU+sdOHXgIB1nInr9vBc1zQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the FSGSBASE support is crashing my second generation EPYC
system. I was able to bisect it to:

b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")

The panic only happens when using KVM. Doing kernel builds or stress
on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
guest and do a kernel build within the guest, I get the following:

[  120.360637] BUG: scheduling while atomic: qemu-system-x86/5485/0x00110000
[  124.041646] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: x86_pmu_handle_irq+0x163/0x170
[  124.041647] ------------[ cut here ]------------
[  124.041649] Hardware name: AMD
[  124.041649] Workqueue:  0x0 (events)
[  124.041651] Call Trace:
[  124.041651] ------------[ cut here ]------------
[  124.041652] corrupted preempt_count: kworker/22:1/1449/0x110000
[  124.051267] WARNING: CPU: 22 PID: 1449 at kernel/sched/core.c:3595 finish_task_switch+0x289/0x290
[  124.051268] Modules linked in: tun ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge stp llc fuse amd64_edac_mod edac_mce_amd wmi_bmof kvm_amd kvm irqbypass sg ipmi_ssif ccp k10temp acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq squashfs loop sch_fq_codel parport_pc ppdev lp parport ip_tables raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear sd_mod t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ast drm_vram_helper drm_ttm_helper i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect ahci sysimgblt libahci fb_sys_fops libata drm e1000e i2c_piix4 wmi i2c_designware_platform i2c_designware_core pinctrl_amd i2c_core
[  124.051285] CPU: 22 PID: 1449 Comm: kworker/22:1 Tainted: G        W         5.9.0-rc1-sos-linux #1
[  124.051286] Hardware name: AMD
[  124.051286] Workqueue:  0x0 (events)
[  124.051287] RIP: 0010:finish_task_switch+0x289/0x290
[  124.051288] Code: ff 65 48 8b 04 25 c0 7b 01 00 8b 90 a8 08 00 00 48 8d b0 b0 0a 00 00 48 c7 c7 20 10 10 86 c6 05 be aa 55 01 01 e8 89 03 fd ff <0f> 0b e9 6b ff ff ff 55 48 89 e5 41 55 41 54 49 89 fc 53 48 89 f3
[  124.051288] RSP: 0018:ffffc9001afe7e10 EFLAGS: 00010082
[  124.051289] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000023
[  124.051290] RDX: 0000000000000023 RSI: ffffffff86101044 RDI: ffff88900d798bb0
[  124.051290] RBP: ffffc9001afe7e38 R08: ffff88900d798ba8 R09: 0000000000000005
[  124.051290] R10: 000000000000000f R11: ffff88900d798d54 R12: ffff88900d7aacc0
[  124.051291] R13: ffff889bd2308000 R14: 0000000000000000 R15: ffff88900d7aacc0
[  124.051291] FS:  0000000000000000(0000) GS:ffff88900d780000(0000) knlGS:0000000000000000
[  124.051292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  124.051292] CR2: 00007ff607620000 CR3: 0000001bcb0d2000 CR4: 0000000000350ee0
[  124.051293] Call Trace:
[  124.051293]  __schedule+0x348/0x810
[  124.051293]  ? dbs_work_handler+0x47/0x60
[  124.051294]  schedule+0x4a/0xb0
[  124.051294]  worker_thread+0xcf/0x3b0
[  124.051294]  ? process_one_work+0x370/0x370
[  124.051294]  kthread+0xfe/0x140
[  124.051295]  ? kthread_park+0x90/0x90
[  124.051295]  ret_from_fork+0x22/0x30
[  124.051295] ---[ end trace 7f77ee8ad05caa89 ]---
[  124.051296] Kernel Offset: disabled

Specifying nofsgsbase avoids the issue. This is very reproducible, so I
can easily test any fixes.

Thanks,
Tom
