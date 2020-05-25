Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CA7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09D4B2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 16:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QQ/0TNF7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391218AbgEYQN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 12:13:27 -0400
Received: from mail-vi1eur05on2089.outbound.protection.outlook.com ([40.107.21.89]:32629
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgEYQN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 12:13:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lnbmfMbKIQkt3wyo7ci9ZjiwjHTToepg9lsHsOf2BvLF20OXTnlMG6xgBqQk7Lmrhb8o7ShiG7xIdI8XduVHoXf/ecEnCPH0zk1rKr0A2XbLeua7b7ipLDZdsMC5jhZgxe7wM90rtgsTgmYZHwELpi0Lxq9+rY/cjw/Mo0htychXPkB9RikOs79jdxrW/aSiQxyRD5rHi/w2D0UYfs6R6Cfcr3ThXM/azCf5Aba+zoQyRXSqq4J/9op7WbxzL0eM4kgneEIQz4xl5wzPrf0v7Vlg2QN9qrRrInh5xKO3XmHp1K8fknP8LU8MoCij/Om7bRwCHfEhgEJ3LfWyj1EJGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPE5lv7iN+KdVXL1brHNVuBc0EaTDk+4SCbJJ1uww7c=;
 b=LuC8e8HIac6cTQPeeWKmcg+yKt7b0WtVbzhyLC8SIGtGnDJRvSIT9WvPMRH0cablp3+JfT4n79oHe4DpSyQ/7xwSOFCekfC03YIM/mZELtqh9ST/RROHEoTaEGJ+UF5jM0d72kxD6hK54443VQQGTbTFYXM91eh9ymqa3GbR7cervvfJ2Jvv2B7g+9TyGL67sYheg9Dx7oVbntZWFIf+//+20SwFwWXMJclDe/b2mFow0kTYXC0W3hWv7vofndCL/+7k5dHJf9Uk5QEbVTQicziv2gpb/v9wp37phvrQjKmtUlJ9mGrOe5p+2eAzsoLyBdNtKoxjkeg3h65FDDF5qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPE5lv7iN+KdVXL1brHNVuBc0EaTDk+4SCbJJ1uww7c=;
 b=QQ/0TNF7x0E+hXohsx3LUyZW1/06LnP/ZXVu+XhsQl8v6wHVCn/3SOPZQ6xtEfQBONQH+v+Nm95UDX2WttuZ7A/CLCbDWLt+O4AGyYo070DhPVlnJ4u9fKSvrUCoDlpFiSivS5gMIxnZCK1SuHGfenw9UP394OSSYKqMlYVQAfc=
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 (2603:10a6:803:16::14) by VI1PR0402MB2717.eurprd04.prod.outlook.com
 (2603:10a6:800:b4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.26; Mon, 25 May
 2020 16:13:23 +0000
Received: from VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::e5d7:ec32:1cfe:71f0]) by VI1PR0402MB3871.eurprd04.prod.outlook.com
 ([fe80::e5d7:ec32:1cfe:71f0%7]) with mapi id 15.20.3021.029; Mon, 25 May 2020
 16:13:23 +0000
From:   Ioana Ciornei <ioana.ciornei@nxp.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] bus: fsl-mc: allocate resources when there is no scan in
 progress
Thread-Topic: [PATCH] bus: fsl-mc: allocate resources when there is no scan in
 progress
Thread-Index: AQHWL4qbnqBdRkT9Ok61D+CKMTFygKi4/0vw
Date:   Mon, 25 May 2020 16:13:23 +0000
Message-ID: <VI1PR0402MB3871B6D74FF14A355C6B7AC1E0B30@VI1PR0402MB3871.eurprd04.prod.outlook.com>
References: <20200521161203.10989-1-ioana.ciornei@nxp.com>
In-Reply-To: <20200521161203.10989-1-ioana.ciornei@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linuxfoundation.org; dkim=none (message not signed)
 header.d=none;linuxfoundation.org; dmarc=none action=none
 header.from=nxp.com;
