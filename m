Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D9EC35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 13:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E82720733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 13:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ImkZ3Iqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbgBINTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 08:19:09 -0500
Received: from mail-eopbgr70059.outbound.protection.outlook.com ([40.107.7.59]:59522
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727473AbgBINTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 08:19:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1bY1stAiIUZ97xL/+PwIisZ7l/Hd8u7vptO20wWNt6TqpCKIhrDMDz+uFdgJStP597E3K0Qv4lg2u62wtYqXY9sY/WOJXre0FUfauEpBH1AsUGBEdr7+XVfJ6jiFucR0TEvf3BRY1o//eY17skwee1rfWO4E5QG6nGDRaFdvPYqCazHDQmvFKwhSBeB/5vFGwsSzXUYysvCDG9xjVABtUWNHwUAgdsHwqHdXMLhh+rcdsZSl5IHj2hmSWFPIVAjScKZqLR9tL5qLgEPzR4IjuQZ7oD0zc8EZTurdJKtUUqF7EM3uD5dRHjONvXd8lIQfIocj+I0znL2rhTa7mn3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWfNxBTGWk8CKcAMWH7NtIEuVegurCTgRzPEE8sawKY=;
 b=ca5GwABoNBAUqbXIff1AaD/5xlT6NDOkdFbVNHrwXTe2vVZLm0+JJAESFY0eImNyPosjm6V5/pIh4YKRshfAUOxK3ljUMN/Ku7+1G/M+XwUVyLhobl/NpzDM2TSDGCudkyvzGrj7utj/JyEG8OJ9hOg0mX8ZwsMnE3lSzb1fDHx+ayTNK+ktI5YyWdFhnMJbXhxYJvsQjZ5eI+cwTE6h0GEcDmXR+Gc7I9eG4LPUF8jXE9AFS20NULSsWHdLXTG7PSiqvesY3OK/eefEnigDlo+obbcOCV3ATZMbPHhy1CmzunUbX2T1Botam1pOeGgUnWKFnQK2ZUspCPpChkkudg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWfNxBTGWk8CKcAMWH7NtIEuVegurCTgRzPEE8sawKY=;
 b=ImkZ3Iquc2GfID0VOSsNPTSY27b93vbiJFv1KS3y9OShEQJNShlP5MKtJCoZdlA2EMJ0ua7IjZ7LUW1/KU7ha8r1SD5rUoQcNw8TRCU6h2PMVWTak3INjgm4uyqt0v4l+9k7xQRrdEGHZlpnFFBohVTT+FHHkdczZgSkUPtQS/o=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6836.eurprd04.prod.outlook.com (52.132.214.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Sun, 9 Feb 2020 13:19:04 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.028; Sun, 9 Feb 2020
 13:19:04 +0000
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
Thread-Index: AQHV3O25X/FFlEFpBUK1Q7PthmZs26gOOvqAgADCJ6CAAI8bgIADT5PQ
Date:   Sun, 9 Feb 2020 13:19:03 +0000
Message-ID: <AM0PR04MB44819EB644DF7F3A45D221AB881E0@AM0PR04MB4481.eurprd04.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: fe3c5899-afe7-48b7-a6f5-08d7ad62a27e
x-ms-traffictypediagnostic: AM0PR04MB6836:|AM0PR04MB6836:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB68368EF6FFE46BEE05CB7392881E0@AM0PR04MB6836.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0308EE423E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39850400004)(189003)(199004)(478600001)(4326008)(6506007)(71200400001)(2906002)(54906003)(316002)(52536014)(86362001)(66476007)(76116006)(8676002)(6916009)(5660300002)(7696005)(81166006)(64756008)(66446008)(8936002)(66556008)(44832011)(66946007)(26005)(9686003)(33656002)(186003)(81156014)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6836;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uV5Ps27ZvTGNbV7QuMnnbp8I2DCbaI1v6cPdItks6IW0RkqJ2MnlTbrNfohDceLHE5uNJhLmczwSleCqVqzRbuOa/OXUV6atxZPUIIpi5MT5iQKUZTUu+2YsBObOd23FNTZpVHGPuI2vLBtvyXTG20XJzwX7vz/C53tMfyOIFuyPyZXiywnXWT9RBRmwysFyrXcpIg4VhyskgwN+qwsCg3HELWiLsSiN6aDrBNrvLd0YTdl/ga3Xt83ke1qSFUBvxOJ/WQRMazTdWuTYfzZutBKzFRj8vWh7vA3IOcxWLgsVsTroNCOMHJVDKdxnq+mZv4ehiTd0R6ta/t/sETbGgFk4hhi7VI0qfU53TrOiEK+y7v6ZrkAmuMZtwUJZ2Fl5G88oj/pHuD/O61hR+z5t7GAuN9kZYFIVkYjh2FMHUs/ijBN6NJ5PwMZ16qbYDBAm
x-ms-exchange-antispam-messagedata: FwhCbMyhneKoKnNpTSfPBuGZ2qdYPSDlCFu8H4OWeZiH8s6MkPBzyGoQHTf/tgocGw01hp4OFT6ZcnqKHvhFgRhL9mtmDdHBTAFnNAYF0xgJVHWj7YcUeU4dALnqDDletE08FI2DEQ/bwAvSL91i5g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe3c5899-afe7-48b7-a6f5-08d7ad62a27e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2020 13:19:03.8715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4W0lCqTl0X3YFfe4sP5svxiy+0NFlxSFvpICyf7Fx4WMiUDwhUdMY7HYbo1JVizHvuBjHM6b7esCkflFMdnT4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep

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

After recheck the SCMI 2.0 spec,

Shared memory area:
This is an area of memory that is shared between the caller and the callee.
At any point in time, the shared memory is owned by the caller or the calle=
e.
The ownership is reflected by a channel status word in the shared memory ar=
ea.

For TX shared memory, it not explains who should initialize the channel sta=
tus,
callee or the caller.

In my case, I not let firmware initialize the shared memory, so it might co=
ntain
garbage data and not able to wait channel free.

So I think add a check of tx and set channel to free when scmi driver probe
, this is valid.

Or update spec to explicitly show who should initialize channel?

Thanks,
Peng.

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
