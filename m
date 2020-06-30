Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A2AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB90220723
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 17:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="GdWA0ad8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390037AbgF3RLL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 13:11:11 -0400
Received: from mail-mw2nam10on2069.outbound.protection.outlook.com ([40.107.94.69]:37924
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387545AbgF3RLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 13:11:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCzc4Xeb75tzF+aV46qa5v0p/23A23eyfnoW73aQy576hYHpi9oYWaljbUY+pOd/GfuavuCXc3CDWCDEcmpWes2WMhMZMJU0AbJ2H2Wc/FQbzIDt+kSO7+rtpxSoy7k+b6sRicW2sPEweXtYnalxCHoflI9/L4XnU9X3oItQTPrFVWraXPxsBz9U+HnP1XQnSFfWq7H2ESAWY8ol9vw97tJ/gLxr6imZyvZHQL8K8nRDcZiIEe959u1sQA8yH7CNK6+urmpwdVlPgIcB7sRri39oyFPjwxOhdS7eiZu3ajVfgb5NsNgyN6wARNkFZ5J/uWCrnZb18emW8nRDfwaLOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpdusHvNrNI/8TePPzuk3CV3zK6FpckbMvuNcAmytUI=;
 b=htdGfGuzLsMk6o4D+OVRGRKtvQYQbHWIdxMkbLR30bvlgYGs8esLv6ox0ktG3QTLL7MJPmfBsg3otWZ0K3nGE+yct9mjftjdS4NrdFrRXac+mDyuAL9OgXtRX7kh/DT0rKO9WkmcgOMCSzS3zds20XSKxiRHhInICCifVgk5MSlT8mLU+7B8bC+P9uI8ROMJ66Ku15EiyMXflRdWVYjyOklO9eZDetJlZDwgvdUu9v0QC8WXC+Mw0QabOoNoqaGShshSb1EJm3UXFZDRKNqfzrrBi4PygEBct4IpGegE+3vnXpHyQP9qnwtfHVSWXo1GRMqQ2nmoWEzePDDWO0MN4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpdusHvNrNI/8TePPzuk3CV3zK6FpckbMvuNcAmytUI=;
 b=GdWA0ad85vcRrlSVC/0o3NCgG2yHtjDOqit/75S/zJ0vsxUlmjM515KmyRyHI0+tusAN3NoHHMCPqUHY6kYMUtYggztlGbhzrk09FF1SJMvpEWIXYJE+BZ0d7AYNyV5+eY0ZhiysmaQbLjrb+dezLUWis61SZxIxTkvCRw6RBqI=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5190.namprd02.prod.outlook.com (2603:10b6:a03:6b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 17:11:06 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::e59d:9815:461e:2a79]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::e59d:9815:461e:2a79%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 17:11:06 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Stefano Stabellini <stefanos@xilinx.com>,
        Rob Herring <robh@kernel.org>
CC:     "ohad@wizery.com" <ohad@wizery.com>,
        Michal Simek <michals@xilinx.com>,
        Rajan Vaja <RAJANV@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: RE: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Thread-Topic: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Thread-Index: AQHWGl7uxdGBAyULe0azD2FJNJZOnqijj0uAgBdEEWCAF8YrgIAeHusAgAAc24CAAN6D4IAAGDLg
Date:   Tue, 30 Jun 2020 17:11:06 +0000
Message-ID: <BYAPR02MB44077F4E61AC3E96F0458D21B56F0@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
 <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com>
 <20200511221755.GA13585@bogus>
 <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
 <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
 <alpine.DEB.2.21.2006291734370.8121@sstabellini-ThinkPad-T480s>
 <20200630022029.GC407764@builder.lan>
 <BYAPR02MB44079AC22428C6D59548E7ECB56F0@BYAPR02MB4407.namprd02.prod.outlook.com>
In-Reply-To: <BYAPR02MB44079AC22428C6D59548E7ECB56F0@BYAPR02MB4407.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dbb9f62c-d588-44c2-8e1c-08d81d189392
x-ms-traffictypediagnostic: BYAPR02MB5190:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB51904C92E2FDA0F580E7906CB56F0@BYAPR02MB5190.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UDNMHlwEFm6RTqje/98UE5HD8KfKekkO7PXxsSC0inU/Hsu+CS9RLEVOe+PAUgSIKnLmOVb2H2O/7aHzmaO7Wq6phxAtBgXN4DR7d4hRKDZItXNNTH1XghmxvX9UOLeCen7qzFXlTKMCz7FuxzEao/nE2U75sD5hCa04XfPxmZq8nXdsiNoM0BqbpJQHvCzL/yAabBv3oymErgonZJy7z5QApSFAaAVs8eNSi+7H9Svlhfg8MKNU1ZheeGr2LZGgJ1lLyIQpYOQysxS9OAdseIwvC9zVdttr4aYDW6dGRBZvfjJQfOO3RKjve421oc5U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(396003)(136003)(366004)(2940100002)(54906003)(478600001)(71200400001)(26005)(33656002)(83380400001)(86362001)(9686003)(316002)(55016002)(66476007)(66556008)(53546011)(110136005)(66946007)(76116006)(7696005)(4326008)(66446008)(64756008)(52536014)(8676002)(186003)(8936002)(2906002)(6506007)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: P0dyN81z+i8K2XIU5X0HuF38Xx2pTH0WwkKseabDk9QA8x6wF2lxR44k39I17sCpJPISBPKqxlnpc0TX5e4lrS1HVSFXcnZGYe1uW2KYE1wYWuFDSNI48ZS354SBijMF/XjMXLAsLTCvfps1vVjKUZz5ti01naJhxg++KDITqUJXJfTS5dtN29DCR7QhC/RzbZM3vhd7in8f7rHMr9BV38O5Y1IWkE6BPlCv/SzVJQ8SxZgrfXJeZuU97PZIqqnOFYak0dsdh76nMFIJ1LmYSV/BCwXgxjDIAtKfG2POWuBqBPbC39dJ2N46+AW0JgIy9xC+a1e+LOjYGOPDWcuHoDtduEKX522HiSyhLvSfEkCad5VgHS1ORYnoRciIZSDht1whOMVT6J2eQ+zzjbNFPJMkL03KxYI6nyv5TCNLIrl5IWY3tWiu0TyFQcKtRtQs6MqhK27MEGncoWwmKNjIROLfGJBq+5VcIrZNkBE02Y/0pTOQ4rx7ZE1rbEGbbH+W
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb9f62c-d588-44c2-8e1c-08d81d189392
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 17:11:06.3312
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qc3JCfyRHL4Xz7lbLRcjgpwGEJZkgvPEUmlLIekP4WRVOHtZJGHdoGT5cJW3yaiJwG9wouELGm7B7wk01pX/9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5190
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Below is proposal simplified device tree binding as per the below discussio=
n.

Best Regards,
Ben

reserved-memory {
     #address-cells =3D <1>;
     #size-cells =3D <1>;
     ranges;
     elf_load: rproc@300000000 {
          no-map;
          reg =3D <0x30000000 0x40000>;
     };
};
Rpu {
     compatible =3D "xlnx,zynqmp-r5-remoteproc-1.0";
     #address-cells =3D <1>;
     #size-cells =3D <1>;
     ranges;
     lockstep-mode =3D <0>;
     r5_0 {
          ranges;
          #address-cells =3D <1>;
          #size-cells =3D <1>;
          memory-region =3D <&elf_load>;
          pnode-id =3D <0x10>;
     };
};

-----Original Message-----
From: Ben Levinsky=20
Sent: Tuesday, June 30, 2020 8:39 AM
To: Bjorn Andersson <bjorn.andersson@linaro.org>; Stefano Stabellini <stefa=
nos@xilinx.com>
Cc: Rob Herring <robh@kernel.org>; ohad@wizery.com; Michal Simek <michals@x=
ilinx.com>; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja <RAJANV@xilinx.com>;=
 mark.rutland@arm.com; linux-remoteproc@vger.kernel.org; linux-arm-kernel@l=
ists.infradead.org; devicetree@vger.kernel.org; linux-kernel@vger.kernel.or=
g; Stefano Stabellini <stefanos@xilinx.com>
Subject: RE: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for =
ZynqMP R5 rproc bindings

Hi Bjorn,



-----Original Message-----
From: Bjorn Andersson <bjorn.andersson@linaro.org>
Sent: Monday, June 29, 2020 7:20 PM
To: Stefano Stabellini <stefanos@xilinx.com>
Cc: Rob Herring <robh@kernel.org>; Ben Levinsky <BLEVINSK@xilinx.com>; ohad=
@wizery.com; Michal Simek <michals@xilinx.com>; Jolly Shah <JOLLYS@xilinx.c=
om>; Rajan Vaja <RAJANV@xilinx.com>; mark.rutland@arm.com; linux-remoteproc=
@vger.kernel.org; linux-arm-kernel@lists.infradead.org; devicetree@vger.ker=
nel.org; linux-kernel@vger.kernel.org; Stefano Stabellini <stefanos@xilinx.=
com>
Subject: Re: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for =
ZynqMP R5 rproc bindings

On Mon 29 Jun 17:37 PDT 2020, Stefano Stabellini wrote:

> On Wed, 10 Jun 2020, Rob Herring wrote:
> > On Tue, May 26, 2020 at 11:40 AM Ben Levinsky <BLEVINSK@xilinx.com> wro=
te:
> > >
> > > Hi Rob,
> > >
> > > The Xilinx R5 Remoteproc driver has been around for a long time -- ad=
mittedly we should have upstreamed it long ago. The driver in the current f=
orm is using an "classic" remoteproc device tree node as described here.
> >=20
> > I would rather not have 2 possible bindings to maintain. If there's=20
> > been no rush to upstream this til now, then it can wait longer.
> >=20
> > >
> > > I am working with Stefano to come up with an appropriate System Devic=
e Tree representation but it is not going to be ready right away. Our prefe=
rence would be to upstream the remoteproc node and driver in their current =
forms while system device tree is maturing.
> >=20
> > There's obviously going to still need to be some sort of description=20
> > of the interface between cores, but this has parts that obviously=20
> > conflict with what's getting defined for system DT. The TCMs are the=20
> > most obvious. If you can remove (or hardcode in the driver) what=20
> > conflicts, then perhaps this can be upstreamed now.
>=20
>=20
> Hi Rob,
>=20
> Sorry it took a while to answer back but we wanted to do some research=20
> to make sure the reply is correct.
>=20
>=20
> The System Device Tree version of the OpenAMP remoteproc bindings aims=20
> at being simpler and vendor-neutral. As anything else System Device=20
> Tree, Lopper will read it and generate a "traditional" device tree=20
> with the existing remoteproc bindings. In that sense, it might not=20
> affect Linux directly.
>=20

Can you give some examples of how you will be able to describe the hardware=
 involved in powering/clocking resources surrounding your remoteproc and th=
e necessary resources in a "simpler and vendor neutral"
way that then can be further lopped(?) into something that Linux can use to=
 control any remoteproc?

> However, given the fragmentation of the remoteproc bindings across=20
> multiple vendors (they are all different), I think it is a good idea=20
> for Linux, for System Device Tree, and in general to come up with=20
> simpler remoteproc bindings, more aligned between the vendors. If=20
> nothing else, it is going to make Lopper's development easier.
>=20

In my view the big reason for the fragmentation between bindings is because=
 they all describe different hardware. There has been common properties of =
remoteprocs discussed, but apart from the firmware-name property I don't th=
ink we have agreed on any.

>=20
> So I think it is a good idea to take this opportunity to simplify the=20
> Xilinx remoteproc bindings as you suggested. The idea of to removing=20
> the TCM nodes is a good one. In addition I asked Ben to have a look at=20
> whether the mboxes and mbox-names properties can be removed too.
>=20

If your remoteproc uses a mailbox for signaling, then this should be descri=
bed in devicetree. This will allow you to reuse components in other designs=
 where either part is replaced or reused.

[Ben Levinsky] The Xilinx R5 remoteproc binding can optionally use the mail=
box. That is if loading a simple binary that is not making use of IPC then =
the mailbox is optional and not needed. Not sure if you still would prefer =
to have the example showcasing use of mailbox then.


Regards,
Bjorn

> Ben will reply with a simplified bindings proposal.
