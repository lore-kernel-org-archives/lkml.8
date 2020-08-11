Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE337C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D388A21744
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728959AbgHKP0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:26:30 -0400
Received: from shelob.surriel.com ([96.67.55.147]:51782 "EHLO
        shelob.surriel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728833AbgHKP03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:26:29 -0400
Received: from imladris.surriel.com ([96.67.55.152])
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <riel@shelob.surriel.com>)
        id 1k5WAP-0000L2-7E; Tue, 11 Aug 2020 11:26:21 -0400
Message-ID: <b3c828825cc62ce79d16a2f1a840279b01f33848.camel@surriel.com>
Subject: Re: [PATCH for 5.9 v2 1/4] futex: introduce FUTEX_SWAP operation
From:   Rik van Riel <riel@surriel.com>
To:     peterz@infradead.org, Peter Oskolkov <posk@posk.io>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>, Aaron Lu <aaron.lwe@gmail.com>
Date:   Tue, 11 Aug 2020 11:26:20 -0400
In-Reply-To: <20200804123147.GI2674@hirez.programming.kicks-ass.net>
References: <20200803221510.170674-1-posk@posk.io>
         <20200803221510.170674-2-posk@posk.io>
         <20200804123147.GI2674@hirez.programming.kicks-ass.net>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-RJsqJcckj6wQC4gZIoGP"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RJsqJcckj6wQC4gZIoGP
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2020-08-04 at 14:31 +0200, peterz@infradead.org wrote:
> On Mon, Aug 03, 2020 at 03:15:07PM -0700, Peter Oskolkov wrote:
> > A simplified/idealized use case: imagine a multi-user service
> > application
> > (e.g. a DBMS) that has to implement the following user CPU quota
> > policy:
>=20
> So the last posting made hackernews; and there a bunch expressed far
> more interest in coroutines, which, if I'm not mistaken, can also be
> implemented using all this.
>=20
> Would that not make for a far simpler and more convincing use-case?

Also just worker threads in general. Instead of waking up
an idle worker thread every time a new request comes in,
why not allow worker threads to indicate "I'm almost done",
and the main/receiving thread to enqueue the new request,
to be handled when the worker thread is done with the current
request?

> I really think we want to have block/resume detection sorted before
> this
> goes anywhere, I also strongly feel BPF should not be used for
> functional interfaces like that.
>=20
> That is, I want to see a complete interface before I want to commit
> to
> an ABI that we're stuck with.

The work case above also needs to have that figured out,
for the (slow path, but still common) case of the worker
thread actually having gone to sleep while the work got
enqueued, and then needing to be woken up anyway.

Not sure that is a direction you are interested in, given
the description, but it could make coroutines and worker
threads more efficient :)

--=20
All Rights Reversed.

--=-RJsqJcckj6wQC4gZIoGP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEKR73pCCtJ5Xj3yADznnekoTE3oMFAl8yuJwACgkQznnekoTE
3oNbgggAwBO/BAmj8n+qEFRTCkdwzHNl90lkqKNMQXHJC+tVuATC/SkdIeYwwxLq
df3aSMxGfNqO4dOg9qs3adNAHZL43ttZ01+SYppfyaIniebPHfOYU6ezYqdH7/Zt
6NTQHp237I890cfqcXhPJdJqt4OyR9m0hpKu7XCR9MbHtcNAiT1NYTIXEMrJuj/x
lLVndwUcFTtg4gwFsb7PnAiUn5dJeTcYgXxwXf4TvGCkgFlXP0M6+rJV/kM3pjWD
D5SLnzS8JNtVU5ASyFQlVxAzVev8Jxud36C7gqeQKA1WVXQktVAQqsTIeMXxeK1e
7bFNA8BEE5btQLrXUUfeufw6ofWz/g==
=KAJv
-----END PGP SIGNATURE-----

--=-RJsqJcckj6wQC4gZIoGP--

