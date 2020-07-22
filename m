Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA39C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B5B02077D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 00:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ecCC2CAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731481AbgGVAfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 20:35:23 -0400
Received: from mail-vi1eur05on2081.outbound.protection.outlook.com ([40.107.21.81]:65376
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726959AbgGVAfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 20:35:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YdOel4RtHB0R1WiwlClSMcwaPwmiqDjmStmpeI6bU0vIP1t3h4kEHhzUc1AT25AnZm/QcYe9usjgxEjOYqVubIm7PRp0wrnSjHAkw4JvBXCDrhZISa11HyGSyIQCz6eIH6U2rzgM+9KwhstMjCS6VmrkDMdUqihkUdq8Ohxq30Se1fueelXFcfoZ65Mx7nDKL8dYNCrg+SbQP1QiIYs9lI6GGG9N63aFlIo2rhEj0WUzfHSnIh6Bdbd/vYWXw8kGgam8sooZnjlSU6zfyeFIERwXaShyUp+hV+n3qgxsKNIS0QpA+IxU8LFcVEjtZOItT24zhldqqPvj82fIns7OaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO0I+3zBYhdqZObLH78CyxHOnLQUQ3PHsXsCJJ1gKU0=;
 b=ZEnLw++Z+QEB4ieEx6j3kiKSRPpDUrZhGTupXp8fUJBB+T0H9T05alH5Ws0hOlvHp7nFJbOQbyLiRcYW314dMzmZg46pK3gR1PTjoTDAm+fl6PqSERg5lNjQdVug116F+dncXGqqYOjQWhRMe/XMs6zw1WPxB4TTud+mviaRAmloFF/f9vJYw7vRvGU2xtIOC0W8jKG3GnSzunk0fT4WKHU1644vXyJP4wR+PTevcJA8Xft8mNN9rvtHMtz+XUSA1jvm6Nd393k1yYOGFYVu25frITVcJxPYz9sX42JkT08OannrSEN+LLriSgLFpXBPiLUvz5rtJo91jUib72p2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bO0I+3zBYhdqZObLH78CyxHOnLQUQ3PHsXsCJJ1gKU0=;
 b=ecCC2CAylklNwapzb0PTYOnbkB5wvqqRAx+f9CzX+jGdeEIBL5w9ZhUYxLp9fqhCetkl2sq5/LvnnnP63ZnxcV31m4Q3S180+B9Sea1zvjvLm0m1NFq48YOi56QJJ3stnzJ6JwuCJDUFBKMIfD6E63O2w+PB6AoCd85kH/QYMo4=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6440.eurprd04.prod.outlook.com (2603:10a6:20b:f4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18; Wed, 22 Jul
 2020 00:35:19 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3195.027; Wed, 22 Jul 2020
 00:35:19 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH v2 4/9] usb: cdns3: drd: return IRQ_NONE explicitly.
Thread-Topic: [PATCH v2 4/9] usb: cdns3: drd: return IRQ_NONE explicitly.
Thread-Index: AQHWWP1GkjzuLMp17E2g/1js/DaXxakSze2A
Date:   Wed, 22 Jul 2020 00:35:19 +0000
Message-ID: <20200722003509.GC5807@b29397-desktop>
References: <20200713100554.28530-1-pawell@cadence.com>
 <20200713100554.28530-5-pawell@cadence.com>
In-Reply-To: <20200713100554.28530-5-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 741e78ce-815a-42c4-bd1b-08d82dd71c89
x-ms-traffictypediagnostic: AM6PR04MB6440:
x-microsoft-antispam-prvs: <AM6PR04MB644017CD95C23A50E755217A8B790@AM6PR04MB6440.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:758;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WJVp0a9XQkIzXabJOModUPoN/KLYU0l4FA0hsWz/jYYRuLsWV3X//wrLuwJEBUd0hhbfXYHhmN0o2mkzKZ3b8tb/YAiCVTV2VFy8Mb0Etjah3Kx+4T//MIMNOKFFYklGelsQEYux+TB736ysBKoKPRhYyoIuMLoDn4tnMOE/DmZwr/HnB/dn/QXEgODJRZ3b9tlUjRrVpjLy/Cjd45WrrGUTPFAR61I5ro6gko/seIVc0Ql+TYIZRtxsOHg809vzNF1pnxSvqeNAzJw9Ms2hYIpFZmj5ae1+WrVJYeXwL8UZCx9N1E7if6Fz/1nTpvYNoAOidH8AUVUY7K37u85ChA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(39860400002)(396003)(376002)(346002)(136003)(366004)(6486002)(33656002)(6916009)(478600001)(6506007)(4326008)(7416002)(186003)(53546011)(26005)(91956017)(76116006)(64756008)(86362001)(316002)(44832011)(8936002)(71200400001)(33716001)(66556008)(54906003)(8676002)(2906002)(4744005)(9686003)(6512007)(66946007)(66476007)(66446008)(83380400001)(1076003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LZdOvV3QD8L3NivkKntHFyVmCTzLZnSiSzSiM/h+o6C4w8iGycDI3UcS69i7s3fhiUIgM7oz+EWJWZKmKFgyMcAjzAxs0HSxSrMlHfIArRrilDF7VBkBCthdV+fNz7bvVxrXzoO00ptFFBM0maCHLqWJxuGwZIc9Wy0f84RvBKNwjkNsZVX8pgTgIHOSkIm8LTVzPYrYkLY2NZlSpIebc0ZXrntfV8XVBdr/0JmUxwV8cD03Qw+tnUWPBv8K6ip6/gjgPC9xtqsrWUgBtNeD4Wf519OudIRlWeqYGfr3iHZGyFaz5CLsnL1+GEEh/dnJjPI6weV2RjVMNETVRs45UxkfULaFfsbDN3msCf5Q7YdlnjOrUNsjANi9cnIPSSmeRFCtZGZKhuYg7Xvw/06ii+YftUyCMUlLxGX874cfp+nO7oJm6f6mKkVDeyt/+dUIGuK/91CYngW2Uy7gHh+enONlEUt/AvMv5FKZZ4AdxxxlHxAkBKjGO7dYXJ7AroyO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFFA76D02BD8514F8BE668F8ACDDFA1E@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 741e78ce-815a-42c4-bd1b-08d82dd71c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 00:35:19.2096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHa1goAKHJFNHmoEn8UIr39QBEpNe+TmdheKQZe3n9UeCGxgAuqVVQrc8lmLNp4gt3IQ/qDkctEwcCEq2adurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6440
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-13 12:05:49, Pawel Laszczak wrote:
> IRQ_NONE can be returned indirect.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>

Reviewed-by: Peter Chen <peter.chen@nxp.com>

> ---
>  drivers/usb/cdns3/drd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 6d2da504ad49..05a9f7d54c46 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -279,12 +279,12 @@ static irqreturn_t cdns3_drd_irq(int irq, void *dat=
a)
>  	u32 reg;
> =20
>  	if (cdns->dr_mode !=3D USB_DR_MODE_OTG)
> -		return ret;
> +		return IRQ_NONE;
> =20
>  	reg =3D readl(&cdns->otg_regs->ivect);
> =20
>  	if (!reg)
> -		return ret;
> +		return IRQ_NONE;
> =20
>  	if (reg & OTGIEN_ID_CHANGE_INT) {
>  		dev_dbg(cdns->dev, "OTG IRQ: new ID: %d\n",
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
