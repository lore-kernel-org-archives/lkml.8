Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7233C4725A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15B624958
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Mb63dsVO";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="Mb63dsVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbgEDIuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 04:50:25 -0400
Received: from mail-eopbgr60079.outbound.protection.outlook.com ([40.107.6.79]:56996
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728351AbgEDIuX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 04:50:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccOjH4U5ZLihVh8WAibZSAYYBO4ImtOs2UMnmc8KAcg=;
 b=Mb63dsVOylMgGDsEnJDGWmMzwArA5Ga7PKav3uakdea2pxbes1H24YpbtrvknRkA6Neam1wzLKooLDoAa8mMZhZDMybTPDYS4m334tnc6NazKPsGdZy5ufx6o6TGxPZn6LizakyrvbPgvr0X/V1mpVOfH45/ZBs5imbKV5cDitM=
Received: from AM6P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:8b::27)
 by AM6PR08MB5543.eurprd08.prod.outlook.com (2603:10a6:20b:b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 08:50:17 +0000
Received: from AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8b:cafe::f2) by AM6P191CA0014.outlook.office365.com
 (2603:10a6:209:8b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Mon, 4 May 2020 08:50:17 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT048.mail.protection.outlook.com (10.152.17.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2958.20 via Frontend Transport; Mon, 4 May 2020 08:50:17 +0000
Received: ("Tessian outbound ff098c684b24:v54"); Mon, 04 May 2020 08:50:17 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 55b1d0c16200114a
X-CR-MTA-TID: 64aa7808
Received: from fe1fcf1b13ab.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 6FC8B5AC-99D6-4982-9724-01A3C4E8A0F0.1;
        Mon, 04 May 2020 08:50:12 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id fe1fcf1b13ab.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 04 May 2020 08:50:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAuoL5p4dyhMXpDBc1adi8goDuN5O9Jt1ihLwwIPoBpOvLXYRZkYCDL2/FKcxqbTq7KboFDqnpuv3yM4vB1RDwFBI6w0E7GseCNgs/Y10ckH7DKvMG9guE5bfbHdeWRzLCUqMZjmufCz014potNL7UAvRGO62hLrh+4rSK+yuLTZB9UQ3UFnhyc+Ih9nRkPjXrAmdbUDp0d8gvqz5x7TKlfu8JOVgolIDU5UNC8GGg0jUEa0tSEFPVZTEXFQ74LkitNd4ZRARP1sWarNiKHPwSWCEcEv9u38Q8gdOLlIijBx+8gkEm4MBbjWEiLZJt/U6anD/f4a3K3g2KDQiNGgpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccOjH4U5ZLihVh8WAibZSAYYBO4ImtOs2UMnmc8KAcg=;
 b=B3DDdrh6GH2af9UovD6rx6hX+wSRbbd6ND6PjjYP2Q77+eTGseUfT4gWDe/Bb9X9/ujhdkXcbZ7kBXvIyoBFNl2n9zMkg1F6nrdogiGg9hw85pTZS1THpJ4U88+ZJJcbS8D6sdi613pLtJDAwlDgT+PlekOVCh8w0Oxs/Vqw+mf3lJw+S9QmKhWP4WrHqvzCffflvAkiHXXIw6Q0tgD5EQUczzaGQ2Fw5XfJTCXgbBmzIHuOrmBmfvRe7q5QEh3kFJCZhBNuj1Dj3ucmi+2cGq7La++/lCEnM0aO5npTQQgrlyIEUoksNuc3dCXqS80xGY4TjDQrKg9QbKw0DVUIWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccOjH4U5ZLihVh8WAibZSAYYBO4ImtOs2UMnmc8KAcg=;
 b=Mb63dsVOylMgGDsEnJDGWmMzwArA5Ga7PKav3uakdea2pxbes1H24YpbtrvknRkA6Neam1wzLKooLDoAa8mMZhZDMybTPDYS4m334tnc6NazKPsGdZy5ufx6o6TGxPZn6LizakyrvbPgvr0X/V1mpVOfH45/ZBs5imbKV5cDitM=
Authentication-Results-Original: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (2603:10a6:20b:85::14)
 by AM6PR08MB4039.eurprd08.prod.outlook.com (2603:10a6:20b:a1::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Mon, 4 May
 2020 08:50:08 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::78d3:4ffd:f7da:b26d%3]) with mapi id 15.20.2958.030; Mon, 4 May 2020
 08:50:08 +0000
Date:   Mon, 4 May 2020 09:50:07 +0100
From:   Brian Starkey <brian.starkey@arm.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mm <linux-mm@kvack.org>, nd <nd@arm.com>
Subject: Re: [RFC][PATCH 1/4] devicetree: bindings: Add linux,cma-heap tag
 for reserved memory
Message-ID: <20200504085007.5yrjhknkg6ugbqwk@DESKTOP-E1NTVVP.localdomain>
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-2-john.stultz@linaro.org>
 <20200501104216.4f226c2a7bzval5o@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLVScV1j-zxw=cwpE0+eDoaubchXx6SJgu=1Zvh8HnE-Tg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLVScV1j-zxw=cwpE0+eDoaubchXx6SJgu=1Zvh8HnE-Tg@mail.gmail.com>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LNXP123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::26) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (82.1.208.173) by LNXP123CA0014.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Mon, 4 May 2020 08:50:07 +0000
