Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFDBC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E85206CC
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 10:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ps0DZYSG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbgBGKoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 05:44:09 -0500
Received: from mail-db8eur05on2080.outbound.protection.outlook.com ([40.107.20.80]:6146
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726798AbgBGKoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 05:44:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TB7f304UTGB6HRtylE7PM8t7Y7wex/04yhMzrXJ4WTKXL+mmxr2ojbZ8fRHf1Ljdt930YZM9vhLmIHe1ArNcGzg5sIBwBfjrQ/LmeNYAsRp6ddiPx6MdFJpvan4yHIa+QL3v6bA5n+gXnG01hq0SrIsduTh8SC8vNuccDynCN3tQPMyVNT4gDfXdIfoyLPjVvthHcpKydGr915389U6OAM4yeLe1gsIjjPWmLp1uO8wXPRPodcdEJQFqPOYNGLfGoJnze9Wki3kDOho8C58dyXNPeY5or3gGOakfropX+E6Nh/g/RAcpQohHJVnUc0/mcHB6Pf5GsH5gQQc6duFrSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXeWnBcngxw1tEfH0HIbgxBWm/wC0fIMDiujUK35Ys8=;
 b=Wi7cmO1A85uuyCRKBaSnzBW0QxIK0DgsVHwmkVrnL4EldCNbQHRJcUi2w8my99T0g8rdd1oWuSRLxnf6ljyGw4+ueIYF49KTfoO9/T+BR1iY3oup/jFk/IcxuDVlAegGLIS7wDZOUezxCv3NG8J1zVdOa57degPyf4aOWJKf5ESUx01rTfmuigbBGxAFuS4R7eqdEwr6+a3pLnL4Ztny++BJBStQ5P7vCyRDzwSA7qhyepCB5iyMeL+5QxKxgRA67BszB0kdrCO9quKDasgs5a0cPh6MhuGnsPEG6NAH/y/pxe7qnFf8gk+2HK9YLvVVoxKLbSP5tNvFamQjehxX7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXeWnBcngxw1tEfH0HIbgxBWm/wC0fIMDiujUK35Ys8=;
 b=Ps0DZYSGiaZGkzGlq6XOam6t86JeswEuS+XuKEMCu/ioppyHXCxdKeMEX3FcRqjMSlXJ6lsZhDP29O0ufLpB+Z0pIrXnB6gxTxWs1nwbG9nNKE3wL1VUzUoRSxbDi1rTjclX5UyMudqhWKkP+9UdcsxXJSIGFb30JkA2g9oORio=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB4129.eurprd04.prod.outlook.com (52.134.95.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Fri, 7 Feb 2020 10:44:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 10:44:04 +0000
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
Thread-Index: AQHV3O25X/FFlEFpBUK1Q7PthmZs26gOOvqAgADCJ6CAAI8bgIAAAFJA
Date:   Fri, 7 Feb 2020 10:44:04 +0000
Message-ID: <AM0PR04MB4481540FBEB2BD3C897479AB881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580993846-17712-1-git-send-email-peng.fan@nxp.com>
 <1580993846-17712-2-git-send-email-peng.fan@nxp.com>
 <20200206143337.GC3383@bogus>
 <AM0PR04MB44817B64CB35B2B2FB50D8F7881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
 <20200207104043.GA36345@bogus>
In-Reply-To: <20200207104043.GA36345@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6adfe3ec-c3e2-43ea-36f9-08d7abbaa6da
x-ms-traffictypediagnostic: AM0PR04MB4129:|AM0PR04MB4129:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB4129AE446DC81FE987F97832881C0@AM0PR04MB4129.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(189003)(199004)(54906003)(2906002)(26005)(186003)(8676002)(33656002)(8936002)(81156014)(6506007)(316002)(4326008)(71200400001)(81166006)(64756008)(66476007)(66556008)(76116006)(9686003)(6916009)(66946007)(55016002)(66446008)(44832011)(478600001)(5660300002)(52536014)(7696005)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4129;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RlMTcJ9vcwncsQ55YnOudKWVD1LjbFdtyCjx2WKaxI43PVgUa4oROs2DAI9BHKWmHfsVi01154tUxmUB9Y0guJkQl/l988PDJdn4JgiKNAia4bT3u7oJrf0P1neA+YJuE6gZQXAgo7qRws4Yb1IKjBlmCL2zMfoDwMbAtqy4MOF9ptWeKKyE2kINyiAAXHVR4/SGo7hkVzzOQ90A3ztS93LLRaB5Imx9LqT5X0WZ37wWscSDbn/k5//ky3bNCiu5a+Sp4P7ElzhDQaGYgWRfvh84RuQz0T7vItWbPu0lf9WfL4hJ9ZqNY/3DkcY3VTWtSMX1wUEPdXzlB5uGFq1uU9XGs2ockg0Q+1dbPr4voy2JpXo3y7Z++xk2v1EEjAQj/vdrVuhPaTOydxynbH9OHQa7buuCouAoP8jftSUEzT4FpTVY/AMDlqILv9IzZwQC
x-ms-exchange-antispam-messagedata: 70MxAaAFTU94i2OeNstxQEQ9McBGfVVkrFf4z2CcX/oZNThsd8WSLdND7uoPH7ZbOy8Ad9rDQVWFvHPzVJ7AD4KfqysI3N/BYVqwak0sNLHNVaujFvfUYBR91f2PnOcYLnoahWaltYwXyQ/wlgWaIw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6adfe3ec-c3e2-43ea-36f9-08d7abbaa6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 10:44:04.6810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OGEmRO/DFxwHbRxshu/XLF85j+jud9b+vQuZfJIpz1hR537AMfSGbpS7DEp1vq6ecPs3gKdHxVI5Z6V/JOVXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4129
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 2/2] firmware: arm_scmi: mark channel free when init
>=20
> On Fri, Feb 07, 2020 at 02:16:04AM +0000, Peng Fan wrote:
> >
> > > Subject: Re: [PATCH 2/2] firmware: arm_scmi: mark channel free when
> > > init
> > >
> > > On Thu, Feb 06, 2020 at 08:57:26PM +0800, peng.fan@nxp.com wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > The firmware itself might not mark channel free, so let's
> > > > explicitly mark it free when do initialization.
> > > >
> > > > Also move struct scmi_shared_mem to common.h
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >  drivers/firmware/arm_scmi/common.h  | 19 +++++++++++++++++--
> > > > drivers/firmware/arm_scmi/mailbox.c |  2 ++
> > > >  drivers/firmware/arm_scmi/shmem.c   | 18 ------------------
> > > >  3 files changed, 19 insertions(+), 20 deletions(-)
> > > >
> > > > diff --git a/drivers/firmware/arm_scmi/common.h
> > > > b/drivers/firmware/arm_scmi/common.h
> > > > index fd091a4ccbff..5df262a564a4 100644
> > > > --- a/drivers/firmware/arm_scmi/common.h
> > > > +++ b/drivers/firmware/arm_scmi/common.h
> > > > @@ -211,8 +211,23 @@ extern const struct scmi_desc
> > > > scmi_mailbox_desc; void scmi_rx_callback(struct scmi_chan_info
> > > > *cinfo, u32 msg_hdr); void scmi_free_channel(struct scmi_chan_info
> > > > *cinfo, struct idr *idr, int id);
> > > >
> > > > -/* shmem related declarations */
> > > > -struct scmi_shared_mem;
> > > > +/*
> > > > + * SCMI specification requires all parameters, message headers,
> > > > +return
> > > > + * arguments or any protocol data to be expressed in little
> > > > +endian
> > > > + * format only.
> > > > + */
> > > > +struct scmi_shared_mem {
> > > > +	__le32 reserved;
> > > > +	__le32 channel_status;
> > > > +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_ERROR	BIT(1)
> > > > +#define SCMI_SHMEM_CHAN_STAT_CHANNEL_FREE	BIT(0)
> > > > +	__le32 reserved1[2];
> > > > +	__le32 flags;
> > > > +#define SCMI_SHMEM_FLAG_INTR_ENABLED	BIT(0)
> > > > +	__le32 length;
> > > > +	__le32 msg_header;
> > > > +	u8 msg_payload[0];
> > > > +};
> > > >
> > > >  void shmem_tx_prepare(struct scmi_shared_mem __iomem *shmem,
> > > >  		      struct scmi_xfer *xfer);
> > > > diff --git a/drivers/firmware/arm_scmi/mailbox.c
> > > > b/drivers/firmware/arm_scmi/mailbox.c
> > > > index 68ed58e2a47a..2d34bf6e94e2 100644
> > > > --- a/drivers/firmware/arm_scmi/mailbox.c
> > > > +++ b/drivers/firmware/arm_scmi/mailbox.c
> > > > @@ -104,6 +104,8 @@ static int mailbox_chan_setup(struct
> > > scmi_chan_info *cinfo, struct device *dev,
> > > >  	cinfo->transport_info =3D smbox;
> > > >  	smbox->cinfo =3D cinfo;
> > > >
> > > > +	iowrite32(BIT(0), &smbox->shmem->channel_status);
> > > > +
> > >
> >
> > +arm list
> >
> > > If we need this then we may need to put this as a function in
> > > shmem.c I am still not convinced if we can do this unconditionally,
> > > i.e. will that affect Rx channel if there's notification pending
> > > before we initialise. But we can deal with that later.
> >
> > Per understanding, channel is specific to an agent, it could not be sha=
red.
> > So the shmem binded to the channel will not be used by others.
> >
>=20
> Yes
>=20
> > Since this is the initialization process, the firmware might not init t=
he
> shmem.
> >
>=20
> But, is there any particular reason for firmware not to ? It means platfo=
rm
> holds the channel and needs to release it to agent(OSPM) in this case aft=
er
> initialisation.

It is just my ATF not initialize the shmem area the leave the area with ran=
dom
data.

So I think that some released buggy firmware might also has similar issue.

To support buggy firmware and bug-fixed firmware, I think it might be helpf=
ul
to init shmem in Linux side.

Thanks,
Peng.

>=20
> > The shmem.c shmem_tx_prepare will spin until channel free, so I did the
> patch.
> > Otherwise it might spin forever.
> >
>=20
> Yes I guessed that to be reason.
>=20
> > I'll add a check as following
> > if (tx)
> >  iowrite32(BIT(0), &smbox->shmem->channel_status);
> >
>=20
> Not yet, I need answers to above query.
>=20
> > I not find a good place to put this in shmem.c (:
> >
>=20
> Least of the problem :), let us first agree if we have to have it.
>=20
> > >
> > > Also what about error fields ? I would rather clear it to 0, not
> > > just BIT(0)
> >
> > Tx channel error should also be cleared, fix in v2.
> >
>=20
> OK but wait for a while before you post for the discussion to end.
>=20
> --
> Regards,
> Sudeep
