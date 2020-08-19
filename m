Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5982C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF19A20758
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R1WV3QQh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHSST5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:19:57 -0400
Received: from mail-dm6nam12on2077.outbound.protection.outlook.com ([40.107.243.77]:11361
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725804AbgHSSTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:19:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYo+2tRib8DZsrginFCzD0Bk/PmtJ9rmP7rT2FCv8KNXXR+6d80DWJ8IFCAH+V40/qko3DLowTRzzVBH9I+dMjMuEWyNm7S5tpGdfkw+TISc1Pu/Aew5Wn911PA8IMiTSuF1ksItBSH5Pc0eqQewEDyy27qgk4Gmg0slONo9f6Dar/JpbundEnzT/lNJDSQf7il3Bujo6aCm7rclmowcaZE+Q1yyONCwJdqt6YjeXUS2EKyxXy/Uk2HJYq0joPRSbGbYClfBcax5XfE62T8w141CX+TVJRUFPfDVeMASe0i0aOhc95Oz08P7dElGhuaoNy3qxiXptMO4tQBUIwS5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9afvIOH5wy/hVft+5pG3ooNYd/AeWe8khE7wB8eWaE=;
 b=RxrVNga2SDF3irRfEPUNyo6AvtNay/MB93y3ddkMNlfyNLv/daSjyj/yuoS2Y+/tiYwr4EcEcM7MzUudbE6lHZ+ds0/Ug8rUJRyTHMtvfXbMdX0MIEIqTsek0TyngeWGiEgTJN7NNDnoDsYfumODoHet2p9HPDFqw8QdKVVyvH5lNYJasuP7l4W6FrEJuJasWinpD0Fdt9wq8BEJiMmAntDS1MkE/fIuEyegOV7ecStIUP1ZMDG2lnR4jkCofyI+UZBKhmlRCV65ekbbuYLHv69RQk0tncFbWwEO71RKqs/khtTQsn1i/JPzOUEV0tgFJWxvTHS36/EZAlN77w3/fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9afvIOH5wy/hVft+5pG3ooNYd/AeWe8khE7wB8eWaE=;
 b=R1WV3QQhaeeOYTBc+fNtsr7ZFs77Dyog5dva+FM7kaKvHooZSDFE7DgVfU7hcIhbTKkU8gjKNrsBzy06oMnhuCxWb7KqN0WkOEWdpgMe394V4TT7LTfwBgnuhgpuGHj6Td8ntB0VWe282dkGgR/VNvzq/vD15+wpwV5TkhAnlSY=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) by
 DM6PR12MB4516.namprd12.prod.outlook.com (2603:10b6:5:2ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24; Wed, 19 Aug 2020 18:19:51 +0000
Received: from DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346]) by DM5PR12MB1355.namprd12.prod.outlook.com
 ([fe80::299a:8ed2:23fc:6346%3]) with mapi id 15.20.3283.027; Wed, 19 Aug 2020
 18:19:51 +0000
