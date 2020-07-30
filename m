Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA992C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C722075F
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 06:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aVZ7UnSl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728630AbgG3GWF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 02:22:05 -0400
Received: from mail-eopbgr130088.outbound.protection.outlook.com ([40.107.13.88]:23846
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725892AbgG3GWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 02:22:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtGphZc60x5DSB7oRIhq0e1xfGZmeSqsczlhqOts74fr0XgvL1GbdxBh16EkwpZgah8b2HIszDrFIqgGp2Zgcmk0PtDmuqYE5dnOZjMuDd6eWv+reGWAdLNJN9wZ9kai4GQhaoo1zkW1V39QpFzBO1IzEPkQYNfh6l3gxvGpCZPA2ZG9RcZAqmUR1MhlnQDck3SWoQoXKvjm+j/tVQ3VpobeQNK3qG65/cDUnyGHXwUbp3cCyewCa0ZCru4o2CaNqGiMK8rUi4eCQ45qyWOmYpMoxvop5dGhKk62+Hn0K019IRXmsv9kYxcSleJyjrbWxeqlb9iQ9BoiyL6EgQSJ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ngsD1CIUYSzjcuM0uJElmzWsByM7u0C88dObuJM7wY=;
 b=ksLyFfzYEs7VNWSzXE+9OcwRGuqgrnikFTuvC88FQMy5F5LBB0NXW4vCK4rIsviG47w/yiGRdJ8iJvN6qR4XNwBnhJ5be2l4D6amBdErogNFKoEan4WlW+zXcRwnnOeh7gYbBMFhgM6Uv4h2WVhfzT9quSbivfUJHbFqp0zKfi7E8QdlTZdRI49vDjKyRtcyMAgP5BAuOrbnmHwtLmNxyk4QO9DVZfuMYuBFSu3lNg+ueqPdZ2OXlLZ4U2EFUrmARrNY283Om+w7Q/wDxz9GTbXbf4nGJniZyLBK2hG/tlxqv3cai6PX+hVgYP9wHieMkRWn28SnmVBz/RHARsep3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ngsD1CIUYSzjcuM0uJElmzWsByM7u0C88dObuJM7wY=;
 b=aVZ7UnSlJxM55X4GjD3uJqE5PSwgwH2oerTe6LuAkOPupQkrdIXYeTHrgcVexDEqLal6rTdAzco4ZmN8p9py29VSFHxYlOGoxtCmXhZgwTQ9DfBBWI7puwgLlR4x70vk62bJJ85dO30FFJ3kiyRGG4eRWtgkkcDkhFh7U0HQIC4=
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com (2603:10a6:4:a1::14)
 by DB7PR04MB5081.eurprd04.prod.outlook.com (2603:10a6:10:23::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 06:22:00 +0000
Received: from DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701]) by DB6PR0402MB2760.eurprd04.prod.outlook.com
 ([fe80::2d36:b569:17c:7701%4]) with mapi id 15.20.3216.033; Thu, 30 Jul 2020
 06:22:00 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] remoteproc: virtio: support sharing vdev buffer
Thread-Topic: [PATCH] remoteproc: virtio: support sharing vdev buffer
Thread-Index: AQHWYCa/ZQ2evnRBnkWEXL5ROMcq8qke1I4AgACcW6A=
Date:   Thu, 30 Jul 2020 06:21:59 +0000
Message-ID: <DB6PR0402MB2760BF33BCBFF1CD1F1C4EED88710@DB6PR0402MB2760.eurprd04.prod.outlook.com>
References: <20200722131543.7024-1-peng.fan@nxp.com>
 <20200729170516.GA3059951@xps15>
