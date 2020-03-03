Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563BFC3F2D8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27856206D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BX6d6Ono"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbgCCTAS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:00:18 -0500
Received: from mail-mw2nam12on2048.outbound.protection.outlook.com ([40.107.244.48]:6209
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728783AbgCCTAR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:00:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc2CnPX/zYQ75ke03aqYZw0qdowsaL6OoYwbZ/CcchrG/Aj8Puc0M8QO03duBWpEU+m/Pa0uNk/7DGh4XxIxDyUAdVUDoO0JmOV0eG2D75RqfCcKdJ3bG0LWwiP10Ap3qvSf4vyjaT3kg24hyvumjfrsTIaqOsLWGkYW8keY8S4WfigVUWInYLkCqZ1fMPHRgBHOuADGx7i7J7W5Cab+i/fgvtVqeFRX+jZCZTBVLu+0+78uewR9qW7F/sCUB9KVgzmX60WqXxNL7aMhDAMycXsMAbaczpNGyxYngeI0Mc/UhffQtsQMx5Bpe3OcL71fJL2tj/jE2fqgBTiLJZUNDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URi10fF/rcegQ41R1fYtjcGnB3OyjomHL6w1MTCs/L0=;
 b=GBjVjQOLIkNtX+S0v9jkHKX8LhVKQjhMyD5v2dL+8+q3qPJ4NcSkE8jBhvEaf9rIpo0e0LxANBSGFBSmDmL+wm+kjofpnKIc8NDOJPUCU96YJ06jb67WYBVL58PLhoOuud2T0rfJ2d0l/o1or/LjMl7S4PCoOWxyALFXqAP20HAtRupd3VXdEruaUI+Y9TUK7lfHfCr0mBv1MeIZhqDtA4sMh5l+eX+EIeaq4YzD0+AciYbmaUPSl31aG1rl82YaFVaz9McG0li7sfvUbAKL7X3UcC0paR6xDfvYyWRF/Z1XOpK5JSDpbN3msZK8qQLWzNPVnL29cW7yXQiP1OrptA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=URi10fF/rcegQ41R1fYtjcGnB3OyjomHL6w1MTCs/L0=;
 b=BX6d6Onou15WOh+0m6yS4tjoG2ZHnatbH6hKJeTP5ENW1suhsa0i2HZO3fU+7PsclMMDRum/TBvDd4AgZ/bZ22WmyImP7s4z3UmIEHFrLfk03ZpqAA77SGsjciTe51bjwz+6TSAEoJz0Q3NckzW//u5iSnheq93H0enQHmHbEGY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2491.namprd12.prod.outlook.com (2603:10b6:907:f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.14; Tue, 3 Mar
 2020 19:00:13 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Tue, 3 Mar 2020
 19:00:13 +0000
Date:   Tue, 3 Mar 2020 14:00:09 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: dcn20: remove an unused function
Message-ID: <20200303190009.sqrll3a2npgjayfl@outlook.office365.com>
References: <20200302214029.zxakr6il6f52yixb@smtp.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3twdewe4gx42kppc"
Content-Disposition: inline
In-Reply-To: <20200302214029.zxakr6il6f52yixb@smtp.gmail.com>
X-ClientProxiedBy: YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::42) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (165.204.55.250) by YTOPR0101CA0065.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19 via Frontend Transport; Tue, 3 Mar 2020 19:00:12 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3114e3b-59cb-44dd-e2ef-08d7bfa51a88
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2491CFCB77F4516B8C22351C98E40@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03319F6FEF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(136003)(396003)(366004)(346002)(376002)(39860400002)(189003)(199004)(21480400003)(6666004)(4326008)(55016002)(9686003)(8676002)(86362001)(81156014)(81166006)(8936002)(966005)(6916009)(478600001)(66476007)(66946007)(316002)(66556008)(1076003)(26005)(16526019)(54906003)(6506007)(2906002)(186003)(956004)(7696005)(5660300002)(52116002)(44144004)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2491;H:MW2PR12MB2524.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2xSXaxK+n6je5o663ZDW3BssfxmylZgUeDSumR/DSSByGAMcowVMAUY3RMmTcS7cEp50EO9uT9cFxNxkKPA6RMWp5szEmQKGpGj1W53qAZqAtjMDZv/hHorI+ZGz9AiB5l79fcbdSKX0jgnKIhJTSFoLrTStzJid9lDuMivABcAEj3u4+RptjToEMGnCRgf8cisC9279BkgwC+K2biiicsoE75+Dm0G61VJzWTkGycz+2FEPkUtYTAyiGc3nd9p+5spv3n7WXLmO4fEMAXALkj0Rp0+gHA8NEoTCH0lifsMQ8k+pHn9bOtqQTcZMGGu19i071PHckj3tD93qJrK7+3bVi+AU4PwoG4YhHNLwU9Jav/2JK43DRTORESv7qGId4m/xrXD2o3vB1Zk5hiwobIm+TevyPT5Ju7s2D1ZMO0+2hi8Lr/CIAY+vod7XRQ5IgRGHJfV10REbJ2FgV66qNh80EP7LJtMbluqrq4onKfNcdz/EABe+dup6SbUaE7Ghxyudb81XGEUivlYCHbd8TX63Py42KJwWKZvBmniyU/0yavMEjT4t69st24UU2T5yU3x3NF4GzdVmwLuM/cGlAgZ9xe1p9D+TZMGldI+NmzVaHDb6404wfpG/Qiaa6mBZDtb4VT2PzMw0tZI8KvW02A==
X-MS-Exchange-AntiSpam-MessageData: CibA7A87kGvr8Cd/uSE+mOwXa99AzDPi4h52iNqUSSflF1GkEuf4i89oiQGy9Eoll6NfI42+V3W9h/poyBGX9en3Sdc50tYdiPPapouwx05LTiCmio+SGWM2GlnkbN+igZeV/T25Evo0zrjHBwEoeA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3114e3b-59cb-44dd-e2ef-08d7bfa51a88
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2020 19:00:13.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq54Yz0A8Leil7+AfqN2IXXH+dd1M5T3tFu0WLaHM1KkBM5R2ULYzrTA5OzSXZzdDvCcW0oJBrmj3xjdStMUQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--3twdewe4gx42kppc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks for your patch, everything lgtm.

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

