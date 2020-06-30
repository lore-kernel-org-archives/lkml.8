Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB904C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE7F20760
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="XPwYdaT3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389596AbgF3PjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:39:07 -0400
Received: from mail-dm6nam12on2079.outbound.protection.outlook.com ([40.107.243.79]:6071
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731107AbgF3PjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:39:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7ApMDXX31QEd5NbksuDSWjSnLPrOtOkODDfJpw97eATqRXdI1LGgzwIKfi/NzAqjX1QV8mwqKfBwl27GHFD0q2pQID1sf0HkvXQodQrkKQJpdenC5I12udkOmH8BEtTTf92TpS4xXrvzmy+TKtJdthV5tr0HhLH4N0J9gt/Xp26hlEn5c6oRyDs4N8sa4Nz7yc3YpPbPF2qzqaUmGeUAP/p829el7xCfcYhkEJXHo2WcMhMEJS6jdzA9oQiUodTexxr/SPfiFk3PQhz24f8DJmWjJgiUYErDMzev0IkCTQxad5QQ2+qmFRik3nT/BRzKdw6t5uxgppeZna1xtOv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULwFnId12BOKn2lWfVbvOr5jV5Oxn938DJ4JbYf8CAY=;
 b=Q6a8mOEh3BVAytWNOBQuwQRmdj9xKD4UclPYgvg8AM3DnYoB/jI2t+aAigRbNF+d/sXaUAM4j1nYeP+MFdmwFzN41x4dJblEBPI/Pp6Wj+DCzvKal3om+EtNFxQoMbKBvGbUQNl0B7yCR/i9OsMHtBFze32vFh+jm49UeGeACiAXGULQYJejzSixEMINn1F3ghu4n9d2q4pA/LYlFK6Td2EA/hvXabEleo7HdY/uE82H5Efu2rElV0ePn9Xp+gfOGpVWAy9RFZNWISzrSMigRYvgHS35UUGqmvRNqUO+AyFxXh9YtV4Hxv9OfZjKeGiJ/4PtIubwGm1Y+ZSARupDAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULwFnId12BOKn2lWfVbvOr5jV5Oxn938DJ4JbYf8CAY=;
 b=XPwYdaT32KIu9POyUdOrHcILcoyN8ZzHxnbL6gwt8Q1obAyQmJDhnWMnXOhDY8PTyzX1c6+ig5om8mBSLVOKXyufT3UeGMQW9RGgvBulDaveeL4IQ1CSg6/HvE1YtQ8k5EJN6n0s4KsCySQaEy4LtudaIiLadLSeVyWB3ld+U3o=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5430.namprd02.prod.outlook.com (2603:10b6:a03:a4::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Tue, 30 Jun
 2020 15:38:58 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::e59d:9815:461e:2a79]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::e59d:9815:461e:2a79%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 15:38:58 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stefano Stabellini <stefanos@xilinx.com>
CC:     Rob Herring <robh@kernel.org>, "ohad@wizery.com" <ohad@wizery.com>,
        Michal Simek <michals@xilinx.com>,
        Jolly Shah <JOLLYS@xilinx.com>, Rajan Vaja <RAJANV@xilinx.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <stefanos@xilinx.com>
Subject: RE: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Thread-Topic: [PATCH v4 4/5] dt-bindings: remoteproc: Add documentation for
 ZynqMP R5 rproc bindings
Thread-Index: AQHWGl7uxdGBAyULe0azD2FJNJZOnqijj0uAgBdEEWCAF8YrgIAeHusAgAAc24CAAN6D4A==
Date:   Tue, 30 Jun 2020 15:38:57 +0000
Message-ID: <BYAPR02MB44079AC22428C6D59548E7ECB56F0@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <1587749770-15082-1-git-send-email-ben.levinsky@xilinx.com>
 <1587749770-15082-5-git-send-email-ben.levinsky@xilinx.com>
 <20200511221755.GA13585@bogus>
 <BYAPR02MB44077C8B7B7FD23FDE8E31B8B5B00@BYAPR02MB4407.namprd02.prod.outlook.com>
 <CAL_JsqLGo380SRYska+xGgJhgF8NCRvY56ewafvSCU6c-LmhZw@mail.gmail.com>
 <alpine.DEB.2.21.2006291734370.8121@sstabellini-ThinkPad-T480s>
 <20200630022029.GC407764@builder.lan>
In-Reply-To: <20200630022029.GC407764@builder.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [98.207.156.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 01cad00d-67c5-4eeb-cd0d-08d81d0bb466
x-ms-traffictypediagnostic: BYAPR02MB5430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB54305657D15B0347FA06BBE4B56F0@BYAPR02MB5430.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0450A714CB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KvPsff1rO+AQLbVo5ETF9cvjKNO3K1mUXkVwJsAQSQe+W1rLQdINeaXtJSts3Ckq57Oay22oTS/K1O7lOdjGZ9fhJg8VRXmjlNIW9ycwMb9C31z1mT0c0Yd+TguR/y7723W+gPf4SJEK+OJJnhyStKDBuOqaRaIDOym0uETgw95zb64RWebkCPXcyjXdtE0q85uBKkHdVtm5fwrdXT43zbnG+vjfAjtolEp0sKebIAgxPgpUBiqZltpJjjoziT4y4gM2+Ch4DWbDIxNKgOWQDLoZru/c2pypw3X5f7Rgn5Jj4cCmgA3kmF0+sfu5PMBzdB50CguWd7B/Q6tbq8yJQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(376002)(136003)(346002)(396003)(39860400002)(33656002)(6506007)(26005)(8936002)(478600001)(53546011)(52536014)(55016002)(107886003)(2906002)(5660300002)(7696005)(6636002)(86362001)(83380400001)(8676002)(66946007)(186003)(66446008)(4326008)(54906003)(71200400001)(9686003)(66556008)(76116006)(66476007)(64756008)(316002)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: tvxWEnce4nx7qNvcxBGpHh/p8fA5L47xk2+DfZx1VXUI9EValW3L+yYQwVJb3RLSkZVL56WHzH13gEzsh/s4qLlgN4LC8wkfu2MddLdJq6XfMxKFwdi4VKgNwu2HreAlbfRfhrm2yWQcDlyE06l5ODqH3NKNethZMTrEla1RGSYQd1GFkZANv1eMEGBAXWc+s4fdKxAIcKjxqIjgkGOPw816itgXcuctYUh1t9LXPjYIFcqPw0Dj1bY6LUdSHvhgcHDpH8DN7birvR4Bs4M0ZkmYRwBjl6dABmGbGQLbhl5DmG/zWmoYiAeU5LeUJ5OMMSHMxspdG47CrObTdYX+K3zBjB+Ai+XbisGji8eq8csTN0Gb1ia0nHtcdwPm8CID77tw4ESW4SBm5BhqLKOfGj5AX6lp45Qf5CkrbpnbHboXmBIDJ4dvKuJNNWyhwAgWtewE0RxSgCnHTQwKKdqmCObzl+w+ATdrak5s/2OBuP69yczHUOVSttrEjUf9fwBV
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01cad00d-67c5-4eeb-cd0d-08d81d0bb466
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2020 15:38:57.9328
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oipKRxZPPA2HEXFexZrDxBYFEPbbGzKEc7CRIOagxcn4WCAClb7q1K/hGn7785pDXN/1hwXUoo+s6LW2fysvbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5430
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,



-----Original Message-----
From: Bjorn Andersson <bjorn.andersson@linaro.org>=20
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
