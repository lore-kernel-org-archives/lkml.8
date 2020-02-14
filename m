Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E8EC3B192
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C2A020848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 00:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RVR9rZYM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgBNA7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 19:59:10 -0500
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:20445
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727782AbgBNA7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 19:59:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRR/Mn8OKKJftJh0dq/r1YqAciIpAjFVLiyVWA15IB1bvjdIgmQ8mYOzQG2eJbCpBay5VPytntmtyZBeqWfWC51bknhbLGmed9Qp+pbWut90y5mDzlUPLcKePDAIGxcx3Z5UW+bPwfG1/PKxfMLGDz69+/vVj6npx72ZdbmoB0iBM88Xqjb+NiBMrHazG0Glhpn2ReYfeHMM70DnuaSs1oANvFD7+Cu8ofG2M2fEOi2OgQFOkHuchE118yclY3I9jirAFkIdVXnZOqClf0K+1hSeZx4Gnnr0deP5rDG7lx+orBUvIUofC24I4W+PhLlWO0WCBh3rpVxkocMEIOsGjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=435BD78WHnZz9Q+Yy4eWb5K8oqWRys+jOpcz65VLUh8=;
 b=Viw4c+aMmxp3nfm3OvIaQQFVkR4PSIoJUsadmp8fe4rBMgfbMkkcy2EYShSexQe46pO9xyjsMN7rrnw3Wi1SFiqM3OfR1UgJAmJ5A3sSiAt6nbupR5awwLAMpnP6YmMmojzSQxc47V7YitzbDkeBIIq2Jy+iUAb8jiYVvlN3V0l/wnptsLD8qnaRwhYI+n1UjwV8UeD+7F9sxDe2NoUBlwu2LX56S1nbs/bI83rJcUWQuWG/Aa9N6Yjtok9N42QKrtt0sTHnIKI7CePsl6YUVIU2bPVIcV9p8SOG+DAtyEhOMPhrtVpmpcSeS0+emt754DQG8inoYbUTjyqmLINOxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=435BD78WHnZz9Q+Yy4eWb5K8oqWRys+jOpcz65VLUh8=;
 b=RVR9rZYM6Q0OCyJXBSpUTnOCu9vS+wfJm1X/S2eFqMds1QkABbgX160MxHxp1LeysP0r9oCupCcCaowonFzEoa6BBgmZHwuXWDrJKsGG3dJXWhtSEWM0x22cSLd9UDrJ8Sowp5NUyKY3n2yvWQsiNOoTzMbUUSv2j5I7HkdnHV0=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4866.eurprd04.prod.outlook.com (20.177.42.15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Fri, 14 Feb 2020 00:59:03 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2729.024; Fri, 14 Feb 2020
 00:59:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andre.przywara@arm.com" <andre.przywara@arm.com>
Subject: RE: [PATCH V2 1/2] dt-bindings: arm: arm,scmi: add smc/hvc transports
Thread-Topic: [PATCH V2 1/2] dt-bindings: arm: arm,scmi: add smc/hvc
 transports
Thread-Index: AQHV4iK2/Nh1kKO7nUGh3zi/1UGt8agY85WAgADrEKA=
Date:   Fri, 14 Feb 2020 00:59:03 +0000
Message-ID: <AM0PR04MB4481D227E34A95D22AFE3C9888150@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1581566330-1029-1-git-send-email-peng.fan@nxp.com>
 <1581566330-1029-2-git-send-email-peng.fan@nxp.com>
 <20200213105413.GA23374@bogus>
In-Reply-To: <20200213105413.GA23374@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 228c9d38-31ba-498e-307c-08d7b0e91605
x-ms-traffictypediagnostic: AM0PR04MB4866:|AM0PR04MB4866:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4866816E47009F5C73AD90EF88150@AM0PR04MB4866.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(39860400002)(376002)(396003)(189003)(199004)(33656002)(478600001)(6506007)(8676002)(81166006)(2906002)(81156014)(966005)(44832011)(6916009)(4326008)(8936002)(186003)(316002)(54906003)(76116006)(66556008)(66446008)(66946007)(86362001)(7696005)(64756008)(66476007)(26005)(71200400001)(52536014)(5660300002)(55016002)(9686003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4866;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSvYAYII6MboKN643cARfpQZ9nSk+IQFn6qNxkbjdtERkOsljMwtGeruP2Bw9Ts+xlnPN/hVwgLX+aVQexAghV7OxeW5+zb9oRtH0YfD/rg7LmNP54n82OmsVwqzqRai7u+jTpEkSIzA2sjqkPPzB49CnbFqSSzYfR/q9s8SjJBliI0j6O/7wLSAHAXJog5xC8CIBLeSDF81Iyf031w5pB1frOQAl1x3saXJI6JMhFDp0+YaImHEtTOad/my8zZeK5zpAJNCs+8aTVGNOel0u/PD7BO1hCDz8N3gYD/Ch/KVg7vrzgXPjZwdIzCyyMVWajGUSE9brf8dKT+gEG1VlvQyNsacnNH/48k8iisrBaULBXgHE+RXj8dshVpU3HoBgwCRqC72TSWZ7VCqTItiQm1mt1/XV9eefijv1fRrqZGWI91yCERKcYqdEj8innbS5jDmq05SM+jyqt+GsfeGEq2YDUHmEJcbvL/02PyEpBR72ERXO98fpjasw4h1sW2MDURZBvAiqO/OH4WcE43j+x1JJTIg6/2fQBVm2t1TmuXTZo3KwEzba4xRvYOsn2gf
x-ms-exchange-antispam-messagedata: arsLYeFli/8Mp3Qo9PW1T/sOC+xPr6S98I9ABO4QNu4NDMVFkkENGbZdiORB+HFJ07cyg5VZkHIZOdg6y/YcqgNDABO/+sQs+m2iKtJVX3k9G34p0QFupJw8MJh1a/N+9MFF51rurCGmaRlH8E6vQw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 228c9d38-31ba-498e-307c-08d7b0e91605
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 00:59:03.8492
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KNnhiKk/qQitTjtGAV4lzlFlRH2VnNVUFizhVPmiPVTg9zksc7+8w3s0/Rph3As637jn7fbxsBgbhJKboakC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4866
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

> Subject: Re: [PATCH V2 1/2] dt-bindings: arm: arm,scmi: add smc/hvc
> transports
>=20
> On Thu, Feb 13, 2020 at 11:58:49AM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > SCMI could use SMC/HVC as tranports. Since there is no standardized
> > id, we need to use vendor specific id. So add into devicetree binding
> > doc.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/arm/arm,scmi.txt | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > index f493d69e6194..dacc62dc248b 100644
> > --- a/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > +++ b/Documentation/devicetree/bindings/arm/arm,scmi.txt
> > @@ -25,6 +25,7 @@ The scmi node with the following properties shall be
> under the /firmware/ node.
> >  	  protocol identifier for a given sub-node.
> >  - #size-cells : should be '0' as 'reg' property doesn't have any size
> >  	  associated with it.
> > +- smc-id : SMC id required when using smc or hvc transports
>=20
> IIUC, "arm,smc-id" is preferred more.

ok. Fix in v3.

>=20
> Why did you drop "arm,scmi-smc" ?

Per our discuss in v1 patchset, mailbox/smc-id could be used
to differentiate mailbox and smc transports.

https://lkml.org/lkml/2020/2/11/226

So I still use "arm,scmi" for smc tranports.=20


Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
