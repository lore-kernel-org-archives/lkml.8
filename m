Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA993C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 869EA222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aCOz3wD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgBGCQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:16:50 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:35964
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726956AbgBGCQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:16:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTZtI7ZmZv9K3HbRw/KwasNDKcToG/ufKeCJfDs2XKh830IaXTVfMlOkbrWlnDxYfuUbxOivdoCloPyGqRswaf5ko4X3expkwyLKHpeTyY67/hUK12tw6hm9n9NDh+DPh6FISlFfX1f6PJgPHvANc+4D9DmgH8fkw/OhJUdBEjxtJ0Ft1RPMEGI1x9eiDYv2aDzZi+OnFfsYYKCFGLwPxmheR5QU+XCnvEcHedp/8yMLtBHzThqWdRG/f9T68dd7ocZm5W1JOSLdgs/iEUhYVoBHLupkTlGHNAzQj2xhau46ptn87+qpObyadF7A3wZoVhOy8XVfiIqwu25yVR7Qyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLPdVFnrQtiq9mtFw++tvHD9dlYAIDzdaZU8wgIBhYc=;
 b=ZxxsTlu07K/T4XZvYjXNR1JgQ3mvnRZvg803OdqyXs4+vQkoldO4UYZL6fa4QQ00fUza2UmAX5jRRVO2kotMF8fpluc5cdDBOW6E/3EO99U0tb1PC15QUJhnjqTDLEbkiA8WZrlO/jBtYUh2UFzAbmgAEuWxo1bkMYVEkMiBKRvRJaOMoIJrqOr/AYiZAY6bhfoOEXwDENpF/+I+oSZvAwJrRKI26Tfn5Gw8z2KFX7yjy/YREXa3lpIKc/FqB3K/DBCKun2BU6P/tdbGEaYZVbSd0ahif9lrleuj13mA+HuVLB1IIpjRubFD4+pGCtbzgfop7ZG6SVJP9SXVwpLzXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLPdVFnrQtiq9mtFw++tvHD9dlYAIDzdaZU8wgIBhYc=;
 b=aCOz3wD19/M9qV2/12PIj/jpa2ETDw0oKuY1f/bMfSVxPh/ILQUIzXeDWMXLoRUGb/cSRgHDJTOTW0eCUB82IvYvsyFZtwzPXqx6nmGUIi9sPgsHk6UEx/6yQ/d1lmbNy2BQ1qcC6OCH2LMoSelAZsQXzlYaPAbciHVtd1oFNIA=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6962.eurprd04.prod.outlook.com (52.132.214.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 02:16:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.020; Fri, 7 Feb 2020
 02:16:04 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] firmware: arm_scmi: mark channel free when init
Thread-Topic: [PATCH 2/2] firmware: arm_scmi: mark channel free when init
Thread-Index: AQHV3O25X/FFlEFpBUK1Q7PthmZs26gOOvqAgADCJ6A=
Date:   Fri, 7 Feb 2020 02:16:04 +0000
Message-ID: <AM0PR04MB44817B64CB35B2B2FB50D8F7881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580993846-17712-1-git-send-email-peng.fan@nxp.com>
 <1580993846-17712-2-git-send-email-peng.fan@nxp.com>
 <20200206143337.GC3383@bogus>
