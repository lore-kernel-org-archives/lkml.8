Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0087C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9676E20679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 13:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cerno.tech header.i=@cerno.tech header.b="AZJBdQAF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aZM9QTK0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCNOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 09:14:42 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:52749 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgFCNOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 09:14:42 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id C46285800EC;
        Wed,  3 Jun 2020 09:14:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 03 Jun 2020 09:14:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=uBEy9uUD7V4GAl7MMeMnyKYCBfd
        DWDfGigVzTdJ7tzc=; b=AZJBdQAFsN8T66EQzn9Wcc2vg3hMeiF1YfrI4otLU5j
        ayEtj9wMzy2dK+q1oaJf6OukjRPqhbRv99XKj25bawwZklNTZX1Ee6D7+bWaoVrL
        3qbmwjNTHNgpDYacDSpJ1Xnhlah2S/i5spzjfYus2ltM7X6HrKQttLQaC6ps+CYp
        ZzZ12CTxUQnFhvSujxTT6GELZWvD1pA0fnw3dT6ZXvl4wz4/AvG/OvAFskt9hTDA
        K5ulb5XTefMVA1D+XOb9CGZ69J+YRp3yucwDcbZljzjcVFISZSyzhBCJA0cecVFB
        HllXzI7njY3EjSuXsWI8OLxzaqiSVsk6lTkApOb/1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=uBEy9u
        UD7V4GAl7MMeMnyKYCBfdDWDfGigVzTdJ7tzc=; b=aZM9QTK0sS7GjkUa7QAJtL
        Lejb+yRHv6mN8TcRQ6s5HfIQMv7rAHGpl3ILdyAA7SQSedj2uxpHpcF1qIDGnAiC
        FCaLo63Rfk7X0vGZ1SeGjKBTnk0XAxk+3Dl7Q+o7OeWQOmFLMHDyVc7Bs5kDvFMw
        FgFWe5daPiWtGGdRrwQf/qmzqwJzv31TIw2jM7JoCqq99UaIeQreLMcJAkDVyL7s
        E69WDcZT+evmDPoas1hfwiN0uGjnzY0JDl2WtpftVp2Pxu+uit2sccOz1eimGDt1
        zDm+Oe6ftv5dh+8q9cvK0UIV3RelzLCNX8nPnX78ayzXWlbOOQUuPOoGh/1esB7A
        ==
X-ME-Sender: <xms:PKLXXnOceDu38XUdEq9KYOvWcbXoNfhmu5vSIOn6HC2Cf6NQzLUfog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudefledggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeforgigihhm
    vgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrfgrth
    htvghrnhepleekgeehhfdutdeljefgleejffehfffgieejhffgueefhfdtveetgeehieeh
    gedunecukfhppeeltddrkeelrdeikedrjeeinecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:PKLXXh8L5OqKPblO06XbnufxBIe_ltSiGcw1inOPsRCCRJ1ecgrhbg>
    <xmx:PKLXXmTuCv8Z8mi2fWBhCVv-ktZMMlOIi8w27Wp2QH0joTkrpztzIg>
    <xmx:PKLXXrvE6CqcWwKTZdVMTOy8CRvcvw-_mcxqJE15O2lZ4pZkkYiQtw>
    <xmx:QKLXXhubcgixN5SkTq2hkByTgjNp12_KtQklGEPxsBV-MOx2LhFKUw>
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        by mail.messagingengine.com (Postfix) with ESMTPA id C1E8E3061CB6;
        Wed,  3 Jun 2020 09:14:35 -0400 (EDT)
Date:   Wed, 3 Jun 2020 15:14:34 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        LKML <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH v3 032/105] drm/vc4: crtc: Enable and disable the PV in
 atomic_enable / disable
