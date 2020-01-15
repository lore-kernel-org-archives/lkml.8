Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564EDC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F409B214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:54:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="jGjfFXEu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAOIyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:54:00 -0500
Received: from mail-vi1eur05on2048.outbound.protection.outlook.com ([40.107.21.48]:55393
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726513AbgAOIyA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:54:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CCKdXl31dvFtCRynRPe4RpYRLhFWMXL4dYsyHwN4sJpDB3vHvnwpJQo4zm53dv3Ewj0d5Dr5vSbP+yz1RA727+0ozcXeWsa0zdoGIVeIObe7NQdYcN4EPjBNVGjbKSUfiC6JVsHfC3dSbpWJjk8b4s5cgtT/MB+D/Xe1nOVOUdCdwZeqLvY/HWzmyqXUU+I2Qvb9VLZJwhNoTkyGIhCFl5stg2SkHP2Yp7XfCxr7WgDnP4uzFtvZJPhlPIglJvfMwK55AI7b9jBTzs33905Y2BoJIm2cYDOpU1p8vcehyhw1gXbwO40DRFTZvS1GFe5DYxJHl9/QT4YoU0CUTBiEXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La9Dn/y+YEM3TTF5VAeCdSECc9YgygdZdLTzpuvILKE=;
 b=DgfsJxqy7hl0m8Yls+vla5vf+5gw0uK/OK712coHhwCBPha+gzNzCS5zghBfME2wppZLT+XAVcVl7pse9E83PVhGaNb1/8/7eF9CRNlOw/b3LJK7CtbAKsQTIVDfI5rZaAihUH93OgXLGHUBA5rG9CL2azIEuL6r7lkqj49bJEMkp9LsbiJ2KkHk/QN1Yis0DM3kIF3mQ0R9JY+iDZm4ONB7z0iCv5EVcUuYYjSiLlM0Wn0h9fTdWQZvgLEMaPF8jiK7pDjhGGmKddtNWB2c/keCDF22YqeuZbqnOb3fZ/dRznQSV4jqIEzPrh7jmQxxOYx7IcsHNfAroYBRxNWIAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=La9Dn/y+YEM3TTF5VAeCdSECc9YgygdZdLTzpuvILKE=;
 b=jGjfFXEuKirJZPDnGY55a5t/Ajucj+IuQpskcvv44uHVxrc8v8qELAxLPrRkCVy5v9yIOiyE6VrK45Sy+Uqu4dZYpAcbhhokLgBFrAnXY7SrXOT9y72z7GCcckd7nZ/j3cb7J3gXjfuqjTmcqWE5YOPZKawoHAMcNLBgSBdC4LM=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6898.eurprd04.prod.outlook.com (52.132.214.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.18; Wed, 15 Jan 2020 08:53:51 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 08:53:51 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "cristian.marussi@arm.com" <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Topic: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
Thread-Index: AQHVx5pwG3O6xvtPWkmuLxJSz4SzNKfrcuWQ
Date:   Wed, 15 Jan 2020 08:53:51 +0000
Message-ID: <AM0PR04MB4481AA813CB53AC0D2C238C788370@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
In-Reply-To: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7dd0029-b3e9-47be-bfc8-08d7999871af
x-ms-traffictypediagnostic: AM0PR04MB6898:
x-microsoft-antispam-prvs: <AM0PR04MB6898F18AAFE4394E52D8742988370@AM0PR04MB6898.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-forefront-prvs: 02830F0362
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(189003)(199004)(81156014)(8936002)(81166006)(8676002)(186003)(7696005)(30864003)(26005)(44832011)(71200400001)(478600001)(6506007)(2906002)(55016002)(316002)(66946007)(66476007)(86362001)(4326008)(64756008)(66556008)(54906003)(52536014)(110136005)(33656002)(66446008)(9686003)(76116006)(5660300002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6898;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0XhAlceQ37LTfRucxZZXtqW/8UXg0LrcHYMt35PD/xHifT45h++9rYohQPjtx1UP1IvVjmksmOHVgEIQnrGcWAxk2sOHln9l9A2VISy+hvDs+RVLrujheDGCVusMf85k+XG0d9UjUbfjOKKipLM7w37uMgRySKH5XtuCJlMX1c8hxaSsgYSz2s2csfcmoD3QghmXoe/VeP0OZ/SjBf7Lh7J78fcUV9wj23mUG9dzDo7wNW5cYKaEqZAmGpc8wGTkdKBL4NsT96dcWsiOqFHna+7zhj8zwm3TvgXYuSlWh3pxshFBsl0pMQPcGlPFDKOJsNInt8ODE69Jc6ZPa4ng/QqxnLW58H9AVJ6mTm687nGCSBHfCydBBN/Z6U6p+1LWeujzoA/ynxMQQHnaOEBctKdq9qHRiOjgFhbwgcCoi5yPyptx0kgc+cOpES372bdA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd0029-b3e9-47be-bfc8-08d7999871af
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2020 08:53:51.7046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PAyEYRuQqKXoVAWkdMB73Gjufoh2nPP0uC7LrciEHv7WRTs3jXs2F9dX9Yl3oviNIIeEiVfdpBo9J/uMJTgalQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
> transport type
>=20
> The SCMI specification is fairly independent of the transport protocol, w=
hich
> can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent of the
> mailbox transport layer.
>=20
> This patch makes the SCMI core code (driver.c) independent of the mailbox
> transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>=20
> We can now implement more transport protocols to transport SCMI messages,
> some of the transport protocols getting discussed currently are SMC/HVC,
> SPCI (built on top of SMC/HVC), OPTEE based mailbox (similar to SPCI), an=
d
> vitio based transport as alternative to mailbox.
>=20
> The transport protocols just need to provide struct scmi_desc, which also
> implements the struct scmi_transport_ops.

I need put shmem for each protocol, is this expected?
Sudeep,
I am able to use smc to directly transport data,
with adding a new file, just named smc.c including a scmi_smc_desc,
But I not find a good way to pass smc id to smc transport file.

+       sram@910000 {
+               compatible =3D "mmio-sram";
+               reg =3D <0x0 0x93f000 0x0 0x1000>;
+
+               #address-cells =3D <1>;
+               #size-cells =3D <1>;
+               ranges =3D <0 0x0 0x93f000 0x1000>;
+
+               cpu_scp_lpri: scp-shmem@0 {
+                       compatible =3D "arm,scmi-shmem";
+                       reg =3D <0x0 0x200>;
+               };
+
+               cpu_scp_hpri: scp-shmem@200 {
+                       compatible =3D "arm,scmi-shmem";
+                       reg =3D <0x200 0x200>;
+               };
+       };
+
+       firmware {
+               scmi {
+                       compatible =3D "arm,scmi";
+                       shmem =3D <&cpu_scp_lpri>;
+                       transport =3D <1>;
+                       arm,func-id =3D <0xc20000fe>;
+                       #address-cells =3D <1>;
+                       #size-cells =3D <0>;
+
+                       scmi_devpd: protocol@11 {
+                               reg =3D <0x11>;
+                               shmem =3D <&cpu_scp_lpri>;
+                               #power-domain-cells =3D <1>;
+                       };
+
+                       scmi_clk: protocol@14 {
+                               reg =3D <0x14>;
+                               shmem =3D <&cpu_scp_lpri>;
+                               #clock-cells =3D <1>;
+                               clocks =3D <&osc_32k>, <&osc_24m>, <&clk_ex=
t1>, <&clk_ext2>,
+                                        <&clk_ext3>, <&clk_ext4>;
+                               clock-names =3D "osc_32k", "osc_24m", "clk_=
ext1", "clk_ext2",
+                                             "clk_ext3", "clk_ext4";
+                       };
+               };
+       };

Thanks,
Peng.
>=20
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Dropped __iomem from payload data.
> - Moved transport ops to scmi_desc, and that has a per transport
>   instance now which is differentiated using the compatible string.
> - Converted IS_ERR_OR_NULL to IS_ERR.
>=20
>  drivers/firmware/arm_scmi/Makefile  |   3 +-
>  drivers/firmware/arm_scmi/common.h  |  55 ++++++++++
> drivers/firmware/arm_scmi/driver.c  | 151 ++++++----------------------
> drivers/firmware/arm_scmi/mailbox.c | 144 ++++++++++++++++++++++++++
>  4 files changed, 233 insertions(+), 120 deletions(-)  create mode 100644
> drivers/firmware/arm_scmi/mailbox.c
>=20
> diff --git a/drivers/firmware/arm_scmi/Makefile
> b/drivers/firmware/arm_scmi/Makefile
> index 5f298f00a82e..df2c05a545d8 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y	=3D scmi-bus.o scmi-driver.o scmi-protocols.o
> +obj-y	=3D scmi-bus.o scmi-driver.o scmi-protocols.o scmi-transport.o
>  scmi-bus-y =3D bus.o
>  scmi-driver-y =3D driver.o
> +scmi-transport-y =3D mailbox.o
>  scmi-protocols-y =3D base.o clock.o perf.o power.o reset.o sensors.o
>  obj-$(CONFIG_ARM_SCMI_POWER_DOMAIN) +=3D scmi_pm_domain.o diff
> --git a/drivers/firmware/arm_scmi/common.h
> b/drivers/firmware/arm_scmi/common.h
> index 5237c2ff79fe..365368f8e6d1 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -111,3 +111,58 @@ void scmi_setup_protocol_implemented(const
> struct scmi_handle *handle,
>  				     u8 *prot_imp);
>=20
>  int scmi_base_protocol_init(struct scmi_handle *h);
> +
> +/* SCMI Transport */
> +
> +/**
> + * struct scmi_chan_info - Structure representing a SCMI channel
> +information
> + *
> + * @payload: Transmit/Receive payload area
> + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> + *	 channel
> + * @handle: Pointer to SCMI entity handle
> + * @transport_info: Transport layer related information  */ struct
> +scmi_chan_info {
> +	void *payload;
> +	struct device *dev;
> +	struct scmi_handle *handle;
> +	void *transport_info;
> +};
> +
> +/**
> + * struct scmi_transport_ops - Structure representing a SCMI transport
> +ops
> + *
> + * @send_message: Callback to send a message
> + * @mark_txdone: Callback to mark tx as done
> + * @chan_setup: Callback to allocate and setup a channel
> + * @chan_free: Callback to free a channel  */ struct scmi_transport_ops
> +{
> +	bool (*chan_available)(struct device *dev, int idx);
> +	int (*chan_setup)(struct scmi_chan_info *cinfo, bool tx);
> +	int (*chan_free)(int id, void *p, void *data);
> +	int (*send_message)(struct scmi_chan_info *cinfo, struct scmi_xfer
> *xfer);
> +	void (*mark_txdone)(struct scmi_chan_info *cinfo, int ret); };
> +
> +/**
> + * struct scmi_desc - Description of SoC integration
> + *
> + * @max_rx_timeout_ms: Timeout for communication with SoC (in
> +Milliseconds)
> + * @max_msg: Maximum number of messages that can be pending
> + *	simultaneously in the system
> + * @max_msg_size: Maximum size of data per message that can be handled.
> + */
> +struct scmi_desc {
> +	struct scmi_transport_ops *ops;
> +	int max_rx_timeout_ms;
> +	int max_msg;
> +	int max_msg_size;
> +};
> +
> +extern const struct scmi_desc scmi_mailbox_desc;
> +
> +void scmi_tx_prepare(struct scmi_chan_info *cinfo, struct scmi_xfer
> +*t); void scmi_rx_callback(struct scmi_chan_info *cinfo, struct
> +scmi_xfer *t); void scmi_free_channel(struct scmi_chan_info *cinfo,
> +struct idr *idr, int id);
> diff --git a/drivers/firmware/arm_scmi/driver.c
> b/drivers/firmware/arm_scmi/driver.c
> index 3eb0382491ce..e67fcbe27472 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -19,7 +19,6 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> -#include <linux/mailbox_client.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
> @@ -77,38 +76,6 @@ struct scmi_xfers_info {
>  	spinlock_t xfer_lock;
>  };
>=20
> -/**
> - * struct scmi_desc - Description of SoC integration
> - *
> - * @max_rx_timeout_ms: Timeout for communication with SoC (in
> Milliseconds)
> - * @max_msg: Maximum number of messages that can be pending
> - *	simultaneously in the system
> - * @max_msg_size: Maximum size of data per message that can be handled.
> - */
> -struct scmi_desc {
> -	int max_rx_timeout_ms;
> -	int max_msg;
> -	int max_msg_size;
> -};
> -
> -/**
> - * struct scmi_chan_info - Structure representing a SCMI channel informa=
tion
> - *
> - * @cl: Mailbox Client
> - * @chan: Transmit/Receive mailbox channel
> - * @payload: Transmit/Receive mailbox channel payload area
> - * @dev: Reference to device in the SCMI hierarchy corresponding to this
> - *	 channel
> - * @handle: Pointer to SCMI entity handle
> - */
> -struct scmi_chan_info {
> -	struct mbox_client cl;
> -	struct mbox_chan *chan;
> -	void __iomem *payload;
> -	struct device *dev;
> -	struct scmi_handle *handle;
> -};
> -
>  /**
>   * struct scmi_info - Structure representing a SCMI instance
>   *
> @@ -138,7 +105,6 @@ struct scmi_info {
>  	int users;
>  };
>=20
> -#define client_to_scmi_chan_info(c) container_of(c, struct scmi_chan_inf=
o,
> cl)
>  #define handle_to_scmi_info(h)	container_of(h, struct scmi_info, handle)
>=20
>  /*
> @@ -195,7 +161,7 @@ static inline void scmi_dump_header_dbg(struct
> device *dev,  }
>=20
>  static void scmi_fetch_response(struct scmi_xfer *xfer,
> -				struct scmi_shared_mem __iomem *mem)
> +				struct scmi_shared_mem *mem)
>  {
>  	xfer->hdr.status =3D ioread32(mem->msg_payload);
>  	/* Skip the length of header and status in payload area i.e 8 bytes */ =
@@
> -233,19 +199,17 @@ static inline void unpack_scmi_header(u32 msg_hdr,
> struct scmi_msg_hdr *hdr)  }
>=20
>  /**
> - * scmi_tx_prepare() - mailbox client callback to prepare for the transf=
er
> + * scmi_tx_prepare() - callback to prepare for the transfer
>   *
> - * @cl: client pointer
> - * @m: mailbox message
> + * @cinfo: SCMI channel info
> + * @t: transfer message
>   *
>   * This function prepares the shared memory which contains the header an=
d
> the
>   * payload.
>   */
> -static void scmi_tx_prepare(struct mbox_client *cl, void *m)
> +void scmi_tx_prepare(struct scmi_chan_info *cinfo, struct scmi_xfer *t)
>  {
> -	struct scmi_xfer *t =3D m;
> -	struct scmi_chan_info *cinfo =3D client_to_scmi_chan_info(cl);
> -	struct scmi_shared_mem __iomem *mem =3D cinfo->payload;
> +	struct scmi_shared_mem *mem =3D cinfo->payload;
>=20
>  	/*
>  	 * Ideally channel must be free by now unless OS timeout last @@
> -332,10 +296,10 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct
> scmi_xfer *xfer)  }
>=20
>  /**
> - * scmi_rx_callback() - mailbox client callback for receive messages
> + * scmi_rx_callback() - callback for receive messages
>   *
> - * @cl: client pointer
> - * @m: mailbox message
> + * @cinfo: SCMI channel info
> + * @t: transfer message
>   *
>   * Processes one received message to appropriate transfer information an=
d
>   * signals completion of the transfer.
> @@ -343,17 +307,16 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo,
> struct scmi_xfer *xfer)
>   * NOTE: This function will be invoked in IRQ context, hence should be
>   * as optimal as possible.
>   */
> -static void scmi_rx_callback(struct mbox_client *cl, void *m)
> +void scmi_rx_callback(struct scmi_chan_info *cinfo, struct scmi_xfer
> +*t)
>  {
>  	u8 msg_type;
>  	u32 msg_hdr;
>  	u16 xfer_id;
>  	struct scmi_xfer *xfer;
> -	struct scmi_chan_info *cinfo =3D client_to_scmi_chan_info(cl);
>  	struct device *dev =3D cinfo->dev;
>  	struct scmi_info *info =3D handle_to_scmi_info(cinfo->handle);
>  	struct scmi_xfers_info *minfo =3D &info->tx_minfo;
> -	struct scmi_shared_mem __iomem *mem =3D cinfo->payload;
> +	struct scmi_shared_mem *mem =3D cinfo->payload;
>=20
>  	msg_hdr =3D ioread32(&mem->msg_header);
>  	msg_type =3D MSG_XTRACT_TYPE(msg_hdr);
> @@ -396,7 +359,7 @@ void scmi_xfer_put(const struct scmi_handle *handle,
> struct scmi_xfer *xfer)  static bool  scmi_xfer_poll_done(const struct
> scmi_chan_info *cinfo, struct scmi_xfer *xfer)  {
> -	struct scmi_shared_mem __iomem *mem =3D cinfo->payload;
> +	struct scmi_shared_mem *mem =3D cinfo->payload;
>  	u16 xfer_id =3D MSG_XTRACT_TOKEN(ioread32(&mem->msg_header));
>=20
>  	if (xfer->hdr.seq !=3D xfer_id)
> @@ -439,15 +402,12 @@ int scmi_do_xfer(const struct scmi_handle *handle,
> struct scmi_xfer *xfer)
>  	if (unlikely(!cinfo))
>  		return -EINVAL;
>=20
> -	ret =3D mbox_send_message(cinfo->chan, xfer);
> +	ret =3D info->desc->ops->send_message(cinfo, xfer);
>  	if (ret < 0) {
> -		dev_dbg(dev, "mbox send fail %d\n", ret);
> +		dev_dbg(dev, "Failed to send message %d\n", ret);
>  		return ret;
>  	}
>=20
> -	/* mbox_send_message returns non-negative value on success, so reset
> */
> -	ret =3D 0;
> -
>  	if (xfer->hdr.poll_completion) {
>  		ktime_t stop =3D ktime_add_ns(ktime_get(),
> SCMI_MAX_POLL_TO_NS);
>=20
> @@ -461,7 +421,7 @@ int scmi_do_xfer(const struct scmi_handle *handle,
> struct scmi_xfer *xfer)
>  		/* And we wait for the response. */
>  		timeout =3D msecs_to_jiffies(info->desc->max_rx_timeout_ms);
>  		if (!wait_for_completion_timeout(&xfer->done, timeout)) {
> -			dev_err(dev, "mbox timed out in resp(caller: %pS)\n",
> +			dev_err(dev, "timed out in resp(caller: %pS)\n",
>  				(void *)_RET_IP_);
>  			ret =3D -ETIMEDOUT;
>  		}
> @@ -470,13 +430,7 @@ int scmi_do_xfer(const struct scmi_handle *handle,
> struct scmi_xfer *xfer)
>  	if (!ret && xfer->hdr.status)
>  		ret =3D scmi_to_linux_errno(xfer->hdr.status);
>=20
> -	/*
> -	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> -	 * transfer queueing since the protocol layer queues things by itself.
> -	 * Unfortunately, we have to kick the mailbox framework after we have
> -	 * received our message.
> -	 */
> -	mbox_client_txdone(cinfo->chan, ret);
> +	info->desc->ops->mark_txdone(cinfo, ret);
>=20
>  	return ret;
>  }
> @@ -713,21 +667,14 @@ static int scmi_xfer_info_init(struct scmi_info
> *sinfo)
>  	return 0;
>  }
>=20
> -static int scmi_mailbox_check(struct device_node *np, int idx) -{
> -	return of_parse_phandle_with_args(np, "mboxes", "#mbox-cells",
> -					  idx, NULL);
> -}
> -
> -static int scmi_mbox_chan_setup(struct scmi_info *info, struct device *d=
ev,
> -				int prot_id, bool tx)
> +static int scmi_chan_setup(struct scmi_info *info, struct device *dev,
> +			   int prot_id, bool tx)
>  {
>  	int ret, idx;
>  	struct resource res;
>  	resource_size_t size;
> -	struct device_node *shmem, *np =3D dev->of_node;
> +	struct device_node *shmem;
>  	struct scmi_chan_info *cinfo;
> -	struct mbox_client *cl;
>  	struct idr *idr;
>  	const char *desc =3D tx ? "Tx" : "Rx";
>=20
> @@ -735,7 +682,7 @@ static int scmi_mbox_chan_setup(struct scmi_info
> *info, struct device *dev,
>  	idx =3D tx ? 0 : 1;
>  	idr =3D tx ? &info->tx_idr : &info->rx_idr;
>=20
> -	if (scmi_mailbox_check(np, idx)) {
> +	if (!info->desc->ops->chan_available(dev, idx)) {
>  		cinfo =3D idr_find(idr, SCMI_PROTOCOL_BASE);
>  		if (unlikely(!cinfo)) /* Possible only if platform has no Rx */
>  			return -EINVAL;
> @@ -748,14 +695,7 @@ static int scmi_mbox_chan_setup(struct scmi_info
> *info, struct device *dev,
>=20
>  	cinfo->dev =3D dev;
>=20
> -	cl =3D &cinfo->cl;
> -	cl->dev =3D dev;
> -	cl->rx_callback =3D scmi_rx_callback;
> -	cl->tx_prepare =3D tx ? scmi_tx_prepare : NULL;
> -	cl->tx_block =3D false;
> -	cl->knows_txdone =3D tx;
> -
> -	shmem =3D of_parse_phandle(np, "shmem", idx);
> +	shmem =3D of_parse_phandle(dev->of_node, "shmem", idx);
>  	ret =3D of_address_to_resource(shmem, 0, &res);
>  	of_node_put(shmem);
>  	if (ret) {
> @@ -770,14 +710,9 @@ static int scmi_mbox_chan_setup(struct scmi_info
> *info, struct device *dev,
>  		return -EADDRNOTAVAIL;
>  	}
>=20
> -	cinfo->chan =3D mbox_request_channel(cl, idx);
> -	if (IS_ERR(cinfo->chan)) {
> -		ret =3D PTR_ERR(cinfo->chan);
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(dev, "failed to request SCMI %s mailbox\n",
> -				desc);
> +	ret =3D info->desc->ops->chan_setup(cinfo, tx);
> +	if (ret)
>  		return ret;
> -	}
>=20
>  idr_alloc:
>  	ret =3D idr_alloc(idr, cinfo, prot_id, prot_id + 1, GFP_KERNEL); @@ -79=
1,12
> +726,12 @@ static int scmi_mbox_chan_setup(struct scmi_info *info, struct
> device *dev,  }
>=20
>  static inline int
> -scmi_mbox_txrx_setup(struct scmi_info *info, struct device *dev, int pro=
t_id)
> +scmi_txrx_setup(struct scmi_info *info, struct device *dev, int
> +prot_id)
>  {
> -	int ret =3D scmi_mbox_chan_setup(info, dev, prot_id, true);
> +	int ret =3D scmi_chan_setup(info, dev, prot_id, true);
>=20
>  	if (!ret) /* Rx is optional, hence no error check */
> -		scmi_mbox_chan_setup(info, dev, prot_id, false);
> +		scmi_chan_setup(info, dev, prot_id, false);
>=20
>  	return ret;
>  }
> @@ -814,7 +749,7 @@ scmi_create_protocol_device(struct device_node *np,
> struct scmi_info *info,
>  		return;
>  	}
>=20
> -	if (scmi_mbox_txrx_setup(info, &sdev->dev, prot_id)) {
> +	if (scmi_txrx_setup(info, &sdev->dev, prot_id)) {
>  		dev_err(&sdev->dev, "failed to setup transport\n");
>  		scmi_device_destroy(sdev);
>  		return;
> @@ -833,12 +768,6 @@ static int scmi_probe(struct platform_device *pdev)
>  	struct device *dev =3D &pdev->dev;
>  	struct device_node *child, *np =3D dev->of_node;
>=20
> -	/* Only mailbox method supported, check for the presence of one */
> -	if (scmi_mailbox_check(np, 0)) {
> -		dev_err(dev, "no mailbox found in %pOF\n", np);
> -		return -EINVAL;
> -	}
> -
>  	desc =3D of_device_get_match_data(dev);
>  	if (!desc)
>  		return -EINVAL;
> @@ -863,7 +792,7 @@ static int scmi_probe(struct platform_device *pdev)
>  	handle->dev =3D info->dev;
>  	handle->version =3D &info->version;
>=20
> -	ret =3D scmi_mbox_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
> +	ret =3D scmi_txrx_setup(info, dev, SCMI_PROTOCOL_BASE);
>  	if (ret)
>  		return ret;
>=20
> @@ -898,19 +827,9 @@ static int scmi_probe(struct platform_device *pdev)
>  	return 0;
>  }
>=20
> -static int scmi_mbox_free_channel(int id, void *p, void *data)
> +void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr,
> +int id)
>  {
> -	struct scmi_chan_info *cinfo =3D p;
> -	struct idr *idr =3D data;
> -
> -	if (!IS_ERR_OR_NULL(cinfo->chan)) {
> -		mbox_free_channel(cinfo->chan);
> -		cinfo->chan =3D NULL;
> -	}
> -
>  	idr_remove(idr, id);
> -
> -	return 0;
>  }
>=20
>  static int scmi_remove(struct platform_device *pdev) @@ -930,25 +849,19
> @@ static int scmi_remove(struct platform_device *pdev)
>  		return ret;
>=20
>  	/* Safe to free channels since no more users */
> -	ret =3D idr_for_each(idr, scmi_mbox_free_channel, idr);
> +	ret =3D idr_for_each(idr, info->desc->ops->chan_free, idr);
>  	idr_destroy(&info->tx_idr);
>=20
>  	idr =3D &info->rx_idr;
> -	ret =3D idr_for_each(idr, scmi_mbox_free_channel, idr);
> +	ret =3D idr_for_each(idr, info->desc->ops->chan_free, idr);
>  	idr_destroy(&info->rx_idr);
>=20
>  	return ret;
>  }
>=20
> -static const struct scmi_desc scmi_generic_desc =3D {
> -	.max_rx_timeout_ms =3D 30,	/* We may increase this if required */
> -	.max_msg =3D 20,		/* Limited by MBOX_TX_QUEUE_LEN */
> -	.max_msg_size =3D 128,
> -};
> -
>  /* Each compatible listed below must have descriptor associated with it =
*/
> static const struct of_device_id scmi_of_match[] =3D {
> -	{ .compatible =3D "arm,scmi", .data =3D &scmi_generic_desc },
> +	{ .compatible =3D "arm,scmi", .data =3D &scmi_mailbox_desc },
>  	{ /* Sentinel */ },
>  };
>=20
> diff --git a/drivers/firmware/arm_scmi/mailbox.c
> b/drivers/firmware/arm_scmi/mailbox.c
> new file mode 100644
> index 000000000000..2d1f7c8be293
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/mailbox.c
> @@ -0,0 +1,144 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * System Control and Management Interface (SCMI) Message Mailbox
> +Transport driver
> + *
> + * Copyright (C) 2019 ARM Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/device.h>
> +#include <linux/mailbox_client.h>
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "common.h"
> +
> +/**
> + * struct scmi_mailbox - Structure representing a SCMI mailbox
> +transport
> + *
> + * @cl: Mailbox Client
> + * @chan: Transmit/Receive mailbox channel
> + * @cinfo: SCMI channel info
> + */
> +struct scmi_mailbox {
> +	struct mbox_client cl;
> +	struct mbox_chan *chan;
> +	struct scmi_chan_info *cinfo;
> +};
> +
> +#define client_to_scmi_mailbox(c) container_of(c, struct scmi_mailbox,
> +cl)
> +
> +static bool mailbox_chan_available(struct device *dev, int idx) {
> +	return !of_parse_phandle_with_args(dev->of_node, "mboxes",
> +					   "#mbox-cells", idx, NULL);
> +}
> +
> +static void mailbox_tx_prepare(struct mbox_client *cl, void *m) {
> +	struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
> +	struct scmi_chan_info *cinfo =3D smbox->cinfo;
> +
> +	scmi_tx_prepare(cinfo, m);
> +}
> +
> +static void mailbox_rx_callback(struct mbox_client *cl, void *m) {
> +	struct scmi_mailbox *smbox =3D client_to_scmi_mailbox(cl);
> +	struct scmi_chan_info *cinfo =3D smbox->cinfo;
> +
> +	scmi_rx_callback(cinfo, m);
> +}
> +
> +static int mailbox_chan_setup(struct scmi_chan_info *cinfo, bool tx) {
> +	struct device *dev =3D cinfo->dev;
> +	struct scmi_mailbox *smbox;
> +	struct mbox_client *cl;
> +	int ret;
> +
> +	smbox =3D devm_kzalloc(dev, sizeof(*smbox), GFP_KERNEL);
> +	if (!smbox)
> +		return -ENOMEM;
> +
> +	cl =3D &smbox->cl;
> +	cl->dev =3D dev;
> +	cl->tx_prepare =3D tx ? mailbox_tx_prepare : NULL;
> +	cl->rx_callback =3D mailbox_rx_callback;
> +	cl->tx_block =3D false;
> +	cl->knows_txdone =3D tx;
> +
> +	smbox->chan =3D mbox_request_channel(cl, tx ? 0 : 1);
> +	if (IS_ERR(smbox->chan)) {
> +		ret =3D PTR_ERR(smbox->chan);
> +		if (ret !=3D -EPROBE_DEFER)
> +			dev_err(dev, "failed to request SCMI %s mailbox\n",
> +				tx ? "Tx" : "Rx");
> +		return ret;
> +	}
> +
> +	cinfo->transport_info =3D smbox;
> +	smbox->cinfo =3D cinfo;
> +
> +	return 0;
> +}
> +
> +static int mailbox_chan_free(int id, void *p, void *data) {
> +	struct scmi_chan_info *cinfo =3D p;
> +	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> +
> +	if (!IS_ERR(smbox->chan)) {
> +		mbox_free_channel(smbox->chan);
> +		cinfo->transport_info =3D NULL;
> +		smbox->chan =3D NULL;
> +		smbox->cinfo =3D NULL;
> +	}
> +
> +	scmi_free_channel(cinfo, data, id);
> +
> +	return 0;
> +}
> +
> +static int mailbox_send_message(struct scmi_chan_info *cinfo,
> +			struct scmi_xfer *xfer)
> +{
> +	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> +	int ret;
> +
> +	ret =3D mbox_send_message(smbox->chan, xfer);
> +
> +	/* mbox_send_message returns non-negative value on success, so reset
> */
> +	if (ret > 0)
> +		ret =3D 0;
> +
> +	return ret;
> +}
> +
> +static void mailbox_mark_txdone(struct scmi_chan_info *cinfo, int ret)
> +{
> +	struct scmi_mailbox *smbox =3D cinfo->transport_info;
> +
> +	/*
> +	 * NOTE: we might prefer not to need the mailbox ticker to manage the
> +	 * transfer queueing since the protocol layer queues things by itself.
> +	 * Unfortunately, we have to kick the mailbox framework after we have
> +	 * received our message.
> +	 */
> +	mbox_client_txdone(smbox->chan, ret);
> +}
> +
> +static struct scmi_transport_ops scmi_mailbox_ops =3D {
> +	.chan_available =3D mailbox_chan_available,
> +	.chan_setup =3D mailbox_chan_setup,
> +	.chan_free =3D mailbox_chan_free,
> +	.send_message =3D mailbox_send_message,
> +	.mark_txdone =3D mailbox_mark_txdone,
> +};
> +
> +const struct scmi_desc scmi_mailbox_desc =3D {
> +	.ops =3D &scmi_mailbox_ops,
> +	.max_rx_timeout_ms =3D 30, /* We may increase this if required */
> +	.max_msg =3D 20, /* Limited by MBOX_TX_QUEUE_LEN */
> +	.max_msg_size =3D 128,
> +};
> --
> 2.21.0.rc0.269.g1a574e7a288b

