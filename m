Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368FAC83002
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130092083B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 06:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="bljCGMcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD3GDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 02:03:54 -0400
Received: from mail-bn8nam12on2112.outbound.protection.outlook.com ([40.107.237.112]:35680
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726180AbgD3GDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 02:03:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NlQ1FsasO5NAQ8isxwNJ/fmqA8tn9yHOJFDb0EfoM2+FW6flzhHKSFpTmws6CFEHR2Bco6wpLiGI5mU1AcN4QWNTlvIw/PfMjpFJkG+T4XUDfsvMeSN04BCDrWrjCHmRCxkynT2BxheYcJySY3ciHCKRy2YRDdDdtXOO0AdwLlT0lwuiygx6XqlqRffMnwF5BdRQZHDT6LuFDE8Yp5LWuCzHz/ylnlWPTnJqDCvuTLiBaBfAjMRy3Qv7faAnVnKV+6U/nc2zRWKI4UsoPpElwOk8PnF5P0NPKO8mTZ6Ijt5y7V4iULNB/s+XZ4bA3o659G6JMv1ZSB8ZI91tccvNCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uohrh0CjH+PxjlSbQ/Oqh7xunRauHtqi2M412VSbx/U=;
 b=XKbIPr3PnGgUXB9PHpDAz0h9XrUoBHoh3kjGNhIMUH2aSZzsNyc9G9ANPjCdPUstwy23XE26VZsz+RQoQeqss8Wc7V+ZE5UnOYg8eTKGhC4DAuQERc1D+9OSxJP3wnoXoGKT7FtUNDVPtxkr8vR40xRdz0VsQwmeXwwc42fvd/hfnSj2skNUPVIsZ8FV7VtclLiW6zyue4qdJkl+U20AFrGUNzjqaX6ktUiqtYnLydkrQsmmjoq12QtsJPhH77Nw2olZFFLXZ3hmRoqG3/bMR++OKwkk/icYxWMw+whwSTs2nR+OdUNJZfsPP0wUbdmL/iZrLYr10svso6uddmxKzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uohrh0CjH+PxjlSbQ/Oqh7xunRauHtqi2M412VSbx/U=;
 b=bljCGMcBE14Uuc4/Z2KszPUsj+uawPn35OW9coWQTZjusj06JcTzfV0svQqtFSC6A5pW4sDwdzUZsUqkOvf609k9DLz9OKDyPfPK3cECfyD7e4WI81HUKO8X6VRXQjxRf5gfGtqqWbrXepmNbk2QVjkBteXdtyJgN0CHMkVdzTs=
Authentication-Results: analogixsemi.com; dkim=none (message not signed)
 header.d=none;analogixsemi.com; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6996.namprd04.prod.outlook.com (2603:10b6:a03:224::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Thu, 30 Apr
 2020 06:03:50 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 06:03:50 +0000
Date:   Thu, 30 Apr 2020 14:03:43 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>
Subject: Re: [PATCH v8 0/2] Add initial support for slimport anx7625
Message-ID: <20200430060343.GC6645@xin-VirtualBox>
References: <cover.1587880280.git.xji@analogixsemi.com>
 <20200427185320.GB15880@ravnborg.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427185320.GB15880@ravnborg.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK2PR02CA0202.apcprd02.prod.outlook.com
 (2603:1096:201:20::14) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xin-VirtualBox (114.247.245.254) by HK2PR02CA0202.apcprd02.prod.outlook.com (2603:1096:201:20::14) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.2958.20 via Frontend Transport; Thu, 30 Apr 2020 06:03:49 +0000
X-Originating-IP: [114.247.245.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 496d46fe-fba9-48cf-10c9-08d7eccc40d0
X-MS-TrafficTypeDiagnostic: BY5PR04MB6996:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR04MB69963462BBDD27DC9173D124C7AA0@BY5PR04MB6996.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0389EDA07F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5hpjp1ZaoQqQbMrPcjxt1+tzwYf9uG5YiIzeZbKPW2uSs0ZFP6/RWRioXvuwT89gVxMKVUGyeY+lqMaofug1raPXWJpL1Kf07mnWLmH2RzgV3LZFHwxoJ4VD3ubLFI/I+cyyq4ZpBm7o8uJSdc26EJRkIg12Nl7fJKC6Zr8/Q6kTFDYvtLHm19bVtUw3QHEq8PrXPBTqmCLCmxknIbKdd+gTBogfsfMZH1qcNThNS+VAFqMbfwjxBpxiutpYXiVoI9SBd7RBMicyrPxo+Lqy6EVd1Sy4t5TPdtZu5E2rNkoIWETpqkv8Nj+ZmNqdfoq5os36ck5XKBI1Ft50lg7eVcVfU+qeWbmMIqEdPmzvxgOZYH+NRMXKKwJViC2UkDxsrrilg7q+sSNdfkNRiOofaVIcNe3mnMKqSv4n/BkntzgVg05v/0KZ2lbMLbKExPpjfec5OyoEn2D8gRIU55ka47XdnsWLpCn+9x721Dk2p4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(366004)(346002)(39840400004)(396003)(376002)(1076003)(66556008)(4326008)(66476007)(186003)(66946007)(55016002)(7416002)(16526019)(26005)(956004)(966005)(9686003)(2906002)(6666004)(54906003)(6916009)(8936002)(6496006)(86362001)(33656002)(8676002)(107886003)(33716001)(478600001)(5660300002)(52116002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: xOVpexEdDubAj/BJbGeO+xnxwC/dNU2XK8XmIizrYUxvhJIQ3aUtQ0WHRuhnBaZaJ32UTxm6V5hn3v5bleOow6sGOpIiZ2kHUepTSkoYnM16vVSIrgDjF82hfgucb9B44eW82bUq0TsVK1721athBi2GewGsCby73kW5pFS71NGI7Gn8ufPs8n+Vo0+AITmMyhgFJX1TEQ6TPjCXZ+RMZqjqvD9mxPP9nz4l/KFWn6tXW21KP1IySc5Ckn35tNil5AjeA3G23nmwSt+5KPsNVsjdlhrWFCiudpBTxykq3uL2G2Qz8l8V+2dYbP2aISEBoWkJ6qVWnNLp6KR/2PCJqKfRC0xanWEXHAGHVHdleW5FmHngzU0ljT9cPoMFE0DpXaxxS/2AdPsbYbIV+wWMD+Ecx03kN2+p/CxeFG2L5j5vL4CsvfvSLxaZ8KSnpP/RvHY4eDgeU+SavN1WHEiYKeMA3TjetPChtoUD7lfeFCRkVxcgDu+OyIQ3RLP+97SrbDcaCGPhgos5Sd9w667Wr9DjyNRUqQapZR8s+ml7O+F37py8iUkUpk8k4ltthP8IauBi/kPEM2bqLkWE2S4AxO/wnBpiqJzknBYjNcC8vGVA1VxjsIZ2RgP4I3c9aYomq+N/meqgCzG8dswZr1Lv0mW3dkwwRehv/LUh6c5cElZ61KxyDEFcbblK3PdxCYkAlI0Ep7YptBH0GWnH1OZ7MWf5Mv5SXM/JtwlH/hLiQlan9y0jZnk6yeLZMHjRSUmx/GCsuOyhdaBzRe2VSMFSUuY/zyX9PubS7KVlKOBO1WublMnLINGkqqTLnHyT7aCa
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496d46fe-fba9-48cf-10c9-08d7eccc40d0
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 06:03:50.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gK9kXBGUbsLIPkNAWabaRYBkF2L1ChleU2dQRPRQizoqzQqHjxVnoMiZYeMq+TnPSyjr8NWWMHtcQ20CaOQtHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6996
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Mon, Apr 27, 2020 at 08:53:20PM +0200, Sam Ravnborg wrote:
> Hi Xin Ji
> 
> On Mon, Apr 27, 2020 at 02:16:49PM +0800, Xin Ji wrote:
> > Hi all,
> > 
> > The following series add support for the Slimport ANX7625 transmitter, a
> > ultra-low power Full-HD 4K MIPI to DP transmitter designed for portable device.
> > 
> > This is the v8 version, any mistakes, please let me know, I will fix it in
> > the next series. This series fix several coding format and description.
> 
> 
> It would be great if you can add a summary of changes like this:
> 
> v8:
>   - fix several coding format
>   - update description
> 
> v7:
>   - Bla bla
> 
> I see no reason to dig out the old changelog, but start from now on.
> The cover letter (this mail) should give a general intro to the changes.
> The individual patches the detailed changelog.
> For each entry is is also a good practice to tell who gave the feedback
> that triggered the changes.
> 
> There are many ways to handle this, take a look at a few submissions 
> to dri-devel to be inspired.
> 
> 	Sam
OK.
> 
> > 
> > Thanks,
> > Xin
> > 
> > 
> > 
> > Xin Ji (2):
> >   dt-bindings: drm/bridge: anx7625: MIPI to DP transmitter binding
> >   drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to DP bridge driver
> > 
> >  .../bindings/display/bridge/anx7625.yaml           |   91 +
> >  drivers/gpu/drm/bridge/Makefile                    |    2 +-
> >  drivers/gpu/drm/bridge/analogix/Kconfig            |    6 +
> >  drivers/gpu/drm/bridge/analogix/Makefile           |    1 +
> >  drivers/gpu/drm/bridge/analogix/anx7625.c          | 2158 ++++++++++++++++++++
> >  drivers/gpu/drm/bridge/analogix/anx7625.h          |  410 ++++
> >  6 files changed, 2667 insertions(+), 1 deletion(-)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7625.yaml
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.c
> >  create mode 100644 drivers/gpu/drm/bridge/analogix/anx7625.h
> > 
> > -- 
> > 2.7.4
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
