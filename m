Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDF5C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A651620870
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 15:24:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oRrUlD/5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="oRrUlD/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgBKPY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 10:24:56 -0500
Received: from mail-eopbgr30057.outbound.protection.outlook.com ([40.107.3.57]:26533
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbgBKPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 10:24:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1JabDj7HvuFx1vmUV9aRVkYIb25mz77fdQUDl8oMeA=;
 b=oRrUlD/5cK8hp911Z1oECkx9DlwIoZatpYnQMH7IuEPSxigAHaChZpgpyofsWwLnfFwOWonIso72lAlnCBNTAwNna64ZDzqL5dfj4yKKHiWd/ZT5CKJyAjAyiITN1CwVPc0gvqNHxGLYYymxw9sC6nIweVP6a4t507XaGyU9ARI=
Received: from VI1PR08CA0267.eurprd08.prod.outlook.com (2603:10a6:803:dc::40)
 by VI1PR08MB3278.eurprd08.prod.outlook.com (2603:10a6:803:48::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.25; Tue, 11 Feb
 2020 15:24:49 +0000
Received: from AM5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::209) by VI1PR08CA0267.outlook.office365.com
 (2603:10a6:803:dc::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend
 Transport; Tue, 11 Feb 2020 15:24:49 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT051.mail.protection.outlook.com (10.152.16.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.18 via Frontend Transport; Tue, 11 Feb 2020 15:24:48 +0000
Received: ("Tessian outbound 0420f1404d58:v42"); Tue, 11 Feb 2020 15:24:48 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: d38dc799712aeb06
X-CR-MTA-TID: 64aa7808
Received: from b530c31315c7.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C074DD3B-302D-4FC5-B6B4-D9D70927C2EA.1;
        Tue, 11 Feb 2020 15:24:43 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b530c31315c7.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 11 Feb 2020 15:24:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I+n8d5166ITUapudqOqigNLwvbNYfcTXeGMCvb8hOAUBLerW54aha0TlHN/xX/Vta7BVd3DUBjYra6V2sbGa7ZF5qYn3gJosq87qqe8yn4Lzitl14A6h8+Xiy8YBgGKpv6gc+zOcsfUpyPV4NGKgCxq4VKxB5e69wt7XEdOsQxwIYdemZnIagmxfJ9+f7zElNoHB52N2QPu1ktdd/0foBDHD5zrUJRjNBt72M3hpWTN22UT2oypiOwc7lPbrp2kakhy3HkhRwe8evg5yVAuM2kfLkhUHsBYL19r8FwNak84qN16xqh+jwSoACffXNK/2Jqo5ch32qGNMDZTo9C+fgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1JabDj7HvuFx1vmUV9aRVkYIb25mz77fdQUDl8oMeA=;
 b=du7nYAYa/hZuEdi7VpCOU/rB6ycANdfvuwAAD8H97xwz1CMVlTnMoaRdUGc2FgLNKHbe9RnrYi1PkK+RB6EvrKY8x4M09btLHDmk7hFWq3Fv7qnrEFf+/dU1ySdIFHVQIZLQHwm4O/lfh2lBhtgEpb721spqD/Ve7dnCeippL2I7e9PUeLmFBT1XE5mDQwxyVY0vAhx8rOYnBnYg80LPwSKbBGrlXBZleAx7nEbeoz0tM+dHcTrXuKIIB0D7BAD7MXfyG5o5ZifiSWWGFHyQgb4CGLtORAFwraGFzLRdC1eTCF4OzQwUo9Vxu8fH6kN/BnBJboZIoNQWRGSaXm3d7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1JabDj7HvuFx1vmUV9aRVkYIb25mz77fdQUDl8oMeA=;
 b=oRrUlD/5cK8hp911Z1oECkx9DlwIoZatpYnQMH7IuEPSxigAHaChZpgpyofsWwLnfFwOWonIso72lAlnCBNTAwNna64ZDzqL5dfj4yKKHiWd/ZT5CKJyAjAyiITN1CwVPc0gvqNHxGLYYymxw9sC6nIweVP6a4t507XaGyU9ARI=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com (10.169.225.144) by
 DB6PR0801MB1816.eurprd08.prod.outlook.com (10.169.227.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Tue, 11 Feb 2020 15:24:40 +0000
Received: from DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::c994:c6af:7fbe:c87a]) by DB6PR0801MB1638.eurprd08.prod.outlook.com
 ([fe80::c994:c6af:7fbe:c87a%5]) with mapi id 15.20.2707.030; Tue, 11 Feb 2020
 15:24:39 +0000
Subject: Re: [PATCH RFC 0/7] perf pmu-events: Support event aliasing for
 system PMUs
To:     John Garry <john.garry@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, will@kernel.org, ak@linux.intel.com
Cc:     linuxarm@huawei.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        zhangshaokun@hisilicon.com, robin.murphy@arm.com
References: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
From:   James Clark <james.clark@arm.com>
Message-ID: <91a62136-219a-766a-12e4-be2b2cc8ae54@arm.com>
Date:   Tue, 11 Feb 2020 15:24:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1579876505-113251-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::15) To DB6PR0801MB1638.eurprd08.prod.outlook.com
 (2603:10a6:4:38::16)
MIME-Version: 1.0
Received: from [10.32.36.33] (217.140.106.40) by LO2P265CA0243.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Tue, 11 Feb 2020 15:24:39 +0000
X-Originating-IP: [217.140.106.40]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2445ce5-5ced-4d60-7fad-08d7af06887b
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1816:|DB6PR0801MB1816:|VI1PR08MB3278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB327878329C8D3EE40531BC6AE2180@VI1PR08MB3278.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 0310C78181
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(189003)(199004)(6486002)(66946007)(66476007)(8936002)(86362001)(26005)(66556008)(4326008)(8676002)(16576012)(31696002)(52116002)(81166006)(81156014)(7416002)(53546011)(316002)(956004)(2616005)(186003)(44832011)(16526019)(31686004)(5660300002)(478600001)(2906002)(36756003)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0801MB1816;H:DB6PR0801MB1638.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: Yd0s2TDXzl0XEzogBrW4P6RQorjX7efl+cBqiGkBoXt3GoLP6sGe1Avp/8ZdBLPMApPC7wy/pzujNt4teBSGdAHvl1x2nvCStek23/rknRYwREo7xS8+lXC+epHz2gN73uapXKYf9cwTgIR4JL34V7pX4aYUve7J4zDpR9lwmxqEPdtqTwgYLaJXi8KlfAbKZ4wK+xRpzVgbvyP1u645X2KTqeHq4+ZOlLjdIFgZ5MNdoHjWaqMNFbjbTYJduxk2nhd9763lRp5EDRtkWECLHyQxGBp5vHn2fdAUumWlldTBc6WmGM4XkH2uuw0oxczHl3EOhPSWBpYtJW5CKecgvTzIttkROlhiO0NYCtOKuWQQV4vyVRQhmfIPqqaRJVn1tYccFIj4I8W3olUayAgYdGRCtmqvO9YVdO9sd9TwlEhEp198ULWL6PDiafjyv/UaWvf6ZSDSgAZZkk9Eec2bwROWB52uXEMe24knUXfSIKHjK5n7S4B5siLJSXTtg+Y3
X-MS-Exchange-AntiSpam-MessageData: sGdC9SNha6yZfXbLOqvtXrXqB120/1umeIL09+c0bkeT2SVtFQpoTfOCyJFTGWXMi39ucafm8TqAnEfJC07quTOLL/EKoJpdSl4piY/fYGZwzJFzkndmfj5uSAt+Ibi/FfSKJzOH2X6RkQcmTWRc+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1816
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=James.Clark@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(376002)(346002)(39860400002)(189003)(199004)(31686004)(36906005)(31696002)(53546011)(2906002)(316002)(4326008)(8936002)(36756003)(356004)(16576012)(81166006)(81156014)(8676002)(86362001)(336012)(6486002)(5660300002)(478600001)(26826003)(44832011)(70206006)(70586007)(26005)(16526019)(186003)(2616005)(956004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3278;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 3a180cb6-5ec4-487d-fd65-08d7af0682e0
X-Forefront-PRVS: 0310C78181
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /WkP7PqnxBAJUqcRbJXojhJFOirVfmY+CcFsOcukxzHkfOCPIkQHwsnu1O6AHcRrwLlakLUWKolC3IY/XPjTmSucHMa5ILU92GEi/ls1diGpHQaNBT7clAvn7srLJDqx2IpcNg/CbslZlelJVlibQjrzYoGFjVMdnRYlSxbebU+1yFnpumt1turddMPT1gFb3xQMEpzJsMAJ9p+AmBYmRWMRE3YzxXDoExzP5lWk24cnvyxfsRau4BPCK3UJj/5wS36/jmi0PC61aw6P1OXMspe/6iWQabc9pyc+xvTGK33cfi2kvpbBva0HUqbjjkKyJ3AYAA3f6jWl4VhQED68AUU06O45jLGj/bN3PiyVkxI/DjrJUg45ZsGP7Tkf9KgpgMpQo220IvQz4yrpiBjnURI0GmshwDKUvDtWDs/zmTfzqPZo2onRv9UC8XWJtll1bI20Qa8rJZrsmLtsOP9dCBvOVEyXjdV8Q25R6PhrCG24McgvpnV3sGTg9Pxd5bTZ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2020 15:24:48.9863
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2445ce5-5ced-4d60-7fad-08d7af06887b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3278
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

I tested this on an Arm N1 board and see the same list of CPU events from t=
he JSONs
picked up so it looks ok from that point of view.

James

On 1/24/20 2:34 PM, John Garry wrote:
> Currently event aliasing for only CPU and uncore PMUs is supported. In
> fact, only uncore PMUs aliasing for when the uncore PMUs are fixed for a
> CPU is supported, which may not always be the case for certain
> architectures.
>
> This series adds support for PMU event aliasing for system and other
> uncore PMUs which are not fixed to a specific CPU.
>
> For this, we introduce support for another per-arch mapfile, which maps a
> particular system identifier to a set of system PMU events for that
> system. This is much the same as what we do for CPU event aliasing.
>
> To support this, we need to change how we match a PMU to a mapfile,
> whether it should use a CPU or system mapfile. For this we do the
> following:
>
> - For CPU PMU, we always match for the event mapfile based on the CPUID.
>   This has not changed.
>
> - For an uncore or system PMU, we match first based on the SYSID (if set)=
.
>   If this fails, then we match on the CPUID.
>
>   This works for x86, as x86 would not have any system mapfiles for uncor=
e
>   PMUs (and match on the CPUID).
>
> Initial reference support is also added for ARM SMMUv3 PMCG (Performance
> Monitor Event Group) PMU for HiSilicon hip08 platform with only a single
> event so far - see driver in drivers/perf/arm_smmuv3_pmu.c for that drive=
r.
>
> Here is a sample output with this series:
>
> root@ubuntu:/# ./perf list
>   [...]
>
>   smmuv3_pmcg_100020/config_cache_miss/              [Kernel PMU event]
>   smmuv3_pmcg_100020/config_struct_access/           [Kernel PMU event]
>   smmuv3_pmcg_100020/cycles/                         [Kernel PMU event]
>   smmuv3_pmcg_100020/pcie_ats_trans_passed/          [Kernel PMU event]
>   smmuv3_pmcg_100020/pcie_ats_trans_rq/              [Kernel PMU event]
>   smmuv3_pmcg_100020/tlb_miss/                       [Kernel PMU event]
>   smmuv3_pmcg_100020/trans_table_walk_access/        [Kernel PMU event]
>   smmuv3_pmcg_100020/transaction/                    [Kernel PMU event]
>
>   [...]
>
> smmu v3 pmcg:
>   smmuv3_pmcg.l1_tlb
>        [SMMUv3 PMCG l1_tlb. Unit: smmuv3_pmcg]
>
>   [...]
>
> root@ubuntu:/# ./perf stat -v -e smmuv3_pmcg.l1_tlb sleep 1
> Using CPUID 0x00000000480fd010
> Using SYSID HIP08
>  -> smmuv3_pmcg_200100020/event=3D0x8a/
>  -> smmuv3_pmcg_200140020/event=3D0x8a/
>  -> smmuv3_pmcg_100020/event=3D0x8a/
>  -> smmuv3_pmcg_140020/event=3D0x8a/
>  -> smmuv3_pmcg_200148020/event=3D0x8a/
>  -> smmuv3_pmcg_148020/event=3D0x8a/
> smmuv3_pmcg.l1_tlb: 0 1001221690 1001221690
> smmuv3_pmcg.l1_tlb: 0 1001220090 1001220090
> smmuv3_pmcg.l1_tlb: 101 1001219660 1001219660
> smmuv3_pmcg.l1_tlb: 0 1001219010 1001219010
> smmuv3_pmcg.l1_tlb: 0 1001218360 1001218360
> smmuv3_pmcg.l1_tlb: 134 1001217850 1001217850
>
>  Performance counter stats for 'system wide':
>
>                235      smmuv3_pmcg.l1_tlb
>
>        1.001263128 seconds time elapsed
>
> root@ubuntu:/#
>
> Issues with this series which need to be addressed (aware to me):
>
> - It would be good to have a universal method to identify the system from
>   sysfs. Nothing exists which I know about. There is DMI, but this is not
>   always available (or has correct info). Maybe systems which want to
>   support this feature will need a "soc" driver, and a
>   /sys/devices/socX/machine file (which I used for testing this series -
>   this driver is out of tree currently).
>
> - Maybe it is ok, but for systems which match on the system identifier,
>   uncore PMUs should be in the system mapfile, and, as such, match on the
>   system identifier and not CPU identifier.
>
> - We need a better way in jevents.c to give a direct mapping of PMU name
>   aliases, i.e. for any PMU name not prefixed with "uncore_", we need to
>   add this to table unit_to_pmu[]. Not scalable.
>
>   Having said that, maybe the kernel can introduce some future PMU naming
>   convention in future.
>
> John Garry (7):
>   perf jevents: Add support for an extra directory level
>   perf vendor events arm64: Relocate hip08 core events
>   perf jevents: Add support for a system events PMU
>   perf pmu: Rename uncore symbols to include system pmus
>   perf pmu: Support matching by sysid
>   perf vendor events arm64: Relocate uncore events for hip08
>   perf vendor events arm64: Add hip08 SMMUv3 PMCG IMP DEF events
>
>  tools/perf/arch/arm64/util/arm-spe.c          |   2 +-
>  tools/perf/pmu-events/README                  |  47 ++++++--
>  .../hip08/{ =3D> cpu}/core-imp-def.json         |   0
>  .../hisilicon/hip08/sys/smmu-v3-pmcg.json     |   9 ++
>  .../hip08/{ =3D> sys}/uncore-ddrc.json          |   0
>  .../hisilicon/hip08/{ =3D> sys}/uncore-hha.json |   0
>  .../hisilicon/hip08/{ =3D> sys}/uncore-l3c.json |   0
>  tools/perf/pmu-events/arch/arm64/mapfile.csv  |   2 +-
>  .../pmu-events/arch/arm64/mapfile_sys.csv     |  14 +++
>  tools/perf/pmu-events/jevents.c               |  65 ++++++++--
>  tools/perf/pmu-events/pmu-events.h            |   1 +
>  tools/perf/util/evsel.h                       |   2 +-
>  tools/perf/util/parse-events.c                |  12 +-
>  tools/perf/util/pmu.c                         | 111 +++++++++++++++---
>  tools/perf/util/pmu.h                         |   2 +-
>  15 files changed, 221 insertions(+), 46 deletions(-)
>  rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ =3D> cpu}/core=
-imp-def.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip08/sys/=
smmu-v3-pmcg.json
>  rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ =3D> sys}/unco=
re-ddrc.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ =3D> sys}/unco=
re-hha.json (100%)
>  rename tools/perf/pmu-events/arch/arm64/hisilicon/hip08/{ =3D> sys}/unco=
re-l3c.json (100%)
>  create mode 100644 tools/perf/pmu-events/arch/arm64/mapfile_sys.csv
>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
