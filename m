Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22586C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F160220874
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="c2mKFEGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbgERLhS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:37:18 -0400
Received: from ozlabs.org ([203.11.71.1]:58779 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgERLhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:37:17 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49QcS93j2Jz9sTC;
        Mon, 18 May 2020 21:37:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1589801835;
        bh=sVwnIBZtE1XIU+cSVfb2AfLRaR5qbpYzuQwbYj/q+m0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=c2mKFEGd8gslESqqwyOhLqXMUh1eHhIqYtyIVao0KterI88UjafJ4vhk7YLcftmkE
         l/ebSBzr+IGn3Gg2bWU/4jX8nwYGdbRLjLZe0AyMQGT83o0J5GVTbHTSiN6ORWijcV
         iRJj78qVj1nnHPNiqYkHqniyOg5cqG1aIrrwLXJJycCaF3AFQCd/ypHTYp8vXSh+7l
         YdqArB4aSFZVZPLbUaHV+7iP/Td0Z5wJQxukfEwezPiUh5OIIUfdPfmKslafDJW7bR
         AzLYDJFulCwRUubVjFb4mmd4V6D6gse8kgdnv3eL8yFJNzQ4Z4haIHeo6S85v7OnGr
         UMA3Br6o/ybWw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     WANG Wenhu <wenhu.wang@vivo.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        wenhu.pku@gmail.com
Subject: Re: [PATCH] powerpc/sysdev: fix compile errors
In-Reply-To: <nycvar.YFH.7.76.2005181232140.25812@cbobk.fhfr.pm>
References: <20200302053801.26027-1-wenhu.wang@vivo.com> <62251ec1-dd42-6522-dcb2-613838cd5504@c-s.fr> <nycvar.YFH.7.76.2005181228480.25812@cbobk.fhfr.pm> <nycvar.YFH.7.76.2005181232140.25812@cbobk.fhfr.pm>
Date:   Mon, 18 May 2020 21:37:33 +1000
Message-ID: <878shpa2yq.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Kosina <jikos@kernel.org> writes:
> On Mon, 18 May 2020, Jiri Kosina wrote:
>> > > Include linux/io.h into fsl_85xx_cache_sram.c to fix the
>> > > implicit-declaration compile errors when building Cache-Sram.
>> > >=20
>> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c: In function
>> > > =E2=80=98instantiate_cache_sram=E2=80=99:
>> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:26: error: implicit dec=
laration
>> > > of function =E2=80=98ioremap_coherent=E2=80=99; did you mean =E2=80=
=98bitmap_complement=E2=80=99?
>> > > [-Werror=3Dimplicit-function-declaration]
>> > >    cache_sram->base_virt =3D ioremap_coherent(cache_sram->base_phys,
>> > >                            ^~~~~~~~~~~~~~~~
>> > >                            bitmap_complement
>> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:97:24: error: assignment m=
akes
>> > > pointer from integer without a cast [-Werror=3Dint-conversion]
>> > >    cache_sram->base_virt =3D ioremap_coherent(cache_sram->base_phys,
>> > >                          ^
>> > > arch/powerpc/sysdev/fsl_85xx_cache_sram.c:123:2: error: implicit dec=
laration
>> > > of function =E2=80=98iounmap=E2=80=99; did you mean =E2=80=98roundup=
=E2=80=99?
>> > > [-Werror=3Dimplicit-function-declaration]
>> > >    iounmap(cache_sram->base_virt);
>> > >    ^~~~~~~
>> > >    roundup
>> > > cc1: all warnings being treated as errors
>> > >=20
>> > > Fixed: commit 6db92cc9d07d ("powerpc/85xx: add cache-sram support")
>> > > Signed-off-by: WANG Wenhu <wenhu.wang@vivo.com>
>> >=20
>> > Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>=20
>> As this doesn't seem to have been picked up for linux-next yet, I am=20
>> picking it up now.
>
> Only now I've noticed that this is actually a dead code o_O as this file=
=20
> can't be built by any combination of config options. So I am dropping the=
=20
> patch again, but why do we keep it in the tree in the first place?

Yeah, sigh.

As Christophe pointed out, it has been dead code for a long time but
there is a series in flight that's trying to make it usable.

cheers
