Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2153FC33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA482214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 06:46:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="r6dMLAb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMGq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 01:46:57 -0500
Received: from mail-co1nam11on2084.outbound.protection.outlook.com ([40.107.220.84]:14848
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726435AbgAMGq4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:46:56 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1OUK7rQ6HupzMNr0wLveSMl9s76FbkDRMRYW2eN8iEi0uiwqN1R4hoEQKndRq2dY4UobqwsgF8V9FhqnLkton3mUlReeUsenzY7IzMe8GTc/coq2Yju9s7SE9KyoP7C7mwRc82/obKwU8456IoBXQvXaSuesw+jJSpnctlVPUs3MbYWYBgJnDnZmmvlgK2O0QYt6tnIoZDRNxbbztjgwkhHlocMVYpBvIoluYJCjVZNExKxZiTFi4Vkc5H2Hmz0Q6vykAY8XdXaESyn0HbvaaFCDKIU8AfmT+yCgpqFaT7I2tGQQg5r3NWZZ1H2Zl4xMwhcj/b5QSaJARrMuHNzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oPjHj4o/d7Xv4MBb9hIWNEje+pKnsEqxm8je1jYIcw=;
 b=cPvXVijhmgjMzTrrE6IwmcvTeH+vsXthUqOF+Yml07ESvq7ZzD6pc7V6U8wWwCpfkqpRiLfLkdWi7kjvxfzsNYHgcBkiIcF3+kWI9QWu6dauJHkZV3MRdCGyi4MiU2uJJleE6tQm3m9RaGQRyjbB9s9vsrRphak4ce2jmP8QSf/UGNhafU8Xb6HiWao/7/SIq6LUNf5UjyRhn3OpZVR7qyD4CtfHtWEm6JJV0F1nWjhZTlV04yOQ+Yv1WJkETXYHXHT8lvh3ATAwDF9mM7t6k5sTczERZV/g4fkX0/WRrqdoun5KCgX9ZDywjFCwvNAgag7kVqm5hU2ItVQtDUQkMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8oPjHj4o/d7Xv4MBb9hIWNEje+pKnsEqxm8je1jYIcw=;
 b=r6dMLAb7fH/LUzp6hFTc985roRs/oFHkQbHzaK0qOm7Avsf265TduDqZiuXFyxvttb9u8Sx5Y/72xUVm36H3N8MNsMeuWSHWDgAWR9FeplPnLjPRwsmJw0gM+nwtE3Ch4wDb8Fcfs8rtAq89vSrr5mxTo9ULw0ux7fbhTBV3tqE=
Received: from BYAPR02MB4055.namprd02.prod.outlook.com (52.135.202.143) by
 BYAPR02MB4007.namprd02.prod.outlook.com (52.135.204.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Mon, 13 Jan 2020 06:46:53 +0000
Received: from BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::f964:6ae7:834b:8fa7]) by BYAPR02MB4055.namprd02.prod.outlook.com
 ([fe80::f964:6ae7:834b:8fa7%5]) with mapi id 15.20.2623.015; Mon, 13 Jan 2020
 06:46:53 +0000
From:   Rajan Vaja <RAJANV@xilinx.com>
To:     Sudeep Holla <sudeep.holla@arm.com>, Jolly Shah <JOLLYS@xilinx.com>
CC:     "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        Michal Simek <michals@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tejas Patel <TEJASP@xilinx.com>
Subject: RE: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
 optional
Thread-Topic: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
 optional
Thread-Index: AQHVxx/fTp0hk3voQU+k+EbrUrDiSqfjyxyAgARcgUA=
Date:   Mon, 13 Jan 2020 06:46:52 +0000
Message-ID: <BYAPR02MB4055B8A5ED27C2F23A28D8D0B7350@BYAPR02MB4055.namprd02.prod.outlook.com>
References: <1578596764-29351-1-git-send-email-jolly.shah@xilinx.com>
 <20200110115415.GC39451@bogus>
