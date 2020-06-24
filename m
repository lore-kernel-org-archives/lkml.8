Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E86C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2471206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:01:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="ixIfRtbs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389574AbgFXHBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:01:36 -0400
Received: from mail-mw2nam12on2043.outbound.protection.outlook.com ([40.107.244.43]:20609
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387918AbgFXHBf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:01:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZbKwBKHbQZo+ehosjC00LJK5CE+/5qg2AFhxvSxgwjSyVMY07AFQv0s0gaqRYE7KwauHAwHBiXCdxeF7eFsm87CGVoYmSmLQ+ivaoCj30vWfz+3fP3ubo1Q8P+mPDpaRffWuapnCDE4FmJQgm04n2Ds/KrAEpn1S6uWdEiJXfD3jvt0vPQjG8f6LgpFX3hhzv0PP9uGYuQKMUMhi67ALpLQbkDrVegvh6nWaU2lnWmpTbVcLNLZqEqn4YQH/w9+t6hQBpfCNbDKQBIGG2u5j6rqnn37Y291XhD/eaAfNtRVOwv93r9PLCmOybZhEbouWuA88Owafjnjh80F8lIvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb7/tpZa8Nh0TJ/Rh10KTnugLRq114RmPqgyVgHV2FQ=;
 b=KaqBYZ0qIY1AVzPewDoLF827EY0PNe6S7m6WTonk6IC0Bmvp/AL06t5ROGXTnUlomYCxrYgW/U53smzQcWzt3LiY+lQi7/VT2QZ5f/ptz1DikQviSLMyKGVcL5e3eVhfDMKQGgRRgQ6LEAZCL0Uya6q0wfc2N+zB2aCQNdimKNu+RgCVbml6ajZwFhDGfqkJZoENz+Wpy1kZZdVbunosP+UCTF0A43RtSrt6SQ2i0HZ6YCMHAMkuZrleGFGj2pVgvXnPv7UZ4LAKqatBRw7DzdyDPRsiEFAs5xtx8d4GiXozp2emg/jh0bGfhaxMSH423YX0aXuVcs/5boJj/HVVow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nb7/tpZa8Nh0TJ/Rh10KTnugLRq114RmPqgyVgHV2FQ=;
 b=ixIfRtbsKKZfgrIbBOcWP2l1LJ1/k4esli9mNgerOQNvRA3v5BULBq2fEkWpBsLtrIqnNH5/WP3V0nR/cASBBPbbI4BNUaNkUcBb68TKgsdiNUNsLknqnZjmCCZyb4KS6AqO4uyNdEQYPgjue+kmrupIiIoHTlCH4knlYiblM1k=
Received: from DM6PR11MB2857.namprd11.prod.outlook.com (2603:10b6:5:cb::18) by
 DM5PR11MB1578.namprd11.prod.outlook.com (2603:10b6:4:e::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.22; Wed, 24 Jun 2020 07:01:33 +0000
Received: from DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf]) by DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf%5]) with mapi id 15.20.3131.020; Wed, 24 Jun 2020
 07:01:33 +0000
From:   Phu Luu <Phu.Luu@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Thread-Topic: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Thread-Index: AdZJ9S1kJPjPfiDsQxixc1vTUuV8Kw==
Date:   Wed, 24 Jun 2020 07:01:33 +0000
Message-ID: <DM6PR11MB28578CA6D09D13A07D7959D99C950@DM6PR11MB2857.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [210.245.53.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff91920c-e3b5-4519-213d-08d8180c6e13
x-ms-traffictypediagnostic: DM5PR11MB1578:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB15783DAD834CB3BF552254E49C950@DM5PR11MB1578.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0444EB1997
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nzUelbjQSKklYHhZDgoPCJz1C+hbiUJ7ovPdysciwBKWytjw3j/jpij0RMndINBEGkWhoDI8RP1ypgdMuqkOPvEs9tsJH0e5u/X48IEdHq8P0YlcHyk3UhqU6C6Kb8OxWnl+NwppAyr5ZZ+NHiXTooaCptIeCYnbeKoFOxv3gzL2p8nqAMnh1wlP54MG2f9OD5ENqJA20agRPVjcr2aGDWo30zjiklHdFKjK+kv0e2tKA9gHb5iKPG9UN2r3JwFVlDn+Wz66dvVpB0+cyKIqXIB6/NZ6E1lm7FvNShMUdXU4YOmDSKswL6jwyubdnyTa7jb0P1Jcx2rX4JNNZLmv1OatXLoe3K7GjEzjmjLybYTNADVJ+BlA3FF+nyX0TlCs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(366004)(346002)(376002)(39850400004)(136003)(64756008)(66946007)(66446008)(66556008)(66476007)(86362001)(54906003)(2906002)(71200400001)(5660300002)(52536014)(6506007)(4326008)(316002)(7696005)(76116006)(26005)(107886003)(110136005)(8676002)(8936002)(55016002)(186003)(33656002)(478600001)(9686003)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hbdKZx4rAMFWlHZdj6BXly+uHAKN7DAlh2ip59k3I/afgnMueIWHs2vvhhaUU5VLmNgdqPhjbAWjj3ks9lRrZYI9b8iwD9ofHP0w798ZBHk4TpfaNMWw3V6MU+2z7AT3XQd9tdhJl+ZMica/nCXG8phJ98Z+2JlbQI+WvBrnxVOPjqUymjz70fAB3rotiI8maeLA4Wgkcl6RZKq6JsU9zrH3UDW5yYJ3PpSpNLBHVqv9SZBEwSoMXypymSSXxNnYyZjAEq6LlGyyd5VuNPCuRlcWJuuFgAtW2sqB6GZFhmPz1BfJPBJDaMrAxBuNERsriXblMGXgs6sbD4TPdyJwhTi6rxu0+qar6xDpjB0LuzYSwJWNM/UTh3zC5c42BdpQVr2eCfzlz+ogymZutHjZo7RqY3ZWucxTHaC0hp0Yk2E97x44acBpkd1I7rxkm1yUMavLLPQIPmKZqinHQ8fMygGHMIK7f2JZkc7fq6sGMec=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff91920c-e3b5-4519-213d-08d8180c6e13
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2020 07:01:33.7147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: soZdCeCEnduAIXb0ZufRyn/nh8cwfoI9QY0XK94RPY6CYJP7BGlHqfAkZrF7T3QMqV1Z7wIdf4bZTntbt+NnfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assign the .throttle and .unthrottle functions to be generic function
in the driver structure to prevent data loss that can otherwise occur
if the host does not enable USB throttling.

Signed-off-by: Phu Luu <phu.luu@silabs.com>
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

