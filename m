Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE9DC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE0420775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WSKaHThK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SnNF8Dr2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgD0SWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:22:50 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:19627 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgD0SWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588011769; x=1619547769;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=egnvTXsuIzziGDuyhitbj1+y1J2wsq8mH1Uoh4xdtWM=;
  b=WSKaHThK30JPMYuRcDGXwBnytMsTgNP1S2P0SE6Ye/6Pig+mN4JS+gdm
   CFRLIzAGz0oVpp3/0qdyvtoB3ungo6OaHQB+IzHnz/kCbFcI+TTetqo6p
   QvyaebsxMnIm8MDSDRdVjEsJHwyhzxQxbbHJ1MR4mctAgTgcEFhx+Rcv7
   5RNIY5PM6PCjQ1/uXW0LuQQ6EKuw9aVt+Ir4dfo+M37KD9XbKdCOk5Rh5
   Vh0oT+4+apbeAX2CRnW2untNlBQLDZh6ro/tutEE5EBKzZHLizOA1UJli
   N6M2/8/Hkz9WtnfvDspGorAq/NqKeon73yNnhevWUSMSZS0b9Igb9awKb
   A==;
IronPort-SDR: 2VtzdZOvhL4iSaU9dh16WtFzCb+IdjinHHZX6qvsAGudmSAyEpR3Do2ppPU34Lw7fs0QU5AFN8
 0D993AKMHa35J28y08MrMTOGcy1t6nAXodPluHwP12Zxo8lY10zUiXptc9UcJJnJbEeU88BZ9k
 ml1sHeA8LQ7iPDAtsqXubNxnsG4x3SX2ldo5s57Qj1hS2iaqyH+55dlaaw9abPK/9pZAcFtqmb
 QecVf3VqrTNGXbbdPA6ePvMhprHCW5ZC8+JJUrbRScWtC74zryFXA6ogKkYFtFstd4l7EyrsN0
 8qY=
X-IronPort-AV: E=Sophos;i="5.73,325,1583164800"; 
   d="scan'208";a="136584561"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 02:22:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho71buUmdq07O9qOQrg9Kw5nOVtmpO2wQGHOog+qModJUMTwXPvTLo1SRq7W7qsfwiSgrB/enAmuA/LMk3GHi4kfrwHoKgzTv0fl8Q0Mxlm38yMbWxS1hgLold3IWK241J6RJG9Cn2ZrlviUjkQwVC7vA9LhYkOIej2Pnai2a/GP30AMXn8J/zL68Fyyl32BDKxx5Z1m9/Bz5caYZ0or0ZD2sSzHFjS27TtPvk2xngrjFkHUZt3uJsxLbdVx67cxVC4aXgWyPmRQ0Elk5pGizF8UuiRoN/ZOKtWwvoTkIhVcMzVaeTWEZbcoammFTRlqeUCVAHmt7/bCBA1Xj8tuUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u107N/75NFyHmgk2EAOtxJiANwRsmRS9+cirqK7OOOA=;
 b=HiZPWG9nDHFB3ABj0qCM2T+H/aY61Vc7gI6hcyaWg5XF7uxY9PaGwdbQ+9rkfJ0J0oEMg9BgjkCguYCUDmC6jG2ENDbl9MP9+OQkbM9lhvSsWdVyYPX9g5HCs2AOZXVCAPevCI2TTIEcBbI90vYppT7dbCBv7+7/cYi/6XN1FqqLscPdrHi6/FLzlSWcE9GWB9NbswQ6wPrUB5dpX5MinZlqgSaG53fWE7s0Tzf1yEAjMfPSe8hTpyZxA151jbEzAw68HHjEsd2WRT92hnSw7qckgmnM74sIR4tGxr4mMloxEx9QuKX/dZKQKqctfO4iaMyNlkAiUtIgmFwCZqQAHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u107N/75NFyHmgk2EAOtxJiANwRsmRS9+cirqK7OOOA=;
 b=SnNF8Dr2Wt/+gV77vxfDXYjt1oXD7JvUIsXO6vw8hgSwpK6GRuLmw8QDwN1G+q+SGJeoR9XLD4z8G/eG2KdKjfISh1lgtxAFx9Q/PIcYYAse7kzVi4aS26RMtL4dnoWUqmzN5JbV3JWtZR5MGwdfl73//qrQoC6vPIv8awZqQ5g=
