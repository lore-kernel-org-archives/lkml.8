Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B4E206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bbHy8C66";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cm+8lQiK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgDCU24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:28:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:22934 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgDCU24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 16:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585945737; x=1617481737;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pfxGPo9grdZs6+Bi9P+jCGvxER8l2+Wgnl10NM7xhaE=;
  b=bbHy8C66in3aqyAOSPvBMHdAjX4SM3kF0G5yaBhqVNAgGYPBR0QhKZYe
   cgQhcuy+9RBWcUhZVtBfHzqmUPHLIC9pIJDfOD0JSGql5zd7/3+L5zb+2
   0n3WDsrkcvl5AsKKeCNGnWScFZ43xh4WAKs8F6KO5EBuE/4p0HhWdzKJx
   qYC9gTqAq/mKafYpTWdjoFz8691l1mcRTs0blp+dMUu6y7Y3M3zPzickv
   XQ9C3NOBadizIqsc9+/UrXOCEzo+Zn2heZLifC8ARVviAU/VaHDCOVZfS
   /BZ8yB9ExKfo0PM2EnrcJL4K4wc40ytnCU5zF6zycN08nzfkVojPOp3se
   Q==;
IronPort-SDR: B4SooITmzeJFkwiVrdbTjkn6PyfmWxVAjAG+95j1jvhEKtlWZtOP1LAn49g9JOvf3XoWSvf2Qi
 +9ldmAX0Jdz4kPIJoNi39bOdGezyocoQYZ8mxD11Fbc5YZ/OPZQ6quSv5vnkEJl+p9PSWtr8sV
 CHX5SeVTNAIGrQ0OwaycpqnMOarX8psxiJjYIsMJ1zGvyZ1OPiNisViVxk/UHEGYq6hT4+VRXC
 0tWj8Otv2WuxDXpiYEvt9k/E3qvGCh/sdBW6DxwUY5eywnm9xv0pzegBj+61VISPEiUkCkpMT5
 vZE=
X-IronPort-AV: E=Sophos;i="5.72,341,1580745600"; 
   d="scan'208";a="236837632"
Received: from mail-bn8nam12lp2168.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Apr 2020 04:28:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGZMKJjpxCBN5EWaAWjz/S0WIz2TMOChAryzrPQ/zvDu6Skm+pwQqiqZ8C/R8W0j08UBy7nnKeqMfOzi6Vga+39pEMnjWdVQ/IXTaj9ryP2RetQv5upMxSwPYxYXYpP6ArIaMofCiaPfp0F4B+cjpq7loP8rGvy1/PArbrIyAo5pW96NTBYmYw1qSt3FNorFPA1lQfSJptDRLyIKnOBBecsMZc7r+t9P+NUj8iTIR/2Um7wP8FAJW+kJ6l66eSwt5pqKXES95m1sOc1lx5rYnOkhNp+1CXb3ls4XBtD+vJI4geoNoECRgz1xCnjFutaZjYrjoKZ+YxEqfne1o/idQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfxGPo9grdZs6+Bi9P+jCGvxER8l2+Wgnl10NM7xhaE=;
 b=UjZzX4dpovhuhNIJ6gTQWpNsET/8vbZzxJCqY4BM0ZPUz74wCKVmXwomhxeoHBWY+QrPYilbGIKsZLqglH/dh3ZemvMTisjVVJdVAYE0CXjnvUFxWrOGe5UoZRyWvw9bfiQyZ23cusytJUhQ1/5ptOTi8CXNVrn4Yl2OTfvm6r9RY2g+7ZooRS8kzwWevEIbjZ4hfXATyXBu4FD1M+4TaDWmkzEeMp73diH3K4HH5XKwd18EmVcYWIoF3ZusWNDlDJUQvHf55wbitoB4emi/2WjvEvcEjdk2LasLCeiNe2SlX9EMG0L8DRYAQe+6w6LMscr1E1NSQNTtAkiSI/ORLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pfxGPo9grdZs6+Bi9P+jCGvxER8l2+Wgnl10NM7xhaE=;
 b=cm+8lQiKi/cVZyhE2Bm7IH3aBKDelsRf7i/65s/dkpTIaEeg0oG9MdVINICGO3iXjZnkcjUAy8B0TIRJf1npltO0raRTId1hzOZOxf33GS54Itcm2153fwID02B6NQeUxV18HIT5vbD9sYtOe34194NMQT/QZFjDeNEcxpneSeU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4296.namprd04.prod.outlook.com (2603:10b6:a02:fa::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Fri, 3 Apr
 2020 20:28:53 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::d826:82b2:764f:9733%7]) with mapi id 15.20.2878.018; Fri, 3 Apr 2020
 20:28:53 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Anthony Iliopoulos <ailiop@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Topic: [PATCH] nvmet: add revalidation support to bdev and file backed
 namespaces
