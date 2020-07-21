Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D55AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6429920B1F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="W9AzDrxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgGUG2K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:28:10 -0400
Received: from mail-dm6nam10on2044.outbound.protection.outlook.com ([40.107.93.44]:11930
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726039AbgGUG2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:28:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3wqckeVk9OreK74Ug3Fub7WLsLZVUciI7c8OYwqtPm4YqS9RCS8MDjhzlv3AtGTYrcWAKeyvHuGGPGNHAx8cOssT8cCWGv7X5JkM4M/XXWknTU9g1rPnU2GPpaVKKSYyeZQ5h6CUylHu8TLGf02UUs+h9b1qAm6gpDdYm+MjoxnLsSgcQjZhkYPYW7hK5GD89ggBCjTPWZWv3edE1GBSQRZed6tfGdmxGcEJCpQcxCExMHjKJNPW1CN8JosuUvYdsmbhnOOZ9ZV5lM+dymWbZgRB6Kz2iSH9NR5KDVaWBDSX3Fn8lBS8YVICf2FAd7u7wxzjuMhRo5Bn2CGTgSLyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcP6ceC56fnJ5gKUuILIwvX3m3wAWQAF/B/pA0RmVbg=;
 b=R8tdYDwn0Xa8JRv4f/T1Sk4ExwD4jUUNwz1yjXwTowHk4QSBzf89chhmFEi820ZR7DfxW66tH61lfHVS2Qy9MmRrNoMGERsMhAPZo6JJGAgn8Q1oHqKKdLFfgcck0SyOjntDmfd2d/BBe8dLvkOG+RjbzlGN37BO0abz9Z6KNMHsGJLbnrAXydqv/N5AqOaIAMWRtlKi3e5m/akpEeHW1VzMYCCjXmku+nQNuZ4p5pq9hW2XwrUomDDYNzHe2SXGjgpfYeHJOj8DMfBT/ODfjBmhq4bE8OiwEEp4HsTtoq8LLb8NXyd0IV4k+5K28Zw+nuSUpFB4/X3hSg77XRQsuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dcP6ceC56fnJ5gKUuILIwvX3m3wAWQAF/B/pA0RmVbg=;
 b=W9AzDrxLMzrcur0/4rJd2I5iNtfOS6NSilO0BkzCt+i0qUvK53zwpeH82SRBWmTY6A3Jt2pdJo4vDCzuLOamsyHDxsP28SsWkBjOO7Kw6fYCTpLsiTxSmn8dtiyasKWH7zdiL0JZZQZrsju8gn1ypTQA9bzH/+SKH3fIWoHMKpw=
Received: from DM6PR02MB5818.namprd02.prod.outlook.com (2603:10b6:5:17c::24)
 by DM6PR02MB5196.namprd02.prod.outlook.com (2603:10b6:5:47::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Tue, 21 Jul
 2020 06:28:05 +0000
Received: from DM6PR02MB5818.namprd02.prod.outlook.com
 ([fe80::fcb8:7630:4fa4:6ba6]) by DM6PR02MB5818.namprd02.prod.outlook.com
 ([fe80::fcb8:7630:4fa4:6ba6%5]) with mapi id 15.20.3174.026; Tue, 21 Jul 2020
 06:28:04 +0000
From:   Sai Krishna Potthuri <lakshmis@xilinx.com>
To:     Rob Herring <robh@kernel.org>
CC:     Philipp Zabel <p.zabel@pengutronix.de>,
        Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>
Subject: RE: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal reset
 driver
Thread-Topic: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal reset
 driver
Thread-Index: AQHWWagTecU6ft9w8EW9Zg+g4N9XWqkRVBwAgABDR8A=
Date:   Tue, 21 Jul 2020 06:28:04 +0000
Message-ID: <DM6PR02MB581821BF5C2F79F909A128C1BD780@DM6PR02MB5818.namprd02.prod.outlook.com>
References: <1594708149-29944-1-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <1594708149-29944-2-git-send-email-lakshmi.sai.krishna.potthuri@xilinx.com>
 <20200721020740.GA3376303@bogus>
In-Reply-To: <20200721020740.GA3376303@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.50.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ea0b2660-7e04-4ee5-2e0e-08d82d3f39d5
x-ms-traffictypediagnostic: DM6PR02MB5196:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR02MB519613251CB9C2EC7D415A88BD780@DM6PR02MB5196.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W6a0tr9EN09Z4Sz1VKYs/Mp4nUuz7puD3tjFzKyAQp6UnErKoas0MALmAjws2yQyqheY3dm1gtMZxoQWUH9fOc0D1g8BXlATWSuzsE/8zRJuR8fCwqm7FFESJ6CtcVcFZytePVBe+vGWzA61BB0UG+CftM/r+733AKyLW7ZEu7HRhM0vCplyAa8kczezGrPlOyeUKSUKeeUK8Edo+VyZHyiYaR2cntMLMOUp9pX2WyCK57wMo7jGEhvza0ZrzVFYMb+U/PhShg0pcO1VP0+TOSrxRpYG3+r9IwO6pj3loGnkdnyLAlXRTlJM4WkyxrEUwclGfdgmbM2dCUm50A8aKQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB5818.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(86362001)(8936002)(52536014)(2906002)(186003)(6506007)(7696005)(53546011)(5660300002)(478600001)(8676002)(26005)(15650500001)(6916009)(83380400001)(316002)(9686003)(55016002)(54906003)(76116006)(71200400001)(33656002)(66946007)(64756008)(4326008)(66556008)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6QuEgGY6KHgji3BY0sR3gI5Zdkw7WARstOnvnehjZVKKkTnArtV1ANhLDhJi0T+1DX4uWs1KmtG4LqXKpf7enGeo/FnBAB7ynhuSuwOcKFb8OSRsXnMX01kLwPcVK+HpgxDea5nSwdddN0cfEl979wWG3+diIR7pZMCm/B5VVvQkzrDJeGhaLGlofpMGqYJkuKktjlzthulpIwNeIX/BZY93IusgUhYbJyYHaf7pwiQLmaDMgNLpW1rc3YVqSu7Oj+fJPWWoRZpCO15FhXdZBbVa0ZUSy3HM3noqnAaXnT+MHoSpAO6pv6T/KF5+sIEl5nCEdqCPWcmmNunS4fla0v/YlQb4+0Vf/JK16x/ColRsmZXKWPkXcvNrdY+8uRQkEs8/vtWZ2jFNqVM3GAbLf/cJx7sndiFk8yAdX/fme18wylipUAKO+uzxfByAcb86GUJbIOAinB6Cqxhwkk36XnL5vfS8dvs9Ck+65dO9f8Iz5YgQXNDrdELFwmLbY/yu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB5818.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0b2660-7e04-4ee5-2e0e-08d82d3f39d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2020 06:28:04.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lDiZjNNCNG5YyGODs33Ub3TIWqvmIPN+3eAWts9u9LeXBfJxxOip9lMpogzHowHpNoZ2jpMezRmBvImByZS5Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Thanks for the review

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Tuesday, July 21, 2020 7:38 AM
> To: Sai Krishna Potthuri <lakshmis@xilinx.com>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; git
> <git@xilinx.com>; saikrishna12468@gmail.com
> Subject: Re: [PATCH 1/2] dt-bindings: reset: Updated binding for Versal r=
eset
> driver
>=20
> On Tue, Jul 14, 2020 at 11:59:08AM +0530, Sai Krishna Potthuri wrote:
> > Added documentation and Versal reset indices to describe about Versal
> > reset driver bindings.
> >
> > Signed-off-by: Sai Krishna Potthuri
> > <lakshmi.sai.krishna.potthuri@xilinx.com>
> > ---
> >  .../bindings/reset/xlnx,zynqmp-reset.txt      |  11 +-
> >  .../dt-bindings/reset/xlnx-versal-resets.h    | 105 ++++++++++++++++++
> >  2 files changed, 112 insertions(+), 4 deletions(-)  create mode
> > 100644 include/dt-bindings/reset/xlnx-versal-resets.h
> >
> > diff --git
> > a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> > b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> > index 27a45fe5ecf1..ed836868dbf1 100644
> > --- a/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> > +++ b/Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
> > @@ -1,7 +1,7 @@
> >
> > ----------------------------------------------------------------------
> > ----
> > - =3D  Zynq UltraScale+ MPSoC reset driver binding =3D
> > + =3D  Zynq UltraScale+ MPSoC and Versal reset driver binding =3D
> >
> > ----------------------------------------------------------------------
> > ---- -The Zynq UltraScale+ MPSoC has several different resets.
> > +The Zynq UltraScale+ MPSoC and Versal has several different resets.
> >
> >  See Chapter 36 of the Zynq UltraScale+ MPSoC TRM (UG) for more
> > information  about zynqmp resets.
> > @@ -10,7 +10,8 @@ Please also refer to reset.txt in this directory for
> > common reset  controller binding usage.
> >
> >  Required Properties:
> > -- compatible:	"xlnx,zynqmp-reset"
> > +- compatible:	"xlnx,zynqmp-reset" for Zynq UltraScale+ MPSoC
> platform
> > +		"xlnx,versal-reset" for Versal platform
> >  - #reset-cells:	Specifies the number of cells needed to encode reset
> >  		line, should be 1
> >
> > @@ -37,8 +38,10 @@ Device nodes that need access to reset lines should
> > specify them as a reset phandle in their corresponding node as
> > specified in reset.txt.
> >
> > -For list of all valid reset indicies see
> > +For list of all valid reset indices for Zynq UltraScale+ MPSoC see
> >  <dt-bindings/reset/xlnx-zynqmp-resets.h>
> > +For list of all valid reset indices for Versal see
> > +<dt-bindings/reset/xlnx-versal-resets.h>
> >
> >  Example:
> >
> > diff --git a/include/dt-bindings/reset/xlnx-versal-resets.h
> > b/include/dt-bindings/reset/xlnx-versal-resets.h
> > new file mode 100644
> > index 000000000000..895424e9b0e5
> > --- /dev/null
> > +++ b/include/dt-bindings/reset/xlnx-versal-resets.h
> > @@ -0,0 +1,105 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + *  Copyright (C) 2020 Xilinx, Inc.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_VERSAL_RESETS_H
> > +#define _DT_BINDINGS_VERSAL_RESETS_H
> > +
> > +#define VERSAL_RST_PMC_POR			(0xc30c001U)
>=20
> Perhaps some explanation on the numbering as ZynqMP seems to be just an
> index.
In versal, all ID's includes Class, SubClass, Type, Index information where=
as class
refers to clock, reset, power etc., Underlying firmware in Versal have such
classification and expects the ID to be this way.
[13:0] - Index bits
[19:14] - Type bits
[25:20] - SubClass bits
[31:26] - Class bits
I will add this information in this file in v2.

Regards
Sai Krishna
>=20
> > +#define VERSAL_RST_PMC				(0xc410002U)
> > +#define VERSAL_RST_PS_POR			(0xc30c003U)
> > +#define VERSAL_RST_PL_POR			(0xc30c004U)
> > +#define VERSAL_RST_NOC_POR			(0xc30c005U)
> > +#define VERSAL_RST_FPD_POR			(0xc30c006U)
> > +#define VERSAL_RST_ACPU_0_POR			(0xc30c007U)
> > +#define VERSAL_RST_ACPU_1_POR			(0xc30c008U)
> > +#define VERSAL_RST_OCM2_POR			(0xc30c009U)
> > +#define VERSAL_RST_PS_SRST			(0xc41000aU)
> > +#define VERSAL_RST_PL_SRST			(0xc41000bU)
> > +#define VERSAL_RST_NOC				(0xc41000cU)
> > +#define VERSAL_RST_NPI				(0xc41000dU)
> > +#define VERSAL_RST_SYS_RST_1			(0xc41000eU)
> > +#define VERSAL_RST_SYS_RST_2			(0xc41000fU)
> > +#define VERSAL_RST_SYS_RST_3			(0xc410010U)
> > +#define VERSAL_RST_FPD				(0xc410011U)
> > +#define VERSAL_RST_PL0				(0xc410012U)
> > +#define VERSAL_RST_PL1				(0xc410013U)
> > +#define VERSAL_RST_PL2				(0xc410014U)
> > +#define VERSAL_RST_PL3				(0xc410015U)
> > +#define VERSAL_RST_APU				(0xc410016U)
> > +#define VERSAL_RST_ACPU_0			(0xc410017U)
> > +#define VERSAL_RST_ACPU_1			(0xc410018U)
> > +#define VERSAL_RST_ACPU_L2			(0xc410019U)
> > +#define VERSAL_RST_ACPU_GIC			(0xc41001aU)
> > +#define VERSAL_RST_RPU_ISLAND			(0xc41001bU)
> > +#define VERSAL_RST_RPU_AMBA			(0xc41001cU)
> > +#define VERSAL_RST_R5_0				(0xc41001dU)
> > +#define VERSAL_RST_R5_1				(0xc41001eU)
> > +#define VERSAL_RST_SYSMON_PMC_SEQ_RST		(0xc41001fU)
> > +#define VERSAL_RST_SYSMON_PMC_CFG_RST		(0xc410020U)
> > +#define VERSAL_RST_SYSMON_FPD_CFG_RST		(0xc410021U)
> > +#define VERSAL_RST_SYSMON_FPD_SEQ_RST		(0xc410022U)
> > +#define VERSAL_RST_SYSMON_LPD			(0xc410023U)
> > +#define VERSAL_RST_PDMA_RST1			(0xc410024U)
> > +#define VERSAL_RST_PDMA_RST0			(0xc410025U)
> > +#define VERSAL_RST_ADMA				(0xc410026U)
> > +#define VERSAL_RST_TIMESTAMP			(0xc410027U)
> > +#define VERSAL_RST_OCM				(0xc410028U)
> > +#define VERSAL_RST_OCM2_RST			(0xc410029U)
> > +#define VERSAL_RST_IPI				(0xc41002aU)
> > +#define VERSAL_RST_SBI				(0xc41002bU)
> > +#define VERSAL_RST_LPD				(0xc41002cU)
> > +#define VERSAL_RST_QSPI				(0xc10402dU)
> > +#define VERSAL_RST_OSPI				(0xc10402eU)
> > +#define VERSAL_RST_SDIO_0			(0xc10402fU)
> > +#define VERSAL_RST_SDIO_1			(0xc104030U)
> > +#define VERSAL_RST_I2C_PMC			(0xc104031U)
> > +#define VERSAL_RST_GPIO_PMC			(0xc104032U)
> > +#define VERSAL_RST_GEM_0			(0xc104033U)
> > +#define VERSAL_RST_GEM_1			(0xc104034U)
> > +#define VERSAL_RST_SPARE			(0xc104035U)
> > +#define VERSAL_RST_USB_0			(0xc104036U)
> > +#define VERSAL_RST_UART_0			(0xc104037U)
> > +#define VERSAL_RST_UART_1			(0xc104038U)
> > +#define VERSAL_RST_SPI_0			(0xc104039U)
> > +#define VERSAL_RST_SPI_1			(0xc10403aU)
> > +#define VERSAL_RST_CAN_FD_0			(0xc10403bU)
> > +#define VERSAL_RST_CAN_FD_1			(0xc10403cU)
> > +#define VERSAL_RST_I2C_0			(0xc10403dU)
> > +#define VERSAL_RST_I2C_1			(0xc10403eU)
> > +#define VERSAL_RST_GPIO_LPD			(0xc10403fU)
> > +#define VERSAL_RST_TTC_0			(0xc104040U)
> > +#define VERSAL_RST_TTC_1			(0xc104041U)
> > +#define VERSAL_RST_TTC_2			(0xc104042U)
> > +#define VERSAL_RST_TTC_3			(0xc104043U)
> > +#define VERSAL_RST_SWDT_FPD			(0xc104044U)
> > +#define VERSAL_RST_SWDT_LPD			(0xc104045U)
> > +#define VERSAL_RST_USB				(0xc104046U)
> > +#define VERSAL_RST_DPC				(0xc208047U)
> > +#define VERSAL_RST_PMCDBG			(0xc208048U)
> > +#define VERSAL_RST_DBG_TRACE			(0xc208049U)
> > +#define VERSAL_RST_DBG_FPD			(0xc20804aU)
> > +#define VERSAL_RST_DBG_TSTMP			(0xc20804bU)
> > +#define VERSAL_RST_RPU0_DBG			(0xc20804cU)
> > +#define VERSAL_RST_RPU1_DBG			(0xc20804dU)
> > +#define VERSAL_RST_HSDP				(0xc20804eU)
> > +#define VERSAL_RST_DBG_LPD			(0xc20804fU)
> > +#define VERSAL_RST_CPM_POR			(0xc30c050U)
> > +#define VERSAL_RST_CPM				(0xc410051U)
> > +#define VERSAL_RST_CPMDBG			(0xc208052U)
> > +#define VERSAL_RST_PCIE_CFG			(0xc410053U)
> > +#define VERSAL_RST_PCIE_CORE0			(0xc410054U)
> > +#define VERSAL_RST_PCIE_CORE1			(0xc410055U)
> > +#define VERSAL_RST_PCIE_DMA			(0xc410056U)
> > +#define VERSAL_RST_CMN				(0xc410057U)
> > +#define VERSAL_RST_L2_0				(0xc410058U)
> > +#define VERSAL_RST_L2_1				(0xc410059U)
> > +#define VERSAL_RST_ADDR_REMAP			(0xc41005aU)
> > +#define VERSAL_RST_CPI0				(0xc41005bU)
> > +#define VERSAL_RST_CPI1				(0xc41005cU)
> > +#define VERSAL_RST_XRAM				(0xc30c05dU)
> > +#define VERSAL_RST_AIE_ARRAY			(0xc10405eU)
> > +#define VERSAL_RST_AIE_SHIM			(0xc10405fU)
> > +
> > +#endif
> > --
> > 2.17.1
> >
