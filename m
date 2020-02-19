Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DC2C3404D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15F452465D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 13:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="HAhH/4oi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727709AbgBSNA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 08:00:57 -0500
Received: from mail-vi1eur05on2134.outbound.protection.outlook.com ([40.107.21.134]:38304
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726977AbgBSNA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:00:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=la0EHMWSiuWU6omGKmdGj0YRMHnb0NbIJiIPg3Nan+8mnmyydOknMDQclLZ6Tuog4HrvPzwhqVGt/7lPtpeImAIV0Vt7ns2kP5yvfO2bduGeyPdIkGD3j0S3aqNKtPfnlpCu8y08y06hlh8ZB9TyqNZaCKK0JXo4ECdQPc3HuiJ3KwrFwuQvwG8DVmRbtTQFf5A4j08XTJ0N57DJ9PLkULs3YXrxYbc7aiRAzJgoGigJn2SAWXPAZ/3vleTorNWaW/7cFnd/wXqloFMeP9DFjHwcSghHKPagIaPamuXoOSbUq3PKQfwUK3ld90FCRnHfxCJFx0DOJkcs9+C4sGJxqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flafnqUM5TAMl6Q6Y2MahYf2phzVdjWl5nScu3j0lmY=;
 b=nAQDywjED7ReYY7BzgGeBnFlC0NExami6rUZBFJCyO7hYNSRohkRBYcjOQLlcGbtQkay/AKPi2AP3x5Zh4IV7VIN5zkL5rXcLQlt/31Nc3Lq2GAB/1hjj5iuqb567+r9fElwOwjwNH0MYP3YR2JpIzSiBFh6i0783NeGNduDAM9Hexb1RQtudiR+84xVIWca7Dmv7eu0L7iTwCp/5zb+n2H4rgMYJ30kZjVPkX/j4kmh7C4dg+6JOYfdd1tRc4c85FKzqFF7fUwB5zpp/xgRQjYICH78Jj/sMgzLqx4koVFbdANFM33RZkCqi22/CjJicg5uyp2vAA8JHw9AkJlMFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flafnqUM5TAMl6Q6Y2MahYf2phzVdjWl5nScu3j0lmY=;
 b=HAhH/4oiIKbW/X8JVJJuOjjxYkq7g/tyBtumuFTHiJEX56SENgusQcOoDhdyPZlu4wL6bdYYzGlhykygYASLKt8Nol8FUWiMu64AL0LOdg8wZGTR8ZeBSmPLXsuvDTGjjUD/TUsAkvqawlW7hu1epJ+nxMts0ZbXrdcgrQBU4Nk=
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6495.eurprd05.prod.outlook.com (20.179.24.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18; Wed, 19 Feb 2020 13:00:50 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 13:00:50 +0000
Received: from localhost (194.105.145.90) by GV0P278CA0014.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:26::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Wed, 19 Feb 2020 13:00:50 +0000
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
To:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC:     Shawn Guo <shawnguo@kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Igor Opanyuk <igor.opanyuk@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/3] ARM: dts: imx7-colibri: Convert to SPDX license tags
 for Colibri iMX7
Thread-Topic: [PATCH v2 1/3] ARM: dts: imx7-colibri: Convert to SPDX license
 tags for Colibri iMX7
Thread-Index: AQHV5yScuXrzcAy26UKODdzBFjLcog==
Date:   Wed, 19 Feb 2020 13:00:50 +0000
Message-ID: <20200219130043.3563238-2-oleksandr.suvorov@toradex.com>
References: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200219130043.3563238-1-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: GV0P278CA0014.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::24) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.24.1
x-originating-ip: [194.105.145.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a0c2a25-53f3-42c3-4a1d-08d7b53bbedb
x-ms-traffictypediagnostic: VI1PR05MB6495:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR05MB649589D220C72FC7E3D86D32F9100@VI1PR05MB6495.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39850400004)(346002)(366004)(136003)(376002)(396003)(189003)(199004)(16526019)(52116002)(26005)(71200400001)(8936002)(186003)(8676002)(81166006)(6496006)(81156014)(7416002)(44832011)(6916009)(6486002)(1076003)(4326008)(86362001)(956004)(5660300002)(64756008)(66446008)(66556008)(2906002)(478600001)(2616005)(316002)(66476007)(36756003)(66946007)(54906003)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6495;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VAJcDoAxqC4nmGwloqMuQwEyPKG5q15etpY0nMISwLNixsf2Y/cFkFRlj9tBNgdw5SDHOXeLLSe9avurMQKTLxffx8Tveh8vdqq0QMpnTyFJkHmh3X7KJYtTtm2fnWG7UoSgmJGxEwgdHkmMozImEq7BhI45SlAmMEI17iRvE6ZjY1c4rzSM1TaMxSqa66MEfv25wbdvTvEleoPQfBMCbEitL+ZkguLQhNwWgqbYYmGWzjMNyJhEYL6m+6PEH+UqfZ4kzoFddhZqRpZRXVuBLB6V1skmsJ3uZXn0be1S8bc9e+1ptcDlUna5+bndeT4Bs+gJfuVOq/oQG2xTinZVbu21nqn0kD0vI536MHJlkgRdaRwyAWTz5fAq7hGnIZTZsruKm3MvVUQZ+tjm8KOqJWYUDtKgQ6ShLyM7FgS523w0sALK/xv6U/1eixh2U+Ru9+ufhqBKnqLyLKjIATFAIDnsqltMKPdBuxzUSLiIJCU=
x-ms-exchange-antispam-messagedata: xb9MjFNO84WEqjFYNh2u+hpi9nfl7PopDqzzPHE5BKfGGbNhOZpkTrXV+gw/sNI6wf2803Le/ov1D4yJSHCov3KbQaX9dSKJlvFaO3BO/ZoeJBPIQXaVOVRBEil6Q1Zq/QWIzzOZp5EM/YCkEteFQA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0c2a25-53f3-42c3-4a1d-08d7b53bbedb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 13:00:50.7493
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SGXmxO85q0GRL9DYqGz+Tih2nalFPObGAIeLynfsjvWFPMF77tq/ujzXisOY7oAXJOv0CEzUJnYogMCI7MWVc7lX6froA9QblvIf889Vy2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6495
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace boiler plate licenses texts with the SPDX license identifiers in
Colibri iMX7 DTS files.

Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
---

