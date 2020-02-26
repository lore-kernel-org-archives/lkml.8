Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04E6C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C85D21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jp2sNT/f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbgBZICe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:02:34 -0500
Received: from mail-am6eur05on2081.outbound.protection.outlook.com ([40.107.22.81]:47041
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727223AbgBZICe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:02:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDRXPdF9ivvZIykRU1NrqGGaIzxu133lDuIbRdaJLJU/qICnlnqK7GlExWcuoiuRO8pii4Ue/kHFKlyOQX5pk+ugUXZimey6GBGWqISqRH4vAmCiXEWI3K1cqwEPIkRf7SxnUo/TJ/+zSfC1slVDlziUBIVwHXFVrHs//sY0xA/7E61PqurtOlMJ/JJx09rlC67GsarftVmx4pILNZ0xWWH/Gp3ZXmHHIsU4cEo08SEr8eWQZu5Z8YREoy+hBluE+agmO7AEHvPd0+qltjLkTIr79D5S+AyaQZ8Ke3NGLKHmZPDeB7klEmYOkIa5nq+0+6HMYRtGYWxlAod9OWxmcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubw8Gbl6XvHXPC/De3ehZs4cLA7iprv6PcCy5XOA4qM=;
 b=EuTUUf8MSw6OR1gDU88R0frdWlypGwOAXYg9QgH14eqA+14tatPrgdLkLGP0sLVAODF9TqVCddYomu/LgSGnBK+Fs4cEyCAsp2vBc7Ow1rSQwpDNnWNjIHgHUzRTE+T5U/m5CHeKdrNMMZhPrdeWb28sfgiaN9Z+g2qakc46MfCwSSHiSDDVtpHsnqJfet0sN0cGFL5/T4lUiiPsmuPbr/wcw8veJjuvtZE/T0iCEzymwuMAH8FcGUrWtZbZWyDspqVze2eu7Tn1fVIsDtBCMjxZ+0Yf4PjqZ6LGS2PAItSxNBR1c+LnhBkBLwbD/LCNE+12aAYT5QMQZxaYm3+fZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ubw8Gbl6XvHXPC/De3ehZs4cLA7iprv6PcCy5XOA4qM=;
 b=Jp2sNT/fB8fwl17Zzm834zl277h8BK46X28oq78liM2k1Gs+KwRSB7E0zqIojo/um2XtSaIAP8BSPcmJeJVPEkFMmI/T8O02uPAbncL47UhddHg4FQNAskBvCnYU+9gCX/6ievqkMvppKqGyVLAjKV0wf0e1d7FC9sx7NMWyMXc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.palcu@nxp.com; 
Received: from AM6PR04MB5766.eurprd04.prod.outlook.com (20.179.2.143) by
 AM6PR04MB5510.eurprd04.prod.outlook.com (20.178.86.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Wed, 26 Feb 2020 08:02:29 +0000
Received: from AM6PR04MB5766.eurprd04.prod.outlook.com
 ([fe80::4c26:a809:e360:5864]) by AM6PR04MB5766.eurprd04.prod.outlook.com
 ([fe80::4c26:a809:e360:5864%3]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 08:02:29 +0000
Date:   Wed, 26 Feb 2020 10:02:26 +0200
From:   Laurentiu Palcu <laurentiu.palcu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, agx@sigxcpu.org,
        lukas@mntmn.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH v3 4/4] arm64: dts: imx8mq: add DCSS node
Message-ID: <20200226080226.xppukafx7453xm2d@fsr-ub1864-141>
References: <1575625964-27102-1-git-send-email-laurentiu.palcu@nxp.com>
 <1575625964-27102-5-git-send-email-laurentiu.palcu@nxp.com>
 <5d0f20b76e31360372a410983b013551062e9a91.camel@pengutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d0f20b76e31360372a410983b013551062e9a91.camel@pengutronix.de>
User-Agent: NeoMutt/20171215
X-ClientProxiedBy: LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a5::34) To AM6PR04MB5766.eurprd04.prod.outlook.com
 (2603:10a6:20b:ab::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fsr-ub1864-141 (89.37.124.34) by LO2P265CA0310.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:a5::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 26 Feb 2020 08:02:28 +0000
X-Originating-IP: [89.37.124.34]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: f663fe35-a783-48f3-a5ff-08d7ba9239e9
X-MS-TrafficTypeDiagnostic: AM6PR04MB5510:|AM6PR04MB5510:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5510FB5ECB81ACA5DC86653EFFEA0@AM6PR04MB5510.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(376002)(366004)(396003)(346002)(189003)(199004)(7416002)(1076003)(33716001)(8936002)(5660300002)(81156014)(316002)(81166006)(2906002)(478600001)(4326008)(54906003)(8676002)(44832011)(66946007)(66556008)(956004)(55016002)(86362001)(186003)(26005)(9686003)(6916009)(6496006)(52116002)(66476007)(16526019)(32563001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB5510;H:AM6PR04MB5766.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+SwYr+swCDsHI3G6FgqooKf4A+dtz4TFZ8C8mIp0ZYGcS7tsHt6BqiX4/gZOMjFW82Kk9kPvvDzUL+Lt1xxP8r0aIJ5hcqrH9fr2FjB6UlkZ+tryGrx60vhOyvK4vkLXjXguTSrHuZqIgS3i1x0/Tn98qyQY0u9mj2Dt6T/yMLMD8ZjSqY6kjLIExv70B3XKU8VvnNNzHvLc76arSMYTiVs4O78s93+5Hx31uDZwz8+gPNMe+kiE1GwFWF9SfVBaNzWG7VAniCl1SbFRyFuoxUCyronPe3eJ0MpLUxs16EYuJuKIBqGj8FUZj+7RsiPaOPETYTcCgJlciQf6SQ5AUCjsAUGQc8rsC7qbMoDUUjxjJzOAhggQtmqsAzlHqCwwRXp45JmTiH+H5MvwjnVsiHj2wNNWVcB4zJB0GlH2eXUxRxd8f3XKXmOwyYcc+00p6HwajstRR9/Z+pEAyZmef0rx45LNfujI1G+LZL0eOE=
X-MS-Exchange-AntiSpam-MessageData: eSTfkwJ7bTImUH3LlamRv+EsHsG1S0bPMqFP4Y0MvQ2GcBEDCrvxZHHjFd6O4ei+N2SFiRouAxxeG+pSsJN7dDFXtp4loiOtZut31CTuL/vfu1t1gnI2yPN1H2eBldYQ/PmfIGUG8JwbF0SUjVEx0w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f663fe35-a783-48f3-a5ff-08d7ba9239e9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 08:02:29.8068
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0PG4r0mktqvD+9xQ9MQ7w2iuJeKllXFBJ0pdYXwvsxhmFFPDyrXHp6Sl5iN3CFcuP+MIT+0yqzNEOpZzejJhew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5510
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lucas,

On Mon, Feb 24, 2020 at 06:23:51PM +0100, Lucas Stach wrote:
> On Fr, 2019-12-06 at 11:52 +0200, Laurentiu Palcu wrote:
> > This patch adds the node for iMX8MQ Display Controller Subsystem.
> >
> > Signed-off-by: Laurentiu Palcu <laurentiu.palcu@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8mq.dtsi | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > index f6e840c..da7e485 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
> > @@ -981,6 +981,31 @@
> >                               interrupt-controller;
> >                               #interrupt-cells = <1>;
> >                       };
> > +
> > +                     dcss: display-controller@32e00000 {
> 
> Node address is lower than the irqsteer node, so the dcss node should
> be added before, not after the irqsteer node in the DT.

That's correct, I'll move it.


> 
> > +                             #address-cells = <1>;
> > +                             #size-cells = <0>;
> > +                             compatible = "nxp,imx8mq-dcss";
> > +                             reg = <0x32e00000 0x2d000>, <0x32e2f000 0x1000>;
> > +                             interrupts = <6>, <8>, <9>;
> > +                             interrupt-names = "ctx_ld", "ctxld_kick", "vblank";
> > +                             interrupt-parent = <&irqsteer>;
> > +                             clocks = <&clk IMX8MQ_CLK_DISP_APB_ROOT>,
> > +                                      <&clk IMX8MQ_CLK_DISP_AXI_ROOT>,
> > +                                      <&clk IMX8MQ_CLK_DISP_RTRM_ROOT>,
> > +                                      <&clk IMX8MQ_VIDEO2_PLL_OUT>,
> > +                                      <&clk IMX8MQ_CLK_DISP_DTRC>;
> > +                             clock-names = "apb", "axi", "rtrm", "pix", "dtrc";
> > +                             assigned-clocks = <&clk IMX8MQ_CLK_DISP_AXI>,
> > +                                               <&clk IMX8MQ_CLK_DISP_RTRM>,
> > +                                               <&clk IMX8MQ_VIDEO2_PLL1_REF_SEL>;
> > +                             assigned-clock-parents = <&clk IMX8MQ_SYS1_PLL_800M>,
> > +                                                      <&clk IMX8MQ_SYS1_PLL_800M>,
> > +                                                      <&clk IMX8MQ_CLK_27M>;
> > +                             assigned-clock-rates = <800000000>,
> > +                                                        <400000000>;
> 
> Second line is not aligned to the first one.

ack

Thanks,
laurentiu

> 
> > +                             status = "disabled";
> > +                     };
> >               };
> >
> >               gpu: gpu@38000000 {
> 

-- 
Laurentiu
NXP
