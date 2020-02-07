Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB59C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 067D42082E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L/27GFwP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727502AbgBGCIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:08:10 -0500
Received: from mail-eopbgr50061.outbound.protection.outlook.com ([40.107.5.61]:56413
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgBGCIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:08:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTfjyEpo0C2+pRg+SSoximUGRzKjUXpJlu6w0KSyuWqxny3Hlb8xeJL0+h8JU+zWoRjkX8x0xxv6CgYq5DPr1bZBeIvLBqLt47G6rZ0IzVQBv85eRwaVIxooixPkVT6LgPsfdPACtDSW9JfJM+WT/sRzAUdt7/jsfksWwavs7/yE8+vZV0H+bZGoeLMsGGuWmuSJyYOyebQyzCL6I+hPgguTGjD9XMuiy0+A6duxbCiCpzBAcHSqYzmqmSbrV/6D0p3lbht2rpGeCDWh++9EReLGLVNesFZsp7NSeSKU2OdC8y8c3JLTUHkvXYQOniRHPLSIbeo/o6cY3AfltrWY2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPtvfXJTWSAbU09S9T3YXw6E5hfOBZ/SlxjwKvjn64A=;
 b=SFpoPFeXS3Sn2QvG6CeKRn8OYKZ5jMUhlahytzMA/TpMxGuEZOTJq5//7J97zNL1gp4W/j3GK/nughskBD8H9b+4Q+hwrHi3mM442meUmQnZR0a56CSR8S+2A21Rk6+Iml0lWeP52M+1ByHBH5nNhl2ysOEpuo1/CS91l+JpzXLt44PuJCgwZWnWoSsh6gTr//Mxvy36R/qbsJvS7IT84ukTuk9kiYINPa4aQ9rns3981UzfmfBxFx6ZPlD4IwtAB/v/KjCU/LWx+iqX05i7JzB84wkXpQDkpJtoHHXNy6Mwdt8bDS05PSjsY0hSCEDe7eY6/9Aw9FfmU8ydTCtnSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPtvfXJTWSAbU09S9T3YXw6E5hfOBZ/SlxjwKvjn64A=;
 b=L/27GFwPxYjIrn15gh8UBCzDHk0GGPEJvh0IIzsUvXQv0VUAobqm+FolmZ18PYssrOFmPBMkTW7Z5KlXxSVKGmOrsj9Vt1O+yHYUkjsI7Kee+aiDUncCY92giAtaGUwwnNtdkNIq3AZE9azmT0G+FxJz3UjEKeKn1RKxwjS29/s=
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com (52.135.147.15) by
 AM0PR04MB6962.eurprd04.prod.outlook.com (52.132.214.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Fri, 7 Feb 2020 02:08:07 +0000
Received: from AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422]) by AM0PR04MB4481.eurprd04.prod.outlook.com
 ([fe80::91e2:17:b3f4:d422%3]) with mapi id 15.20.2707.020; Fri, 7 Feb 2020
 02:08:07 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] firmware: arm_scmi: mailbox: share shmem for
 protocols
Thread-Topic: [PATCH 1/2] firmware: arm_scmi: mailbox: share shmem for
 protocols
Thread-Index: AQHV3O24QXHBlTcD4kSCPnFpCByfEqgON8AAgADC2KA=
Date:   Fri, 7 Feb 2020 02:08:06 +0000
Message-ID: <AM0PR04MB4481A6C089DD233D4099566D881C0@AM0PR04MB4481.eurprd04.prod.outlook.com>
References: <1580993846-17712-1-git-send-email-peng.fan@nxp.com>
 <20200206142204.GB3383@bogus>
In-Reply-To: <20200206142204.GB3383@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=peng.fan@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1079dd0e-55c2-4332-fefd-08d7ab729296
x-ms-traffictypediagnostic: AM0PR04MB6962:|AM0PR04MB6962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR04MB69622262C1DE239BC74E0486881C0@AM0PR04MB6962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(366004)(39860400002)(396003)(136003)(189003)(199004)(55016002)(4326008)(7696005)(9686003)(6916009)(478600001)(86362001)(186003)(26005)(33656002)(2906002)(81166006)(81156014)(8676002)(44832011)(316002)(54906003)(6506007)(66946007)(8936002)(76116006)(15650500001)(66476007)(4744005)(64756008)(5660300002)(71200400001)(66446008)(52536014)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6962;H:AM0PR04MB4481.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 28rlNzxYzCvqJid+0qesx/QmPRnw326Mz4r4ob77z7lCdCwIXhfdmNG+D23AUgWCqD4UXeXvPuSkJUqBdwSQKHYG18vmWSTLp8Hbh4zGwtPk4pDHunN5P+MJqPf8/rDA+a5scVd+bLiM1dLXWGgEjiBJPAoWKnTxt/EboKxe4gc8BLwgHe/dhXiaUeHYk8f4epk0N6UwpDsmzCf/o9CkRTMvj72YxOm5eTwQarqOG/9bYiGSIuaqD10lAv0UDRMGPHes0CUh+aYyOIxIsFvohqsuQl+PdBqXYyWHWeGCJ+2bnQEVt3ULwp+zkiTwySARtkgdTdOMysV1bU541+06B0Shw8PXC/HP8Qm6Kd/9uN1fwiu+ex0KoLOAhmq3RSVrcaFqTCNIWVGmSzx5raEcRMqz9YyJCzmSr+tlwOs1OzbZ/uyJ32QCPJHhk/HHT2Vr
x-ms-exchange-antispam-messagedata: z8RDvtFEF1IbM2oqJDu5TnH56yuzEQo+RMywyynJ2+UIyELW/kTxXhcoeOslboLUdyGZt1qpRx7z9r41o+Py11sHUlQqr4Y+GTSGlvK/4OHsEkCnA2EjshuSoy23TQm7spauil0YRxIGRufCiCS+fw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1079dd0e-55c2-4332-fefd-08d7ab729296
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 02:08:06.9625
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DDoLfJfjC/NY72pto8uRtVEc9I7yT7Gl8gb3pW0IKQpXlwREvh1k26xLxSqIfI0PdNfqsphuiIX3dxt7693jaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6962
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH 1/2] firmware: arm_scmi: mailbox: share shmem for
> protocols
>=20
> On Thu, Feb 06, 2020 at 08:57:25PM +0800, peng.fan@nxp.com wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > When shmem property of protocol is not specificed, let it use its
> > parent's shmem property.
> >
>=20

+arm list

> Why do you even need this ? If shmem property of protocol is not specifie=
d
> then why is the mailbox property ? Either you need both or none. I don't =
see
> the point of this patch. I am interested to know how are you even hitting=
 this
> case.

Without this patch, I need add shmem property in each protocol node.
With this patch, I only need to add shmem property in scmi node.

In mailbox_chan_setup, cdev is protocol device, input parameter device
is the parent, saying scmi device.

>=20
> If you don't have mailbox property, then chan_available is false and henc=
e we
> don't call chan_setup.

chan_avilable only parse mbox properties, not shmem.

Regards,
Peng.

>=20
> --
> Regards,
> Sudeep