Changes in v2:
- Change X11 license to MIT

 arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 40 ++-------------------
 arch/arm/boot/dts/imx7-colibri.dtsi         | 40 ++-------------------
 arch/arm/boot/dts/imx7d-colibri-eval-v3.dts | 40 ++-------------------
 arch/arm/boot/dts/imx7s-colibri-eval-v3.dts | 40 ++-------------------
 4 files changed, 8 insertions(+), 152 deletions(-)

diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dt=
s/imx7-colibri-eval-v3.dtsi
index 9e9e85c10acb..20a82b1c2690 100644
--- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
@@ -1,43 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-2020 Toradex AG
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
=20
 / {
diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-c=
olibri.dtsi
index ad7536da4313..e078487a1347 100644
--- a/arch/arm/boot/dts/imx7-colibri.dtsi
+++ b/arch/arm/boot/dts/imx7-colibri.dtsi
@@ -1,43 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-20 Toradex AG
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
=20
 / {
diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dt=
s/imx7d-colibri-eval-v3.dts
index 136e11ab4893..699b9dda2fb0 100644
--- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
@@ -1,43 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-2020 Toradex AG
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
=20
 /dts-v1/;
diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dt=
s/imx7s-colibri-eval-v3.dts
index bd2a49c1ade6..ab139266ce23 100644
--- a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
@@ -1,43 +1,7 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
 /*
- * Copyright 2016 Toradex AG
+ * Copyright 2016-2020 Toradex AG
  *
- * This file is dual-licensed: you can use it either under the terms
- * of the GPL or the X11 license, at your option. Note that this dual
- * licensing only applies to this file, and not this project as a
- * whole.
- *
- *  a) This file is free software; you can redistribute it and/or
- *     modify it under the terms of the GNU General Public License as
- *     published by the Free Software Foundation; either version 2 of the
- *     License, or (at your option) any later version.
- *
- *     This file is distributed in the hope that it will be useful,
- *     but WITHOUT ANY WARRANTY; without even the implied warranty of
- *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *     GNU General Public License for more details.
- *
- * Or, alternatively,
- *
- *  b) Permission is hereby granted, free of charge, to any person
- *     obtaining a copy of this software and associated documentation
- *     files (the "Software"), to deal in the Software without
- *     restriction, including without limitation the rights to use,
- *     copy, modify, merge, publish, distribute, sublicense, and/or
- *     sell copies of the Software, and to permit persons to whom the
- *     Software is furnished to do so, subject to the following
- *     conditions:
- *
- *     The above copyright notice and this permission notice shall be
- *     included in all copies or substantial portions of the Software.
- *
- *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
- *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
- *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
- *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
- *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
- *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
- *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- *     OTHER DEALINGS IN THE SOFTWARE.
  */
=20
 /dts-v1/;
--=20
2.24.1

