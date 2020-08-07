Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0088C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEDB2075A
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgHGTmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:42:05 -0400
Received: from shelob.surriel.com ([96.67.55.147]:57250 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:42:05 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1k48Fa-0001C6-99; Fri, 07 Aug 2020 15:41:58 -0400
Message-ID: <9ed51691d4e129b5c30343a89a107d4ff9dd89ce.camel@surriel.com>
Subject: Re: CFS flat runqueue proposal fixes/update
From:   Rik van Riel <riel@surriel.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>,
        "vincent.guittot" <vincent.guittot@linaro.org>, kernel-team@fb.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggeman" <dietmar.eggeman@arm.com>
Date:   Fri, 07 Aug 2020 15:41:57 -0400
In-Reply-To: <1eaeeb1d-96c7-4819-8e1e-8f190a650030@arm.com>
References: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
         <1eaeeb1d-96c7-4819-8e1e-8f190a650030@arm.com>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-5o37GL1is6EbjFxi3XMZ"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5o37GL1is6EbjFxi3XMZ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2020-08-07 at 16:14 +0200, Dietmar Eggemann wrote:
> On 31/07/2020 09:42, Rik van Riel wrote:
> >     Possible solution
> > ...
> I imagine that I can see what you want to achieve here ;-)
>=20
> But it's hard since your v5 RFC
> https://lkml.kernel.org/r/20190906191237.27006-1-riel@surriel.com is
> pretty old by now.

The v5 patches also do not implement this new idea, and
still suffer from the corner cases that Paul Turner
pointed out last year.

> Do you have a version of the patch-set against tip/sched/core? Quite
> a
> lot has changed (runnable load avg replaced by runnable avg, rq->load=20
> is
> gone, CFS load balance rework).

Not yet. We got a baby this spring, so I've been busy
with things like milk and diapers, instead of with
code.

I wanted to get this proposal out before Plumbers, so
we could at least talk about it, and maybe find flaws
with this idea before I spend weeks/months implementing it :)

> IMHO it would be extremely helpful to have a current patch-set to
> discuss how these other problems can be covered by patches on top.

Agreed. I hope to get some time to work on that, but
no guarantees about getting it ready before Plumbers :)

--=20
All Rights Reversed.

--=-5o37GL1is6EbjFxi3XMZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl8troUACgkQznnekoTE
3oMeYAgAoMKreC/fhuo73dZvdb+q53y8WBAwJ7e5rrlrLA5Bib6Cg1rZbTjS4lXM
qMI+24OjQxj+J/wOfhlKxH9/HRxmCk/8sCv8SHKEnnhbJudiCEfuf7UPLMUT/r2F
myL1BOlM/cjE+D5lKzq+6CDDGlFOMauiHNteSkX70nBNgm6kwXQOLDdCZFE0n3ej
CI0zijJ3KLDZC8uV/1LT625IfTwy1YuwjY9xDU5gIrkE2CkgPLEvA5qLQzuvq82f
rUD4JUxR2CKV/4czEbJZmXb5uMfEKE7172XRTAKkpHjT1CIozoyc9P+DphQatThr
wkcue/ZRoPzxmQY37jRA4LPx7A9JFQ==
=mLBW
-----END PGP SIGNATURE-----

--=-5o37GL1is6EbjFxi3XMZ--

