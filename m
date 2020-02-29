Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22C2C3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919DB24672
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 23:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=plvision.eu header.i=@plvision.eu header.b="BEsEeRA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgB2XHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 18:07:02 -0500
Received: from mail-eopbgr80137.outbound.protection.outlook.com ([40.107.8.137]:15118
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726786AbgB2XHC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 18:07:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8eL591JVQ4zd0yjpTe3d7fWxcKQVA+z+vdOSwoktSkgZjLFN3imPYrkqQPvf7d55EZUuDhu7AtCCiy2EKf+139qU6gJas7vzmtnAYiSo9wJT9TvD7uydoFzd1WyJ5aaWvEkF6KZ/YEeQQa1FvwB6urw5okd10tpQMCoBeTo01eK5zfQJVjFgbpaYOBjbHZ24bZ8TB/HSlQQ0asd9mnfnYmDIsG205kfWes6fiRr7y37Se45icqGUuJwS8twP6WaZ2WMwFpCwU6wjgDOUhAxD9YcK9nMQUkVDny+OE0z8QVGcgR8SMS8nikJsCzV5pdS7frkkW9dt2Rj+CrbZvOWLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9NwnqjzOEn7SAFnPgIMaY5+QocVdNWZcAsasBSTTd0=;
 b=RCddzQ61WpDqrQKnL4gVE7V7ZCjMF1Nim3DJ/F9TrCTU33CnXV8utnEjKABItcur50Dc9P7wvyXbKqH2IzG/DIx0OMLC3OL644VZl0feVof4mkWogRdKEOb5lWUdL2vlEZt5voicekc6I4Up2+xyjTMJpXETDf1h48ZHWCzydPiR3oRSHMrg+ZDzrjYCghRXyArbL4i9r2KLhavvcVxZC4VcHWQU6NVdwY5ytwZU1RNEdeIaBUhsd2lBnU/3fWPD27uUHLZqBJq9pxB5knszD96/LsJoJ8nmhQS7ljSvJv5aQoeg/1zbgY1bMKN/WiY4bMLCw5IK0vMc14O7QCWS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9NwnqjzOEn7SAFnPgIMaY5+QocVdNWZcAsasBSTTd0=;
 b=BEsEeRA/MUj+PL5VR5STEI52MvXc1AQxJ7cIEoHA8hRPIHHI0r32SkqJ4RezMMrganfrjajsCTjCX6Dv1ei+f5gVSGyWm4eqawKZOvbkCw0LA+LunU6SJTu30YEIDw+gTVqvhAWj020bT4ErFO7a3LDv5tgYKVW+6WD2LhATtG4=
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM (10.165.195.138) by
 VI1P190MB0397.EURP190.PROD.OUTLOOK.COM (10.165.196.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14; Sat, 29 Feb 2020 23:06:57 +0000
Received: from VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::a587:f64e:cbb8:af96]) by VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 ([fe80::a587:f64e:cbb8:af96%4]) with mapi id 15.20.2772.018; Sat, 29 Feb 2020
 23:06:56 +0000