Thread-Index: AQHWCSVL06kuVSKmBEqONSGslHKI9A==
Date:   Fri, 3 Apr 2020 20:28:53 +0000
Message-ID: <BYAPR04MB4965E4160FDA8F0BF668198086C70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200402193052.19935-1-ailiop@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 04375043-77f9-4bd5-32d6-08d7d80da0be
x-ms-traffictypediagnostic: BYAPR04MB4296:
x-microsoft-antispam-prvs: <BYAPR04MB4296C3D37A9A4B9F6E6E17DF86C70@BYAPR04MB4296.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0362BF9FDB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(136003)(376002)(396003)(478600001)(4744005)(55016002)(110136005)(4326008)(54906003)(316002)(186003)(7696005)(66556008)(86362001)(53546011)(33656002)(52536014)(8936002)(66446008)(5660300002)(8676002)(66946007)(66476007)(76116006)(6506007)(81166006)(71200400001)(64756008)(26005)(9686003)(2906002)(81156014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gp1VOnSxCbZAyXuNWpjpM9ca+6dRevI7J9tznoR0ieRmpMuP2MAz17eHguP/l1QzvGl2kY38t8K9/enPUucCcrt08lHeJBscB58cUmyynWRm7LgaQ5JN9YUJ8gCmjxaiUma/ZIk0RlrolzGh1lCYGjDc6gGopWqD1fYH0PXn13/Vpg/v9wGHXbLi31Hq+w6x7THt69P5SdGgSMKyTeScnQik0gfug0ILUEEM4sNuH/TyMqQyQzC+AYlaqNq7sMNTi4S6LJL2VGu6TIkhjkpGso8pyhEYbM7u/4PNlElfZxGrEIe+Qaz+kzOe7+nPPTRLn0f0TabztwCXLIMmcbct+GuSbiEDJYpSC5rhZS1iAGrNBTmOsjyIxvdVe1dPGmzRDYIGo8It8wvffwmL1+JQPbA02NUrdeKeA1tLbJ7e4sbTkzUzwYeVQlAKQ3e4FRe7
x-ms-exchange-antispam-messagedata: Fy0Cvng/6G5bEvbxXdXuCzZw2Azz87hd0WcarlI5iDSTmLQui+kdgx0JrvBsusCi74OrmxnAV4WDdJUUnPpfmHidW0YoTTiAXjOeJSPUUPXN61DLyJzv6pRqY4TmgPKXGycrHYEb0iQlwcd8mDg22Q==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04375043-77f9-4bd5-32d6-08d7d80da0be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2020 20:28:53.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OOERb5VQV0xgo4Qu8YoHZcwNHhTc0WrJelB+5Fw+0t/HT9eoyqlQCU84L5QxmJDA5/VR9JKBFaEeeR3WAZdldPpAodT6vEWXglyndJPQwdg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/2020 12:31 PM, Anthony Iliopoulos wrote:=0A=
> Add support for detecting capacity changes on nvmet blockdev and file=0A=
> backed namespaces. This allows for emulating and testing online resizing=
=0A=
> of nvme devices and filesystems on top.=0A=
>=0A=
> Signed-off-by: Anthony Iliopoulos<ailiop@suse.com>=0A=
=0A=
Since we are adding this code for testing I'd like to see test cases=0A=
for both bdev and file.=0A=
=0A=
All the testcases are in blktests/test/nvme/ with nvme-loop for NVMeOF.=0A=
=0A=
=0A=
