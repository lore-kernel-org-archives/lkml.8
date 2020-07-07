Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED32B206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NL85UN27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgGGGlM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:41:12 -0400
Received: from mail-am6eur05on2075.outbound.protection.outlook.com ([40.107.22.75]:6268
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726788AbgGGGlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:41:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tt4RCgjwKvxKAg0aSUo3OvDzE6HPu0ZyQQ5epTHdVlMYw3QssDUJmz6VX3/JAh1d4CKvWx1xUm2UP6UAyj7+zZbqv+YKcX2xfzsbNF6nTCs/jbVrn1ICs6HXbDuxVQLSldl/DF8wKxCYwbvE5oF9swdr0C5SltJv5VHy8+Yw0fQYy38gAho/7PIMDLqb0QZH5FIa2NVCFxgXpCGDkO+ZPBKwQ9jNg4p9jEXOs1nHq0PvWuW/FRgabK66MjT76Zlu/q6b8Vr+xuzx/7S1Llz65lxwTjEn0anne3jojVLkz3gliZH8E13yOYY8VmOc0EWhjXrCopiqfR+pB5fbn5bQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFWb4wAK0oKh79g8U9N3UwaV+02+4PFgVtohqZO5wR8=;
 b=dxb2uIHIxrT3BoqWmXUGAQahhppR5zfabU6/xH34m+XUfa+I/MRYiTEX4hY8KePtQf91YLfM4Vf+0/dWkPja0XmCAAlFeiT5D/psgI/oe5FHCMyKZLkKLpa1+AaOdWT7laWg1d19db2KA67qbA1AAncCjJ5dYKjhRpAh8YCABmECZQnZG0pA0eqy88fOgybzNT0fULnkzSuYCcBlliaHzfjHFVkB3MlwMICnkCOzRmVjY/+aeDNTEn3WjSfk6hVly50LBkF+0xA7TbLBE8IwJMePWU3tW1fApGxHTYHbYCksyimtIbTdPDmPjCFqeRR9VG1oe1liV1HlKiSat55OAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFWb4wAK0oKh79g8U9N3UwaV+02+4PFgVtohqZO5wR8=;
 b=NL85UN27FzAasn9oLqXcrO68wRnV5LA83LlsBulvAfzZSlnJkbZiybkSENJbsuSwH1M/GYVnrdJv+6KTApdXfa85dNJJ9WoroSEhaHi6h1dwy5qyTgvwn0R0xuqwYZDnmL6fEo2MqrqJI8plyhxvRywyG5f5Kmpxgw4wI86TTRE=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB5320.eurprd04.prod.outlook.com (2603:10a6:20b:3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 06:41:04 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:41:04 +0000
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
Subject: Re: [PATCH 9/9] usb: cdns3: Impovement: simplify *switch_gadet and
 *switch_host
Thread-Topic: [PATCH 9/9] usb: cdns3: Impovement: simplify *switch_gadet and
 *switch_host
Thread-Index: AQHWT3AXFHF3xDPMa0+wH8koBQd7iaj7tFaA
Date:   Tue, 7 Jul 2020 06:41:04 +0000
Message-ID: <20200707064113.GH16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-10-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-10-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a4efd2ba-88d0-4753-160a-08d82240b8e3
x-ms-traffictypediagnostic: AM6PR04MB5320:
x-microsoft-antispam-prvs: <AM6PR04MB532025A1A5E24430339DFBA78B660@AM6PR04MB5320.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M/E1xvtZXCRane9Ped6sFnYbV2MHvp5NqrLXZ2QIUO+/16SmM2wsDSbYgzMTsBL+dypLSxql8B6UGSoASOe6iqV/oFKvTs2uMX4UD7webATUNqv7ZPxyJ/YedwV/MpfdrfVWCeiDdfh4xjAhqd1dAR818IawNZRtaJO9sXzbQKg8B0pZik9d5xf7mIq2JrHN//AsWhX+VsKuZ3tmAgI1Zda6xd5+C4UykMgOz3uOx6JIecygZTaju1JnNHJujV3/+NnRUz+aJKgapASo7ru1+zwmoS6CDL137GiPl3SRORCgQcj5Bi872j6cp//tlYxCFNd0fdqfAIEjn4PT25lOZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(7916004)(396003)(136003)(366004)(346002)(39860400002)(376002)(1076003)(44832011)(33716001)(26005)(186003)(6916009)(316002)(54906003)(71200400001)(6486002)(53546011)(6506007)(76116006)(478600001)(7416002)(8936002)(8676002)(4326008)(33656002)(2906002)(91956017)(66946007)(9686003)(6512007)(83380400001)(5660300002)(66556008)(66446008)(64756008)(66476007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2uXMY3mv6MGxOHNfdDPk8Rl/aL7B1/std0ELgYYXcx5Pt38L83nnm1cc42EHMnZQiKqFOMi6pOZpVyobe8scyZPkDz7XZqANAP/T4BS0gx/YeJEDptwnrWcU6NpOYzYYZiM0kAUCco8ImGFoW46gCt5X8eMOzO9pyOWLkKrCTv+elJMvIw2AgCBQSASHJQNRkpmltyxjVWYBMD0KAuDN9KsBNb3J74yBCq9dulB3ps5ymZUQQO41cSDu+Atu/5hu5YPlQ5nUJva8bpae9oB7rJ36nOtuzF0TWWiZ13mpsYSIKOabtFIss+o1dMU4dxuSaCqn93hIOinzSPuMk3k0CBiLkVe5IMSgLrTyaIYIk05PYn8q9U3WnEkR44DSW5fJT1A6JphAyAHQmtBx4mC3olTbAsCcMn4npEaxKQ7WT0SNDwtuNHeb6RbIprTPOsd+mF5OJ8Vt+1FrbAXzzXiGn4CleaN8uRfTkQCZ3CCtXqOcAAcyLb8sMRsnmSxHOX0S
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2008BCDC96AB6E46A96048B9CB2D69F9@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4efd2ba-88d0-4753-160a-08d82240b8e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:41:04.6841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bphzpZT2dNxaw79Z+gfqQnxn4CQjkJlvHpzgMSpt73WspXOdh6vWUz8oPU9Gj31DS/PvspjNFfRS53+itHvyRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5320
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:20:04, Pawel Laszczak wrote:
> Patch split function cdns3_drd_switch_gadget and
> cdns3_drd_switch_host into:
> - cdns3_drd_host_on
> - cdns3_drd_host_off
> - cdns3_drd_gadget_on
> - cdns3_drd_gadgett_off
>=20
> These functions don't have any shared code so it's better to
> have smaller, faster and easier functions.

Changes the patch title, otherwise:

Reviewed-by: Peter Chen <peter.chen@nxp.com>

Peter
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/drd.c    | 124 ++++++++++++++++++++-----------------
>  drivers/usb/cdns3/drd.h    |   6 +-
>  drivers/usb/cdns3/gadget.c |   4 +-
>  drivers/usb/cdns3/host.c   |   4 +-
>  4 files changed, 76 insertions(+), 62 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 8e7673da905e..6234bcd6158a 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -124,85 +124,97 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns=
)
>  }
> =20
>  /**
> - * cdns3_drd_switch_host - start/stop host
> - * @cdns: Pointer to controller context structure
> - * @on: 1 for start, 0 for stop
> + * cdns3_drd_host_on - start host.
> + * @cdns: Pointer to controller context structure.
>   *
> - * Returns 0 on success otherwise negative errno
> + * Returns 0 on success otherwise negative errno.
>   */
> -int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
> +int cdns3_drd_host_on(struct cdns3 *cdns)
>  {
> -	int ret, val;
> +	u32 val;
> +	int ret;
> =20
> -	/* switch OTG core */
> -	if (on) {
> -		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> -		       &cdns->otg_regs->cmd);
> -
> -		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
> -		ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> -						val & OTGSTS_XHCI_READY,
> -						1, 100000);
> -		if (ret) {
> -			dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
> -			return ret;
> -		}
> -	} else {
> -		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> -		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> -		       &cdns->otg_regs->cmd);
> -		/* Waiting till H_IDLE state.*/
> -		readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
> -					  !(val & OTGSTATE_HOST_STATE_MASK),
> -					  1, 2000000);
> -	}
> +	/* Enable host mode. */
> +	writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> +	       &cdns->otg_regs->cmd);
> =20
> -	return 0;
> +	dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
> +	ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> +					val & OTGSTS_XHCI_READY, 1, 100000);
> +
> +	if (ret)
> +		dev_err(cdns->dev, "timeout waiting for xhci_ready\n");
> +
> +	return ret;
>  }
> =20
>  /**
> - * cdns3_drd_switch_gadget - start/stop gadget
> - * @cdns: Pointer to controller context structure
> - * @on: 1 for start, 0 for stop
> + * cdns3_drd_host_off - stop host.
> + * @cdns: Pointer to controller context structure.
> + */
> +void cdns3_drd_host_off(struct cdns3 *cdns)
> +{
> +	u32 val;
> +
> +	writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +	       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +	       &cdns->otg_regs->cmd);
> +
> +	/* Waiting till H_IDLE state.*/
> +	readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
> +				  !(val & OTGSTATE_HOST_STATE_MASK),
> +				  1, 2000000);
> +}
> +
> +/**
> + * cdns3_drd_gadget_on - start gadget.
> + * @cdns: Pointer to controller context structure.
>   *
>   * Returns 0 on success otherwise negative errno
>   */
> -int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on)
> +int cdns3_drd_gadget_on(struct cdns3 *cdns)
>  {
>  	int ret, val;
>  	u32 reg =3D OTGCMD_OTG_DIS;
> =20
>  	/* switch OTG core */
> -	if (on) {
> -		writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +	writel(OTGCMD_DEV_BUS_REQ | reg, &cdns->otg_regs->cmd);
> =20
> -		dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
> +	dev_dbg(cdns->dev, "Waiting till Device mode is turned on\n");
> =20
> -		ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> -						val & OTGSTS_DEV_READY,
> -						1, 100000);
> -		if (ret) {
> -			dev_err(cdns->dev, "timeout waiting for dev_ready\n");
> -			return ret;
> -		}
> -	} else {
> -		/*
> -		 * driver should wait at least 10us after disabling Device
> -		 * before turning-off Device (DEV_BUS_DROP)
> -		 */
> -		usleep_range(20, 30);
> -		writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> -		       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> -		       &cdns->otg_regs->cmd);
> -		/* Waiting till DEV_IDLE state.*/
> -		readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
> -					  !(val & OTGSTATE_DEV_STATE_MASK),
> -					  1, 2000000);
> +	ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> +					val & OTGSTS_DEV_READY,
> +					1, 100000);
> +	if (ret) {
> +		dev_err(cdns->dev, "timeout waiting for dev_ready\n");
> +		return ret;
>  	}
> =20
>  	return 0;
>  }
> =20
> +/**
> + * cdns3_drd_gadget_off - stop gadget.
> + * @cdns: Pointer to controller context structure.
> + */
> +void cdns3_drd_gadget_off(struct cdns3 *cdns)
> +{
> +	u32 val;
> +
> +	/*
> +	 * Driver should wait at least 10us after disabling Device
> +	 * before turning-off Device (DEV_BUS_DROP).
> +	 */
> +	usleep_range(20, 30);
> +	writel(OTGCMD_HOST_BUS_DROP | OTGCMD_DEV_BUS_DROP |
> +	       OTGCMD_DEV_POWER_OFF | OTGCMD_HOST_POWER_OFF,
> +	       &cdns->otg_regs->cmd);
> +	/* Waiting till DEV_IDLE state.*/
> +	readl_poll_timeout_atomic(&cdns->otg_regs->state, val,
> +				  !(val & OTGSTATE_DEV_STATE_MASK),
> +				  1, 2000000);
> +}
> +
>  /**
>   * cdns3_init_otg_mode - initialize drd controller
>   * @cdns: Pointer to controller context structure
> diff --git a/drivers/usb/cdns3/drd.h b/drivers/usb/cdns3/drd.h
> index 3889fead9df1..7e7cf7fa2dd3 100644
> --- a/drivers/usb/cdns3/drd.h
> +++ b/drivers/usb/cdns3/drd.h
> @@ -163,8 +163,10 @@ int cdns3_get_vbus(struct cdns3 *cdns);
>  int cdns3_drd_init(struct cdns3 *cdns);
>  int cdns3_drd_exit(struct cdns3 *cdns);
>  int cdns3_drd_update_mode(struct cdns3 *cdns);
> -int cdns3_drd_switch_gadget(struct cdns3 *cdns, int on);
> -int cdns3_drd_switch_host(struct cdns3 *cdns, int on);
> +int cdns3_drd_gadget_on(struct cdns3 *cdns);
> +void cdns3_drd_gadget_off(struct cdns3 *cdns);
> +int cdns3_drd_host_on(struct cdns3 *cdns);
> +void cdns3_drd_host_off(struct cdns3 *cdns);
>  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode);
> =20
>  #endif /* __LINUX_CDNS3_DRD */
> diff --git a/drivers/usb/cdns3/gadget.c b/drivers/usb/cdns3/gadget.c
> index c303ab7c62d1..6ea6839a2a8c 100644
> --- a/drivers/usb/cdns3/gadget.c
> +++ b/drivers/usb/cdns3/gadget.c
> @@ -3014,7 +3014,7 @@ void cdns3_gadget_exit(struct cdns3 *cdns)
>  	kfree(priv_dev->zlp_buf);
>  	kfree(priv_dev);
>  	cdns->gadget_dev =3D NULL;
> -	cdns3_drd_switch_gadget(cdns, 0);
> +	cdns3_drd_gadget_off(cdns);
>  }
> =20
>  static int cdns3_gadget_start(struct cdns3 *cdns)
> @@ -3145,7 +3145,7 @@ static int __cdns3_gadget_init(struct cdns3 *cdns)
>  		return ret;
>  	}
> =20
> -	cdns3_drd_switch_gadget(cdns, 1);
> +	cdns3_drd_gadget_on(cdns);
>  	pm_runtime_get_sync(cdns->dev);
> =20
>  	ret =3D cdns3_gadget_start(cdns);
> diff --git a/drivers/usb/cdns3/host.c b/drivers/usb/cdns3/host.c
> index ad788bf3fe4f..36c63d9ecd37 100644
> --- a/drivers/usb/cdns3/host.c
> +++ b/drivers/usb/cdns3/host.c
> @@ -19,7 +19,7 @@ static int __cdns3_host_init(struct cdns3 *cdns)
>  	struct platform_device *xhci;
>  	int ret;
> =20
> -	cdns3_drd_switch_host(cdns, 1);
> +	cdns3_drd_host_on(cdns);
> =20
>  	xhci =3D platform_device_alloc("xhci-hcd", PLATFORM_DEVID_AUTO);
>  	if (!xhci) {
> @@ -53,7 +53,7 @@ static void cdns3_host_exit(struct cdns3 *cdns)
>  {
>  	platform_device_unregister(cdns->host_dev);
>  	cdns->host_dev =3D NULL;
> -	cdns3_drd_switch_host(cdns, 0);
> +	cdns3_drd_host_off(cdns);
>  }
> =20
>  int cdns3_host_init(struct cdns3 *cdns)
> --=20
> 2.17.1
>=20

--=20

Thanks,
Peter Chen=
