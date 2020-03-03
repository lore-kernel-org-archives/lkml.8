Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFBBC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCE22080C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="miGjpXje";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="miGjpXje"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgCCKxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:53:42 -0500
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:56302
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728454AbgCCKxl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:53:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdIjeztbu4suoMrtRh5LJc3vAdFk+ORXzTNqLB9I1DQ=;
 b=miGjpXjeWuKhal3oqdGKl2nZQbHH2EMvW60CIKFz5OPHy5mFRB5LhNki9Hd+VfHwYDVwLdjQToB9jLfaHAjG2hEfWbZ+tCD4C4pNONHM245gsX2xHK4EH/ped8E8DpFtg1FkXE6TRPxr1p4ImRgvXb+Z0Ei3imsOyxjNGme2M4k=
Received: from VI1PR08CA0160.eurprd08.prod.outlook.com (2603:10a6:800:d1::14)
 by AM7PR08MB5462.eurprd08.prod.outlook.com (2603:10a6:20b:10b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 10:53:33 +0000
Received: from AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::200) by VI1PR08CA0160.outlook.office365.com
 (2603:10a6:800:d1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18 via Frontend
 Transport; Tue, 3 Mar 2020 10:53:33 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT026.mail.protection.outlook.com (10.152.16.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 10:53:32 +0000
Received: ("Tessian outbound 846b976b3941:v42"); Tue, 03 Mar 2020 10:53:31 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 2fb315371c14d04a
X-CR-MTA-TID: 64aa7808
Received: from 37e9f0de91be.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id D554EB7A-A13B-4AF5-A4B8-84DBDC75D929.1;
        Tue, 03 Mar 2020 10:53:26 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 37e9f0de91be.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Mar 2020 10:53:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DrFds+ImEgWXXOaAkcEXfQ69QMAcceNGcj39KRfmajMXmrspi6LCI76jEqwevEER5VK1r1oqtEcxS/6mrE564zzJjLu4Kh/otNqB622W/8qltOPsQLA+FNeACCLZR6P6naxuwi8ZaD1Aa7yr1PwvWHn4YTx1Hst/yygAvb0ML/UpB+Yg8WIkcIPYLqTkXiGtd1CaoPKciBehIQacPxXihrFRkYXW5AaloY5Y06Tw8aqiVnXGPgT9ImGdgnSk4GjBDneH8ZWFmTCmvqWLhF5mN5iVMcu5xxorNlSjgIsS3SpdcczgStoCRjO0/yLcDfJdZ7DuJfZrqic4QRtIH2jiyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdIjeztbu4suoMrtRh5LJc3vAdFk+ORXzTNqLB9I1DQ=;
 b=a0i9LtBZ4lTI3DHzCg7acRg1QFaZk7k/ZHfAr6N4tQ+dlYOQOwu8PxMgI5SldevIcJOFqq3hNqnM6L+NSEuIFTrE+twK/w3KRNVD9TSa2PXVVTveqTCVbhd0oB96o8N2+LrCaWw3ZzQZqOUu18FY7zswyO0WGyOo/DXkUhqgma1OD2VwudizuNh6wWJzmAANYxKRIBmeaTHVz9D5lrY7o8B7nvFXNFn+r6sQWfeNNeAVXBUgzvkP9xxeASRY5XgAhd+zKTdHh7sh2rqLqQO/mfXGc/7ZUsF1vH2u6lCGRSYlGBRhxGfpZArjgcXwrZRdPHDRAf1hQbprAmTS+/o/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DdIjeztbu4suoMrtRh5LJc3vAdFk+ORXzTNqLB9I1DQ=;
 b=miGjpXjeWuKhal3oqdGKl2nZQbHH2EMvW60CIKFz5OPHy5mFRB5LhNki9Hd+VfHwYDVwLdjQToB9jLfaHAjG2hEfWbZ+tCD4C4pNONHM245gsX2xHK4EH/ped8E8DpFtg1FkXE6TRPxr1p4ImRgvXb+Z0Ei3imsOyxjNGme2M4k=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3046.eurprd08.prod.outlook.com (52.135.165.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15; Tue, 3 Mar 2020 10:53:24 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::75a9:e388:c1ff:6352]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::75a9:e388:c1ff:6352%5]) with mapi id 15.20.2772.018; Tue, 3 Mar 2020
 10:53:24 +0000
