Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 734F5C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5680B2072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 12:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgCFMfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 07:35:51 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38118 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbgCFMfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 07:35:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: alyssa)
        with ESMTPSA id EE776297096
Date:   Fri, 6 Mar 2020 07:35:43 -0500
From:   Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Nick Fan <nick.fan@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, hsinyi@chromium.org
Subject: Re: [PATCH v5 0/4] Add dts for mt8183 GPU (and misc panfrost patches)
Message-ID: <20200306123543.GA1821@kevin>
References: <20200306041345.259332-1-drinkcat@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="huq684BweRXVnRxX"
Content-Disposition: inline
In-Reply-To: <20200306041345.259332-1-drinkcat@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--huq684BweRXVnRxX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Series has my r-b :)

On Fri, Mar 06, 2020 at 12:13:41PM +0800, Nicolas Boichat wrote:
> Hi!
>=20
> Follow-up on the v4: https://patchwork.kernel.org/cover/11369777/, some
> of the core patches got merged already (thanks Rob!).
>=20
> The main purpose of this series is to upstream the dts change and the
> binding document, but I wanted to see how far I could probe the GPU, to
> check that the binding is indeed correct. The rest of the patches are
> RFC/work-in-progress.
>=20
> So this is tested on MT8183 with a chromeos-4.19 kernel, and a ton of
> backports to get the latest panfrost driver (I should probably try on
> linux-next at some point but this was the path of least resistance).
>=20
> I tested it as a module as it's more challenging (originally probing would
> work built-in, on boot, but not as a module, as I didn't have the power
> domain changes, and all power domains are on by default during boot).
>=20
> Probing logs looks like this, currently. They look sane.
> [  501.319728] panfrost 13040000.gpu: clock rate =3D 511999970
> [  501.320041] panfrost 13040000.gpu: Linked as a consumer to regulator.14
> [  501.320102] panfrost 13040000.gpu: Linked as a consumer to regulator.31
> [  501.320651] panfrost 13040000.gpu: Linked as a consumer to genpd:0:130=
40000.gpu
> [  501.320954] panfrost 13040000.gpu: Linked as a consumer to genpd:1:130=
40000.gpu
> [  501.321062] panfrost 13040000.gpu: Linked as a consumer to genpd:2:130=
40000.gpu
> [  501.321734] panfrost 13040000.gpu: mali-g72 id 0x6221 major 0x0 minor =
0x3 status 0x0
> [  501.321741] panfrost 13040000.gpu: features: 00000000,13de77ff, issues=
: 00000000,00000400
> [  501.321747] panfrost 13040000.gpu: Features: L2:0x07120206 Shader:0x00=
000000 Tiler:0x00000809 Mem:0x1 MMU:0x00002830 AS:0xff JS:0x7
> [  501.321752] panfrost 13040000.gpu: shader_present=3D0x7 l2_present=3D0=
x1
> [  501.324951] [drm] Initialized panfrost 1.1.0 20180908 for 13040000.gpu=
 on minor 2
>=20
> Some more changes are still required to get devfreq working, and of course
> I do not have a userspace driver to test this with.
>=20
> I believe at least patches 1 & 2 can be merged (2 depends on another
> patch series, so maybe we could start with 1 only for now...).
>=20
> Thanks!
>=20
> Nicolas Boichat (4):
>   dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
>   arm64: dts: mt8183: Add node for the Mali GPU
>   RFC: drm/panfrost: Add mt8183-mali compatible string
>   RFC: drm/panfrost: devfreq: Add support for 2 regulators
>=20
>  .../bindings/gpu/arm,mali-bifrost.yaml        |  25 +++++
>  arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 ++
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 ++++++++++++++++++
>  drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  17 +++
>  drivers/gpu/drm/panfrost/panfrost_device.h    |   1 +
>  drivers/gpu/drm/panfrost/panfrost_drv.c       |  11 ++
>  6 files changed, 166 insertions(+)
>=20
> --=20
> 2.25.1.481.gfbce0eb801-goog
>=20

--huq684BweRXVnRxX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ17gm7CvANAdqvY4/v5QWgr1WA0FAl5iQ5oACgkQ/v5QWgr1
WA2Wfg/5Acx01qtWt1r6N8Am7rBvPeoVpmq9TkjjQ4RxwOUOdNmY0EdHiFThQMh+
IcRWZd7FYzM43WLebWWFVxcPgajS9PXB6MPiJcYwxVGvck0F6AW1SbZysoLdY4S8
AkaNQ5FLVHdr0sa5dkD80nAbLEnIyzkE48WXg7g1hIbdOjompFKdsHyv8UllLDdh
exBzqdVkfCd4UWCF+89cxDhGFUB/KFKdzk3jezMTCzkFzH6U0NWSn54oRJNFYdn8
x+1IscTm8NEZ9ghuldVcTLkiw+HDeEJ7tOgIq9REuUelwk312INaju2cxhF60Id0
JgIrNn+p7G9E3sEMlrrfDkEAm2kzS9WDVQGJ2vG2hNpwAZZBmLPnGQuV0pFuUSCB
Te5JrsafvUHZVWa3WrwFAxWM6F1iIfPlSXSQ1OYE6TrcSE2jWTZpWfXrHTg1oZOn
vTg+ZPyg7VfH/VtI/BmjIGeCPDVvPwCmlIbLv351H/uZ+sLWbT0Q1c9Y8qptg0MY
ldn2eRHR//yugNzH1QIWr6aPz0HTRHhEomrckZONP+40n1LinxHZEapOeTQnw0Ch
IoQjaQCaNW615SGOd3z2ncpg84xcc9SS3xb8Lb2WZZb9GHCIP3479jdCj52fnlQG
hYdjTL7nX7jwJkAXIUza7jiC2KIw7J8AfU10nxdyM9F5pHU9KS4=
=SWdB
-----END PGP SIGNATURE-----

--huq684BweRXVnRxX--
