Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5DBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14419204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 23:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CTAQ7/r2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="xWnc5/Qy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgFKXpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 19:45:14 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:39820 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgFKXpN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 19:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591919113; x=1623455113;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cPTgLV5CC9NTl4nebD3xyo8aaz2Hwve8wWwj8P6Rj2A=;
  b=CTAQ7/r2baDC9V494rlIePa1FMjzPsByJcd915PkyXYCGdDPV9GbY8KU
   9foCOUFbc6d8feURRw/Ou3YxrKvwbFey2+x1np1Sd1sSdDu38rniznSv/
   HfIwL2f9hBbSBcO3LjT5unA4kWIOiATCiT8Wp0VktGkwezIYecApf/wwg
   05C3mm6agsLsyzJEnS63zNMInnyaTknFA6INu/AMKcapdOsNQrjvMO4cj
   +tNAA3aFHMxAGhOB//jCuHyVxWzN4lfoHpQeQjfiOKoaVwvjezJqO54Hj
   y6VXaw5gQ/YiYTZbg8rLeJCXeCayEiWVOfQwQdeJHGyylJlryGJOjd+kK
   A==;
IronPort-SDR: 0bNYIaWd2fCdD/22Ewy5GJjA9xefX5xy9Ot/QEpHuOqDGWjyNOADhzpUZLBL/PShcaUjaZq7c2
 Z8e8gQNiHDLY3R3wlO5CzEVy3VIEObkvFZ3Iz/wEkIY9Xop7fHpC/Usraddm99zTAghvSKf5+F
 YG8mWVtssSrk4jbEjO/iDPKLbYJJ6eJHVbKHxJ83E09LeJsVqM/4kt+qSjbtTgPOP4B+44SKDd
 WMIP0crMlkNHvPE79pBZqHR0zjJpZVUkgfvpGHcyO3oeOczXORjacFPCDbYFpM6wu86x8kYhMs
 Euk=
X-IronPort-AV: E=Sophos;i="5.73,501,1583164800"; 
   d="scan'208";a="144102326"
Received: from mail-dm6nam11lp2170.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jun 2020 07:45:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VVLdKv37OWf2Fev+B93bnOLtihliyKfU0rAE+wLwXPTSeAt2XhDgIpRog/1ECGo0jGMDgc5uXB4dCjr/viFEjKhJtFKFQmfvjlrAkbdldzCeSe21q01VhEjLiphsv73zgKvXQovzGdLQJ6IFYjQt5USFbkszCzTpk/v6wY+QRDvMh+QMuQIapzBTQclcmGyMSZ2QDk8jJ6KZakQcXJBlyUrsewZG+ohVALdBCvxElul3VSruAOkr80lVbN/NYU8HrP4XFlOJ8i8K3pFftA/tFXgBK8dbdBf2sVUhDuhdgUgPftVL73SnnNdDchssjVIlOmZwdBSIWmGAO4s3wTmhSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEc40JkD51XLAAOw0tSEu2Dei9rEyk/UV18o8I14lqc=;
 b=OFlFU5wTKO2Eqp695WnerqOPOWot5RP7xeFZrgwgWm+JTB3EW0BOPL4tp2evK5y3wOfp50jbOIXBBKyKgWvpF2qmkicgi1Jx+3SHCipOoWqgSWi9nRthFvxVG6LT3FJN50YvDJJ0PhudGtD05iXjNbQA9j8URjx/KTfsQ3CnBq7AHPivTu89lrgvo4odAFnw2mRq9Nt7cvuO2z0J7auYA6naWGbsAy1aLuBvqXL+4+quwGr6bGrDOhGHu/SByjRvuE2IGSu9K30x+i2GBJtaX2BGXZ08nQ2zL+/V/vJpp6WzHiO4Z9jz8Jg8ERZOKpsy/VW7C/zqZ7k0rVjHPwQ9lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QEc40JkD51XLAAOw0tSEu2Dei9rEyk/UV18o8I14lqc=;
 b=xWnc5/QyCXKU0euFfkKmHXksp340IYf3QwDdRGbNfYkF2C4pBuga+j1C38qIx/ZWCFn+dtifdxFCP+6iywcQlHrPGhUhWB3Y+PdsrEdmpxjgab9KZ6oqLCdVtPLMt0Ow+R9dGY+7VYZ80FnljaoSYmdKKwW4JyqDvj6uYy3KNPg=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7122.namprd04.prod.outlook.com (2603:10b6:a03:222::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Thu, 11 Jun
 2020 23:45:10 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Thu, 11 Jun 2020
 23:45:10 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Logan Gunthorpe <logang@deltatee.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v13 7/9] nvmet-passthru: Add passthru code to process
 commands
Thread-Topic: [PATCH v13 7/9] nvmet-passthru: Add passthru code to process
 commands
Thread-Index: AQHWKhRpuphoSoz88kOAfqTRprM+0g==
Date:   Thu, 11 Jun 2020 23:45:10 +0000
Message-ID: <BYAPR04MB4965379CE8694F52D684993386800@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200514172253.6445-1-logang@deltatee.com>
 <20200514172253.6445-8-logang@deltatee.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f4457c2b-e649-44cb-b625-08d80e617adc
