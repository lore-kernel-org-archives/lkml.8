Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9695CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCCB206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 21:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oiz6xMcG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="uQ7oJUfD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgFHVeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 17:34:21 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63466 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbgFHVeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 17:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591652059; x=1623188059;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=SYV5+h5+nt/Vt85usPLMWDVuvkvinZgb5zUvXG2uyZY=;
  b=oiz6xMcGcnRc12ILqlWPEBQ988nE2sWhaLBcHFBgpOxFR/hOCt7xZXcN
   00KqmvyaMPdDi+2WOHiU6WyzChR1MMUpn2Fuj6KCn/chBn+DvSrP1ybqi
   cx9qY82cGsXsrTqI4XcUVYieYuzzlwnhc3Pubac7FX51QyxYAJwDyrZM3
   sIJOIYsa/3hl/X89UWx5T5XZGzFcvmpj4kf68P7ORJ5+AUqbFdBomZufB
   mqR0aK+1b0gauJrqLAzE7Yxcg3lxeEfBIGmO4n9ETBAiByRoGij3prOud
   cYVUYzxu5r0DI4urikRjQhvxgUI3khPQSqJrJOcLIExNVYAeishQOB4JW
   A==;
IronPort-SDR: W7FHxuMpogOVpDi1SH3vWtmOXHta4LGcqPDwOSQ0ESUGGI0ioYjW/c8iUCZ0c2LMGrIat/56kK
 XG+/FuhfNv1n4tybiXLtUnnBe9IcNHb7hqb+Ml66oxyJGmBjkUB63e6Lyt/G0PYSY705tWAVPq
 jT/jdPlQk0KRxm3c4V+DyZnSHRB8pnB0OuMTBftmv92GpEMg3225Ajzf8nUsjjAfTFD8dDS7Iz
 y2wPY5dMxCILxDtAYJFNDdmi5Yj+mMQGONiurf4YREOyQscbgARM2LKUSDBv/Y+9rllFP939Mj
 dyI=
