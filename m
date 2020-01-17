Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758BFC33CAF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B53206E6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Km5wXfXi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388820AbgAQC0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:26:48 -0500
Received: from mail-vi1eur05on2063.outbound.protection.outlook.com ([40.107.21.63]:25378
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388334AbgAQC0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:26:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ/tl9RA2P5uCC5MqfdvxKZgzfB73z+GEu+iIgERxUE+hKK6s0hmCfvqTrC+EtAax+3WoJpXVcTgmztOMg4L1NDJKB6H7LRWhV4Pb3szrTtAbHmuwMAMHW9f2H+zNOe4+ueAgUzincwtU6ZuqOcgbPpZxDieNc5xAHBrScQUXAbiYvyr/wGX0tBosXZQENaOiPJ594bsA40UE8UnUMLKlraBxwaSjD8YLRYKA65XY6wJybsI16MNrwTLSMqApdje+lPjVFa6qIZ8JWJ/IukxdDj40KPn1NDS9an3s3CEiuNr021qZ9bJSicr4SJ2nxliM4MFR6f+2RtOKDbuSsQsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDnoBNI8k2YIaxF16jswR9C1lsCbJQYr91rQoDA/N2I=;
 b=AkSqNaLulYabRDzQ7vDeQOWkivvUSIl77D1mLrsBNguUxOui0fKMtNsu189c6D53Sp38QR8/ESkyDdeFkQu16molPb8RDCNnZb3OL3xld9ZfsDEtsGoapN8heiiEaRgj+X2uQTesDeQnhiNwjzZdmX3YMLr/fVlKJY3iDrM6/cjlTRuIc9BusnZtbmknFeLLnS9fb4kuua9xfTnNRxxLM+AfukhHNHX/mqHctMoBhn3Nc9PHvjYIGfLYiQz5LuL4hjsTpKlZvU1QVcOZFvNr+kuGxpNqjhMtlaQalyykOB5nvyFKrYTI53Pb5Pq9YmV4eWQKtDDUUWQtnPez4zwDzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDnoBNI8k2YIaxF16jswR9C1lsCbJQYr91rQoDA/N2I=;
 b=Km5wXfXiZBL24Jh5+chPTgyGfKdUZCC/R5CgjY0q0pG948NUhxwzgQ3kX27Zxeb/VROiKdYn/0fwsuZO9xP4nO7CAMfUz7gAFYBYdG5aUtTL2THfasavm1ZpLgT4LFa7D+jS8bD80wmXivCWzn9BUz1976Jc+d3c1SlN2VujH9U=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB7172.eurprd04.prod.outlook.com (10.186.128.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.19; Fri, 17 Jan 2020 02:26:44 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.018; Fri, 17 Jan 2020
 02:26:43 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Viresh Kumar <viresh.kumar@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Topic: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Index: AQHVx5pwG3O6xvtPWkmuLxJSz4SzNKfrcuWQgABfY4CAAlluoA==
Date:   Fri, 17 Jan 2020 02:26:43 +0000
Message-ID: <AM0PR04MB4481D300CC3B936A1F32B30688310@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <AM0PR04MB4481AA813CB53AC0D2C238C788370@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200115143325.GA12340@bogus>
In-Reply-To: <20200115143325.GA12340@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7dff0cf9-f484-4916-0ca6-08d79af4b1a5
x-ms-traffictypediagnostic: AM0PR04MB7172:
x-microsoft-antispam-prvs: <AM0PR04MB7172C85E7D3D26E6D3C9DB6C88310@AM0PR04MB7172.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(199004)(189003)(76116006)(6916009)(7696005)(64756008)(71200400001)(55016002)(66476007)(478600001)(66556008)(66946007)(66446008)(52536014)(81166006)(5660300002)(4326008)(9686003)(316002)(54906003)(2906002)(44832011)(26005)(8676002)(81156014)(86362001)(6506007)(33656002)(186003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB7172;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWYywzSbkQo7xpJMmj1BF/VblAkpoMLpBfQkY55fTfkcwtSQNfydGe11fnlb+wSlfNhWzbVqZGJ7vWczZ0K1osCD4PNfDbk7E/VNtj70bIDm3isMvwOEwPuUjcISLhwgGqM3fGcARFwtmhcxLhdduY0LpRb8qbLLZMEKk4+WnK84mtALBLTz/Zc5v3hdUwpNpRY3upLRoklo1Msn2270og6/cV9ECSv4VH8vw9WY/N1wTL4X7ZUd4RBBOS0uiB5Ukykdz314OoQA6YCpFIBlSTRq6Lmwp8yvcou36OQYA25psgDxF+xuhcC24pK245wH/o6/FfJslmvWX+SchDL/spqufN8DmGLWI7xqgY4X8Xbwu/2cFbbFV6a6OsyqDF0IfVBlO+qqKPIXRS872tZPGV9JpIQwZm6YPXsLPSA5QlpBG6YgYCv1vqVC5+Bb+muo
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dff0cf9-f484-4916-0ca6-08d79af4b1a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 02:26:43.7966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1YTn3XgLwGB2hVak4yx0pdeBfr5OFC+66DQU1TUNbpWeaglckWeZ6tuKzBNvgFJR9yrrKLBf3RBaSmdPKNaDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
> transport type
>=20
> On Wed, Jan 15, 2020 at 08:53:51AM +0000, Peng Fan wrote:
> >
> > > Subject: [PATCH V2] firmware: arm_scmi: Make scmi core independent
> > > of transport type
> > >
> > > The SCMI specification is fairly independent of the transport
> > > protocol, which can be a simple mailbox (already implemented) or
> anything else.
> > > The current Linux implementation however is very much dependent of
> > > the mailbox transport layer.
> > >
> > > This patch makes the SCMI core code (driver.c) independent of the
> > > mailbox transport layer and moves all mailbox related code to a new
> > > file: mailbox.c.
> > >
> > > We can now implement more transport protocols to transport SCMI
> > > messages, some of the transport protocols getting discussed
> > > currently are SMC/HVC, SPCI (built on top of SMC/HVC), OPTEE based
> > > mailbox (similar to SPCI), and vitio based transport as alternative t=
o
> mailbox.
> > >
> > > The transport protocols just need to provide struct scmi_desc, which
> > > also implements the struct scmi_transport_ops.
> >
> > I need put shmem for each protocol, is this expected?
>=20
> No, it's optional. If some/all protocols need dedicated channel for whate=
ver
> reasons(like DVFS/Perf for polling based transfers), they can specify.
> Absence of dedicated channel infers all protocols share the channel(s).
>=20
> > Sudeep,
> > I am able to use smc to directly transport data, with adding a new
> > file, just named smc.c including a scmi_smc_desc,
>=20
> Good.
>=20
> > But I not find a good way to pass smc id to smc transport file.
> >
>=20
> IMO, we have to deal this in transport specific init. I am thinking of
> chan_setup in context of this patch. Does that make sense ?

Yes, will you implement that?

>=20
> [...]
>=20
> > +
> > +    scmi_clk: protocol@14 {
> > +            reg =3D <0x14>;
> > +            shmem =3D <&cpu_scp_lpri>;
> > +            #clock-cells =3D <1>;
> > +            clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ext1>,
> <&clk_ext2>,
> > +                     <&clk_ext3>, <&clk_ext4>;
> > +            clock-names =3D "osc_32k", "osc_24m", "clk_ext1",
> "clk_ext2",
> > +                          "clk_ext3", "clk_ext4";
>=20
> This caught my attention, why do we need these clocks phandle list and cl=
ock
> names above ? Ideally just need scmi_clk phandle and the index to refer a=
nd
> names need to be provided by the firmware.

No need, I forgot the remove them.

Thanks
Peng.

>=20
> --
> Regards,
> Sudeep
