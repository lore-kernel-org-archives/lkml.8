Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E43F1C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB37206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ff7io55t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgBGKzt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:55:49 -0500
Received: from mail-eopbgr70075.outbound.protection.outlook.com ([40.107.7.75]:57025
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgBGKzs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:55:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxpAZ+pBL4Je9IYClqVGPfPInoRr9+VGMD1qF8At5uZjDMMVwCTNuAXp+i/5oR6SvtX8LpYe4qSpI7yueaPg7l9Ae5HiPCrCfsxPbsuJ8/k105/i/POE0/IsTfNUUa+sgJB14hw8t7EywKtXZTmsN7vmqjRyQAXT4tFXWmExZNmUqtshcmPNRKozWsiCUsZgBYFFzwKrXjGMHBTYVj0OFL6vqQBYTIW/NVqMnHIpSngrFTTHr8kvqGqmMrWJ/PRHC6P4acy8Syifgw6W/5vieMVIMOirEgNCgAYRWgvkJvWY3mcyoDEUQzPNWXpKcARyFvaaKTKAdC1rOksRCJM9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMzuKmlGUanbdc0Spo99QONSyOaE6LriUKLeONphZ5Q=;
 b=XcDvFmNVHKZAWfEL0V1J+8zWOqpS8vjvEQ5XSaGC5w7oCwhXZ00MnS/zPCWFGy96/VnwCcnn2ZVASzeV2I/JWJsE6lJWU7DKp5CkrtFsjOO0pd2xBFC9T8MFuSzC6I0gFwAqL8mj8ZVQVeznqWKJOlGJVoPHg1TVnMr9OpTgF0L1IkKmtOoNOWyLZq99k40qmYcN7/HZhjToh9o/+fPBEOXRAXmh7kFq/Y9Qe2SYSmPCuDHeioUAYnC11IuPbyGH/EDaC5VBX/zAgQpqRGEqaAL1P6KUxoJ6ItC4COInj2izK5oJ3pc+od1rN4ob7U+krAUfUB849QWXVjAXAhz+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fMzuKmlGUanbdc0Spo99QONSyOaE6LriUKLeONphZ5Q=;
 b=ff7io55tMHl/bi1Nrn43xchDQY+iTni0EL+g4CGd91E9f6A+p2ivKhmf0qWI+ujElmsHyNylhS7Usf5rOlyKcJHTYocbmiSl/EYXHFpAM0JPnsaT1H/1mOpy1WHMv44Sye82r2aYuyt8rM3eWe5gyU+lBi8dt7VQrw5ndh8b8Lw=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB5329.eurprd04.prod.outlook.com (52.134.124.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 7 Feb 2020 10:55:44 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 10:55:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, Marc Zyngier <maz@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Thread-Topic: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Thread-Index: AQHV3O5LIqtUB1cLq0qKBDDFKN5B7qgPg0IAgAAK5QCAAADsQA==
Date:   Fri, 7 Feb 2020 10:55:44 +0000
Message-ID: <AM0PR04MB4481B1D5E2725E85BC6D6D71881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580994086-17850-1-git-send-email-peng.fan@nxp.com>
 <1580994086-17850-2-git-send-email-peng.fan@nxp.com>
 <7875e2533c4ba23b8ca0a2a296699497@kernel.org> <20200207104736.GB36345@bogus>
In-Reply-To: <20200207104736.GB36345@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8c292e8e-bd98-44f6-0cec-08d7abbc47e6
x-ms-traffictypediagnostic: AM0PR04MB5329:|AM0PR04MB5329:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB532912FBCF9C8C8C8920EB0D881C0@AM0PR04MB5329.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(136003)(366004)(346002)(39860400002)(376002)(199004)(189003)(26005)(7416002)(55016002)(81166006)(7696005)(2906002)(9686003)(66556008)(64756008)(66946007)(66476007)(81156014)(186003)(316002)(66446008)(8676002)(8936002)(76116006)(4326008)(110136005)(478600001)(52536014)(86362001)(44832011)(71200400001)(54906003)(33656002)(53546011)(6506007)(5660300002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5329;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i773gPsWpoD4n7qiI+O9MJ8pFgw/V7v05vTDvFp+KX437rmE5ObhT0qVF04D5p5WkaA2wKyTmncbx3BR0QXd35pEzZZcrXfnGQJZoQmSaMFI60Omu9fZn2xVvQoJzUgHY4lC4SgPtaYCNak/UMO3Wv8qNYpVPfqFYmh7dw6hAWA+i8uag7JY2I467xD87MR57aeNvz56WnHuLHgC22bvGMuJxkunZ1/kPwcc1/uuFuDVWCk44RYZjsXkysP+Zns+DBhrQovuUF6ubRfrO8/VFnAq5o+pAw871hPa14G5t7VbZMu7ipAZbONLIcOXGfClYd3LNr4FgTQiyaLM+nyihCdc4XXRMIdhnyiRr4i2vUcejI/kCJNfaPB+s2Wd8uuObG0AZACM5G+qCfNouurVRF70pUdb7DPlBu0LwYcAZoCjGluqaiRSJZiPoWasieDyBSd8GLO3lL1zQsBaPkhxEZpP2OW77Ezvp00r0m4g0gn1a1sqAybGqFDWY5ICZx2Q
x-ms-exchange-antispam-messagedata: LcFZKwvDTQ9T3W23f1Di46MVAtdvm9ogaADHS/lKGGGwHZnAT97L6aguHGxf/1woh4Bx1hK3h83HTaTjoaG5tzZcQE9kEWlW+UJpnrzyOppOZ/x7zampbR7ILol9/T4CaRtHJkf1DDGsxF29gBTicw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c292e8e-bd98-44f6-0cec-08d7abbc47e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 10:55:44.2965
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Awl0cRJUnubIdtjmpPJ7iH+fpWmzXgGC7kkaaQRdJ+3MkGE8ET+PyWFHHFgYz7fXMbtQeFOvSj629/5Kjkok/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5329
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transpor=
ts
>=20
> On Fri, Feb 07, 2020 at 10:08:36AM +0000, Marc Zyngier wrote:
> > On 2020-02-06 13:01, peng.fan@nxp.com wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > SCMI could use SMC/HVC as tranports, so add into devicetree binding
> > > doc.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > index f493d69e6194..03cff8b55a93 100644
> > > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > > @@ -14,7 +14,7 @@ Required properties:
> > >
> > >  The scmi node with the following properties shall be under the
> > > /firmware/ node.
> > >
> > > -- compatible : shall be "arm,scmi"
> > > +- compatible : shall be "arm,scmi" or "arm,scmi-smc"
> > >  - mboxes: List of phandle and mailbox channel specifiers. It should
> > > contain
> > >  	  exactly one or two mailboxes, one for transmitting messages("tx")
> > >  	  and another optional for receiving the notifications("rx") if @@
> > > -25,6 +25,8 @@ The scmi node with the following properties shall be
> > > under the /firmware/ node.
> > >  	  protocol identifier for a given sub-node.
> > >  - #size-cells : should be '0' as 'reg' property doesn't have any siz=
e
> > >  	  associated with it.
> > > +- arm,smc-id : SMC id required when using smc transports
> > > +- arm,hvc-id : HVC id required when using hvc transports
> > >
> > >  Optional properties:
> >
> > Not directly related to DT: Why do we need to distinguish between SMC
> > and HVC?
>=20
> IIUC you want just one property to get the function ID ? Does that align =
with
> what you are saying ? I wanted to ask the same question and I see no need=
 for
> 2 different properties.

The multiple protocols might use SMC or HVC. Saying

 Protocol@x {
    method=3D"smc";
    arm,func-id=3D<0x....>
 };
 Protocol@y {
    method=3D"hvc";
    arm,func-id=3D<0x....>
 };

With my propose:

Protocol@x {
    arm,smc-id=3D<0x....>
 };
 Protocol@y {
    arm,hvc-id=3D<0x....>
 };

No need an extra method property to indicate it is smc or hvc.
The driver use take arm,smc-id as SMC, arm,hvc-id as HVC.

Thanks,
Peng.

>=20
> > Other SMC/HVC capable protocols are able to pick the right one based
> > on the PSCI conduit.
> >
>=20
> This make it clear, but I am asking to  be sure.
>=20
> > This is how the Spectre mitigations work already. Why is that any diffe=
rent?
> >
>=20
> I don't see any need for it to be different.
>=20
> --
> Regards,
> Sudeep
