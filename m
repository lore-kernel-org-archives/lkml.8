Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A42420890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 17:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gzRjyjZO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="EHsNAyFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732299AbgFRR3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 13:29:04 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:16839 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729453AbgFRR3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 13:29:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592501354; x=1624037354;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=65fATkcGX1XMV8ZqADTopBjp7U3D4XZZb5sTGqRsBAo=;
  b=gzRjyjZO4HlRNZUaMU2Wu28tWKlTEWcIVKXcRs73rCK8gbu5I0hRcfiI
   FwAc0/AKmqyHymmwUc89jdu/LgOHiNCBNIL0wF0evKxTmL/eROqwagJLp
   ptUrlNb9y3hdxgzDN2eXfzFQ5MESxXY1cXgCROq8NpSJEqkebS4N+9TGO
   PH9elNgeceZKB5fwERV074JEiqtpgVhWYyfUXlr9moV2iryhaI6nOP6fr
   GTEbuhTmz96R5NCg5qBBGe30XrmZHU8QLbnGCvYab0Wxx8CO7T/dYAhoR
   KCTBuBW5/pxlVw8ZbGWrYqY6jYs61if71t7iv4yBgT50sKCXBbJ538PDn
   w==;
IronPort-SDR: GAF8GbCY2sMUDvs6oFDte2kMBtM77ZrZoggvsxxBn7dItF39O849VXdbaKEJslbY9JF+p+2xf8
 A+FKED8ex8sCU7BqJhU62Y5q07XogkBucjBTcbkrXJgHTCkUXsnPBN5hNWvJWat7TblslnM8ak
 5FXGJO5HbCklT7XUkIKaYZtaF1bauuY8cN7aFVDbdKCE4FjU3xes54tWGGQt24kUtId9HZuh9T
 3d2AaYREH2Ak+8Ma9+4gqaLZDnwNCNFHWmM+m0GOERNLEgWh7Z/N+k36C+j9hSWjOc0z8/XYxw
 MQ8=
