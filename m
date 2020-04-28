Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEFAC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07012053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fm2iuIN9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="dDszQt1B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgD1Htm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:49:42 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33174 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD1Htl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588060180; x=1619596180;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cum3JfwwcAiL2MPOSqobRTAp7tQDIWPpXkOPmq1b058=;
  b=fm2iuIN909KhxImsJaMqHW0CL81U+iw5K2X5CFr+4To5/gq5/BqXqhny
   kqAuNEC5y7cuxwLR6B9NvoezPICCOICePirzhYPZtJChY3Tzj/K4I2SRd
   3f5u3W6IYk+NUQoZuhCUkf0wpDf7jEyY2nlWV6Cw1d8WuvORU09yi8O/s
   r06gaAqdKs0/gEuVVienxXAyz+XWFNFYtUeyIrwmuDAmRvQRZOdo/rqLn
   IG7KVy7pc6P/PLvqvTBD7RDBrXbaDxcdTgUCiiwGfM8P9KJsme8GIvt8v
   m3Z6p8zCNSAe5zG9i2ZGFGGpTRoWjp1yOp3MlI4p17YpkHhZnYIq36Da1
   w==;
IronPort-SDR: rrdr9IygSTSEzZ5XAnPYRq+lc9vkc0tVrPOE8QvNusbYRwLDq4933BNHo4qzJdPbOVCfwx/gLn
 jMcYmsOHw6iwCYfTxLR7weMP783jZ3Wy18GUuZiUTPVJYdok0neRt97DpgQ/CESfUPrpEFhQ2g
 YwSvh5sEZdGpKAAs0XY7ZMCRDD39YkDiTo9oLFJgr0GvtZn+EbKtqkwlgbqLXxozFM2gCCbZtj
 rB719gorhuoikoGBBJgjUNxSBH1+8UwkASaScgPtMVglOxa0I8mBeSgsRdaSnDox+E1ZQUdzV0
 yVE=
X-IronPort-AV: E=Sophos;i="5.73,327,1583164800"; 
   d="scan'208";a="136631442"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 15:49:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Whujbdub4un9nEAyRrPcINftibsvyzMqrIwQxeYi93+U5neUdASt5ddvwwPzAMeRATzPMhewEnCvIvAEEvdZbajYpjFpQ9lcVoBDxrswi9qBLr5E8ZpivkQOO5SXvX6DiwwM2XzaRwJZZBbQTrrl5Z2gFvbA/kYSNFjXpx3/IHSgAAElKyURzsZFSEKRJLoRfuh6fozhK0HnM7RdwNChJkik87P25dgJioQLAmYvHituo74++3DUi1+VX8OJTiJA2DJWZYrPnWCY4EyGRazDkGogbIemizxCiuCpxpRaAyjlMldOReMBaHLw+Jd38xGYW+mVXNmFNb8Cngz+TscWKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3pqCgASJJEIww3vYsmalRjqDvxl1ZBrTgC7Ywp0x6M=;
 b=HxPOP1hB6+Vf3t8P3hpVcOh8qlurDknuEb4WLwt3Khr74cPAfD88/a4+BOCCL2WbucJDqtHw32btdeHCkJzJAgsTYKIdIzIOR/6jEyMQMZ7UCfKo+fnnvNjTGxo/iJv7A4DC8YCGfILQUJcpE0YE69KyWlzcKafY0p7yoVRuCJLpmGyntQ3v1Zgf5VOrsRojqnuKxEAJqgsbiwW8870OCOjBUYgnxEkWZ8YROPHkK0+E57tBXKL98q/U1DoZpcy9wJBiF/Vql5Nf+X+xAsIp4Y4tgGngQBpQ5zKAwqV65VwD5zWsMiBZlg9xuyqkT/kW9OwFMUYwG2R2nWuTXvj89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3pqCgASJJEIww3vYsmalRjqDvxl1ZBrTgC7Ywp0x6M=;
 b=dDszQt1BRyXzO5A69CzgnNIL4GeAtzoUCkbe2xDo4IlvV8y9YALDrz5aaZX8QD8qPsVetPVFs7kv3s4syIV5DEO+Q+YnPFSKvNSnJUPuLs17mn39oUax5myL79kip70ZSrRd7sepHuMDCv+8p319nU+PsGSPGTQEsU12pNs3NOo=