x-originating-ip: [188.25.147.193]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9cb15201-e4ca-49c2-4ce9-08d800c68c67
x-ms-traffictypediagnostic: VI1PR0402MB2717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB2717C1B614C178EE31585BBAE0B30@VI1PR0402MB2717.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0414DF926F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gtlXzOGhmwW18K4i+/DM1RbIJLL7KCWqaW06XZpQMyElSIZlgEAZPqUo4jjsYoBvu+KethDoF+MchoiLqYTNBJ7E5O0sbKGefs5Abn9aqqYdS3LKomD1hFEGkV7t3wvAvV91XsQgSlZb17kz8hC7ZabhNupfq0+6Fc5ZHuaGLj47p9EkiP5zni6DFddy/jgg55ew6aLuU1neZELknPl2GcoFzfPrzucFYP6ofGY7jKEXhhYubSkosAu6eiIzduyEMxmfuQMWI/VNwVcWq6A1Sc+tHuek7pDNH5sJ93m7AyiSCSVl0fisPOLdiyoJFlxrfPjDg+rMc9HNBN8U9+wOHw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3871.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(4326008)(5660300002)(7696005)(2906002)(26005)(76116006)(64756008)(6506007)(66446008)(66476007)(110136005)(66946007)(316002)(66556008)(478600001)(186003)(71200400001)(8936002)(33656002)(44832011)(9686003)(86362001)(8676002)(6636002)(55016002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: e1J6aSq312dqaPIGc1rid2RRrAWdBWDWC16Lb/vPVYuIKP5btzt931MWdopvSkbsUcD0VaKjLIJmXorfyYh8gvDjHlEpBuukeOUlfd2UDSWmv8USstfY2ZvmCM/FNecR8mmHQbScsSah7oKFuo+d+m5oxLEmoLaIcrcZda4DEfE0g6PeCrZc6SrIG0sxCI3SVGlnWOB6odcpqbuiaHDj4KVM83rxsAwPzevsOd4W9urutBg11uBYNuPpAhBSsSUXX0jf56lVraI/E/C6sIixZ6mbyfXRWNqTYQ7EcI+wL22iYQlXlIneCtPRq9QJMSY657XzbTLhktAwfzicZ8Y23Mgu2XOxQqeyIIjWDnwWy+3a5piJKGFccfVSKRCraBwakw7KHcymfuxh5+xxmApducu7nQ1LNFIQvMj5ty9cOTjqZt4K9KvYL07g0miXdWhf88mCASja6Q/3dHkhktnjUGoXhkiU8i+I4vh86L8WT48BMpaXxjZFs9AWs8KsKoMQ
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb15201-e4ca-49c2-4ce9-08d800c68c67
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2020 16:13:23.0800
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jeQi4zuvma5BPAbC4Elxn6uKrqmpnElP9Smht6yv7dGNw/JaPNKerVhSNv9nUXddP5LWFFu1ffuO3gkI2KLc3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB2717
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH] bus: fsl-mc: allocate resources when there is no scan in
> progress
>=20
> Allocate resources from the fsl-mc bus only when a scan of the bus is not
> happening. This is useful when functional devices on the bus, such as DPN=
I,
> DPSW etc, request some kind of allocatable object but the scan of the bus=
 is still
> in progress, thus those resources are not yet available. Catch this early=
 and
> notify the upper layer driver of the condition.
>=20
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> ---

Please don't apply this.
I just discovered a corner case in which this approach does not work.

Sorry for the bother,
Ioana

>  drivers/bus/fsl-mc/fsl-mc-allocator.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bus/fsl-mc/fsl-mc-allocator.c b/drivers/bus/fsl-mc/f=
sl-mc-
> allocator.c
> index cc7bb900f524..794ddc9589dc 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-allocator.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-allocator.c
> @@ -184,6 +184,9 @@ int __must_check fsl_mc_resource_allocate(struct
> fsl_mc_bus *mc_bus,
>  	BUILD_BUG_ON(ARRAY_SIZE(fsl_mc_pool_type_strings) !=3D
>  		     FSL_MC_NUM_POOL_TYPES);
>=20
> +	if (!mutex_trylock(&mc_bus->scan_mutex))
> +		return -ENXIO;
> +
>  	*new_resource =3D NULL;
>  	if (pool_type < 0 || pool_type >=3D FSL_MC_NUM_POOL_TYPES)
>  		goto out;
> @@ -197,7 +200,7 @@ int __must_check fsl_mc_resource_allocate(struct
> fsl_mc_bus *mc_bus,
>  					    struct fsl_mc_resource, node);
>=20
>  	if (!resource) {
> -		error =3D -ENXIO;
> +		error =3D -ENOMEM;
>  		dev_err(&mc_bus_dev->dev,
>  			"No more resources of type %s left\n",
>  			fsl_mc_pool_type_strings[pool_type]);
> @@ -220,6 +223,7 @@ int __must_check fsl_mc_resource_allocate(struct
> fsl_mc_bus *mc_bus,
>  	mutex_unlock(&res_pool->mutex);
>  	*new_resource =3D resource;
>  out:
> +	mutex_unlock(&mc_bus->scan_mutex);
>  	return error;
>  }
>  EXPORT_SYMBOL_GPL(fsl_mc_resource_allocate);
> --
> 2.17.1

