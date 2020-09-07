Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89C36C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A582078E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 09:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="EakioP7S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728431AbgIGJuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 05:50:12 -0400
Received: from mail-vi1eur05on2055.outbound.protection.outlook.com ([40.107.21.55]:7902
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728375AbgIGJuI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 05:50:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZajmjUZBH/ChFnHf4gnlSKX44B1SvTYMyqNk3lsUWQ44RfWC3XTDHWJtlDbvXAE/P+N2ojsUMBcxq/COtGYQ1jxlNlTz2nTcYPxzJXhZBuOefiTPmaf39taHytBdOVtl5yvNDsTcZKW9Y6a4luOnsxP5YE5y56ikKaRJRT6ptw3ZGBFFbhpQ6hhRC8BpLlEEmsxkZom1WVCp43i4gGrwiuRI8VYmBfHFysNzU6NlcH6Bfg9Y+R5Qg5vbHbd6QD3Fv0Cc4P3B/wmSaDb5UaNH9Ay5QApMm6FxSCgTWx11W83WNEzzkblObSDIoyi4a3kxvGomKRCUrss1ZkADgboOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsfUNsgxF90ZNjMa4Owxk6fnLAPmeI6OEaA2JSNsy24=;
 b=ARw3aX47W4VG0R+zqe1kpQ9RGuUIG/eB7qkPwFV5RFvoTj/Uo+cvFNCzbicJ6vCjTgJTaodeREJFsY/T9H9j/7o28CsDE9JAKH+7mhTY3Rr+O2ikJ5htYBKpWb1bwx5vsxLSShuCcH84GksG0LBNdCnrazfnx/MavuvFIUc9VgcjbOJxX8Jk6iyzgLmLFam5OcaCGnHzRKavKmjuwzI3QFQMEEq7MqFbNLGeMaSCa8dh4PG30sZIR+hW77GvdFCbff7IB4mW7Um7pHOBQgT5bT88LevwXYJg9mDh1BshCaf6WwjigEI3445wb6vt8+u0FnGG57DwE7qWegcpRvRNkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsfUNsgxF90ZNjMa4Owxk6fnLAPmeI6OEaA2JSNsy24=;
 b=EakioP7SL4cO9aUxyMs+SQYQDV/e3Z37tfImjIMo3ciluYkXfqaVZhebXMBA7Yi4p1iHG8C1Lv0OnlOsZGwEcr6eZJ9qesVdxhxs6GDKnBWHPPdASPH8J2JoRO7PK4r3Ml4i8RBquqUf2DJp7zJsCoRyN5en/gH7uXbmpP4ZDE0=
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 (2603:10a6:200:47::26) by AM0PR04MB3956.eurprd04.prod.outlook.com
 (2603:10a6:208:5d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16; Mon, 7 Sep
 2020 09:49:52 +0000
Received: from AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::a1ce:11b4:bce7:e13a]) by AM4PR0401MB2401.eurprd04.prod.outlook.com
 ([fe80::a1ce:11b4:bce7:e13a%4]) with mapi id 15.20.3348.019; Mon, 7 Sep 2020
 09:49:52 +0000
From:   "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Franck Lenormand (OSS)" <franck.lenormand@oss.nxp.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        "linux@rempel-privat.de" <linux@rempel-privat.de>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: RE: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver
Thread-Topic: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver
Thread-Index: AQHWX3J/lFCoBVmNf0e/r+iYLrcA6Kk/mzuAgB2eBGA=
Date:   Mon, 7 Sep 2020 09:49:51 +0000
Message-ID: <AM4PR0401MB24013282D99065A19AFC626F92280@AM4PR0401MB2401.eurprd04.prod.outlook.com>
References: <1595344835-67746-1-git-send-email-franck.lenormand@oss.nxp.com>
 <1595344835-67746-6-git-send-email-franck.lenormand@oss.nxp.com>
 <20200819133136.GB7114@dragon>
In-Reply-To: <20200819133136.GB7114@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.1.10.98]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2ad04dae-1387-431f-166c-08d853135e33
x-ms-traffictypediagnostic: AM0PR04MB3956:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB3956FF64D981F280A912B029D3280@AM0PR04MB3956.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:16;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pjBPk5ybSnnxgRoCIq0qaLdeBjrPP3kEPHpjzNXzrN1Q28lAI5/v6MQNUr6o3KehDmovv3FI6kjMR3j26ZvUVktOZmNgqxxHC3gZSlD0AdROfDND2lKwMxHQNIlRV3hkgVEqmGK3Xhx8DvWGCNRdCBoA8c40r41BMbWRjUvA3u3Vll59KXdN76MxV7L2loeTuHbFTI83p+EV7YrXVDIQOUsHNKTZXgLPKuRu2bcHDTk+XqH6CXTK8bRhujaNuXMcjeXHJKQUaIB8iGKe7nA9dplMTpCCbANcLWi4y4khWyFDeHAymMfmxvfKkUatUCgC1K/5wEkSHE3DXESShWAJVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0401MB2401.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(66476007)(33656002)(71200400001)(2906002)(55016002)(64756008)(186003)(83380400001)(9686003)(53546011)(66446008)(6506007)(5660300002)(4326008)(30864003)(54906003)(52536014)(478600001)(26005)(110136005)(66946007)(7696005)(76116006)(8676002)(8936002)(86362001)(66556008)(316002)(579004)(559001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w2uOaRnBv8i61fYosgXVOv3b97Framb6N3hXXkM6A1eNzOMX96fia6N7TFjbYl9okDueC6JT6GBjCzSOnJ555QunsoHM5gTwE1FFb9tq24+ecIh+S+dNQk+5+ucevZbi9Dn4KufCjpIK3TtEDp/zJvUdtPZiDmh0reGRASfOWIbdcSXVSyuP+iUraMZCK/0015kaugynnXcyraNLgQO2A9rd5iogM78B0vJLpjhEv3axhstyixy4OnBiIqsdQusBP+LceTfxUp7MzBr7oeMbla2kcorrELB1X/6A3JsE4l2GasVnej6Q7Km+4siB3yAuQM06IG/P2A8Wvt4dFLItYP+FXOn8rZMMiUwVTICKZ73XzsgAboKsVqX69Ul1xtDBdFe0IwbrQo819DfizedczZ+c/5YvnIXWBaJR39RqEo1Put8kbtl88h+91zOd6Yv6i49wYRLv/O7UouNs0H9Ed/YwyiNOFCkH/DlqlXORF01F/YzE5pL2XGyqLGPXM1lByRQy3AUHc5ilfrRehbni3JuYx22hsdg249YgLEeaeysU69Xh9wPKt/0+zozPUkpE12ala8jPDJPSHn15Alb42V7Jk1Ug+Gd1RD+n0x54twVOKEGq09eJt+2ZjpgNWuz3Z65BBSK7tbXAkI0BNTYi0Q==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0401MB2401.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad04dae-1387-431f-166c-08d853135e33
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2020 09:49:52.1036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjYbjS7LMsAKJjKd+JAxRmjvfOJHNwu6Yg1G91Ebn083FymCI1xCJL1ekCsSlrh/waPNCFZx7r1SegtFmMYQPVz3Fz0VUlze68F8OZf/wyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB3956
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Regards,

Franck LENORMAND, STEC Engineer

-----Original Message-----
From: Shawn Guo <shawnguo@kernel.org>=20
Sent: Wednesday, August 19, 2020 3:32 PM
To: Franck Lenormand (OSS) <franck.lenormand@oss.nxp.com>; Arnd Bergmann <a=
rnd@arndb.de>
Cc: s.hauer@pengutronix.de; festevam@gmail.com; kernel@pengutronix.de; linu=
x-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org; dl-linux-im=
x <linux-imx@nxp.com>; Aisheng Dong <aisheng.dong@nxp.com>; Abel Vesa <abel=
.vesa@nxp.com>; Anson Huang <anson.huang@nxp.com>; linux@rempel-privat.de; =
Leonard Crestez <leonard.crestez@nxp.com>; Daniel Baluta <daniel.baluta@nxp=
.com>; Joakim Zhang <qiangqing.zhang@nxp.com>; Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v2 5/5] soc: imx8: Add the SC SECVIO driver