Received: from plvision.eu (217.20.186.93) by AM5PR0701CA0012.eurprd07.prod.outlook.com (2603:10a6:203:51::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.5 via Frontend Transport; Sat, 29 Feb 2020 23:06:55 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Jason Cooper <jason@lakedaemon.net>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: marvell: fix non-existed cpu referrence in
 armada-ap806-dual.dtsi
Thread-Topic: [PATCH] arm64: dts: marvell: fix non-existed cpu referrence in
 armada-ap806-dual.dtsi
Thread-Index: AQHV347B2j3P1pYbBU6vmfM/4HtQ8Kgy6rgA
Date:   Sat, 29 Feb 2020 23:06:56 +0000
Message-ID: <20200229230648.GA21220@plvision.eu>
References: <20200209212016.27062-1-vadym.kochan@plvision.eu>
In-Reply-To: <20200209212016.27062-1-vadym.kochan@plvision.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:203:51::22) To VI1P190MB0399.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:35::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadym.kochan@plvision.eu; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [217.20.186.93]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9b30180-fc95-4b6c-6bde-08d7bd6c128e
x-ms-traffictypediagnostic: VI1P190MB0397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1P190MB0397292A09918BBE7DA2D9AD95E90@VI1P190MB0397.EURP190.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03283976A6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39830400003)(396003)(366004)(376002)(136003)(199004)(189003)(66446008)(66476007)(66556008)(64756008)(16526019)(508600001)(186003)(8886007)(2906002)(55016002)(7696005)(81156014)(81166006)(8676002)(52116002)(4326008)(66946007)(86362001)(8936002)(4744005)(33656002)(110136005)(26005)(36756003)(956004)(2616005)(44832011)(1076003)(71200400001)(5660300002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1P190MB0397;H:VI1P190MB0399.EURP190.PROD.OUTLOOK.COM;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: plvision.eu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2HS+krweyWQ8CRbe1o5Z4+PTMFcQuaPa+dJwlwY9LKuIVIi1rFPpt7Qbcby3xsV5jh3OU1qng2vNvWmk2aD6F3fBbSjC0ulZmhaxvSUgnidrWMNiq26LkUdzM5eO002Kzy4BtnURkaHHrG1kUlFDjV+PyS0NEyJLjJvTxzpbeCmBPuX5UmchrTC5JXuEMLLnSd35TBcmAfLXrIhbifoleF+lKWKQZp6ew4nWeEQbyucA47qtKIrCI+a+u5FFp/Y3S3SWdXbZ4LQj8yXb9wYJJAnvJDzfYHGDTndiAllKA7148I7XOuG7cfUAUkbyvvrTx4Yg+mxbB9SKhQBaHpatz+J5GnUgS18HdYBpFWkRT3kprvLpeawMEfFdPkjzo/Stc8d1czmW6PKNg5m9KtWjIWszFGj1oLdlavYTXWllI++NHwyjEwNQG9xsIsRv1W2
x-ms-exchange-antispam-messagedata: WSH3fv+ZwPPnMU5akZXuHueLJlqbNZnoycg8pu9tx7AmZsl6gdyf09IlCdz+4idiVvBdVVtdglMSxcg/QGw4yCw0dx9+gB1hIjdyhtrZeXpyhvR9bIKsUy99NaO/Mpf4Z3OiVSo4J6krPSP3zjyD/w==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1462DB9A36CE444384035ADE6DB1B14A@EURP190.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b30180-fc95-4b6c-6bde-08d7bd6c128e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2020 23:06:56.5143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R3IscuNb/pV1mazkPCPRnlB3lxIPo7JG1m3S4xqbUNLIIGoejIcKH49dqLbmh/bYr34wm8SfCugS+/YUF8j9HFjFbmUrG46WF6mdDtqIuqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0397
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just softly ping if I sent it to the right direction.

On Sun, Feb 09, 2020 at 11:20:30PM +0200, Vadym Kochan wrote:
> armada-ap806-dual.dtsi includes armada-ap806.dtsi which describes
> thermal zones for 4 cpus but only cpu0 and cpu1 only exists for dual
> configuration, this makes dtb compilation fail. Fix it by removing
> thermal zone nodes for non-existed cpus for dual configuration.
>=20
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>  arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi b/arch/ar=
m64/boot/dts/marvell/armada-ap806-dual.dtsi
> index 09849558a776..fcab5173fe67 100644
> --- a/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> +++ b/arch/arm64/boot/dts/marvell/armada-ap806-dual.dtsi
> @@ -53,4 +53,9 @@
>  			cache-sets =3D <512>;
>  		};
>  	};
> +
> +	thermal-zones {
> +		/delete-node/ ap-thermal-cpu2;
> +		/delete-node/ ap-thermal-cpu3;
> +	};
>  };
> --=20
> 2.17.1
>=20

Regards,
Vadym Kochan
