Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6E4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1810221E5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 02:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bKgGKfN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgHHCoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 22:44:38 -0400
Received: from mail-eopbgr70087.outbound.protection.outlook.com ([40.107.7.87]:13342
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726201AbgHHCoh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 22:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fk/8UIUzA3r0vZLaxUk0tRHggaC1LNqHugBdJrHU+0GRfnfGxKBDyfr4CkjW/SE7PA8ypyp4FaEZE3EvKNi2mBnSkZ+61qFyT8Ojaaq3ffhyxj5KU99lPJzyLN7A2k3YeOuZuUvg1JN8sHt+Tj77ng9BDMmIGwTEwlqoEnTsiSj4dghIAU/HV75zoIk6lINy56d+fwzzpXoHKo6CNDAk3GeFoni9QpBkPzZlLDsBhJEcy1w0BwTjU65FGpnBJDeUSXBKrIxz1ZQkrfailarr8CSPXWD6gcjVNyswNwr1AbFp5NclY/ItxKhFxeLYiNSWM0rCBRJ8rw0mIfckWKTifA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtfrBVWlcle1159msR286W4to2MxE4b4JJvVD8f3Xh8=;
 b=H1aNWrN8AzWiSGLHJv0B73y/iXV7NngpHljPCWo0C1+fCyrz8UE2gUFoM3O3VEF9U+nABqAbw1CcTCrb22YYWWyhVW6qKf5AzZIh2yBXw6POnE5xiVF94bkZbG8RJeTBDd1wm0+vibkKZXb2oN5kv5xAQNIce+cZPUg2UoL4POcuU/F2Uu+/BZ4ayvjsw02wty/jUeb2u7eBdv9YUGmypH3e6oqvCY4LT3my9N3TC03xNy4FAWDLwZ5/6JMMaOCDKpWxAjZ3+NNU0MOgKnvvhJluKfOhYi4fs+WCrpZ9adfSTr0Z6XsAWsg/Vg2lXlbwR2r4wxJkYYGATExgQrW1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtfrBVWlcle1159msR286W4to2MxE4b4JJvVD8f3Xh8=;
 b=bKgGKfN7y4qOoZyeAgD367Y/JN6WJvQgV2KZ42L7LT2ZDcPz/U3PDZdJxOz/kXhqZmGzyhmV3TSP7cNVMkGc4+YTXsSRcvrJeMBZNmV1Zg092oP5PrdtjZsFvTQTEdzIO/4B/q/hFe3ZjKOoABOCFn4fXB/EKR5Sue2UMEzsMg4=
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com (2603:10a6:803:127::18)
 by VI1PR0401MB2575.eurprd04.prod.outlook.com (2603:10a6:800:51::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Sat, 8 Aug
 2020 02:44:32 +0000
Received: from VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::30e2:71b0:ffd3:e39e]) by VE1PR04MB6528.eurprd04.prod.outlook.com
 ([fe80::30e2:71b0:ffd3:e39e%7]) with mapi id 15.20.3261.022; Sat, 8 Aug 2020
 02:44:31 +0000
From:   Jun Li <jun.li@nxp.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Peter Chen <peter.chen@nxp.com>
Subject: RE: drivers/usb/chipidea/core.c:657 ci_usb_role_switch_set() error:
 double unlocked 'ci->lock' (orig line 638)
Thread-Topic: drivers/usb/chipidea/core.c:657 ci_usb_role_switch_set() error:
 double unlocked 'ci->lock' (orig line 638)
