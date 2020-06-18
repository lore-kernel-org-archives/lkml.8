Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:00:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4A720890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:00:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="SRVIPOrG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="pQYDjrQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgFRUAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:00:21 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:42571 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728960AbgFRUAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:00:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592510417; x=1624046417;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jRrJXMEchcTWvFyIs4r3UPi8it0qR1LeCD+CFYOxvBc=;
  b=SRVIPOrGcbRENC7Th8Lq1YHDhFqF+nGHcYArSGUhj8rAzRpLlkvzabtZ
   PckOQHU1TvvFhjF3jeSPG85UbKYh558H0sCy+0I3r2bZB9s+Teu5KGUD9
   bYavErxaDZlh7xqJC27p0W+N2Yb6z2LGBIt7Syne2/OdoEkq8Z6WysaWR
   L1q6PoyBHvdSp8skHF9FyUxRwl65NTSODP5obGJAmAMW1dN4fwsJ/2Z6/
   Vcx+fBqDi/r14q53RCuZSyFM3bo610oOki+ApR4tvNXnG6eNTyzWZFVP4
   J7/ESm3l7YoT1iYLLc/yjcgDrqfIPYOINa9+6frHSN7lVTXjVMQ/jgsTJ
   Q==;
IronPort-SDR: A+fqD33kFsgWBBqYnXrVd6lgp1nameZnpKgl7ueDeaqTzUJKuHv0iuLwKHAEs5qxnT8G40Rh3z
 4GrKIveGhBojK6rUoslEpmWgYsj79KXjEXXxW9ced/0GfaMBpJUonN4//TxeEHjTaBKSx0xjlx
 Za4mjHCGtH37sloNZSzRZzwbV1vSCSNvgyqYD30ffaygYYWhL39W/CU3c2+C/uaROp5wICQr3d
 RW5nzIvmosOQyvAYWtASRexOQzwF7bqOW3h6rdxsOnRCJDh7FYjGnXvRY9jijaGIa6LhYNVzYC
 fA0=
X-IronPort-AV: E=Sophos;i="5.75,252,1589212800"; 
   d="scan'208";a="243315982"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jun 2020 04:00:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yps1XqulJwQIETKsQEELxxsmL/PZgZIbBeaAksz1aYXoy9wEL7GC3R7gVUwCVPyLzFVgdsNCTP8d818kLJg/JvVXQnB9IMRQ2zDT/JsQjZ/Aocrs2O6X/JF7wmpyi3MZvYmE58EwrXtV4ymA2P6ciHY8GLliy6byKgd0PGWVp/xpKD7q/j1jDeJsFey2UQ8UdkId773J+GtevsKradlbNMwl4gYqsZpu+412WesmLUTZREpb9tGLvRAeR8kkppbnrlt8DD4mSOR5vsJUlVW+n9vxemD/W8bL99GU0fx/B8Ew/9xiMr23v+AplwLKZBkZjltk7eVGZRXtA+RgbTAbkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4GYvpDs60CtE/p1oldPUIUzB/SWrjipVjDWwt6btdY=;
 b=Y+dquCXj0KlS0GnL77uGP/VDaT8oUYAjXjwGUWm9KfxU3z55mU+Rp9JUttH/ZyKFtPBcDDXzxNLTUCo3IsDirc6Ux0qb00Kzo0tIUX7e/j8tikut7nDPqPpmX5gFP8+5YPj0WZcFgMgYv2eY3csMLodVHn3QWH8qsUrJ7wvro9ZCRp4VdbKLM37oFkQv+rA0vpHIL6AtZ8lfvIBiZ6f23GOo5TwJQlFUOFw6ST43jNU0/OLFdsfS86sDHj1yhJSWt9UilIZDo8pWcEr71iNTeipjWgfsxc+yoMJwQYWWmnl5AMaA4ZjMcUOaoxFNCBiocma4IEtg8jAHkf/KKn0obA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4GYvpDs60CtE/p1oldPUIUzB/SWrjipVjDWwt6btdY=;
 b=pQYDjrQDaKgBCYQ7qJy/h89YuAouOWFaeUMbKPoc25lTusJTvp9NB8SN/i96sBCc56g7mp5U1j+YFXuvxNnn+cd7jlywbHDMvUwv9qYyS33P7sCPD5sOO2xxrAB57qa0tOdStRUkPVkDLqETV2SJyX0gfzu7WFHF+nkw9FKCZLA=