Received: from BYAPR04MB5015.namprd04.prod.outlook.com (2603:10b6:a03:47::33)
 by BYAPR04MB3782.namprd04.prod.outlook.com (2603:10b6:a02:ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Tue, 28 Apr
 2020 07:49:36 +0000
Received: from BYAPR04MB5015.namprd04.prod.outlook.com
 ([fe80::e165:ec6b:c79c:c076]) by BYAPR04MB5015.namprd04.prod.outlook.com
 ([fe80::e165:ec6b:c79c:c076%3]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 07:49:36 +0000
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
Thread-Index: AQHWHJBF5J2JgQiUdUSwnibdYIeruaiNQxmAgAAFd4CAANV9gIAAC/GA
Date:   Tue, 28 Apr 2020 07:49:36 +0000
Message-ID: <20200428074935.GA584449@localhost.localdomain>
References: <20200427123443.520469-1-niklas.cassel@wdc.com>
 <20200427180311.nssquibbak5ib4oo@mpHalley.localdomain>
 <20200427182245.GA547726@localhost.localdomain>
 <20200428070651.qbsyivvaakflipr4@mpHalley.localdomain>
In-Reply-To: <20200428070651.qbsyivvaakflipr4@mpHalley.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 64964c7f-58dd-496d-f1de-08d7eb48b2e7
x-ms-traffictypediagnostic: BYAPR04MB3782:
x-microsoft-antispam-prvs: <BYAPR04MB3782D85404C63A378F47A7AFF2AC0@BYAPR04MB3782.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5015.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(346002)(39860400002)(366004)(376002)(136003)(86362001)(9686003)(6486002)(8676002)(81156014)(2906002)(6512007)(186003)(316002)(54906003)(26005)(64756008)(66476007)(71200400001)(8936002)(4326008)(66574012)(33656002)(5660300002)(478600001)(76116006)(7416002)(66556008)(66446008)(6916009)(53546011)(6506007)(66946007)(1076003)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3NC8SPmV/A/bdfmUOR5Ng5RfMQMK63x/Kw7/UNWZFVsv42yX7hQwFTVjRhSrX5FjBO5MXVSVQpkxqM8mtNn+Odr4QfFmR+S7KfiEar8lxZMwPuMiWHst/c/lSLGGj1syhq2O2kJmOOfPdCeCYgrGIPqNOpq93PQvmq7ot/5uroYJym73KTtoYz59ut2o7Er+2K6ZCZ6s1EqtfWkNG4nIEt2PqjZ1IqtOkx3yB7OZ4cz5UFtnQxv4fPcWjmUmSThUTUfVDH/AO5cAB9p0zkoygQ+SynWnzNkos7vmCdzRxHUbv7iLSLmo49Rr+cPJluA+iab467Q+sh/B1t5n5V/UrjxsQ7cJX83OZpX0g1BqOdumsNS4bl1bTORkd7wJnm+JZ1hL5RGO1HX07MzbYdz7FGffOc7qjfVbfhjbs5T6ha6hR76iFVShRffrYoPe5Z7E
x-ms-exchange-antispam-messagedata: La6zK0Mg6CcyZDNhnxVkH0DakMPucaQMUnzxcPJVmVqNhpiHS2y6vpTg8rGmqyh1QFXrHA4e+WDvmk6QPxnmQ6EZRx/MZgwegt+SJTwmgzcMSQ1voaPkcxBdAi6YzFGMEOr1DEcFNK9pqkng46eFHsMvzlpeRKdIuBNL9qqIEam+Vi2mN/8JaF3VtyBC2qVtgYCDO4ft3LxP7sHOMchEh0fPpQkd/QTWPqoji89fg2JekcQILxSndY0akDEZ+srgMitMcihvutPexW6Zg07pKfWCG/APMIaLnaYgKRfPH/NOTa1TAXPETwB8djN3QjsMK++vKy5x94BVTBXO+gxvf7KMDviJxdG9cvupJ850cKwUo4MblNTf6A3tA+fXLfqhUwBQPqfUmanZJg/G3dUOBdACBdvpHZ7wS7OmkqQJyUo0PIYNWzfl68qMQ+CrWFvV2Po9d1S+vR36iJCLzpSHJ17P8PWle6E3DlHU+hOtKsfHkAcwDeS2KJN5+xsjQsR8MTBo+J9EZaYz7i6EfMw8GYxESjkkNTL3VbB8jdcERPFk11Zkr0FuwieHXnyMSwuCom5Z9qiJkPOK0Czc2/fIPSraQXUrfnGQ4iIOeGd5YTy6G5/Vcx1FizXZvePkWeKP3COGU+8dcjsc4rWjuix3zppXLDZo6GAY7X7B+MnIu9YDwNtbxEfgfgLiI4WTBAK/XOFn99a3bzHy6ozZjyboKte4h7RukySTbRLL8DW73IlUxzfzD+XPRYvWBKcb4ak82sqSYsFaoHHMfnuKykuRiGhdDU8Onh65kAAlnSQB92k=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DDB25662D9CD22469FC093E0DFCE4BAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64964c7f-58dd-496d-f1de-08d7eb48b2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 07:49:36.5466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEm3cxScZjmRrDQ5Nua1//dYK5P9HjcsP3u4GqJzxYOjT2UAQPCEAnQSYlNQqAA4YOv6BS3XHlFXKOa5awm3mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3782
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 09:06:51AM +0200, Javier Gonz=E1lez wrote:
> CAUTION: This email originated from outside of Western Digital. Do not cl=
ick on links or open attachments unless you recognize the sender and know t=
hat the content is safe.
>=20
>=20
> On 27.04.2020 18:22, Niklas Cassel wrote:
> > On Mon, Apr 27, 2020 at 08:03:11PM +0200, Javier Gonz=E1lez wrote:
> > > On 27.04.2020 14:34, Niklas Cassel wrote:
> > > > When jumping to the out_put_disk label, we will call put_disk(), wh=
ich will
> > > > trigger a call to disk_release(), which calls blk_put_queue().
> > > >
> > > > Later in the cleanup code, we do blk_cleanup_queue(), which will al=
so call
> > > > blk_put_queue().
> > > >
> > > > Putting the queue twice is incorrect, and will generate a KASAN spl=
at.
> > > >
> > > > Set the disk->queue pointer to NULL, before calling put_disk(), so =
that the
> > > > first call to blk_put_queue() will not free the queue.
> > > >
> > > > The second call to blk_put_queue() uses another pointer to the same=
 queue,
> > > > so this call will still free the queue.
> > > >
> > > > Fixes: 85136c010285 ("lightnvm: simplify geometry enumeration")
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@wdc.com>
> > > > ---
> > > > drivers/nvme/host/core.c | 2 ++
> > > > 1 file changed, 2 insertions(+)
> > > >
> > > > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > > > index 91c1bd659947..f2adea96b04c 100644
> > > > --- a/drivers/nvme/host/core.c
> > > > +++ b/drivers/nvme/host/core.c
> > > > @@ -3642,6 +3642,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *c=
trl, unsigned nsid)
> > > >
> > > >       return;
> > > >  out_put_disk:
> > > > +      /* prevent double queue cleanup */
> > > > +      ns->disk->queue =3D NULL;
> > > >       put_disk(ns->disk);
> > > >  out_unlink_ns:
> > > >       mutex_lock(&ctrl->subsys->lock);
> > > > --
> > > > 2.25.3
> > > >
> > > What about delaying the assignment of ns->disk?
> > >=20
> > > diff --git i/drivers/nvme/host/core.c w/drivers/nvme/host/core.c
> > > index a4d8c90ee7cc..6da4a9ced945 100644
> > > --- i/drivers/nvme/host/core.c
> > > +++ w/drivers/nvme/host/core.c
> > > @@ -3541,7 +3541,6 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl=
, unsigned nsid)
> > >         disk->queue =3D ns->queue;
> > >         disk->flags =3D flags;
> > >         memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
> > > -       ns->disk =3D disk;
> > >=20
> > >         __nvme_revalidate_disk(disk, id);
> > >=20
> > > @@ -3553,6 +3552,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl=
, unsigned nsid)
> > >                 }
> > >         }
> > >=20
> > > +       ns->disk =3D disk;
> > > +
> >=20
> > Hello Javier!
> >=20
> >=20
> > The only case where we jump to the out_put_disk label, is if the
> > nvme_nvm_register() call failed.
> >=20
> > In that case, we want to undo the alloc_disk_node() operation, i.e.,
> > decrease the refcount.
> >=20
> > If we don't set "ns->disk =3D disk;" before the call to nvme_nvm_regist=
er(),
> > then, if register fails, and we jump to the put_disk(ns->disk) label,
> > ns->disk will be NULL, so the recount will not be decreased, so I assum=
e
> > that this memory would then be a memory leak.
> >=20
> >=20
> > I think that the problem is that the block functions are a bit messy.
> > Most drivers seem to do blk_cleanup_queue() first and then do put_disk(=
),
> > but some drivers do it in the opposite way, so I think that we might ha=
ve
> > some more use-after-free bugs in some of these drivers that do it in th=
e
> > opposite way.
> >=20
>=20
> Hi Niklas,
>=20
> Yes, the out_put_disk label was introduced at the same time as the
> LightNVM entry point. We can do a better job at separating the cleanup
> functions, but as far as I can see ns->disk is not used in the LightNVM
> initialization, so delaying the initialization should be ok. Part of
> this should be also changing the out_put_disk to put_disk(disk).

