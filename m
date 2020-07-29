Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2591CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:19:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBDF62070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QkPqHk7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgG2OTg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:19:36 -0400
Received: from mail-eopbgr40050.outbound.protection.outlook.com ([40.107.4.50]:14422
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726449AbgG2OTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:19:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nqDDinJX/h7SlFPB01b/HegH8R5CTxUNZP3acIZF+gabJVCeRdk2XhZR7G54HUuxQ6WBDAFQNmY7a8oIK0BdA/0ULnYsWeuKvG5PGKVTM+A8nXaam8RFfhzL75z5X/yNQu/VYVv2PZQ2Z1xGDdgccIii8GMjEVy4l5166XaM3HeZIe6wWZrYwq5A/l9xHa7/BNgsnX4PYdp4rQHW6UOltolEafnb02S/l1Az4EN6LHsW6z2SuMJBUFtxRTZurBjdEeorrIZlhLWZtlTHIeOHnnjgV8wMBi0MAwF1v7evxD8Ijrvdjh4yBXCqXXFLdLkyB/5TnmCkotzBNxdlWN7vyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4qO9gihBSn2NbH+cf1yaCHaJ1vxPLw90gR+deLqPvs=;
 b=QSZZinUbO1EL/tYTNIB1i39Xk5TJjf4LPL42NHruKKTg+/3fynmYtlWKfJP/6Ypsnh+9HuL5vEeLVgKzbWqDbK9TKVBWd0uc1he/rIO7+peBxFDqVZDLpxP95uplethfIADqMuh5MfV0IuR+DzHLBe+47j8x0wnNVLW4Wck7YIlUbwD1Rq5+bop+p5l2xrlyx37axmP5f5OQwUvMkI8ToYgnjsk08leJTiTTZ2zHTm6Gc4aSBI1TMjS9As6ZNyN4FXyi17ArRCpTczdP8l2Yzf9y0Rm0sL9WqmeMbhE6wSVCpiz3XlXOW4CTGM9tUmsQ4XVxSYKJhymtj/QUDxfM+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4qO9gihBSn2NbH+cf1yaCHaJ1vxPLw90gR+deLqPvs=;
 b=QkPqHk7bryZxq6uDeT6Jqct+XBFFE+nx86GzcIqAPPxBMQa2JCD7tY0mskw3Ul09b6SZjHfj5uP4qgT5Nr2fKoFKkOMMZOTYGtF5Ezu2DQGv1gwEUPGrOfACxicEKe7WeKqjNhEYaISLuntArAa69B/eTcysd5sb3akSXym3jXo=
Authentication-Results: sigxcpu.org; dkim=none (message not signed)
 header.d=none;sigxcpu.org; dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27) by VI1PR0401MB2557.eurprd04.prod.outlook.com
 (2603:10a6:800:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20; Wed, 29 Jul
 2020 14:19:30 +0000
Received: from VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8]) by VI1PR0402MB3902.eurprd04.prod.outlook.com
 ([fe80::5c87:6dce:840d:d4c8%7]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 14:19:30 +0000
Date:   Wed, 29 Jul 2020 17:19:26 +0300
From:   Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
To:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, lukas@mntmn.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Laurentiu Palcu <laurentiu.palcu@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v8 5/5] dt-bindings: display: imx: add bindings for DCSS
Message-ID: <20200729141926.hrky2e4hggf5renn@fsr-ub1864-141>
References: <20200724090736.12228-1-laurentiu.palcu@oss.nxp.com>
 <20200724090736.12228-6-laurentiu.palcu@oss.nxp.com>
 <20200729132730.GA266947@bogon.m.sigxcpu.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729132730.GA266947@bogon.m.sigxcpu.org>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: AM3PR03CA0065.eurprd03.prod.outlook.com
 (2603:10a6:207:5::23) To VI1PR0402MB3902.eurprd04.prod.outlook.com
 (2603:10a6:803:22::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141 (83.217.231.2) by AM3PR03CA0065.eurprd03.prod.outlook.com (2603:10a6:207:5::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Wed, 29 Jul 2020 14:19:28 +0000
X-Originating-IP: [83.217.231.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d6a614b-fd8b-4866-6639-08d833ca6851
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2557:
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2557E61712235B49AA229E77BE700@VI1PR0401MB2557.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y0+sRzNl8ttHC7ge1KtzeQ3VDbdmfir5XLo/6UtxdKoUUQ4QfIOpNuvjYDRjGF3pUaP9KwnMEj7CGINo5T4XDEl1LFkhXpWzosvoBm0+mp+ALnJwIr9YG4puvxd5LD7dP6eU5eJzK8FvUrqa+I4sBeF3IdM6/8RwtUsU38cu0vBinFcrbs3ZX6Od0b7y5yy7fQbC0NqmE3nAb6py8OEo53L2K7iIj05YV9uCmh+nDHJHs+9d3lyWYMEei50ZYqI8CG52ii98j5Bnv2xm6YhCW0QMg3LHQku0kHPl+vNJshAtrXkl6Ix1/SmN3hbcdEHSSHLlgfu1D/0Shdmby4yO6ZyKu2RNlM2h18P9jsLDSTsmp2Ldupo9rqwdSQ89EnJ2j0oxHkIv/eQ3AMuwK/mjpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3902.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(83380400001)(1076003)(4326008)(6496006)(52116002)(8676002)(5660300002)(33716001)(7416002)(44832011)(66574015)(86362001)(478600001)(6916009)(2906002)(55016002)(66946007)(66556008)(9686003)(66476007)(8936002)(186003)(16526019)(316002)(26005)(956004)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: DAXKPeJbX8+w1Ny2O4CYsKRoWS2aQmD+1uMRLAmdHZFL2huycnwJXw+n14MZPcUYDqo96j+Ozz1Fw88yRKwWQwg31Yo0l7w7cet/DJooG+CO+VjguM2FDDWrBF1zFhazVVQRq+BA1fe5VGG+lbtVFGn84JSxnxFAu4EwAQ4wexpf3LRP9dnUBa1Y9RlgT4rQOP4UaLxhSPpSjEu+ZKFIGrMnPJtKktaOW/CTF4or+Wk32IRJ7HrWEp8YP+tDRbu/u9T3+RZyEB3QHNdmgDP59p5LA6sm9TD0AtGpcMIHzjOpGTJq/vDEoMI/T31VvUuw+40OUsFedJfCoJEY4tjMqNrBPfWVFXfzRlPb41mJMptQmzd+TzozZI8gpdEb9YLWAOkbwECXcOfHEmlZMNAcdyhoWIUepGk9eCTywkUqsfHG6qxH9hAVRZhl8ig0oKsz4q8YnR/ekO+GAcCQdy1Ku4FDyf96pny7h4U7ZdMQhrM=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6a614b-fd8b-4866-6639-08d833ca6851
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3902.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2020 14:19:30.1109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwBcqZ7ShM20RSPYDY/0oQIsAYy1pfO0kOPbpWNfnj9iFobXDWyMjY4/0tVufeCf3f6qDHuccVX1/1yfCxdzHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2557
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 03:27:30PM +0200, Guido Günther wrote:
> Hi,
> On Fri, Jul 24, 2020 at 12:07:34PM +0300, Laurentiu Palcu wrote:
> > From: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > 
> > Add bindings for iMX8MQ Display Controller Subsystem.
> > 
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../bindings/display/imx/nxp,imx8mq-dcss.yaml | 104 ++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> > new file mode 100644
> > index 000000000000..68e4635e4874
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/imx/nxp,imx8mq-dcss.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 NXP
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/display/imx/nxp,imx8mq-dcss.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: iMX8MQ Display Controller Subsystem (DCSS)
> > +
> > +maintainers:
> > +  - Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > +
> > +description:
> > +
> > +  The DCSS (display controller sub system) is used to source up to three
> > +  display buffers, compose them, and drive a display using HDMI 2.0a(with HDCP
> > +  2.2) or MIPI-DSI. The DCSS is intended to support up to 4kp60 displays. HDR10
> > +  image processing capabilities are included to provide a solution capable of
> > +  driving next generation high dynamic range displays.
> > +
> > +properties:
> > +  compatible:
> > +    const: nxp,imx8mq-dcss
> > +
> > +  reg:
> > +    items:
> > +      - description: DCSS base address and size, up to IRQ steer start
> > +      - description: DCSS BLKCTL base address and size
> > +
> > +  interrupts:
> > +    items:
> > +      - description: Context loader completion and error interrupt
> > +      - description: DTG interrupt used to signal context loader trigger time
> > +      - description: DTG interrupt for Vblank
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: ctxld
> > +      - const: ctxld_kick
> > +      - const: vblank
> > +
> > +  clocks:
> > +    items:
> > +      - description: Display APB clock for all peripheral PIO access interfaces
> > +      - description: Display AXI clock needed by DPR, Scaler, RTRAM_CTRL
> > +      - description: RTRAM clock
> > +      - description: Pixel clock, can be driven either by HDMI phy clock or MIPI
> > +      - description: DTRC clock, needed by video decompressor
> > +
> > +  clock-names:
> > +    items:
> > +      - const: apb
> > +      - const: axi
> > +      - const: rtrm
> > +      - const: pix
> > +      - const: dtrc
> > +
> > +  assigned-clocks:
> > +    items:
> > +      - description: Phandle and clock specifier of IMX8MQ_CLK_DISP_AXI_ROOT
> > +      - description: Phandle and clock specifier of IMX8MQ_CLK_DISP_RTRM
> > +      - description: Phandle and clock specifier of either IMX8MQ_VIDEO2_PLL1_REF_SEL or
> > +                     IMX8MQ_VIDEO_PLL1_REF_SEL
> > +
> > +  assigned-clock-parents:
> > +    items:
> > +      - description: Phandle and clock specifier of IMX8MQ_SYS1_PLL_800M
> > +      - description: Phandle and clock specifier of IMX8MQ_SYS1_PLL_800M
> > +      - description: Phandle and clock specifier of IMX8MQ_CLK_27M
> > +
> > +  assigned-clock-rates:
> > +    items:
> > +      - description: Must be 800 MHz
> > +      - description: Must be 400 MHz
> > +
> > +  port:
> > +    type: object
> > +    description:
> > +      A port node pointing to the input port of a HDMI/DP or MIPI display bridge.
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> 
> it would be nice to
> 
>     #include <dt-bindings/clock/imx8mq-clock.h>
> 
> here...
> 
> > +    dcss: display-controller@32e00000 {
> > +        compatible = "nxp,imx8mq-dcss";
> > +        reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> > +        interrupts = <6>, <8>, <9>;
> > +        interrupt-names = "ctxld", "ctxld_kick", "vblank";
> > +        interrupt-parent = <&irqsteer>;
> > +        clocks = <&clk 248>, <&clk 247>, <&clk 249>,
> > +                 <&clk 254>,<&clk 122>;
> > +        clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> > +        assigned-clocks = <&clk 107>, <&clk 109>, <&clk 266>;
> > +        assigned-clock-parents = <&clk 78>, <&clk 78>, <&clk 3>;
> 
> so that clock names like IMX8MQ_CLK_DISP_AXI could be used to make this
> even more useful.

That's a good idea. I'll add it in.

Thanks,
laurentiu

> 
> Cheers,
>  -- Guido
> 
> > +        assigned-clock-rates = <800000000>,
> > +                               <400000000>;
> > +        port {
> > +            dcss_out: endpoint {
> > +                remote-endpoint = <&hdmi_in>;
> > +            };
> > +        };
> > +    };
> > +
> > -- 
> > 2.23.0
> > 