X-IronPort-AV: E=Sophos;i="5.75,251,1589212800"; 
   d="scan'208";a="243303844"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 01:29:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MaC/dJMMSKZqx7RvYLrz6icf+c5qcmaLjmrAdeb9vV8lwkt83FI2XzTidq3ugQzzCxlai2gcgRkNTQuRdhkGbv+BdZimuLPojCvjnpR5rxivYZewKSbBUQhCe8z0kvGm1pW3P2HxD16QoUo8NF+scwmAi0XEyO0xAaEqIkMkzdbcG8UhU2gpw4C6m2wOGl5cEhGZWhf3ZuQLO4tRLhL0w6QMz8pmGi1YH0XeQ8vynHOJvegxCX0QmUhF/WSJO1CNjuCtioVV+9pubXr7/eF8Nl2oczEno0gLGNO/wKo1mGRf4WXBhwUtjo91wGXeveQ2oN2IM2QZLYTNVNNk3aIVYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2pKAGXGAjeAxpupRWGLgSEORk+y91EzQzS3dSarqH8=;
 b=oNS62eV3IkbGIcROejSQ2VUQUPmts8xVZ41rX6rwHyMBDcJFWVpyDP5N+ooZvrL+ikjTPMVB+gEWpVrCtC/eLD9ZNPRHg03XHXaEEyx87Cdwh1f1fshnUcxkuWs+Gp38YXlIGC4nqfGLB6GgwbW4xa0P/Tno27PtagAlChFQoJ6jYFiQ5t7GfNQHv8W9JvDRaryloxEgarYMPnjjOjX3h+97YR4YOBAWpW7HPfePlEbHZt0oSbbGfzor3wr7WIntmbCQ1MEfn51DkpSgqvPPuU/+4q92qLsnbmvqQRUpBjVHZ8dtzg16m1B81fNCDMNZrjQkdHvZJtK4pqvgvrBmQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j2pKAGXGAjeAxpupRWGLgSEORk+y91EzQzS3dSarqH8=;
 b=EHsNAyFbKdRhtl2SSi3JC35bRZmedihATI6t17XhHexAHXU+BmGxO6nXLF2pTjkJ8iVRKMtnqAsxXHOEysIO9X8mqcyzrsG20PCoDk2kOS31ZfQzNNUSLJIJN9tQVV95+/H+J3rmwb4vSrT/gDsBHbZiSwP6XOSnozEPHjW2Hmk=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5032.namprd04.prod.outlook.com (2603:10b6:a03:44::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 17:29:00 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3109.023; Thu, 18 Jun 2020
 17:29:00 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Topic: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Index: AQHWRX1ZyGByOih9fUSrbaAjQMq7Ig==
Date:   Thu, 18 Jun 2020 17:29:00 +0000
Message-ID: <BYAPR04MB4965AA7B57AC6B6E19BCBBA5869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
 <20200618143241.1056800-2-niklas.cassel@wdc.com>
 <BYAPR04MB49657026BADC613CA83CB896869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200618161509.GA1059668@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 385760c0-5ad9-4477-7bc5-08d813ad16de
x-ms-traffictypediagnostic: BYAPR04MB5032:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5032D4C407FAEE9F8923A3DA869B0@BYAPR04MB5032.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRdGICNiwgK6P9SrezoEiLTNLiwGO8msAxOUxCPdlJpienveRK9EqTcTPAAp/uG5iOMkpnD1klIRex4K1bXayVH+cGZN8tIN8J/OEFbCUsA0iNVcU0YWXLbEkFewCRLX45K1B9gEn3C2RxLYOM5dbrGkLf2UaB1hiON3iCcTImL3avJflb99eAvavGKoI1vBIpcT/QcdwbTafNaMTWuIMO4Dwz28QygUZh7ab53sP0me246EZbJzaWw1WuokNarMksuXGU7Uvzrd68IcfvoA9LzsO6mZM2ak7LsKg6Tb3aA+I5IUuhBNJ+CoUM90V90oE+mLEtXDluqfzGf5enyhhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(64756008)(76116006)(66446008)(66946007)(66476007)(66556008)(54906003)(478600001)(9686003)(316002)(55016002)(6506007)(6636002)(52536014)(4326008)(86362001)(8936002)(186003)(5660300002)(2906002)(71200400001)(33656002)(6862004)(83380400001)(7696005)(8676002)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Kg8m2E+DfNbCwXAFrtbCRRn2Gasxw7iRTljJxUQZmp/2ReGtN3d4xvujOK4hBugGbYx0BTujUUgvWT2EBV5tRFHL4qL7UPq2MT3rLp3DwcMfl1tgU1yNU7qvjf7jJtIWPPFLbAjdVYl9Aehs87wdDGjeaRuLvgWmwSZGqjm0CrCQ3vLO92AyonEZNkW/IOlW7Xed7oD1tjFwd2uPYoUs2+C7LUHC00QPJ0e4IjPb9jdYfv5jygVuyFTrYNXkN0/QfXLd97ENn9+v0GyISsDb59xSyqIpXQ+MoWCm4bGJuu/MhfxbmHO4qWtdzgqJuAw777e7BGM7ftIiGSbfBLoXeWs9NAUedQZUOpn6hniZDxsqpe8S3yVN+DWWKxITu9ciAlzHIwFeHW8rB14ecSBuVTZs+CJpr9sdII9MTkWBWM8e36ft/qjclZHxc5CeNjZ1E+fOmv/v2/gx7HKTtlWl4MvZJQAQLcgJaeTZUTqWh6Y=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 385760c0-5ad9-4477-7bc5-08d813ad16de
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 17:29:00.5315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYtemYXtOtzOq6Jg4HAgEjweYlr84bxJuPxJc4zoENwriFwFbxUk+8qIO3pQzdIBrVNEByNolvkbSjQ4brf3hsgKKmXGIqQ9SR/tcuHDRz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5032
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm  not against the code cleanup and it always welcome.=0A=
Please also have a look at other comment.=0A=
=0A=
>> What is the issue with existing code that we need this patch for ?=0A=
>>=0A=
> =0A=
> Hello Chaitanya,=0A=
> =0A=
> This is just a cleanup patch, no functional change intended.=0A=
> =0A=
I can see that.=0A=
> It simply performs the initialization at declaration time, which is how w=
e=0A=
> usually initialize a subset of all fields.=0A=
Absolutely not true in case nvme subsystem.=0A=
> =0A=
> This is also how it was originally done, but this was changed to a=0A=
> non-standard way in order to workaround a compiler bug.=0A=
> =0A=
and the existing code matches the pattern present in the repo no need to =
=0A=
change if it is not causing any problem.=0A=
> Since the compiler bug is no longer relevant, we can go back to the=0A=
> standard way of doing things.=0A=
Is there any problem with the code now which mandates this change ? =0A=
which I don't see any.=0A=
> =0A=
> Performing initialization in a uniform way makes it easier to read and=0A=
> comprehend the code, especially for people unfamiliar with it, since=0A=
> it follows the same pattern used in other places of the kernel.=0A=
> =0A=
This is absolutely not uniform way infact what you are proposing is true =
=0A=
then we need to change all existing function which does not follow this =0A=
pattern, have a look at the following list.=0A=
=0A=
In NVMe subsystem case there are more than 10 functions which are on the =
=0A=
similar line of this function and doesn't initialize the variable at the =
=0A=
time declaration.=0A=
=0A=
Please have a look the code :-=0A=
nvmf_reg_read32=0A=
nvmf_reg_read64=0A=
nvmf_reg_write32=0A=
nvmf_connect_admin_queue=0A=
nvmf_connect_io_queue=0A=
nvme_identify_ctrl=0A=
nvme_identify_ns_descs=0A=
nvme_identify_ns_list=0A=
nvme_identify_ns=0A=
nvme_features=0A=
nvme_get_log=0A=
nvme_toggle_streams=0A=
nvme_get_stream_params=0A=
=0A=
Also here :-=0A=
nvme_user_cmd=0A=
nvme_user_cmd64=0A=
=0A=
Last two are an exception of copy_from_user() call before initialization =
=0A=
case, but we can do copy from user from caller and pass that as an =0A=
argument if we really want to follow the declare-init pattern.=0A=
=0A=
In several places we don't follow this pattern when function is compact =0A=
and it looks ugly for larger structures such as this example. this is=0A=
exactly the reason {} used in nvme subsystem.=0A=
=0A=
> Just reading e.g. struct rdma_conn_param  param =3D { }; one assumes that=
=0A=
> all fields will be zero initialized.. reading futher down in the function=
=0A=
=0A=
No this is standard style and used in nvme/host/core.c everywhere =0A=
nothing wrong with this at all, please have a look at the author.=0A=
=0A=
> you realize that this function actually does initialize the struct..=0A=
> which causes a mental hiccup, so you need to do a mental pipeline flush=
=0A=
> and go back and read the code from the beginning. This only happens with=
=0A=
> patterns that deviate from the standard way of doing things.=0A=
=0A=
The function is small enough for such hiccup which follows the pattern =0A=
which we have it in the tree there is nothing wrong.=0A=
=0A=
> =0A=
> Kind regards,=0A=
> Niklas=0A=
> =0A=
=0A=
=0A=
