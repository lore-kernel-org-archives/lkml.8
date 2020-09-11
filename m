Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3100EC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA154204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 15:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lPUJH2pg";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="lPUJH2pg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726239AbgIKPTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 11:19:02 -0400
Received: from mail-eopbgr50088.outbound.protection.outlook.com ([40.107.5.88]:2115
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726292AbgIKPO6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:14:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdeOCHkrE7g1daNaRpnzc6/HJu9GDrYoZ9L80Sn6yY=;
 b=lPUJH2pg3N9gEh8RZB5JWEzKOZc7P1fVHfPjY1DbXgGyblD2HdG5BSpkHAvm5TwKrtcLCI6F6wb0TK8ekoXxmbJUM4sLoMpKdMu6kq/XjR5k+3C2IHzi4RZKZaiAnIAXb58jxjtS5pE9w/h/58Cx0Quk8aVFSfiITRZIRBt13iQ=
Received: from AM6PR0202CA0042.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::19) by AM0PR08MB5249.eurprd08.prod.outlook.com
 (2603:10a6:208:15f::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Fri, 11 Sep
 2020 15:14:41 +0000
Received: from AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:3a:cafe::33) by AM6PR0202CA0042.outlook.office365.com
 (2603:10a6:20b:3a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Fri, 11 Sep 2020 15:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT010.mail.protection.outlook.com (10.152.16.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 15:14:41 +0000
Received: ("Tessian outbound bac899b43a54:v64"); Fri, 11 Sep 2020 15:14:40 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 6c1fac655536ea20
X-CR-MTA-TID: 64aa7808
Received: from 0e1f763b1716.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 18177EA2-5AC5-447C-B1D9-4D8F0D55D6A8.1;
        Fri, 11 Sep 2020 15:14:30 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0e1f763b1716.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 11 Sep 2020 15:14:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op4rReB2AAjE+FJlzTYA4L+1qOIcrenJ2SilT1j+o1igHA2WNTvNkB75qbKvzMUDfrxzmhvpGrenq5qKeEm+Bzs/W+QSghWlhf+ap2rxzKCCkszyuICyJhsLV2vIT1skuPjTxHuJnnxEsghfgkL3vCrMvkt95Gmx2RG05Kt7FYmUr0Xb7F3QqPk87uI9XWpuUFNq07AABriie1BctTsmeXysNZIbuhGgb/8wLEQJaPJPYPA9CfrsZhv136z/dhiQrhuEWdEt5LF855hH8Z/3E0xYQdA/YIy6gG8QUH0CxzGXuzk1zdHpSGKHrtYgH5AyT/22enPRWRqJYdjYYmFzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdeOCHkrE7g1daNaRpnzc6/HJu9GDrYoZ9L80Sn6yY=;
 b=fzaTa61jdHdULxbUaFI3KLVv/zowEQEnJ6RO+8dNhEdUkCFiip7A4BFnabtitIuWSxMaAjhsucXXqbZnkpIQOjtLvoVk7N0djYhlNn4cV6Eig+POwG5nvwQaiKLh/1PUpJKhm2ZKPRtTAGy7fBxfqVIzRXyiH9QfULBODXER7SbyeoMmvhXSxDoklfQO3W13oLmzOH69nxcqY5E2ZJpfiB3q2izWwuPZ+ZZa+EFBp0xQFOYPQ6r30R4aD7FyTt3kAn6zv1ycesUPEhhNSsvz8U1LT5FDDbiEiGLbmQrRo1WKaYF06J35ycjppfpFrQPozWADVOdwhhIgwmRMnQC8Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdeOCHkrE7g1daNaRpnzc6/HJu9GDrYoZ9L80Sn6yY=;
 b=lPUJH2pg3N9gEh8RZB5JWEzKOZc7P1fVHfPjY1DbXgGyblD2HdG5BSpkHAvm5TwKrtcLCI6F6wb0TK8ekoXxmbJUM4sLoMpKdMu6kq/XjR5k+3C2IHzi4RZKZaiAnIAXb58jxjtS5pE9w/h/58Cx0Quk8aVFSfiITRZIRBt13iQ=
Authentication-Results-Original: vger.kernel.org; dkim=none (message not
 signed) header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=arm.com;
Received: from DB6PR08MB2840.eurprd08.prod.outlook.com (2603:10a6:6:1d::31) by
 DB8PR08MB3977.eurprd08.prod.outlook.com (2603:10a6:10:ad::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.17; Fri, 11 Sep 2020 15:14:29 +0000
Received: from DB6PR08MB2840.eurprd08.prod.outlook.com
 ([fe80::dc1e:f0ae:c1e9:135a]) by DB6PR08MB2840.eurprd08.prod.outlook.com
 ([fe80::dc1e:f0ae:c1e9:135a%3]) with mapi id 15.20.3326.025; Fri, 11 Sep 2020
 15:14:29 +0000
Subject: Re: [PATCH v4 00/14] arm64: Optimise and update memcpy, user copy and
 string routines
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200630194822.1082-1-oli.swede@arm.com>
 <f52401d9-787c-667b-c1ec-8b91106d6d14@arm.com>
 <20200907101003.GA11970@willie-the-truck> <20200911112911.GA12835@gaia>
From:   Oli Swede <oli.swede@arm.com>
Message-ID: <6d33c737-ead2-2e67-573e-936e245a13f3@arm.com>
Date:   Fri, 11 Sep 2020 16:14:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200911112911.GA12835@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::31) To DB6PR08MB2840.eurprd08.prod.outlook.com
 (2603:10a6:6:1d::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.57.51.226] (217.140.99.251) by LO2P265CA0187.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Fri, 11 Sep 2020 15:14:28 +0000
X-Originating-IP: [217.140.99.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3d778020-da74-4123-1540-08d856656822
X-MS-TrafficTypeDiagnostic: DB8PR08MB3977:|AM0PR08MB5249:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB52493D11FFCD0603CEE956A7EF240@AM0PR08MB5249.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: yOsRxui+vWvLdM0f7q+TCPD4ExeA6NI6r1pXucKkFQsxBtWcCu/eT8V9nsGobsAm+m1hYxPIAj88zf3NErYkogYBWQTww+tE45qocm41mloX2OMReCjeUrq2POOsE1LmtUNGgaoi1YV67tJj7ANmVjP25JP2dUntguxT0wjIf98qzy6HCL9vMVQVDaQoggtK/xcdwGQsc1+LeEwt55TYKReGPPLbXY70Ogbg/1B5mCV1ZdMDNp6ngaUTWHMjHcdrSRvFuTGfUglxjF89mAYQhYGelmaauBsHfQnEE3/dafJNm0wnn+OGFyrV7l755dc9wYmvcyys7lrw4VhP6OkCXGOLzJKWKaqXPrUJ0EkuOU4vK0KsQGja429NX0rdBhHX
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR08MB2840.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(31696002)(478600001)(66476007)(316002)(4326008)(16576012)(26005)(53546011)(52116002)(66556008)(36756003)(31686004)(186003)(16526019)(956004)(2616005)(44832011)(2906002)(8936002)(8676002)(6486002)(83380400001)(5660300002)(6666004)(86362001)(66946007)(110136005)(15650500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: mkcVCJ+w+mjE6al7oz3CXKC5lIEjzqsJswE333Syeyt8EqzCTLBp3Y8nq7D2lg9Td0zeX3HlZSJdzWkVyOmeyUHXKO5oxfzU2gcLD2md4X3Nr2hjDCK0p65WYCKbol+2QgUpbwe9nb23twN3Z669cUNoChPHobwhX/FlwzvnWBh9SBPpttH14j1MJ3WDzT6HtS1CD4p1N1M7VHjXlzu09JaNewcpVXpx+UrwQoBPjJkb6jUySMy25WW6O4YgTCSmwUDptZj6mP00ojlbO4RKDbddC1y0uZuHcFKkSzMXY3RAXTDV7aNJukPE01gMAt1bvpHFLf2NBCB3T8XoMIP8XgIZmN3FLlhu0s9bBPyoq6qcmj1JCsSxO/oNL1d8eMvXj3G2SZigJy4Y4mPaGzofo99wF1qERObtaCq2Fj+a3ujSf7mj3E/0lZNFHpNKl+8vQjmMRcMT70NCTj0Vh/VHsUOcUAVnMBIB7zT8I3mhwdiTceKTzT/HFeSCRPXA5+aJyaTpRl1GKXy+HO4ltnCv65AR+T0gZKUQSBUsILUtAkYpKQEtKS0DmtieD24imYU0lUZNgvTxvmeh3mLm6TpYMDPisrtoqhmE+unvIDR3c7O66xEPusyUwsKf8eylQZ6QGKY3sVpJYBFJ8Zjg2Ja2cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB3977
Original-Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 573fb008-b3b2-4c43-61e7-08d8566560d0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/C9qNDqDw6h68EXFsMXZsFlHNCOdxBAg7OXpsJl/vmeivILMVRwadh60Zeu2Gg8QRwAc+bnAGebJ0Ee7MFgR9lqH6BwnfHpr3tL+pz2CFT4q9gsAtL55HGG8aRoToM7dmW3vqbQcEVec8ZqXq5f0Oc9zW7419lPhblaOGm82pd15VM17RyiDjdXsUa6pMIlLU7B/nuiHN5nwHGOZF9CoTYTez+zdD6lA547phmnPbHH2B6ovtNo4Te4Y2exBj8xqWAEt3aDvRasRoRaX35XVsLI/Y65HWvi3P7sq4la4pilP84gpWWVyMzxRigZ9CyOLZbpeFytZxhRPzJbBwZflU1I4c4GVoSzoieFjSsQDyiJDEHC1iEqH/FaNnURfLZYEGKx7r8AHhLTc8TGzRMW9QV5ycgyYsAQA3D54GDd+3yl3rm1jsaoJYl93BMq/0af
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966005)(70206006)(70586007)(44832011)(82310400003)(2616005)(86362001)(36756003)(2906002)(82740400003)(83380400001)(81166007)(47076004)(956004)(15650500001)(31686004)(4326008)(31696002)(356005)(478600001)(36906005)(6486002)(336012)(5660300002)(8676002)(8936002)(53546011)(316002)(110136005)(6666004)(16576012)(26005)(186003)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2020 15:14:41.0775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d778020-da74-4123-1540-08d856656822
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT010.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB5249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will and Catalin,

Thank you both for having a look at this, the coupling between the 
usercopy routines and the fixup routines was my main concern as well and 
I understand the desire to take an approach that avoids this dependency 
when it comes to importing new copy routines.

On 9/11/20 12:29 PM, Catalin Marinas wrote:
 >
 > I was a bit more optimistic about this series until I saw the
 > copy_user_fixup.S changes (patches 12 to 14). I have a suspicion it's
 > only Oli (and maybe Robin) who understands it, so from a maintainer's
 > perspective it doesn't really scale. It's also very fragile with any
 > minor tweak in the actual copy routine potentially breaking the fixup
 > code.
 >

I was wondering if it would be possible to check that an alternative 
expression of the logic involved (e.g. diverted to a C function - if 
technically feasible - that is easier to understand and modify) would 
not really be desirable either?

On 9/11/20 12:29 PM, Catalin Marinas wrote:
 > On Mon, Sep 07, 2020 at 11:10:03AM +0100, Will Deacon wrote:
 >>
 >> I'm inclined to say that cortex-strings is probably not a good basis for
 >> our uaccess routines. The code needs to be adapted in a 
non-straightforward
 >> way so that we lose pretty much all of the benefits we'd usually get 
from
 >> adopted an existing implementation; we can't pull in fixes or 
improvements
 >> without a lot of manual effort, we can't reuse existing testing 
infrastructure
 >> (see below) and we end up being a "second-class" user of the routines
 >> because of the discrepancies in implementation.
 >
 > I was a bit more optimistic about this series until I saw the
 > copy_user_fixup.S changes (patches 12 to 14). I have a suspicion it's
 > only Oli (and maybe Robin) who understands it, so from a maintainer's
 > perspective it doesn't really scale. It's also very fragile with any
 > minor tweak in the actual copy routine potentially breaking the fixup
 > code.
 >

An alternative approach to the fixup routines came up recently in 
discussions; it could potentially enable the copy template to be 
preserved in its current form and allow the uaccess routines to re-use a 
shared copy algorithm (including cortex-strings and/or future optimized 
out-of-order algorithms), and is based on one of Robin's suggestions 
from a few weeks ago (I found some time to prototype this locally the 
other day). The algorithm-specific backtracking would be dropped in 
favour of first- and second-stage fixups, with each of these being 
relatively short & straightforward, and (together) likely compatible 
with future copy routines.
More specifically, within the fixup path invoked after the initial 
fault, it could jump back N bytes and then begin an in-order byte-wise 
copy from within the first fixup, and then intentionally fault for the 
second time at either the same or another fault address. As the 
intermediate scan-copy should continue right up to the 'true' fault 
address, and ignore any out-of-order techniques used by the optimized 
algorithm, the fixup for the second fault could then contain an 
accurate, conclusive calculation of the return value.

A technique for this which would need to be carried forward from patch 
11 in v4 would be to redirect the PC to a different 'intermediate' fixup 
(though only two choices this time) depending on whether the faulting 
instruction is a load or store, so it can establish if the minimum 
address to jump back to should be src or buf when comparing to 
(faddr-N). Additionally, for this the parameters to the usercopy 
functions would still need to be stored on the stack (patch 10 in v4).
Otherwise, it would involve a slight rewrite of v4 that could provide a 
more maintainable approach; the same fixups would be shared for all copy 
sizes & fault addresses (versus in v4) and the only variable subject to 
re-evaluation with new imports might be N (currently for copy sizes over 
64B it is guaranteed anything below the previous 64B will have been 
copied). It could also remove the need to special-case UAO systems when 
compared to v4.

If it's possible for pages to be swapped out in the middle of a usercopy 
function then this method might not provide the extra implicit knowledge 
used by the fixups in v4 about the stage of the algorithm that has been 
reached (deduced from the fixup that has been routed to, implied by the 
fault-instruction-to-fixup mapping) to compensate for this, so it could 
under-report the bytes copied if it faults at an earlier address during 
the in-order (secondary) copy. This could be outweighed by the potential 
advantages mentioned above, and I mainly include this as v4 should 
account for this scenario (but perhaps unnecessarily if the scenario 
isn't possible or too unlikely :) ), but as you rightly point out it 
would be tiresome to re-write these routines.

On Mon, Sep 07, 2020 at 11:10:03AM +0100, Will Deacon wrote:
 >
 > So why don't we use cortex-strings as a basis for the in-kernel routines
 > only, preferably in a form where the code can be used directly and 
updated
 > with a script (e.g. similar to how we pull in arch/arm64/crypto routines
 > from OpenSSL). We can then roll our own uaccess routines, using a 
slightly
 > more straight-forward implementation which is more amenable to handling
 > user faults and doesn't do things like over copying.

I was wondering if the proposal described above is something that you 
would want to look into, or if the use of separate copy routines 
(script-based or otherwise) for in-kernel/uaccess is the preferred approach?

On Mon, Sep 07, 2020 at 11:10:03AM +0100, Will Deacon wrote:
 >
 > Can we put this test module into the kernel source tree, please, maybe as
 > part of lkdtm? Given the control flow of these optimised functions, I 
think
 > we absolutely need targeted testing to make sure we're getting complete
 > coverage.

I will post the standalone module in its current state later today/early 
next week, the tests are exhaustive but if it would be useful to include 
a mechanism for specifying certain ranges of faults/copy sizes or 
improve the error reporting, I'd be happy to add these features (and/or 
integrate it into lkdtm).

Many thanks,
Oli


On 9/11/20 12:29 PM, Catalin Marinas wrote:
> On Mon, Sep 07, 2020 at 11:10:03AM +0100, Will Deacon wrote:
>> On Wed, Jul 01, 2020 at 09:12:49AM +0100, Oli Swede wrote:
>>>> Version 3 addressed this but I later found some issues with the fixup
>>>> correctness after further testing, and have partially re-written them
>>>> here, and addressed some other behaviours of the copy algorithm.
>>
>> [...]
>>
>>> I am waiting on access to the relevant machine before posting the benchmark
>>> results for this optimized memcpy, but Sam reported the following with the
>>> similar (but now slightly older) cortex-strings version:
>>>    * copy_from_user: 13.17%
>>>    * copy_to_user: 4.8%
>>>    * memcpy: 27.88%
>>>    * copy_in_user: Didn't appear in the test results.
>>> This machine will also be used to check the fixups are accurate on a system
>>> with UAO - they appear to be exact on a non-UAO system with PAN that I've
>>> been working on locally.
>>
>> I'm inclined to say that cortex-strings is probably not a good basis for
>> our uaccess routines. The code needs to be adapted in a non-straightforward
>> way so that we lose pretty much all of the benefits we'd usually get from
>> adopted an existing implementation; we can't pull in fixes or improvements
>> without a lot of manual effort, we can't reuse existing testing infrastructure
>> (see below) and we end up being a "second-class" user of the routines
>> because of the discrepancies in implementation.
> 
> I was a bit more optimistic about this series until I saw the
> copy_user_fixup.S changes (patches 12 to 14). I have a suspicion it's
> only Oli (and maybe Robin) who understands it, so from a maintainer's
> perspective it doesn't really scale. It's also very fragile with any
> minor tweak in the actual copy routine potentially breaking the fixup
> code.
> 
>> So why don't we use cortex-strings as a basis for the in-kernel routines
>> only, preferably in a form where the code can be used directly and updated
>> with a script (e.g. similar to how we pull in arch/arm64/crypto routines
>> from OpenSSL). We can then roll our own uaccess routines, using a slightly
>> more straight-forward implementation which is more amenable to handling
>> user faults and doesn't do things like over copying.
> 
> I think that's probably the best option. I wouldn't mind replacing the
> in-kernel memcpy/strcpy etc. with these patches since the work was done
> already but definitely not for the uaccess and fixup routines (we still
> have the original implementation in the git log).
> 
> A script would work even better. Do we have any issue with licensing
> though? Cortex Strings is BSD (3-clause IIRC) and copyright owned by
> Linaro. I got them to officially agree with relicensing (dual license)
> the latest copy under GPLv2 so that we can contribute it to the kernel.
> But since the project license is still BSD, any future updates in there
> are BSD-only.
> 
> Maybe someone who understands this stuff can confirm that it's ok to
> regularly grab the Cortex Strings files into a GPLv2 codebase without
> asking for Linaro's permission.
> 
> BTW, you could pick the kprobes patch in here, that explicit fixup call
> is not necessary.
> 
