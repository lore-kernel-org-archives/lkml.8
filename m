Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCEDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8669C207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ZyhFFOoB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHROYN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:24:13 -0400
Received: from mail-dm6nam11on2069.outbound.protection.outlook.com ([40.107.223.69]:27105
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726709AbgHROYG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:24:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pyfqas97zxGA0YRYjYOAa7zU6wnxyz5WgNDz22LxN3gVRiKH8uAa5xpl8Yh//39wQ5uDPwpmUYYrnozQfB539wUdwH4sDK9DbBVZv/grdA5ZVbYu/5Vugm+OtGpk9QPci8SE547L9Avsw/foA351xt9Dkaw6uq+LI6syOBcMBs3KqtsRvkK89tDgM5PvwZCbod+3M44dNFyq8yi0VD+8b0qr+pKc3ZBdE2/UeRHnppxZuVzjv7P4R/MXM2aZttUuDtQDySnZMnY/wiBvGoGso8YJjmeJ9tzKIcSjpuz5qF4Z/iwZs8Oy2sJgBkeGAWgg32ZQYlUBznVNfRYuat5QIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf1aL0D+/12/G3ECe0X0hQ5RLSCGOkvTPmlmXL3tztg=;
 b=hcmwrUndeAhRlLqm3+7NyOHLfuGg+KheCa12eUS6ygRWwm1bs2wMtn5yZdbjSIjKTjl9593iySEwFszDbfS6zNMrSR+HSCtj9w4veTutzlqACysXDv4TIlsgxO4vfOGSBoOUlw6/8TKoTFhADgQRla3H4Hs1XYkTuMoBhYiIQEWYFGraPW/dpI69zi1VVj29tGm1E9PPGX7mV6SiauRmglSOjChzTUX+bT7zpPfjIXFTFsW2k3tAOQ3EjsGh/r7Xd15DH6GojQsnMu0pITpg4D1Tigs7E1itQIkvxzu+B4y/mKuRyTCLrmTpnJ0tmf0HgLPzcZ0I768CPw+JMR4EQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pf1aL0D+/12/G3ECe0X0hQ5RLSCGOkvTPmlmXL3tztg=;
 b=ZyhFFOoB9qUowSo12NTSfg9hlaphaHTI+exdtUO0OhNHHN8TyGqc7/NLbNrFWfLQDsOm/y2vlqVrHBk6yrvpkj4PpBWe/WloD2+ooCmc3hH7LVxbnX2gXb5loMYs/DRYJp+Z3Xab1cm28xPoisyi93N1eh7WYsgidLaLIIxpwZ0=
Received: from BYAPR02MB4407.namprd02.prod.outlook.com (2603:10b6:a03:55::31)
 by BYAPR02MB5718.namprd02.prod.outlook.com (2603:10b6:a03:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Tue, 18 Aug
 2020 14:24:02 +0000
Received: from BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5]) by BYAPR02MB4407.namprd02.prod.outlook.com
 ([fe80::b0f6:b3a:6543:26f5%5]) with mapi id 15.20.3305.024; Tue, 18 Aug 2020
 14:24:02 +0000
From:   Ben Levinsky <BLEVINSK@xilinx.com>
To:     Stefano Stabellini <stefanos@xilinx.com>
CC:     Michal Simek <michals@xilinx.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "Ed T. Mooring" <emooring@xilinx.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Jiaying Liang <jliang@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Thread-Topic: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
Thread-Index: AQHWb5AL1Cmns7xcFkizB0J8iqhSuak2g3KAgAdzeCA=
Date:   Tue, 18 Aug 2020 14:24:01 +0000
Message-ID: <BYAPR02MB44076F48364A94C05F636870B55C0@BYAPR02MB4407.namprd02.prod.outlook.com>
References: <20200811033213.20088-1-ben.levinsky@xilinx.com>
 <20200811033213.20088-3-ben.levinsky@xilinx.com>
 <alpine.DEB.2.21.2008131103230.15669@sstabellini-ThinkPad-T480s>