Subject: Re: FSGSBASE causing panic on 5.9-rc1
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <sashal@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
References: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
Message-ID: <7dedb0ab-56a6-5d96-577b-21ab1ecdad24@amd.com>
Date:   Wed, 19 Aug 2020 13:19:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <39d57e4d-5db4-f536-6f5e-6b0414c0dccc@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR21CA0012.namprd21.prod.outlook.com
 (2603:10b6:5:174::22) To DM5PR12MB1355.namprd12.prod.outlook.com
 (2603:10b6:3:6e::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by DM6PR21CA0012.namprd21.prod.outlook.com (2603:10b6:5:174::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.0 via Frontend Transport; Wed, 19 Aug 2020 18:19:50 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7766cf9f-d48c-4e96-5f27-08d8446c7675
X-MS-TrafficTypeDiagnostic: DM6PR12MB4516:
X-Microsoft-Antispam-PRVS: <DM6PR12MB451670083AD0F5D02DEE2B55EC5D0@DM6PR12MB4516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dR3QFTnecc515e7v0oahFGl5YwaOUZkG2CkMbJrhOEMz6NrOkkTUtKGRrL0XRac9XB0uT0lp8QyAe61VC4fPlvqc1N71mdgZ/KQrvG9LkiOaygXbvrPJtDVtZfOWMrblkFsGLC2o8Nk5uU79kHhu4Z/DrE9/Y83DNt4J7HurGxQDisuBB+UQZv914QyJSVqZVQ8ge435jjwuQmWkOQu6/lMdq3jjCQYTLeDTd0AVqGEKheQ6e9NEIcoHAbRzPbJEBoYKkPLuuptMRrKVP1EM3r5FSZjh9JUifIS7CxwgFY/t2u2mo5fOHDC5o3JzA3Kc2c6eY3l+8+Nlio4h/1Nj7zy7VIxOyXHpNI3lStgekx+Tj8g8Z9cAYB4gozflbz0O
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB1355.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(5660300002)(66946007)(66556008)(66476007)(26005)(478600001)(83380400001)(16526019)(86362001)(31696002)(36756003)(53546011)(186003)(2616005)(956004)(4326008)(6486002)(2906002)(316002)(16576012)(45080400002)(31686004)(54906003)(8936002)(52116002)(8676002)(110136005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: Ij9kKT4gOP33gwCCwDofRqgyBCEIqIUorX9v1P108xciNI320Z6GglhgFOmKtTDJH4pNdPnWsamei3djPMCRmNU53rIqKIaQGvKdr08kytgpbppg/yhlx8IYZgaMHArNpeeYp+Ai4omSEZd9mGA3PsLnS+nH3b4zOC3FrB5v9+MlK6qQmlUD6oxys1yninvzKuxjk1nuagSveTG3c2V7Q4odQicUF0Ll5UPfG9HykBdStgQfhzgVF7ycRgtmKp20QnEjeecMG5G0KsqJKIEGwtYkjsUZu6ObbnmmJ/FmEnvUNuk+Z2g8ZgWwTVdPsOe1dxDkZIg0QZs+3hj59TBJlL/kqrTgcIPkFECgNvTdEUzzyYkMsNNpufOVLKP2vs4T97l+mZMaZVqAvslLuhm0RbGHszuA+v81K2KpSYopGZNV7IEw6X1a2r6/Wt9EXWafstiL6MQHwIoelTCnHpLi8gswO/IkJsFkgBznJUoSRWZe+OggcKSJkL7IIjIHbc7Ci6Il0ApD9/fwg/09fYqm/fX2euY79AoXrYAwfKxLQ+7qHdlUL++ya8SwXg1ln6GzSmzbKOA9KZxzNOi2Flp5EIiHUr8PvZBAoMuPZtLJszZAxfo0+OFQ1QROHhA2G2qVGMy9vWL98U9cjfp3Y/GpEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7766cf9f-d48c-4e96-5f27-08d8446c7675
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1355.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 18:19:50.8974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sg7c16aEqw9lEQJ7dtlXzgxCi/a2amFC5M2m/57+3H377vSaXj0rovTDrS6plsQdzET207HOCHGlDq/0uwJlcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4516
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/19/20 1:07 PM, Tom Lendacky wrote:
> It looks like the FSGSBASE support is crashing my second generation EPYC
> system. I was able to bisect it to:
> 
> b745cfba44c1 ("x86/cpu: Enable FSGSBASE on 64bit by default and add a chicken bit")
> 
> The panic only happens when using KVM. Doing kernel builds or stress
> on bare-metal appears fine. But if I fire up, in this case, a 64-vCPU
> guest and do a kernel build within the guest, I get the following:

I should clarify that this panic is on the bare-metal system, not in the
guest. And that specifying nofsgsbase on the bare-metal command line fixes
the issue.

Thanks,
Tom

> 
> [  120.360637] BUG: scheduling while atomic: qemu-system-x86/5485/0x00110000
> [  124.041646] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: x86_pmu_handle_irq+0x163/0x170
> [  124.041647] ------------[ cut here ]------------
> [  124.041649] Hardware name: AMD
> [  124.041649] Workqueue:  0x0 (events)
> [  124.041651] Call Trace:
> [  124.041651] ------------[ cut here ]------------
> [  124.041652] corrupted preempt_count: kworker/22:1/1449/0x110000
> [  124.051267] WARNING: CPU: 22 PID: 1449 at kernel/sched/core.c:3595 finish_task_switch+0x289/0x290
> [  124.051268] Modules linked in: tun ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge stp llc fuse amd64_edac_mod edac_mce_amd wmi_bmof kvm_amd kvm irqbypass sg ipmi_ssif ccp k10temp acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_cpufreq squashfs loop sch_fq_codel parport_pc ppdev lp parport ip_tables raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor async_tx xor raid6_pq raid1 raid0 linear sd_mod t10_pi crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel crypto_simd cryptd glue_helper ast drm_vram_helper drm_ttm_helper i2c_algo_bit ttm drm_kms_helper syscopyarea sysfillrect ahci sysimgblt libahci fb_sys_fops libata drm e1000e i2c_piix4 wmi i2c_designware_platform i2c_designware_core pinctrl_amd i2c_core
> [  124.051285] CPU: 22 PID: 1449 Comm: kworker/22:1 Tainted: G        W         5.9.0-rc1-sos-linux #1
> [  124.051286] Hardware name: AMD
> [  124.051286] Workqueue:  0x0 (events)
> [  124.051287] RIP: 0010:finish_task_switch+0x289/0x290
> [  124.051288] Code: ff 65 48 8b 04 25 c0 7b 01 00 8b 90 a8 08 00 00 48 8d b0 b0 0a 00 00 48 c7 c7 20 10 10 86 c6 05 be aa 55 01 01 e8 89 03 fd ff <0f> 0b e9 6b ff ff ff 55 48 89 e5 41 55 41 54 49 89 fc 53 48 89 f3
> [  124.051288] RSP: 0018:ffffc9001afe7e10 EFLAGS: 00010082
> [  124.051289] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000023
> [  124.051290] RDX: 0000000000000023 RSI: ffffffff86101044 RDI: ffff88900d798bb0
> [  124.051290] RBP: ffffc9001afe7e38 R08: ffff88900d798ba8 R09: 0000000000000005
> [  124.051290] R10: 000000000000000f R11: ffff88900d798d54 R12: ffff88900d7aacc0
> [  124.051291] R13: ffff889bd2308000 R14: 0000000000000000 R15: ffff88900d7aacc0
> [  124.051291] FS:  0000000000000000(0000) GS:ffff88900d780000(0000) knlGS:0000000000000000
> [  124.051292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  124.051292] CR2: 00007ff607620000 CR3: 0000001bcb0d2000 CR4: 0000000000350ee0
> [  124.051293] Call Trace:
> [  124.051293]  __schedule+0x348/0x810
> [  124.051293]  ? dbs_work_handler+0x47/0x60
> [  124.051294]  schedule+0x4a/0xb0
> [  124.051294]  worker_thread+0xcf/0x3b0
> [  124.051294]  ? process_one_work+0x370/0x370
> [  124.051294]  kthread+0xfe/0x140
> [  124.051295]  ? kthread_park+0x90/0x90
> [  124.051295]  ret_from_fork+0x22/0x30
> [  124.051295] ---[ end trace 7f77ee8ad05caa89 ]---
> [  124.051296] Kernel Offset: disabled
> 
> Specifying nofsgsbase avoids the issue. This is very reproducible, so I
> can easily test any fixes.
> 
> Thanks,
> Tom
> 
