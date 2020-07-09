Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD199C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDC2207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594311239;
	bh=nTexoKEy5GLJOg8vAoAgb+Bs+0ul8c1mEWXYw5RR9Mw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XEKn6zVfqkgNJmdDrPvVLkadXXh9RCzQQX6pFX/31F/jFmOToFt4+t8JQ2ZWPjYKA
	 V7+Fqlrvg0paGLdWAC7b5x3qpuKVcmTXGhyl3Uc4ptMUZMy2KCb3LNPX/OlOGr6pMY
	 GZLIr0nlUmgduXc/aIN570rDvhvzNrLU+t51SBbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGIQN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:13:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726339AbgGIQN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:13:57 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D24022078B;
        Thu,  9 Jul 2020 16:13:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594311237;
        bh=nTexoKEy5GLJOg8vAoAgb+Bs+0ul8c1mEWXYw5RR9Mw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2bdq1FJx2Eny+0HsA2RDiWRYOkCzlQFE5NZ33A9DyDuVYMvmGYiQ3dFTXe4alkcdD
         gdTBcgvnn6F9ZwxgwgCqq1o85OtbZtlxfjCig7UClixChw6Ihhs4rHwMUEwWRsABHM
         ZXa4dNXY/V260Yw/NUmKvzN7O9jBnunwgGSb+BPM=
Date:   Thu, 9 Jul 2020 17:13:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Tibor Raschko <tibrasch@gmail.com>,
        ksummit-discuss@lists.linuxfoundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>, torvalds@linux-foundation.org
Subject: Re: [Tech-board-discuss] [Ksummit-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200709161351.GF4960@sirena.org.uk>
References: <79214066-3886-e0ef-f26e-8cb3d53404be@linuxfoundation.org>
 <e41ded21-1432-afa8-2e42-e509539281c4@gmail.com>
 <20200709124327.369781a0@coco.lan>
 <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b8GWCKCLzrXbuNet"
Content-Disposition: inline
In-Reply-To: <93fc3afb-8c3f-0fb9-3b92-adfb6571e060@linuxfoundation.org>
X-Cookie: You will be married within a year.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b8GWCKCLzrXbuNet
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 09, 2020 at 10:01:18AM -0600, Shuah Khan wrote:
> On 7/9/20 4:43 AM, Mauro Carvalho Chehab wrote:

> > For coherency, if "blacklist/whitelist" won't be used anymore, an
> > alternative to graylist should also be provided.

> What is "graylist"? Does it mean in between allow/deny?

Yes.  Typically it's used in situations where you don't want to deny
something but might for example want to do extra checks to verify that
things are OK.

--b8GWCKCLzrXbuNet
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl8HQj8ACgkQJNaLcl1U
h9DBcQf+K56Y9mlR9Dst9+GDWVZmoi7aO+Tnt+eblgju9NN9sKUNWzJ8YR8GA4vV
z6deFWJMWOruLvHFhLXOl4s8OZjnoifyGKvUKZkwNEa7ilfpO6A4ShhVgbeU5aqs
9kalbjk3lIzPqo9L8/qmH1xDyaRMlBeZXzYuc63cCOG3w1NmaQhcSjaBPuTVAF6h
oAIAt/TYlzDw8/Qaa1swsC3iN+cVIkt4cwLEO7+H6juOW/nOqJ0cOWASYDPrY/Gz
bGs48U/wFJoesyl2quo8XtyxAQNmvld4Pb0e1+mcrh3Lz3jitp8Jo+j7UwIXglTS
22KvCX3YVOLc6eQFGhe0Nd17DzHoyQ==
=M0gt
-----END PGP SIGNATURE-----

--b8GWCKCLzrXbuNet--
