Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98F12C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74F3120746
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 09:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="28u1SGw5";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="28u1SGw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEDJGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 05:06:46 -0400
Received: from mail-eopbgr70074.outbound.protection.outlook.com ([40.107.7.74]:51392
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726467AbgEDJGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:06:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me03ZDsFYyyUDzA23dGXx6iBVPgSmnXSn0KWN4Dd3EM=;
 b=28u1SGw5rJWQb9jhV37HkHEhDp1xKLwup0mAM0Aq+H7RryGPw/LCt/CevpHHzReQzoHUClOQWQypNfPDepJlGuC21gy2NDPCgwSaE5bAnKudmrhW38ikElxv0kWVNqiy2Gb7Nsh1jglAXuzkngm3W6xAP6DKm11s/TmBxvfXr9o=
Received: from DB6PR0802CA0030.eurprd08.prod.outlook.com (2603:10a6:4:a3::16)
 by VI1PR0801MB2095.eurprd08.prod.outlook.com (2603:10a6:800:8c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 09:06:37 +0000
Received: from DB5EUR03FT008.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a3:cafe::3) by DB6PR0802CA0030.outlook.office365.com
 (2603:10a6:4:a3::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Mon, 4 May 2020 09:06:37 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT008.mail.protection.outlook.com (10.152.20.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Mon, 4 May 2020 09:06:37 +0000
Received: ("Tessian outbound 4cdf5642225a:v54"); Mon, 04 May 2020 09:06:37 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b360b976e1bbede9
X-CR-MTA-TID: 64aa7808
Received: from 1bcda96b86ba.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 390088F8-F9AF-4029-90E4-6893A561AB32.1;
        Mon, 04 May 2020 09:06:31 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1bcda96b86ba.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 04 May 2020 09:06:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KoQyfqoVL30oSmA9a1Q6JjSQLfnCnVUahKRZh9LPEyeAMQQrAL+TXS+29mhR/6QFv/UIt7UEuM5suVp1/zMedDASaeYkpvQL1J2w40uAdFDCeENWejm+9CKaPadQ6J4pzSpNJs5Nghj8xwYg7muLJXQi7NEq2dhIbdQ+FBo1XNopwkCuLmlPzubkxOX179K9LuXxXURP4JIB9lddRBU1+Nphfo0A4cpZZnNEMNDlHX5rxEoEcaYqEe87ygkN3UzB74rchtqbjcnC8B84WEkGd9/nSbjleCyX7s/0ocJB+A4ba3Sf34rKIBEErwhw035/iLRVC/E9koNk0jSVrrU29Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me03ZDsFYyyUDzA23dGXx6iBVPgSmnXSn0KWN4Dd3EM=;
 b=OJnDsOpkUhfOQG4uj3W5TOw9bdAE+bGLYrk+zQ2gTN9vnGX7WlmDWkbdsEXhkle1kJKXki32jeivCvTgN2zO/DFusCYXW5qTZkL8f/3xtQFnLP+CVginSUcaEKJQdJgjboO0ixoq+/ZCMou3NY0Wgh/PX0wjvlXgSThmJ96tT6S0SxU9NdqIulIX6FQn0FL0WBVkZoWX1TUnijMEM2Uy/sZfOJ2HwYr3oPQvPUNigdLx8w+4kHOFXncVdVDtt0sZE5mlv/1GAuv6KoJTwrU4bDfnYGERG4PPtVBiSRjujS2G5XL4Xz0bnf56Sf8/t5z++52F+OjfhFJa/vdQMtx2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=me03ZDsFYyyUDzA23dGXx6iBVPgSmnXSn0KWN4Dd3EM=;
 b=28u1SGw5rJWQb9jhV37HkHEhDp1xKLwup0mAM0Aq+H7RryGPw/LCt/CevpHHzReQzoHUClOQWQypNfPDepJlGuC21gy2NDPCgwSaE5bAnKudmrhW38ikElxv0kWVNqiy2Gb7Nsh1jglAXuzkngm3W6xAP6DKm11s/TmBxvfXr9o=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (2603:10a6:20b:85::14)
 by AM6PR08MB4262.eurprd08.prod.outlook.com (2603:10a6:20b:b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Mon, 4 May
 2020 09:06:28 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d%3]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 09:06:28 +0000
Date:   Mon, 4 May 2020 10:06:28 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
Message-ID: <20200504090628.d2q32dwyg6em5pp7@DESKTOP-E1NTVVP.localdomain>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-4-john.stultz@linaro.org>
 <20200501102143.xcckvsfecumbei3c@DESKTOP-E1NTVVP.localdomain>
 <47e7eded-7240-887a-39e1-97c55bf752e7@arm.com>
 <CALAqxLU6kmvJ+xPCFzc3N+RNMv4g=L9bmzgE0wrOXefiGfPoHg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLU6kmvJ+xPCFzc3N+RNMv4g=L9bmzgE0wrOXefiGfPoHg@mail.gmail.com>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LNXP123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::32) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (82.1.208.173) by LNXP123CA0020.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Mon, 4 May 2020 09:06:27 +0000
X-Originating-IP: [82.1.208.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bf6419b3-499e-42f5-f8d2-08d7f00a7376
X-MS-TrafficTypeDiagnostic: AM6PR08MB4262:|AM6PR08MB4262:|VI1PR0801MB2095:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB209563C3F67447F0FF05CF72F0A60@VI1PR0801MB2095.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;OLM:8882;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: zPp3U3FEfsKFX7a9HESOO4JYYUae2MCPEeZbO0oeUZvohxp4UEUzbT+Kd+JZYAxN1qkNS8ibuIlDxrpXK9uBJVVDJrxk66DnYCbOk5rag4XhLiglzUbmhzcLI+kZWDvyWDe9QjH4dT+pT3CVkqRWJfH2dDtEUisgPV+Ct9rhH2ur7cZw9fhB1qSbBAAHqUnWdBfl2aAz2mbT93+WHBGjhK7Wg2eQd88eFlIxKacVLA4QOR4uvbBK8fUSzQLK1XfGM+Y3ruaM0uk8grPUPwVhYy5JC8yY8UueHt4VJNiiHqxkJo1jFJI8sFSAjPy6YO/1J5FDHhRuWKCj6LhXYR94BPFdhOmsEs5w1ygSgzrTuzVF1S/CTA28T8gXDyoEmL6lfKlJZlNqDyWbNEuNo0tBI3i36TQtTgJ9d+fIHQzekHlfkl5ocSJVcYY1J/9oNAvfxeiXlRGMv5iM/OFvUtT9eKViMM3Rk4Fl0UXtcjGZ1CDQuxGJOHzBcskcXY5A3i6k
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3829.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(86362001)(55016002)(2906002)(6916009)(478600001)(8936002)(9686003)(5660300002)(8676002)(6506007)(66946007)(956004)(53546011)(7416002)(186003)(26005)(16526019)(1076003)(52116002)(7696005)(66556008)(66476007)(4326008)(54906003)(44832011)(316002)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sT9mVsWfaq0GWQLx5SCmDh2PZAKCVxGVOa/HtbFPMiQkmM/jLPFfCz/od7+jwvM25EL8lcL++dW4N9i0YLOxrWE9/sbpfdOJ6VUEUAx3KxsHASJNlD0DUtA1nt4kyKxVr8c6g0jBmix14lZoRCwmTjTURMMpkvJ4oZVCi+HWlu6SGbrGL6kxI1uLYWvIxceWO5xcdeCxRLRhzVvAIGGES06vbNNSP1uHF9mAVH39ZqoXIzejdJq7G8yLVFM9ctuFSZ96Q/WW5T3xxnYhszjaDAurxc0SDrFK0w4JFXiCr6LeQA505FcOb3xtSCMyTNYVXTkbFtgSfv4M3aZYRSqp7eopCPH7r23VIop3hOZPbF0F3JdDHpqevFHX3uCjuCC83hwDwjRaNJlDoBBaYu+GXrHpFZNb6XLtyIDoMHrYQTzqw0vqa+QhJqST+1Ng+tO1wBQUBDDLWZSCkg15nmdWxImU0Ec+Yd5ioNA4T1HQHxqMHz6xzJezUCkGVjdQJgW1+uAK0jGy4fIeg8ZSCg6jQ5v4pkhHuIH5L4GAUKGw1my7eNlti81CwqN/sZ+wNwS9CG7on74aklo1PcunO8O2WEawjmRFj3ZGbe+7pWT7XUJ1L8HdQvGy4aIuzYYHVMUXUiUt1apqxyrE95VSelLJRwmKoCGmCgSC8ssqPOBRSfl+eUyxpWDrmtEMZpu9QEl4sF8HAcsl1/pvDSeZCCB4VcED60TCFLtDVecLJNCJOysw+kNjL5VmOKwfFMB2wzN77rEL3ymSho0FxDrOOREpx2pCfidaqncU9YxhcKCFDBU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4262
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT008.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(46966005)(26005)(16526019)(316002)(8936002)(956004)(336012)(7696005)(86362001)(44832011)(186003)(54906003)(6862004)(82740400003)(47076004)(82310400002)(8676002)(1076003)(2906002)(81166007)(478600001)(53546011)(6506007)(450100002)(5660300002)(356005)(9686003)(55016002)(70586007)(4326008)(70206006)(142933001);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: d4c63e69-87bf-49ea-0be7-08d7f00a6e0c
X-Forefront-PRVS: 03932714EB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2Zq1bdMmRJggEVlEnsKfYgeL5QI6U45HsL0BOnfE1qU19fOn2qJARHCCM9TIZukqIzwGXVosSQ3MY5kvILFYcLu4lR7rVpbwlaWJEO3MweZGeCjGbYkc7WRTroLdUSJnsCB1UXgURto3VCGATwxWYHCVTKuShqXG3+PBdn+b6D0oV9OMKngv7POJQLVnthDg9F04NxG8eLtcpkCqOijsITRIKgYvKjZQGfT7KXGwC2pRvYSGGKbvl9yrnQ24yXIoyOi2VWU0F65GSTgJ6b1u/HNPoOymeZtQdfq2NQdvOQAfEwIR6nnKl4njIpiaF3Nz8U3tFrrwk0pn4wIf4ynd64P5NHxhyus4TxCGj/P4m7VIKj03P9iA+f6exOTq21mPxtfcp/iM6fifn2o0b9va+wwfXOT9dAI6c81UH/jvs/KpTf/DbiFwlPHNLTz99ISQGG5EfQ6S96R1LgiM5pwr3G24M1sr1AOVy19ErlGPmmeqJvE2eiPxaxiX32DJMj6xfpcGK8ZpUqgxP/+w3axDY91ZfJaHL6AvQSUJwRAryYA=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 09:06:37.3640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6419b3-499e-42f5-f8d2-08d7f00a7376
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB2095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 12:01:40PM -0700, John Stultz wrote:
> On Fri, May 1, 2020 at 4:08 AM Robin Murphy <robin.murphy@arm.com> wrote:
> >
> > On 2020-05-01 11:21 am, Brian Starkey wrote:
> > > Hi John,
> > >
> > > On Fri, May 01, 2020 at 07:39:48AM +0000, John Stultz wrote:
> > >> This patch reworks the cma_heap initialization so that
> > >> we expose both the default CMA region and any CMA regions
> > >> tagged with "linux,cma-heap" in the device-tree.
> > >>
> > >> Cc: Rob Herring <robh+dt@kernel.org>
> > >> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > >> Cc: "Andrew F. Davis" <afd@ti.com>
> > >> Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > >> Cc: Liam Mark <lmark@codeaurora.org>
> > >> Cc: Pratik Patel <pratikp@codeaurora.org>
> > >> Cc: Laura Abbott <labbott@redhat.com>
> > >> Cc: Brian Starkey <Brian.Starkey@arm.com>
> > >> Cc: Chenbo Feng <fengc@google.com>
> > >> Cc: Alistair Strachan <astrachan@google.com>
> > >> Cc: Sandeep Patil <sspatil@google.com>
> > >> Cc: Hridya Valsaraju <hridya@google.com>
> > >> Cc: Christoph Hellwig <hch@lst.de>
> > >> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > >> Cc: Robin Murphy <robin.murphy@arm.com>
> > >> Cc: Andrew Morton <akpm@linux-foundation.org>
> > >> Cc: devicetree@vger.kernel.org
> > >> Cc: dri-devel@lists.freedesktop.org
> > >> Cc: linux-mm@kvack.org
> > >> Signed-off-by: John Stultz <john.stultz@linaro.org>
> > >> ---
> > >>   drivers/dma-buf/heaps/cma_heap.c | 18 +++++++++---------
> > >>   1 file changed, 9 insertions(+), 9 deletions(-)
> > >>
> > >> diff --git a/drivers/dma-buf/heaps/cma_heap.c b/drivers/dma-buf/heaps/cma_heap.c
> > >> index 626cf7fd033a..dd154e2db101 100644
> > >> --- a/drivers/dma-buf/heaps/cma_heap.c
> > >> +++ b/drivers/dma-buf/heaps/cma_heap.c
> > >> @@ -141,6 +141,11 @@ static int __add_cma_heap(struct cma *cma, void *data)
> > >>   {
> > >>      struct cma_heap *cma_heap;
> > >>      struct dma_heap_export_info exp_info;
> > >> +    struct cma *default_cma = dev_get_cma_area(NULL);
> > >> +
> > >> +    /* We only add the default heap and explicitly tagged heaps */
> > >> +    if (cma != default_cma && !cma_dma_heap_enabled(cma))
> > >> +            return 0;
> > >
> > > Thinking about the pl111 thread[1], I'm wondering if we should also
> > > let drivers call this directly to expose their CMA pools, even if they
> > > aren't tagged for dma-heaps in DT. But perhaps that's too close to
> > > policy.
> >
> > That sounds much like what my first thoughts were - apologies if I'm
> > wildly off-base here, but as far as I understand:
> >
> > - Device drivers know whether they have their own "memory-region" or not.
> > - Device drivers already have to do *something* to participate in dma-buf.
> > - Device drivers know best how they make use of both the above.
> > - Therefore couldn't it be left to drivers to choose whether to register
> > their CMA regions as heaps, without having to mess with DT at all?
> 
> I guess I'm not opposed to this. But I guess I'd like to see some more
> details? You're thinking the pl111 driver would add the
> "memory-region" node itself?
> 
> Assuming that's the case, my only worry is what if that memory-region
> node isn't a CMA area, but instead something like a carveout? Does the
> driver need to parse enough of the dt to figure out where to register
> the region as a heap?

My thinking was more like there would already be a reserved-memory
node in DT for the chunk of memory, appropriately tagged so that it
gets added as a CMA region. 

The device's node would have "memory-region=<&blah>;" and would use
of_reserved_mem_device_init() to link up dev->cma_area to the
corresponding cma region.

So far, that's all in-place already. The bit that's missing is
exposing that dev->cma_area to userspace as a dma_heap - so we could
just have "int cma_heap_add(struct cma *cma)" or "int
cma_heap_dev_add(struct device *dev)" or something exported for
drivers to expose their device-assigned cma region if they wanted to.

I don't think this runs into the lifetime problems of generalised
heaps-as-modules either, because the CMA region will never go away
even if the driver does.

Alongside that, I do think the completely DT-driven approach can be
useful too - because there may be regions which aren't associated with
any specific device driver, that we want exported as heaps.

Hope that makes sense,
-Brian

> 
> thanks
> -john
