Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B4FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3459207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 04:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=silabs.onmicrosoft.com header.i=@silabs.onmicrosoft.com header.b="irNiqcbU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgFZEXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:23:02 -0400
Received: from mail-eopbgr760081.outbound.protection.outlook.com ([40.107.76.81]:44595
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726585AbgFZEXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 00:23:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oElofxOc9UMkAyCEtp+CgwHqjjFO9RuLDR8s5ImRoc8hp1Xe4B3h4whmwwB5KDgd7tKFmnGETIENq/m/8+OYmOyT/V4jsLCTlQM9oYalF400D9LdmDXarmTOvrIXtfiym0wXlUb0OBgfQ3w+Z3BakW61AjAswHMl48lGjfJwgq0doDv7N8Ymifpm/ecMywnOmz3/BaqQxD1Y9wkdDbaMW/Tc9QgRoz1wEHt6pNfWoenAe/MGts3fVX8jhzaRV+7VPrW1jGZ0umcPrbGbD/YrR0qexSvCYWWd6RB0VtGRwAgNmVLFJmR8MBp4O9SRVJP+xeGYMCuI4Aoh2rBUk6C31w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQEnMftYKj8Sm4rMSi6vw2QRA+FQyuCo7aGOneOVgEg=;
 b=OBw/go2vRD3p5tA/DcIN8LvT2o8T0wllMMUBKZe2UC+oIglCxp+5nhicxIhIjmWkpMzzEIDVn7q96PB6Evt9bpnvJpkCaXVeeFu1nE69YVstu2qEU6n3ZmXEH2z6Ele2GgC30qNJ3DLC8blC52Nnu7za4cXPPcSCDmCynA13njB6C6gS2Olr+GvA4EfGwghCONtTfsXjNS80hlu20+iNC68mqtbIb2nkt++82O8QGmY6WRnmtrB/xAginNzAecDlhcV/gg9U7Ootgt0PgvdiekpqmIDE0ej9XhpPAyn5ZcNJKRELqQBc0Y+wekjrd+fwFV3yNxNSdy9vSC4zkaBcyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silabs.com; dmarc=pass action=none header.from=silabs.com;
 dkim=pass header.d=silabs.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=silabs.onmicrosoft.com; s=selector2-silabs-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQEnMftYKj8Sm4rMSi6vw2QRA+FQyuCo7aGOneOVgEg=;
 b=irNiqcbUQ1NZSX48CvC/WjBQ2C1+FtKIzYPNqqJLEtqGz2xJTb+JiqVILXY5hGrdwsirXfIZm8Y6cnP6d4I6FRcXd+KOhQ+CeLQzYWU29lXWqJRmumXyNRkMrhaKGjR65Jy+TR8kO+XvXfkOg1myFdKfOUQCn1uGHcG0RmoOupk=
Received: from DM6PR11MB2857.namprd11.prod.outlook.com (2603:10b6:5:cb::18) by
 DM6PR11MB3290.namprd11.prod.outlook.com (2603:10b6:5:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Fri, 26 Jun 2020 04:22:58 +0000
Received: from DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf]) by DM6PR11MB2857.namprd11.prod.outlook.com
 ([fe80::80a:1058:250c:28bf%5]) with mapi id 15.20.3131.020; Fri, 26 Jun 2020
 04:22:58 +0000
From:   Phu Luu <Phu.Luu@silabs.com>
To:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>,
        "hungnd3@fsoft.com.vn" <hungnd3@fsoft.com.vn>,
        =?windows-1258?Q?Ph=FA_L=FDu_An?= <luuanphu@gmail.com>
Subject: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Thread-Topic: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Thread-Index: AQHWS3F5PdCoZ8YA8U+lTX0A20r8MA==
Date:   Fri, 26 Jun 2020 04:22:58 +0000
Message-ID: <57401AF3-9961-461F-95E1-F8AFC2105F5E@silabs.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silabs.com;
x-originating-ip: [59.153.235.166]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69b8adb9-529d-43e1-d8a0-08d819889b92
x-ms-traffictypediagnostic: DM6PR11MB3290:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3290B69EC84CAC042B5064D29C930@DM6PR11MB3290.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pQ2oQzLpAmmlpnYVp+qYluOVRWmgpFcgFbqVJmZDF62OM7uyQFDW2r0+cgXaJMMX8o1Sl6+e+e7g6azPklkfyVLM9U2gDQ62biorPCZbbkVsQySFiGT6lx+3nP+UdBEGHkl+glOp9S2OwwSfhpYFVV6mIU5nIi+OfvnS9mapLgpqhRWsny+VbsSbu6o+eWQSiMAjGL9A/OT0FUEo6fHZ+xSssnagmi1/gs2nwvxSgt6BoLU9KYaoXm94VzZYLue1J+r4NUFethBvZ+a4XMaJ4yVGNwWxWyXbn432HEAoVHgDaMwvzOzjp/RnJz7lX6xno6eOTZ3UfzwelXkfrO02BmgBqm6gZz8Ah0Jo9IJkT38cnmEPnQqNPVNdH198ryoT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2857.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39850400004)(396003)(376002)(366004)(136003)(478600001)(71200400001)(4326008)(5660300002)(6512007)(36756003)(8676002)(86362001)(8936002)(33656002)(6486002)(2616005)(76116006)(66446008)(66476007)(110136005)(66556008)(64756008)(54906003)(2906002)(6506007)(316002)(91956017)(26005)(186003)(66946007)(41533002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BM0T+CxE0rCPAPgcIE/cVmuWn+7CTw94Pr5WiH3jDkAcFvvwBeP6RnMPmVPG7CxmOjADmJES8pDdcIBGBmKNRKvuUK856BWg5GWFEU02Ey0a2dGtecLKTWle+W6zjFxuAQtJ/JRQwB2BKncJcJM+wO1IE2T7rjj5GOf90/8sAkAD6Zog6J6EkVrSeDkUQoFR3oPFjutOtrvAG/NlZym/nL5CAdfbHZj9K0AOCoopIrAJgzkyLyvRbIqcx2d26VOTlmtnTxSe8zidbSwnL9YLbcn3CYVpP025GvJPT3KFWiX7ZJbxkA7nIPRNI13WGGpe+TeV285IQog8mjil2fKcaDUmD2TWXuICn5BkBcADbaWoGt97onGUB30F/9CvWzA4qYlBxgmhis4hfq5Ah5FvtmJmKzLNql5uWYgMKCmBXBaGZfHbUfWaM5YjKScMoiWk+H94hsbYtno4z1TbgyuP0Dc2SLSSMywQWcDUP/zuZ1TK4cfqyb7Dsv38JMMbpmNc
Content-Type: text/plain; charset="windows-1258"
Content-ID: <BB73C7DF97CA8146B915C5B1FCA1A0C0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2857.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69b8adb9-529d-43e1-d8a0-08d819889b92
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 04:22:58.8404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 54dbd822-5231-4b20-944d-6f4abcd541fb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZOsopy6VsMOY2VUps7zh9Y+cBKgUvLw9AxIz03N6jlHwWaOxd8hnea41Zj76hcUwAjnwuDSK8WZQIkR2siec8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3290
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brant Merryman <brant.merryman@silabs.com>

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


