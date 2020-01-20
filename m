Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAFA6C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B73F32077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726621AbgATGfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:35:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:55427 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725783AbgATGfX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:35:23 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jan 2020 22:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,340,1574150400"; 
   d="asc'?scan'208";a="226972871"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.13.14])
  by orsmga003.jf.intel.com with ESMTP; 19 Jan 2020 22:35:21 -0800
Date:   Mon, 20 Jan 2020 14:23:30 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhenyu Wang <zhenyuw@linux.intel.com>, hang.yuan@intel.com,
        dri-devel@lists.freedesktop.org, zhiyuan.lv@intel.com
Subject: Re: [RFC PATCH 2/4] drm/i915/gvt: remove unused vblank_done
 completion
Message-ID: <20200120062330.GB14597@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
 <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
 <20200109171357.115936-3-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="H+4ONPRPur6+Ovig"
Content-Disposition: inline
In-Reply-To: <20200109171357.115936-3-julian.stecklina@cyberus-technology.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--H+4ONPRPur6+Ovig
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.01.09 19:13:55 +0200, Julian Stecklina wrote:
> This variable is used nowhere, so remove it.
>=20
> Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
>=20
> Signed-off-by: Julian Stecklina <julian.stecklina@cyberus-technology.de>
> ---

Thanks for catching this.

Acked-by: Zhenyu Wang <zhenyuw@linux.intel.com>

>  drivers/gpu/drm/i915/gvt/gvt.h   | 2 --
>  drivers/gpu/drm/i915/gvt/kvmgt.c | 2 --
>  2 files changed, 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/i915/gvt/gvt.h b/drivers/gpu/drm/i915/gvt/gv=
t.h
> index 2604739e5680..8cf292a8d6bd 100644
> --- a/drivers/gpu/drm/i915/gvt/gvt.h
> +++ b/drivers/gpu/drm/i915/gvt/gvt.h
> @@ -203,8 +203,6 @@ struct intel_vgpu {
>  	struct mutex dmabuf_lock;
>  	struct idr object_idr;
> =20
> -	struct completion vblank_done;
> -
>  	u32 scan_nonprivbb;
>  };
> =20
> diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/=
kvmgt.c
> index d725a4fb94b9..9a435bc1a2f0 100644
> --- a/drivers/gpu/drm/i915/gvt/kvmgt.c
> +++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
> @@ -1817,8 +1817,6 @@ static int kvmgt_guest_init(struct mdev_device *mde=
v)
>  	kvmgt_protect_table_init(info);
>  	gvt_cache_init(vgpu);
> =20
> -	init_completion(&vgpu->vblank_done);
> -
>  	info->track_node.track_write =3D kvmgt_page_track_write;
>  	info->track_node.track_flush_slot =3D kvmgt_page_track_flush_slot;
>  	kvm_page_track_register_notifier(kvm, &info->track_node);
> --=20
> 2.24.1
>=20
> _______________________________________________
> intel-gvt-dev mailing list
> intel-gvt-dev@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gvt-dev

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--H+4ONPRPur6+Ovig
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXiVHYgAKCRCxBBozTXgY
J7O4AJ48ARBfZBHass37yOR8ijzI27ZMOACffEnlES5GbM0gcAfSIxey2K4EXZo=
=xnFl
-----END PGP SIGNATURE-----

--H+4ONPRPur6+Ovig--
