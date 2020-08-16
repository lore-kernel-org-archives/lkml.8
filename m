Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAC0C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FA820829
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729717AbgHPT7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:59:34 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:33412 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbgHPT7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:59:33 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4D4C71C0BB6; Sun, 16 Aug 2020 21:59:31 +0200 (CEST)
Date:   Sun, 16 Aug 2020 21:59:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Popov <alex.popov@linux.com>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, Will Deacon <will@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Laura Abbott <labbott@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org,
        notify@kernel.org
Subject: Re: [PATCH RFC 1/2] mm: Extract SLAB_QUARANTINE from KASAN
Message-ID: <20200816195930.GA4155@amd>
References: <20200813151922.1093791-1-alex.popov@linux.com>
 <20200813151922.1093791-2-alex.popov@linux.com>
 <20200815185455.GB17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Content-Disposition: inline
In-Reply-To: <20200815185455.GB17456@casper.infradead.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2020-08-15 19:54:55, Matthew Wilcox wrote:
> On Thu, Aug 13, 2020 at 06:19:21PM +0300, Alexander Popov wrote:
> > +config SLAB_QUARANTINE
> > +	bool "Enable slab freelist quarantine"
> > +	depends on !KASAN && (SLAB || SLUB)
> > +	help
> > +	  Enable slab freelist quarantine to break heap spraying technique
> > +	  used for exploiting use-after-free vulnerabilities in the kernel
> > +	  code. If this feature is enabled, freed allocations are stored
> > +	  in the quarantine and can't be instantly reallocated and
> > +	  overwritten by the exploit performing heap spraying.
> > +	  This feature is a part of KASAN functionality.
>=20
> After this patch, it isn't part of KASAN any more ;-)
>=20
> The way this is written is a bit too low level.  Let's write it in terms
> that people who don't know the guts of the slab allocator or security
> terminology can understand:
>=20
> 	  Delay reuse of freed slab objects.  This makes some security
> 	  exploits harder to execute.  It reduces performance slightly
> 	  as objects will be cache cold by the time they are reallocated,
> 	  and it costs a small amount of memory.

Written this way, it invites questions:

Does it introduce any new deadlocks in near out-of-memory situations?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl85kCIACgkQMOfwapXb+vLxYwCfbn811vr0Zj6oofab9u8xfms5
WYIAnjboCM2RGhT/UoknoFiLV5GpOKEC
=c5uZ
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
