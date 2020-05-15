Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03D4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7135820671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 19:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgEOTff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 15:35:35 -0400
Received: from shelob.surriel.com ([96.67.55.147]:34770 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgEOTff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 15:35:35 -0400
X-Greylist: delayed 659 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 May 2020 15:35:34 EDT
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <riel@shelob.surriel.com>)
        id 1jZfwa-0001zw-Gb; Fri, 15 May 2020 15:24:28 -0400
Message-ID: <3b217554a8a337de544482d20ddf8f2152559cd3.camel@surriel.com>
Subject: Re: Possibility of conflicting memory types in lazier TLB mode?
From:   Rik van Riel <riel@surriel.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Date:   Fri, 15 May 2020 15:24:28 -0400
In-Reply-To: <1589523957.s4pf3vd48l.astroid@bobo.none>
References: <1589523957.s4pf3vd48l.astroid@bobo.none>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-h/QtW0ir0IujPC4jw789"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-h/QtW0ir0IujPC4jw789
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-05-15 at 16:50 +1000, Nicholas Piggin wrote:
>=20
> But what about if there are (real, not speculative) stores in the
> store=20
> queue still on the lazy thread from when it was switched, that have
> not=20
> yet become coherent? The page is freed by another CPU and reallocated
> for something that maps it as nocache. Do you have a coherency
> problem=20
> there?
>=20
> Ensuring the store queue is drained when switching to lazy seems like
> it=20
> would fix it, maybe context switch code does that already or you
> have=20
> some other trick or reason it's not a problem. Am I way off base
> here?

On x86, all stores become visible in-order globally.

I suspect that
means any pending stores in the queue
would become visible to the rest of the system before
the store to the "current" cpu-local variable, as
well as other writes from the context switch code
become visible to the rest of the system.

Is that too naive a way of preventing the scenario you
describe?

What am I overlooking?

--=20
All Rights Reversed.

--=-h/QtW0ir0IujPC4jw789
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl6+7GwACgkQznnekoTE
3oNMXAgAvb6XjIAElzfwfI3CkGDhKm7MZHEfyiz8fA44HCh9IugCpFM7MGi3Kv+f
jwDnHLGvnsPXmZt5HzAaZ/73Amcgb491ls0URndjMSgg/5SoxoanUFXQfQeE/4P2
4ifT71HJhMNms9788VZBpvLC3+qqCVOOPH/sczt7ttc64sFaGi4r9XOQNdGHeKSM
EcaPJs9ZVcCMZOb86sqmN40UXJZSmtdObqLeT/TFKacKHDpA3wJ4GLyz5GvgE0v0
AjoxxHjMgbgok8b/tBEqN8I45izKESKp6b5qU+KfZ4yn9cRRaf+FpU7pirntPIp5
cQzugqEN+ZzlPjfcIAWQJPgd1EJO2g==
=y0CW
-----END PGP SIGNATURE-----

--=-h/QtW0ir0IujPC4jw789--

