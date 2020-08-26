Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ECCAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7917020767
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 07:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHZH0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 03:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgHZH0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 03:26:44 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92368C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 00:26:44 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Bby8v6xKmzKmMG;
        Wed, 26 Aug 2020 09:26:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id ZH8t6mGKXNM0; Wed, 26 Aug 2020 09:26:35 +0200 (CEST)
Date:   Wed, 26 Aug 2020 17:26:26 +1000
From:   Aleksa Sarai <cyphar@cyphar.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] MAINTAINERS: add namespace entry
Message-ID: <20200826072626.4z2oeocrf3gnqsu2@yavin.dot.cyphar.com>
References: <20200825154148.1219500-1-christian.brauner@ubuntu.com>
 <87zh6in140.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2zhs6rixenugheyi"
Content-Disposition: inline
In-Reply-To: <87zh6in140.fsf@x220.int.ebiederm.org>
X-MBO-SPAM-Probability: 
X-Rspamd-Score: -6.33 / 15.00 / 15.00
X-Rspamd-Queue-Id: 755A2178D
X-Rspamd-UID: 673d90
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2zhs6rixenugheyi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2020-08-25, Eric W. Biederman <ebiederm@xmission.com> wrote:
> C) You have overstated what I have agreed to here.
>    I have have previously said that I agree that having a MAINTAINERS
>    entry so people who are unfamiliar with the situation with namespaces
>    can find us.  Given that most of the changes going forward are likely
>    to be maintenance changes.
>=20
>    I also said we need to talk about how we plan to maintain the code
>    here.
>=20
>    It feels like you are pushing this hard, and I am not certain why you
>    are pushing and rushing this.  With my maintainer hat on my big
>    concern is we catch the issues that will introduce security issue.
>    Recently I have seen a report that there is an issue on Ubuntu
>    kernels where anyone can read /etc/shadow.  The problem is that
>    Ubuntu has not been cautions and has not taken the time to figure out
>    how to enable things for unprivileged users safely, and have just
>    enabled the code to be used by unprivileged users because it is
>    useful.
>=20
>    In combination with you pushing hard and not taking the time to
>    complete this conversation in private with me, this MAINTAINERS entry
>    makes me uneasy as it feels like you may be looking for a way to push
>    the code into the mainline kernel like has been pushed into the
>    Ubuntu kernel.  I may be completely wrong I just don't know what to
>    make of your not finishing our conversation in private, and forcing
>    my hand by posting this patch publicly.

Eric, with all due respect, Christian is not a sleeper agent of some
shadow Ubuntu kernel team that is tirelessly trying to slip things by
you. I have no idea where you could have possibly gotten this
impression, given his track record of the past few years.

I also don't understand why you feel the need to talk about things which
he had nothing to do with -- what relationship does the /etc/shadow
thing have to do with his work and track record? Were Debian kernel
contributors considered untrustworthy because of the OpenSSL weak keys
issue? Would it be fair to question your competence because some RHEL
kernel backports were borked? Of course not -- that would be ridiculous!

> At the same time I am not convinced you are actually going to do the
> work to make new code maintainable and not a problem for other kernel
> developers.
>=20
> A big part the job over the years has been to make the namespace ideas
> proposed sane, and to keep the burden from other maintainers of naive
> and terrible code.  Pushing this change before we finished our private
> conversation makes me very nervous on that front.

What gives you that impression? This whole thing seems incredibly
strange -- we've all met IRL several times, and have had many long
discussions about the best way to solve problems without placing undue
burden on kernel maintenance.

Furthermore, I don't think this is an acceptable way to talk about a
peer within the kernel community -- attributing malicious intent without
any justification other than "I feel this is the case" is little more
than a character assassination, and I don't see why you would feel that
such a statement is justified.

--=20
Aleksa Sarai
Senior Software Engineer (Containers)
SUSE Linux GmbH
<https://www.cyphar.com/>

--2zhs6rixenugheyi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSxZm6dtfE8gxLLfYqdlLljIbnQEgUCX0YOlAAKCRCdlLljIbnQ
EvEDAQCM9clLTLSL1Tif3v+irBiAH3elOxE9PsNIlY/QLCaZLQEAvQ5ezgAinRAP
/6RU/YaGh/xvZ6Adb0DZeJ5g+z9x/AA=
=b6WN
-----END PGP SIGNATURE-----

--2zhs6rixenugheyi--
