Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD5BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26ED20848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 13:43:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="v4IT0Lz3";
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="v4IT0Lz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgCCNno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 08:43:44 -0500
Received: from mail-eopbgr70053.outbound.protection.outlook.com ([40.107.7.53]:12131
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727192AbgCCNno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 08:43:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgrtee7182Rt+wlTzU/uudpndSDevt0GH3z9OHqJzCA=;
 b=v4IT0Lz3BtRXcnFrGjFO17ZjgDZcSbhu/nSYY0obPrpGyv90ZvZjNQaLMGY+G1v3ReIeOPJO45RWVjHvTWhkbeKA6lmp78qboqjQafIPqwMF/FEve49V5h+Qk4aJRILo1i//TtAj7uBXzfMic0xLWw9JkJfw+ejdZUziZ78Hyqs=
Received: from VI1PR08CA0196.eurprd08.prod.outlook.com (2603:10a6:800:d2::26)
 by VI1PR08MB3984.eurprd08.prod.outlook.com (2603:10a6:803:e9::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.16; Tue, 3 Mar
 2020 13:43:36 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::209) by VI1PR08CA0196.outlook.office365.com
 (2603:10a6:800:d2::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend
 Transport; Tue, 3 Mar 2020 13:43:35 +0000
Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.15 via Frontend Transport; Tue, 3 Mar 2020 13:43:35 +0000
Received: ("Tessian outbound efdea641ed36:v42"); Tue, 03 Mar 2020 13:43:35 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: f5a9596c8e67f07b
X-CR-MTA-TID: 64aa7808
Received: from 4ce2d6aab017.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id E2251C5B-FBFA-4561-B6F5-05DC7D29D6E4.1;
        Tue, 03 Mar 2020 13:43:30 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 4ce2d6aab017.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Tue, 03 Mar 2020 13:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2DV1OLmbaw3lIgm14D6sKcU85O5rq2VHSy0XxrlPNlNzQNCXTsmIK3Rn+eamCU/okkMbfwIeM7mQSLWTCHcdHid25g2mCD+sEx3+TLo+mI28USbjYT+3stRHc13Qm2eGTaCA39+aI0th/mV8dqs6LsGLkNUQecJqptpKP2LZDwwoWKlf8WCw4A88y8xVueWgLzCmL2rJIlhgM+JO/hB7BtcxCZBUGhFPioOyGwJS7VnCNjG+q8aCMz2ibXRCQpU6X+q1J+N93hEWTxrGIWsQbcaMh9KHRsdbYGuYq4Hur5DkJJGAkT19rA9ONzAMJMTnFwkwFyGdhKsB3Ed6e6ixw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgrtee7182Rt+wlTzU/uudpndSDevt0GH3z9OHqJzCA=;
 b=XphU9XrZ4V95a2VZH4oO11+Q02R1vKuGtyA6QttwBSjfRX8nMZuBlxsYYteBqOroj6kVe5uXbeRRUG+pRtEEo6B7rjeH9ewjx6hbmLUZcNGRwvBX+8zgtKPIb/CsIbPpBKJlRLx8FxGa9Uws9S4OIAtRdDE6iqwlIDwILUJQKaWRxJQdBSzJ5jnZ1Lzq45Kfwoh00DqgVJxCFi2CvGI/iT7syHYd03HyBMAIbSsU4V03rXcsEnVJGIVcydcNm+IK5zG1/Zwr6ymgSzDRPYVy30x7WXVyiOBQtoxaRMVRYNMa3zY4TZUfMye8Xb33Vy9l/v23pVDZPmzBck71M61xCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mgrtee7182Rt+wlTzU/uudpndSDevt0GH3z9OHqJzCA=;
 b=v4IT0Lz3BtRXcnFrGjFO17ZjgDZcSbhu/nSYY0obPrpGyv90ZvZjNQaLMGY+G1v3ReIeOPJO45RWVjHvTWhkbeKA6lmp78qboqjQafIPqwMF/FEve49V5h+Qk4aJRILo1i//TtAj7uBXzfMic0xLWw9JkJfw+ejdZUziZ78Hyqs=
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com (20.178.89.14) by
 AM6PR08MB3205.eurprd08.prod.outlook.com (52.135.166.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.18; Tue, 3 Mar 2020 13:43:29 +0000
Received: from AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::75a9:e388:c1ff:6352]) by AM6PR08MB3829.eurprd08.prod.outlook.com
 ([fe80::75a9:e388:c1ff:6352%5]) with mapi id 15.20.2772.018; Tue, 3 Mar 2020
 13:43:28 +0000
Date:   Tue, 3 Mar 2020 13:43:29 +0000
From:   Brian Starkey <brian.starkey@arm.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Pekka Paalanen <ppaalanen@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amlogic@lists.infradead.org, nd <nd@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/4] drm/fourcc: Add modifier definitions for describing
 Amlogic Video Framebuffer Compression
