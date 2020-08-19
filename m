Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A6CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3208207DE
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 19:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597866041;
	bh=4AK5v821zy1PWvts/5ogFBjV+oVDZUgiOW/Z26HFexU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Wdk8uTD5FT4rs56FnsqC2VGYW7yFRF60+uE98j/AmAWai0JnHgakpfMPHIrEu5nfY
	 gHrJx7ezTdInm9k1G/rUeqPFH1vZDGfWS7oyR3zw1xnjYRRNVqSDU5nQu2Z053YOw+
	 ql3ATplYg2N+jtX1pW+1LGp4h4Er/+EruuMvvsXg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgHSTkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 15:40:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbgHSTki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:40:38 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F545207BB;
        Wed, 19 Aug 2020 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597866038;
        bh=4AK5v821zy1PWvts/5ogFBjV+oVDZUgiOW/Z26HFexU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ua92POSnqY57JylYmFlW/zoes2kP0GYGQbu4I2NNqI7oKhrS+kId6nciud6UtU/53
         xxjtEqyOGHXub4q0MJZENkMJiLMST98/X3qRGgvZaSsOkDwX/+1iT3sCek7q/zCe9/
         6H3LuAli7CzlhN/nPXo39fhV7mSt1VLrJDKdV/2k=
Date:   Wed, 19 Aug 2020 20:40:05 +0100
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
Message-ID: <20200819194005.GC38371@sirena.org.uk>
References: <1597644455-8216-1-git-send-email-jiaxin.yu@mediatek.com>
 <1597644455-8216-3-git-send-email-jiaxin.yu@mediatek.com>
 <CA+Px+wXSbGLb+AZnF8ETRycRUVjqk4xacm5DH6MzuMw0vh6Wzg@mail.gmail.com>
 <CA+Px+wUMXoSL6w0wBduE7obJRWgCteeT8=_=U=8LR34JKTTGZA@mail.gmail.com>
 <20200819103730.GB5441@sirena.org.uk>
 <CA+Px+wUV89KO8JJd3+HpOrgFRSc7sdg-DBW44C31262Qx9NzVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="V88s5gaDVPzZ0KCq"
Content-Disposition: inline
In-Reply-To: <CA+Px+wUV89KO8JJd3+HpOrgFRSc7sdg-DBW44C31262Qx9NzVg@mail.gmail.com>
X-Cookie: Absence makes the heart grow frantic.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--V88s5gaDVPzZ0KCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 19, 2020 at 11:42:27PM +0800, Tzung-Bi Shih wrote:

> But I found struct mfd_cell also contains member .of_compatible.  What
> is the difference if we use compatible string (as is) for this device
> instead of falling back to use device name to match?

That's for binding the MFD subdevice to an OF node, you don't need to do
that for a device like this - you can just use the of_node of the parent
to get at the properties.

--V88s5gaDVPzZ0KCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl89gBUACgkQJNaLcl1U
h9D/+gf/Ux+96dRrUQezVV+5UF/r90Gm5dpzj3qN3D3o9ZNOhCUt2+i9Js4F/YDL
LL4dlrRI1Yg/CpFwunLwTiy3q2xYqUIFODQq/u2fkSDyejrXkt6R3NqxlaG5Jc0K
EpOxKm07grdw9WOWls6UmbeJLTL8jHp2KWUqGL5t2KiVLPAaxXvCOzI5MugAp3W1
B80S4jndViv3IEGEgKqvuS8PxVxmXuNe1gVH6arMvmDmK2NQWEIpit4dpWiuT7UY
EbAJsnABzE8jasbBRLHt5F7VRdU004CyjtsoZswk9b+otbSwvW82CRUQ8oD7t83+
VQcrX/wlkN3yNdkNF4CwrbBmV9d7sA==
=eiwO
-----END PGP SIGNATURE-----

--V88s5gaDVPzZ0KCq--
