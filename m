Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B770C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A7F22080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599501114;
	bh=YMxZ0LBQubRWUql8kN4D8NLNlVpvgs2xsR5mya0rxqE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S8S8oCh2AVCgDz9fy23lilUU06ANoEgwOl2eDf2gBqQNgxGy/qSu2pP7Q692h4dE0
	 7wciorGy6eATPd4iKSOIAD4EMeUHU/erTs+mK7PeOd0CVbiN0woRvb02DSpNBwAE+j
	 lRJ0MwsB+5MTJJBgoYn7J5KanhaP4HZJHUQl+uUg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgIGRvv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:55324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729212AbgIGRvo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:51:44 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47F3E2080A;
        Mon,  7 Sep 2020 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599501103;
        bh=YMxZ0LBQubRWUql8kN4D8NLNlVpvgs2xsR5mya0rxqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v5Kb6di9323FGcnbwasyBMt/IV3HEFuAzbUF+APrbb0SwX1Vz8+6BIvEfNG1YP0Sn
         4Yyl9nTx4dUPvO6OfOBYrJ1/CQ6/Pxtf7VpWZ80gfFV/2K0iRzWwK1P8y5E1vPxDz7
         L+SR/HeAepqOnh9a29zkFo5IyF4a3NjkhA+slzaE=
Date:   Mon, 7 Sep 2020 18:50:59 +0100
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
Message-ID: <20200907175059.GD4907@sirena.org.uk>
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
 <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
 <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
 <20200819103730.GB5441@sirena.org.uk>
 <CA+Px+wUV89KO8JJd3+HpOrgFRSc7sdg-DBW44C31262Qx9NzVg@mail.gmail.com>
 <20200819194005.GC38371@sirena.org.uk>
 <CA+Px+wWMH6iUzFq0g4BFC5qA993r9UBobmNAyS2ie+xDwci-yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eqp4TxRxnD4KrmFZ"
Content-Disposition: inline
In-Reply-To: <CA+Px+wWMH6iUzFq0g4BFC5qA993r9UBobmNAyS2ie+xDwci-yg@mail.gmail.com>
X-Cookie: Elevators smell different to midgets.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eqp4TxRxnD4KrmFZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 07, 2020 at 09:37:12PM +0800, Tzung-Bi Shih wrote:
> On Thu, Aug 20, 2020 at 3:40 AM Mark Brown <broonie@kernel.org> wrote:

> > That's for binding the MFD subdevice to an OF node, you don't need to do
> > that for a device like this - you can just use the of_node of the parent
> > to get at the properties.

> There is an issue we overlooked.  In sound/soc/codecs/mt6359.c,

> After removing the line at (1), mt6359_parse_dt() cannot read the DT properties.

> Here are a few options we can come out with.
> 1. adds back the compatible string in the DTS
> 2. gets of_node of parent in mt6359.c, and iterates all children nodes
> to get the desired properties

Do this, but instead of iterating all the child nodes just look for the
named CODEC node that you define in the bindings if you don't want to
put the properties in the root MFD node.

--eqp4TxRxnD4KrmFZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9WcwMACgkQJNaLcl1U
h9Dp0wf6A3eiem9QGqgDURjl9QoxRQnRXVafGmdx8S4QioV/mf+/xBOc7cNzYri6
keaJ0K+HFWRqk4GwYx4JhRYez80iQmT6TWszym6iv0bCB5UeGXXvhsxsnAm06eKi
FgsY9Wx48r9hxEvDr6S46HYR++HLQI2cg3krRvm6iyQ/jLc1tm1zGfRSOXYenfSJ
HuJydCwg8AUxd0o486d5K6v8md9EK7vtFqqNTEi2NLcfLNlXhR+7L8Ft5LfhvYDk
ScJydi1HAyayykul+n7w4r6ZlP8H5I9Ha7O7HTZMEmpWufiNAl4l+yn6vL2l73xX
77G/jtTLhxwpYEW45hLguvCN6asf/A==
=CY1J
-----END PGP SIGNATURE-----

--eqp4TxRxnD4KrmFZ--
