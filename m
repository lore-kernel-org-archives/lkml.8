Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D229FC41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:01:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E3720870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TbEcdvF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbgCXMBX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:01:23 -0400
Received: from mail-dm6nam12on2046.outbound.protection.outlook.com ([40.107.243.46]:16480
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727368AbgCXMBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:01:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C7fcElUoLQ37Xsx/FTz5YV52DR3JO9Ynbt+UM2+UxA0gjOFXQFczYlGehGpXwGSyiOuXlydR/rXBtUClrkV/h4bMf5oGFl+VxetCuxShqnub7dY5TOMNiAn1ca9hRBCVlG5K87FmPB77vJNhXmlZSAkHI4DxxdnuPXtAraPiYoxDzrIAUaRm7wELIrCvKkeCs14qSHtLSplWiaCfs4eTY7qua/KvHDACzYHDbr0YbPreZbLEUMaHh8Lj4xHJsE4klCmun0cJCbD77SwSuZvcxpbgRHipzryo6dsLCL1mofGpIa6rqRiKCKzYhJceusolGeDg3jEDPiQdPe9nWYdOqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KbYw4utvTWBu8wKEg/C4G5uFwD+1N19k/szKyG3sX8=;
 b=VvtsRvqYxjU2VAI5Ft5Yo1AhEWmPhQw3ZHx2ok/7J40itn/oXLMy87bXNow3TiZ1RAJWazH9nNfHhOfrsoAvZZqUgttCcAu8LCT/If412RSzG4tTw1P3dY/u9A9K/uOiH6TmfPvi/gWnK2C3o1QvqFXVYuwrNr114KNbApxYuUmMkFy0Of3RxgIyE6ELV4OGqkNqJOGaI/JA+JcGfqqTQzPc9L4AOx0OgAU0mNEMv0Q3ejrPlhE9vTKl31H9+Z8sdDvLn2ZO+4YpmK+HmsiY7A661hVR62e2aDfKAVPbAdc6o5cnCda9T2z+Db7PDhFocdAgOkgQ8XD1e3/bQU/EMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KbYw4utvTWBu8wKEg/C4G5uFwD+1N19k/szKyG3sX8=;
 b=TbEcdvF0cqPbT6WLrPoixK3Tt7/WautKPDbic/7evzRlqmFRjXq3zuQod4mIwqapqVpwVIQ26f09/ZbULvB9DjWHUC/wWyZdotr6vTjJ+gor5EhEGmLCneKaI7R8z4Gd5CIIPLzdR/h9cHWKS0ENd3w1aqQ4hmXxlIw1o+qglBE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2586.namprd12.prod.outlook.com (2603:10b6:907:11::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Tue, 24 Mar
 2020 12:01:18 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 12:01:18 +0000
Date:   Tue, 24 Mar 2020 08:01:11 -0400
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com
Subject: Re: [PATCH v3] drm: Align a comment block
Message-ID: <20200324120111.554eniw3aw6nqne4@outlook.office365.com>
References: <20200319210600.1170-1-igormtorrente@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="updchwr65wpkdjjh"
Content-Disposition: inline
In-Reply-To: <20200319210600.1170-1-igormtorrente@gmail.com>
X-ClientProxiedBy: BN7PR02CA0022.namprd02.prod.outlook.com
 (2603:10b6:408:20::35) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (2607:fea8:56a0:11a1::4) by BN7PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:20::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Tue, 24 Mar 2020 12:01:16 +0000
X-Originating-IP: [2607:fea8:56a0:11a1::4]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 78e92b8b-0970-4a9e-bdd0-08d7cfeb0f5b
X-MS-TrafficTypeDiagnostic: MW2PR12MB2586:
X-Microsoft-Antispam-PRVS: <MW2PR12MB258618EF42949B0859C8B31C98F10@MW2PR12MB2586.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(39860400002)(376002)(346002)(366004)(136003)(6916009)(66946007)(44144004)(2906002)(66556008)(66476007)(186003)(316002)(6506007)(5660300002)(16526019)(86362001)(55016002)(52116002)(81156014)(81166006)(7696005)(966005)(9686003)(1076003)(8676002)(478600001)(4326008)(21480400003)(7416002)(6666004)(8936002)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2586;H:MW2PR12MB2524.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIdJiaedlcR1VxrZjYxTatYW9MiAFx+lUwzZ+GZAa1rcCOHu/sW6jIrrj/tExIGabrxioqa9cZOzqeWSEcqaqJN+MmL5HHSA3l2RLsuAKAqT4w3uQbahCwa15urHkDaECLnh6oc7T0uTCFWRDkU+pfBPpzOT/drNCzr6yu3ZMYw5IPGh4MmP65v3MAM0+n/K6FTxgoiEIHQ+Cm5lDy0yMUGJ5jyp6oNX/xdZJjEJ6pnDczzLe0zxj9bI0KHH5T5enwJ02WH+mFcvvSI0rw19fWpTkAP0l5Ww4DUHkxJ1CjhapVqeQN5ypY+3MJ45k8zV21Y9WqE8s+zcX9QHSSd5V/WdPHOY45qfut/LbeOMFiiBJMwR7U4m5MOxjbVvNroxPONXG/qCL/spCSjSxmF9lGLBYvMqQUpgSrxdLl19neKyq1QahMV5WjfR4KuDcfBWNCHlduQ6RYKsR0u3vGqhRcrP2poHmG8gMO6WgeC/eq/U/Kr4+MeOBKhI8w5qnu5NDDBtbo7FmPjhJBdnj3VgD/cFhmFxRw9yohvBJ/YgSLnGL+uUG0HsCl7Mu/9w0xp6
X-MS-Exchange-AntiSpam-MessageData: xF02zGJAQ2x0suqh/XwQeX2uUTHdMTgvxtxKMooNdMUDvz0wZDmrYQlnj6A8mGE6dd8eAKzrAjwSaOO3W8lbMqoZv/VRWBfadvTFHtJvjtArgVSqqH0tyH9VEAc3qSF+Otz0iveIBfSuzhzJiIajHwxJxNy4lR8KfacHNXqv0YI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e92b8b-0970-4a9e-bdd0-08d7cfeb0f5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 12:01:18.0258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nkb1g1lBXgYlpYEjvLgSE2Ylfd7TwIKLQKmMoj3QGWTrG9CDDqg3jejXAJ3pHiSTLwJSFFyh6YwZVA5PpY8yAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2586
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--updchwr65wpkdjjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 03/19, Igor Matheus Andrade Torrente wrote:
> Fix a checkpatch warning caused by a misaligned comment block.
>=20
> Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
>=20
> ---
> Changes in v2:
> - Change subject text
>=20
> Changes in V3
> - Fix a typo in the commit message
>=20
> drivers/gpu/drm/drm_gem.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
> index a9e4a610445a..564acc1f4030 100644
> --- a/drivers/gpu/drm/drm_gem.c
> +++ b/drivers/gpu/drm/drm_gem.c
> @@ -222,10 +222,10 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_o=
bject *obj)
>  		return;
> =20
>  	/*
> -	* Must bump handle count first as this may be the last
> -	* ref, in which case the object would disappear before we
> -	* checked for a name
> -	*/
> +	 * Must bump handle count first as this may be the last
> +	 * ref, in which case the object would disappear before we
> +	 * checked for a name
> +	 */
> =20
>  	mutex_lock(&dev->object_name_lock);
>  	if (--obj->handle_count =3D=3D 0) {
> --=20
> 2.20.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--updchwr65wpkdjjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl559ocACgkQWJzP/com
vP8CyRAAwdDgMWKmXCGRlRu4C5O1r5QqJmi+t1oMezdD+WUFgRDZErMbME/gZxBI
wRvlAjMKCWfVIOsdaSWffXVnsownXCfPws/EptVuQI8VQ7KkmakshGB3mqBk0s8W
VfrsOkgs238GXdAEwGAR4pFvd6VbotFAr7ucyNKuwOub/0Gvo2bFqIAvE7AFO9bF
a76zVO+XXz3HkjrTwXccYnfTTWqPug9+teUW41z9HRbBaq9FcRHNRKYZAtXl/nsd
zg85jT7vl8P1TOjxmvKx5kdB1kAO483XIxR+zyDgTOo1r9UUr4ZWa8PhaKTIV3gt
x9OeLT0PGHsvglcMEe2dCfJJahOflDWke45hDm1XUpNMFZYBhE1Fv++/enI9F+SB
Tx6JlgjmzllMBpmt8A9KSFe6ybEIrXVBOQzHfwsJxaOzPkP4HUr86UA4P3sfdDYz
zgtQvR0Gd4Pn0Pl+qGstrJI7TicqXu9T2rX7LYjwbKd52KBOMVgtx/ld4CiMf0IJ
3ydy5I1yD+AaWX59s74njYxfhM5iJNo6bSGmgGst8/zIpPIhNK53GCJTUa8hWi7N
4BHA/uFmAoCwMZwLfG8OV0EluwsOEGEOmJd5epuSu+rQGqTYNsRHJu5lNla71Dgl
d4RsU5iN6+DWwOk/2xaiZGsCfd9xZG5ZFx77VVU5X8g4kzPqfQA=
=HK4I
-----END PGP SIGNATURE-----

--updchwr65wpkdjjh--
