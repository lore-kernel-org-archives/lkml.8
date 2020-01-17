Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B53C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098FE2082F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 06:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hhW8sdBV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgAQGKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 01:10:05 -0500
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:19918
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726189AbgAQGKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 01:10:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDAoWeI4o+gduK2ydpfUsaFGXw2WWrfoGdOkWF6R7UbPVyaLIP5YmrpZh+KjxQ+TjOsDVELLZzsujL+yERAnJU5P9pD2TwEnhVMM1RYNuc7fDx03gdlWc+87ZBh4g1OS5HepBiKkJS67p5k8e/6GKlYcKuAXLr4ZKF1abOX/Fnl0WKj45fY4ZQeojO2k20gaA9j4Elvl9rZlIFvXNz0PsNqRBjM1xhMrnVgkxQyu9xC9OZgJEaRlfMGg6cVwKQGEiVsdhQMm3qHkxvqAwNu0Prn7fVvppmiipmFJiE3wlCmpxhp2rKddzIMvEE2cehBrVuVD/Ut+jkMJk6XO7pjqcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krEU1WMTaCd6aWUb7IZWkt+zlbNLRbHPqg8zKdDrLkw=;
 b=MB7EYvedEurCpbw/X6v3Fdu8HuZiYOlKLK4Kx5AX8dpRGXfg5gSXzqpduYBYJ+JXHOc1DyqOMWB1t0EGmJxPD7EgOaQ9/H7XEFUWb84GhdkNJHTN+6g90TS03qYZ4jG3ZcQ+5/B4NwBexJNIKz1UwUh/HZn6n2c3iWPv31++9sOur7ETbu/UxqCpwCbvQ+NXFxssTtR28f5Y0QoYf7zzosKDw53Ks3EkzNdQcwANF+uXnkQFgUSLwm3OfRUsRDfRS6qDcwaSd2LmPJ5osfnfQuz4TvbgFs5ninud+nQz7l7gc3QC6cjNnIkb68rTOK5bjWSmDeB2BKrCH/KCQ4nAeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=krEU1WMTaCd6aWUb7IZWkt+zlbNLRbHPqg8zKdDrLkw=;
 b=hhW8sdBV/5Ys3cMir2WHx1Im5pjfTsglxeobuupT/jIVg/J5U63HSvHdjCxNZp+d/h9VTH1bEuxGKOjFnFlKqkfAe92TxGN4aLXjotqZ9J3itVRPw4g6A4QmWck3nTSA5M2WBye/fY1cttmxtOALyYJOZk9rzdRYRTOunDy7nn8=
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com (52.135.139.151) by
 DB7PR04MB4841.eurprd04.prod.outlook.com (20.176.232.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 06:10:00 +0000
Received: from DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca]) by DB7PR04MB4618.eurprd04.prod.outlook.com
 ([fe80::5cb4:81c8:1618:5ca%7]) with mapi id 15.20.2644.023; Fri, 17 Jan 2020
 06:10:00 +0000
