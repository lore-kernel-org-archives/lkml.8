Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C23C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B30724125
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 05:19:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgAWFT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 00:19:28 -0500
Received: from mga01.intel.com ([192.55.52.88]:48637 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgAWFT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 00:19:28 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jan 2020 21:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,352,1574150400"; 
   d="asc'?scan'208";a="216152482"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.14])
  by orsmga007.jf.intel.com with ESMTP; 22 Jan 2020 21:19:24 -0800
Date:   Thu, 23 Jan 2020 13:07:27 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Igor Druzhinin <igor.druzhinin@citrix.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, zhenyuw@linux.intel.com,
        zhi.a.wang@intel.com, jani.nikula@linux.intel.com,
        joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
        airlied@linux.ie, daniel@ffwll.ch
Subject: Re: [PATCH] drm/i915/gvt: fix high-order allocation failure on late
 load
Message-ID: <20200123050727.GA25905@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <1579723824-25711-1-git-send-email-igor.druzhinin@citrix.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="vkogqOf2sHV7VnPd"
Content-Disposition: inline
In-Reply-To: <1579723824-25711-1-git-send-email-igor.druzhinin@citrix.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--vkogqOf2sHV7VnPd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.01.22 20:10:24 +0000, Igor Druzhinin wrote:
> If the module happens to be loaded later at runtime there is a chance
> memory is already fragmented enough to fail allocation of firmware
> blob storage and consequently GVT init. Since it doesn't seem to be
> necessary to have the blob contiguous, use vmalloc() instead to avoid
> the issue.
>=20
> Signed-off-by: Igor Druzhinin <igor.druzhinin@citrix.com>
> ---
>  drivers/gpu/drm/i915/gvt/firmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/firmware.c b/drivers/gpu/drm/i915/g=
vt/firmware.c
> index 049775e..b0c1fda 100644
> --- a/drivers/gpu/drm/i915/gvt/firmware.c
> +++ b/drivers/gpu/drm/i915/gvt/firmware.c
> @@ -146,7 +146,7 @@ void intel_gvt_free_firmware(struct intel_gvt *gvt)
>  		clean_firmware_sysfs(gvt);
> =20
>  	kfree(gvt->firmware.cfg_space);
> -	kfree(gvt->firmware.mmio);
> +	vfree(gvt->firmware.mmio);
>  }
> =20
>  static int verify_firmware(struct intel_gvt *gvt,
> @@ -229,7 +229,7 @@ int intel_gvt_load_firmware(struct intel_gvt *gvt)
> =20
>  	firmware->cfg_space =3D mem;
> =20
> -	mem =3D kmalloc(info->mmio_size, GFP_KERNEL);
> +	mem =3D vmalloc(info->mmio_size);
>  	if (!mem) {
>  		kfree(path);
>  		kfree(firmware->cfg_space);
> --=20
> 2.7.4
>

Looks fine to me. Thanks!

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--vkogqOf2sHV7VnPd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXikqDwAKCRCxBBozTXgY
J+4uAJ96YbLIY0cQA9wjsw2Zc/jXBf4gXwCeMpf5uwvjnowmgSrYjEle8958Ezw=
=DlrF
-----END PGP SIGNATURE-----

--vkogqOf2sHV7VnPd--
