Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E57C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FD96206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgESJSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:18:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:6249 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgESJSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:18:53 -0400
IronPort-SDR: rIJVXUsBaKHfdl9BCjYml+o83IGMNBQl2f8iyaOMxriJwEuhTYo0yi9iWFJAhWs7ZtMXYhv162
 0u0cZi9A3uSA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 02:18:53 -0700
IronPort-SDR: eLPJ7emkIjiGp5tvpgx2vYXt/WlHCVeI92gARiXcJIbFd985uSG4b3hmQ33/TUb4eoAoOhpFyj
 NJi9cBfLPYoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="asc'?scan'208";a="264246035"
Received: from zhen-hp.sh.intel.com (HELO zhen-hp) ([10.239.160.147])
  by orsmga003.jf.intel.com with ESMTP; 19 May 2020 02:18:49 -0700
Date:   Tue, 19 May 2020 17:03:49 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        intel-gvt-dev@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gvt: Use ARRAY_SIZE for vgpu_types
Message-ID: <20200519090349.GH12464@zhen-hp.sh.intel.com>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20200518150336.15265-1-aishwaryarj100@gmail.com>
 <158983565244.7442.10004490488930800145@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XaUbO9McV5wPQijU"
Content-Disposition: inline
In-Reply-To: <158983565244.7442.10004490488930800145@build.alporthouse.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XaUbO9McV5wPQijU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020.05.18 22:00:52 +0100, Chris Wilson wrote:
> Quoting Aishwarya Ramakrishnan (2020-05-18 16:03:36)
> > Prefer ARRAY_SIZE instead of using sizeof
> >=20
> > Fixes coccicheck warning: Use ARRAY_SIZE
> >=20
> > Signed-off-by: Aishwarya Ramakrishnan <aishwaryarj100@gmail.com>
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>

Applied, thanks!

--=20
Open Source Technology Center, Intel ltd.

$gpg --keyserver wwwkeys.pgp.net --recv-keys 4D781827

--XaUbO9McV5wPQijU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCXsOg9QAKCRCxBBozTXgY
J77kAJwPrZXYQuwdV7vDYpOyws1dsMYDawCglf/k9lLHmCPNlRV4qCUW+TyrJMc=
=L3VK
-----END PGP SIGNATURE-----

--XaUbO9McV5wPQijU--