On Tue, Jul 21, 2020 at 05:20:35PM +0200, franck.lenormand@oss.nxp.com wrot=
e:
> From: Franck LENORMAND <franck.lenormand@oss.nxp.com>
>=20
> The SNVS is a hardware component in the imx8 SoC. One of its function=20
> is to detect hardware attacks, in which case it creates a SECurity=20
> VIOlation.
>=20
> This patch adds the support for the reception of these secvio and=20
> report it to the audit framework.
>=20
> It also gives the possibility to perform custom processing when a=20
> secvio is detected.
>=20
> Signed-off-by: Franck LENORMAND <franck.lenormand@oss.nxp.com>
> Reported-by: kernel test robot <lkp@intel.com>
> ---
>  drivers/soc/imx/Kconfig                     |  10 +
>  drivers/soc/imx/Makefile                    |   1 +
>  drivers/soc/imx/secvio/Kconfig              |  10 +
>  drivers/soc/imx/secvio/Makefile             |   3 +
>  drivers/soc/imx/secvio/imx-secvio-audit.c   |  39 ++
>  drivers/soc/imx/secvio/imx-secvio-debugfs.c | 379 ++++++++++++ =20
> drivers/soc/imx/secvio/imx-secvio-sc-int.h  |  84 +++
>  drivers/soc/imx/secvio/imx-secvio-sc.c      | 858 ++++++++++++++++++++++=
++++++
>  include/soc/imx/imx-secvio-sc.h             | 177 ++++++
>  9 files changed, 1561 insertions(+)
>  create mode 100644 drivers/soc/imx/secvio/Kconfig  create mode 100644=20
> drivers/soc/imx/secvio/Makefile  create mode 100644=20
> drivers/soc/imx/secvio/imx-secvio-audit.c
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-debugfs.c
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc-int.h
>  create mode 100644 drivers/soc/imx/secvio/imx-secvio-sc.c
>  create mode 100644 include/soc/imx/imx-secvio-sc.h

Hi Arnd,

Do we have any subsystem to accommodate this driver?  Or 'soc' is just the =
right place for it?
[FL:] I was not able to find other devices which detects hardware intrusion=
s so it seemed to be the best place for the driver.

Shawn

