Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3283BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05185207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 10:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597833488;
	bh=y+M69Til1EvJORNhPxvngspprJECf70sXE+hyFMk3+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xGMdGicAz/8o+pdHw+eKSXRAnBYuwej0GC0lztkmU+mAjx99zKI7+x68crrfLmBDV
	 lIO4LANQsM+RQTi4qHebH3yXxWVRnH8ZhZTmIt2JATKV7HAjdTNn8WCZy1JllzBvTE
	 PF1ezLNiC1P2A91t6/ggfozEk6l9huQqhLUaUpUA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHSKiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 06:38:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727869AbgHSKiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:38:03 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7B52072D;
        Wed, 19 Aug 2020 10:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597833482;
        bh=y+M69Til1EvJORNhPxvngspprJECf70sXE+hyFMk3+Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=toLXAql2wtllHm023rx293u6rgtg4oRalT1G7c7wfPh7zw6tadzcKc0nAX0mtQSv9
         cJCv8nopRHdF9FKLtrxwQZ8GdvEdfF2+RWPKX1UAnOfdE43dVszrqRdv7WbdIxH5JE
         UIM61liYddD+z/S7aiK9zvrhAesojjkLfn5YxTb0=
Date:   Wed, 19 Aug 2020 11:37:30 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Tzung-Bi Shih <tzungbi@google.com>
Cc:     Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, howie.huang@mediatek.com,
        eason.yen@mediatek.com, shane.chien@mediatek.com,
        bicycle.tsai@mediatek.com
Subject: Re: [PATCH v5 2/2] dt-bindings: mediatek: mt6359: add codec document
Message-ID: <20200819103730.GB5441@sirena.org.uk>
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
 <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
 <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
X-Cookie: I wish you were a Scotch on the rocks.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 17, 2020 at 04:11:03PM +0800, Tzung-Bi Shih wrote:
> On Mon, Aug 17, 2020 at 3:29 PM Tzung-Bi Shih <tzungbi@google.com> wrote:

> > > +required:
> > > +  - compatible

> > And the same here.

> I misunderstood.  It still needs the compatible string to match the
> corresponding driver.

No, it doesn't.  The MFD should be registering the platform device.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89AOkACgkQJNaLcl1U
h9Dwbwf8COv9Rs7LMNn91TpJLXgOTRfXxwmnESd9+12yTNqmd+k9YAgp3PaB7PBq
GX1hQYeOeClZMGMGnjCt2RAkfT5A0/5SwKVsASefRpA6CTlKNCUk+5WQ6pK/LLqA
TH0RRiA3Z8ZS5WfUsZrovdCsHlCEQ+gCNctOyf3RqmX33RmycE1YWyWlQS3qLK7v
W7/F7t/mOMbrEAT4a4YHtbSYf/xT8aDr81GyndfpV6zwtQlWAmw4lI2IT0+XX4hr
BDwHxr6/Te3UgU6p+9xq5UgrIyXkR5htNv+49VqxNFNUhhPMgd00IO47kda9kvHP
rIO1YU5Mf+STMsbFuTk3zmEfud3FkQ==
=7xtJ
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