X-Originating-IP: [82.1.208.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1f3bc4fa-037c-435d-fced-08d7f0082b6b
X-MS-TrafficTypeDiagnostic: AM6PR08MB4039:|AM6PR08MB4039:|AM6PR08MB5543:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB5543AF8674C86BBE82A9BE85F0A60@AM6PR08MB5543.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;OLM:3513;
X-Forefront-PRVS: 03932714EB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 5aqkfSzawpaRGdgh5I+KcYz/6WcivLoO6/DG8JpWeatju/j35p/g7hEEeuQTx5LSNabZm1nIXnJ/qLxw12L8HLS1jy7+lz6O0+ucX2QmwsNGds4Hn5XMOTgdxC2UNBB/SXdjuuV3U9177N6ku241jPPzRQ/O/13M8Ge6wB+qyMGmb7RbFU7jNO9NdsOAiQDxIUuD6oeZ52hFwqpKfw3jEGizY7iglAm4WX6i9elJDBkIuHhEWkLb7Mu/dfAbX1WI2s6iKt7OEyIH1aHbmO84gFfxVVltMtVg+md7esKlGKGcr9YP06I+I47iRCANHfjS2xk2PkmnfsS480atEfcWIVt88BE+whAbIx3hjm7qoWIu67pzyABTr07HDb3RY8pwEZr6LTM3Qni930CrMMhx1tN5L4quDK+zflnkv7YpOtRsD1H1MfUKlM/k00+1Iegh/FlGprg1NDM45ldKYc7IXBBktw4ufv84iLGM8VMjonptcdzidWCJXOQDAyjgjsbB
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3829.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(86362001)(6916009)(52116002)(2906002)(7696005)(66946007)(9686003)(478600001)(5660300002)(16526019)(186003)(66556008)(6506007)(53546011)(66476007)(26005)(44832011)(1076003)(956004)(7416002)(55016002)(8936002)(54906003)(316002)(8676002)(4326008)(142933001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: PjXOCi9sreftXgJc64m9gRBwy8tZkkmGzDCG4ZvgEtLy3S3GQzWK62il6VVM48kCv9LqrCplVroT1It4eRoOvhmzPxyRCNZm6sAXwdNEM62uazFdiJj4Cnk95MBlfERAjsUeV1SdQs5a0vV1gQ1j0ToU6c+MtuS7WN9SMu/7Iy+5nyr1aQRBJd6ToQxx5kBsKJouUf6b85tfvm1lmhh0LJ3O2tSutSy4nOvcrPbV5zS80dTcEXbIVnG88LJRjxyKYKGBf4ni4qUFhkYGdmk7vcJ1Ni2JZHJ9z1DvM7m4gu8WqMVHfFpnrmELj6YwSTM/QQP/+D5osfCdSbrRqNxzWQSKpd0Jgkpjd4zC21pePtCYuRQ/E6oD3UDJfOgfaYec37eTNqg15bI+N7fj5ClTr9DLXfE3rUyqgJTNcUoqtgiEYciiDbAPgFRsrONIL5s+xQ8ghqjoTqA5nokQRN2Mq0C4S7aRvYZuoH3sttQ0sZIh/baODO4jVBCS4aDoGlKZFezHb0aPm/6tmB/zkTe3OWHuySU9QRmg8Hv9vlx2uT3Pe0CE/vaxQLhwiraun9sa0LDKIAxoHxx/xU0qbx9Pje01x/ILqqIJDmdDRReKATHTVjtcqiX2sAJ5z4YJ+m7fI2PqfSy5lQZdSj/bRoCFLwphrOUR+Fv/UVakC0cKDj7HgoUnukV7CxmWVk/41TRb0Bpjc5871+R4ZQQ+Wx6OhtLsOUUk7R+zoJbxYjmrcacYIxYA0lLj7cF/uQwPVWRBWUyNkS9WCIMMMPQ3pk59+1Oi9VgjODNfeSWwGkHRU8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4039
Original-Authentication-Results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT048.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966005)(86362001)(1076003)(956004)(44832011)(55016002)(6862004)(4326008)(47076004)(82310400002)(8936002)(54906003)(450100002)(8676002)(316002)(356005)(7696005)(36906005)(2906002)(81166007)(186003)(16526019)(5660300002)(70206006)(26005)(336012)(9686003)(478600001)(53546011)(70586007)(82740400003)(6506007)(142933001);DIR:OUT;SFP:1101;
X-MS-Office365-Filtering-Correlation-Id-Prvs: cb0f6ef8-cfa9-4aef-0c4d-08d7f00825cf
X-Forefront-PRVS: 03932714EB
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NbcQeun8WWz/AiP11OUW5laMRuC3OMqmri+NWUB45Giq1UPZ2/EYisQpJILRNYK7ySbFG+vxOAqk3lc1t9VDinSB/1f9msiiG39KaxSY1aDOV4NyFUvaHbnVCMhtSLQYlsLOj9FY53CmLbmGv7NfQzvLoKs44mbOPrbxbuQBXGBcf0ekjxrbbcdx7nHfMQCDlRtyt9peDJOZiDX4n6LoiCcqyM/1a7Dt9O43la3VJvR4adTWAbjlQcuIkS8K/rO7CdesdTIYPhuIF4sVUWiQfvhPpy+Zyg3VKHronddVWSmaZF7PHI1u/cYDB4vbrnRaaEj6TR5bZl0YRnEcnVfN0ebR/L4UIW7hgVa/t6zATN6tzXFgIpXEYbwdkcShpXeRCjI6y4stHqcnAhWBsgZgRKlmvQyDiDY8/3cmhYF1dtPTGkDOFjnAbpRF1MhLVS9qvK0psP2/xJ0OJ8cZqM7TCXAjbCjwTa4BYHORzOkEyBefCFgDNwv82eOx+4aw37w0FrOzZ6HEON/imUonmNmhsPd43RiOO/n8yYqhy2K9h+A=
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2020 08:50:17.4296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3bc4fa-037c-435d-fced-08d7f0082b6b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5543
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 11:40:16AM -0700, John Stultz wrote:
> On Fri, May 1, 2020 at 3:42 AM Brian Starkey <brian.starkey@arm.com> wrote:
> >
> > Hi,
> >
> > On Fri, May 01, 2020 at 07:39:46AM +0000, John Stultz wrote:
> > > This patch adds a linux,cma-heap property for CMA reserved memory
> > > regions, which will be used to allow the region to be exposed via
> > > the DMA-BUF Heaps interface
> > >
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Sumit Semwal <sumit.semwal@linaro.org>
> > > Cc: "Andrew F. Davis" <afd@ti.com>
> > > Cc: Benjamin Gaignard <benjamin.gaignard@linaro.org>
> > > Cc: Liam Mark <lmark@codeaurora.org>
> > > Cc: Pratik Patel <pratikp@codeaurora.org>
> > > Cc: Laura Abbott <labbott@redhat.com>
> > > Cc: Brian Starkey <Brian.Starkey@arm.com>
> > > Cc: Chenbo Feng <fengc@google.com>
> > > Cc: Alistair Strachan <astrachan@google.com>
> > > Cc: Sandeep Patil <sspatil@google.com>
> > > Cc: Hridya Valsaraju <hridya@google.com>
> > > Cc: Christoph Hellwig <hch@lst.de>
> > > Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Cc: Robin Murphy <robin.murphy@arm.com>
> > > Cc: Andrew Morton <akpm@linux-foundation.org>
> > > Cc: devicetree@vger.kernel.org
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: linux-mm@kvack.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > >  .../devicetree/bindings/reserved-memory/reserved-memory.txt    | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > index bac4afa3b197..e97b6a4c3bc0 100644
> > > --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> > > @@ -68,6 +68,9 @@ Linux implementation note:
> > >  - If a "linux,cma-default" property is present, then Linux will use the
> > >    region for the default pool of the contiguous memory allocator.
> > >
> > > +- If a "linux,cma-heap" property is present, then Linux will expose the
> > > +  the CMA region via the DMA-BUF Heaps interface.
> > > +
> >
> > Would it be useful or even possible to give some indication of what
> > the heap will end up being called? I'm afraid I don't remember what if
> > any conclusions came out of previous discussions on UAPI for heap
> > enumeration.
> 
> So the name we expose is the CMA name itself. So with dt it will be
> the name of the reserved memory node that the flag property is added
> to.
> 

Yeah I'm just wondering if that's "stable" so we can say "the heap
will use the node name", or if saying that would cause us a headache
in the future.

> > I suppose CMA names haven't been relevant to userspace before, but
> > they perhaps would be with this change.
> >
> > Alternatively, leaving it effectively undefined doesn't tie us down,
> > and something like links in sysfs can be added as a richer API in the
> > future.
> 
> Hrm. Mind expanding on what you're thinking here?

Super hand-wavy, something like:

/sys/devices/blah/display@2f000000/cma_region is a symlink to
	/sys/class/dma_heaps/heap_display

I think danvet had some thoughts in this vein.

Cheers,
-Brian

> 
> thanks
> -john
