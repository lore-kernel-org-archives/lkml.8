Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400DBC33CA8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0526D2081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qoNqA4oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbgAMJzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:55:22 -0500
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:48865
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgAMJzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:55:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAXcq11V1ZYgntbTJROwAyg/cnkV2nMAhqrod47T07vEWRVZF7Gtct+HmZPbMYxuJl4Apxp4Czh8qSG64d7GIqRZMHzk2zchQlqlr2rb+wmXm0XLhDtgZ2AanWaxPGysHhYiL/MbDGhAl8pCOGrUUX9+zhvSVeb+XUl3p+81qbIMPcIvlZk1f4XRpV53gN5Fg/2c73u3700xCuvmWU+tBDqTPP7rBealeNxADByWBT4IDpZR+uMVIa3Q6kmuuH7+M52DJEA1tV/1hHR+oqJWCkdze1Q56U4rh1ZUxhC5D7rbr7kIZjgmLjJJrWJXwIKjM7PBzz+FXKdKzetvUryXkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTt+hGV0TORRvre0z3JZUBb3t0xKciEw1B1hUSY9Qs8=;
 b=f6KJefHVAkC5tBhIhLEqBqffHRLPDK8gD9+tN+PCJFQgtfWABI8B6GZOHMkH8O7dbMboZ/q6o52n2KBkcblc6okJiWF+eB4SlMZugFHXNJK2XApVk7rFHRUGj8isOrHdfUcigCZePrHj1z5g8xkyCD1HGQ8mam61QkavU/9slEdtxHxxxGaeWqDso+g5wWvcaTxBrIikoYl9qOsRv1Rgye7X0LQ8iKyCRBgtUKbezN6BeiewDmHZzW9kCRSZ2J0Gj5oZAemue2l3Kf9WYpgV8Gy+O7lLjIydjcGlcMnnQn7+o3uZdiFriXkn/D3BpkIKlXVPdr/f31pkc99s6qY17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTt+hGV0TORRvre0z3JZUBb3t0xKciEw1B1hUSY9Qs8=;
 b=qoNqA4oaiqoLfPV4SPtLhKLX8p0QlxTFqAYCzEVbu5WQxFibC0FUM/HuJtWzniGJrLrymL8/Y8TV2kq3LETQvghi/+njAg9+yZXSrjfVr71meRAQFV1k4w5zmcY7Un2s9IAMVcddFnvSimRuBkNRlGtGI2Kbi+cryZlSCsD8KlE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com; 