Received: from BYAPR04MB5112.namprd04.prod.outlook.com (2603:10b6:a03:45::10)
 by BYAPR04MB3832.namprd04.prod.outlook.com (2603:10b6:a02:af::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Thu, 18 Jun
 2020 20:00:13 +0000
Received: from BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b]) by BYAPR04MB5112.namprd04.prod.outlook.com
 ([fe80::a442:4836:baba:c84b%6]) with mapi id 15.20.3109.021; Thu, 18 Jun 2020
 20:00:13 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
CC:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Topic: [PATCH 2/2] nvmet: remove workarounds for gcc bug wrt unnamed
 fields in initializers
Thread-Index: AQHWRX1ZbrDHfOtockWlJJLIW+DNgajeyykA
Date:   Thu, 18 Jun 2020 20:00:13 +0000
Message-ID: <20200618200010.GA1080112@localhost.localdomain>
References: <20200618143241.1056800-1-niklas.cassel@wdc.com>
 <20200618143241.1056800-2-niklas.cassel@wdc.com>
 <BYAPR04MB49657026BADC613CA83CB896869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20200618161509.GA1059668@localhost.localdomain>
 <BYAPR04MB4965AA7B57AC6B6E19BCBBA5869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
In-Reply-To: <BYAPR04MB4965AA7B57AC6B6E19BCBBA5869B0@BYAPR04MB4965.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.224.200.150]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 76713ffc-d441-45fd-28d7-08d813c2367f
x-ms-traffictypediagnostic: BYAPR04MB3832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB3832AD933BD3789A4F3FC3C2F29B0@BYAPR04MB3832.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0438F90F17
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4A61ktEnR6i4Ng0cedN0xOSHMVj0tW76hhm/a8Vb4mkxFd6wxIFIoTmrlt3AjM6oMHppdFkHszOgk1WVO8MK9udRyoNQDeGTE68qk+pL+LYog+ckdmeKJwmdsRUJN7jonaLkcoGy3T72ENVb3YMTihNlBjIFpvPA847qtY3Q7Eh4TMVcA+tu0W+K1vjQQFlZR2N2pwtUWKLtp9fcaM4ucrXipdaemxbPL8RKkVL23tMU0hfwt1ImQgi0j0MQniaZswjy/DzE2w+mFN0O2gdYRMCuWfV+Qh7Tn+ElRenjiOsGcLVAnlVbVfnLJwuA6MOan6atuXnteD0NtEiL/+GMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5112.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(8676002)(6512007)(33656002)(71200400001)(8936002)(9686003)(4326008)(6636002)(6506007)(83380400001)(5660300002)(66946007)(478600001)(66556008)(66476007)(66446008)(316002)(1076003)(6862004)(2906002)(6486002)(86362001)(76116006)(91956017)(186003)(26005)(54906003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kD3ZGYp2/QZD7GvPXJOreVDX93d9iiYH1H2swCWLb0xXJsSvkLsL91tMp0gn9Xdo7SlF/D+OOyqhq0gV3+TWtMa2VfSRJfxujEj3cuf1cyMmmBmWCNC+nYWwKoH2Nx+L1o9xc08TpXbyZpGs8wOflYuQ+yX2A94tO/hufBwGj9Mm395SeirIV/kYaaMFzhXJhzv9+ApwC6ADc309+ywfuYsg9IXbDtX+67qZ1QiF5MLXbA6K2s3Zzgy8USg5aEUPVJVlGn5RDJl0K9sIZML8Y12322Sr2m6OeT1rVCEHrw/nTDdkxvu1SbrV5JbUN4NeYDQG0ibAPEfdKT463k53rIUyCLQWhmylg3n8HGSaaBpHPVaNTfTavZSgyPOOny1aGEX6ROW2UT00YkwqIYerMOKe2JFoIWO+657t3LS8i8qBKnVAqUTc59kAr4yUXXetgDSxUT4Tg/6y9AC5yzoOH5WkhlwNjG5gpeAzoZFgIv+NsPCWpzr1rFoqV/HDhvix
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32AE7E24D2EE0D478095ED56BE24F095@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76713ffc-d441-45fd-28d7-08d813c2367f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2020 20:00:13.0998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JRz31nsvVj51xnnsogJ9GOuxxQu6zSt8lOhjLGEef0yW998nLkuN8bxqnGrJdBWsglCgcjxQEuAjH2J3CwnIWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3832
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 05:29:00PM +0000, Chaitanya Kulkarni wrote:
> I'm  not against the code cleanup and it always welcome.
> Please also have a look at other comment.
>=20
> >> What is the issue with existing code that we need this patch for ?
> >>
> >=20
> > Hello Chaitanya,
> >=20
> > This is just a cleanup patch, no functional change intended.
> >=20
> I can see that.
> > It simply performs the initialization at declaration time, which is how=
 we
> > usually initialize a subset of all fields.
> Absolutely not true in case nvme subsystem.
> >=20
> > This is also how it was originally done, but this was changed to a
> > non-standard way in order to workaround a compiler bug.
> >=20
> and the existing code matches the pattern present in the repo no need to=
=20
> change if it is not causing any problem.
> > Since the compiler bug is no longer relevant, we can go back to the
> > standard way of doing things.
> Is there any problem with the code now which mandates this change ?=20
> which I don't see any.
> >=20
> > Performing initialization in a uniform way makes it easier to read and
> > comprehend the code, especially for people unfamiliar with it, since
> > it follows the same pattern used in other places of the kernel.
> >=20
> This is absolutely not uniform way infact what you are proposing is true=
=20
> then we need to change all existing function which does not follow this=20
> pattern, have a look at the following list.
>=20
> In NVMe subsystem case there are more than 10 functions which are on the=
=20
> similar line of this function and doesn't initialize the variable at the=
=20
> time declaration.
>=20
> Please have a look the code :-

> nvmf_reg_read32
> nvmf_reg_read64
> nvmf_reg_write32
> nvmf_connect_admin_queue
> nvmf_connect_io_queue
> nvme_features
> nvme_toggle_streams
> nvme_get_stream_params
> nvme_user_cmd
> nvme_user_cmd64

These do not use an initializer at all, these use memset.
So at declaration time, these are not initialized at all.

Basically like:

int a;
a =3D 2;

I don't have any problem with the memset code pattern per se,
it is very common. Although it is weird that the nvme code
sometimes declares a "struct nvme_command c" on the stack,
and then memsets it, and sometimes uses an initializer.

Perhaps we should create a patch to unify this.
IMHO, using an initializer is more clear.
memset has to be used if the function needs to reset an
existing struct, but in none of the functions above are
we given a nvme_command that we need to reset. In each case
we declare a new nvme_command on the stack (so an initializer
makes more sense).

> nvme_identify_ctrl
> nvme_identify_ns_descs
> nvme_identify_ns_list
> nvme_identify_ns
> nvme_get_log

These used an initializer, and then also later did explict assignments,
e.g.:
struct nvme_command c =3D { 0 };
...
c.identify.cns =3D NVME_ID_CNS_CTRL;

which is basically the same as doing:

int a =3D 0;
a =3D 2;


However, I have fixed these functions in patch 1/2 in this series,
so that the values are set in the initializer, and then there is
not need for any further assignments.

Basically:
int a =3D 2;

>=20
> Last two are an exception of copy_from_user() call before initialization=
=20
> case, but we can do copy from user from caller and pass that as an=20
> argument if we really want to follow the declare-init pattern.
>=20
> In several places we don't follow this pattern when function is compact=20
> and it looks ugly for larger structures such as this example. this is
> exactly the reason {} used in nvme subsystem.

If this pattern of using an initializer and then doing an assignment
is the desired pattern, then you should at least remove the
/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
comments from drivers/nvme/host/core.c, because then that comment is
not true, because then you want this design pattern because you like it,
not because of a gcc bug.

>=20
> > Just reading e.g. struct rdma_conn_param  param =3D { }; one assumes th=
at
> > all fields will be zero initialized.. reading futher down in the functi=
on
>=20
> No this is standard style and used in nvme/host/core.c everywhere=20
> nothing wrong with this at all, please have a look at the author.

I think that the standard style in the nvme code is to assign the
values inside the initializer when assigning values to a struct
(except when using memset), see e.g.:

nvmet_tcp_try_recv_ddgst
nvmet_tcp_try_recv_pdu
nvmet_try_send_ddgst
nvmet_rdma_init_srq
nvmet_fc_add_port
nvme_fc_parse_traddr
nvmet_copy_ns_identifier
nvme_tcp_try_send_ddgst
nvme_rdma_inv_rkey
nvme_setup_irqs
nvme_fc_create_ctrl
nvme_fc_parse_traddr
nvme_fc_signal_discovery_scan
nvme_aen_uevent

And then there are the many many
static const struct's that are assigned values using initializers.
(Which I didn't count.)


I made a small mistake in v1, so I'll send out a v2,
feel free to continue the discussion there :)


Kind regards,
Niklas=
