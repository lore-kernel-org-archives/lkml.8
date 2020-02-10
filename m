Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BF7C2BA83
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04E332082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 01:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726961AbgBJBzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 20:55:53 -0500
Received: from mga01.intel.com ([192.55.52.88]:51100 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbgBJBzw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 20:55:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Feb 2020 17:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,423,1574150400"; 
   d="asc'?scan'208";a="405439459"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.14])
  by orsmga005.jf.intel.com with ESMTP; 09 Feb 2020 17:55:49 -0800
Date:   Mon, 10 Feb 2020 09:43:14 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Igor Druzhinin <igor.druzhinin@citrix.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, airlied@linux.ie,
        joonas.lahtinen@linux.intel.com, jani.nikula@linux.intel.com,
        zhenyuw@linux.intel.com, daniel@ffwll.ch, rodrigo.vivi@intel.com,
        zhi.a.wang@intel.com
Subject: Re: [PATCH] drm/i915/gvt: more locking for ppgtt mm LRU list
Message-ID: <20200210014314.GA28133@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <1580742421-25194-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
In-Reply-To: <1580742421-25194-1-git-send-email-igor.druzhinin@citrix.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.02.03 15:07:01 +0000, Igor Druzhinin wrote:
> When the lock was introduced in 72aabfb862e40 ("drm/i915/gvt: Add mutual
> lock for ppgtt mm LRU list") one place got lost.
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> ---
>  drivers/gpu/drm/i915/gvt/gtt.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gt=
t.c
> index 34cb404..4a48280 100644
> --- a/drivers/gpu/drm/i915/gvt/gtt.c
> +++ b/drivers/gpu/drm/i915/gvt/gtt.c
> @@ -1956,7 +1956,11 @@ void _intel_vgpu_mm_release(struct kref *mm_ref)
> =20
>  	if (mm->type =3D=3D INTEL_GVT_MM_PPGTT) {
>  		list_del(&mm->ppgtt_mm.list);
> +
> +		mutex_lock(&mm->vgpu->gvt->gtt.ppgtt_mm_lock);
>  		list_del(&mm->ppgtt_mm.lru_list);
> +		mutex_unlock(&mm->vgpu->gvt->gtt.ppgtt_mm_lock);
> +
>  		invalidate_ppgtt_mm(mm);
>  	} else {
>  		vfree(mm->ggtt_mm.virtual_ggtt);
> --=20

Thanks for the fix!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--KsGdsel6WgEHnImy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXkC1MQAKCRCxBBozTXgY
J4abAJ9rGEjuKM3P5001pSAgbWTxt3gc1gCfQm1iVfei/7raZuyFiFZ7OkbVwJE=
=y1cr
-----END PGP SIGNATURE-----

--KsGdsel6WgEHnImy--
