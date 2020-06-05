Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF60C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B782207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 05:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgFEFKK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 01:10:10 -0400
Received: from mga09.intel.com ([134.134.136.24]:21900 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgFEFKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 01:10:10 -0400
IronPort-SDR: GF9rJsIpdPDqTCZsWnDhkiNGYGJ9eMDSzSNerqBaDTC/R42iP5R2FtKApIfcjL5/pLb1j7oiy2
 byBzoMz+2Pnw==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2020 22:10:09 -0700
IronPort-SDR: 4idtIugdnOHQYK2nosQvAUNWjA4rL6bAZOJwhqMG8P8YiBjNHy5yvSIA3oUSYEWxW9LZRDSuZc
 TLH/up3j8ssQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,475,1583222400"; 
   d="asc'?scan'208";a="445768791"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by orsmga005.jf.intel.com with ESMTP; 04 Jun 2020 22:10:07 -0700
Date:   Fri, 5 Jun 2020 12:54:30 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        Thomas Prescher <thomas.prescher@cyberus-technology.de>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/i915/gvt: print actionable error message when gm
 runs out
Message-ID: <20200605045430.GS5687@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200603123321.263895-1-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="tuFXEhzhBeitrIAu"
Content-Disposition: inline
In-Reply-To: <20200603123321.263895-1-julian.stecklina@cyberus-technology.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tuFXEhzhBeitrIAu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.06.03 14:33:21 +0200, Julian Stecklina wrote:
> When a user tries to allocate too many or too big vGPUs and runs out
> of graphics memory, the resulting error message is not actionable and
> looks like an internal error.
>=20
> Change the error message to clearly point out what actions a user can
> take to resolve this situation.
>=20
> Cc: Thomas Prescher <thomas.prescher@cyberus-technology.de>
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---
>  drivers/gpu/drm/i915/gvt/aperture_gm.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/aperture_gm.c b/drivers/gpu/drm/i91=
5/gvt/aperture_gm.c
> index 0d6d598713082..5c5c8e871dae2 100644
> --- a/drivers/gpu/drm/i915/gvt/aperture_gm.c
> +++ b/drivers/gpu/drm/i915/gvt/aperture_gm.c
> @@ -69,9 +69,12 @@ static int alloc_gm(struct intel_vgpu *vgpu, bool high=
_gm)
>  				  start, end, flags);
>  	mmio_hw_access_post(gt);
>  	mutex_unlock(&gt->ggtt->vm.mutex);
> -	if (ret)
> -		gvt_err("fail to alloc %s gm space from host\n",
> -			high_gm ? "high" : "low");
> +	if (ret) {
> +		gvt_err("vgpu%d: failed to allocate %s gm space from host\n",
> +			vgpu->id, high_gm ? "high" : "low");
> +		gvt_err("vgpu%d: destroying vGPUs, decreasing vGPU memory size or incr=
easing GPU aperture size may resolve this\n",
> +			vgpu->id);

Currently we can't decrease vGPU mem size as defined by mdev type,
so actually you may try different vGPU type. And aperture size is
also handled for supported vGPU mdev types, so assume user should
already be awared of that too. I just don't want us to be too chatty. :)

> +	}
> =20
>  	return ret;
>  }
> --=20
> 2.26.2
>=20
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--tuFXEhzhBeitrIAu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXtnQBgAKCRCxBBozTXgY
J/c4AKCKRut0XbYE1ZzbeKKaRdpwFEG8cgCfRE5+/HXqXZ4OypqRUdPCM+ACVTk=
=2IF1
-----END PGP SIGNATURE-----

--tuFXEhzhBeitrIAu--