Date:   Tue, 3 Mar 2020 10:53:25 +0000
From:   Brian Starkey <brian.starkey@arm.com>
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, nd@arm.com
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifier definitions for describing
 Amlogic Video Framebuffer Compression
Message-ID: <20200303105325.bn4sob6yrdf5mwrh@DESKTOP-E1NTVVP.localdomain>
References: <20200221090845.7397-1-narmstrong@baylibre.com>
 <20200221090845.7397-2-narmstrong@baylibre.com>
 <20200303121029.5532669d@eldfell.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303121029.5532669d@eldfell.localdomain>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::27) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (217.140.106.52) by LO2P265CA0471.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a2::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14 via Frontend Transport; Tue, 3 Mar 2020 10:53:24 +0000
X-Originating-IP: [217.140.106.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08967fbd-c791-423c-3a79-08d7bf611de6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3046:|AM7PR08MB5462:
X-Microsoft-Antispam-PRVS: <AM7PR08MB5462525A5D963E925F8487F5F0E40@AM7PR08MB5462.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;OLM:10000;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(189003)(199004)(5660300002)(186003)(52116002)(7696005)(16526019)(9686003)(44832011)(86362001)(55016002)(6506007)(2906002)(1076003)(66946007)(81166006)(8676002)(4326008)(8936002)(478600001)(316002)(6916009)(66476007)(66556008)(26005)(81156014)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3046;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: xZdJFGg77MD31b6coOgyxJsP6RdCvLqeFuKObUhZakFdYzzO9lkiam02zAik4ljgixfV92m9yJMk4wIYEkA64vStMcGIcDtnxb2taRAc9A3nJdjvTvdXjtyollbv+WjeLH98y85SyyoakdmGW4+SChIo6xy3xQsIjsbPgotiMly5LKv8tVVDQmnLmA6v/hzexDTQCEg9lXuoOgUT3bsxJPZM5qn0CdxUdHnbCYOoqZoMdH5saShcmUwZh7y33zgx6b6YpPMo0x3PnezyBbKff72hz5n23OY/DM65kdVG0aKga9wp07dEtJS6QJbpMQDEmn7ghoAYLGSrRCu8AmF6bTdc3/jGktOLht+2/V7NMFFe0vSw9WP6vBBZjpKJB2PoErjEDzPCtUovxDnUZPF7gx5xu2iGJd8LTETGsEDMpcqV9PSuBEg2qE07c4EMzI6G
X-MS-Exchange-AntiSpam-MessageData: VlCO4z76c5qkgy8Q5XpMLWY00qPK7QORb3BZzNkAqjqK0Mt6Y4m3yH0eZKMZq4bOr1JOUFXfyim1gIA7SYNgTFhKzIow3lB7DcZo5q/NI5DwniEy50mPx/79v6i4x0viURSjX30nwAQ+6w5PUtFprQ==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3046
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(39860400002)(136003)(376002)(199004)(189003)(1076003)(956004)(9686003)(55016002)(336012)(356004)(7696005)(44832011)(6862004)(5660300002)(81156014)(81166006)(26826003)(70206006)(478600001)(316002)(36906005)(16526019)(70586007)(6506007)(8676002)(26005)(2906002)(4326008)(8936002)(86362001)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM7PR08MB5462;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;A:1;MX:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 61529b82-9df9-454f-c4c1-08d7bf6118bd
X-Forefront-PRVS: 03319F6FEF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jJ/OR02o+oOqKl002mTcZZd540uEFP7NBgz8vzUGfoa/x6h5+/55RCfUpQOHGJLe77KNSpscHsTgk9SzFqUJULCnptSL8gj8+BTP9dWiWEsoq7iAX7afeHq3Q9TI4uxH1DhKv1odWRdey+4ZyUOgT+aecffAMaDh05K5QqC+N4S87tJPSEcG5kOsvMw7SrSc2Lo0LnNLzqih2xxg6Auq805ZbAG2nAzEO9fN0r1DmputPkQNMXfbKDnAaFXNj/AG57/HfP7LYQ9JyE1p2lMnkLv7a4a7AL1zUKkqRQm9LLjQgKnJLAKUlDpZ9s0764W5Lm4q41bnEhlZao18GGIKS8IRlNE+gSSye7douU8WuycSedVVEvSQ/tLfeZ85neqvVlLIT2r0/gEXQMYoQph9rRBZGl/nfjr5k55/R+SDK06cX53uj7wziqwBpAJxEYQE
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 10:53:32.9924
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08967fbd-c791-423c-3a79-08d7bf611de6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5462
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 03, 2020 at 12:10:29PM +0200, Pekka Paalanen wrote:
> On Fri, 21 Feb 2020 10:08:42 +0100
> Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> > Amlogic uses a proprietary lossless image compression protocol and format
> > for their hardware video codec accelerators, either video decoders or
> > video input encoders.
> > 
> > It considerably reduces memory bandwidth while writing and reading
> > frames in memory.
> > 
> > The underlying storage is considered to be 3 components, 8bit or 10-bit
> > per component, YCbCr 420, single plane :
> > - DRM_FORMAT_YUV420_8BIT
> > - DRM_FORMAT_YUV420_10BIT
> > 
> > This modifier will be notably added to DMA-BUF frames imported from the V4L2
> > Amlogic VDEC decoder.
> > 
> > At least two options are supported :
> > - Scatter mode: the buffer is filled with a IOMMU scatter table referring
> >   to the encoder current memory layout. This mode if more efficient in terms
> >   of memory allocation but frames are not dumpable and only valid during until
> >   the buffer is freed and back in control of the encoder
> > - Memory saving: when the pixel bpp is 8b, the size of the superblock can
> >   be reduced, thus saving memory.
> > 
> > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > ---
> >  include/uapi/drm/drm_fourcc.h | 56 +++++++++++++++++++++++++++++++++++
> >  1 file changed, 56 insertions(+)
> > 
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 8bc0b31597d8..8a6e87bacadb 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -309,6 +309,7 @@ extern "C" {
> >  #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
> >  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
> >  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
> > +#define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> >  
> >  /* add more to the end as needed */
> >  
> > @@ -804,6 +805,61 @@ extern "C" {
> >   */
> >  #define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
> >  
> > +/*
> > + * Amlogic Video Framebuffer Compression modifiers
> > + *
> > + * Amlogic uses a proprietary lossless image compression protocol and format
> > + * for their hardware video codec accelerators, either video decoders or
> > + * video input encoders.
> > + *
> > + * It considerably reduces memory bandwidth while writing and reading
> > + * frames in memory.
> > + * Implementation details may be platform and SoC specific, and shared
> > + * between the producer and the decoder on the same platform.
> 
> Hi,
> 
> after a lengthy IRC discussion on #dri-devel, this "may be platform and
> SoC specific" is a problem.
> 
> It can be an issue in two ways:
> 
> - If something in the data acts like a sub-modifier, then advertising
>   support for one modifier does not really tell if the data layout is
>   supported or not.
> 
> - If you need to know the platform and/or SoC to be able to interpret
>   the data, it means the modifier is ill-defined and cannot be used in
>   inter-machine communication (e.g. Pipewire).
> 

Playing devil's advocate, the comment sounds similar to
I915_FORMAT_MOD_{X,Y}_TILED:

 * This format is highly platforms specific and not useful for cross-driver
 * sharing. It exists since on a given platform it does uniquely identify the
 * layout in a simple way for i915-specific userspace.

Isn't the statement that this for sharing between producer and decoder
_on the same platform_ a similar clause with the same effect?

What advantage is there to exposing the gory details? For Arm AFBC
it's necessary because IP on the SoC can be (likely to be) from
different vendors with different capabilities.

If this is only for talking between Amlogic IP on the same SoC, and
those devices support all the same "flavours", I don't see what is
gained by making userspace care about internals.

Thanks,
-Brian

> Neil mentioned the data contains a "header" that further specifies
> things, but there is no specification about the header itself.
> Therefore I don't think we can even know if the header contains
> something that acts like a sub-modifier or not.
> 
> All this sounds like the modifier definitions here are not enough to
> fully interpret the data. At the very least I would expect a reference
> to a document explaining the "header", or even better, a kernel ReST
> doc.
> 
> I wonder if this is at all suitable as a DRM format modifier as is. I
> have been assuming that a modifier together with all the usual FB
> parameters should be enough to interpret the stored data, but in this
> case I have doubt it actually is.
> 
> I have no problem with proprietary data layouts as long as they are
> fully specified.
> 
> I do feel like I would not be able to write a software decoder for this
> set of modifiers given the details below.
> 
> 
> Thanks,
> pq
> 
