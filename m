Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72E3DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4834320DD4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 02:26:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jWwi91+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388297AbgFXC0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 22:26:03 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:49249
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387719AbgFXC0C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 22:26:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIp+S7T4Sl+RYxbcf3rwlrmVBfiAIt9QlYK9mQx5yYcMAfgq/ht0iKB8gWOcVpKj41BG+167VmX+BGtsQtLGtVOSbT3BtWXwqHou6kg0sSyiIAkgoTJnIuxF7D/J79W6qKTGvQZVZdBXBxBHf1qQM+GpUtln8/TgbPPxtzwZ8/o8G2A0rfiOj8J5CkAPFntS2gaTkj3whnTAnIXrWBq1rhgV9WmRBpfgEjWN7Zmfe5w7mrzlb+X6+oKo/ZiEmPvpP8rhrR5AEX8uTKt6TX1Wgx9kPNtHLofLGW4QcbG2/jGgSFHMixFLKfD/NSUh5JRN2ZVGebh8GnpXSoMlzH77Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU9cDiMtqOvhoArBDcGrVu7PgwcUM9jJVlq3xzSYTuM=;
 b=fBhDDBak6gDXJ5uWk7Gj8SdnsJcEneSP8l6hz2OkDAgSrIYQfldgF5Z9JZNzcIE3P1ZI8tJf7JTtoBjoggUkvlxVsIhhnw9QkiAX1CDBQi2nOYushGXCWHhZi5rjyLXL8RFZwAXC2St9OoMMcnmDlIz8qC3J1hHmhUWkwrkpfvvap6uvkHexBLpSZYApTQSPdKoElLc5sgIQHiJpOQPX6ZQwwsQRSYaDUtuS9jae4wW8rSP4yObccCbe5CrwPmm1pYfZEe6rmt7RvNBuT+Nq+HLHZIO4ioLAKjYymiQDgtIz7Ijzi1X6VK043DQH2lrK/TQHI5IoDeeZs0WFMUp9Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU9cDiMtqOvhoArBDcGrVu7PgwcUM9jJVlq3xzSYTuM=;
 b=jWwi91+6cKA6z69EPtB0ml2ml20JFX8PHuDrCcpip/rZKQ2jydbW2WxISVlkfWe1pJRQigt7GNrCvh9EUlzntmUA5lB4snDDdU54Q4SW6mBHfbLen3+7cJD1PLlh3qxAlJ5Z8NtAHaAcX36l8RBmmY2LA/ILoIjA3glHAndZ2IY=
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com (2603:10a6:4:33::14)
 by DB6PR0401MB2472.eurprd04.prod.outlook.com (2603:10a6:4:36::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Wed, 24 Jun
 2020 02:25:58 +0000
Received: from DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::444:b05a:a5:5710]) by DB6PR0401MB2438.eurprd04.prod.outlook.com
 ([fe80::444:b05a:a5:5710%9]) with mapi id 15.20.3109.027; Wed, 24 Jun 2020
 02:25:58 +0000
From:   "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>
CC:     Ran Wang <ran.wang_1@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>
Subject: RE: [v2 3/4] arm64: dts: ls1012a/ls1043a/ls1046a/ls1088a/ls208xa: add
 ftm_alarm0 node
Thread-Topic: [v2 3/4] arm64: dts: ls1012a/ls1043a/ls1046a/ls1088a/ls208xa:
 add ftm_alarm0 node
Thread-Index: AQHWSc7LwUF/uYH2J0qePoDw6vPXhw==
Date:   Wed, 24 Jun 2020 02:25:58 +0000
Message-ID: <DB6PR0401MB2438903D0BA7650CE4B136548F950@DB6PR0401MB2438.eurprd04.prod.outlook.com>
References: <20200614143206.24993-1-biwen.li@oss.nxp.com>
 <20200614143206.24993-3-biwen.li@oss.nxp.com> <20200623120004.GD30139@dragon>
In-Reply-To: <20200623120004.GD30139@dragon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f905141b-0a4f-40b4-a7f4-08d817e5ee41
x-ms-traffictypediagnostic: DB6PR0401MB2472:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0401MB247228B0FC08997C6B847893CE950@DB6PR0401MB2472.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2512;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m5VcHEO0bcn5lBgpDvFO3NZKMtazSoHjKdUfM/IP7Xqj0w8SFcT5/nEp0bk+s+qGodx+qgoKiJKPVFRRK0dIGAhz2iPyLO1dIoalDPopqPcDlBh3GykzbSGGSYvUwF9ZWNprd7a4yN2dq6bNn9lm6rbw8rhPqvemsxrJbUItUqOYl8l4Smu4kaSL47sL4gCep51GP4BsG3Zucg8gkKQ/hhGzfqinNXyMc/458JYiOveLZlGmZkttyz3Smgo7o+SzIJEAm9F05bZEM3v7Zo/85PfZgWfeY7UbsfB7FIISIw8o3X5p3Rh1rzQ0gLfge2x1RmEYMfeKsAXRXTGJFKZQYA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0401MB2438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(136003)(346002)(39860400002)(366004)(8936002)(478600001)(5660300002)(2906002)(76116006)(66946007)(64756008)(66476007)(66556008)(71200400001)(66446008)(8676002)(9686003)(7696005)(52536014)(33656002)(186003)(6506007)(4326008)(54906003)(316002)(110136005)(26005)(55016002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sfxdcTv0ZWzBb5bCxIg/GNYSNh2vurkS5Co4UfLK1z34oOsG5iZFVMk/u4vP82friiOYTsK6ZmNNLghy5atft0yRKxeUoBRTyLtZFGWrP4oSheXeY9i+OO6QfLLWAv9/vgvao44SP9y8DNIXp/wust5oQF4vE1aSVoZe1yX89W1wfCEu6tCUhivqQoqovDvPWNEXbalSQHQnXVgjkNQBITHcb92PYpXde27ohdpScBm+kTqNn0BPi2ZOmZkjdsNyNGVFEaut2MVvXuUx5SQVURwa967jWuKFUzVcj6RKylQDveGfRONYBT03KE61sYHPzFE/sr041YitWfspvO/4EG4Kc2LHmhGvQY5aUmIQjNPf0Ck6hmfxHJvRiLLBOLV9tURHGjBJRF35seKdap7c63/oAtXzctIxBQzI4dT/gSuO6MUf2kp9VKpY/gAF+gFimLDXIg7WJzNEqW3feIf04ARI+VtrqIrnxk/w2Pejlks=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f905141b-0a4f-40b4-a7f4-08d817e5ee41
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 02:25:58.4735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWY1XxLVBchHXW8LSGIKYAv1TgEKRTb9DlOLnlrl2pIbYW/NG4du2hhjPa78hrQCCXhuUbOIY2437hTWDbbu7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2472
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Signed-off-by: Biwen Li <biwen.li@nxp.com>
> > ---
> > Change in v2:
> > 	- use generic name
> > 	- use definition
> >
> >  arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 15 +++++++++++++++
> > arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 14 ++++++++++++++
> > arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi | 15 +++++++++++++++
> > arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 14 ++++++++++++++
> > arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 14 ++++++++++++++
> >  5 files changed, 72 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > index 006e544..4742efe 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > +++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
> > @@ -22,6 +22,7 @@
> >  		rtic-c =3D &rtic_c;
> >  		rtic-d =3D &rtic_d;
> >  		sec-mon =3D &sec_mon;
> > +		rtc1 =3D &ftm_alarm0;
>=20
> Sorry. I did not catch it during v1 review.  But we want to keep them sor=
t
> alphabetically.
Okay, got it, i will sort them in v3.