In-Reply-To: <20200110115415.GC39451@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RAJANV@xilinx.com; 
x-originating-ip: [149.199.62.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1bcce14a-0afb-4db4-60bf-08d797f45fbe
x-ms-traffictypediagnostic: BYAPR02MB4007:|BYAPR02MB4007:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB4007595357165A74D9E5081EB7350@BYAPR02MB4007.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 028166BF91
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(199004)(189003)(26005)(7696005)(33656002)(9686003)(55016002)(478600001)(186003)(86362001)(4326008)(107886003)(8676002)(81156014)(81166006)(54906003)(6506007)(53546011)(2906002)(110136005)(8936002)(316002)(66476007)(66446008)(66556008)(66946007)(52536014)(5660300002)(71200400001)(7416002)(76116006)(64756008)(6636002);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4007;H:BYAPR02MB4055.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nAKgNQZhGFoNroJhafWP73JhB+Mn6usySi2myHF2ba4sw9b17vs2GkzltV0RyhbK55/1HhtVae14jcyb2BK39XLN+6ftzhfxB2mH9vVqEqnfSTNRkvKjqCHIkML0jbo9b5AqhIeCEJh/I4WFaCSz/86kSLyIn8H6dZP/khVt47cKDym++6kO8bFraRzCxnZ4aKgfxbhBtLhH0IjHVo/+2E9J0MH2CcXnKh7VIRo29RgK/yLXPJXjwCTxVGt6YKjNbIWSs6lqWH4lTKzFHVzbru6Di+SlxsY26VeZ6+QWSpVlLVrWsdJ8OA+bRsVPMcQ/StdNeJK1UhVCC8uDOKeJG/dobwc4xhojJHdmQR1lq0OpaYa2ssvTJhmqw3aT3xg0MpZ4PNqHaZFo0XlCaa0Aq3J168QFgxYbTQ4LUi5fTtBkcHHSzTEiY8hH9EzqK4Vm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bcce14a-0afb-4db4-60bf-08d797f45fbe
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2020 06:46:52.8891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z1nV7YtSIYq67J+gveFWN2FlgQZ+UInLbrkHSVhKNoAIOkHAL+tIJRJgebpl2LYaK0lCCQZT5WuRClMnem3nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4007
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

Thanks for the reviewing patch.

> -----Original Message-----
> From: Sudeep Holla <sudeep.holla@arm.com>
> Sent: 10 January 2020 05:24 PM
> To: Jolly Shah <JOLLYS@xilinx.com>
> Cc: ard.biesheuvel@linaro.org; mingo@kernel.org; gregkh@linuxfoundation.o=
rg;
> matt@codeblueprint.co.uk; hkallweit1@gmail.com; keescook@chromium.org;
> dmitry.torokhov@gmail.com; Michal Simek <michals@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; Sudeep Holla <sudeep.holla@arm.com>; Tejas Patel
> <TEJASP@xilinx.com>
> Subject: Re: [PATCH 0/2] arch: arm64: xilinx: Make zynqmp_firmware driver
> optional
>=20
> EXTERNAL EMAIL
>=20
> On Thu, Jan 09, 2020 at 11:06:02AM -0800, Jolly Shah wrote:
> > From: Tejas Patel <tejas.patel@xilinx.com>
> >
> > Zynqmp firmware driver requires firmware to be present in system.
> > Zynqmp firmware driver will crash if firmware is not present in system.
> > For example single arch QEMU, may not have firmware, with such setup
> > Linux booting fails.
> >
> > So make zynqmp_firmware driver as optional to disable it if user don't
> > have firmware in system.
> >
>=20
> Why can't it be detected runtime ? How do you handle single binary if you
> make this compile time option ?
[Rajan] There is PMU register which indicates if firmware is present or not=
, but in case of single arch QEMU that register will not be available so  t=
here is no way to detect if firmware is present or not from Linux.
Linux firmware crashes while arm_smccc_smc() call for firmware, but before =
this call there is no way  to identify if firmware is present or not. So we=
 are just giving user an option if they want to use it on single arch
Platform they can disable firmware driver.

Thanks,
Rajan
> --
> Regards,
> Sudeep
