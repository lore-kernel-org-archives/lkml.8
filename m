Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E3F206B5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 08:21:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgHGIVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 04:21:41 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:56346 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbgHGIVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 04:21:41 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9A4DD1C0BD9; Fri,  7 Aug 2020 10:21:38 +0200 (CEST)
Date:   Fri, 7 Aug 2020 10:21:38 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Denis Osterland-Heim <denis.osterland@diehl.com>
Cc:     "dmurphy@ti.com" <dmurphy@ti.com>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v7 1/3] leds: move default_state read from fwnode to core
Message-ID: <20200807082138.6y4sumchphjb6elw@duo.ucw.cz>
References: <20200731164945.19515-1-Denis.Osterland@diehl.com>
 <20200731164945.19515-2-Denis.Osterland@diehl.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="mt2cj253mqgb5vz4"
Content-Disposition: inline
In-Reply-To: <20200731164945.19515-2-Denis.Osterland@diehl.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mt2cj253mqgb5vz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Signed-off-by: Denis Osterland-Heim <Denis.Osterland@diehl.com>

This tells me you:

1) you are probably not copyright owner

2) you want your company to promise not to sue people, in a legally
binding way.

> The contents of the above mentioned e-mail is not legally
>  binding. This e-mail contains confidential and/or legally protected
>  information. Please inform us if you have received this e-mail by

This tells me:

1) your company and/or lawyers are not ... people I'd like to meet

2) you can not make promises for your company.

Please talk to your legal department and / or make someone who _can_
make promises submit the patch.

Best regards,

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--mt2cj253mqgb5vz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCXy0PEgAKCRAw5/Bqldv6
8oLqAJ9I763m3DLrubBReUSP2UxpcD84NACfR65GCIxR9sMl3RHNzipfo32YkT0=
=fNIR
-----END PGP SIGNATURE-----

--mt2cj253mqgb5vz4--
