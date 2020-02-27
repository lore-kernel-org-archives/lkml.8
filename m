Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DA7C34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:04:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C6824691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 15:04:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bY4LeJKH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgB0PE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 10:04:28 -0500
Received: from mail-dm6nam12on2040.outbound.protection.outlook.com ([40.107.243.40]:52558
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729388AbgB0PE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 10:04:27 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HsGDF9jrtrc84KF0dQfJH+KV5rKnV3HAdqE4nW8MOBx2IMHsyZ6J1JBGneO2C1OnQUF6sSFUjYKwnwwZLc546iK/ga/L/IzlUSW1ne338Jici4yegatb+ccXZ82uRoMzvSwjVcRv/k4wLrcNQCVsEqPQW+EuQiLEmDpbSmvS8ZZCzx0GjJc4kHvaa3jEiRdU/Qsl4Bf0bZp+5d+HtolO35XsQ89HN6XS+CKHGNwvMe0LtpGcDw1x9f4OW5hNxqBf+Ouds6TxYVu1TP/FEILbqno+WfhIMv+5A6jKYuDiUf951n7gKoguzdN7L97qfqcm+5pZ3AUAlg1lyD74IemNDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbBRFbWOGxJn35/ExiYvU1/ocwsR/grac1OKjPfr5uE=;
 b=PZn2/2BtDLYwv3nfNbZzjnJ8M3QfoT5tvE/ZAzLNaE5207fDP0dDjNLyxLNHKPhHurCyWyRH2cBSwvUZhLaCc8c+GJXDQbyHhDLLII2ze4IgOF7FmWF5YjGHyv/8i46pz7ftbX4okLoH7//IMObsghqDbgO6LkF8sWwWjLRjcwUpAH3CIIgh7LjXL/7M0+PhoaqZjPNrnUHw29Vn9ZVAeHn1SB+0YQCky3f60km5UzCdYO/bFGUZ0xfNOZicxmbzI+9uod9B+UGgXU2YH4oKGeT1h0HfBil2FCcQfyuqI3tUOQC8F3f5Bo+fmehfhBJxrx+1daF2EEp0rHOA20INfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XbBRFbWOGxJn35/ExiYvU1/ocwsR/grac1OKjPfr5uE=;
 b=bY4LeJKH03QU0qF3i7pkD44/BMoRVd3md/klW6oAnfpPYEq3nUqpQAkLoz5tIrQDMiK32B9zWaqs7eZ0E2f/LY6hcPbfhDDIYrJDAbYuEJh1wTjfNwE6sDBI7A7ar+1KwavJy6oySgql+XVfhN1IGeVZNXaYupScyMtyZVZsW5I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2521.namprd12.prod.outlook.com (2603:10b6:907:8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.22; Thu, 27 Feb
 2020 15:04:25 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 15:04:25 +0000
Date:   Thu, 27 Feb 2020 10:04:22 -0500
From:   Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To:     Melissa Wen <melissa.srw@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] drm/amd/display: dc_link: code clean up on
 enable_link_dp function
Message-ID: <20200227150422.isialtxjvtru23xl@outlook.office365.com>
References: <cover.1582752490.git.melissa.srw@gmail.com>
 <990112183d2bc344bd921bb55eee2f8cc2cd8bd5.1582752490.git.melissa.srw@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ebgtat4l2jjw2z7g"
Content-Disposition: inline
In-Reply-To: <990112183d2bc344bd921bb55eee2f8cc2cd8bd5.1582752490.git.melissa.srw@gmail.com>
X-ClientProxiedBy: YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::49) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from outlook.office365.com (165.204.55.250) by YTOPR0101CA0072.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15 via Frontend Transport; Thu, 27 Feb 2020 15:04:23 +0000
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 664d6772-7386-42f8-4bce-08d7bb965559
X-MS-TrafficTypeDiagnostic: MW2PR12MB2521:|MW2PR12MB2521:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2521D4F3E391DCF9ED88006E98EB0@MW2PR12MB2521.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10001)(10009020)(4636009)(39860400002)(396003)(376002)(136003)(346002)(366004)(189003)(199004)(81166006)(16526019)(186003)(9686003)(55016002)(956004)(81156014)(86362001)(8936002)(45080400002)(66556008)(478600001)(66946007)(54906003)(66476007)(966005)(316002)(1076003)(7696005)(4326008)(8676002)(26005)(2906002)(6506007)(5660300002)(21480400003)(44144004)(6916009)(52116002)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2521;H:MW2PR12MB2524.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A33m9QsHduz2lQiD8Z4Bia7l0jixRkVCzBtZb0i0U/2CIl7hcuXP2mYfpPdIKdORcgiP+j6TSl7qav/NoduP7qBIlBGnQUL3I58FqPM9ZGPuNwjXHOkrJCyAnCA56hEgm0oax49G+GCggwR8kGk5QGvKbUuqa0i49aJqkiu8r3QGUyF4fzuGJFKsbl/CanF4k/98HSuO96rR+QxedkIS1a7AZ1c5YHs1g55GgmS4PPgCO9LKAxnb92W7ufz4hyGfT6c5+yYiNWDU66OJIBLZBf69pwdN5Zpw4mXkHDM+EV3nODAjfwi+3JiNNZlf100U03n2DMQ0Mgjb3F8Z8MGrZVu7O4Uateplq6qK4fkcJmAXSS96viRUsCwdG+Ivz1FmigVUfiW8UOTRmL/+UfZTNZ30OegykIAcZqlhFbYk6WY4HZQoEMuyThrOAmBxzaPGuOU5JoImBqZVeaLuVRmDeYWl297llIflbiSn3eBcj0Zc/KodvSmHQJFZ23rclsflbAdm/1hzzLh7oNbL5AcBQpV6bPezWZLS0W0n/wC4EJ/QLowZ/dygrMhMvrqQvcTIiWUEt07mXS+0HL4awgFfvapPaI8uhjDxEfTZ8MzVly00BYW9Ov9OyxjoI4Oge8ZZ6ykLi2KFAe9lEEtU6HfAlg==
X-MS-Exchange-AntiSpam-MessageData: uOqYCNOdHXOCXd1oQVMGzERy67wRavkgMe+PmCR0hJTeINHFMGSScdANYyv60F+0CYYhIy0d0ftZqtv0FoMY++Fw4EPlTlAVz4FuWIQvZ0uhXbmBHQAojp3GHm2NA2B4JQO5mPbPCrNePbhD46Bh4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 664d6772-7386-42f8-4bce-08d7bb965559
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 15:04:25.0147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Knb0lNz/cGP0HpYSRZS2V8MTR5eICQMo9CQSsUV6rWsTOq3DEs+AQGJTI/8c1clG0zYP4IEHZfp1BgyZtP4YLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2521
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--ebgtat4l2jjw2z7g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

