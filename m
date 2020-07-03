Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0032C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 709A520747
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 01:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PnGbExz/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgGCB4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 21:56:34 -0400
Received: from mail-eopbgr00062.outbound.protection.outlook.com ([40.107.0.62]:3460
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726072AbgGCB4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 21:56:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irkQDxgW4vcP6f3OCLpNpWAutl3/wxOFmowoCPO6jcSinPAH+A/HOdQJxprnjHdkfDAKwPvI9/fl6Vy+nuioeUumE1Yn01GRHhpksmECQ0pKhN5HGqVQRgH4L+pGfjWZYTgNsqEPGeZDL24CZa9p6009L+PxJGRa6AMSHYZBQHjbDF/ne+CXCvuURvEHermOIvnOZH7xpA0NEZp9vmVAI3C9mEpAfZU53RkRMyXliGqdqAUlK41QfF0iwDD0oVf9BD//dPSAdrZY+NvKC122W5LL1NN4PtVbPCBkEGBHuK+wHEpJghHjX3fgDY4G66j6Ai0HUVcS8Axb3mw7bTDiWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqIJgK1b48g2hxQit/Cv+7K97/fWKRaiKWlP/Gya0OE=;
 b=Ur/km4BaSS0ADjUUroqGsVemz+AzCmgp3flV3rtLz1/uryoxXOOryC5pOOb+NO/9501eIVDH/KfGtQYqtiVvwsCBAWtZkMsMizcgfpls6uqVjlnedTBveoY+fE7ihdNIsW6artLXjgzG1QEz/hMjdFIeIn/frXoF0pIITcrKZ0b2Bub0UCEZ4LDWd709HV7CKOPrRgm8fB4yyBrB26qUZM5DZxnObx2D44FuFXinZNg425Ol4x6eqPVvw1o1bqGZSwUzxUmaLIKEY4U/HIPBY+ifX0rsVbzLPOr8Ya2RS0opQQVJGouKvdIIJq9+ClDiDmwE1MMS/6kZ0Ik86w+mZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HqIJgK1b48g2hxQit/Cv+7K97/fWKRaiKWlP/Gya0OE=;
 b=PnGbExz/LAKBlovIxkLge5Y/TDR8KblGLbBbUJW6lgnP08kpUHs6vBYH/F0G3KHan06moqLZwstnlGiShXrBr5io6cmxxyQZ0CcklJv7+07uFraPjMtqpkYBo1tch30k07Xh6h4c6T3SxKVjdbeFbC+Auwa/1cnsEgSP9zOnBJU=
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com (2603:10a6:20b:96::28)
 by AM6PR04MB4968.eurprd04.prod.outlook.com (2603:10a6:20b:7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Fri, 3 Jul
 2020 01:56:28 +0000
Received: from AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::18e:f4c7:5a46:90e3]) by AM6PR04MB5413.eurprd04.prod.outlook.com
 ([fe80::18e:f4c7:5a46:90e3%5]) with mapi id 15.20.3153.028; Fri, 3 Jul 2020
 01:56:28 +0000
From:   Ran Wang <ran.wang_1@nxp.com>
To:     Peter Chen <peter.chen@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>, Leo Li <leoyang.li@nxp.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] USB: phy: fsl-usb: remove character device usage
Thread-Topic: [PATCH 2/2] USB: phy: fsl-usb: remove character device usage
Thread-Index: AQHWUEKFal2ogPleHEuySxXSCK02R6jz//eAgAEX8OA=
Date:   Fri, 3 Jul 2020 01:56:28 +0000
Message-ID: <AM6PR04MB54133D6402EE1FDC7E44CB32F16A0@AM6PR04MB5413.eurprd04.prod.outlook.com>
References: <20200702072914.1072878-1-gregkh@linuxfoundation.org>
 <20200702072914.1072878-2-gregkh@linuxfoundation.org>
 <AM7PR04MB71575977E680A7F6405D8B3F8B6D0@AM7PR04MB7157.eurprd04.prod.outlook.com>
In-Reply-To: <AM7PR04MB71575977E680A7F6405D8B3F8B6D0@AM7PR04MB7157.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 62e3f1c2-0b05-4cfa-bc70-08d81ef44cd8
x-ms-traffictypediagnostic: AM6PR04MB4968:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR04MB4968355C69E1738BB0FD3E1DF16A0@AM6PR04MB4968.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1SYjtgSVn+GceIdxXa2ol12BhnYn/y8PEpE93L/5n8HEIY7zdKfz9CB6Is2e6r5cWS56EarCfbuPL1DIQX85oW8gPyrgH1GHz7JOx7apbVt+C7fjbif0lv3G8bepnjouHeR48AGwGNtqyanYrlE072zXHJewG+yMpqm/PmrQumgld5HjsjPGhO3TvcFODQGBJeX+YV92lFQMNJqFBHX72SbUIhhQLO+729CIWXjXPZgrhtqaJDqWfCXkVA2nYgvCMvC0/zNLJnXp1OHKUNmNhxFEYPPePzYgrFmzn4M7jKO2rSotStcGVpCXau2sk68z0YKqRyNgamdAobugYm7c8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5413.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(376002)(39860400002)(346002)(136003)(66476007)(9686003)(76116006)(66446008)(64756008)(66946007)(66556008)(7696005)(8936002)(54906003)(110136005)(186003)(55016002)(33656002)(4326008)(71200400001)(26005)(2906002)(6636002)(8676002)(52536014)(478600001)(5660300002)(86362001)(6506007)(316002)(4744005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Q2rv2f+hHy6nhwfG12HaQQI1Kz4BMeA3VhELRmXHEFOJZTsrBpeqtfFnzRUUoAB/CmOPK28Nux+ZtBDzFaNoMlfbiMVLcMo7XwEL6OnNuhkDU4Ko/AfXRcEoI4JCRhpl+GsUSgycEAbKNm5bF3a1N+rXg0GE2R5BHtFwAy2A3YWZoL7gDXfRQveO0VQRyAEQ3J1ToRm5tEKyiM18duHPvjnaR+d0ORCiRnFDLji81u9WkXAC9lcgZny7eaKy5Ix3ortF/8OH17aemVpYqpq3nEQO3hf0VEOVQWqADqRqNqD23aXIJRi/UelClT+7oPRxNf0B863fMg+aPDGQesFS5ztjcAR/bsicKnogKkZf18HsMkLrZ/03mXmF3SDrCvK1ARhCl5z7Q4xW9Xgm8TfMjHrPYo/ESvGRlHMjBSp5zYmgDTLDBtkOh3W/h9GCcOBKVHx0D5WaOivC717209HAhUwopnpjSbHQmmdKGCW96oA=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5413.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62e3f1c2-0b05-4cfa-bc70-08d81ef44cd8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 01:56:28.1811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIzd/4xM5F69Fi7hfRa7c9/oXAdrhTYjN2MAYfP/9nlJ/KGGSZoxvR+du+UzehwanAiot8qwagnD1IgIvtfR8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4968
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thursday, July 2, 2020 5:08 PM, Peter Chen wrote
> >
> > No idea why this driver is using a char device node, statically
> > allocated, with no dynamic allocation or hook up with devtmpfs, along
> > with a reserverd major number, for "special" operations, not all of whi=
ch ever
> were implemented.
> >
> > So just rip it out, as no one must be using it because no modern
> > system will ever actually create the /dev/ node it needs.
> >
>=20
> Add related people from NXP.
>=20

Reviewed-by: Ran Wang <ran.wang_1@nxp.com>

Regards,
Ran

<snip>

