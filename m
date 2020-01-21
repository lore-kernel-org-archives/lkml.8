Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2D9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F0D5E217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Hu1QEPDj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="cz7NU88t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbgAUMC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:02:57 -0500
Received: from mail-db8eur05on2040.outbound.protection.outlook.com ([40.107.20.40]:6087
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727817AbgAUMC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:02:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dhR/GsAHelNuqLxfcvIwjqAH8w16NadYjld4l9BFA4U=;
 b=Hu1QEPDjts9iUyWZhq/8w83BiPUxEL2F6+S6mu72QU5Sny7KlP5PlcPtF9JjiRxv4+/d1dPQBNGmqeOj0cJ2FdE6UJGRXkGqzyeCoPxrIFdOApDN7Itb2CxVB+3YcmM/lOhX9Az7vjbMwA2YnswYkK2b7XOvDhqRJ7GDXCgBiMM=
Received: from AM4PR08CA0062.eurprd08.prod.outlook.com (2603:10a6:205:2::33)
 by AM0PR08MB3617.eurprd08.prod.outlook.com (2603:10a6:208:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.24; Tue, 21 Jan
 2020 12:02:51 +0000
Received: from AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by AM4PR08CA0062.outlook.office365.com
 (2603:10a6:205:2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend
 Transport; Tue, 21 Jan 2020 12:02:51 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT028.mail.protection.outlook.com (10.152.16.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23 via Frontend Transport; Tue, 21 Jan 2020 12:02:50 +0000
Received: ("Tessian outbound 4f3bc9719026:v40"); Tue, 21 Jan 2020 12:02:50 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f9ea57a3a814276a
X-CR-MTA-TID: 64aa7808
Received: from 4a701ace8b15.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 50BB5AFF-1979-4477-A789-DDBE7B757623.1;
        Tue, 21 Jan 2020 12:02:45 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4a701ace8b15.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 21 Jan 2020 12:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZISvCu4JEoQZ45KcdLjQaCSpeN8kxyF6F/WVPLzLO8hpAKHvjYnhNknvmSYZgVsSAC+f6AcTUMtoCg+lD5989+BjYCe43zZKU4ZgCHC1yQ0lVniB8TB3UvJkiHywsL8NrmE02n6VdweX24jG7HDoVtlFdBu2unrK9Z75RjFBavMdBWxPfHiWRO+ZJVxbUTh0y3rh4gCtsaSmv3Ni3XBfw81E6dFtf/z/0y5dGyKC19qAqpfGJ02OmBs09NG9RVT26JCLIS6MLrYmx4ebkWDP5mCZsEwyAgo0Y5DEjN3FNcAcahOtFFieaje4BmojQuDLnAK0jZalEJ3RiRlHneKn+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqXDE1eW5PtBSR2KUk+XDmRDH2qjzhkghm+iDk26JNY=;
 b=XvJA/QcBzifrmmJrvVIzPcxP7kJNz8PWrEIZWJDc8cqweLYVIJ5GoiuwY104N+w/f6mZ97zCeuAM7bpemJnSup5arK2Jx0mpHF5VnlzLbD/svB32qSXHQtLlGTTTUR1yN4o15fHdev4kZvkxFvMl2Rn3gVXiUhmJaqbaA8Hlo4YyFNr2OYPafUeAwzgN6bIR5kUBp8J27CGupm4ja5CYrDLBoEHMIe+/mngfZx//hGE5yflEGPJJV8+fNjyYU/lLpB/qlYAqnNZlT3hgHYvN3S86IhPxHzA61jmEP9S03E8NMnAluT0W+BQPE9kVgxFW/dq/V0cW3MMNK5/hJg/lCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TqXDE1eW5PtBSR2KUk+XDmRDH2qjzhkghm+iDk26JNY=;
 b=cz7NU88t5XphSVyihIrOFFlU1XG+Av8GGGUwUDp05inEqr+5BPkBrVJxjN2M8uKOi4kHfBRWw1ka9WYduCMDvGKKvYI7aAUUvfr0pwCH8XafT7mPeiSjVTZ6bFbVRAXV2It/pIXxqo47F3on3Ajh9HoNBXeqK2MXZRyyPreGyrc=
Received: from DB6PR08MB2791.eurprd08.prod.outlook.com (10.170.219.160) by
 DB6PR08MB2806.eurprd08.prod.outlook.com (10.175.234.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 12:02:41 +0000
Received: from DB6PR08MB2791.eurprd08.prod.outlook.com
 ([fe80::c51d:bc86:7692:181]) by DB6PR08MB2791.eurprd08.prod.outlook.com
 ([fe80::c51d:bc86:7692:181%6]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 12:02:41 +0000
Received: from arrakis.emea.arm.com (217.140.106.50) by LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20 via Frontend Transport; Tue, 21 Jan 2020 12:02:40 +0000
From:   Catalin Marinas <Catalin.Marinas@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "will@kernel.org" <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "david@redhat.com" <david@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        "logang@deltatee.com" <logang@deltatee.com>,
        "cpandya@codeaurora.org" <cpandya@codeaurora.org>,
        "arunks@codeaurora.org" <arunks@codeaurora.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "osalvador@suse.de" <osalvador@suse.de>,
        Ard Biesheuvel <Ard.Biesheuvel@arm.com>,
        Steve Capper <Steve.Capper@arm.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        Steven Price <Steven.Price@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [PATCH V12 1/2] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Thread-Topic: [PATCH V12 1/2] arm64/mm: Hold memory hotplug lock while walking
 for kernel page table dump
Thread-Index: AQHVzDhxBbGg9NtlH0u/OUhHsvtVxKf1DOgA
Date:   Tue, 21 Jan 2020 12:02:41 +0000
Message-ID: <20200121120238.GC3113562@arrakis.emea.arm.com>
References: <1579157135-10360-1-git-send-email-anshuman.khandual@arm.com>
 <1579157135-10360-2-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1579157135-10360-2-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0134.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::26) To DB6PR08MB2791.eurprd08.prod.outlook.com
 (2603:10a6:6:17::32)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8d893572-6658-4cb4-42f8-08d79e69d6dc
X-MS-TrafficTypeDiagnostic: DB6PR08MB2806:|DB6PR08MB2806:|AM0PR08MB3617:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB3617A3B0AFA705097196711EF20D0@AM0PR08MB3617.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
x-forefront-prvs: 0289B6431E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(189003)(199004)(956004)(54906003)(2906002)(71200400001)(55016002)(186003)(16526019)(478600001)(26005)(316002)(7696005)(52116002)(4326008)(66446008)(44832011)(86362001)(8676002)(66556008)(7416002)(81166006)(66476007)(6862004)(66946007)(64756008)(81156014)(8936002)(33656002)(1076003)(6636002)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2806;H:DB6PR08MB2791.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: mq8Q7/tmEBK4HQD8oQ4bG9ZupMVFijIa/XqI8LPmOFtelGt2DaZx29k+azWf4Fm6+qRN0dnBrEzoW+GOe+BiT1irtZKKPLzoShNkk2ez1mRYpY/9dsRWq+niLJqU1bIzCC/mpWwH1kCH1lNw/PdVX0XifPhoqVPoSQtcSCrGsgdNE2TtInAz9Z1Zwj0P1KFwBsm7tH6hUtWFUzgvbLBAZlNlDPoq1IubANkKYxGNgyzZNWp0VsywRV7baAAV2eGR0SY7kHC14tAsbFSIv9KsHFKDE8oTOS5SSOIcghTfuHy7xBK/bVT1bENlYBdb4aJxdl0zIDk99ZzODfK6Lmm4ReRX89uAKFND0qi2xt4+KJsALJMHeoGZevINSQ6gyo33ANnAmLntNiXte29G+Kw9O+GYN+xAjLOgY/OfyNAgUqeqtRrXEGmGAua4iCPNN8HY
Content-Type: text/plain; charset="us-ascii"
Content-ID: <69B17A45438A7B4DAEAFE6038470BFB9@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2806
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT028.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(396003)(136003)(189003)(199004)(107886003)(33656002)(336012)(36906005)(956004)(54906003)(8936002)(55016002)(4326008)(478600001)(81166006)(81156014)(8676002)(16526019)(186003)(1076003)(6862004)(26005)(316002)(2906002)(26826003)(5660300002)(356004)(6636002)(70206006)(70586007)(86362001)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR08MB3617;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 20543342-6879-4001-2ed0-08d79e69d0be
X-Forefront-PRVS: 0289B6431E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BdQLnma2yr9fU/86W4QkXCh8A84dsJ8MZPiuBfRg3Tn47glKuNvMyTqJ9tYB+G/0tgreVTQhTtLlVv8iNgXfOXQpb3100XNDqP5Jlko5cadBAFuKlFjtEQuSgM46d3ZoqX9KN9F/Ei2vyPPeQ7/SLngj2ojrE9aBHp+q7OeANnhrpzS2Z/H/+0jXyCnpIEpRqg2/DNDoQGL5rR5fbWxvo5DzAOOrwYkxR+nb2910CXlsPofcZmCcvxCbjXBHNgyHdR4P40qoCl8xZLqtoUr7RfL7i+rfdqFkMmXjd+Ms+NZHn/JKau0YP4HG6rMh3OlytSVpT1bk/xnAtslvs2mrqeMvaPrGvhMDdUDsKGeYs4VyBLCWUEgo4iIKlSZOBae3Cr1qXD53B87PucNJC5X6E79ld5kPobEglAT2BP86HVgn3K1yjKPtqelJjdEJhed/
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 12:02:50.9138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d893572-6658-4cb4-42f8-08d79e69d6dc
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3617
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:15:34PM +0530, Anshuman Khandual wrote:
> The arm64 page table dump code can race with concurrent modification of t=
he
> kernel page tables. When a leaf entries are modified concurrently, the du=
mp
> code may log stale or inconsistent information for a VA range, but this i=
s
> otherwise not harmful.
>
> When intermediate levels of table are freed, the dump code will continue =
to
> use memory which has been freed and potentially reallocated for another
> purpose. In such cases, the dump code may dereference bogus addresses,
> leading to a number of potential problems.
>
> Intermediate levels of table may by freed during memory hot-remove,
> which will be enabled by a subsequent patch. To avoid racing with
> this, take the memory hotplug lock when walking the kernel page table.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
