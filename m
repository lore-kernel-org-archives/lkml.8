Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C795206A1
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 08:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="f7kp1c3Z";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="f7kp1c3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgGAIPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 04:15:46 -0400
Received: from mail-eopbgr20076.outbound.protection.outlook.com ([40.107.2.76]:15017
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728143AbgGAIPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 04:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRx8kYHZufOIqhZYbL574uFb/KVqp1zI5q93j0FehyE=;
 b=f7kp1c3Z0SeaqVG24UY3wV5ePVhbPtnfv4cqUgWxyCxmAEpQv8TwA+Osu1qjoL2bOgbrQnQTM1NCOPIqtDVV1Q+c40r/r3OdZjPuG7e2Tp7Be/7vgup2JLDw6DjIsXnQU8ChQyLwwQOQS/QtaGNChl3aMixJtA7ue8S1wj6n0Gw=
Received: from DB6PR0202CA0047.eurprd02.prod.outlook.com (2603:10a6:4:a5::33)
 by DB6PR08MB2903.eurprd08.prod.outlook.com (2603:10a6:6:25::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.24; Wed, 1 Jul
 2020 08:13:05 +0000
Received: from DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::ef) by DB6PR0202CA0047.outlook.office365.com
 (2603:10a6:4:a5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend
 Transport; Wed, 1 Jul 2020 08:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT044.mail.protection.outlook.com (10.152.21.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.20 via Frontend Transport; Wed, 1 Jul 2020 08:13:04 +0000
Received: ("Tessian outbound 7fd8d0809508:v61"); Wed, 01 Jul 2020 08:13:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4d5bb1ede1bb4d0c
X-CR-MTA-TID: 64aa7808
Received: from b03614350a89.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 4841E48D-18F5-434C-9D72-D3CEE37EEC40.1;
        Wed, 01 Jul 2020 08:12:58 +0000
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b03614350a89.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 01 Jul 2020 08:12:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bKBi+m0fwdU5ChhO6CQz3EskeUvl6RCg2nYlOMOpMxhRkoDUfJ04chNSWIgTjfl7E404zrGQ+ueDr+gfWcDSLAvEm1dCv3fRqWbeZNnJJKbmFH+/SF2rxkykA0sVdv5QlzeO7yWmxzpIrrnj3mGovJ0ivXGPWGC794TctmQQQfSaugDb2EMWnIHCvIXkVIVgruHWYGedJWuB/eGoUrjsuUPDNPwCZDAGxHTPtpgXraCjmRImH7sxtsCBi0bDmywFP7y7pQcN2Ln9j2zErIoB1JzNUnNsU2sxgCnzIuf9d4JkmHgaiX7k89/CNsQ6WjI+HE72YWfg/mgEbK9Qd1a7fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRx8kYHZufOIqhZYbL574uFb/KVqp1zI5q93j0FehyE=;
 b=j/2PBOAmggIH+mG1OAgDi2wvFKcDSMQDk6NCoi6TF2aKw4/QDrcC8EkJqrBQG+m0jg6tFq/Lveaa4+hoGsUVKpVDMYn4WXJ4opaGj/H6RZCAQMTQ2wpWbmzFGSAJin8p0ZJtxjAshb+1Crki04+lb58I5bHgDwPwHXVSBpvBB3zFPSrJPPjVUkEGx5pXt4/jFs7xAIyZS3id/OjbPffxkdwA54tD2g5OiI7EHBsRnvsNwIIPjdR/hbps9cC2VvyfaPtyy6+q0uH2HYHvd8bedSZJOfKieA4IBms9krRjK6fYlhupkQpdpZNKH3ZwOUx1Opa1AXwniWo+WLri8++Hkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CRx8kYHZufOIqhZYbL574uFb/KVqp1zI5q93j0FehyE=;
 b=f7kp1c3Z0SeaqVG24UY3wV5ePVhbPtnfv4cqUgWxyCxmAEpQv8TwA+Osu1qjoL2bOgbrQnQTM1NCOPIqtDVV1Q+c40r/r3OdZjPuG7e2Tp7Be/7vgup2JLDw6DjIsXnQU8ChQyLwwQOQS/QtaGNChl3aMixJtA7ue8S1wj6n0Gw=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB4149.eurprd08.prod.outlook.com (2603:10a6:20b:b0::27)
 by AM5PR0801MB1827.eurprd08.prod.outlook.com (2603:10a6:203:3c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.25; Wed, 1 Jul
 2020 08:12:57 +0000
Received: from AM6PR08MB4149.eurprd08.prod.outlook.com
 ([fe80::95a:fa75:ba76:dcb5]) by AM6PR08MB4149.eurprd08.prod.outlook.com
 ([fe80::95a:fa75:ba76:dcb5%5]) with mapi id 15.20.3131.030; Wed, 1 Jul 2020
 08:12:57 +0000
Subject: Re: [PATCH v4 00/14] arm64: Optimise and update memcpy, user copy and
 string routines
From:   Oli Swede <oli.swede@arm.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200630194822.1082-1-oli.swede@arm.com>
Message-ID: <f52401d9-787c-667b-c1ec-8b91106d6d14@arm.com>
Date:   Wed, 1 Jul 2020 09:12:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200630194822.1082-1-oli.swede@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR16CA0067.namprd16.prod.outlook.com
 (2603:10b6:805:ca::44) To AM6PR08MB4149.eurprd08.prod.outlook.com
 (2603:10a6:20b:b0::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.20.213] (217.140.99.251) by SN6PR16CA0067.namprd16.prod.outlook.com (2603:10b6:805:ca::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Wed, 1 Jul 2020 08:12:55 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 07c14bdc-3241-4517-5e4f-08d81d9694c7
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1827:|DB6PR08MB2903:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR08MB2903FB2865A3AF7046F2A6C6EF6C0@DB6PR08MB2903.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 04519BA941
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: bvbC7bPyc9ZGdb636rrzDPB9WpycnMXr/jxLoonh9kztOMs03HQK+sHVwSLMPzx8klbIqMHk7r6eF6OqRwFXT+eobF1HIYeVRMOum5gS/lQEuohX2pS1ZtDoiSKqDN2rHaTb0tQDFR1GKJnufneBzn98REsGiihywLSl1AxQHmMvUqDLI3rK0F9e6+I3lf365SGHwswclViN0EfZpHHlRPk3CkMzpDnoKVo2wqbm4Sf368fK4gP10URrBGJPSDbRWTr2fRyHhTIsW/vzCtHuP7s2hqRfszPeGTDqOorfYZnWIZj6FrLtNyh0sgaAgLOl9LZFZJU+QYFxBfAOJqI86JI5j7i6FC54fDklhhQRASLy0wlnurOzqvhjEtKF8V6XRrQBcCSgco2Vl0JBH9gKEX+VqMgutAXoyiJVKtZmr/linzrgA7NGOSaUzMAd/9ztcptZRf5OKYxipG/a8acQpA==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4149.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(16576012)(26005)(83380400001)(31686004)(316002)(16526019)(86362001)(110136005)(8936002)(15650500001)(4326008)(478600001)(52116002)(6486002)(66946007)(956004)(6636002)(8676002)(36756003)(2616005)(66476007)(66556008)(5660300002)(53546011)(2906002)(186003)(966005)(31696002)(6666004)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: K0Ls6hAjRy+6LRCz6rz1PjilNNzAcaP+V+GV/zGAyrFXl2uVgtk997vmguUHSNWn88MgduJYUYWmKhbvvDa4AwQewc0vVfKOqfwDqkeB5r3bPcYfZrvriaXuGZUGiSIJN7uBIfwfiEqYRK1ugy5VLW7MHHEF+0HslqzoJHGy9p4Z+RZipMFb6nRa4+ljIRz6PZeCBRZTV3wrT6P62i0zFot46mcM0QaM+hvQpdaEKdsyVGfyzHJWWcyqGM1AZszZ/qOsVPYiVwm00c4uahTn7KfA0s6ArjFb9c7ymP3v9NM/ZPrIBrAsfga+udt0zkIEqUpYTwO5hdGGK6AXhvHZsIfNxJSOoYtFa+KiNPtdNCgXDT2TbbiPTbs+AmhdZ1s84q+BR9SWtt18fhPEht7RCmP6/wvnOAjMDWPErgvN/ietzaYPLh0/sr7ABOrdbxpFnlmvfPcPEGY9nnFawWi3YlZOdUtxGwqZmLPMPvorH64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1827
Original-Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(46966005)(83380400001)(70206006)(8936002)(70586007)(8676002)(316002)(966005)(36756003)(186003)(336012)(26005)(16526019)(81166007)(6486002)(2616005)(16576012)(5660300002)(82310400002)(956004)(478600001)(6666004)(44832011)(6636002)(2906002)(31696002)(86362001)(82740400003)(47076004)(15650500001)(110136005)(4326008)(53546011)(356005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 32420ca2-654c-4a6f-f192-08d81d968fd9
X-Forefront-PRVS: 04519BA941
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F4200EMxhxUvgrFVvaOrNQf08j6IcMd2ziAl2FFIxNeRzjP6Kl2K1JLTuTMtA9/MRVj2gUAW5Z3CXnXH+bnqbKjn34i6dE+QbL8TiwnIkKNrRY5J9QN+grwq5wqowxYDyhz8gBpIEov+JRla4NU+R2ArsGxsnXgPtQiD21Nt/hvdb1POSGU+MYIhVNrOsO72PYoihem/yGZFjIs1/ZaPPRR4InlQLYTCGR47h0tY7u6szSnuF8wRDHlJvlVRpElctIzYDePHr+tl9tiyH+ruqaufofmoOWOsuSTAD+PZsUtFE2US5RDFTjPWeSwJIk97yWqWFDMKXWVld6m2yT1HyLS2oD6Xt/qWp9j2HX41gg0OCaN8WcmCJcC83zSy+KSYkmHlu8pmhWbE/I/AxQwwiyEf2iJJprZt1NDsL53eogyB2YUQHgUfev8/mDMOu99MhXNpaCXhxk8Pl3arMHnJI7OdPE8U79e64wZzDehSq/c5y28NEPrckTUfc0AssgNH
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2020 08:13:04.9459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c14bdc-3241-4517-5e4f-08d81d9694c7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT044.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2903
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

(Apologies if you have already received this follow-up, please ignore 
any previous duplicates; I am re-sending this with the lists in the CC 
as the formatting filters caught me out :) Thanks ]

 > Version 3 addressed this but I later found some issues with the fixup
 > correctness after further testing, and have partially re-written them
 > here, and addressed some other behaviours of the copy algorithm.

Further to the above description from the cover letter I have expanded 
on this below.

The approach introduced in this version redirects the faulting 
instruction to one of multiple fixup subroutines, depending on 
properties of the instance of the instruction in the copy template: if 
it specifies the target address relative to the start or end of the 
buffer, and if the algorithm has reached a stage where the destination 
address has been set to be 16-byte aligned (this is more relevant for 
longer copies).

These two properties are both in relation to the copy algorithm's aim at 
reducing the number of total instruction by making accesses that may 
overlap, and thus copy the same data multiple times. This is in contrast 
to the current algorithm which may need to branch to subroutines that 
complete an odd number of bytes that isn't divisible by the initial unit 
that was directed to. E.g. with the new algorithm, 17 bytes will 
complete with two load and two store instructions, by coping the first 
16 bytes from the start of the buffer, then the last 16 bytes to the 
left of the end of the buffer.

There appear to be two types of overlapping copies within a source or 
destination buffer:
1. If src is initially non-16-byte aligned, then it is re-set to (src &~ 
15), and the copying then resumes from aligned_src+16. In this scenario 
any data between aligned_src+16 and src+16 could repeat in the 
overlapping instruction.
2. If the target address is specified relative to the end of the buffer 
(e.g. [srcend, -16]) then an overlap is taking place, so it should check 
the fault address against the threshold known to have already been 
copied up to.

In particular, encapsulating these properties through separate fixups 
allows for:

a) Accurate rounding-down to the base of the block within which the 
fault occurred.
The assumption here is that load and and store instructions are 
single-copy atomic, so a fault in one instruction will not result in any 
of the other bytes succeeding. For instance, the copy unit size could be 
1, 4, 8, or 16, depending on the instruction (ldrb/strb, ldr/str, or 
ldp/stp), but any threshold prior to which copying may have succeeded 
will be the target address, i.e. the base of this block.
If the fixup routing itself implies certain information about the target 
address, then the scenario shouldn't occur where it faults on an address 
but the backtracking to the target is inaccurate (as a result of copy 
overlaps within the buffer).

b) All data copied up to some address to be taken into account, in the 
case where a page is swapped out immediately before the same address is 
accessed as a result of an overlap.
This is somewhat related to the above, but addresses a specific 
situation, where a page could be swapped out mid-way through a copy and 
result in the same address faulting on its second copy, even if the 
algorithm has succeeded up to a threshold address beyond the fault.

Within each fixup is the calculation for the number of bytes remaining 
is performed, with the knowledge about the stage of the algorithm that 
has been reached and any previous steps before the fault, and the 
information retrieved from the stack, which contains the original 
arguments to the usercopy function. It is then able to determine the 
accurate return value. For systems implementing UAO, due to the ldp/stp 
instructions being substituted for 2x ldtr/sttr instructions, a fault in 
the second half of the doubleword needs to to take any completion of the 
first half into account, and there are in-line modifications for this 
(but they are not necessary for the load instruction fixups).

The categorization of the fixups based on the algorithm's behaviour may 
also provide a general approach to replacing the fixups for future copy 
imports, as they are fairly modular. However, there is an open question 
as to whether it would be easy to replace them given this framework, as 
the fixup subroutines are relatively long for the store instructions. I 
have added comments to explain the calculations, but I am wondering if 
it would be possible to divert the fixup logic to make it easier to 
modify, if the aim is to reduce the coupling between the fixup routines 
and the copy algorithm.

I am waiting on access to the relevant machine before posting the 
benchmark results for this optimized memcpy, but Sam reported the 
following with the similar (but now slightly older) cortex-strings version:
   * copy_from_user: 13.17%
   * copy_to_user: 4.8%
   * memcpy: 27.88%
   * copy_in_user: Didn't appear in the test results.
This machine will also be used to check the fixups are accurate on a 
system with UAO - they appear to be exact on a non-UAO system with PAN 
that I've been working on locally.

I should also mention that the correctness of these routines were tested 
using a selftest test module akin to lib/test_user_copy.c (whose 
usercopy functionality checks these patches do pass) but which is more 
specific to the fixup accuracy, in that it compares the return value 
with the true number of bytes remaining in the destination buffer at the 
point of a fault.

Thanks in advance,
Oliver

On 6/30/20 8:48 PM, Oliver Swede wrote:
> Hi,
> 
> This contains an update to the cortex-strings patchset: the
> correctness of the fixup routines are improved, with the aim being to
> return the exact number of remaining bytes for all copy sizes.
> To ensure they are exact - which the current fixups are not for some
> copy sizes and are off by a few byes - is an extension to the
> original intention of fixing an issue reported by an LTP run last
> year, where the fixup routine in v2 of this patchset (which was
> importing the cortex-strings memcpy implementation) would over-report
> the number of bytes that successfully copied.
> Version 3 addressed this but I later found some issues with the fixup
> correctness after further testing, and have partially re-written them
> here, and addressed some other behaviours of the copy algorithm.
> 
> Comments welcome,
> 
> Thanks
> Oliver
> 
> v1: https://lore.kernel.org/linux-arm-kernel/cover.1571073960.git.robin.murphy@arm.com/
> v2: https://lore.kernel.org/linux-arm-kernel/cover.1571421836.git.robin.murphy@arm.com/
> v3: https://lore.kernel.org/linux-arm-kernel/20200514143227.605-1-oli.swede@arm.com/
> 
> Changes since v3:
> * Improves the accuracy of the fixups in response to issues that
>    arose during futher testing
> * Accounts for faults on store instructions on systems with UAO
>    enabled
> * Expands on comments detailing the implementation
> 
> Changes since v2:
> * Adds Robin's separate patch that fixes a compilation issue with
>    KProbes fixup [1]
> * Imports the most recent memcpy implementation by updating Sam's
>    patch (and moves this patch to occur after the cortex-strings
>    importing so that it's closer to the patches containing its
>    corresponding fixups)
> * Uses the stack to preserve the initial parameters
> * Replaces the usercopy fixup routine in v2 with multiple longer
>    fixups that each make use of the fault address to return the exact
>    number of bytes that haven't yet copied.
> 
> [1] https://lore.kernel.org/linux-arm-kernel/e70f7b9de7e601b9e4a6fedad8eaf64d304b1637.1571326276.git.robin.murphy@arm.com/
> 
> Oliver Swede (5):
>    arm64: Store the arguments to copy_*_user on the stack
>    arm64: Use additional memcpy macros and fixups
>    arm64: Add fixup routines for usercopy load exceptions
>    arm64: Add fixup routines for usercopy store exceptions
>    arm64: Improve accuracy of fixup for UAO cases
> 
> Robin Murphy (2):
>    arm64: kprobes: Drop open-coded exception fixup
>    arm64: Tidy up _asm_extable_faultaddr usage
> 
> Sam Tebbs (7):
>    arm64: Allow passing fault address to fixup handlers
>    arm64: Import latest version of Cortex Strings' memcmp
>    arm64: Import latest version of Cortex Strings' memmove
>    arm64: Import latest version of Cortex Strings' strcmp
>    arm64: Import latest version of Cortex Strings' strlen
>    arm64: Import latest version of Cortex Strings' strncmp
>    arm64: Import latest optimization of memcpy
> 
>   arch/arm64/include/asm/alternative.h |  36 ---
>   arch/arm64/include/asm/assembler.h   |  13 +
>   arch/arm64/include/asm/extable.h     |  10 +-
>   arch/arm64/kernel/probes/kprobes.c   |   7 -
>   arch/arm64/lib/copy_from_user.S      | 272 +++++++++++++++--
>   arch/arm64/lib/copy_in_user.S        | 287 ++++++++++++++++--
>   arch/arm64/lib/copy_template.S       | 377 +++++++++++++----------
>   arch/arm64/lib/copy_template_user.S  |  50 ++++
>   arch/arm64/lib/copy_to_user.S        | 273 +++++++++++++++--
>   arch/arm64/lib/copy_user_fixup.S     | 433 +++++++++++++++++++++++++++
>   arch/arm64/lib/memcmp.S              | 333 ++++++++------------
>   arch/arm64/lib/memcpy.S              | 127 ++++++--
>   arch/arm64/lib/memmove.S             | 232 +++++---------
>   arch/arm64/lib/strcmp.S              | 272 +++++++----------
>   arch/arm64/lib/strlen.S              | 247 ++++++++++-----
>   arch/arm64/lib/strncmp.S             | 363 ++++++++++------------
>   arch/arm64/mm/extable.c              |  13 +-
>   arch/arm64/mm/fault.c                |   2 +-
>   18 files changed, 2228 insertions(+), 1119 deletions(-)
>   create mode 100644 arch/arm64/lib/copy_template_user.S
>   create mode 100644 arch/arm64/lib/copy_user_fixup.S
> 