In-Reply-To: <20200206143337.GC3383@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 126afa4f-9721-4db3-bbdb-08d7ab73af6d
x-ms-traffictypediagnostic: AM0PR04MB6962:|AM0PR04MB6962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB6962E50A9D1A286E172A0490881C0@AM0PR04MB6962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(199004)(189003)(6506007)(81166006)(81156014)(8676002)(44832011)(54906003)(316002)(66476007)(64756008)(66556008)(52536014)(5660300002)(71200400001)(66446008)(8936002)(66946007)(76116006)(6916009)(55016002)(4326008)(7696005)(9686003)(33656002)(2906002)(86362001)(26005)(186003)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6962;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /PowTgFWjOzezxxbJEwV+xIvXP1U0TwrHiqvLNW2PqExNYXuAZxm9JAmBmyFY8WFjHPiN6of13ztZba7DdlxaaUfHnrvR7zp2Q7c8CcEZTCC7yzAYdql6P7lZc9LkSUmYCM5LUhHNuFAdp5LjD/B820oLzvPqx2Hxivgz+WMVjXT3lD0wUZ3JZhyuMFGeuS5qMKOFYtgNDWR/7FDSwIzLYSnw/LK2PAWQ5WOobN9FHRExo4JcxHre53SbtDrS6Kkr0XjJvfh7mGcJ8PQTRgZKJgh4B88W7rQ8TvbLa9pSbDxskWOeyFFdBdMfDV/fKxEgABc6nmmxtjMjYhMAP36IVg/nMiE47lXUFHHKipqp0rfkT2fEV6gRsvsuOX9Zq8WpRFiFwTpL2LimuXcn44aEA1hA7AWK+DnF+sqRoUB1XHSvlxbXGB3LPgty3S/onv7
x-ms-exchange-antispam-messagedata: MGmcEwtdUGzQABjUgiyoeWO+k0Hdsqz9kxa1Dq1Mo/YmxIbg98kzHfoB6Ip3V2pclratrosHmW2Hxsjhl4qfOQVzamHo1yUAn2qPPXcAvgc0w7ybt6lMW7yj6DxTtCN6ihP8ecNo1r4NIqbJAfIxXg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 126afa4f-9721-4db3-bbdb-08d7ab73af6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 02:16:04.7678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtH6F7wPBTpWIlELwzlkNzmeVhN3nCh1KqePFtQMbIwqrx6OsB6ovzQrg10BHJYwRqgHmv1cjPyGu8LuinGRtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Subject: Re: [PATCH 2/2] firmware: arm_scmi: mark channel free when init
>=20
> On Thu, Feb 06, 2020 at 08:57:26PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > The firmware itself might not mark channel free, so let's explicitly
> > mark it free when do initialization.
> >
> > Also move struct scmi_shared_mem to common.h
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/firmware/arm_scmi/common.h  | 19 +++++++++++++++++--
> > drivers/firmware/arm_scmi/mailbox.c |  2 ++
> >  drivers/firmware/arm_scmi/shmem.c   | 18 ------------------
> >  3 files changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/firmware/arm_scmi/common.h
> > b/drivers/firmware/arm_scmi/common.h
> > index fd091a4ccbff..5df262a564a4 100644
> > --- a/drivers/firmware/arm_scmi/common.h
> > +++ b/drivers/firmware/arm_scmi/common.h
> > @@ -211,8 +211,23 @@ extern const struct scmi_desc scmi_mailbox_desc;
> > void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr);
> > void scmi_free_channel(struct scmi_chan_info *cinfo, struct idr *idr,
> > int id);
> >
> > -/* shmem related declarations */
> > -struct scmi_shared_mem;
> > +/*
> > + * SCMI specification requires all parameters, message headers,
> > +return
> > + * arguments or any protocol data to be expressed in little endian
> > + * format only.
> > + */
> > +struct scmi_shared_mem {
> > +	__le32 reserved;
> > +	__le32 channel_status;
> > +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR	BIT(1)
> > +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE	BIT(0)
> > +	__le32 reserved1[2];
> > +	__le32 flags;
> > +#define SCMI_SHMEM_FLAG_INTR_ENABLED	BIT(0)
> > +	__le32 length;
> > +	__le32 msg_header;
> > +	u8 msg_payload[0];
> > +};
> >
> >  void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
> >  		      struct scmi_xfer *xfer);
> > diff --git a/drivers/firmware/arm_scmi/mailbox.c
> > b/drivers/firmware/arm_scmi/mailbox.c
> > index 68ed58e2a47a..2d34bf6e94e2 100644
> > --- a/drivers/firmware/arm_scmi/mailbox.c
> > +++ b/drivers/firmware/arm_scmi/mailbox.c
> > @@ -104,6 +104,8 @@ static int mailbox_chan_setup(struct
> scmi_chan_info *cinfo, struct device *dev,
> >  	cinfo->transport_info =3D smbox;
> >  	smbox->cinfo =3D cinfo;
> >
> > +	iowrite32(BIT(0), &smbox->shmem->channel_status);
> > +
>=20

+arm list

> If we need this then we may need to put this as a function in shmem.c I a=
m
> still not convinced if we can do this unconditionally, i.e. will that aff=
ect Rx
> channel if there's notification pending before we initialise. But we can =
deal
> with that later.

Per understanding, channel is specific to an agent, it could not be shared.
So the shmem binded to the channel will not be used by others.

Since this is the initialization process, the firmware might not init the s=
hmem.

The shmem.c shmem_tx_prepare will spin until channel free, so I did the pat=
ch.
Otherwise it might spin forever.

I'll add a check as following
if (tx)
 iowrite32(BIT(0), &smbox->shmem->channel_status);

I not find a good place to put this in shmem.c (:

>=20
> Also what about error fields ? I would rather clear it to 0, not just BIT=
(0)

Tx channel error should also be cleared, fix in v2.

Thanks,
Peng

>=20
> --
> Regards,
> Sudeep