>=20
> diff --git a/drivers/soc/imx/Kconfig b/drivers/soc/imx/Kconfig index=20
> a9370f4..6c1bc78 100644
> --- a/drivers/soc/imx/Kconfig
> +++ b/drivers/soc/imx/Kconfig
> @@ -19,4 +19,14 @@ config SOC_IMX8M
>  	  support, it will provide the SoC info like SoC family,
>  	  ID and revision etc.
> =20
> +config SECVIO_SC
> +        tristate "NXP SC secvio support"
> +        depends on IMX_SCU
> +        help
> +           If you say yes here you get support for the NXP SNVS security
> +           violation module. It includes the possibility to read informa=
tion
> +           related to security violations and tampers. It also gives the
> +           possibility to register user callbacks when a security violat=
ion
> +           occurs.
> +
>  endmenu
> diff --git a/drivers/soc/imx/Makefile b/drivers/soc/imx/Makefile index=20
> 078dc91..c91a499 100644
> --- a/drivers/soc/imx/Makefile
> +++ b/drivers/soc/imx/Makefile
> @@ -5,3 +5,4 @@ endif
>  obj-$(CONFIG_HAVE_IMX_GPC) +=3D gpc.o
>  obj-$(CONFIG_IMX_GPCV2_PM_DOMAINS) +=3D gpcv2.o
>  obj-$(CONFIG_SOC_IMX8M) +=3D soc-imx8m.o
> +obj-${CONFIG_SECVIO_SC} +=3D secvio/
> diff --git a/drivers/soc/imx/secvio/Kconfig=20
> b/drivers/soc/imx/secvio/Kconfig new file mode 100644 index=20
> 0000000..dcfaea5
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/Kconfig
> @@ -0,0 +1,10 @@
> +config SECVIO_SC
> +        tristate "NXP SC secvio support"
> +        depends on IMX_SCU
> +        help
> +           If you say yes here you get support for the NXP SNVS security
> +           violation module. It includes the possibility to read informa=
tion
> +           related to security violations and tampers. It also gives the
> +           possibility to register user callbacks when a security violat=
ion
> +           occurs.
> +
> diff --git a/drivers/soc/imx/secvio/Makefile=20
> b/drivers/soc/imx/secvio/Makefile new file mode 100644 index=20
> 0000000..d5a89ba
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/Makefile
> @@ -0,0 +1,3 @@
> +obj-y +=3D  imx-secvio-sc.o
> +obj-$(CONFIG_DEBUG_FS) +=3D imx-secvio-debugfs.o
> +obj-$(CONFIG_AUDIT) +=3D imx-secvio-audit.o
> diff --git a/drivers/soc/imx/secvio/imx-secvio-audit.c=20
> b/drivers/soc/imx/secvio/imx-secvio-audit.c
> new file mode 100644
> index 0000000..dc96e16
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-audit.c
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +#include <linux/audit.h>
> +
> +#include <soc/imx/imx-secvio-sc.h>
> +
> +/**
> + * report_to_audit_notify() - Report secvio and tamper status to=20
> +audit FW
> + *
> + * This function can be chained in a notifier list
> + *
> + * @nb: notifier block
> + * @status: error code
> + * @notif_info: Pointer on secvio_sc_notifier_info structure
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int report_to_audit_notify(struct notifier_block *nb, unsigned long stat=
us,
> +			   void *notif_info)
> +{
> +	struct audit_buffer *ab;
> +	struct secvio_sc_notifier_info *info =3D notif_info;
> +
> +	ab =3D audit_log_start(audit_context(), GFP_KERNEL, AUDIT_INTEGRITY_RUL=
E);
> +	if (!ab)
> +		return -ENOMEM;
> +
> +	audit_log_format(ab, " hpsvs=3D0x%.08x lps=3D0x%.08x lptds=3D0x%.08x",
> +			 info->hpsvs, info->lps, info->lptds);
> +	audit_log_task_info(ab);
> +	audit_log_end(ab);
> +
> +	return 0;
> +}
> diff --git a/drivers/soc/imx/secvio/imx-secvio-debugfs.c=20
> b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
> new file mode 100644
> index 0000000..bcbd77a
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-debugfs.c
> @@ -0,0 +1,379 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +/*
> + * The module exposes 3 files in debugfs:
> + *  - secvio/info:
> + *      * Read: It returns the value of the fuses and SNVS registers whi=
ch are
> + *              readable and related to secvio and tampers
> + *      * Write: A write of the format "<hex id> [<hex value 0> <hex val=
ue 1>
> + *               <hex value 2> <hex value 3> <hex value 4>](<nb values>)=
"
> + *               will write the SNVS register having the provided id wit=
h the
> + *               values provided (cf SECO documentation)
> + *  - secvio/enable: State of the IRQ
> + *  - secvio/check: Check the state of the security violation and tamper=
s
> + *                  and calls notifier
> + *  - secvio/clear: Clear the state of all secvio and tampers  */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/debugfs.h>
> +#include <linux/uaccess.h>
> +#include <linux/nvmem-consumer.h>
> +
> +#include <linux/firmware/imx/svc/misc.h> #include=20
> +<linux/firmware/imx/svc/seco.h>
> +
> +#include <soc/imx/imx-secvio-sc.h>
> +#include "imx-secvio-sc-int.h"
> +
> +/**
> + * fuse_reader() - Read a set of fuse
> + *
> + * @dev: secvio device
> + * @id: offset of the fuse
> + * @value: array of values read
> + * @mul: number of fuse to read
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int fuse_reader(struct device *dev, u32 id, u32 *value, u8=20
> +mul) {
> +	struct imx_secvio_sc_data *data =3D dev_get_drvdata(dev);
> +	u32 size_to_read =3D mul * sizeof(u32);
> +	int ret;
> +
> +	ret =3D nvmem_device_read(data->nvmem, id, size_to_read, value);
> +	if (ret < 0) {
> +		dev_err(data->dev, "Failed to read fuse %d: %d\n", id, ret);
> +		return ret;
> +	}
> +
> +	if (ret !=3D size_to_read) {
> +		dev_err(data->dev, "Read only %d instead of %d\n", ret,
> +			size_to_read);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * snvs_reader() - Read a set of SNVS register
> + *
> + * @dev: secvio device
> + * @id: offset of the register
> + * @value: array of values read
> + * @mul: number of registers to read
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int snvs_reader(struct device *dev, u32 id, u32 *value, u8=20
> +mul) {
> +	int ret;
> +	u32 *v1, *v2, *v3, *v4, *v5;
> +
> +	v1 =3D NULL;
> +	v2 =3D NULL;
> +	v3 =3D NULL;
> +	v4 =3D NULL;
> +	v5 =3D NULL;
> +
> +	switch (mul) {
> +	case 5:
> +		v5 =3D &value[4];
> +		fallthrough;
> +	case 4:
> +		v4 =3D &value[3];
> +		fallthrough;
> +	case 3:
> +		v3 =3D &value[2];
> +		fallthrough;
> +	case 2:
> +		v2 =3D &value[1];
> +		fallthrough;
> +	case 1:
> +		v1 =3D &value[0];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret =3D call_secvio_config(dev, id, SECVIO_CONFIG_READ, v1, v2, v3, v4,
> +				 v5, mul);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to read snvs reg %d: %d\n", id, ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * snvs_dgo_reader() - Read a set of DGO register
> + *
> + * @dev: secvio device
> + * @id: offset of the register
> + * @value: array of values read
> + * @mul: number of registers to read
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int snvs_dgo_reader(struct device *dev, u32 id, u32 *value, u8=20
> +mul) {
> +	struct imx_secvio_sc_data *data =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	/* We check that we only have 1 register to read */
> +	if (mul !=3D 1)
> +		return -EINVAL;
> +
> +	ret =3D imx_sc_seco_secvio_dgo_config(data->ipc_handle, id,
> +					    SECVIO_CONFIG_READ, value);
> +	if (ret)
> +		dev_err(dev, "Failed to read snvs dgo reg %d: %d\n", id, ret);
> +
> +	return ret;
> +}
> +
> +static const struct imx_secvio_info_entry {
> +	int (*reader)(struct device *dev, u32 id, u32 *value, u8 mul);
> +	const char *type;
> +	const char *name;
> +	u32 id;
> +	u8 mul;
> +} gs_imx_secvio_info_list[] =3D {
> +	{fuse_reader, "fuse", "trim", 30, 1},
> +	{fuse_reader, "fuse", "trim2", 31, 1},
> +	{fuse_reader, "fuse", "ctrim1", 260, 1},
> +	{fuse_reader, "fuse", "ctrim2", 261, 1},
> +	{fuse_reader, "fuse", "ctrim3", 262, 1},
> +	{fuse_reader, "fuse", "ctrim4", 263, 1},
> +	{fuse_reader, "fuse", "OSC_CAP", 768, 1},
> +
> +	{snvs_reader, "snvs", "HPLR",    0x0, 1},
> +	{snvs_reader, "snvs", "LPLR",    0x34, 1},
> +	{snvs_reader, "snvs", "HPSICR",  0xc, 1},
> +	{snvs_reader, "snvs", "HPSVCR",  0x10, 1},
> +	{snvs_reader, "snvs", "HPSVS",   0x18, 1},
> +	{snvs_reader, "snvs", "LPSVC",   0x40, 1},
> +	{snvs_reader, "snvs", "LPTDC",   0x48, 2},
> +	{snvs_reader, "snvs", "LPSR",    0x4c, 1},
> +	{snvs_reader, "snvs", "LPTDS",   0xa4, 1},
> +	{snvs_reader, "snvs", "LPTGFC",  0x44, 3},
> +	{snvs_reader, "snvs", "LPATCTL", 0xe0, 1},
> +	{snvs_reader, "snvs", "LPATCLK", 0xe4, 1},
> +	{snvs_reader, "snvs", "LPATRC1", 0xe8, 2},
> +	{snvs_reader, "snvs", "LPMKC",   0x3c, 1},
> +	{snvs_reader, "snvs", "LPSMC",   0x5c, 2},
> +	{snvs_reader, "snvs", "LPPGD",   0x64, 1},
> +	{snvs_reader, "snvs", "HPVID",   0xf8, 2},
> +
> +	{snvs_dgo_reader, "dgo", "Offset",  0x0, 1},
> +	{snvs_dgo_reader, "dgo", "PUP/PD",  0x10, 1},
> +	{snvs_dgo_reader, "dgo", "Anatest", 0x20, 1},
> +	{snvs_dgo_reader, "dgo", "T trim",  0x30, 1},
> +	{snvs_dgo_reader, "dgo", "Misc",    0x40, 1},
> +	{snvs_dgo_reader, "dgo", "Vmon",    0x50, 1},
> +};
> +
> +struct imx_secvio_sc_info_seq_data {
> +	struct device *dev;
> +	const struct imx_secvio_info_entry *list;
> +	int size;
> +};
> +
> +/**
> + * imx_secvio_sc_info_seq_start() - Start sequence
> + *
> + * @m: seq file
> + * @pos: position in the sequence
> + *
> + * Return pointer on position
> + */
> +static void *imx_secvio_sc_info_seq_start(struct seq_file *m, loff_t=20
> +*pos) {
> +	struct imx_secvio_sc_info_seq_data *data =3D m->private;
> +
> +	/* Check we are not out of bound */
> +	if (*pos >=3D data->size)
> +		return NULL;
> +
> +	return (void *)pos;
> +}
> +
> +/**
> + * imx_secvio_sc_info_seq_next() - Iterate sequence
> + *
> + * @m: seq file
> + * @v: pointer
> + * @pos: position in the sequence
> + *
> + * Return pointer on position
> + */
> +static void *imx_secvio_sc_info_seq_next(struct seq_file *m, void *v,=20
> +loff_t *pos) {
> +	/* Increment the counter */
> +	++*pos;
> +
> +	/* call the start function which will check the index */
> +	return imx_secvio_sc_info_seq_start(m, pos); }
> +
> +/**
> + * imx_secvio_sc_info_seq_stop() - Stop sequence
> + *
> + * @m: seq file
> + * @v: pointer
> + */
> +static void imx_secvio_sc_info_seq_stop(struct seq_file *m, void *v)=20
> +{ }
> +
> +/**
> + * imx_secvio_sc_info_seq_show() - Show the item in the sequence
> + *
> + * @m: seq file
> + * @v: pointer
> + * @pos: position in the sequence
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_info_seq_show(struct seq_file *m, void *v) {
> +	struct imx_secvio_sc_info_seq_data *data =3D m->private;
> +	const struct imx_secvio_info_entry *e;
> +	int ret;
> +	u32 vals[5];
> +	int idx;
> +
> +	idx =3D *(loff_t *)v;
> +	e =3D &data->list[idx];
> +
> +	/* Read the values */
> +	ret =3D e->reader(data->dev, e->id, (u32 *)&vals, e->mul);
> +	if (ret) {
> +		dev_err(data->dev, "Fail to read %s %s (idx %d)\n", e->type,
> +			e->name, e->id);
> +		return 0;
> +	}
> +
> +	seq_printf(m, "%5s/%-10s(%.3d):", e->type, e->name, e->id);
> +
> +	/* Loop over the values */
> +	for (idx =3D 0; idx < e->mul; idx++)
> +		seq_printf(m, " %.8x", vals[idx]);
> +
> +	seq_puts(m, "\n");
> +
> +	return 0;
> +}
> +
> +static const struct seq_operations imx_secvio_sc_info_seq_ops =3D {
> +	.start =3D imx_secvio_sc_info_seq_start,
> +	.next  =3D imx_secvio_sc_info_seq_next,
> +	.stop  =3D imx_secvio_sc_info_seq_stop,
> +	.show  =3D imx_secvio_sc_info_seq_show, };
> +
> +/**
> + * imx_secvio_sc_info_open() - Store node info for ioctl
> + *
> + * @inode: inode
> + * @file: file used to perform the ioctl
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_info_open(struct inode *inode, struct file=20
> +*file) {
> +	struct imx_secvio_sc_info_seq_data *data;
> +
> +	data =3D __seq_open_private(file, &imx_secvio_sc_info_seq_ops, sizeof(*=
data));
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->dev =3D inode->i_private;
> +	data->list =3D gs_imx_secvio_info_list;
> +	data->size =3D ARRAY_SIZE(gs_imx_secvio_info_list);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations imx_secvio_sc_info_ops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D imx_secvio_sc_info_open,
> +	.read =3D seq_read,
> +	.llseek =3D seq_lseek,
> +	.release =3D seq_release_private,
> +};
> +
> +/**
> + * if_debugfs_remove_recursive() - Wrapper for=20
> +debugfs_remove_recursive
> + *
> + * Can be used with devm
> + *
> + * @dentry: directory entry
> + */
> +static void if_debugfs_remove_recursive(void *dentry) {
> +	debugfs_remove_recursive(dentry);
> +}
> +
> +/**
> + * imx_secvio_sc_debugfs() - Create the debugfs
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int imx_secvio_sc_debugfs(struct device *dev) {
> +	struct imx_secvio_sc_data *data =3D dev_get_drvdata(dev);
> +	struct dentry *dir;
> +	int ret =3D 0;
> +
> +	/* Create a folder */
> +	dir =3D debugfs_create_dir(dev_name(dev), NULL);
> +	if (IS_ERR(dir)) {
> +		dev_err(dev, "Failed to create dfs dir\n");
> +		ret =3D PTR_ERR(dir);
> +		goto exit;
> +	}
> +	data->dfs =3D dir;
> +
> +	ret =3D devm_add_action(dev, if_debugfs_remove_recursive, data->dfs);
> +	if (ret) {
> +		dev_err(dev, "Failed to add managed action to disable IRQ\n");
> +		goto remove_fs;
> +	}
> +
> +	/* Create the file to read info and write to reg */
> +	dir =3D debugfs_create_file("info", 0x666, data->dfs, dev,
> +				  &imx_secvio_sc_info_ops);
> +	if (IS_ERR(dir)) {
> +		dev_err(dev, "Failed to add info to debugfs\n");
> +		ret =3D PTR_ERR(dir);
> +		goto exit;
> +	}
> +
> +	goto exit;
> +
> +remove_fs:
> +	debugfs_remove_recursive(data->dfs);
> +
> +exit:
> +	return ret;
> +}
> diff --git a/drivers/soc/imx/secvio/imx-secvio-sc-int.h=20
> b/drivers/soc/imx/secvio/imx-secvio-sc-int.h
> new file mode 100644
> index 0000000..54de7fa
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-sc-int.h
> @@ -0,0 +1,84 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +#ifndef SECVIO_SC_H
> +#define SECVIO_SC_H
> +
> +/* Includes */
> +#include <linux/kernel.h>
> +#include <linux/notifier.h>
> +#include <linux/semaphore.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/miscdevice.h>
> +
> +/* Access for sc_seco_secvio_config API */ #define SECVIO_CONFIG_READ =20
> +0 #define SECVIO_CONFIG_WRITE 1
> +
> +/* Internal Structure */
> +struct imx_secvio_sc_data {
> +	struct device *dev;
> +
> +	struct imx_sc_ipc *ipc_handle;
> +
> +	struct notifier_block irq_nb;
> +	struct notifier_block report_nb;
> +	struct notifier_block audit_nb;
> +
> +	struct nvmem_device *nvmem;
> +
> +	struct miscdevice miscdev;
> +
> +#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dfs;
> +#endif
> +
> +	u32 version;
> +};
> +
> +/**
> + * call_secvio_config() - Wrapper for imx_sc_seco_secvio_config()
> + *
> + * @dev: secvio device
> + * @id: ID of the register, ie the offset of the first register of=20
> +the set
> + * @access: Write (1) or Read (0) the registers
> + * @data0: Data for the first register
> + * @data1: Data for the second register
> + * @data2: Data for the third register
> + * @data3: Data for the fourth register
> + * @data4: Data for the fifth register
> + * @size: Number of register to configure
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int call_secvio_config(struct device *dev, u8 id, u8 access, u32 *data0,
> +		       u32 *data1, u32 *data2, u32 *data3, u32 *data4, u8 size);
> +
> +#ifdef CONFIG_DEBUG_FS
> +extern
> +int imx_secvio_sc_debugfs(struct device *dev); #else static inline=20
> +int imx_secvio_sc_debugfs(struct device *dev) {
> +	return 0;
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
> +#ifdef CONFIG_AUDIT
> +int report_to_audit_notify(struct notifier_block *nb, unsigned long stat=
us,
> +			   void *notif_info);
> +#else /* CONFIG_AUDIT */
> +static inline
> +int report_to_audit_notify(struct notifier_block *nb, unsigned long stat=
us,
> +			   void *notif_info)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_AUDIT */
> +
> +#endif /* SECVIO_SC_H */
> diff --git a/drivers/soc/imx/secvio/imx-secvio-sc.c=20
> b/drivers/soc/imx/secvio/imx-secvio-sc.c
> new file mode 100644
> index 0000000..1e0d6aa
> --- /dev/null
> +++ b/drivers/soc/imx/secvio/imx-secvio-sc.c
> @@ -0,0 +1,858 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +/*
> + * The SoC of the i.MX8 family contains a hardware block called SNVS
> + * (Secure Non-Volatile Storage).
> + *
> + * The i.MX8 (QM/QXP/DXL) SoC contains the  (SNVS) block. This
> + * block can detect specific hardware attacks. Due to the presence of=20
> +the SECO,
> + * this block can only be accessible using the SCFW API.
> + *
> + * This module interacts with the SCU which relays request to/from=20
> +the SNVS block
> + * to detect if security violation occurred.
> + *
> + * The module exports an API to add processing when a SV is detected:
> + *  - register_imx_secvio_sc_notifier
> + *  - unregister_imx_secvio_sc_notifier
> + *  - imx_secvio_sc_check_state
> + *  - int_imx_secvio_sc_clear_state
> + *  - imx_secvio_sc_enable_irq
> + *  - imx_secvio_sc_disable_irq
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/notifier.h>
> +#include <linux/module.h>
> +#include <linux/fs.h>
> +#include <linux/uaccess.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/miscdevice.h>
> +
> +#include <linux/firmware/imx/ipc.h>
> +#include <linux/firmware/imx/sci.h>
> +#include <linux/firmware/imx/svc/seco.h> #include=20
> +<linux/firmware/imx/svc/rm.h> #include=20
> +<dt-bindings/firmware/imx/rsrc.h>
> +
> +#include <soc/imx/imx-secvio-sc.h>
> +#include "imx-secvio-sc-int.h"
> +
> +/* Definitions */
> +static int int_imx_secvio_sc_enable_irq(struct device *dev); static=20
> +int int_imx_secvio_sc_disable_irq(struct device *dev);
> +
> +/* Reference on the driver_device */
> +static struct device *gs_imx_secvio_sc_dev;
> +
> +/* Register IDs for sc_seco_secvio_config API */ #define HPSVS_ID=20
> +0x18 #define LPS_ID 0x4c #define LPTDS_ID 0xa4 #define HPVIDR_ID 0xf8
> +
> +#define SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER 0x53 #define=20
> +SECO_VERSION_MINOR_MASK GENMASK(15, 0)
> +
> +/* Notifier list for new CB */
> +static BLOCKING_NOTIFIER_HEAD(imx_secvio_sc_notifier_chain);
> +
> +/**
> + * register_imx_secvio_sc_notifier() - Add function to secvio call=20
> +chain
> + *
> + * @nb: notifier block of the function to add
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int register_imx_secvio_sc_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_register(&imx_secvio_sc_notifier_chain,
> +						nb);
> +}
> +EXPORT_SYMBOL(register_imx_secvio_sc_notifier);
> +
> +/**
> + * unregister_imx_secvio_sc_notifier() - Remove function to secvio=20
> +call chain
> + *
> + * @nb: notifier block of the function to add
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +int unregister_imx_secvio_sc_notifier(struct notifier_block *nb) {
> +	return blocking_notifier_chain_unregister(&imx_secvio_sc_notifier_chain=
,
> +						  nb);
> +}
> +EXPORT_SYMBOL(unregister_imx_secvio_sc_notifier);
> +
> +/**
> + * if_imx_scu_irq_register_notifier() - Wrapper for=20
> +imx_scu_irq_register_notifier
> + *
> + * Can be used for devm actions
> + *
> + * @nb: notifier block of the function to add  */ static void=20
> +if_unregister_imx_secvio_sc_notifier(void *nb) {
> +	unregister_imx_secvio_sc_notifier(nb);
> +}
> +
> +/**
> + * imx_secvio_sc_notifier_call_chain() - Call secvio notifier chain
> + *
> + * @info: The structure containing the info to pass to notified=20
> +functions
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static
> +int imx_secvio_sc_notifier_call_chain(struct secvio_sc_notifier_info=20
> +*info) {
> +	return blocking_notifier_call_chain(&imx_secvio_sc_notifier_chain, 0,
> +					    (void *)info);
> +}
> +
> +int call_secvio_config(struct device *dev, u8 id, u8 access, u32 *data0,
> +		       u32 *data1, u32 *data2, u32 *data3, u32 *data4, u8 size) {
> +	int ret =3D 0;
> +	struct imx_secvio_sc_data *data;
> +
> +	data =3D dev_get_drvdata(dev);
> +
> +	ret =3D imx_sc_seco_secvio_config(data->ipc_handle, id, access, data0,
> +					data1, data2, data3, data4, size);
> +	if (ret)
> +		dev_err(dev, "Fail %s secvio config %d",
> +			((access) ? "write" : "read"), ret);
> +
> +	return ret;
> +}
> +
> +/**
> + * int_imx_secvio_sc_get_state() - Get the state of secvio and tamper
> + *
> + * @dev: secvio device
> + * @info: The structure to use to store the status
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_get_state(struct device *dev,
> +				       struct secvio_sc_notifier_info *info) {
> +	struct secvio_sc_notifier_info _info =3D {0};
> +	struct secvio_sc_notifier_info *p_info;
> +	int ret =3D 0, ret2 =3D 0;
> +
> +	p_info =3D info ? info : &_info;
> +
> +	/* Read secvio status */
> +	ret =3D call_secvio_config(dev, HPSVS_ID, SECVIO_CONFIG_READ,
> +				 &p_info->hpsvs, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		ret2 =3D ret;
> +		dev_warn(dev, "Cannot read secvio status: %d\n", ret);
> +	}
> +	p_info->hpsvs &=3D HPSVS__ALL_SV__MASK;
> +
> +	/* Read tampers status */
> +	ret =3D call_secvio_config(dev, LPS_ID, SECVIO_CONFIG_READ,
> +				 &p_info->lps, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		ret2 =3D ret;
> +		dev_warn(dev, "Cannot read tamper 1 status: %d\n", ret);
> +	}
> +	p_info->lps &=3D LPS__ALL_TP__MASK;
> +
> +	ret =3D call_secvio_config(dev, LPTDS_ID, SECVIO_CONFIG_READ,
> +				 &p_info->lptds, NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		ret2 =3D ret;
> +		dev_warn(dev, "Cannot read  tamper 2 status: %d\n", ret);
> +	}
> +	p_info->lptds &=3D LPTDS__ALL_TP__MASK;
> +
> +	dev_dbg(dev, "Status: %.8x, %.8x, %.8x\n", p_info->hpsvs,
> +		p_info->lps, p_info->lptds);
> +
> +	return ret2;
> +}
> +
> +/**
> + * imx_secvio_sc_get_state() - Wrapper for=20
> +int_imx_secvio_sc_get_state
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +inline int imx_secvio_sc_get_state(struct secvio_sc_notifier_info=20
> +*info) {
> +	if (!gs_imx_secvio_sc_dev)
> +		return -EOPNOTSUPP;
> +
> +	return int_imx_secvio_sc_get_state(gs_imx_secvio_sc_dev, info); }=20
> +EXPORT_SYMBOL(imx_secvio_sc_get_state);
> +
> +/**
> + * int_imx_secvio_sc_check_state() - Get the state and call chain of=20
> +notifier
> + * if there is a status
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_check_state(struct device *dev) {
> +	struct secvio_sc_notifier_info info =3D {0};
> +	int ret =3D 0;
> +
> +	ret =3D int_imx_secvio_sc_get_state(dev, &info);
> +	if (ret) {
> +		dev_err(dev, "Failed to get secvio state\n");
> +		goto exit;
> +	}
> +
> +	/* Call chain of CB registered to this module if status detected */
> +	if (info.hpsvs || info.lps || info.lptds)
> +		if (imx_secvio_sc_notifier_call_chain(&info))
> +			dev_warn(dev,
> +				 "Issues when calling the notifier chain\n");
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * imx_secvio_sc_check_state() - Wrapper for=20
> +int_imx_secvio_sc_check_state
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +inline int imx_secvio_sc_check_state(void) {
> +	if (!gs_imx_secvio_sc_dev)
> +		return -EOPNOTSUPP;
> +
> +	return int_imx_secvio_sc_check_state(gs_imx_secvio_sc_dev);
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_check_state);
> +
> +/**
> + * imx_secvio_sc_notify() - Process event from SCU
> + *
> + * If the event is secvio we check the state, then
> + * re-enable the IRQ which has been disabled by SCU
> + *
> + * @nb: secvio device
> + * @event: The id of the IRQ received in a group
> + * @group: The group of the IRQ
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_notify(struct notifier_block *nb,
> +				unsigned long event, void *group) {
> +	struct imx_secvio_sc_data *data =3D
> +				container_of(nb, struct imx_secvio_sc_data,
> +					     irq_nb);
> +	struct device *dev =3D data->dev;
> +	int ret =3D 0;
> +
> +	/* Filter event for us */
> +	if (!((event & IMX_SC_IRQ_SECVIO) &&
> +	      (*(u8 *)group =3D=3D IMX_SC_IRQ_GROUP_WAKE)))
> +		goto exit;
> +
> +	dev_warn(dev, "secvio security violation detected\n");
> +
> +	ret =3D int_imx_secvio_sc_check_state(dev);
> +
> +	/* Re-enable interrupt */
> +	ret =3D int_imx_secvio_sc_enable_irq(dev);
> +	if (ret)
> +		dev_err(dev, "Failed to enable IRQ\n");
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * int_imx_secvio_sc_clear_state() - Clear secvio and tamper state
> + *
> + * @dev: secvio device
> + * @hpsvs: high power security violation status to clear
> + * @lps: low power status to clear
> + * @lptds: low power tamper detector status to clear
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_clear_state(struct device *dev, u32 hpsvs, =
u32 lps,
> +					 u32 lptds)
> +{
> +	int ret =3D 0;
> +
> +	ret =3D call_secvio_config(dev, HPSVS_ID, SECVIO_CONFIG_WRITE, &hpsvs,
> +				 NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot clear secvio status: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret =3D call_secvio_config(dev, LPS_ID, SECVIO_CONFIG_WRITE, &lps, NULL=
,
> +				 NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot clear tamper 1 status: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	ret =3D call_secvio_config(dev, LPTDS_ID, SECVIO_CONFIG_WRITE, &lptds,
> +				 NULL, NULL, NULL, NULL, 1);
> +	if (ret) {
> +		dev_err(dev, "Cannot clear tamper 2 status: %d\n", ret);
> +		goto exit;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * imx_secvio_sc_clear_state() - Wrapper for=20
> +imx_secvio_sc_clear_state
> + *
> + * @hpsvs: high power security violation status to clear
> + * @lps: low power status to clear
> + * @lptds: low power tamper detector status to clear
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +inline int imx_secvio_sc_clear_state(u32 hpsvs, u32 lps, u32 lptds) {
> +	if (!gs_imx_secvio_sc_dev)
> +		return -EOPNOTSUPP;
> +
> +	return int_imx_secvio_sc_clear_state(gs_imx_secvio_sc_dev, hpsvs, lps,
> +					     lptds);
> +}
> +EXPORT_SYMBOL(imx_secvio_sc_clear_state);
> +
> +/**
> + * report_to_user_notify() - Print to console the status
> + *
> + * @nb: notifier block
> + * @status: error code
> + * @notif_info: Pointer on structure containing the status of the=20
> +secvio and
> + * tampers
> + *
> + * Return:
> + * 0 - OK
> + */
> +static int report_to_user_notify(struct notifier_block *nb,
> +				 unsigned long status, void *notif_info) {
> +	struct secvio_sc_notifier_info *info =3D notif_info;
> +	struct imx_secvio_sc_data *data =3D
> +				container_of(nb, struct imx_secvio_sc_data,
> +					     report_nb);
> +	struct device *dev =3D data->dev;
> +
> +	/* Information about the security violation */
> +	if (info->hpsvs & HPSVS__LP_SEC_VIO__MASK)
> +		dev_info(dev, "SNVS secvio: LPSV\n");
> +	if (info->hpsvs & HPSVS__SW_LPSV__MASK)
> +		dev_info(dev, "SNVS secvio: SW LPSV\n");
> +	if (info->hpsvs & HPSVS__SW_FSV__MASK)
> +		dev_info(dev, "SNVS secvio: SW FSV\n");
> +	if (info->hpsvs & HPSVS__SW_SV__MASK)
> +		dev_info(dev, "SNVS secvio: SW SV\n");
> +	if (info->hpsvs & HPSVS__SV5__MASK)
> +		dev_info(dev, "SNVS secvio: SV 5\n");
> +	if (info->hpsvs & HPSVS__SV4__MASK)
> +		dev_info(dev, "SNVS secvio: SV 4\n");
> +	if (info->hpsvs & HPSVS__SV3__MASK)
> +		dev_info(dev, "SNVS secvio: SV 3\n");
> +	if (info->hpsvs & HPSVS__SV2__MASK)
> +		dev_info(dev, "SNVS secvio: SV 2\n");
> +	if (info->hpsvs & HPSVS__SV1__MASK)
> +		dev_info(dev, "SNVS secvio: SV 1\n");
> +	if (info->hpsvs & HPSVS__SV0__MASK)
> +		dev_info(dev, "SNVS secvio: SV 0\n");
> +
> +	/* Information about the tampers */
> +	if (info->lps & LPS__ESVD__MASK)
> +		dev_info(dev, "SNVS tamper: External SV\n");
> +	if (info->lps & LPS__ET2D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 2\n");
> +	if (info->lps & LPS__ET1D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 1\n");
> +	if (info->lps & LPS__WMT2D__MASK)
> +		dev_info(dev, "SNVS tamper: Wire Mesh 2\n");
> +	if (info->lps & LPS__WMT1D__MASK)
> +		dev_info(dev, "SNVS tamper: Wire Mesh 1\n");
> +	if (info->lps & LPS__VTD__MASK)
> +		dev_info(dev, "SNVS tamper: Voltage\n");
> +	if (info->lps & LPS__TTD__MASK)
> +		dev_info(dev, "SNVS tamper: Temperature\n");
> +	if (info->lps & LPS__CTD__MASK)
> +		dev_info(dev, "SNVS tamper: Clock\n");
> +	if (info->lps & LPS__PGD__MASK)
> +		dev_info(dev, "SNVS tamper: Power Glitch\n");
> +	if (info->lps & LPS__MCR__MASK)
> +		dev_info(dev, "SNVS tamper: Monotonic Counter rollover\n");
> +	if (info->lps & LPS__SRTCR__MASK)
> +		dev_info(dev, "SNVS tamper: Secure RTC rollover\n");
> +	if (info->lps & LPS__LPTA__MASK)
> +		dev_info(dev, "SNVS tamper: Time alarm\n");
> +
> +	if (info->lptds & LPTDS__ET10D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 10\n");
> +	if (info->lptds & LPTDS__ET9D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 9\n");
> +	if (info->lptds & LPTDS__ET8D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 8\n");
> +	if (info->lptds & LPTDS__ET7D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 7\n");
> +	if (info->lptds & LPTDS__ET6D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 6\n");
> +	if (info->lptds & LPTDS__ET5D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 5\n");
> +	if (info->lptds & LPTDS__ET4D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 4\n");
> +	if (info->lptds & LPTDS__ET3D__MASK)
> +		dev_info(dev, "SNVS tamper: Tamper 3\n");
> +
> +	return 0;
> +}
> +
> +/**
> + * int_imx_secvio_sc_enable_irq() - Enable the secvio IRQ in SCU
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_enable_irq(struct device *dev) {
> +	int ret =3D 0, ret2;
> +	u32 irq_status;
> +	struct imx_secvio_sc_data *data;
> +
> +	data =3D dev_get_drvdata(dev);
> +
> +	/* Enable the IRQ */
> +	ret =3D imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECV=
IO,
> +				       true);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SCU IRQ: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	/* Enable interrupt */
> +	ret =3D imx_sc_seco_secvio_enable(data->ipc_handle);
> +	if (ret) {
> +		dev_err(dev, "Cannot enable SNVS irq: %d\n", ret);
> +		goto exit;
> +	};
> +
> +	/* Unmask interrupt */
> +	ret =3D imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "Cannot unmask irq: %d\n", ret);
> +		goto exit;
> +	};
> +
> +exit:
> +	if (ret) {
> +		ret2 =3D int_imx_secvio_sc_disable_irq(dev);
> +		if (ret2)
> +			dev_warn(dev, "Failed to disable the IRQ\n");
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * int_imx_secvio_sc_disable_irq() - Disable secvio IRQ
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int int_imx_secvio_sc_disable_irq(struct device *dev) {
> +	int ret =3D 0;
> +	struct imx_secvio_sc_data *data;
> +
> +	data =3D dev_get_drvdata(dev);
> +
> +	/* Disable the IRQ */
> +	ret =3D imx_scu_irq_group_enable(IMX_SC_IRQ_GROUP_WAKE, IMX_SC_IRQ_SECV=
IO,
> +				       false);
> +	if (ret) {
> +		dev_err(dev, "Cannot disable SCU IRQ: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * if_imx_secvio_sc_disable_irq() - Wrapper for=20
> +int_imx_secvio_sc_disable_irq
> + *
> + * Can be used with devm
> + *
> + * @dev: secvio device
> + */
> +static void if_imx_secvio_sc_disable_irq(void *dev) {
> +	int_imx_secvio_sc_disable_irq(dev);
> +}
> +
> +/**
> + * imx_secvio_sc_open() - Store node info for ioctl
> + *
> + * @node: inode
> + * @file: file used to perform the ioctl
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_open(struct inode *node, struct file *filp)=20
> +{
> +	filp->private_data =3D node->i_private;
> +
> +	return 0;
> +}
> +
> +/**
> + * imx_secvio_sc_ioctl() - IOCTL handler for the driver
> + *
> + * @file: file used to perform the ioctl
> + * @cmd: command to perform
> + * @arg: Pointer on structure with info for the command
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static long imx_secvio_sc_ioctl(struct file *file, unsigned int cmd,=20
> +unsigned long arg) {
> +	struct device *dev =3D file->private_data;
> +	struct secvio_sc_notifier_info info;
> +	int ret;
> +
> +	switch (cmd) {
> +	case IMX_SECVIO_SC_GET_STATE:
> +		ret =3D int_imx_secvio_sc_get_state(dev, &info);
> +		if (ret) {
> +			dev_err(dev, "Fail to get state\n");
> +			goto exit;
> +		}
> +
> +		ret =3D copy_to_user((void *)arg, &info, sizeof(info));
> +		if (ret) {
> +			dev_err(dev, "Fail to copy info to user\n");
> +			ret =3D -EFAULT;
> +			goto exit;
> +		}
> +		break;
> +	case IMX_SECVIO_SC_CHECK_STATE:
> +		ret =3D int_imx_secvio_sc_check_state(dev);
> +		if (ret) {
> +			dev_err(dev, "Fail to check state\n");
> +			goto exit;
> +		}
> +		break;
> +	case IMX_SECVIO_SC_CLEAR_STATE:
> +		ret =3D copy_from_user(&info, (void *)arg, sizeof(info));
> +		if (ret) {
> +			dev_err(dev, "Fail to copy info from user\n");
> +			ret =3D -EFAULT;
> +			goto exit;
> +		}
> +
> +		ret =3D int_imx_secvio_sc_clear_state(dev, info.hpsvs, info.lps,
> +						    info.lptds);
> +		if (ret) {
> +			dev_err(dev, "Fail to clear state\n");
> +			goto exit;
> +		}
> +		break;
> +	default:
> +		ret =3D -ENOIOCTLCMD;
> +	}
> +
> +exit:
> +	return ret;
> +}
> +
> +const static struct file_operations imx_secvio_sc_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D imx_secvio_sc_open,
> +	.unlocked_ioctl =3D imx_secvio_sc_ioctl, };
> +
> +static void if_misc_deregister(void *miscdevice) {
> +	misc_deregister(miscdevice);
> +}
> +
> +static void reset_global_dev(void *dev) {
> +	gs_imx_secvio_sc_dev =3D NULL;
> +}
> +
> +/**
> + * imx_secvio_sc_setup() - Configure the driver
> + *
> + * @dev: secvio device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_setup(struct device *dev) {
> +	struct imx_secvio_sc_data *data;
> +	u32 seco_version =3D 0;
> +	bool own_secvio;
> +	u32 irq_status;
> +	int ret =3D 0;
> +
> +	if (!devres_open_group(dev, NULL, GFP_KERNEL)) {
> +		ret =3D -ENOMEM;
> +		goto exit;
> +	}
> +
> +	/* Allocate private data */
> +	data =3D devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret =3D -ENOMEM;
> +		dev_err(dev, "Failed to allocate mem for data\n");
> +		goto clean;
> +	}
> +
> +	data->dev =3D dev;
> +
> +	dev_set_drvdata(dev, data);
> +
> +	data->nvmem =3D devm_nvmem_device_get(dev, NULL);
> +	if (IS_ERR(data->nvmem)) {
> +		ret =3D PTR_ERR(data->nvmem);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "Failed to retrieve nvmem\n");
> +
> +		goto clean;
> +	}
> +
> +	/* Get a handle */
> +	ret =3D imx_scu_get_handle(&data->ipc_handle);
> +	if (ret) {
> +		dev_err(dev, "cannot get handle to scu: %d\n", ret);
> +		goto clean;
> +	};
> +
> +	/* Check the version of the SECO */
> +	ret =3D imx_sc_seco_build_info(data->ipc_handle, &seco_version, NULL);
> +	if (ret) {
> +		dev_err(dev, "Failed to get seco version\n");
> +		goto clean;
> +	}
> +
> +	if ((seco_version & SECO_VERSION_MINOR_MASK) <
> +	     SECO_MINOR_VERSION_SUPPORT_SECVIO_TAMPER) {
> +		dev_err(dev, "SECO version %.8x doesn't support all secvio\n",
> +			seco_version);
> +		ret =3D -EOPNOTSUPP;
> +		goto clean;
> +	}
> +
> +	/* Init debug FS */
> +	ret =3D imx_secvio_sc_debugfs(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set debugfs\n");
> +		goto clean;
> +	}
> +
> +	/* Check we own the SECVIO */
> +	ret =3D imx_sc_rm_is_resource_owned(data->ipc_handle, IMX_SC_R_SECVIO);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to retrieve secvio ownership\n");
> +		goto clean;
> +	}
> +
> +	own_secvio =3D ret > 0;
> +	if (!own_secvio) {
> +		dev_err(dev, "Secvio resource is not owned\n");
> +		ret =3D -EPERM;
> +		goto clean;
> +	}
> +
> +	/* Check IRQ exists and enable it */
> +	ret =3D imx_scu_irq_get_status(IMX_SC_IRQ_GROUP_WAKE, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "Cannot get IRQ state: %d\n", ret);
> +		goto clean;
> +	}
> +
> +	ret =3D int_imx_secvio_sc_enable_irq(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to enable IRQ\n");
> +		goto clean;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, if_imx_secvio_sc_disable_irq, dev=
);
> +	if (ret) {
> +		dev_err(dev, "Failed to add managed action to disable IRQ\n");
> +		goto clean;
> +	}
> +
> +	/* Register the notifier for IRQ from SNVS */
> +	data->irq_nb.notifier_call =3D imx_secvio_sc_notify;
> +	ret =3D imx_scu_irq_register_notifier(&data->irq_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to register IRQ notification handler\n");
> +		goto clean;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, if_unregister_imx_secvio_sc_notif=
ier,
> +				       &data->irq_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to remove irq notify\n");
> +		goto clean;
> +	}
> +
> +	/* Register the notification for reporting to user */
> +	data->report_nb.notifier_call =3D report_to_user_notify;
> +	ret =3D register_imx_secvio_sc_notifier(&data->report_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to register report notify handler\n");
> +		goto clean;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, if_unregister_imx_secvio_sc_notif=
ier,
> +				       &data->report_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to remove report notify\n");
> +		goto clean;
> +	}
> +
> +	/* Register the notification to report to audit FW */
> +	data->audit_nb.notifier_call =3D report_to_audit_notify;
> +	ret =3D register_imx_secvio_sc_notifier(&data->audit_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to register report audit handler\n");
> +		goto clean;
> +	}
> +
> +	ret =3D devm_add_action(dev, if_unregister_imx_secvio_sc_notifier,
> +			      &data->audit_nb);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to remove audit notif\n");
> +		goto clean;
> +	}
> +
> +	/* Register misc device for IOCTL */
> +	data->miscdev.name =3D devm_kstrdup(dev, "secvio-sc", GFP_KERNEL);
> +	data->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> +	data->miscdev.fops =3D &imx_secvio_sc_fops;
> +	data->miscdev.parent =3D dev;
> +	ret =3D misc_register(&data->miscdev);
> +	if (ret) {
> +		dev_err(dev, "failed to register misc device\n");
> +		goto exit;
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, if_misc_deregister, &data->miscde=
v);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to unregister miscdev\n");
> +		goto clean;
> +	}
> +
> +	gs_imx_secvio_sc_dev =3D dev;
> +	ret =3D devm_add_action_or_reset(dev, reset_global_dev, dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to add action to disable global dev\n");
> +		goto clean;
> +	}
> +
> +	/* Process current state of the secvio and tampers */
> +	int_imx_secvio_sc_check_state(dev);
> +
> +	devres_remove_group(dev, NULL);
> +
> +	goto exit;
> +
> +clean:
> +	devres_release_group(dev, NULL);
> +
> +exit:
> +	return ret;
> +}
> +
> +/**
> + * imx_secvio_sc_probe() - Probe the driver
> + *
> + * @pdev: platform device
> + *
> + * Return:
> + * 0 - OK
> + * < 0 - error.
> + */
> +static int imx_secvio_sc_probe(struct platform_device *pdev) {
> +	int ret;
> +	struct device *dev =3D &pdev->dev;
> +
> +	ret =3D imx_secvio_sc_setup(dev);
> +	if (ret && ret !=3D -EPROBE_DEFER)
> +		dev_err(dev, "Failed to setup\n");
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id imx_secvio_sc_dt_ids[] =3D {
> +	{ .compatible =3D "fsl,imx-sc-secvio", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx_secvio_sc_dt_ids);
> +
> +static struct platform_driver imx_secvio_sc_driver =3D {
> +	.driver =3D {
> +		.owner =3D THIS_MODULE,
> +		.name	=3D "imx-secvio-sc",
> +		.of_match_table =3D imx_secvio_sc_dt_ids,
> +	},
> +	.probe		=3D imx_secvio_sc_probe,
> +};
> +module_platform_driver(imx_secvio_sc_driver);
> +
> +MODULE_AUTHOR("Franck LENORMAND <franck.lenormand@nxp.com>");=20
> +MODULE_DESCRIPTION("NXP i.MX driver to handle SNVS secvio irq sent by=20
> +SCFW"); MODULE_LICENSE("GPL");
> diff --git a/include/soc/imx/imx-secvio-sc.h=20
> b/include/soc/imx/imx-secvio-sc.h new file mode 100644 index=20
> 0000000..a26e2ff
> --- /dev/null
> +++ b/include/soc/imx/imx-secvio-sc.h
> @@ -0,0 +1,177 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Copyright 2019-2020 NXP
> + */
> +
> +#ifndef _MISC_IMX_SECVIO_SC_H_
> +#define _MISC_IMX_SECVIO_SC_H_
> +
> +#include <linux/kernel.h>
> +#include <linux/notifier.h>
> +
> +/* Bitmask of the security violation status bit in the HPSVS register=20
> +*/ #define HPSVS__LP_SEC_VIO__MASK BIT(31)
> +#define HPSVS__SW_LPSV__MASK    BIT(15)
> +#define HPSVS__SW_FSV__MASK     BIT(14)
> +#define HPSVS__SW_SV__MASK      BIT(13)
> +#define HPSVS__SV5__MASK        BIT(5)
> +#define HPSVS__SV4__MASK        BIT(4)
> +#define HPSVS__SV3__MASK        BIT(3)
> +#define HPSVS__SV2__MASK        BIT(2)
> +#define HPSVS__SV1__MASK        BIT(1)
> +#define HPSVS__SV0__MASK        BIT(0)
> +
> +/* Bitmask of all security violation status bit in the HPSVS register=20
> +*/ #define HPSVS__ALL_SV__MASK (HPSVS__LP_SEC_VIO__MASK | \
> +			     HPSVS__SW_LPSV__MASK | \
> +			     HPSVS__SW_FSV__MASK | \
> +			     HPSVS__SW_SV__MASK | \
> +			     HPSVS__SV5__MASK | \
> +			     HPSVS__SV4__MASK | \
> +			     HPSVS__SV3__MASK | \
> +			     HPSVS__SV2__MASK | \
> +			     HPSVS__SV1__MASK | \
> +			     HPSVS__SV0__MASK)
> +
> +/*
> + * Bitmask of the security violation and tampers status bit in the=20
> +LPS register  */ #define LPS__ESVD__MASK  BIT(16) #define=20
> +LPS__ET2D__MASK  BIT(10) #define LPS__ET1D__MASK  BIT(9) #define=20
> +LPS__WMT2D__MASK BIT(8) #define LPS__WMT1D__MASK BIT(7)
> +#define LPS__VTD__MASK   BIT(6)
> +#define LPS__TTD__MASK   BIT(5)
> +#define LPS__CTD__MASK   BIT(4)
> +#define LPS__PGD__MASK   BIT(3)
> +#define LPS__MCR__MASK   BIT(2)
> +#define LPS__SRTCR__MASK BIT(1)
> +#define LPS__LPTA__MASK  BIT(0)
> +
> +/*
> + * Bitmask of all security violation and tampers status bit in the LPS r=
egister
> + */
> +#define LPS__ALL_TP__MASK (LPS__ESVD__MASK | \
> +			   LPS__ET2D__MASK | \
> +			   LPS__ET1D__MASK | \
> +			   LPS__WMT2D__MASK | \
> +			   LPS__WMT1D__MASK | \
> +			   LPS__VTD__MASK | \
> +			   LPS__TTD__MASK | \
> +			   LPS__CTD__MASK | \
> +			   LPS__PGD__MASK | \
> +			   LPS__MCR__MASK | \
> +			   LPS__SRTCR__MASK | \
> +			   LPS__LPTA__MASK)
> +
> +/*
> + * Bitmask of the security violation and tampers status bit in the LPTDS
> + * register
> + */
> +#define LPTDS__ET10D__MASK  BIT(7)
> +#define LPTDS__ET9D__MASK   BIT(6)
> +#define LPTDS__ET8D__MASK   BIT(5)
> +#define LPTDS__ET7D__MASK   BIT(4)
> +#define LPTDS__ET6D__MASK   BIT(3)
> +#define LPTDS__ET5D__MASK   BIT(2)
> +#define LPTDS__ET4D__MASK   BIT(1)
> +#define LPTDS__ET3D__MASK   BIT(0)
> +
> +/*
> + * Bitmask of all security violation and tampers status bit in the LPTDS
> + * register
> + */
> +#define LPTDS__ALL_TP__MASK (LPTDS__ET10D__MASK | \
> +			     LPTDS__ET9D__MASK | \
> +			     LPTDS__ET8D__MASK | \
> +			     LPTDS__ET7D__MASK | \
> +			     LPTDS__ET6D__MASK | \
> +			     LPTDS__ET5D__MASK | \
> +			     LPTDS__ET4D__MASK | \
> +			     LPTDS__ET3D__MASK)
> +
> +/**
> + * struct secvio_sc_notifier_info - Information about the status of the =
SNVS
> + * @hpsvs:   status from register HPSVS
> + * @lps: status from register LPS
> + * @lptds: status from register LPTDS
> + */
> +struct secvio_sc_notifier_info {
> +	u32 hpsvs;
> +	u32 lps;
> +	u32 lptds;
> +};
> +
> +/**
> + * register_imx_secvio_sc_notifier() - Register a notifier
> + *
> + * @nb: The notifier block structure
> + *
> + * Register a function to notify to the imx-secvio-sc module. The functi=
on
> + * will be notified when a check of the state of the SNVS happens: calle=
d by
> + * a user or triggered by an interruption form the SNVS.
> + *
> + * The struct secvio_sc_notifier_info is passed as data to the notifier.
> + *
> + * Return: 0 in case of success
> + */
> +int register_imx_secvio_sc_notifier(struct notifier_block *nb);
> +
> +/**
> + * unregister_imx_secvio_sc_notifier() - Unregister a notifier
> + *
> + * @nb: The notifier block structure
> + *
> + * Return: 0 in case of success
> + */
> +int unregister_imx_secvio_sc_notifier(struct notifier_block *nb);
> +
> +/**
> + * imx_secvio_sc_get_state() - Get the state of the SNVS
> + *
> + * @info: The structure containing the state of the SNVS
> + *
> + * Return: 0 in case of success
> + */
> +int imx_secvio_sc_get_state(struct secvio_sc_notifier_info *info);
> +
> +/**
> + * imx_secvio_sc_check_state() - Check the state of the SNVS
> + *
> + * If a security violation or a tamper is detected, the list of notifier
> + * (registered using register_imx_secvio_sc_notifier() ) will be called
> + *
> + * Return: 0 in case of success
> + */
> +int imx_secvio_sc_check_state(void);
> +
> +/**
> + * imx_secvio_sc_clear_state() - Clear the state of the SNVS
> + *
> + * @hpsvs: Value to write to HPSVS register
> + * @lps:   Value to write to LPS register
> + * @lptds: Value to write to LPTDSregister
> + *
> + * The function will write the value provided to the corresponding regis=
ter
> + * which will clear the status of the bits set.
> + *
> + * Return: 0 in case of success
> + */
> +int imx_secvio_sc_clear_state(u32 hpsvs, u32 lps, u32 lptds);
> +
> +/* Commands of the ioctl interface */
> +enum ioctl_cmd_t {
> +	GET_STATE,
> +	CHECK_STATE,
> +	CLEAR_STATE,
> +};
> +
> +/* Definition for the ioctl interface */
> +#define IMX_SECVIO_SC_GET_STATE   _IOR('S', GET_STATE, \
> +				       struct secvio_sc_notifier_info)
> +#define IMX_SECVIO_SC_CHECK_STATE _IO('S', CHECK_STATE)
> +#define IMX_SECVIO_SC_CLEAR_STATE _IOW('S', CLEAR_STATE, \
> +				       struct secvio_sc_notifier_info)
> +
> +#endif /* _MISC_IMX_SECVIO_SC_H_ */
> --=20
> 2.7.4
>=20
