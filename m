Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DECFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD1E20716
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="R8g2FIVw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgA0O1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:27:35 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:38533
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725828AbgA0O1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:27:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcJ8YOsr+MgNsZulCjgj5+b5tcoLX4Jmxh/441MaPPCD8RgT7PUXRajt33h/sDMKbRdUAEGC3CnGYIrJd/iQyEFXmWjAxbwRYBMiW5R6Nmb0Id1/YYN6uFKEhTBPTUIQtCxq5hGLi8n0fYcDiD7TEtWD1uZR/olfr93bTp1ehKc0fXGo606j+xT4G0UU8W2JjxS1Lwr/6NGlinjijvge9mevS6Oo0IZblVg+KMuDcxeQpkdWyvY8Zb194ASE3fqIWqFzr+549UzGnl83Gb7YUAYHIMAjhxpCTRK/1u14OPZ6kXl5gXg/iv1iyrv6RhD/GpbjPicrX/m42nesqDZOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KD2Q4/h6XGP/DalqA/JxOWpEjd4ULXrLedbMET6M3w=;
 b=oAjHqq8Hwt8TkUCO9wbLw2SVbL+jZwD9A53WtrbprRwN13209vUcwQTxOkFUwUvTMUf9uEL/G69+kxw8jgJLzHUr3eebt1aE412sgoakvMKrRdjdCvBhWbPxcIRWiL/yhdnbYnpguwpo0Ipb0BqK9rY7Nwyv94DNaeQE1XugK0+KQAirRZX3v+81Yp/qgwmHY7onkNb0M/YEgGKLm4QCRb7JGiehCDVT9JCHrR9gO0hJtZWIUSe7YK4RX//xrVRhPR8yNexu9Yx+XoIDFulXN5qZD69iM/+npJjHpP/deeEKuzk87VmZNA5hwAFyZXzugKP4MPljTIU84NFEjR8HOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KD2Q4/h6XGP/DalqA/JxOWpEjd4ULXrLedbMET6M3w=;
 b=R8g2FIVwX941V2NqbIRpg4GiLvDF315HKnkvkLAaRH2xD4c7JInXHusejBJSl0sZxnFw4ktynE3NvpNwP/eSEsRx71rxbjROI43vDvW8GVJtsE+mauySx4O3OrJq5WO/ZABzNJ5G+6K1DV8XDdBCOx3HrHGEnlQkdE01y7rNYDc=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3664.eurprd04.prod.outlook.com (52.134.15.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 14:27:30 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 14:27:30 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend Transport; Mon, 27 Jan 2020 14:27:29 +0000
From:   "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>
To:     "shawnguo@kernel.org" <shawnguo@kernel.org>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "S.j. Wang" <shengjiu.wang@nxp.com>,
        Sebastien Fagard <sebastien.fagard@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH 0/2] Add more power domains
Thread-Topic: [PATCH 0/2] Add more power domains
Thread-Index: AQHV1R3oVnys6XlKE0yxPQVJPt7+1w==
Date:   Mon, 27 Jan 2020 14:27:30 +0000
Message-ID: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM3PR05CA0141.eurprd05.prod.outlook.com
 (2603:10a6:207:3::19) To VI1PR0402MB3839.eurprd04.prod.outlook.com
 (2603:10a6:803:21::19)
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=daniel.baluta@oss.nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [89.37.124.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b424bff-6d01-4b48-c855-08d7a3350a64
x-ms-traffictypediagnostic: VI1PR0402MB3664:|VI1PR0402MB3664:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB36649EF4EE2F20B0DA3FB16FB80B0@VI1PR0402MB3664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(189003)(199004)(1076003)(8936002)(66476007)(66946007)(6916009)(66446008)(54906003)(81156014)(81166006)(2616005)(316002)(956004)(66556008)(64756008)(478600001)(52116002)(5660300002)(6506007)(2906002)(8676002)(16526019)(186003)(6666004)(86362001)(6512007)(6486002)(71200400001)(4326008)(26005)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3664;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bqR3CPGtQNW++dHR5s0aniS+/5lJg2SdWKmQlUk5sS5iEaMDoEjrj0yw9iKb+lrGt+zNPUyePYizgx77C96+J2AjBWjQv60eHdeeYQjlyp0gY8VR+iCra4jSX0TavJAK5dj9AFaPVDbwTgwAV5WVBOWrDTVW/lQdGGySm4t3GL4oZNhjIrGHn72RQ80s7JJlyoyamAa/0gsEvekocSsPw/LI3owMkzP3zoNFN/Tq4OURth7ON39ojSHFUQ8fozacw/PqQEXIiyL90xn1KhJ8fsITbQXuTQx2L4F5y5D/N/XPKv9N6emWe+/8fyYetrDYBZBF1hpU5ADMWGkONdBFUHA66/DK8l4/Go6DvDFWm9SsY21YclKvB+U3oVvht2oGvXtiate0OKMq2zv00cuu0i+o9k48nA5JX0hK5uv8L0FwlZz714CuNIcCcw0+VaHE
x-ms-exchange-antispam-messagedata: hR9pqWj94uqBS91/AzcZch7ndcH4CJUgC16+4IhbU/ozim7uNCTNDJ3enQS10YTKLI4yOBrSW1D5Y0FJmrSCo7w9TTqE7QLirtO+wKu0HfA1mbaQmKqnrrb3vTpS3KcVxM1D6zUfCDh8kgooqguuqQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b424bff-6d01-4b48-c855-08d7a3350a64
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 14:27:30.2459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S6GxhdEPpnHDMLdtROY8ssUC2yUjL4YdvyioVjxpB1bjztl10TrAZxHkkLJxQVlGZ3gjuUu8WfVEkriM3o69jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Baluta <daniel.baluta@nxp.com>

This patch series adds some missing audio PD domain and enlarges
the power domain range for MU side B.

Daniel Baluta (1):
  firmware: imx: scu-pd: Add missing audio PD ranges

Sebastien Fagard (1):
  firmware: imx: scu-pd: enlarge PD range for mu_b

 drivers/firmware/imx/scu-pd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

--=20
2.17.1