Hello Javier,


If I understand correctly, you are suggesting this:

--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3616,7 +3616,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, uns=
igned nsid)
        disk->queue =3D ns->queue;
        disk->flags =3D flags;
        memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
-       ns->disk =3D disk;

        __nvme_revalidate_disk(disk, id);

@@ -3628,6 +3627,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, uns=
igned nsid)
                }
        }

+       ns->disk =3D disk;
+
        down_write(&ctrl->namespaces_rwsem);
        list_add_tail(&ns->list, &ctrl->namespaces);
        up_write(&ctrl->namespaces_rwsem);
@@ -3642,7 +3643,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, uns=
igned nsid)

        return;
  out_put_disk:
-       put_disk(ns->disk);
+       put_disk(disk);
  out_unlink_ns:
        mutex_lock(&ctrl->subsys->lock);
        list_del_rcu(&ns->siblings);


That would not solve the double free error when the registration fails,
since disk->queue is still set, so this call will still free the queue.

Later in the cleanup code blk_cleanup_queue(ns->queue);
is called, which will still try to free what is already freed.

To remove the double free by delaying assignments, we would need to
delay the assignment of disk->queue until after the LightNVM entry point,
but I don't think that is possible, since __nvme_revalidate_disk(), which
is called before the LightNVM entry point uses disk->queue.

Christoph said that he would clean up this mess with better block layer
APIs. So perhaps the fix that is already queued is good enough until then.


Kind regards,
Niklas=