In-Reply-To: <20200729170516.GA3059951@xps15>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d08d2b62-3405-481f-63a0-08d83450de11
x-ms-traffictypediagnostic: DB7PR04MB5081:
x-microsoft-antispam-prvs: <DB7PR04MB5081917B1B6F3C6698D5B00888710@DB7PR04MB5081.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B8hreQvtX8WLC+ijYT4VFcLNoQTMQ9EGsvy9hQorWcPVE2EqMP8urP3qxk3Tlmg2SxI0iInFikE7MRT84lUtQnefostlB8f2B1uT+adh2Ss9+CCoS19tJOpso4ddsNV0+3akAAeM+7jRp1l76c3H5GDZtWychwqGs+LaPA0IIDuXnx6ewirqF3/qA/qXXwwfCzjVrSzS/gDr/wgOAbsbER/qRHsRTSWmSGuoMogeAAKo0k2l5HGu8ZfFaoQDGx2uPWzJtzpomGSCHD+euUXDVz34P9/3x/zKAhGoqHxsktLdNoL0/UsiRRdp+e9LKpopfuTOT9byF4cMz+px+KMlgPnDDSHmyxU0AqB5uDVsLEskNgPSLGhMpseHayAaG4gkaLQ3YcXYZtaXHlBETPCJ1A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2760.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(66946007)(66446008)(64756008)(54906003)(76116006)(66476007)(2906002)(66556008)(83380400001)(8676002)(5660300002)(316002)(8936002)(4326008)(26005)(45080400002)(86362001)(6506007)(9686003)(478600001)(52536014)(7696005)(44832011)(33656002)(55016002)(186003)(71200400001)(966005)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: B449u75Ex7S6rQv7Myb0JHyrDc6b6kJWpLpKkuIDzVpqT8yMPYvF17NqZRzFD+1BiUuqWsxcviL13SgEHYmYWOe5xZfpmnRpuELlHVfaKIdSEZs8w55sqFG8YqbUNkLdepKzefjGXuf/taCMRzftUox9iDfPxB/r2JzAz47AcgK9gNnvBNeei7jRYKHef4tdk4iFoft231klHgCthj//QszSiu6QWr/AMvsIXc7LQtew+YFuOKQqhWpY12nPa7hsh03IYN542i+bCJhkdrfQ4XLJogRa2L+xteX1+j4DvX8M4k0GJkdqD4v4D/2PY5UXJdsBYzbomNske6j00B7S6nch/rvrDdSTKn4ELxVc65msi4/6UwEcpe6+Mj8nI3pX7EMj9sCiC8IfE2PpEWTJRPCzZuWi02L+qGMpOXursR/3BYrHzSyWi+Yj478+7MtYlia4SL7JDoRaBLCnLFR8uuFSgtyXPMs6YdO8mMFRPTOcLj6QD3CZbfDpiOtB7Ir7mAhVN8ldmOf5PLJV0Ot6UWdNEc5cZhnKsBis1djVtv8ZiEiT46Vf4g7Wy77Avuo3EUgHmEaVeuqWBmlpVz3ZkyxAfmCjL0iaYb+twcRyNx2BcbSgoq4SEXz8y5TyPtdhRM8TlMMjQiJ6PYwYlvhJoA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2760.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d08d2b62-3405-481f-63a0-08d83450de11
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2020 06:21:59.9355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: czkgfQx9OWE44LGDbxNvlowxgP11NNEVYjK3BvttiEjchgyZsE6PHZnJO1yZFIk27twSnEZygJVjDzYT18HJYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5081
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

> Subject: Re: [PATCH] remoteproc: virtio: support sharing vdev buffer
>=20
> Hi Peng,
>=20
> On Wed, Jul 22, 2020 at 09:15:43PM +0800, Peng Fan wrote:
> > Support sharing vdev buffer between multiple vdevs by using name
> > "vdevbuffer".
> >
> > Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/remoteproc/remoteproc_virtio.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/remoteproc/remoteproc_virtio.c
> > b/drivers/remoteproc/remoteproc_virtio.c
> > index dfd3808c34fd..5d78ebea111e 100644
> > --- a/drivers/remoteproc/remoteproc_virtio.c
> > +++ b/drivers/remoteproc/remoteproc_virtio.c
> > @@ -343,6 +343,8 @@ int rproc_add_virtio_dev(struct rproc_vdev *rvdev,
> > int id)
> >
> >  	/* Try to find dedicated vdev buffer carveout */
> >  	mem =3D rproc_find_carveout_by_name(rproc, "vdev%dbuffer",
> > rvdev->index);
> > +	if (!mem)
> > +		mem =3D rproc_find_carveout_by_name(rproc, "vdevbuffer");
>=20
> We already have a way to share buffers [1], do you think it would work fo=
r you?
> I would rather proceed that way to avoid introducing a 3rd way to deal wi=
th
> vdev buffers.

That should work for me. I just need to move the vdevbuffer to the 1st one
inside the memory-region.

BTW: Do you have time to give a review for
https://patchwork.kernel.org/patch/11688751/

Thanks,
Peng.

>=20
> Thanks,
> Mathieu
>=20
> [1].
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Felixi=
r.b
> ootlin.com%2Flinux%2Fv5.8-rc4%2Fsource%2Fdrivers%2Fremoteproc%2Frem
> oteproc_virtio.c%23L389&amp;data=3D02%7C01%7Cpeng.fan%40nxp.com%7C
> 760ae238005c49fe20db08d833e193ca%7C686ea1d3bc2b4c6fa92cd99c5c30
> 1635%7C0%7C0%7C637316391223184319&amp;sdata=3DUTN8YVaEynomrwFx
> 7aTCJ7fp0fjfIS8fscfGG67naKk%3D&amp;reserved=3D0
>=20
> >  	if (mem) {
> >  		phys_addr_t pa;
> >
> > --
> > 2.16.4
> >
