Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4D2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE578207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="npR4vHsd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgFZEYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:24:23 -0400
Received: from mail-eopbgr760073.outbound.protection.outlook.com ([40.107.76.73]:5454
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbgFZEYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:24:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzjAmdGc1ZhgxNdHoCBkKl5eOBP/dXosFrJPIwf6RkXkAcQ/zWGwTNBBgkQMS4oroE1pnJuuBAj3bk3w+Pnau08+qY50k4S7K/s2P66SVssiZx4GI3ejzhwG3Foy5mIJG42esQh0Wm101N0bxUOSFuF4BUa65cv9HnG1hwOTvFjdw+J0hgUVkiRM2xNQKoMPWw6eDGGUojDWFEouV7ob/mgwt4EO/qDpQaNziffdusHK+l759SnS0yYXyTSt+DLGPUCCZ9H7v6eMMywOJzC7iJ83cVnfedjNl34I+60FMDMv/NvfgJYGuNYCWuCkv1CjTkKsypsMCDBjSC2eJdiepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IXCBzEaM3G/P/LrVsBfVcupd+Kl8FabZZP0BBPkXB8=;
 b=TuaMYNWdVUWFANMZIz6a88WV9e/ugIGmHuO/h6rVQhmzxcSWBNHUHdJ4rJLaBAgJg0h7mVNO4sN093TRQVCkTClAiwtpaefn40zAGGD0BNeIyJI693L25j9xo19jnQr3mePFT85qtGjzX/A93iT8DEMhn1ffr0p/d5cOh3HkjLta9VgxB2pkWiidwgZGt3NXiNQU7yrizBjQjONI0tBttNew8AOcVSz7+IlwE+/CbuFCdBYC/q2/yxvhCZUCowI5R9bt1na6ixD4uZi4DLzGjymZB74ySeOQAOjxXRTxxYIyAQZuMludi2No3OoZA1DPZtYIBCzpi2KARc+IdNeF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IXCBzEaM3G/P/LrVsBfVcupd+Kl8FabZZP0BBPkXB8=;
 b=npR4vHsdSlT7T+uV3MIrBrm3Zeg1F87jrVpS2S3F27VBzBcW+V7by2F85Yqac2HN7vtTbRgnwYleP8cCga7K76BOPZ9LfRapN1UZPkXPdOyd/ff2jyYymO+xKGfAWd7u7UdOSqy+ucaTes9NwI+bmvyrjqvo3GgvYhtcpsIvXPM=
Received: from DM6PR11MB2857.namprd11.prod.outlook.com (2603:10b6:5:cb::18) by
 DM6PR11MB3290.namprd11.prod.outlook.com (2603:10b6:5:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Fri, 26 Jun 2020 04:24:20 +0000
Received: from DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf]) by DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf%5]) with mapi id 15.20.3131.020; Fri, 26 Jun 2020
 04:24:20 +0000
From:   Phu Luu <Phu.Luu@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>,
        =?windows-1258?Q?Ph=FA_L=FDu_An?= <luuanphu@gmail.com>,
        "hungnd3@fsoft.com.vn" <hungnd3@fsoft.com.vn>
Subject: [PATCH v3 2/2] USB: serial: cp210x: Proper RTS control when buffers
 fill
Thread-Topic: [PATCH v3 2/2] USB: serial: cp210x: Proper RTS control when
 buffers fill