Received: from localhost.localdomain (119.31.174.71) by SG2PR01CA0102.apcprd01.prod.exchangelabs.com (2603:1096:3:15::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend Transport; Fri, 17 Jan 2020 06:09:56 +0000
From:   Joakim Zhang <qiangqing.zhang@nxp.com>
To:     "maz@kernel.org" <maz@kernel.org>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "robh@kernel.org" <robh@kernel.org>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>, Andy Duan <fugang.duan@nxp.com>
Subject: [PATCH V6 0/2] irqchip: add NXP INTMUX interrupt controller
Thread-Topic: [PATCH V6 0/2] irqchip: add NXP INTMUX interrupt controller
Thread-Index: AQHVzPzAinimUXRRJkOyca2IU2HYbQ==
Date:   Fri, 17 Jan 2020 06:10:00 +0000
Message-ID: <20200117060653.27485-1-qiangqing.zhang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-clientproxiedby: SG2PR01CA0102.apcprd01.prod.exchangelabs.com
 (2603:1096:3:15::28) To DB7PR04MB4618.eurprd04.prod.outlook.com
 (2603:10a6:5:38::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=qiangqing.zhang@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5f039d13-a926-462f-d747-08d79b13e295
x-ms-traffictypediagnostic: DB7PR04MB4841:|DB7PR04MB4841:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB7PR04MB48411181C09C9657C2BCEF75E6310@DB7PR04MB4841.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(199004)(189003)(1076003)(5660300002)(66446008)(6506007)(8676002)(478600001)(81156014)(81166006)(6512007)(6666004)(16526019)(186003)(2906002)(36756003)(86362001)(26005)(316002)(110136005)(54906003)(8936002)(6486002)(66946007)(71200400001)(64756008)(4326008)(7416002)(66556008)(66476007)(69590400006)(2616005)(956004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4841;H:DB7PR04MB4618.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jKn32lrME+D/JTAjbmF4UurGHKG7hS2weqBhbC6lPHUla5eld6zce7kovqvmTIrCMb9+TGVCHuarIR/4cuOnBVikNX1F8qQl1F4a2v7PHY2bKRuAdCz+AK9ZBAS62XkQ8xLn8JR6lmKXF73RPWdW9rT6EUm5zca6exNIaH9OwalGCoaadippT2E59vGinwABSYAi/HeTQcp5OjbFONt0n+i/yzvZXqywpetoM6WIUqD5+SDG6MPdW9oujZeGvjUXnvetX/vXXKVYSSvphcKIYiYiWQw18X1JRR6xTskZ2fqfj4RPx69AApokKnKbXjfj3+9TvQMQICmcP62ngwhpN3K92k7kUP0HnvvP0tJA0kmgRE7y0+uZxnHV9BpLuu4eOSWV+FPXM6m3PIItPdxExDZ/mtxnk43GwxQUaYxklX+xQ9e0fhuoC+7xwO9UEu35L21/OroLUxBytWKAJ5Z0Yxv9nK8kfyY2mYJjlxfGDkSHPRgzx709CPa0SzixWiJf
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f039d13-a926-462f-d747-08d79b13e295
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 06:10:00.6867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MY0lIT3SnOkb9zVarVP31Y8+/2Bo0P8KUXAHQWFfOq0yExXGCuB5qJC7pF8m9hj52ZwzqhC5khJFBP0B+KWosA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4841
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set adds driver for NXP INTMUX interrupt controller.

ChangeLogs:
V5->V6:
	*fix DTC check failure from binding file.

V4->V5:
	*get number of channels by platform_irq_count() instead of
	'fsl,intmux_chans' property
	*update binding files and remove 'fsl,intmux_chans' property.

V3->V4:
	*set IRQ_TYPE_LEVEL_HIGH flag in .xlate callback.
	*fix comment format.
	*use an intermediate variable for irq_domain_add_linear().
	*disable interrupts before enabling chained interrupt.
	*disable interrupt in imx_remove() for level interrupt.
	*convert binding to DT schema.

V2->V3:
	*impletement .xlate and .select callback.

V1->V2:
	*squash patches:
		drivers/irqchip: enable INTMUX interrupt controller driver
 		drivers/irqchip: add NXP INTMUX interrupt multiplexer support
	*remove properity "fsl,intmux_chans", only support channel 0 by
	default.
	*delete two unused macros.
	*align the various field in struct intmux_data.
	*turn to spin lock _irqsave version.
	*delete struct intmux_irqchip_data.
	*disable interrupt in probe stage and clear pending status in remove
	stage.

Joakim Zhang (2):
  dt-bindings/irq: add binding for NXP INTMUX interrupt multiplexer
  drivers/irqchip: add NXP INTMUX interrupt multiplexer support

 .../interrupt-controller/fsl,intmux.yaml      |  68 ++++
 drivers/irqchip/Kconfig                       |   6 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-imx-intmux.c              | 309 ++++++++++++++++++
 4 files changed, 384 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
fsl,intmux.yaml
 create mode 100644 drivers/irqchip/irq-imx-intmux.c

--=20
2.17.1

