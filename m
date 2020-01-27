Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25EDCC33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF9F7214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 14:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IciBpm8G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgA0O1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 09:27:39 -0500
Received: from mail-eopbgr140048.outbound.protection.outlook.com ([40.107.14.48]:38533
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729126AbgA0O1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 09:27:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th9zO6ItB/YPJT2KBCc7g98213Jrm8JjyPBQ9feSP5nvczH16MkKGkzNNutPuQrixOcpLuJ6RUs5bsBUhLJUZZD5IHsWxYpwZYI+YdkKW4XwcFL3dhzfSNNxGnzx8zK1LPUBY5HJRfKJBoCC+xyJQY3QdQgGAYlbJxMUj60byfolatamT8fBbS8vEaUWqPVBB5bMX9GtrMHZWO9753KTagsg7ZSJpSldgLfJEu05UcUzLnRRajI6vmZnGhREMIiszRbX7U+vn9DQw5oIs4SuSt11dSk/jeOrW7piko8wF6GCn7rDDfhCIIxaVJXLODfZQ1IAUDBlsgwbUsMWt7GIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EifVznja+dtuuOzHbUidF1dUBXDHVn1DtC1pG30yJNE=;
 b=fVKeW8kPDfHc8bZlY2CQgRpy2yYShm4a0l4l7T11Pg5msw9rKTCjftCAycOglMdCNKI/YhbIDXZn0vxObM9gT4fJSxNAGeUGIjLeINhJ79NbE0UwdAy4zjawo2jJ8++b8f7btjcupLaQCmbTm0xN1OKzXgS5MUbV5KFJXmr54WWQfxfrp+EXVVEdZlJ61jDzNKakc7nwnyEXEGryxb+tutueJmVOvd2jtcaKPQx/bqj2eN3DfIj2XBmZEkxvbyVmXo7zOS631HpU3vn0VSvtoSnVGsQwWe+9h/i/mMpwKER2AAhJ4DhHxw/xsm1wzRdEmxLawOyEAcdGwBdK1Tb+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EifVznja+dtuuOzHbUidF1dUBXDHVn1DtC1pG30yJNE=;
 b=IciBpm8G/zWqqZsVpwEoYWVjoLdOmIuX++b0WOf1ylHXfnNxT0a6sDMV2HWSlIer2QaIq3WWN3LUk5TCnuRD6arD0LIEq/v4ug+1Q+Gg9gS3AC+tZNjfwEt+Xx9PcyM+zBSN9zY9q+fOJt2OavYumexGsyPV/Y0XGBglrVBs+gw=
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com (52.134.16.147) by
 VI1PR0402MB3664.eurprd04.prod.outlook.com (52.134.15.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Mon, 27 Jan 2020 14:27:33 +0000
Received: from VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1]) by VI1PR0402MB3839.eurprd04.prod.outlook.com
 ([fe80::8881:e155:f058:c0d1%4]) with mapi id 15.20.2665.017; Mon, 27 Jan 2020
 14:27:33 +0000