First of all, thank you for your patch.

I just have one tiny comment inline.

On 02/26, Melissa Wen wrote:
> Coding style clean up on enable_link_dp function as suggested by
> checkpatch.pl:
>=20
> CHECK: Lines should not end with a '('
> WARNING: line over 80 characters
> WARNING: suspect code indent for conditional statements (8, 24)
> CHECK: braces {} should be used on all arms of this statement
> ERROR: else should follow close brace '}'
> CHECK: Comparison to NULL could be written
>        "link->preferred_training_settings.fec_enable"
>=20
> Signed-off-by: Melissa Wen <melissa.srw@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 32 +++++++++----------
>  1 file changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/=
drm/amd/display/dc/core/dc_link.c
> index a09119c10d7c..0f28b5694144 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -1480,9 +1480,8 @@ static void enable_stream_features(struct pipe_ctx =
*pipe_ctx)
>  	}
>  }
> =20
> -static enum dc_status enable_link_dp(
> -		struct dc_state *state,
> -		struct pipe_ctx *pipe_ctx)
> +static enum dc_status enable_link_dp(struct dc_state *state,
> +				     struct pipe_ctx *pipe_ctx)
>  {
>  	struct dc_stream_state *stream =3D pipe_ctx->stream;
>  	enum dc_status status;
> @@ -1512,27 +1511,28 @@ static enum dc_status enable_link_dp(
> =20
>  	pipe_ctx->stream_res.pix_clk_params.requested_sym_clk =3D
>  			link_settings.link_rate * LINK_RATE_REF_FREQ_IN_KHZ;
> -	if (state->clk_mgr && !apply_seamless_boot_optimization)
> -		state->clk_mgr->funcs->update_clocks(state->clk_mgr, state, false);
> +	if (state->clk_mgr && !apply_seamless_boot_optimization) {
> +		state->clk_mgr->funcs->update_clocks(state->clk_mgr,
> +						     state, false);
> +	}

This `if` condition only has one action, which means that you don't need
to add `{}` in the above statement. See:

https://www.kernel.org/doc/html/v4.10/process/coding-style.html#placing-bra=
ces-and-spaces

Thanks

> =20
>  	skip_video_pattern =3D true;
> =20
>  	if (link_settings.link_rate =3D=3D LINK_RATE_LOW)
> -			skip_video_pattern =3D false;
> -
> -	if (perform_link_training_with_retries(
> -			&link_settings,
> -			skip_video_pattern,
> -			LINK_TRAINING_ATTEMPTS,
> -			pipe_ctx,
> -			pipe_ctx->stream->signal)) {
> +		skip_video_pattern =3D false;
> +
> +	if (perform_link_training_with_retries(&link_settings,
> +					       skip_video_pattern,
> +					       LINK_TRAINING_ATTEMPTS,
> +					       pipe_ctx,
> +					       pipe_ctx->stream->signal)) {
>  		link->cur_link_settings =3D link_settings;
>  		status =3D DC_OK;
> -	}
> -	else
> +	} else {
>  		status =3D DC_FAIL_DP_LINK_TRAINING;
> +	}
> =20
> -	if (link->preferred_training_settings.fec_enable !=3D NULL)
> +	if (link->preferred_training_settings.fec_enable)
>  		fec_enable =3D *link->preferred_training_settings.fec_enable;
>  	else
>  		fec_enable =3D true;
> --=20
> 2.25.0
>=20
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists=
=2Efreedesktop.org%2Fmailman%2Flistinfo%2Fdri-devel&amp;data=3D02%7C01%7CRo=
drigo.Siqueira%40amd.com%7Ccbf2adb12548404e917208d7bb0842d2%7C3dd8961fe4884=
e608e11a82d994e183d%7C0%7C0%7C637183516476617662&amp;sdata=3D%2FyyxWqZVGvbV=
Anr1OWCKi0y5Sdl5j5Le6C3dmYoaNy4%3D&amp;reserved=3D0

--=20
Rodrigo Siqueira
https://siqueira.tech

--ebgtat4l2jjw2z7g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4tZ+ii1mjMCMQbfkWJzP/comvP8FAl5X2nEACgkQWJzP/com
vP/ZRQ/+Ldr4/C9O3T0D1lPuhTvRPEVLeIUjOAJanAgCMbixfhZSTel8we2p+7Sh
a8aUb25eUET2FBTrA5wemGJ9x6nQ9s4NXk4SHwWhfggRLfOMPM85MwPquI+0bF/y
FrcjbubbxDuoJEPB+y3cCCriMhq90wFfI40s6QNl5zm9LyWfTaNzXbFOMXunSWl/
Tj1MowURGwP2UIfeLv5MIUj5vx7p6Gm/I3DaxqiEqnb4Iyadb+YgDj9NXkoEoIxf
Y7P9fOMgHeQ94GLNeuyX3Jkwh335xy286noWjXYvQgTpGG3DqJWmbuElOjLzywNC
QqHxYsqlIa2HPUcxqo7A7/jPKl8Awkm09Ul4hg/mdON899WiDbOS6daxQ8VAq+rk
UzCowOxxP8Gitu967YWJSqwgfwa+5ZS5t5inCmTqd9CJ0/gxVRdo3QFPyjtlQ8DU
5ciF+i6PrX76HwJMXVfbIbF+fnCsgtDBiAlGXeAi9OpRQNsYczgxW64SfJLwnfg1
B532QhDT5wgYS0GjJEeVfkof9VtquRhXJHUDHOhmuJpE5LpwkCHNI/0Cu4aRUj9M
WykvKSM3TsLIgBVKIK06wJPPp0luFcvk2zR74NexqJR3sLUPQntV4ImlisbiRAI2
fRQW/DoCZg6XA62IwFF/Y05fWQJrN8+2zFBy/4RWNB9vjVLCauo=
=aELQ
-----END PGP SIGNATURE-----

--ebgtat4l2jjw2z7g--
