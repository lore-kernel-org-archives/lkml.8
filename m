Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0EAC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEBD7206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="U86HcaIj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGGGXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:23:37 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:26035
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726434AbgGGGXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:23:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjnQgNpVRv69+Po7DWZCLRFAUNKPqS8aT/WR1M/EDXq66C/JEBwJ0L2tmsJgEXkb3y+lCpCp9VDcwFKQ5KJa7LgTTaZtJE+Cf1i8luXBE+KuUUR+/BdT70POEm/Ql/iJWZKyTKSnANX6jXhfLEv+y6hRr6qoQszZEtK7UviDNbWr/f3CLfMepXfAWJsKaQZHmsQbkxLEHjuSUb7c452n62Q62/OdrDx6l65YA8o2VYklRZf/QKOkcnduJBZ7DqZaS/1hTIANEsI2euF9UbWlySQHX/nc1rLXh/bb8zT0neMRrYBF7/qwjvOOBM46NE8BaVFDwU27q9/ZV2abq4XFVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44BWWOa6UVGiiCGBh0u1di7fzVuRl+0aTmpI6G0e3+0=;
 b=JDEd9/hd/CYWuqOSCKYiV/MJbI/L3GNm/HybHxiOfljO1KPiuPhz7mADE2BgOywLf4E6LDa4gNGmc5z2uwlwcdNdm90vn73wgV3yp3pRznLevVxGmTjLFS99Fh6AF5YodMkKgWSeyki1NWMryix73kMGoqZ46F6u5VgGu48Dwsdz9CSv7N+BxSlNO4OYTfJHobxNOITYg5S9uSSUVocmq86zH0ZuoBR8PFcxkZIlP0Z3/XkB90iUJmQ+px0MUhmQ7G7WieNibFUi3WbEKvF6HL14QG9Z/okPlIs3iFrZ/CP9gE2nQMbreITxW72nmSIothM7qdUKOJsw08/UB3BvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44BWWOa6UVGiiCGBh0u1di7fzVuRl+0aTmpI6G0e3+0=;
 b=U86HcaIjgMxDN6qZSXux/ouOazYU95T1epBpf4jocIjPxUhcT36nAvzJTMwGZUqZ3iJKeLxA8Ar3/CGD9/ylXQE/CyWqs8RbaCJdKud9QIkOcDcSix8WfkvmxVdZDSpm5Fi4nOsBRwye4a/ofhDQX4stpRuqc+g8NUbHOLpLb2Y=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM7PR04MB6998.eurprd04.prod.outlook.com (2603:10a6:20b:10a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Tue, 7 Jul
 2020 06:23:33 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:23:32 +0000
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
Subject: Re: [PATCH 2/9] usb: cdns3: Improvement: removed not needed variables
 initialization
Thread-Topic: [PATCH 2/9] usb: cdns3: Improvement: removed not needed
 variables initialization
Thread-Index: AQHWT3A7xx5kHJrdX06bV9HY3fSaRaj7r3CA
Date:   Tue, 7 Jul 2020 06:23:32 +0000
Message-ID: <20200707062341.GC16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-3-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-3-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 225eae09-5bfb-4910-091c-08d8223e45b7
x-ms-traffictypediagnostic: AM7PR04MB6998:
x-microsoft-antispam-prvs: <AM7PR04MB69987E5B74AACDCC37F01A9A8B660@AM7PR04MB6998.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:235;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DG1Ue5aEvkga8Zaxq2sRFOPFcu1ZJAge10lTNa/qCX6NTwsk8eGjWF9dmL34pfOy8MW6ChYlO1zx5DonhiTO8qdiSV7dysS4lY7yW9UdpiZCow2r/9ieac+QcrGbMuh4IhFxrqQmG1YUklmRfN0vynhyoHZ74Kkh8sRpMUX3i4ClZhWO3ifmotGKHH8a+MjITyHV1x99JCtXxRAeUkR8i1TGCl4RCzSh4MNNaSXuX7sNSsd0fLyOwceVYlKCkroQGWOFZ2slx363QeWfzvsbK5zrAORjKJFC9RiHw7pbOQW2syuOJjvyGWo1VkyRPR/vtG9VBi7TZs1D4sGrR/3xYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(376002)(346002)(366004)(396003)(136003)(8936002)(478600001)(44832011)(54906003)(316002)(8676002)(7416002)(86362001)(6512007)(9686003)(71200400001)(2906002)(33716001)(6916009)(66476007)(91956017)(66556008)(64756008)(1076003)(76116006)(4326008)(6506007)(53546011)(66446008)(66946007)(6486002)(33656002)(186003)(5660300002)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: F5gt+Kj/nZICxD1t0ZcOuTtprHPTvOWCUyYkqVM8AoU2+YsSKXnwJWBpcoyHHm5lGXeZk8m8LshvxAya2FBpyPlSQKbIS4Qe+Wur3ojETPnQi8Te19ppb2S7XWjbW3X2+agm+fj8q4hacH3NpcaCj7TOFj+4d6O6BuphmhN6cR/7AeUmn81JH8cC9FIGUqLQ5wnatVXnL9vmpzVhW5Ga8/w0J9pcZfB/qYsV3BwX99PmWPwAZI2TgmlR45f5EeZKhkvFLMD3m6ctei0wgbNiXpmKaOAb6cFkLqXwMDymCpev4K+ynZgkDujG9SN0FJ8ZxRcJXSbG1xpW1RR3f+dihyWPw+QfXw72C6IeZsCMyZWOsiXV4oyhWMkDmaFKdcSVNs1YhZ3go4Yr8hPg8SY8M8hQiJRlasi90n6ojXiOMMyzHWzdq+/ApGwDefUNrI8+egRG2iOqiHPR+injF0zGBzRpiuWz+GI5OjpVwphLZgWJm8ja6INFLhp0hTEVPX6/
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <514EFFB0D0B15F4B8C8337D08E321627@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 225eae09-5bfb-4910-091c-08d8223e45b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:23:32.4371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PYlXgyEgyYiL4dYrelC9OqLFCbQnZr0v9RJsn7GwYH3p8XuhBxuA6OpmICmOE8FYozsbINpkB3elA+mzQFdrqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6998
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:19:57, Pawel Laszczak wrote:
> Patch remove some variables initialization from core.c and drd.c
> file.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c |  4 ++--
>  drivers/usb/cdns3/drd.c  | 19 +++++++++----------
>  2 files changed, 11 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index eaafa6bd2a50..c3dac945f63d 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -86,7 +86,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  	struct device *dev =3D cdns->dev;
>  	enum usb_dr_mode best_dr_mode;
>  	enum usb_dr_mode dr_mode;
> -	int ret =3D 0;
> +	int ret;
> =20
>  	dr_mode =3D usb_get_dr_mode(dev);
>  	cdns->role =3D USB_ROLE_NONE;
> @@ -177,7 +177,7 @@ static int cdns3_core_init_role(struct cdns3 *cdns)
>  		goto err;
>  	}
> =20
> -	return ret;
> +	return 0;
>  err:
>  	cdns3_exit_roles(cdns);
>  	return ret;
> diff --git a/drivers/usb/cdns3/drd.c b/drivers/usb/cdns3/drd.c
> index 58089841ed52..4939a568d8a2 100644
> --- a/drivers/usb/cdns3/drd.c
> +++ b/drivers/usb/cdns3/drd.c
> @@ -29,7 +29,6 @@
>   */
>  int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode mode)
>  {
> -	int ret =3D 0;
>  	u32 reg;
> =20
>  	switch (mode) {
> @@ -61,7 +60,7 @@ int cdns3_set_mode(struct cdns3 *cdns, enum usb_dr_mode=
 mode)
>  		return -EINVAL;
>  	}
> =20
> -	return ret;
> +	return 0;
>  }
> =20
>  int cdns3_get_id(struct cdns3 *cdns)
> @@ -134,11 +133,11 @@ static void cdns3_otg_enable_irq(struct cdns3 *cdns=
)
>  int cdns3_drd_switch_host(struct cdns3 *cdns, int on)
>  {
>  	int ret, val;
> -	u32 reg =3D OTGCMD_OTG_DIS;
> =20
>  	/* switch OTG core */
>  	if (on) {
> -		writel(OTGCMD_HOST_BUS_REQ | reg, &cdns->otg_regs->cmd);
> +		writel(OTGCMD_HOST_BUS_REQ | OTGCMD_OTG_DIS,
> +		       &cdns->otg_regs->cmd);
> =20
>  		dev_dbg(cdns->dev, "Waiting till Host mode is turned on\n");
>  		ret =3D readl_poll_timeout_atomic(&cdns->otg_regs->sts, val,
> @@ -212,7 +211,7 @@ int cdns3_drd_switch_gadget(struct cdns3 *cdns, int o=
n)
>   */
>  static int cdns3_init_otg_mode(struct cdns3 *cdns)
>  {
> -	int ret =3D 0;
> +	int ret;
> =20
>  	cdns3_otg_disable_irq(cdns);
>  	/* clear all interrupts */
> @@ -223,7 +222,8 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
>  		return ret;
> =20
>  	cdns3_otg_enable_irq(cdns);
> -	return ret;
> +
> +	return 0;
>  }
> =20
>  /**
> @@ -234,7 +234,7 @@ static int cdns3_init_otg_mode(struct cdns3 *cdns)
>   */
>  int cdns3_drd_update_mode(struct cdns3 *cdns)
>  {
> -	int ret =3D 0;
> +	int ret;
> =20
>  	switch (cdns->dr_mode) {
>  	case USB_DR_MODE_PERIPHERAL:
> @@ -307,8 +307,8 @@ static irqreturn_t cdns3_drd_irq(int irq, void *data)
>  int cdns3_drd_init(struct cdns3 *cdns)
>  {
>  	void __iomem *regs;
> -	int ret =3D 0;
>  	u32 state;
> +	int ret;
> =20
>  	regs =3D devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>  	if (IS_ERR(regs))
> @@ -359,7 +359,6 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  					cdns3_drd_thread_irq,
>  					IRQF_SHARED,
>  					dev_name(cdns->dev), cdns);
> -
>  	if (ret) {
>  		dev_err(cdns->dev, "couldn't get otg_irq\n");
>  		return ret;
> @@ -371,7 +370,7 @@ int cdns3_drd_init(struct cdns3 *cdns)
>  		return -ENODEV;
>  	}
> =20
> -	return ret;
> +	return 0;

Is this necessary?

--=20

Thanks,
Peter Chen=