Received: from fsr-ub1864-103.ro-buh02.nxp.com (89.37.124.34) by AM3PR05CA0141.eurprd05.prod.outlook.com (2603:10a6:207:3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.21 via Frontend Transport; Mon, 27 Jan 2020 14:27:31 +0000
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
Subject: [PATCH 2/2] firmware: imx: scu-pd: enlarge PD range for mu_b
Thread-Topic: [PATCH 2/2] firmware: imx: scu-pd: enlarge PD range for mu_b
Thread-Index: AQHV1R3pM7J2DAQj8E+mhvmL3yBfgA==
Date:   Mon, 27 Jan 2020 14:27:32 +0000
Message-ID: <20200127142717.27570-3-daniel.baluta@oss.nxp.com>
References: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20200127142717.27570-1-daniel.baluta@oss.nxp.com>
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
x-ms-office365-filtering-correlation-id: 66fb2a34-a8e6-4e19-621a-08d7a3350c08
x-ms-traffictypediagnostic: VI1PR0402MB3664:|VI1PR0402MB3664:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB3664EAECAE99D91503AF9D2AB80B0@VI1PR0402MB3664.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 02951C14DC
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(189003)(199004)(1076003)(8936002)(66476007)(66946007)(6916009)(66446008)(54906003)(81156014)(81166006)(2616005)(316002)(956004)(66556008)(64756008)(478600001)(52116002)(5660300002)(6506007)(2906002)(8676002)(16526019)(186003)(86362001)(6512007)(6486002)(71200400001)(4326008)(26005)(4744005)(161623001)(147533002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0402MB3664;H:VI1PR0402MB3839.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:0;
received-spf: None (protection.outlook.com: oss.nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0wsea7bY/if/fLFNe+djDvqDCB+N2zgo3e88CKutNh7tLdJuhYAl0o9vKcnX5pAyJespyi46ddFEkqjD58Co+5KkjsYSygPp+DVc+fscGurTFktZUK1THwCCxbTN6i8WT5cad9BfMRDD5ECM6nn9xlRJ467LVZBqkEGORPERZHKPZfj+1UYW5PhtfgM7qtT9VeK7iBUSG+NthJllUcsFe5PIZnyHr9lw5iSW8xNId4CroQDRoAB+faxL0ePObtJmmgJv8vwKZJLQlYzT0DXuPtVLYXxFbhM3Dx68bXjAe0GErkEXZmFuZbptzy8ve6twiqKs84/M5hluGzVwrIr4xMfCCb3p5jEJT1Ig0zl0G4lJVWnvVtsAI9s/h+I09QO3G9pk65/ZBAyrinYBUaTTe5u8r2f4ArYBPl4tYLeGlijdV9ClLdC+kd1yvfvIZoiIinPhUWZ8jCBmrZkMzpI+7YdnCT7iW+y55FCJnHtFG7tvQDe7REajL2DCYecwhbFFsFM3G1gzvpgXlwiSMqspmA==
x-ms-exchange-antispam-messagedata: sBybwvvVlgawvN8BlTMpAgbcJkv/UZyDfiznQp7R1xUTxODGillM6gzkCyQtk1UuW5cQf6HT6zN28QUepNVnk/UOVFK0IljHTQKl1yeDztp4Is34uK0fDl8QXWilhiRYYdSqgLme4WdUMYaqCMshkg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fb2a34-a8e6-4e19-621a-08d7a3350c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2020 14:27:32.9000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgZmdKxbE8+2JKAYtmomqR4uKs0RJLUGEM8EwofpwpoMacizOEu/48XqrYDNpNDKQFcs0bp4SWJVbbM2iczCCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastien Fagard <sebastien.fagard@nxp.com>

The range of resources for Messaging Units side B needs to contain
all the possible MUB resource available: starting from MU_5B up to
MU_13B.
This patch is needed to enable MU_8B for the 'imx-shmem-net' driver
which allows two OS partitions communicating via MUs without Hypervisor.

Signed-off-by: Sebastien Fagard <sebastien.fagard@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/firmware/imx/scu-pd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/imx/scu-pd.c b/drivers/firmware/imx/scu-pd.c
index c10f63901c1c..09cfa268c6bd 100644
--- a/drivers/firmware/imx/scu-pd.c
+++ b/drivers/firmware/imx/scu-pd.c
@@ -93,7 +93,7 @@ static const struct imx_sc_pd_range imx8qxp_scu_pd_ranges=
[] =3D {
 	{ "kpp", IMX_SC_R_KPP, 1, false, 0 },
 	{ "fspi", IMX_SC_R_FSPI_0, 2, true, 0 },
 	{ "mu_a", IMX_SC_R_MU_0A, 14, true, 0 },
-	{ "mu_b", IMX_SC_R_MU_13B, 1, true, 13 },
+	{ "mu_b", IMX_SC_R_MU_5B, 9, true, 5 },
=20
 	/* CONN SS */
 	{ "usb", IMX_SC_R_USB_0, 2, true, 0 },
--=20
2.17.1

