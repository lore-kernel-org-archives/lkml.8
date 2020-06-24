Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9147C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3D7206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 04:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="J4UczAZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgFXELY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 00:11:24 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:6044
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725765AbgFXELY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 00:11:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jJt5thEfcgF5vpWKa8oOEXAjrpI7XjR/5dKnn9fF20K8YGK038JFCLyQG6SfyuZ4JuJ8YgR9TWQhsfbcNgG4N2gKGs81qoDJSvpzozj6JvdtOwxBHGOsMdu+Mn60uW1QtAnFYX44NueOgVZg9wMMfBFHU2SG3plTdTlwwRe9BSmQTUnH0k1kqG2gGxsEUlB6edJwskHBS66IoLkw1EtiLkSwMkb+V2rMKYiDhNf8PAEipeITctZeJlJrWKjapSg/Uuvb7xW61ftND95myYK/MEC77KbqQZP2ksJJGgvSUtUOE/ER1pR0ymcm7Q/p65laPpH4ufeNviYyRROGJMhMvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cChiEodZ37LbgTycXSumitRchrEaEVKQibiyX3smQ5Q=;
 b=cLor/IASFdQDjySwH2DPv3gmN0vS598jAePkQ/lTnKm8AvKOWdaoUIumnrzs3ed7Rt9lxnZ+CvDdGLrRkwkfdANQ4RHvJIS4/oD9Dq8gIqaT4/hlBuphcO6cX8+0cME2dKAPxYtz/lpX5RgsoRdPYBSVDcrsM/0qJuuMh7xg/ZKUuu90e5NP6JoaBHtKb6U/c9TSj630CbBquXyVpOIM+a/J2A+IJDhTWAl1hiHCbRgqsr8lMwstaPkwLrYv6gx3yC0tVm15/xns9opskqCK1eEIKoUVbheNwptDFQilTojd9jFK27CCqbkpk+Yr0PN1JzhRr/JZeMZRQBN/RK+IwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cChiEodZ37LbgTycXSumitRchrEaEVKQibiyX3smQ5Q=;
 b=J4UczAZZFlmf2DCJ6z6dRZXszsEsHF5mM7XbugOIFg2odTnJlQEId3uJvyhhixCBQvKW+KyyRIWuDdYaS/2/pmIaAVbsSjT9OTIvHdnjwOcUUbR8tKzqSUkYHEwAC7Bd9LmmuaVknvYDQxL8A+IHO30BQLOmERIeyaa//z8Zq7Q=
Received: from DM6PR11MB2857.namprd11.prod.outlook.com (2603:10b6:5:cb::18) by
 DM5PR11MB1483.namprd11.prod.outlook.com (2603:10b6:4:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 04:11:21 +0000
Received: from DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf]) by DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 04:11:21 +0000
From:   Phu Luu <Phu.Luu@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: Subject: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Thread-Topic: Subject: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Thread-Index: AdZJ3Wh0Xts+vQ0HTvangZIlpNEkbw==
Date:   Wed, 24 Jun 2020 04:11:21 +0000
Message-ID: <DM6PR11MB285755DFFFCFB60E2BE09B369C950@DM6PR11MB2857.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [14.238.24.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1bf86727-9f8d-47b6-83a0-08d817f4a6fb
x-ms-traffictypediagnostic: DM5PR11MB1483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1483CA6C37799BE45BE37BDE9C950@DM5PR11MB1483.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Anvf5FWKzIxYQA/n6SvGYMY7JigFqxXylSHzFU8z76Acruxqy0LpaFEo+riaMc4wOhvsDsaUHF4MWilFwr0gFV4W+qVmnhQK39zwZg+RArEipeHbWRbVfiZgAxdQSobuzTxP1kYMq+6hW9bOA3WREmRhdWCLn55tnX3jcJDjHcHLWtr7AFcTHbp4q4oNG0DCGUx7ipyoXj0+pgM0+m8wyY0EvDizPgNLCYK8nnqYO+yTyCX6QJH4iHo0sJyZnD9Ho+IcpH3Htyoxprt352MyEJ1mu8K0mgTOSnU7BdVBEaRwlJeabPRZdxDQ+Utjb48xaTpJX5LWoJTSD8IogpL63RkPZl1d5+qBfW8WIl5h8fPQb3edd1z5TIQjFnHgvbYw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(376002)(396003)(136003)(366004)(39850400004)(316002)(26005)(66556008)(64756008)(66476007)(66946007)(7696005)(54906003)(33656002)(66446008)(110136005)(55016002)(71200400001)(8936002)(76116006)(4326008)(2906002)(8676002)(107886003)(9686003)(52536014)(5660300002)(186003)(6506007)(86362001)(478600001)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pYkuoZHAGbp2Jrn7EqbQ8w5XtVfd2VOU2Js7oPBXln+smLmjXmXDbSiC+2U1piuevbJuvuMcy+WBDO+XTjiOqVHBQYlLQz5ywRntXZ3cB3ICtcFZM/LkbTs9ourPbsvlEMp2UiyDA8BqGuzRhovW4cduMdvLLSCqV5mJdIuZogkWrlAADgvGAyc2eAK/HyD9W4J13YiUggD89yRuScaJMBzBW3rxRuwCbk4RYfXq5zW3wNctseVW+Phsp155lhVcF2rY5T7inzGD8TTll3yRlEhzmKyR39Io8UzQwQ70zxKSJ+gscTlX0HJ5PvVFBMC7I57KfCtg4v/5LnxfKCwz6kLO5qMF8gjYxW4EtUyElv5hwulPojp6f5jhsr2pIxGiqHR8LxrSYwVOHLtPnnm1t89s7FOgpp5s+tZOd+Jq9FAxcHZZp7P4s57v6BeRqL99z1FeV7JW8NTTDQi7BdtuDrZVIpyn7QE6GlBHOmpXf04=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf86727-9f8d-47b6-83a0-08d817f4a6fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 04:11:21.3395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EInvtvqZXP+IgLVBn/UY1AJQ/VUcuMjIdc08oenS7N7yJkrOtGncKV8hmqi1QrPEzhKXywD47NB6wep3acHAUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1483
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the .throttle and .unthrottle functions to be generic function
in the driver structure to prevent data loss that can otherwise occur
if the host does not enable USB throttling.

Signed-off-by: Phu Luu An <phu.luu@silabs.com>
Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
---
06/09/2020: Patch v3 1/2 Modified based on feedback from Johan Hovold <joha=
n@kernel.org>
12/18/2019: Patch v2 Broken into two patches and modified based on feedback=
 from Johan Hovold <johan@kernel.org>
12/09/2019: Initial submission of patch "Proper RTS control when buffers fi=
ll"

 drivers/usb/serial/cp210x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index f5143eedbc48..bcceb4ad8be0 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -272,6 +272,8 @@ static struct usb_serial_driver cp210x_device =3D {
 	.break_ctl		=3D cp210x_break_ctl,
 	.set_termios		=3D cp210x_set_termios,
 	.tx_empty		=3D cp210x_tx_empty,
+	.throttle		=3D usb_serial_generic_throttle,
+	.unthrottle		=3D usb_serial_generic_unthrottle,
 	.tiocmget		=3D cp210x_tiocmget,
 	.tiocmset		=3D cp210x_tiocmset,
 	.attach			=3D cp210x_attach,
--=20
2.17.0