x-ms-traffictypediagnostic: BY5PR04MB7122:
x-microsoft-antispam-prvs: <BY5PR04MB7122ED35404176B527E391FA86800@BY5PR04MB7122.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p/oAlTREwX64c7RffJBYif0WBg6ldrIx8n1VBARMkA7at3TOnrKE+tpi1+L8duKeDNsIL+zZtD/JqKKwZP1Dp2xDpoCNVCNIbBuSntQxr4K7Av0PQJgpsJUi+ZP7zPgO2y3H7MqF5Pb+etDC/xZ8UkllN9Rz2QbR5DHn0rBbpbcseDeHGxT5a6YjWu9rBAlOuba3hdhNUlByt7T2l9FADMsAlwotCSwNB/LE1/nootc9Sk4Lf+tUIK5H9JW4aZSoJcHY1YFnN7lzqkHzAwx8iX02O0dtONIkyk+5Tqpo79chhen3DoMqq5y5uAi/dQwb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(66556008)(8676002)(8936002)(76116006)(66946007)(66476007)(64756008)(2906002)(66446008)(33656002)(86362001)(55016002)(83380400001)(186003)(26005)(6506007)(71200400001)(53546011)(9686003)(316002)(4326008)(7696005)(478600001)(54906003)(5660300002)(52536014)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: nern+YkBdfYGsMDmmvmhOBG26z9YggaoeUUjPVHcRifgTikahnqHXdHtQfJVuhnyQLTAjvpIgJ/S+9QKDSAIePYvlY4Es11KJQjTqs6MLM0+rCt58qhKSjdSruWwpx1KJyu0FFcp5Jba9Rr9gZis0HTEd8j0EnMOiTVMItvA16VuuAA9kfPbUL8JltT7QH+qFJMU20qUOnWXFrj2uYLP2r1oEFcbIoU7hbve6aVXgey24CShLrHle76Vnwe1g1Axtsjciwb8Elyikdl5QdsYE61CUeczUgmPfrz2vZsmmZh/gNtUXa8T41neDaXi5mjODc58AMQ2jQdbynlTO3lrym+nFuh+beLqBM7wyL0xXaoErwTIqKhvZRWUNmSEDIA9zzksZ68GwKN2P63+jJr/xS8lkc35ePOmyZFoGYfDQyObivGHkGm5oPuxe1tmJnh1Wxgl27eZVW/qGx3Qu3qYsL0oiWXQUiuZh6IC6iFmHmo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4457c2b-e649-44cb-b625-08d80e617adc
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 23:45:10.6887
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eA96pe/ru1glYskqQwM9cMTKfuFJo0tHCkPutklJmlE3JhvaPNwenSO9kv1jvhp/xUfr+sybDlBDKJEo6dV45hTYcjE+/IxgJ75Z/m7wIDY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7122
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/20 10:23 AM, Logan Gunthorpe wrote:=0A=
> +=0A=
> +static void nvmet_passthru_execute_cmd(struct nvmet_req *req)=0A=
> +{=0A=
> +	struct nvme_ctrl *ctrl =3D nvmet_req_passthru_ctrl(req);=0A=
> +	struct nvme_ns *ns =3D NULL;=0A=
> +	struct request *rq =3D NULL;=0A=
> +	struct request_queue *q;=0A=
> +	u32 effects;=0A=
> +	u16 status;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (likely(req->sq->qid !=3D 0)) {=0A=
> +		u32 nsid =3D le32_to_cpu(req->cmd->common.nsid);=0A=
> +=0A=
> +		ns =3D nvme_find_get_ns(ctrl, nsid);=0A=
> +		if (unlikely(!ns)) {=0A=
> +			pr_err("failed to get passthru ns nsid:%u\n", nsid);=0A=
> +			status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
> +			goto fail_out;=0A=
> +		}=0A=
> +	}=0A=
> +=0A=
> +	if (ns)=0A=
> +		q =3D ns->queue;=0A=
> +	else=0A=
> +		q =3D ctrl->admin_q;=0A=
=0A=
Is it possible to avoid explicit if.. else in fast path given that the=0A=
condition exists and we can take an advantage of that, how about=0A=
following ?=0A=
=0A=
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.=
c=0A=
index 9e71fdfbdbb3..4f8e022d254c 100644=0A=
--- a/drivers/nvme/target/passthru.c=0A=
+++ b/drivers/nvme/target/passthru.c=0A=
@@ -84,9 +84,9 @@ static int nvmet_passthru_map_sg(struct nvmet_req =0A=
*req, struct request *rq)=0A=
  static void nvmet_passthru_execute_cmd(struct nvmet_req *req)=0A=
  {=0A=
         struct nvme_ctrl *ctrl =3D nvmet_req_passthru_ctrl(req);=0A=
+       struct request_queue *q =3D ctrl->admin_q;=0A=
         struct nvme_ns *ns =3D NULL;=0A=
         struct request *rq =3D NULL;=0A=
-       struct request_queue *q;=0A=
         u32 effects;=0A=
         u16 status;=0A=
         int ret;=0A=
@@ -100,12 +100,8 @@ static void nvmet_passthru_execute_cmd(struct =0A=
nvmet_req *req)=0A=
                         status =3D NVME_SC_INVALID_NS | NVME_SC_DNR;=0A=
                         goto fail_out;=0A=
                 }=0A=
-       }=0A=
-=0A=
-       if (ns)=0A=
                 q =3D ns->queue;=0A=
-       else=0A=
-               q =3D ctrl->admin_q;=0A=
+       }=0A=
=0A=
         rq =3D nvme_alloc_request(q, req->cmd, BLK_MQ_REQ_NOWAIT, =0A=
NVME_QID_ANY);=0A=
         if (IS_ERR(rq)) {=0A=
=0A=