Message-ID: <20200303134329.vqpaql73ozm5zw3o@DESKTOP-E1NTVVP.localdomain>
References: <20200221090845.7397-1-narmstrong@baylibre.com>
 <20200221090845.7397-2-narmstrong@baylibre.com>
 <20200303121029.5532669d@eldfell.localdomain>
 <20200303105325.bn4sob6yrdf5mwrh@DESKTOP-E1NTVVP.localdomain>
 <CAKMK7uFgQGrnEkXyac15Wz8Opg43RTa=5cX0nN5=E_omb8oY8Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFgQGrnEkXyac15Wz8Opg43RTa=5cX0nN5=E_omb8oY8Q@mail.gmail.com>
User-Agent: NeoMutt/20180716-849-147d51-dirty
X-ClientProxiedBy: LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::31) To AM6PR08MB3829.eurprd08.prod.outlook.com
 (2603:10a6:20b:85::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-E1NTVVP.localdomain (217.140.106.52) by LO2P265CA0043.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:61::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19 via Frontend Transport; Tue, 3 Mar 2020 13:43:28 +0000
X-Originating-IP: [217.140.106.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3069ef36-15ea-4335-f42b-08d7bf78df38
X-MS-TrafficTypeDiagnostic: AM6PR08MB3205:|VI1PR08MB3984:
X-Microsoft-Antispam-PRVS: <VI1PR08MB39848A8B8EDDD9CACD379F97F0E40@VI1PR08MB3984.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;OLM:5516;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(376002)(396003)(346002)(136003)(366004)(199004)(189003)(66556008)(6916009)(956004)(66476007)(53546011)(6506007)(478600001)(2906002)(966005)(66946007)(54906003)(9686003)(8936002)(4326008)(44832011)(86362001)(52116002)(7696005)(55016002)(16526019)(81156014)(8676002)(81166006)(26005)(186003)(5660300002)(1076003)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB3205;H:AM6PR08MB3829.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 05ZP6gVeWiA5iH07oJr6w8PX3C65z/tshGm9ASudVcyOeS/fVhttX2/fyIsVg49KFtnDdPx7qk5AiZHwTrnXG1FCahBY5Pjycuw6wcFEJEYdethPAavZLCdlR2lodAPFNWoOBauTmxDw4pbIwzw8noVswT8QMJbF5H1YKQyNhWVwnX9sALoX11NN3xwxU5DOmoztZsNdElA/BS9p8FuvcyDzp2kPmjkVX/8tlmk+Hauh3drkk5hP6l1fj49uwsJXAK1rIYFFPMzfw3iZyHSxTrC3v7pd0FoJFh2awfc8p0k00SSUad9tBD4HH1i51cChEdAZ1BSYYsbmSryhU0rTN1lm22WUvh219UbpVlppRo9/uRcVtll/NNBT/YPWiyKVi6XLUP89rE1qaZ10jidj4DA7SmQ9j+JguxBeDRqRS0odW+ZB5mKOItJ/bj3Hb2YahYF7qVdctKv8z/lIfu/14DzwzLJUekhJJEPqjeYcupTA9tnqrbBtOCWOvN0weLi+iwiYf5TwUBnPmR0KvrJsUQ==
X-MS-Exchange-AntiSpam-MessageData: /I9T5HQgKEBkAqK5gifODgDHrW32rPh0i5Hl1LsAJExUpJg0PSi9cHBs3KpWSSExb7qA7C71EEB4dGhZHr5mBpoFNjo8cW/weeNOFxtpInr6jjdLGsruJ65zmG0SN17KcTD1/qjNl0Gbx970xHs6BQ==
X-MS-Exchange-Transport-Forked: True
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3205
Original-Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Brian.Starkey@arm.com; 
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:63.35.35.123;IPV:CAL;SCL:-1;CTRY:IE;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(189003)(199004)(956004)(53546011)(966005)(6506007)(478600001)(6862004)(26826003)(70206006)(16526019)(1076003)(2906002)(7696005)(316002)(70586007)(336012)(54906003)(44832011)(4326008)(26005)(55016002)(107886003)(9686003)(8676002)(186003)(356004)(86362001)(81156014)(81166006)(5660300002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR08MB3984;H:64aa7808-outbound-1.mta.getcheckrecipient.com;FPR:;SPF:Pass;LANG:en;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;MX:1;A:1;
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2c4d1452-ecf7-40e9-0304-08d7bf78daee
X-Forefront-PRVS: 03319F6FEF
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K/pAmg0neIGVdTOGH21cv96mYbHm5Lnyjai/Qho7eKHr/AFlbT/P94AjNSOqfuElCnKivxwuVP3P82MkispJhbo3MKHWJNZHttgECe3fFdAUk2s59d+1qAHvViK3OgDQHefsdGBcUd+hsQXSmudSh6KwIOpzK/OBeILMIXsloTBuYIYwrVqOF+vfNVdldNPVCJf95tTj0RCdEzw2hBSCndMCNvSyaMUagOXmUlTUfhjOJv1jp+NNQfFO132wNFZ6C0nQihe7DVJfd/wasVVUPq0wZoCRJ2C/U9cBUDiA1Vp9OBWfZnQx3gxOLzFQb5CEsLsRIU+85/g79+dOblXAi7KCTDZTTzKK5nf0guDzNP1+4Ron/9tEB1+j6RHer23RTtwGCjbwsjjscCpa7NOHvttGkVr6ygaVKYjtAS90gsHp+JPKi996W2ABIgS7TLx57BKt19J69xut80sfLeGlPF7cOijLq8ktzh81z5JBrLogrjpCdk28YWr5Sm+PEr1Xe6snmsp35hjUhDof7aDyAQ==
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 13:43:35.8176
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3069ef36-15ea-4335-f42b-08d7bf78df38
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3984
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 12:37:16PM +0100, Daniel Vetter wrote:
> On Tue, Mar 3, 2020 at 11:53 AM Brian Starkey <brian.starkey@arm.com> wrote:
> >
> > Hi,
> >
> > On Tue, Mar 03, 2020 at 12:10:29PM +0200, Pekka Paalanen wrote:
> > > On Fri, 21 Feb 2020 10:08:42 +0100
> > > Neil Armstrong <narmstrong@baylibre.com> wrote:
> > >
> > > > Amlogic uses a proprietary lossless image compression protocol and format
> > > > for their hardware video codec accelerators, either video decoders or
> > > > video input encoders.
> > > >
> > > > It considerably reduces memory bandwidth while writing and reading
> > > > frames in memory.
> > > >
> > > > The underlying storage is considered to be 3 components, 8bit or 10-bit
> > > > per component, YCbCr 420, single plane :
> > > > - DRM_FORMAT_YUV420_8BIT
> > > > - DRM_FORMAT_YUV420_10BIT
> > > >
> > > > This modifier will be notably added to DMA-BUF frames imported from the V4L2
> > > > Amlogic VDEC decoder.
> > > >
> > > > At least two options are supported :
> > > > - Scatter mode: the buffer is filled with a IOMMU scatter table referring
> > > >   to the encoder current memory layout. This mode if more efficient in terms
> > > >   of memory allocation but frames are not dumpable and only valid during until
> > > >   the buffer is freed and back in control of the encoder
> > > > - Memory saving: when the pixel bpp is 8b, the size of the superblock can
> > > >   be reduced, thus saving memory.
> > > >
> > > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> > > > ---
> > > >  include/uapi/drm/drm_fourcc.h | 56 +++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 56 insertions(+)
> > > >
> > > > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > > > index 8bc0b31597d8..8a6e87bacadb 100644
> > > > --- a/include/uapi/drm/drm_fourcc.h
> > > > +++ b/include/uapi/drm/drm_fourcc.h
> > > > @@ -309,6 +309,7 @@ extern "C" {
> > > >  #define DRM_FORMAT_MOD_VENDOR_BROADCOM 0x07
> > > >  #define DRM_FORMAT_MOD_VENDOR_ARM     0x08
> > > >  #define DRM_FORMAT_MOD_VENDOR_ALLWINNER 0x09
> > > > +#define DRM_FORMAT_MOD_VENDOR_AMLOGIC 0x0a
> > > >
> > > >  /* add more to the end as needed */
> > > >
> > > > @@ -804,6 +805,61 @@ extern "C" {
> > > >   */
> > > >  #define DRM_FORMAT_MOD_ALLWINNER_TILED fourcc_mod_code(ALLWINNER, 1)
> > > >
> > > > +/*
> > > > + * Amlogic Video Framebuffer Compression modifiers
> > > > + *
> > > > + * Amlogic uses a proprietary lossless image compression protocol and format
> > > > + * for their hardware video codec accelerators, either video decoders or
> > > > + * video input encoders.
> > > > + *
> > > > + * It considerably reduces memory bandwidth while writing and reading
> > > > + * frames in memory.
> > > > + * Implementation details may be platform and SoC specific, and shared
> > > > + * between the producer and the decoder on the same platform.
> > >
> > > Hi,
> > >
> > > after a lengthy IRC discussion on #dri-devel, this "may be platform and
> > > SoC specific" is a problem.
> > >
> > > It can be an issue in two ways:
> > >
> > > - If something in the data acts like a sub-modifier, then advertising
> > >   support for one modifier does not really tell if the data layout is
> > >   supported or not.
> > >
> > > - If you need to know the platform and/or SoC to be able to interpret
> > >   the data, it means the modifier is ill-defined and cannot be used in
> > >   inter-machine communication (e.g. Pipewire).
> > >
> >
> > Playing devil's advocate, the comment sounds similar to
> > I915_FORMAT_MOD_{X,Y}_TILED:
> >
> >  * This format is highly platforms specific and not useful for cross-driver
> >  * sharing. It exists since on a given platform it does uniquely identify the
> >  * layout in a simple way for i915-specific userspace.
> 
> Yeah which we regret now. We need to now roll out a new set of
> modifiers for at least some of the differences in these on the
> modern-ish chips (the old crap is pretty much lost cause anyway).
> 
> This was kinda a nasty hack to smooth things over since we have epic
> amounts of userspace, but it's really not a great idea (and no one
> else really has epic amounts of existing userspace that uses tiling
> flags everywhere, this is all new code).
> -Daniel
> 
> > Isn't the statement that this for sharing between producer and decoder
> > _on the same platform_ a similar clause with the same effect?
> >
> > What advantage is there to exposing the gory details? For Arm AFBC
> > it's necessary because IP on the SoC can be (likely to be) from
> > different vendors with different capabilities.
> >
> > If this is only for talking between Amlogic IP on the same SoC, and
> > those devices support all the same "flavours", I don't see what is
> > gained by making userspace care about internals.
> 
> The trouble is if you mix&match IP cores, and one of them supports
> flavours A, B, C and the other C, D, E. But all you have is a single
> magic modifier for "whatever the flavour is that soc prefers". So
> someone gets to stuff this in DT.
> 

Yes, if incompatible support levels are possible, then they must be
described, no disagreement there. That's why AFBC is so explicit.

> Also eventually, maybe, perhaps ARM does grow up into the
> client/server space with add-on pcie graphics, and at least for client
> you very often end up with integrated + add-in pcie gpu. At that point
> you really can't have magic per-soc modifiers anymore.
> 

I don't entirely agree. This is only relevant for modifiers which
might be used between the PCIe GPU and the SoC (in your example).
Per-SoC modifiers still work, they just lose meaning at the SoC
boundary.

Looking at the description of DRM_FORMAT_MOD_AMLOGIC_FBC_SCATTER in
particular, it sounds like that would never be shareable even if it
had a more "complete" modifier.

> If people get confused I'm happy to add a "WARNING: This was a dumb
> idea for backwards compat with legacy code, no one with new stuff ever
> repeat it" to the i915 modifers.
> -Daniel

I think marking it as non-preferred (and why) would be a good idea, so
as not to use it as an example.

Cheers,
-Brian

> 
> >
> > Thanks,
> > -Brian
> >
> > > Neil mentioned the data contains a "header" that further specifies
> > > things, but there is no specification about the header itself.
> > > Therefore I don't think we can even know if the header contains
> > > something that acts like a sub-modifier or not.
> > >
> > > All this sounds like the modifier definitions here are not enough to
> > > fully interpret the data. At the very least I would expect a reference
> > > to a document explaining the "header", or even better, a kernel ReST
> > > doc.
> > >
> > > I wonder if this is at all suitable as a DRM format modifier as is. I
> > > have been assuming that a modifier together with all the usual FB
> > > parameters should be enough to interpret the stored data, but in this
> > > case I have doubt it actually is.
> > >
> > > I have no problem with proprietary data layouts as long as they are
> > > fully specified.
> > >
> > > I do feel like I would not be able to write a software decoder for this
> > > set of modifiers given the details below.
> > >
> > >
> > > Thanks,
> > > pq
> > >
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
