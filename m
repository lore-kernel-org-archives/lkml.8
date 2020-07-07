Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B6CC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB69D20758
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 06:20:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rAn6QrlK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgGGGUE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 02:20:04 -0400
Received: from mail-eopbgr80080.outbound.protection.outlook.com ([40.107.8.80]:11635
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726540AbgGGGUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 02:20:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HdB22qNlmH4O2o6wmxdtBYB90HBFX4iUExHDj/LM+pcpcLsGS22qUVDUui89RdZIVO7xC/V3YwNxFyaHBqWrPEx22gV7uK/C2W2+JTAzZdFRrBs06egj8+70+MzBj8DSjpGDpfw5POWbaCZhvXihDZHOdG8TMOMVam4w2fweTDu8gVx1oHn2P8ACYwelcG3VuYsXjYWUlt5k/aUwAGrHz5dYge0C2hXAJ0/H7QH17+v00LTflnMechxir0Nf7a4wBINyZKgwAr2YJNDa/q7dZn8mxcKb1Sfi00ZuPOrZPZ4knux1LquK+O/cRiWLKN3Z53hd+Re62GNbUizGeGF2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh2t4FTPtk8NztFzvYyvZrvNWKaREeC+MAG9mxlHo9g=;
 b=b7vCs8IA8oAjY/8SQQ7qhUaSornQzMllKe1Q7womDlJQLa5zdXravelLoUsKQ66bXK+ClDQOUwkeDYC0CZ0q8yNre4CEsr7IoTApSmhXEGWvfwdWrOVU4l21RQP8J5zOj/AvNeVASmVq5Ay93KjmuHZyVKXMbaWHvnvgK77ITxtXQm0KVNAhjT6IVQYixJ6XtYe9sa4CdvvbD2pkiV7nhSOEW/v8+Ct72FU9gBFSG7M6Xxl537u7PhgLmYLIdMeUQg91kx5BEVBM74NV50unogDH34iwZ4Et8nhzfy2idzMKi5ExCffY2X/LS38BuowiDuM0Nmzt5mDzfG93JYoQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh2t4FTPtk8NztFzvYyvZrvNWKaREeC+MAG9mxlHo9g=;
 b=rAn6QrlKipbJcpMgAbYCBmBn2KsaPMbjLHmll4WAHC/KnbC3SkE02lytRXiNG+ywo7vtMsHNfNAhgSI/v+Pp26ZRXTGzBD5Zief7yGLPoxEwpI5QDqwmXcHlM3KfILLWeiqFJlvYGAaZe6mPwRARg7AMcUtnVpz+OQMDbH4Q4oI=
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com (2603:10a6:20b:118::20)
 by AM6PR04MB6280.eurprd04.prod.outlook.com (2603:10a6:20b:71::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.28; Tue, 7 Jul
 2020 06:20:00 +0000
Received: from AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a]) by AM7PR04MB7157.eurprd04.prod.outlook.com
 ([fe80::1101:adaa:ee89:af2a%3]) with mapi id 15.20.3153.029; Tue, 7 Jul 2020
 06:20:00 +0000
From:   Peter Chen <peter.chen@nxp.com>
To:     Pawel Laszczak <pawell@cadence.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "colin.king@canonical.com" <colin.king@canonical.com>,
        "jpawar@cadence.com" <jpawar@cadence.com>,
        "ben.dooks@codethink.co.uk" <ben.dooks@codethink.co.uk>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "sparmar@cadence.com" <sparmar@cadence.com>
Subject: Re: [PATCH 1/9] usb: cdns3: Improvement: removed
 cdns3_get_current_role_driver function.
Thread-Topic: [PATCH 1/9] usb: cdns3: Improvement: removed
 cdns3_get_current_role_driver function.
Thread-Index: AQHWT3AWQFugyHyfQkS1wLAPetiZuqj7rnOA
Date:   Tue, 7 Jul 2020 06:20:00 +0000
Message-ID: <20200707062009.GB16073@b29397-desktop>
References: <20200701062004.29908-1-pawell@cadence.com>
 <20200701062004.29908-2-pawell@cadence.com>
