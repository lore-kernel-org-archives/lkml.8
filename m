Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D348AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF56217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="rB+siPev";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="o73wOdIO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgAUMCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:02:44 -0500
Received: from mail-eopbgr10053.outbound.protection.outlook.com ([40.107.1.53]:9765
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727817AbgAUMCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:02:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AM/FBw0XkIqSN4N3ssrMwHOgdKqigRcQUvcqO8NZE/8=;
 b=rB+siPevhIOSbOkK5+FGGZ3r5Mi3LTSGTsX7mr5GTpakowVQv8gou9YIrRcUtH2Tdb+fQ+gwpIbGKU94jkMdWw0BccgNTZvjDg3EA6ob9zXz+39TdAzUkbukhMd/46sKHRJRmRZURyVqR89PZ1XtPNuiyTsvDHTJIh8OmE4eHik=
Received: from DB6PR0801CA0053.eurprd08.prod.outlook.com (2603:10a6:4:2b::21)
 by AM6PR08MB3749.eurprd08.prod.outlook.com (2603:10a6:20b:8f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.20; Tue, 21 Jan
 2020 12:02:38 +0000
Received: from AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::208) by DB6PR0801CA0053.outlook.office365.com
 (2603:10a6:4:2b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Tue, 21 Jan 2020 12:02:38 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT049.mail.protection.outlook.com (10.152.17.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23 via Frontend Transport; Tue, 21 Jan 2020 12:02:38 +0000
Received: ("Tessian outbound e09e55c05044:v40"); Tue, 21 Jan 2020 12:02:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 5f4b518c7b118edf
X-CR-MTA-TID: 64aa7808
Received: from ac3e3775d579.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 43AC234B-3D20-44EB-AC06-BCCE3924D7CC.1;
        Tue, 21 Jan 2020 12:02:31 +0000
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id ac3e3775d579.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 21 Jan 2020 12:02:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMNLHECgUlUSDnXcfrILztGYXqmbwIo23ldb7Fe4zW0yAbjH/E+6X3q8BgXsx+hxsF3nu6M/eAZfV8fjz/kpnG8ID462a2SPrB+MDJAPxgPOgI4T7CB0jvxkldlYPOw+0GepQbNqZoYrLtTeYqQsAWj7ORwvM6MhBTvoOmwNGHJ9mF2SHV9NxrtY6J2y5VP5vPlrrLdLVzVlzqbCS8I8uIV6WQs1VhGoMKlZsAo9Kd96Hmn1vTS5aA4267qUGi7f4OVTJOSUBd1TMOP358PzcJDWu/K5P6Zsj9Xc7DJr2oIXuefq0L6+JY16548Qrst+PRfGwF/L2AuGwkYITl/Q5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAbXjGuQ+eyzvPfW3pmfFeOx8ZqQDGBiY5wACgOcv00=;
 b=fpUhiaIjRH29KOeyW6inYz4KkhArvXgTxQrvCBybmbtkbTfKEkCIvRqHBEwdQDI4JX4UDYqCgB8Ytp3D2qxFOuslycSY5UFH+vx1vgBMjLsL+ZDSyZelzl6Vf8BOLgH1uTtjQKzuDo5gdgh9wLHrrCvDVCBnx09bTdKh+aIkp+xZITYD6pIU4TC6GI4tWVVV49Vu8oYNMa1BDmTlZVS0Ea2Lr8aNNG8J/ecc4PvuMb6BVF8GsWoVZC6zCJi+Jiak7oWu++VPYqcEsnwgPuwZ0aHpz5OyUj3eXmTRnBy86QksJNa94YDhc46cnNw9W0c+oMb9WKae/kA+pr22JXttqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAbXjGuQ+eyzvPfW3pmfFeOx8ZqQDGBiY5wACgOcv00=;
 b=o73wOdIO5Hm6U4X7KO2QcaXXwHjBwNi8kZK0m8DR1RsmsCBr/seBHkUvKTAzWBFiXau3s4PEJjSxuUbfH96+aifexQSwPRB/G04diYE09FClbUtvpK1GRAuWdLyqg+6u3e20M8SK5EeJS9NxriM3aZks1hg+4Kw0dF2tFZVfbwU=
Received: from DB6PR08MB2791.eurprd08.prod.outlook.com (10.170.219.160) by
 DB6PR08MB2806.eurprd08.prod.outlook.com (10.175.234.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Tue, 21 Jan 2020 12:02:26 +0000
Received: from DB6PR08MB2791.eurprd08.prod.outlook.com
 ([fe80::c51d:bc86:7692:181]) by DB6PR08MB2791.eurprd08.prod.outlook.com
 ([fe80::c51d:bc86:7692:181%6]) with mapi id 15.20.2644.024; Tue, 21 Jan 2020
 12:02:26 +0000
Received: from arrakis.emea.arm.com (217.140.106.50) by LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:62::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Tue, 21 Jan 2020 12:02:25 +0000
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
Subject: Re: [PATCH V12 2/2] arm64/mm: Enable memory hot remove
Thread-Topic: [PATCH V12 2/2] arm64/mm: Enable memory hot remove
Thread-Index: AQHVzDh01JJgnTWmaE6s7E0reOKvCaf1DNaA
Date:   Tue, 21 Jan 2020 12:02:26 +0000
Message-ID: <20200121120223.GB3113562@arrakis.emea.arm.com>
References: <1579157135-10360-1-git-send-email-anshuman.khandual@arm.com>
 <1579157135-10360-3-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1579157135-10360-3-git-send-email-anshuman.khandual@arm.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.50]
x-clientproxiedby: LO2P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:62::35) To DB6PR08MB2791.eurprd08.prod.outlook.com
 (2603:10a6:6:17::32)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c4df91bd-9e25-4252-1b32-08d79e69cf56
X-MS-TrafficTypeDiagnostic: DB6PR08MB2806:|DB6PR08MB2806:|AM6PR08MB3749:
x-ms-exchange-transport-forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3749D92E1C919530AF485411F20D0@AM6PR08MB3749.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
x-ms-oob-tlc-oobclassifiers: OLM:9508;OLM:10000;
x-forefront-prvs: 0289B6431E
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(39860400002)(396003)(136003)(366004)(199004)(189003)(6862004)(66476007)(81156014)(8936002)(64756008)(66946007)(4326008)(44832011)(66446008)(66556008)(7416002)(81166006)(86362001)(8676002)(6636002)(1076003)(5660300002)(33656002)(55016002)(71200400001)(2906002)(956004)(54906003)(26005)(52116002)(316002)(7696005)(186003)(478600001)(16526019);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR08MB2806;H:DB6PR08MB2791.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XAP/i4zQpZ9wE1msLDDYgqABAFMs1yEnb1iDZXxL23Gm4ugbxD17neATBmpGz3Isk8/y/nvd0bIrKNNwOqaM30/KngZspfKYPwLJfmtYDCinknnDHn6HEX9i1P0nuhjaDIQKxmy41wXw7q9LL0IB6zYK71lyuGRk5uz9GJaLH2CQWmngglKjmPJazIc1M1iN/AeRNPFgS188EvVWmoh67WSFX3gU6yBeah83K+gPpJ5ZkZv9/ZQmBWtGz23mNDcJBjpx8GVLmr+u4L0cImzLl5GnJoKovpc6Upj2f/dvK+zvbUzWmkqzdZOcW0Ixcn4Vro0opZ2699Xq4sJLdzkaOpaKByZoD8Utpyq5Mal5n5uC889CgOOcwHzmyTP3IdW4gYtTXBLsv7PcSD8cME9jq4G4ccF60ikgJ1+kz9gjEdgvS9Imv67aMOgCRGjbn0KI
Content-Type: text/plain; charset="us-ascii"
Content-ID: <460143B401C1874A96BC5C64D967788A@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2806
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Catalin.Marinas@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT049.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(136003)(39860400002)(199004)(189003)(4326008)(7696005)(70206006)(6862004)(8936002)(336012)(70586007)(55016002)(956004)(107886003)(1076003)(33656002)(356004)(5660300002)(478600001)(86362001)(26826003)(26005)(186003)(2906002)(16526019)(54906003)(81156014)(8676002)(6636002)(36906005)(316002)(81166006);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3749;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: e9dd39ac-586d-4797-2ddf-08d79e69c7c0
X-Forefront-PRVS: 0289B6431E
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJiUPr9koGCPXTrzCd1YoT8R502twoX9mQTlK+vDZFAo6rJuCnlKDI1QFioORXS+GtKBmnlZjtv+APE6Q/BZofJpQGe/b8uTRzzvYPDkaLc4AV0o8jBS/6fwrilJqoEAht6rCu3WkYIrVhpWw8e+LAzm8a1r5Mshi4sDqhhIiCTDTTty8PkHLVzw+ow7g9b87TaRH8Pq+WCFC26MinUMDpc+8hTbd3qiLw2xBpHbg3RFpLgoiYTb/lWxT16WT1OZHRDhDKttfYYLYWtK6AUaSh9qf7ILnJgNRkFLV9VkcMGe7Luk4iGpCR3yUGAYE5bfj+tIP0NPenkdQOI+mhvtZYgNiOOGAMaa06jo5RLO+9N7LFzMCtOY2LIUhdg8NQu7qp21daK50CT98QXVe/CJ3rSBBI8LNotRJCLeFdGAp9lZziRHXBaEx0a8IXGEptj9
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2020 12:02:38.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4df91bd-9e25-4252-1b32-08d79e69cf56
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3749
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:15:35PM +0530, Anshuman Khandual wrote:
> The arch code for hot-remove must tear down portions of the linear map an=
d
> vmemmap corresponding to memory being removed. In both cases the page
> tables mapping these regions must be freed, and when sparse vmemmap is in
> use the memory backing the vmemmap must also be freed.
>
> This patch adds unmap_hotplug_range() and free_empty_tables() helpers whi=
ch
> can be used to tear down either region and calls it from vmemmap_free() a=
nd
> ___remove_pgd_mapping(). The free_mapped argument determines whether the
> backing memory will be freed.
>
> It makes two distinct passes over the kernel page table. In the first pas=
s
> with unmap_hotplug_range() it unmaps, invalidates applicable TLB cache an=
d
> frees backing memory if required (vmemmap) for each mapped leaf entry. In
> the second pass with free_empty_tables() it looks for empty page table
> sections whose page table page can be unmapped, TLB invalidated and freed=
.
>
> While freeing intermediate level page table pages bail out if any of its
> entries are still valid. This can happen for partially filled kernel page
> table either from a previously attempted failed memory hot add or while
> removing an address range which does not span the entire page table page
> range.
>
> The vmemmap region may share levels of table with the vmalloc region.
> There can be conflicts between hot remove freeing page table pages with
> a concurrent vmalloc() walking the kernel page table. This conflict can
> not just be solved by taking the init_mm ptl because of existing locking
> scheme in vmalloc(). So free_empty_tables() implements a floor and ceilin=
g
> method which is borrowed from user page table tear with free_pgd_range()
> which skips freeing page table pages if intermediate address range is not
> aligned or maximum floor-ceiling might not own the entire page table page=
.
>
> Boot memory on arm64 cannot be removed. Hence this registers a new memory
> hotplug notifier which prevents boot memory offlining and it's removal.
>
> While here update arch_add_memory() to handle __add_pages() failures by
> just unmapping recently added kernel linear mapping. Now enable memory ho=
t
> remove on arm64 platforms by default with ARCH_ENABLE_MEMORY_HOTREMOVE.
>
> This implementation is overall inspired from kernel page table tear down
> procedure on X86 architecture and user page table tear down method.
>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

With the memory notifier added, my reviewed-by still stands.

--
Catalin
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
