Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F828C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D033206BE
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 08:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N9EBPQ4Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbgETI1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 04:27:08 -0400
Received: from mail-vi1eur05on2066.outbound.protection.outlook.com ([40.107.21.66]:18913
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726403AbgETI1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 04:27:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSlpMrV4ffkf5G9DzMOVOW5EIJQWwNOQt0dOovskyRxEqGfh5LtnOY3JTVV5wRe4DGGVN0/mYT/hoYEf0941IfCddUUYRfgbSji4t/wRGhdBkBC4V75sMRwWyv6AhFNSH60CUk0hD/wlf/wTnEIQGfg/+6u6Nkui1G/DVlL5q+5P0qzeQ1aWdttkH1wBN1I2eeeY4Gy20ekuhThM5boDhxGsz6sY6wy7RHBq2y9+dMFB0vjAxn5pvFrUEr1kASn08jxIiXE+VGOTkXi3mB2j9uRzwKUCqleA0RVC3RKMxc1+C/5UoxtzGk+uahWdMZtqD3NZu/BYdYeWn0BNIy+eYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAr05cAZBlGb/Kx7rhymPd0KK7Jug2gaZNj7/d8gNRg=;
 b=agYLjUY5XppttxixuocFjO65FQqWYynIABLfYBHIKKTd9PyusSDmipvqdBmTI7tSJZsb7LE2ZqwTOcEA+TseLZ/t3d3CBnkQQBMeRvxr1GbJVJ8ShNP3Yp3LL7h+PDKvqjfIuQYsC1v+8X2sxPRGoA1+JeMWf+rDvfuLjhVINu/27lEyCef+RVnd3z1zZiyqqHZ8SnVpCE8ETg6FJVoyc6ScEGbJl91/Q3993cDe9ik+lrr/+dk3qluHnaWP6f5ipcdz1aUBodF9iXsnse4ghKmTVZmG86aKMrzT0XCu7VYodMPxOhh2oN+Zo92IpSxf/Wempj4N5gxz0K+ER+pZ5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LAr05cAZBlGb/Kx7rhymPd0KK7Jug2gaZNj7/d8gNRg=;
 b=N9EBPQ4QjAhnBdtvBOhsFdvZ3Dk9oEtlUZ7/ZoeUKh5q0ZTu8dI4MOYmmTp/cnoldfb8IXJIpceuBrrTnVhfUL98STYmlcOUtlhQZyMGT8RQwWMpWwxcEpD6qNk2xyNt9J8qNE5xI8NNjjbOGgvtGs1guuIFIZP+gZTTQkl0sm4=
Received: from VI1PR0401MB2446.eurprd04.prod.outlook.com
 (2603:10a6:800:4e::21) by VI1PR0401MB2576.eurprd04.prod.outlook.com
 (2603:10a6:800:56::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Wed, 20 May
 2020 08:27:04 +0000
Received: from VI1PR0401MB2446.eurprd04.prod.outlook.com
 ([fe80::10d3:8526:1631:142b]) by VI1PR0401MB2446.eurprd04.prod.outlook.com
 ([fe80::10d3:8526:1631:142b%9]) with mapi id 15.20.3000.034; Wed, 20 May 2020
 08:27:04 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     Ran Wang <ran.wang_1@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [RESEND 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Thread-Topic: [RESEND 1/4] arm64: dts: lx2160a: add ftm_alarm0 DT node
Thread-Index: AQHWJRwNdMV78TX1sk6N7IDGhrQGaKieAICAgAUFi4CADcLJEA==
Date:   Wed, 20 May 2020 08:27:04 +0000
Message-ID: <VI1PR0401MB244628B9AED7B46862E63E2E8FB60@VI1PR0401MB2446.eurprd04.prod.outlook.com>
References: <20200407064251.39244-1-biwen.li@oss.nxp.com>
 <20200426131751.GC30501@dragon>
 <DB6PR0401MB2438A8B634DBE15FADD3CFB18FA20@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <20200511141649.GA26831@dragon>
In-Reply-To: <20200511141649.GA26831@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0c9e1003-dd42-4127-6ed9-08d7fc9793fa
x-ms-traffictypediagnostic: VI1PR0401MB2576:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2576A8344007467D5EDC9C4ECEB60@VI1PR0401MB2576.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8y4eJLDF7Qn2/OEUkndCfuJ8UN/4b9kIDLUEFGo5LHxIQKWP6BhxmFeqny9b+uNcIqmLdxmPLPEECAf1hsUJNoRpliCWr/Ht5c8DgunXtV/h19RVxEbW4aWVSDMUvmyeabvhOr9n6gyuHDYoeu14CoZqrCYF+gdo38gsFPKxsk7m737QNKIdGXJNQuk9X1ntodbpRYqkVjmJp8C/REyLIqjIPZB6K7CoUg7EPIK6LZAmggEeRtmMPG+7MNLyWkbe+OM/ylJUXNDZAm48vfPZ/JjGMmPEA5sa1wLFZ2UeoLhtY1SWWQ2L0GasxFuNeFVyVH3cXdnosBNUbs68+ntAXVXh6eMSe4MoC84d/OTyu9Hc1H/twKIKP9lH0ooTWpg5quLsFcinXWT1b9MzZv1eFTlDWnZux9B2i7jXaHEBjWmpYQ8C8nJ3HWA+K2B/D0P
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2446.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(7696005)(8936002)(76116006)(52536014)(186003)(9686003)(8676002)(86362001)(55016002)(71200400001)(26005)(5660300002)(54906003)(64756008)(4326008)(66946007)(2906002)(66556008)(316002)(110136005)(6506007)(33656002)(478600001)(66446008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: T6x3m/8rNBhgUc/KOPpZQ5THWAem1GDj+rbx8KPcusTdnHEojnGr8iqAoxG7kepu/lC6WWPL/uUoKzmN4PduvlT01m0bKTmQGlaCYkRV3xD61D38T6Om2TYCGz2JzeB7KoypQeG+JjSESK5OIdRinCjr9Kt69wZ0YUBs+TQ6q21O9c38dyNkVnV+NjFSPMV2sC+qJTWO93LA4J0PDacao8a15p1pCDLz77HzBpNjCwtpvobTMomoStMHe4Td3DCDA6C5+s+myZZo7U2k5nQtSR5jHIexN4+5lwqt9+1dL1zpc6ltB0ZGNGpWD8IjAPjwFbrnE/JX2waSt5gtJLJzFdDN42ygJ+SzNGWV5kr9QhD/iQ0bOjuYbD5MZi7uAAbZDbLAyGqhMFLye7nOqEgoUb3v/sUMHqu4DBNawAYKNpaxeLAsk8e3OiTgaIJ7q+2hE9TtbXekQDK6b6gTH17B7oKsX/OUNfLI9qwn9Nl96Jo=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c9e1003-dd42-4127-6ed9-08d7fc9793fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 08:27:04.7529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: APVf6m6l2ohCvky14rec/NQoSKiMpQxSUXG+qWdeoLL9NCUkjU43I6B7NKMs1YuRPvaXm/Cm4+9lDyKgBZGH8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2576
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> > > > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > index e5ee5591e52b..e0d8d68ce070 100644
> > > > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
> > > > @@ -16,6 +16,10 @@
> > > >  	#address-cells =3D <2>;
> > > >  	#size-cells =3D <2>;
> > > >
> > > > +	aliases {
> > > > +		rtc1 =3D &ftm_alarm0;
> > > > +	};
> > > > +
> > > >  	cpus {
> > > >  		#address-cells =3D <1>;
> > > >  		#size-cells =3D <0>;
> > > > @@ -768,6 +772,20 @@
> > > >  			timeout-sec =3D <30>;
> > > >  		};
> > > >
> > > > +		rcpm: rcpm@1e34040 {
> > >
> > > Keep the node sort in unit-address.  Also, try to use a generic node =
name.
> > Hi Shawn,
> > Sorry for late reply.
> > The node sort will be updated in v2.
> > rcpm is called as Run Control and Power Management. Don't Have a
> > generic node name, any suggestions?
>=20
> It sounds like some sort of power controller, so maybe 'power-controller'=
?
Okay, How about replace it with "rcpm: power-controller@1e34040 {"?
>=20
> Shawn