Received: from DM6PR12MB3865.namprd12.prod.outlook.com (10.255.172.206) by
 DM6PR12MB3484.namprd12.prod.outlook.com (20.178.199.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Mon, 13 Jan 2020 09:55:14 +0000
Received: from DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::fdd1:4a97:85cc:d302]) by DM6PR12MB3865.namprd12.prod.outlook.com
 ([fe80::fdd1:4a97:85cc:d302%3]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 09:55:14 +0000
Subject: Re: [PATCH] x86/fpu: Warn only when CPU-provided sizes less than
 struct declaration
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        jon.grimm@amd.com,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>
References: <1575363688-36727-1-git-send-email-suravee.suthikulpanit@amd.com>
 <b63e2111-b0c6-a716-3d99-88f91ad64e1d@intel.com>
 <68bdd6f0-a229-433a-9234-303a3b02b092@amd.com>
 <4b20cff5-6e16-3599-4fc1-4f51d7c18d1d@intel.com>
 <7a8fe748-2c57-295a-e6ed-8969c41462aa@amd.com>
 <d092bae0-69ea-0a57-4db5-6de074956564@intel.com>
 <bac4b1ee-de8c-5e50-dc11-ab432ca0f6af@amd.com>
Message-ID: <71a863a0-800b-0f3b-0846-839512f38208@amd.com>
Date:   Mon, 13 Jan 2020 16:54:52 +0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.3.1
In-Reply-To: <bac4b1ee-de8c-5e50-dc11-ab432ca0f6af@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: KU1PR03CA0019.apcprd03.prod.outlook.com
 (2603:1096:802:18::31) To DM6PR12MB3865.namprd12.prod.outlook.com
 (2603:10b6:5:1c4::14)
MIME-Version: 1.0
Received: from Suravees-MacBook-Pro.local (165.204.100.2) by KU1PR03CA0019.apcprd03.prod.outlook.com (2603:1096:802:18::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.6 via Frontend Transport; Mon, 13 Jan 2020 09:55:08 +0000
X-Originating-IP: [165.204.100.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d91efdb0-d678-4a4a-a7c6-08d7980eafa5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3484:|DM6PR12MB3484:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3484C9C64ACB9E567650F8CBF3350@DM6PR12MB3484.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 028166BF91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(189003)(199004)(4326008)(81166006)(81156014)(52116002)(5660300002)(54906003)(16526019)(6512007)(53546011)(8676002)(6666004)(31686004)(8936002)(316002)(966005)(66476007)(36756003)(6486002)(186003)(2906002)(66556008)(31696002)(66946007)(86362001)(26005)(478600001)(6506007)(44832011)(956004)(2616005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3484;H:DM6PR12MB3865.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3B9hZPK7iMygNRgez8MBFmyMEW36OVrlmZZ5BdzPaqHrSA9lAD/AGxVQL85qENFU+14Xw29I94ibCLacg0ai2FdHdEp1uM7cfnjB1S3k2Fi4OSQZF1pAG9Fsoucwyb7XKMbRv8o2lFB9AT1ypSByTF2Be4BxfNXPRdAcu+sDEJVKVzyU/hWoBgEsw7QL4pgXujGoGRWopuZPy/6lABV++9nFrPqI1K4vDOU6/tEZhgMIIo7Qj7dIWEba3j6dlR9fkCxHFWTaf4MeRFaTRTKK/L0FWRv19kgsLQ4sXGZIAonXOYiO1IRbGIykaEwz5/Jzldqo4KrU6RfsUnAlmjj68tlxPN+K+3TTFsNhW1LnBsiUDGNvG+GyRb9/hoKl2d+heTMbGY38WzP8IeF2wWGPlZZpMYMThcWHklBX4lIQOLfrkBy9CKw0w7OLsKjXnLT9325D7OoLcmFUcf/jbpXvKuUnx+FTVMFiwhG5q/YloN0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91efdb0-d678-4a4a-a7c6-08d7980eafa5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2020 09:55:14.2466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0k2ms62W9O+NtWar43k7rPq6xWNRPP60Fu8jUoKbD8ZtMGV74ini9MgiHv+4JoIuQBaWt0jrv2dK3pyIPpezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3484
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

On 12/12/19 1:52 PM, Suravee Suthikulpanit wrote:
> 
> On 12/11/2019 9:13 PM, Dave Hansen wrote:
>> On 12/10/19 9:24 PM, Suravee Suthikulpanit wrote:
>>> The value returned by ECX[1] indicates the alignment of state
>>> component i when the compacted format of the extended region of an
>>> XSAVE area is used (see Section 13.4.3). If ECX[1] returns 0, state
>>> component i is located immediately following the preceding state
>>> component; if ECX[1] returns 1, state component i is located on the
>>> next 64-byte boundary following the preceding state component.
>>
>> Essentially, if an implementation needs state alignment or (up to) 64
>> bytes of padding, it could use this existing architecture for it.
> 
> Let me check with the HW folks and get back to you on this.

I don't think the 64-byte aligned bit alone would help with the PKRU size mismatch warning in 
check_xstate_against_struct() that we are seeing.

Here is the description from the section 13.4.3, for the compacted format:

* Let j, 2 ≤ j < i, be the greatest value such that XCOMP_BV[j] = 1. Then locationI is
determined by the following values: locationJ; sizeJ, as enumerated in CPUID.(EAX=0DH,ECX=j):EAX;
and the value of alignI, as enumerated in CPUID.(EAX=0DH,ECX=i):ECX[1]:

   — If alignI = 0, locationI = locationJ + sizeJ. (This item implies that state component i is located immediately 
following the preceding state component whose bit is set in XCOMP_BV.)

   — If alignI = 1, locationI = ceiling(locationJ + sizeJ, 64). (This item implies that state component i is located on 
the next 64-byte boundary following the preceding state component whose bit is set in XCOMP_BV.)

According to the description above, since we need to add padding for PKRU state, if we set the aligned bit of the 
subsequent feature after PKRU state, the current Linux kernel would still generate the warning for PKRU since the 
check_xstate_against_struct() does not currently take into account of the align bit (which is only for compact mode).

It would also generate another warning in do_extra_xstate_size_checks() due to XSTATE_WARN_ON(paranoid_xstate_size != 
fpu_kernel_xstate_size) (see https://elixir.bootlin.com/linux/latest/source/arch/x86/kernel/fpu/xstate.c#L608). Note 
that the paranoid_xstate_size takes into account of the 64-byte alignment in the size calculation, but the 
fpu_kernel_xstate_size takes the size reported by CPUID function 0DH, sub-function 0 or 1. So, this logic might need to 
change as well.

As for the PKRU size, it should really be 4 bytes (regardless of the alignment) since that's the size of actual PKRU 
register, but it seems that the 4-byte padding in struct pkru_state was added to match the Intel's CPUID-report size of 
8. Now we also have AMD hardware reporting PKRU size of 32 (also mainly for padding). We shouldn't keep the same warning 
logic in check_xstate_against_struct().

Please let me know if I am still missing anything.

Thanks,
Suravee