In-Reply-To: <20200701062004.29908-2-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cadence.com; dkim=none (message not signed)
 header.d=none;cadence.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fc8d6465-2155-4184-fe6c-08d8223dc737
x-ms-traffictypediagnostic: AM6PR04MB6280:
x-microsoft-antispam-prvs: <AM6PR04MB62805B619618662E8DC723F08B660@AM6PR04MB6280.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0457F11EAF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: krdAAQEkPN/n6ca89PM3jvsF6PjkBlKNedkg5IQ/l8qgXMtw3zaaOc7HZYdJz94QUvA3/NxD4hOMOjWk4nSFo9iakMDRo+ClFXPLlKwW3uhR9eCtPI0Oq+DEsowUJXTKCJdCXu8WKa18+y1CWllzrgxxQcrSCAP+ktY1rM8sdtuQVqRXNw7gLH4doK+P1TSCIPmjwmWbzN2CVb4VVwgGijGRORIM7JuDWb3qjw0WlXmOOhjE7+6omoKmrPlsq3WvpaooC+ttU4xwQPoY9eNrM/UrxGGlKUJWW4z3xPV5jjYqAbO2argqIYZ5Mtq4x52pHxwQGirNYPU0C9kSnEqMBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7157.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(7916004)(4636009)(39860400002)(136003)(366004)(346002)(396003)(376002)(71200400001)(8936002)(186003)(478600001)(91956017)(66946007)(76116006)(66446008)(64756008)(66476007)(26005)(4326008)(66556008)(53546011)(6506007)(33716001)(86362001)(7416002)(6916009)(1076003)(316002)(6512007)(44832011)(4744005)(9686003)(54906003)(2906002)(5660300002)(83380400001)(6486002)(8676002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: jca+9w2hllAZwygFIyz871rjSiUaItF8zb5gHqE+q3bGrkpL+aoqeBqCp7fjbN/5FcOINwBqs2X3CMgFMo67e/LutzgLqR6pdgiIc5gNW2UwbEHqnGtG+F+GxP6JgiaJMpX0btoSKimqlZHJ/05UOmaV+alBXBigIGws7Tc+diaXdM5A0wniHi+CLWJE6Aan7T1w6znYKsw2EOAE5JsUDyt84pH07grSCNoiuZZHJegul3ftzPyCd4GQutkch2zm35STUm1pEYeAWQatebyE6hXFrlWObUvkLesuSK5x4kaKTveN2tl2botHjZ7m55L/Cacn0ksBI3c0AUWCRYaclFpCy3QNLMFHjXvhAe87TqJ2L/QNMq4Lb4l8jkjfmZH8PgxDU2tfPVFDYSTdMLxscXi8rFP0VuM+OOXItTUtL/dMyt+CL1QYLnzQLK1XTPTi2Bk14d329WpzsnvvIedCbb6O+ubLCqu0gng+r7gv2esuquq+HzVj0dYy74qmBsXH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <599417C8E315CF4BBD06B0FB4589D64F@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7157.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8d6465-2155-4184-fe6c-08d8223dc737
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2020 06:20:00.2126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pzrYOxsk3iQK1wzZHCCoG2CslLMBj/uBBONlQaVvTmskt8IqFQyGkVV1xl0kLHb0SrQeZB/ca7DiKcDv0TEl6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6280
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:19:56, Pawel Laszczak wrote:
> Function is not used in driver so it can be removed.
>=20
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/cdns3/core.c | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> index 19bbb5b7e6b6..eaafa6bd2a50 100644
> --- a/drivers/usb/cdns3/core.c
> +++ b/drivers/usb/cdns3/core.c
> @@ -27,13 +27,6 @@
> =20
>  static int cdns3_idle_init(struct cdns3 *cdns);
> =20
> -static inline
> -struct cdns3_role_driver *cdns3_get_current_role_driver(struct cdns3 *cd=
ns)
> -{
> -	WARN_ON(!cdns->roles[cdns->role]);
> -	return cdns->roles[cdns->role];
> -}
> -

Change the title for the patch, otherwise:
Reviewed-by: Peter Chen <peter.chen@nxp.com>

--=20

Thanks,
Peter Chen=