Message-ID: <20200603131434.2gmofg7sf7luakje@gilmour>
References: <cover.aaf2100bd7da4609f8bcb8216247d4b4e4379639.1590594512.git-series.maxime@cerno.tech>
 <d2c1850e38e14f3def4c0307240e6826e296c14b.1590594512.git-series.maxime@cerno.tech>
 <CADaigPU7c=1u47R9GzvGCH_Z2fywY1foGYEy=KbBikjUQpwUFg@mail.gmail.com>
 <20200602141228.7zbkob7bw3owajsq@gilmour>
 <CAPY8ntDZWJeu14mL5a0jqUWHFOEWm2OOBBkh4yjjP0oLU83UCQ@mail.gmail.com>
 <CADaigPUHPhdrt9JkTfaw0iT7Z8z3Si-v2VJ-s+dhnFQaDNkAaA@mail.gmail.com>
 <f0098c06-f892-cc1e-eb75-be48e40f705c@i2se.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="skfrnwv7a5sl4g3l"
Content-Disposition: inline
In-Reply-To: <f0098c06-f892-cc1e-eb75-be48e40f705c@i2se.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--skfrnwv7a5sl4g3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

On Tue, Jun 02, 2020 at 10:03:13PM +0200, Stefan Wahren wrote:
> Am 02.06.20 um 21:31 schrieb Eric Anholt:
> > On Tue, Jun 2, 2020 at 8:02 AM Dave Stevenson
> > <dave.stevenson@raspberrypi.com> wrote:
> >> Hi Maxime and Eric
> >>
> >> On Tue, 2 Jun 2020 at 15:12, Maxime Ripard <maxime@cerno.tech> wrote:
> >>> Hi Eric
> >>>
> >>> On Wed, May 27, 2020 at 09:54:44AM -0700, Eric Anholt wrote:
> >>>> On Wed, May 27, 2020 at 8:50 AM Maxime Ripard <maxime@cerno.tech> wr=
ote:
> >>>>> The VIDEN bit in the pixelvalve currently being used to enable or d=
isable
> >>>>> the pixelvalve seems to not be enough in some situations, which whi=
ll end
> >>>>> up with the pixelvalve stalling.
> >>>>>
> >>>>> In such a case, even re-enabling VIDEN doesn't bring it back and we=
 need to
> >>>>> clear the FIFO. This can only be done if the pixelvalve is disabled=
 though.
> >>>>>
> >>>>> In order to overcome this, we can configure the pixelvalve during
> >>>>> mode_set_no_fb, but only enable it in atomic_enable and flush the F=
IFO
> >>>>> there, and in atomic_disable disable the pixelvalve again.
> >>>> What displays has this been tested with?  Getting this sequencing
> >>>> right is so painful, and things like DSI are tricky to get to light
> >>>> up.
> >>> That FIFO is between the HVS and the HDMI PVs, so this was obviously
> >>> tested against that. Dave also tested the DSI output IIRC, so we shou=
ld
> >>> be covered here.
> >> DSI wasn't working on the first patch set that Maxime sent - I haven't
> >> tested this one as yet but will do so.
> >> DPI was working early on to both an Adafruit 800x480 DPI panel, and
> >> via a VGA666 as VGA.
> >> HDMI is obviously working.
> >> VEC is being ignored now. The clock structure is more restricted than
> >> earlier chips, so to get the required clocks for the VEC without using
> >> fractional divides it compromises the clock that other parts of the
> >> system can run at (IIRC including the ARM). That's why the VEC has to
> >> be explicitly enabled for the firmware to enable it as the only
> >> output. It's annoying, but that's just a restriction of the chip.
> > I'm more concerned with "make sure we don't regress pre-pi4 with this
> > series" than "pi4 displays all work from the beginning"
>=20
> unfortuntely i can confirm this. With this patch series (using Maxime's
> git repo with multi_v7_defconfig) my Raspberry Pi 3 B hangs up while
> starting X (screen stays black, heartbeat stops, no more output at the
> debug UART). AFAIR v2 didn't had this issue.

Did it happen with a DSI display or something else?

I've been trying to setup the DSI display on an RPi3 today, but noticed
that it looks like there's a regression in next that prevents the HDMI
driver to load entirely (without my patches).

Maxime

--skfrnwv7a5sl4g3l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXteiOgAKCRDj7w1vZxhR
xbKWAQDYW0bIeRglf4HXhCDqUGdBhZA9ZXckJcF7Q9T+gYysFQEAyPKFFwR9N3NC
f2tspYRw6I0x7UydBz+c6ib42l557wQ=
=eXfr
-----END PGP SIGNATURE-----

--skfrnwv7a5sl4g3l--