On 03/02, Melissa Wen wrote:
> The dpp2_get_optimal_number_of_taps function is never used. Removing just=
 for
> code cleaning up.
>=20
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  .../gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c  | 78 -------------------
>  1 file changed, 78 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c b/drivers/g=
pu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> index 13e057d7ee93..42bba7c9548b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dpp.c
> @@ -369,84 +369,6 @@ void dpp2_set_cursor_attributes(
>  	}
>  }
> =20
> -#define IDENTITY_RATIO(ratio) (dc_fixpt_u3d19(ratio) =3D=3D (1 << 19))
> -
> -bool dpp2_get_optimal_number_of_taps(
> -		struct dpp *dpp,
> -		struct scaler_data *scl_data,
> -		const struct scaling_taps *in_taps)
> -{
> -	/* Some ASICs does not support  FP16 scaling, so we reject modes requir=
e this*/
> -	if (scl_data->viewport.width  !=3D scl_data->h_active &&
> -		scl_data->viewport.height !=3D scl_data->v_active &&
> -		dpp->caps->dscl_data_proc_format =3D=3D DSCL_DATA_PRCESSING_FIXED_FORM=
AT &&
> -		scl_data->format =3D=3D PIXEL_FORMAT_FP16)
> -		return false;
> -
> -	if (scl_data->viewport.width > scl_data->h_active &&
> -		dpp->ctx->dc->debug.max_downscale_src_width !=3D 0 &&
> -		scl_data->viewport.width > dpp->ctx->dc->debug.max_downscale_src_width)
> -		return false;
> -
> -	/* TODO: add lb check */
> -
> -	/* No support for programming ratio of 8, drop to 7.99999.. */
> -	if (scl_data->ratios.horz.value =3D=3D (8ll << 32))
> -		scl_data->ratios.horz.value--;
> -	if (scl_data->ratios.vert.value =3D=3D (8ll << 32))
> -		scl_data->ratios.vert.value--;
> -	if (scl_data->ratios.horz_c.value =3D=3D (8ll << 32))
> -		scl_data->ratios.horz_c.value--;
> -	if (scl_data->ratios.vert_c.value =3D=3D (8ll << 32))
> -		scl_data->ratios.vert_c.value--;
> -
> -	/* Set default taps if none are provided */
> -	if (in_taps->h_taps =3D=3D 0) {
> -		if (dc_fixpt_ceil(scl_data->ratios.horz) > 4)
> -			scl_data->taps.h_taps =3D 8;
> -		else
> -			scl_data->taps.h_taps =3D 4;
> -	} else
> -		scl_data->taps.h_taps =3D in_taps->h_taps;
> -	if (in_taps->v_taps =3D=3D 0) {
> -		if (dc_fixpt_ceil(scl_data->ratios.vert) > 4)
> -			scl_data->taps.v_taps =3D 8;
> -		else
> -			scl_data->taps.v_taps =3D 4;
> -	} else
> -		scl_data->taps.v_taps =3D in_taps->v_taps;
> -	if (in_taps->v_taps_c =3D=3D 0) {
> -		if (dc_fixpt_ceil(scl_data->ratios.vert_c) > 4)
> -			scl_data->taps.v_taps_c =3D 4;
> -		else
> -			scl_data->taps.v_taps_c =3D 2;
> -	} else
> -		scl_data->taps.v_taps_c =3D in_taps->v_taps_c;
> -	if (in_taps->h_taps_c =3D=3D 0) {
> -		if (dc_fixpt_ceil(scl_data->ratios.horz_c) > 4)
> -			scl_data->taps.h_taps_c =3D 4;
> -		else
> -			scl_data->taps.h_taps_c =3D 2;
> -	} else if ((in_taps->h_taps_c % 2) !=3D 0 && in_taps->h_taps_c !=3D 1)
> -		/* Only 1 and even h_taps_c are supported by hw */
> -		scl_data->taps.h_taps_c =3D in_taps->h_taps_c - 1;
> -	else
> -		scl_data->taps.h_taps_c =3D in_taps->h_taps_c;
> -
> -	if (!dpp->ctx->dc->debug.always_scale) {
> -		if (IDENTITY_RATIO(scl_data->ratios.horz))
> -			scl_data->taps.h_taps =3D 1;
> -		if (IDENTITY_RATIO(scl_data->ratios.vert))
> -			scl_data->taps.v_taps =3D 1;
> -		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
> -			scl_data->taps.h_taps_c =3D 1;
> -		if (IDENTITY_RATIO(scl_data->ratios.vert_c))
> -			scl_data->taps.v_taps_c =3D 1;
> -	}
> -
> -	return true;
> -}
> -
>  void oppn20_dummy_program_regamma_pwl(
>  		struct dpp *dpp,
>  		const struct pwl_params *params,
> --=20
> 2.25.1
>=20

--=20
Rodrigo Siqueira
https://siqueira.tech

--3twdewe4gx42kppc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5eqTEACgkQWJzP/com
vP8M5BAAwKi8S/vvPBhHOWt6Eze2QS+XXneKaUD2e+JiKjgCQlYdyGhc5B5qfUuG
1Avu5jzFKEyhCF4BMQybYCwzQpbHAICSOyr68srM3Bli8BflfBa1sl6PL0DAdkO6
vSp+TTd99X1mMrrspRGzlignLPw8XJc/SD//gly7zX5+amEW9H2HKfW5mNQ5bwLL
9DsiVSodb5fefBm7Xcyio1ghY5fQeAXO1CM+UEeqdj7K9RH3fx/Xhk3/bQv4jmYF
Ux6Jpd0XSn88tIol67yVBqz9rceJBmKYRZwrhmOpa8kVl0FZtheeznkH016ZAeYK
wND27/XXflfxgDK/44qjP8cBfhKPI34MFqk+MZlOyWk79pZGimxIxV6n0u/Bf61e
XNwQRFpB32PgqX93Hf1ixZ3XayzQSo/Xc3bx0yHl+0S4SuaceXz3Jsjzj6Ahvioe
AiYYUUVVc5dJhaOyeikpB1h1ZiqRyabrxBN15s2GVgOItUmJYcGijh6TqCKTYL0r
h7Uu9887F7nXxvrQJroPVZl+3Un/F/lidOwq2JAuhfID1jABa3Y8cWHd13s4AOuX
gX19BsJava/m5paNqBv5bQPo+hrteXgBJyp03ISfdywdubHqhzT7MkqnbAKSZ6eS
kqIt9L8NMZ8dGz9I3nwu7N04pzipBrndq9BlIDRy5DD5kQo/rW8=
=tZpi
-----END PGP SIGNATURE-----

--3twdewe4gx42kppc--