Thread-Index: AQHWS3Gpakt8lWkQAEeJtxJ+vFX8Lg==
Date:   Fri, 26 Jun 2020 04:24:20 +0000
Message-ID: <ECCF8E73-91F3-4080-BE17-1714BC8818FB@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [59.153.237.173]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 03ca8aa3-63a4-4581-b8ae-08d81988cbfe
x-ms-traffictypediagnostic: DM6PR11MB3290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB32907D91E00886455A8E82329C930@DM6PR11MB3290.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1186;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ko4KLs3S7Kr03Dy7MAigGAE8jn/6ptWmLgacx4qVgpoZsC3nKsDf8/eLc1B/NEsSed9hq9G3EnbDDu8pA19GohhI38T1UYchbKytD4wMYV2DIhNwx/r/4lZuOBZT9wHOWGi2fcoOdax4aQP+nSo8hYAqKPtKBgyNylHuICKqEgI6AJb6Ii02xc6seoE+pmZQ5jj8cW+k3Gh83Lnxd2wlKJPQY8R6FpS7pSYwx2C+PlSRT3eFGBw7yfHRMZLxMb96pYfrgni0ApDbSpgn7wUEmxyAwfA9Moz0I6r9jy8SUHxJvzrhx0URSTDzQGHQecSN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39850400004)(396003)(376002)(366004)(136003)(478600001)(71200400001)(83380400001)(4326008)(5660300002)(6512007)(36756003)(8676002)(86362001)(8936002)(33656002)(6486002)(2616005)(76116006)(66446008)(66476007)(110136005)(66556008)(64756008)(54906003)(2906002)(6506007)(316002)(91956017)(26005)(186003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: PL5Co+lPtiyOqcofprsiIRdX4gt/8Hh1hvbDF5uR1C2gX9cqOgIlnqYWl7TM3RNryvSPA7BsI7o7DQ525mnhUEuN8eOV7TTspXlzEWvOiD1dnZQV/ixjnhOPOuq9g/CSVVmdp6An2iqNqexv/C4+OScxslOjH3m21qdvGpeKE/xcQTms7TGNsbMFW/UGrW8hURMhbep4rOMSLl28kpM08cDkgMNgLg7h+HTHZ+1hYdnhd+lgOw/5pzs3E/5DIeWoQ1PZwCOH+5DC+Z6FG2xkWxQIwXl5g4ytn6cP8GUR9ESm13CWLUL81gTYdeOsSJCH8271oZrtv8NYTsvXemiyzmaAbbZSlYKSYoswoSKEM9D4HwKTrCjrlKsZ1ioGYRg0ZXYMiM/YydEzJG/aq/TjiCuSjnq9sTBXAyFAdOCfwWpvstEDjSNEYvze2sp552kP0hkClFs/ecqFIzYPjdcEX03B4evLxBri3hHjYPHT2wMkbV899+XFr0ckAbp0jeYW
Content-Type: text/plain; charset="windows-1258"
Content-ID: <248726EE79415944BD0B7ED5144C1F9D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2857.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ca8aa3-63a4-4581-b8ae-08d81988cbfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 04:24:20.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RH4hRQQY0HYfB446Y6b00+vyyiGkMuXnzFD9vyPkF+tfRJMNp9gFi+4SbpLZzcxlpJzYJIIW1r+A75ZLelo0Dg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brant Merryman <brant.merryman@silabs.com>

CP210x hardware disables auto-RTS but leaves auto-CTS when
in hardware flow control mode and UART on cp210x hardware
is disabled. This allows data to flow out, but new data
will not come into the port. When re-opening the port, if
auto-CTS is enabled on the cp210x, then auto-RTS must be
re-enabled in the driver.

Signed-off-by: Phu Luu <phu.luu@silabs.com>
Signed-off-by: Brant Merryman <brant.merryman@silabs.com>
---
06/09/2020: Patch v3 2/2 Modified based on feedback from Johan Hovold <joha=
n@kernel.org>
12/18/2019: Patch v2 Broken into two patches and modified based on feedback=
 from Johan Hovold <johan@kernel.org>
12/09/2019: Initial submission of patch "Proper RTS control when buffers fi=
ll"

 drivers/usb/serial/cp210x.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index bcceb4ad8be0..091441b1c5b9 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -917,6 +917,7 @@ static void cp210x_get_termios_port(struct usb_serial_p=
ort *port,
 	u32 baud;
 	u16 bits;
 	u32 ctl_hs;
+	u32 flow_repl;
=20
 	cp210x_read_u32_reg(port, CP210X_GET_BAUDRATE, &baud);
=20
@@ -1017,6 +1018,23 @@ static void cp210x_get_termios_port(struct usb_seria=
l_port *port,
 	ctl_hs =3D le32_to_cpu(flow_ctl.ulControlHandshake);
 	if (ctl_hs & CP210X_SERIAL_CTS_HANDSHAKE) {
 		dev_dbg(dev, "%s - flow control =3D CRTSCTS\n", __func__);
+		/*
+		 * When the port is closed, the CP210x hardware disables
+		 * auto-RTS and RTS is deasserted but it leaves auto-CTS when
+		 * in hardware flow control mode. This prevents new data from
+		 * being received by the port. When re-opening the port, if
+		 * auto-CTS is enabled on the cp210x, then auto-RTS must be
+		 * re-enabled in the driver.
+		 */
+		flow_repl =3D le32_to_cpu(flow_ctl.ulFlowReplace);
+		flow_repl &=3D ~CP210X_SERIAL_RTS_MASK;
+		flow_repl |=3D CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
+		flow_ctl.ulFlowReplace =3D cpu_to_le32(flow_repl);
+		cp210x_write_reg_block(port,
+				CP210X_SET_FLOW,
+				&flow_ctl,
+				sizeof(flow_ctl));
+
 		cflag |=3D CRTSCTS;
 	} else {
 		dev_dbg(dev, "%s - flow control =3D NONE\n", __func__);
--=20
2.17.0