Thread-Index: AQHWbKGsGqewxSYImkqunwNcEM9c26ktgfEg
Date:   Sat, 8 Aug 2020 02:44:31 +0000
Message-ID: <VE1PR04MB6528C68E6ADFA069F5A104E189460@VE1PR04MB6528.eurprd04.prod.outlook.com>
References: <202008071801.Xh6tOFOH%lkp@intel.com>
In-Reply-To: <202008071801.Xh6tOFOH%lkp@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [114.217.242.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d848123a-c1ec-43b8-177c-08d83b44fa82
x-ms-traffictypediagnostic: VI1PR0401MB2575:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB257508CC3106759234AA501189460@VI1PR0401MB2575.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:291;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TtewHE7GiWjWm7g12h7N/a3ymGYyt1liCWiEB7Ju8KOLp55buV4C931cua4lKKNMqbhPRh3IZqcu6UipyWAQX3Nb28KE81ohM5DoXILEQ1JPXEtQfOtHHZgj2ckd4SGmYH6jUTqoBWQ6mFzxNyvlChII225UcIPCZYH1jV3fDsvU6FLEjNkliZCDfk/AAtmvkBYQRYWmEnGsU3RR7eKQYyzaYyaYdszBEiDPjEbCYchDlGeTr9BzTzqw7FW76w6ocziGMkqKoiTa4KlMkYiredRFALClskrAF/vCufHEvf6xBAvEsr67i0kWFOT67qEk2Yp35/o9UX1atTmA+pIA8EfdjbKMDyw6s925uXrJJwII3Z/OSQE5jhmeJTTSptiQr37C5dwNyYuT+M5q5DfuRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB6528.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(478600001)(53546011)(66446008)(66556008)(66476007)(8936002)(2906002)(6916009)(64756008)(54906003)(316002)(45080400002)(26005)(5660300002)(8676002)(9686003)(186003)(44832011)(52536014)(4326008)(66946007)(33656002)(83380400001)(966005)(76116006)(55016002)(71200400001)(7696005)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bq5CCbDO1qu3hbuO2dhqfXJ5lSxF4WYvjd/KrLA4kDBQgzYZskarTN/PJv6N0DJoI3aWatipy1nw9TmQSih+b8eSEtXIdfk8JGjWjhV8o1zdw3VmWTOpQXy7sNe6mfESzGmwCX0MCOCOT2yzUiWIDrN8SF+RY6+7f/4j/0K7EYvVlI7DKi60DeAywb/eL62u/jywhT1E9pdyk3jTmmGZPU6VGCrUC+V8an4kGf/kjErMoW1DO0PFtAH1cY65bPDd21BUYyjqxinV/SOpvJwFGX0ekVCvFPdiHmtVPUJb04bL9gj99KV91w4ZeaICmQbJo9AqYYNNA6R9pVrTEd5tIzxMWNeS8IfUK1xhRZQiKFhDyaQQqgmgAQxaQZv1DVWLW35wo5W8TtqH5wlAPQznXovaNVuQPCt+qMg3RrT2XCex3oiLbTGkic3jSO99KljODXNv3brFxIscfuhggjRUsR36zn4kCmruM/aNbtuT8lIJ22thJ10p9adYxcufPRADiB1XrUEhqOq7k1TBuL5zTj1H3+vSCPPm8yLuly06DeFJK9TAkmytds4aQja+I3+PP8wyx21JuJDlisep/LhD7rordMJfw6MvFhQxTXuEGUwkiI2eHLA5kEQdkVw6IW+Bh8rNF9GrAhqrWK26KBDVlw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6528.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d848123a-c1ec-43b8-177c-08d83b44fa82
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2020 02:44:31.7880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ouMDq3Xrg2U/hJ1Zrho2r5N+xgartbjDOW/XpGxiuCkwpr6Aw9WnT+o446hgAEz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2575
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> -----Original Message-----
> From: kernel test robot <lkp@intel.com>
> Sent: Friday, August 7, 2020 6:00 PM
> To: Jun Li <jun.li@nxp.com>
> Cc: kbuild-all@lists.01.org; linux-kernel@vger.kernel.org; Peter Chen
> <peter.chen@nxp.com>
> Subject: drivers/usb/chipidea/core.c:657 ci_usb_role_switch_set() error: =
double
> unlocked 'ci->lock' (orig line 638)
>=20
> tree:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
ernel.o
> rg%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git&amp;data=3D0=
2%7C01%
> 7Cjun.li%40nxp.com%7Ce261827f14f6446b3e8308d83ab8c407%7C686ea1d3bc2b4c6fa=
92cd9
> 9c5c301635%7C0%7C0%7C637323912694699319&amp;sdata=3DioDexF9tIACz%2BlnZC%2=
BzZsiFz
> iOeeLembxqr9PwE%2Fpgg%3D&amp;reserved=3D0 master
> head:   86cfccb66937dd6cbf26ed619958b9e587e6a115
> commit: 05559f10ed797b79f7fa47313682c48919a2b111 usb: chipidea: add role =
switch
> class support
> date:   12 months ago
> config: parisc-randconfig-m031-20200807 (attached as .config)
> compiler: hppa-linux-gcc (GCC) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> smatch warnings:
> drivers/usb/chipidea/core.c:657 ci_usb_role_switch_set() error: double un=
locked
> 'ci->lock' (orig line 638)
>=20
> vim +657 drivers/usb/chipidea/core.c
>=20
>    615
>    616	static int ci_usb_role_switch_set(struct device *dev, enum usb_rol=
e role)
>    617	{
>    618		struct ci_hdrc *ci =3D dev_get_drvdata(dev);
>    619		struct ci_hdrc_cable *cable =3D NULL;
>    620		enum usb_role current_role =3D ci_role_to_usb_role(ci);
>    621		unsigned long flags;
>    622
>    623		if (current_role =3D=3D role)
>    624			return 0;
>    625
>    626		pm_runtime_get_sync(ci->dev);
>    627		/* Stop current role */
>    628		spin_lock_irqsave(&ci->lock, flags);
>    629		if (current_role =3D=3D USB_ROLE_DEVICE)
>    630			cable =3D &ci->platdata->vbus_extcon;
>    631		else if (current_role =3D=3D USB_ROLE_HOST)
>    632			cable =3D &ci->platdata->id_extcon;
>    633
>    634		if (cable) {
>    635			cable->changed =3D true;
>    636			cable->connected =3D false;
>    637			ci_irq(ci->irq, ci);
>  > 638			spin_unlock_irqrestore(&ci->lock, flags);
>    639			if (ci->wq && role !=3D USB_ROLE_NONE)
>    640				flush_workqueue(ci->wq);
>    641			spin_lock_irqsave(&ci->lock, flags);

Here we hold the lock again.

>    642		}
>    643
>    644		cable =3D NULL;
>    645
>    646		/* Start target role */
>    647		if (role =3D=3D USB_ROLE_DEVICE)
>    648			cable =3D &ci->platdata->vbus_extcon;
>    649		else if (role =3D=3D USB_ROLE_HOST)
>    650			cable =3D &ci->platdata->id_extcon;
>    651
>    652		if (cable) {
>    653			cable->changed =3D true;
>    654			cable->connected =3D true;
>    655			ci_irq(ci->irq, ci);
>    656		}
>  > 657		spin_unlock_irqrestore(&ci->lock, flags);

So it's fine to unlock here.

Thanks
Li Jun
>    658		pm_runtime_put_sync(ci->dev);
>    659
>    660		return 0;
>    661	}
>    662
>=20
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
.01.org
> %2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=3D02%7C01%7Cjun=
.li%40n
> xp.com%7Ce261827f14f6446b3e8308d83ab8c407%7C686ea1d3bc2b4c6fa92cd99c5c301=
635%7
> C0%7C0%7C637323912694709319&amp;sdata=3DtAxmh6eq3yT3A89mY2RrGQxwdkUN4A9r7=
08lFQJW
> gcI%3D&amp;reserved=3D0