Received: from BYAPR04MB5015.namprd04.prod.outlook.com (2603:10b6:a03:47::33)
 by BYAPR04MB3862.namprd04.prod.outlook.com (2603:10b6:a02:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Mon, 27 Apr
 2020 18:22:46 +0000
Received: from BYAPR04MB5015.namprd04.prod.outlook.com
 ([fe80::e165:ec6b:c79c:c076]) by BYAPR04MB5015.namprd04.prod.outlook.com
 ([fe80::e165:ec6b:c79c:c076%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 18:22:46 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Igor Konopko <igor.j.konopko@intel.com>,
        =?iso-8859-1?Q?Matias_Bj=F8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Thread-Topic: [PATCH] nvme: prevent double free in nvme_alloc_ns() error
 handling
Thread-Index: AQHWHJBF5J2JgQiUdUSwnibdYIeruaiNQxmAgAAFd4A=
Date:   Mon, 27 Apr 2020 18:22:46 +0000
Message-ID: <20200427182245.GA547726@localhost.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
In-Reply-To: <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Niklas.Cassel@wdc.com; 
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 271aa722-a0fb-4a2e-994e-08d7ead7fc25
x-ms-traffictypediagnostic: BYAPR04MB3862:
x-microsoft-antispam-prvs: <BYAPR04MB3862EB3BA10020F0FF5C191EF2AF0@BYAPR04MB3862.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0386B406AA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5015.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(4326008)(71200400001)(1076003)(2906002)(66574012)(478600001)(5660300002)(6916009)(8676002)(33656002)(7416002)(86362001)(66476007)(64756008)(9686003)(6486002)(186003)(26005)(6512007)(91956017)(66446008)(316002)(66946007)(66556008)(54906003)(6506007)(8936002)(81156014)(76116006)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1Xu1KxKX9Em1OGDDXRX5AXBmp0zk2bhfpIiDCIywKVXah1ds/ZOKWxGhELZ7jwx13J2iOWowj9QPnKk63aNNXuHgH5PNaBpLljWTR8upB8S/f/sZIuWQLpt/0kreSaat7rieQtzhTwXKdLrrbaRyFmduIclIwT6voyEzKdDGBf3//lw+UJH2rZri8OD3kxHfFxXtbdM2i32OBv2g4UNM64vhwDM+iLflkeuN5Bq/vPAmDJvBA/1zadBZkFUmtcmEh8EnXq9RC2fTAEyMqY/zEqgLLBuLoCqQeQKs0fipdTyrhp43QLvu9NKKIB56DzG7/0HI9rNg0PTimtgynjQtozHrw1UuC3kxtVQsgTQzoTs+2yMk9yeO+7HmwwSCu4jKL96+/W0H+JuS3PtQ9T6AFCDijRt5KOjaHeraYbUJiSogjRvr0K+0W6ICVX3GNdOK
x-ms-exchange-antispam-messagedata: /Xx53yRRZ/Z1GcR3XnJlnD7up0jwF2G7ApruTDvrwIZLBc7mn/2upknxX6l8vKDPBJnSj0xCB+5LxovZ2pqW8RtNEqNBUNUNor1Xn4dSeqVmrT+CHIfBOWAPB9nI3eff6LZMm6MJxHoPVPNvjq1GnMfgA6D9RuWq5bQQGkjMKlAny3KAXTzVZTvzY4S6oLB/W0060+uFPTFA8X4xMC5ZxjTqgJ1m8yhFYpg1bf5y94YlkFz8xqKNqKKkq3agTyromEE5wzw5aaOPco7OPLaOhy88NH4wXdkt4we+S+XUv+gfwrPf0s1zRkExsTOfXp9BNgqvoMCYIDkUS8p7Yg5bLQSCfsUvUHAgr/HuMnkxm5fG7fw9CGcG0lT545BvDNfLriOAthSDUKtpU0UYOstSC3TjqQzwJ07NfBq+PvtM16YTiqaIVjJXWVl8IBWbFbNw0IBZBptZiwEzFncAfS9xwJnEXnvmn7yzToZw99Na6/zJY0uBkZkJA+xhMmQOs+UpwAI9Dzv+TJH4PdoOF9cZygalfebsyIU1+ypLx8w3QCBsFQQx0TR3YAg7Pjx6vVvB3xfe/mRsZ2jx5v9Dvx7InQCb+eSrLW7llto+taX062XSj4kpsqzsbDV1fJKzS0DD0enbjjA1AlyHXrX3qptu52Fn2JNT/ZcEplbjbC/dK/Smn3iEbSfcbyQISoiHJmP63xNR8sQMOaAIO9ErVkfopyKs59xWWdw487RFqY7+10EqEZxIGNto4ELTE3SXLdQXB/IW5vvib55Um3G29gwtjRxhKnovgBEUqaACLxz5TE4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <2C0B76D1975B0F479825BFE0FF922E9B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 271aa722-a0fb-4a2e-994e-08d7ead7fc25
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2020 18:22:46.3533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: umv3FiSPn02KxF3aekLDJt0bYvlMykg64oxE60H8mTcu8JMyyOgviCe/9qIUQiH3Ey7CgSbfg8A56MyH1GO0og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3862
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 08:03:11PM +0200, Javier Gonz=E1lez wrote:
> On 27.04.2020 14:34, Niklas Cassel wrote:
> > When jumping to the out_put_disk label, we will call put_disk(), which =
will
> > trigger a call to disk_release(), which calls blk_put_queue().
> >=20
> > Later in the cleanup code, we do blk_cleanup_queue(), which will also c=
all
> > blk_put_queue().
> >=20
> > Putting the queue twice is incorrect, and will generate a KASAN splat.
> >=20
> > Set the disk->queue pointer to NULL, before calling put_disk(), so that=
 the
> > first call to blk_put_queue() will not free the queue.
> >=20
> > The second call to blk_put_queue() uses another pointer to the same que=
ue,
> > so this call will still free the queue.
> >=20
> > Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
> > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > ---
> > drivers/nvme/host/core.c | 2 ++
> > 1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 91c1bd659947..f2adea96b04c 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl,=
 unsigned nsid)
> >=20
> >       return;
> >  out_put_disk:
> > +      /* prevent double queue cleanup */
> > +      ns->disk->queue =3D NULL;
> >       put_disk(ns->disk);
> >  out_unlink_ns:
> >       mutex_lock(&ctrl->subsys->lock);
> > --
> > 2.25.3
> >=20
> What about delaying the assignment of ns->disk?
>=20
> diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
> index a4d8c90ee7cc..6da4a9ced945 100644
> --- i/drivers/nvme/host/core.c
> +++ w/drivers/nvme/host/core.c
> @@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, un=
signed nsid)
>         disk->queue =3D ns->queue;
>         disk->flags =3D flags;
>         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
> -       ns->disk =3D disk;
>=20
>         __nvme_revalidate_disk(disk, id);
>=20
> @@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, un=
signed nsid)
>                 }
>         }
>=20
> +       ns->disk =3D disk;
> +

Hello Javier!


The only case where we jump to the out_put_disk label, is if the
nvme_nvm_register() call failed.

In that case, we want to undo the alloc_disk_node() operation, i.e.,
decrease the refcount.

If we don't set "ns->disk =3D disk;" before the call to nvme_nvm_register()=
,
then, if register fails, and we jump to the put_disk(ns->disk) label,
ns->disk will be NULL, so the recount will not be decreased, so I assume
that this memory would then be a memory leak.


I think that the problem is that the block functions are a bit messy.
Most drivers seem to do blk_cleanup_queue() first and then do put_disk(),
but some drivers do it in the opposite way, so I think that we might have
some more use-after-free bugs in some of these drivers that do it in the
opposite way.


Kind regards,
Niklas

>         down_write(&ctrl->namespaces_rwsem);
>         list_add_tail(&ns->list, &ctrl->namespaces);
>         up_write(&ctrl->namespaces_rwsem);
>=20
>=20
> Javier=