In-Reply-To: <alpine.DEB.2.21.2008131103230.15669@sstabellini-ThinkPad-T480s>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [24.5.142.107]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d3f17faf-37cd-437f-6ca5-08d843825ac0
x-ms-traffictypediagnostic: BYAPR02MB5718:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB5718CC6008903A74CC639AF4B55C0@BYAPR02MB5718.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5jU2ySYMiEq4vm9KpHNABhdnPwAPyma1WhoOVFNitvLhZIemmYwcLNPR1TPtF6pRavUccVF3BJGO+sBurFz7O0eYloEnS58aGt3/XHIEWTq9C69Q6yxOCjJ29MwVkMyVACOo/BBGHNNabKeZBh69gqP9+Qv6SeKfDXHYSrdMe9ydEZ5D9kzdoQODgNIcUEXdDafjlQ5OdVVihEi2HjItz+fz3xrVeF3vxsp4q5XSWgKY8SxE2uz7jLiW5rJCcEadocDzQZFC6OyM7ZPeB/gLF7qyddchzGJ0yER+n2HJ2/rBfcKRETmMjGWD5SlkCl/q5C9QN0PRcff6zJIYFR4o7AJPWN78bZNFAp4Iewagij5mX90693RlDogmye8n7lS1nUvAXOckuVb9mtpbVNa6Sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB4407.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(376002)(396003)(366004)(64756008)(26005)(66446008)(6636002)(52536014)(966005)(53546011)(6506007)(478600001)(33656002)(4326008)(83380400001)(54906003)(86362001)(76116006)(55016002)(2906002)(66946007)(9686003)(66476007)(7696005)(71200400001)(5660300002)(6862004)(8936002)(66556008)(316002)(8676002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: hlad5NJakkMcLgpfRV9h761SqaKMRTri6HBmIKgl4uXQ0wSeuUB77p4SQl2m0WjvUx6RMc7E2bdd+O/Fn1+bXw3VHZodaUZYZY6e6S5X7zooA3YwFgQTFj0RDjTr2+5KqJ/lXpjnuSZm1dsQgzRfpA+yPcVK0UJaK1s81anv0dCo8Wlm+OgUVAKeevtKtBAWXNm6glx+VzNFGq42Cv15BR5+FJJRPFaYngv853U9LA4DJaNtmgiVKUc4mks8PC5J1MpBJopMUvB+JZtkTk+UZGwiec3hfQk/KmFiY5vmZ7Wm9xzvuDUOGAupu1T9zTLug/Ny+fFlQtk3lARrvdbCl9JxRfe0ZsNDU8zO7caz6OF5klASj3FA4Ku9l4wn9sREdCJdQGvnhP9WF289xZgbsMaoDC6IdpPmuHa2VZzlCplkCZYEW9a2X9HFzTIHeGqYoxY9A7Ox4el5UnUQ+/C4ij4QhtMzAeZnjRlKdi+VjlPz1mAGSuu6jaTgKy/A35XxFXfPRNmXQ3MBXsIwzuVzOgUecluTAQN9S6viFfyg+0cTtU3qvo+E7cnP62mgZJFHGwvVYYai9LHzB8DxjvQVUD7tLNWqh8kipUs/jecmWfzVRtCfTPwJYUnpdUiAWTKY/fei+bBi3XtzSe9BMNn1nQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4407.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3f17faf-37cd-437f-6ca5-08d843825ac0
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2020 14:24:01.8535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: icXK3ytN+3H9EGHf9Y2iL2vsTFqWMthb54orxPLdvo/qUSw/zj6GrOsKe+ChFy8jYReAQbQdwIfCaDrqrOoCHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> Sent: Thursday, August 13, 2020 1:36 PM
> To: Ben Levinsky <BLEVINSK@xilinx.com>
> Cc: Stefano Stabellini <stefanos@xilinx.com>; Michal Simek
> <michals@xilinx.com>; devicetree@vger.kernel.org;
> mathieu.poirier@linaro.org; Ed T. Mooring <emooring@xilinx.com>; linux-
> remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org;
> robh+dt@kernel.org; Jiaying Liang <jliang@xilinx.com>; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v8 2/5] firmware: xilinx: Add shutdown/wakeup APIs
>=20
> On Mon, 10 Aug 2020, Ben Levinsky wrote:
> > Add shutdown/wakeup a resource eemi operations to shutdown
> > or bringup a resource.
> >
> > Signed-off-by: Ben Levinsky <ben.levinsky@xilinx.com>
> > ---
> > v3:
> > - add xilinx-related platform mgmt fn's instead of wrapping around
> >   function pointer in xilinx eemi ops struct
> > - fix formatting
> > v4:
> > - add default values for enumv3:
> > - add xilinx-related platform mgmt fn's instead of wrapping around
> >   function pointer in xilinx eemi ops struct
> > - fix formatting
> > v4:
> > - add default values for enum
> > ---
> >  drivers/firmware/xilinx/zynqmp.c     | 35 ++++++++++++++++++++++++++++
> >  include/linux/firmware/xlnx-zynqmp.h | 22 +++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/drivers/firmware/xilinx/zynqmp.c
> b/drivers/firmware/xilinx/zynqmp.c
> > index 8d1ff2454e2e..f1a0bd35deeb 100644
> > --- a/drivers/firmware/xilinx/zynqmp.c
> > +++ b/drivers/firmware/xilinx/zynqmp.c
> > @@ -846,6 +846,41 @@ int zynqmp_pm_release_node(const u32 node)
> >  }
> >  EXPORT_SYMBOL_GPL(zynqmp_pm_release_node);
> >
> > +/**
> > + * zynqmp_pm_force_powerdown - PM call to request for another PU or
> subsystem to
> > + *             be powered down forcefully
> > + * @target:    Node ID of the targeted PU or subsystem
> > + * @ack:   Flag to specify whether acknowledge is requested
> > + *
> > + * Return: status, either success or error+reason
> > + */
> > +int zynqmp_pm_force_powerdown(const u32 target,
>=20
> If the target is really the node id, why not calling it "node", the same
> way as below?
[Ben Levinsky] good point. Will change to "target" in v9
>=20
>=20
> > +			      const enum zynqmp_pm_request_ack ack)
> > +{
> > +	return zynqmp_pm_invoke_fn(PM_FORCE_POWERDOWN, target, ack,
> 0, 0, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(zynqmp_pm_force_powerdown);
> > +
> > +/**
> > + * zynqmp_pm_request_wakeup - PM call to wake up selected master or
> subsystem
> > + * @node:  Node ID of the master or subsystem
> > + * @set_addr:  Specifies whether the address argument is relevant
> > + * @address:   Address from which to resume when woken up
> > + * @ack:   Flag to specify whether acknowledge requested
> > + *
> > + * Return: status, either success or error+reason
> > + */
> > +int zynqmp_pm_request_wakeup(const u32 node,
> > +			     const bool set_addr,
> > +			     const u64 address,
> > +			     const enum zynqmp_pm_request_ack ack)
> > +{
> > +	/* set_addr flag is encoded into 1st bit of address */
> > +	return zynqmp_pm_invoke_fn(PM_REQUEST_WAKEUP, node, address
> | set_addr,
> > +				   address >> 32, ack, NULL);
> > +}
> > +EXPORT_SYMBOL_GPL(zynqmp_pm_request_wakeup);
> > +
> >  /**
> >   * zynqmp_pm_set_requirement() - PM call to set requirement for PM
> slaves
> >   * @node:		Node ID of the slave
> > diff --git a/include/linux/firmware/xlnx-zynqmp.h
> b/include/linux/firmware/xlnx-zynqmp.h
> > index bb347dfe4ba4..4d83a7d69c4c 100644
> > --- a/include/linux/firmware/xlnx-zynqmp.h
> > +++ b/include/linux/firmware/xlnx-zynqmp.h
> > @@ -64,6 +64,8 @@
> >
> >  enum pm_api_id {
> >  	PM_GET_API_VERSION =3D 1,
> > +	PM_FORCE_POWERDOWN =3D 8,
> > +	PM_REQUEST_WAKEUP =3D 10,
> >  	PM_SYSTEM_SHUTDOWN =3D 12,
> >  	PM_REQUEST_NODE =3D 13,
> >  	PM_RELEASE_NODE,
> > @@ -376,6 +378,12 @@ int zynqmp_pm_write_pggs(u32 index, u32 value);
> >  int zynqmp_pm_read_pggs(u32 index, u32 *value);
> >  int zynqmp_pm_system_shutdown(const u32 type, const u32 subtype);
> >  int zynqmp_pm_set_boot_health_status(u32 value);
> > +int zynqmp_pm_force_powerdown(const u32 target,
> > +			      const enum zynqmp_pm_request_ack ack);
> > +int zynqmp_pm_request_wakeup(const u32 node,
> > +			     const bool set_addr,
> > +			     const u64 address,
> > +			     const enum zynqmp_pm_request_ack ack);
> >  #else
> >  static inline struct zynqmp_eemi_ops *zynqmp_pm_get_eemi_ops(void)
> >  {
> > @@ -526,6 +534,20 @@ static inline int
> zynqmp_pm_set_boot_health_status(u32 value)
> >  {
> >  	return -ENODEV;
> >  }
> > +
> > +static inline int zynqmp_pm_force_powerdown(const u32 target,
> > +				    const enum zynqmp_pm_request_ack ack)
> > +{
> > +	return -ENODEV;
> > +}
> > +
> > +static inline int zynqmp_pm_request_wakeup(const u32 node,
> > +					   const bool set_addr,
> > +					   const u64 address,
> > +				   const enum zynqmp_pm_request_ack ack)
>=20
> code style
>=20
[Ben Levinsky] will fix this in v9
>=20
> > +{
> > +	return -ENODEV;
> > +}
> >  #endif
> >
> >  #endif /* __FIRMWARE_ZYNQMP_H__ */
> > --
> > 2.17.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
