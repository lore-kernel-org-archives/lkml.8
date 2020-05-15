Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4BEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F4AF206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="n4g1dPvn";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="n4g1dPvn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728139AbgEOJcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:32:51 -0400
Received: from mail-eopbgr80073.outbound.protection.outlook.com ([40.107.8.73]:60413
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727116AbgEOJct (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:32:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1eVtPJdOfak8LUKZ90gMOGASb8ujGDAuzC7EcQvvxA=;
 b=n4g1dPvnQerVoJdDk5Kpc3Uw67yq5AYbGmHrxHP3Rwd0mt23QCRN5t/gvbIS2mDounPReMjIRScxJyZ7Xqzy/1NE92rLCs5r+QpOr/OwgnY6hJqV4WE6nikA881vo1gjGguSuIX5FaiffjgShMq0mbTsukyq5BwUFWNB+sbPDe0=
Received: from AM4PR0202CA0022.eurprd02.prod.outlook.com
 (2603:10a6:200:89::32) by AM6PR08MB3400.eurprd08.prod.outlook.com
 (2603:10a6:20b:42::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Fri, 15 May
 2020 09:32:42 +0000
Received: from AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:200:89:cafe::8) by AM4PR0202CA0022.outlook.office365.com
 (2603:10a6:200:89::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend
 Transport; Fri, 15 May 2020 09:32:42 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT012.mail.protection.outlook.com (10.152.16.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.19 via Frontend Transport; Fri, 15 May 2020 09:32:41 +0000
Received: ("Tessian outbound b3a67fbfbb1f:v54"); Fri, 15 May 2020 09:32:41 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: e383358394b59448
X-CR-MTA-TID: 64aa7808
Received: from e9153ab57fc6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id DFB3491D-EF13-411F-8C1B-AAB3CDFC3F87.1;
        Fri, 15 May 2020 09:32:36 +0000
Received: from EUR02-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id e9153ab57fc6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 15 May 2020 09:32:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wza82cE5h5ZWP3h2XRO9zs6EkKdBRvJeETYJCKqYXlchwydv71olSoVzhzJPEvV6w+zG1sqpj7UwEgY/ha+2PQ8mblujGMCGC8+MEoy398rwUrO3mO9SPgSpNA//NAp3DducaPQ9aOj+1sU6abzJStVDW2NluWR04Piqk/MHMEOuIybeXlVf19qPgdqqb7AO1H2JoS9GOFIZGWGu5qMWqsw1mivdmBl6wePs47h/2VhXARDCsCnnTKqfRW8d3Ze9b5NGB3idzGRpBNamjBcrUAMGzZxMe8fkeV7jsZZWlQ9/LBPNMM+iEtkO61cRQ4Bypqy4KwgqU0PPet/EbYgj9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1eVtPJdOfak8LUKZ90gMOGASb8ujGDAuzC7EcQvvxA=;
 b=IyCt+e+JCvhBY+LBT9GJPFsBbGf1JodQ6UHPezQu8pq8bh9F+JmwnnywJ43MlRANjuMbydAxsG+vG9RE4uBAjWgj2TJ78KLonanJRH8FSsqFBjS3HVJFlIlBM9cd8NnWCSr/0tGI38OYPPaWhPimoQdFW3Rl7kVuzbdxTT2BHS2zLYnWixBeB17gDekXvpKfI7PYxT4LPQDO22YMxza8wfjopkUcbjXC//GRg91CoMk4GPSmah3rpywtx6sFNyhW7RYTA7D8QadGjZz61XnH6ye1ynU+ksBQQMY5N15jUq+SHHX1Uh179t+8s3birpYdTw+i6NjcpJPh7GgrFjQQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1eVtPJdOfak8LUKZ90gMOGASb8ujGDAuzC7EcQvvxA=;
 b=n4g1dPvnQerVoJdDk5Kpc3Uw67yq5AYbGmHrxHP3Rwd0mt23QCRN5t/gvbIS2mDounPReMjIRScxJyZ7Xqzy/1NE92rLCs5r+QpOr/OwgnY6hJqV4WE6nikA881vo1gjGguSuIX5FaiffjgShMq0mbTsukyq5BwUFWNB+sbPDe0=
Authentication-Results-Original: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
Received: from HE1PR08MB2890.eurprd08.prod.outlook.com (2603:10a6:7:36::11) by
 HE1PR08MB2921.eurprd08.prod.outlook.com (2603:10a6:7:30::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2979.34; Fri, 15 May 2020 09:32:32 +0000
Received: from HE1PR08MB2890.eurprd08.prod.outlook.com
 ([fe80::21af:7992:3558:1a80]) by HE1PR08MB2890.eurprd08.prod.outlook.com
 ([fe80::21af:7992:3558:1a80%2]) with mapi id 15.20.3000.022; Fri, 15 May 2020
 09:32:32 +0000
Date:   Fri, 15 May 2020 10:32:29 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mm <linux-mm@kvack.org>, nd <nd@arm.com>
Subject: Re: [RFC][PATCH 3/4] dma-buf: cma_heap: Extend logic to export CMA
 regions tagged with "linux,cma-heap"
Message-ID: <20200515093229.bibu5etvfrdlrhsi@DESKTOP-E1NTVVP.localdomain>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-4-john.stultz@linaro.org>
 <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
 <47e7eded-7240-887a-39e1-97c55bf752e7@arm.com>
 <CALAqxLU6kmvJ+xPCFzc3N+RNMv4g=L9bmzgE0wrOXefiGfPoHg@mail.gmail.com>
 <20200504090628.d2q32dwyg6em5pp7@DESKTOP-E1NTVVP.localdomain>
 <20200512163714.GA22577@bogus>
 <20200513104401.lhh2m5avlasev6mj@DESKTOP-E1NTVVP.localdomain>
 <CAL_Jsq+V-YA9B7i+9U0as3oXNC=HLPHmZ2NrPzNJu5CXpvD3tg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+V-YA9B7i+9U0as3oXNC=HLPHmZ2NrPzNJu5CXpvD3tg@mail.gmail.com>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::32) To HE1PR08MB2890.eurprd08.prod.outlook.com
 (2603:10a6:7:36::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (82.1.208.173) by LO2P265CA0308.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26 via Frontend Transport; Fri, 15 May 2020 09:32:30 +0000
X-Originating-IP: [82.1.208.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb0c88b4-fb4a-4d89-149d-08d7f8b2ea70
X-MS-TrafficTypeDiagnostic: HE1PR08MB2921:|HE1PR08MB2921:|AM6PR08MB3400:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3400807DEDC86952FC95D154F0BD0@AM6PR08MB3400.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 04041A2886
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: NKzk5khuMDIemVQuoeYoENrAbLHq3Hpeo2gRKN6vmFsYC1xU+vooC9Ivx4bsqwWuFUMlM0H7Yub2p2OFrZppkSlVqrPZzZcN8CYvMkQ+Qn2U/TGjdWc4gj1H8kOrd9mEXYEAgZvEM76dmL9q8bJZ2XlIGlsyL4uUd/OIDAdtKQ+BlYu13a7oKqISeh2uUpmz+C07JMDKWxIsZHp/It7B9qNkSr1LNcNbH51uAU9F5qEieWatsgjk/laV3Eyiiw7z/dnZPR2osLWbyXNck1gwMRDFytGFaFDjqYFxyTtBM20r6yANXoQuQl1AxWVkCOC5z/TigLlFyfZ7SBeKlBSfMfxAYojKMJr2jer38pT6cE2k2EG80ZCXfmiZo/gbgWKKL8mOYhxXHN5EEco6+8SaJ7eQUGVOS2ffvogvM8uOHFQWqKfHyOmL1f5hLTHuwWb3PF7wZl/MKP+SMFOUUlJ3Wl3J/S0SEFw8Sa8/pYKnQAWRJfn/Y4ExQ20s+bh5q4uO
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR08MB2890.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(1076003)(6916009)(8936002)(86362001)(66946007)(66556008)(186003)(54906003)(7416002)(16526019)(956004)(66476007)(55016002)(9686003)(478600001)(6506007)(7696005)(53546011)(8676002)(316002)(52116002)(2906002)(44832011)(4326008)(26005)(5660300002)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fN6g2wvY+kQGqfVYzukC3huo+PGdxIeyOewBKsrg/s82Mk1AoC2NmSzAYVzbuurElLMVfWrZTeJmNTczo09V4iRZIMbiRNhGN+VmgFokPp/P3ZeT2wmC0z8LSbr2QPpYt+lzJRv/O+CwT4DAoLeipF9z3SFpLcKNMdyzTQqWc19KFq3o3RgAYYee5+5SMYqM1OiwZuYHN1JqXmt42FwPW1v+ZyEKnkT+QoSoBd4bBJwFeQxYTrHknu9y8CMLOyq13aFsqPWdad+xt65gGl9E1Gbxk7DflMt7uaT4SXNhRqXyXff/OHILVG6xsKmiC9c4TQ32SNLn7X39/lWjP9u0ItK6uFVCiSyn9E2TeiCgj9GPqZXvEXILozz3URcDyUrTdnOE6/ebGFvBa1yXnM3CaPUy/gzwDtQ9IiQ+VN5ZlNoLBBWHNCwruKkN8AXzqdQvGhmFSrci1+MW0iI2zUOCCjNDpxmomb4/YzMehXw4E2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2921
Original-Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT012.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966005)(6862004)(8676002)(70586007)(316002)(9686003)(70206006)(47076004)(1076003)(82310400002)(16526019)(4326008)(55016002)(36906005)(54906003)(5660300002)(8936002)(450100002)(186003)(26005)(956004)(53546011)(6506007)(2906002)(336012)(86362001)(478600001)(356005)(81166007)(82740400003)(44832011)(7696005)(142933001);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 75b2492b-b0b0-470a-0c9c-08d7f8b2e49b
X-Forefront-PRVS: 04041A2886
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1pvgSql+3+uukiSbqv8nxZWUKXUFEjubHLDU5v3wGABJNFWVjQUS1HiCet9gZpmfXvEfIMhbvjPynkkjStbqeKVycmRlBVRCWOWfMdj/YU3XvvGdrrVuL88mjIH8CcaNOoJwUxu4RwG5op7KSXxLsAbZ2xN0HKT6XNGhnJqhO3JU9YngLkveGcSo1rrLUcAzDm9bvDf3fcrqCVqPUmxf7wYL4ICbvm9DDqoVAn+UwxupwQO0KOkMR0JtZt8nn2yac0vtR6CAR2MG3rz2Diq6KBLbmG342NQOMYfYLjBn8inSyQeljtALQZZBR94coIJpuQkmllP9NEu7hV6BHoCxzYaIAHYhDzlCx3f4rLqieWTd7XVYizutXTK81Q3adgd8awkHqeoROMV9ksXNwL34PgYkdFSIOFgt/WBmt2fKk+0t7EAnEEuttQ4/3ORcDbaGXoiuHh6zM/uWaWT3qZ3kDQMC3eVpj3olgv0vpZCDIdzq8aGsuLoYoXW3AgJtG9+koVGTYqmqSTOgqlce2acnKpwfLXsXASEnVRykw02a//8=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2020 09:32:41.6056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb0c88b4-fb4a-4d89-149d-08d7f8b2ea70
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3400
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 09:52:35AM -0500, Rob Herring wrote:
> On Wed, May 13, 2020 at 5:44 AM Brian Starkey <brian.starkey@arm.com> wrote:
> >
> > Hi Rob,
> >
> > On Tue, May 12, 2020 at 11:37:14AM -0500, Rob Herring wrote:
> > > On Mon, May 04, 2020 at 10:06:28AM +0100, Brian Starkey wrote:
> > > > On Fri, May 01, 2020 at 12:01:40PM -0700, John Stultz wrote:
> > > > > On Fri, May 1, 2020 at 4:08 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > > > > >
> > > > > > On 2020-05-01 11:21 am, Brian Starkey wrote:
> > > > > > > Hi John,
> > > > > > >
> > > > > > > On Fri, May 01, 2020 at 07:39:48AM +0000, John Stultz wrote:
> > > > > > >> This patch reworks the cma_heap initialization so that
> > > > > > >> we expose both the default CMA region and any CMA regions
> > > > > > >> tagged with "linux,cma-heap" in the device-tree.
> > > > > > >>
> > > > > > >> Cc: Rob Herring <robh+dt@kernel.org>
> > > > > > >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > > > > >> Cc: "Andrew F. Davis" <afd@ti.com>
> > > > > > >> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > > > > >> Cc: Liam Mark <lmark@codeaurora.org>
> > > > > > >> Cc: Pratik Patel <pratikp@codeaurora.org>
> > > > > > >> Cc: Laura Abbott <labbott@redhat.com>
> > > > > > >> Cc: Brian Starkey <Brian.Starkey@arm.com>
> > > > > > >> Cc: Chenbo Feng <fengc@google.com>
> > > > > > >> Cc: Alistair Strachan <astrachan@google.com>
> > > > > > >> Cc: Sandeep Patil <sspatil@google.com>
> > > > > > >> Cc: Hridya Valsaraju <hridya@google.com>
> > > > > > >> Cc: Christoph Hellwig <hch@lst.de>
> > > > > > >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > > > >> Cc: Robin Murphy <robin.murphy@arm.com>
> > > > > > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > > > > > >> Cc: devicetree@vger.kernel.org
> > > > > > >> Cc: dri-devel@lists.freedesktop.org
> > > > > > >> Cc: linux-mm@kvack.org
> > > > > > >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > > > > >> ---
> > > > > > >>   drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
> > > > > > >>   1 file changed, 9 insertions(+), 9 deletions(-)
> > > > > > >>
> > > > > > >> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> > > > > > >> index 626cf7fd033a..dd154e2db101 100644
> > > > > > >> --- a/drivers/dma-buf/heaps/cma_heap.c
> > > > > > >> +++ b/drivers/dma-buf/heaps/cma_heap.c
> > > > > > >> @@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
> > > > > > >>   {
> > > > > > >>      struct cma_heap *cma_heap;
> > > > > > >>      struct dma_heap_export_info exp_info;
> > > > > > >> +    struct cma *default_cma = dev_get_cma_area(NULL);
> > > > > > >> +
> > > > > > >> +    /* We only add the default heap and explicitly tagged heaps */
> > > > > > >> +    if (cma != default_cma && !cma_dma_heap_enabled(cma))
> > > > > > >> +            return 0;
> > > > > > >
> > > > > > > Thinking about the pl111 thread[1], I'm wondering if we should also
> > > > > > > let drivers call this directly to expose their CMA pools, even if they
> > > > > > > aren't tagged for dma-heaps in DT. But perhaps that's too close to
> > > > > > > policy.
> > > > > >
> > > > > > That sounds much like what my first thoughts were - apologies if I'm
> > > > > > wildly off-base here, but as far as I understand:
> > > > > >
> > > > > > - Device drivers know whether they have their own "memory-region" or not.
> > > > > > - Device drivers already have to do *something* to participate in dma-buf.
> > > > > > - Device drivers know best how they make use of both the above.
> > > > > > - Therefore couldn't it be left to drivers to choose whether to register
> > > > > > their CMA regions as heaps, without having to mess with DT at all?
> > >
> > > +1, but I'm biased toward any solution not using DT. :)
> > >
> > > > > I guess I'm not opposed to this. But I guess I'd like to see some more
> > > > > details? You're thinking the pl111 driver would add the
> > > > > "memory-region" node itself?
> > > > >
> > > > > Assuming that's the case, my only worry is what if that memory-region
> > > > > node isn't a CMA area, but instead something like a carveout? Does the
> > > > > driver need to parse enough of the dt to figure out where to register
> > > > > the region as a heap?
> > > >
> > > > My thinking was more like there would already be a reserved-memory
> > > > node in DT for the chunk of memory, appropriately tagged so that it
> > > > gets added as a CMA region.
> > > >
> > > > The device's node would have "memory-region=<&blah>;" and would use
> > > > of_reserved_mem_device_init() to link up dev->cma_area to the
> > > > corresponding cma region.
> > > >
> > > > So far, that's all in-place already. The bit that's missing is
> > > > exposing that dev->cma_area to userspace as a dma_heap - so we could
> > > > just have "int cma_heap_add(struct cma *cma)" or "int
> > > > cma_heap_dev_add(struct device *dev)" or something exported for
> > > > drivers to expose their device-assigned cma region if they wanted to.
> > > >
> > > > I don't think this runs into the lifetime problems of generalised
> > > > heaps-as-modules either, because the CMA region will never go away
> > > > even if the driver does.
> > > >
> > > > Alongside that, I do think the completely DT-driven approach can be
> > > > useful too - because there may be regions which aren't associated with
> > > > any specific device driver, that we want exported as heaps.
> > >
> > > And they are associated with the hardware description rather than the
> > > userspace environment?
> >
> > I'm not sure how to answer that. We already have CMA regions being
> > created from device-tree, so we're only talking about explicitly
> > exposing those to userspace.
> 
> It's easier to argue that how much CMA memory a system/device needs is
> h/w description as that's more a function of devices and frame sizes.
> But exposing to userspace or not is an OS architecture decision. It's
> not really any different than a kernel vs. userspace driver question.
> What's exposed by UIO or spi-dev is purely a kernel thing.
> 
> > Are you thinking that userspace should be deciding whether they get
> > exposed or not? I don't know how userspace would discover them in
> > order to make that decision.
> 
> Or perhaps the kernel should be deciding. Expose to userspace what the
> kernel doesn't need or drivers decide?

If not via device-tree how would the kernel make that decision? For
regions which get "claimed" by a device/driver, obviously that driver
can make the decision, and I totally think we should provide a way for
them to expose it.

But for something like a shared pool amongst the media subsystem,
there may not be any specific single device/driver - and creating a
dummy driver with the sole purpose of exposing the heap doesn't seem
like an improvement over a simple "linux,cma-heap".

Cheers,
-Brian

> 
> It's hard to argue against 1 new property. It's death by a 1000 cuts though.
> 
> Rob