X-IronPort-AV: E=Sophos;i="5.73,489,1583164800"; 
   d="scan'208";a="139481105"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2020 05:34:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCxHDnwk+1mwe3YTqqiWdb3YSKU0n7NrMEEMYerbHhdP40y5qty3AvN3wctaNFD3YFB+4VLVTZkJGyRVhCyd98SKDN4/dwUOaw/OiXzCmP9QfLWBXo39/H1sj3LWiPK9m1DrrviufD+TmQ8sCGLHi9izBtLQQcn84WmE2PlWbIDJlFmFuek4FbvbWoc8ooJeuPvSNVf6Ltq/PuDzxa7a/Q+L/+y3UbeSNyKymJYCeXhSnqQok8brd8EsS6FE5SyYa1VRxH2hTu9jkw1UfnKXdNMMZXU+L/00zLnbs6T4jYgC5gDq/Aj42Y2pZNXUs8BJxKh7mceEi6PCU6ySuNu1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYV5+h5+nt/Vt85usPLMWDVuvkvinZgb5zUvXG2uyZY=;
 b=Dsby230b3Kqw9dIGTi6X4ZIeJ/HiEaVO+ZUiZYLmBWj3IknpJF0uv6pFN+6KGljpumZ08wNbL2sKf5XVQNbWAUM5Jsv0jNZWogTYs/c+NEjO6ojWcQ4RsYficnFQmgqbfiGhbDxEvisg6rCtoZV5MT/nZsqdJbMIrEr7KkSCLuNY4QZvwtxJ50UZyQt1oGMGdu/g0YblTSH6sR4G64WBl58Jx/Qj7hZqR8W8b59sF++48xLGwHXtsIuEP8/02XuBoLId7rxIqDsuaupgftrh5c7ivfpRhYJqk2roaPGPD76r6VI3+Xl+jCf2mXsbntVqb+wb7gDSOCA8LYHTXZmrhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SYV5+h5+nt/Vt85usPLMWDVuvkvinZgb5zUvXG2uyZY=;
 b=uQ7oJUfDOLvW+6hYYzig04CsLOur6tZGLEbbBW/I5+ZoTO6VfBrcC7U/FLH4LpEaZHKrCO7Ca5Yx30cS/1MHqreENiojt2GKTB8LxgX69lzzreT/+WO8aOOAa9hEjUwGNXHnkniD72kMOKgTHW/o7JcnfLmZNlfChi7IgXTh8xQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4229.namprd04.prod.outlook.com (2603:10b6:a02:f5::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.23; Mon, 8 Jun
 2020 21:34:17 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 21:34:17 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
Subject: Re: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in
 nvme_loop_ctrl
Thread-Topic: [PATCH 1/2] nvmet-loop: remove unused 'target_ctrl' in
 nvme_loop_ctrl
Thread-Index: AQHWPbH20HHmlisblkW3BkPpqnR6Fw==
Date:   Mon, 8 Jun 2020 21:34:17 +0000
Message-ID: <BYAPR04MB49655A1EFD53AAA965FB83AF86850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200608162002.17017-1-dongli.zhang@oracle.com>
 <20200608162002.17017-2-dongli.zhang@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ad56fc0-302b-4300-9e24-08d80bf3b289
x-ms-traffictypediagnostic: BYAPR04MB4229:
x-microsoft-antispam-prvs: <BYAPR04MB4229369485E2C37DF562B60786850@BYAPR04MB4229.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:55;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vnmHKZpoAegW+qhp4+mP4TLUduDHljWQjFuF2n7yAU7ZdmDvMI7aY15ryJ/b3RrXQheNXa/5fmc9KFO/enNVLg6RMvbrCrdhvKvhf3YJYONYuA+SgThZQ/UwMNK2N1T0C4T3qm62/ZQmfnjS9IX9oMKuf3RuGhq1mK5f5esAUT30hwpI2qMG8CwUMS8M6D6q4brSQigNEUyBsxpc2ZaLb3vMo3hbl6kLqdSDsVwfvcvjcO6+q+j0jMb4lCuvVLwM7iNn7t2oYP/SGqWrpNEzpgZSghDYXpqql+I9s+RHJkhDV2C4tRB8acoOIWrnP7MuBK/xs/9QW4JuiLXlhjvlNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(39860400002)(396003)(346002)(376002)(136003)(478600001)(110136005)(66446008)(9686003)(66556008)(66946007)(66476007)(64756008)(7696005)(316002)(55016002)(76116006)(6506007)(52536014)(8676002)(26005)(186003)(71200400001)(86362001)(558084003)(5660300002)(4326008)(33656002)(8936002)(53546011)(2906002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: AxZOg+AV5lfi3SBuOtVAtsOzZ5BnUnB2vYYeC7Gt8++YcjYpKrA6hLkc65YAyVqkdUakm117khI1u6bjoFdE2OIhcIls2ScxqadZnYEOqlIov8iN7mEmQN3hriUNCJ2v2P69daDmLGS+1B/JtKk0QBQIWiOBASk2euU9kUJ20QOcsr9qxh5mhA4vwy89zLzAOLBnJHis0GAE3//McoipE4JkbqRg7bM+i6EpnGJIVlq+hsRmIRRUuudkgt8R3SXXGI+CLWjIVbJuCYHUanweB2TZ2adWQu4OCtYKoyFJrfsLl2TYyN20yi2JHNOskiU+elGyBK4x/cQeb1Ma1p1Bp9ggXWz+0F9Nmd8qNLnTPKdWQBp3ErZGdyq+rAxGgKOia3EOOyW/E1Qt5K4VtZ9FQonvCX3ss5sEGnFVhBfB2K9raV0fKnRgvUxiEAq7EDg+0S0XCOVn2UU8vtOvBEiCRBftORwzmDmOffF1KlDvpZ4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad56fc0-302b-4300-9e24-08d80bf3b289
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 21:34:17.1987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /XhqqoZRIU/3nKkDYo0G6Fil0nHuBCC9dXdqANVO8EDalXQZSt+5xnaOkxASzIMI8TT0Xi7g+gCRrmT83xSAMLdWoFDBEJ0Ac1fgt8eABMA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4229
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/20 9:29 AM, Dongli Zhang wrote:=0A=
> This field is never used since the introduction of nvme loopback by=0A=
> commit 3a85a5de29ea ("nvme-loop: add a NVMe loopback host driver").=0A=
> =0A=
> Signed-off-by: Dongli Zhang<dongli.zhang@oracle.com>=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
