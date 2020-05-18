Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TRACKER_ID,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F99C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B5592070A
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:24:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbgERGY3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:24:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:48658 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726378AbgERGY3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:24:29 -0400
IronPort-SDR: dNxq8mYf81djkVA01PNJKcvNAQuE7lhKxUbGFAT/g+PccKwYg5Y0tnGcWni4ih8QIKw5/iP4wz
 Isau/ixTAoiQ==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 23:24:28 -0700
IronPort-SDR: i/Efo5wE8sji1KgHmHKQOoWISCOrfbaG9dNAnzdGRzbN+bl1tSNbeTVj+LVpGkktlgEAS0whlt
 u7ComdAa8dGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="asc'?scan'208";a="299674577"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by orsmga008.jf.intel.com with ESMTP; 17 May 2020 23:24:25 -0700
Date:   Mon, 18 May 2020 14:09:29 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        clang-built-linux@googlegroups.com,
        intel-gvt-dev@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915: Mark check_shadow_context_ppgtt as maybe unused
Message-ID: <20200518060929.GS18545@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200516023545.3332334-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="t54s24TTWYm6oOX+"
Content-Disposition: inline
In-Reply-To: <20200516023545.3332334-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t54s24TTWYm6oOX+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.05.15 19:35:45 -0700, Nathan Chancellor wrote:
> When CONFIG_DRM_I915_DEBUG_GEM is not set, clang warns:
>=20
> drivers/gpu/drm/i915/gvt/scheduler.c:884:1: warning: function
> 'check_shadow_context_ppgtt' is not needed and will not be emitted
> [-Wunneeded-internal-declaration]
> check_shadow_context_ppgtt(struct execlist_ring_context *c, struct
> intel_vgpu_mm *m)
> ^
> 1 warning generated.
>=20
> This warning is similar to -Wunused-function but rather than warning
> that the function is completely unused, it warns that it is used in some
> expression within the file but that expression will be evaluated to a
> constant or be optimized away in the final assembly, essentially making
> it appeared used but really isn't. Usually, this happens when a function
> or variable is only used in sizeof, where it will appear to be used but
> will be evaluated at compile time and not be required to be emitted.
>=20
> In this case, the function is only used in GEM_BUG_ON, which is defined
> as BUILD_BUG_ON_INVALID, which intentionally follows this pattern. To
> fix this warning, add __maybe_unused to make it clear that this is
> intentional depending on the configuration.
>=20
> Fixes: bec3df930fbd ("drm/i915/gvt: Support PPGTT table load command")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1027
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/i915/gvt/scheduler.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/scheduler.c b/drivers/gpu/drm/i915/=
gvt/scheduler.c
> index f776c92de8d7..0fb1df71c637 100644
> --- a/drivers/gpu/drm/i915/gvt/scheduler.c
> +++ b/drivers/gpu/drm/i915/gvt/scheduler.c
> @@ -880,7 +880,7 @@ static void update_guest_pdps(struct intel_vgpu *vgpu,
>  				gpa + i * 8, &pdp[7 - i], 4);
>  }
> =20
> -static bool
> +static __maybe_unused bool
>  check_shadow_context_ppgtt(struct execlist_ring_context *c, struct intel=
_vgpu_mm *m)
>  {
>  	if (m->ppgtt_mm.root_entry_type =3D=3D GTT_TYPE_PPGTT_ROOT_L4_ENTRY) {
>=20
> base-commit: bdecf38f228bcca73b31ada98b5b7ba1215eb9c9

Thanks for the fix!

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

I'll pick up for gvt-next-fixes pull.

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--t54s24TTWYm6oOX+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXsImmQAKCRCxBBozTXgY
JxfOAJ94e1oxLhfjkCYgNWLtG0s7S2z1fACggFwQWbFs3UxsTHtWE9Ln1GA6M2A=
=gdfP
-----END PGP SIGNATURE-----

--t54s24TTWYm6oOX+--
