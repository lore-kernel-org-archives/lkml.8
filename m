Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D9C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F07752186A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 09:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="nQOE4vPY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3Jja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 05:39:30 -0400
Received: from ozlabs.org ([203.11.71.1]:60127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726396AbgD3Jj3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 05:39:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49CVhL1mfPz9sPF;
        Thu, 30 Apr 2020 19:39:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1588239567;
        bh=+q3qK7ThA6S0SUMv93CvqoJgpSGdg5tNFF2TPvf35hI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nQOE4vPYnSb9Gz4jmhcJfj+a1yh87FOuKiuzmd4oxYn5IhsI/Dnpwzmq52qQW0pQf
         M0tApzyZI9uxTdAiPF4s0Nkcmvsx1nkje8SKC9VWyRlEJIRIX73CXIJEF4ai+ol2DI
         zjGTMwOLdpx2CnZhmjov0yXsGp5XA5MkdfXI+vDu21NiH3qaAKsho+OsYLhyDQuPyb
         oOyc6EHycC/flK5ft9w6rIq/dmjl65Ag+k1HTd5JfXzHzqtobx0BmmMKwqCk3977qq
         93M3QGH4Y94A9KzFtlczuY8Tg4jfonKEvSz3r0vaMgH4N7dojOCJC3EIRX7AZLVqeW
         5SR7cffZTwIrQ==
Date:   Thu, 30 Apr 2020 19:39:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Brian Cain <bcain@codeaurora.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guan Xuetao <gxt@pku.edu.cn>,
        James Morse <james.morse@arm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: kvm: fix gcc-10 shift warning
Message-ID: <20200430193910.294842c4@canb.auug.org.au>
In-Reply-To: <20200430082927.GA18615@willie-the-truck>
References: <20200429185657.4085975-1-arnd@arndb.de>
        <20200430090251.715f6bf0@why>
        <20200430082927.GA18615@willie-the-truck>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xzv.XEbMG=15e_LStDYa1s9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xzv.XEbMG=15e_LStDYa1s9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Will,

On Thu, 30 Apr 2020 09:29:28 +0100 Will Deacon <will@kernel.org> wrote:
>
> On Thu, Apr 30, 2020 at 09:02:51AM +0100, Marc Zyngier wrote:
> > On Wed, 29 Apr 2020 20:56:20 +0200
> > Arnd Bergmann <arnd@arndb.de> wrote:
> >  =20
> > > Fixes: 22998131ab33 ("arm64: add support for folded p4d page tables")
>=20
> Happy to queue via arm64 for 5.8. Does that work for you, Arnd, or were y=
ou
> planning to get this in sooner than that?

The commit that this fixes is in Andrew's patch series in linux-next,
so it should just go in there.

--=20
Cheers,
Stephen Rothwell

--Sig_/xzv.XEbMG=15e_LStDYa1s9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl6qnL4ACgkQAVBC80lX
0GzToAf/bXREqbiltcjG5hxNdpU1I4moIKv6bFtCjrnCW5muA2pCR3xx5Twzm5UG
Mw36RWbLqcQwOOcH9RtlCFe0zq1DEgPvShaF1lTh8n5dybdjKbCzSFsP6uoSZ/1i
rcT/rZ1GC/9zCOvI8MUYb748fIMdC5zeZOGpTPzYL8HPV4+65nY3+OMT8+0IS2JS
kJACY35PygG1QnWjF7JmwfBnAGe3M3jJ2OJe1IiF8lR6max8qziACp5cGHxAMq3B
d+XyW62Jfft6iGyz4+RAslfELwJXtLqgnJPy3NoJDy3eSghTCCh43mjuRctsVctk
7aYaVXRjxdDyfLBn013vvyPbIibusQ==
=6Ce6
-----END PGP SIGNATURE-----

--Sig_/xzv.XEbMG=15e_LStDYa1s9--
