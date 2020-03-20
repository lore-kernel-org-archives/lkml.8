Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5909CC43332
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F30020774
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WCGHemLp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCTIkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:40:22 -0400
Received: from mail-eopbgr130089.outbound.protection.outlook.com ([40.107.13.89]:35215
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbgCTIkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:40:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+38sseMgZdiVlSZadirQMMX4mkWDl16Tnat3MDolYb6sBv1GJzEWRe+wfs4P6KxUG8s7LlfW8fxrandB5pfTmGwkadabZzDDc2qgIxsezUjueFcnhdZbR7w9NP8rgZbknBg9U+93axELwCLbtWzeJ321cvEIAd4/WFzC8ZCw6PF7maWkGL6U34IpVXvcs7w+b0NZzficnsUUnMu3GAmwBmmZ6kvt/byRqaG4wycxULuJp+dufI1k95932sGf2Da0ZhQ6bEfMlTXxTXOPrgrexGvqE3/zCkwFt4D7eiDttuqFi71gXtSOtcXEi1hmBJ1xce01aTdRx+pntpDF0Y5gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig7vsm4mW0W2fWYVuYntzY2+i2Gm5rc73fWEJDiL9mI=;
 b=lt/DZRQjUj3U5RpMUZWY61WTgJZfda2oHdB2aEz03JUrGzjWcckB6V41Cul3Di3w6ifVp4NSqqjdXpC8771Vp3g2tVF7+2neUS2WqtLbxZIF5gB0UkjYASKo2AEnRCILbvxl3yfgxeQMDZbql+Y+JG4zdSdQs4BBhhK/X2NNsJpwwX7TY1V7eOIELvK1GV/2sCOjHERE1Nm9m5I9BkCJcr4coEFTWB/r+qn1PH1ytqeukP4rYjFaxjTbq6URRG+oJyhIU9yt4KHYqce66WJeMMsqO5ka1HI4ynODsG3iuBHhLnkjq41ckbqz9RkHm95o2C44Y1k1OVTKSR+aBk9xNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ig7vsm4mW0W2fWYVuYntzY2+i2Gm5rc73fWEJDiL9mI=;
 b=WCGHemLp17GewkXCv5pyChq21s1kOLqWkM/NunW9COzIS7soP2+AHSqXjiKrCgQsYsNfinlULzlzxU33rn3sC27bOOo0rSC4IP8lY62TlZW95mwR4whjvRJQym1DijencUAv/BWtKn8m4KxfgZm/SerIoVhTi/R52utLE96e3/w=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6500.eurprd04.prod.outlook.com (20.179.253.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.18; Fri, 20 Mar 2020 08:40:16 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::ad44:6b0d:205d:f8fc%7]) with mapi id 15.20.2814.021; Fri, 20 Mar 2020
 08:40:16 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: RE: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports support
Thread-Topic: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports
 support
Thread-Index: AQHV9U3Qw/Abi3aPd0Wpj3X8/OF3VqhRN+vAgAADLgCAAAB94A==
Date:   Fri, 20 Mar 2020 08:40:15 +0000
Message-ID: <AM0PR04MB44819EAFF5AD697B7E39B7B888F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1583673879-20714-1-git-send-email-peng.fan@nxp.com>
 <AM0PR04MB4481F673F90C735F272C171F88F50@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200320083756.GA12067@e107533-lin.cambridge.arm.com>
In-Reply-To: <20200320083756.GA12067@e107533-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9892e06d-2d82-4591-78e6-08d7ccaa5054
x-ms-traffictypediagnostic: AM0PR04MB6500:|AM0PR04MB6500:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB65006F08063F12BE96EF43F388F50@AM0PR04MB6500.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-forefront-prvs: 03484C0ABF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(346002)(39860400002)(136003)(199004)(33656002)(6916009)(52536014)(5660300002)(26005)(81156014)(186003)(8676002)(7696005)(44832011)(64756008)(66946007)(55016002)(86362001)(66446008)(71200400001)(4744005)(81166006)(9686003)(66556008)(2906002)(66476007)(478600001)(76116006)(54906003)(316002)(8936002)(6506007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6500;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3tMjY7jUgNmsa9NmJIjW97DieEbe/Feu8U2Z+peSIms7a/QVq25NQom9Y4+CCYCIXcz2LaeXyakPLZp717zsM8yHUUU2DnzzXS+/KVe0rKHeyvJBntRzqCf50tM89pkAsbJGzKBTIOLxewSob9fxZprP5xN5ucJvXkT/x8eWhHGpK5p++9jS6+8bN/9LC7kckBvtMeE3809ITOREQ69ZJt8i0b9nEQFiSWMqiPGD21ePd/fcr6jiBLvEm83rVSDIM+rTJIrtto8VPJ48IWJuVq8wueQWOqJ9dciFg/3jQJLwWrqmePV9Ht2ug2mKU6j3p5kBZfNb75OhzQsfBpvD70gB58Cnynhw4JClkQkWa/eLmDgu/Z+xom7vo8THgltq1WImf7vEDMFylByYlQ+WErK4EGbnbkZU3tvfeT2kh9UKnS0ucCDN5GPBiBFcLnfk
x-ms-exchange-antispam-messagedata: a0rQHc419AtV9HiEH0uUsF66amt0280lHPHZ7CH27wxz/B7cyDjLH8Scflq1PyG/G2YYh+gA2mDmlpbZYehPfWIHI26ENkKyvMbTtST/ixR8oevpnQlz7x+bbel7GM2uRS6CwiZE71tUg8ydaFsyWw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9892e06d-2d82-4591-78e6-08d7ccaa5054
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2020 08:40:15.9305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L9BTin7GFM7NM9fROWrg1ryS/gMORHDE288iMyeNIa+6lTFeMr2BReo4WHii2/QPbBRMKi1+Y3VdjHThjwSYVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6500
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports
> support
>=20
> On Fri, Mar 20, 2020 at 08:27:47AM +0000, Peng Fan wrote:
> > Hi Sudeep,
> >
> > > Subject: [PATCH V5 0/2] firmware: arm_scmi: add smc/hvc transports
> > > support
> >
> > Are you fine with this patchset? Or You expect multi channel support?
> >
> > We have some features depending on this for long time, so hope smc
> > transports could be finalized sooner.
> >
>=20
> I have applied these patches as is, yet to push it out. I am waiting for =
my v5.7
> scmi PR to reach arm-soc next before I update my scmi branch. I will let =
you
> know replying to this thread once that happens.

Appreciate.

Thanks,
Peng.

>=20
> --
> Regards,
> Sudeep
