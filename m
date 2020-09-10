Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19959C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB286208FE
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 22:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rDv5FxI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725613AbgIJW43 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 18:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIJW41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 18:56:27 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF86C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:56:27 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t7so752541pjd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 15:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=wjWetvRZgh7oFO5ZvZ50cpoVotEHFUPyg+herVdhT5I=;
        b=rDv5FxI1rLlsn2DHtnid+W3UuQhqaobJZcYdlDry66JAHfDyHzoYkwF5PXPtJcbO8a
         EXyKG+QgS4rSmuGYnm+cObdPmTOY5XuY5cDkrTJXpkJCz0WcTEuz6KjF9Vt1CytrdrDL
         b1qwXWW1YUtUtnTTmBV5aTyYXiQ/ZuzdL4vPRtbjxyfeROuBP/ECZaR05rH2CNyMfVF+
         lTmk7berZ1fsvB+tkeXB80HD8vUXZVfpsJF9AhB2hNJeQCiVkmV05oIkhNM8nQWAqC71
         HmOax/Y1wseLy9rkFJZMkrZI/XWCSllpIYSKUy7Th2ex9qMo6/8jQ95vvio5+wM2iyZa
         H2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=wjWetvRZgh7oFO5ZvZ50cpoVotEHFUPyg+herVdhT5I=;
        b=eZwJkdmFBcSoO4vtC7z7piNQomAktKXBNU6MXov/LsvatmaGqEtTJiCw6dgC8LPbfX
         oJ8tSbua9RVFWRVtydFk/gJU0Plol49usqqJsHZO3okWfOgRofuKwR925VD3DinGmkrR
         tyYv6f1ci+j/ByYsoFKZjpct1QzOCh5nu2W0RP3Begaig07tlPGGLiH7L64o8NjhEUn9
         BWplws+ZbL3DDAOIr7GPAnWUJC0YOLy3NJWmvOJg4IsLwg0qlX2N/W8MDKTIFW89bq8Q
         fsxOZhA757neLWk2fcNhWEnht/tVQjN5r34nn1tJtuEPeY5EHQ4NjhnnP7mHkWXtZcDv
         OlZg==
X-Gm-Message-State: AOAM533vtLdIHp4A+fXh6atvlGc0SiKHPSLLCcujNgIztH6oW9nxZrZh
        DceCT3Upn8P0eV4UcSZj63fs0MisGm1HNEM0
X-Google-Smtp-Source: ABdhPJzCs8DJmkeALKv84koBEIn7uBccc8iFn3+Iv06h4oJFsgpJE9A3bpaskT7jDPz44+wuLqzgHQ==
X-Received: by 2002:a17:90a:a81:: with SMTP id 1mr2143030pjw.174.1599778586741;
        Thu, 10 Sep 2020 15:56:26 -0700 (PDT)
Received: from Gentoo (sau-ff5be-or.servercontrol.com.au. [43.250.207.3])
        by smtp.gmail.com with ESMTPSA id x20sm119790pfr.190.2020.09.10.15.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 15:56:25 -0700 (PDT)
Date:   Fri, 11 Sep 2020 04:26:15 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more
 reliable
Message-ID: <20200910225615.GA10714@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
Content-Disposition: inline
In-Reply-To: <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 23:34 Thu 10 Sep 2020, Masahiro Yamada wrote:
>On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
><linux@rasmusvillemoes.dk> wrote:
>>
>> When building for an embedded target using Yocto, we're sometimes
>> observing that the version string that gets built into vmlinux (and
>> thus what uname -a reports) differs from the path under /lib/modules/
>> where modules get installed in the rootfs, but only in the length of
>> the -gabc123def suffix. Hence modprobe always fails.
>>
>> The problem is that Yocto has the concept of "sstate" (shared state),
>> which allows different developers/buildbots/etc. to share build
>> artifacts, based on a hash of all the metadata that went into building
>> that artifact - and that metadata includes all dependencies (e.g. the
>> compiler used etc.). That normally works quite well; usually a clean
>> build (without using any sstate cache) done by one developer ends up
>> being binary identical to a build done on another host. However, one
>> thing that can cause two developers to end up with different builds
>> [and thus make one's vmlinux package incompatible with the other's
>> kernel-dev package], which is not captured by the metadata hashing, is
>> this `git describe`: The output of that can be affected by
>>
>> (1) git version: before 2.11 git defaulted to a minimum of 7, since
>> 2.11 (git.git commit e6c587) the default is dynamic based on the
>> number of objects in the repo
>> (2) hence even if both run the same git version, the output can differ
>> based on how many remotes are being tracked (or just lots of local
>> development branches or plain old garbage)
>> (3) and of course somebody could have a core.abbrev config setting in
>> ~/.gitconfig
>>
>> So in order to avoid `uname -a` output relying on such random details
>> of the build environment which are rather hard to ensure are
>> consistent between developers and buildbots, use an explicit
>> --abbrev=3D15 option (and for consistency, also use rev-parse --short=3D=
15
>> for the unlikely case of no signed tags being usable).
>>
>> Now, why is 60 bits enough for everyone? It's not mathematically
>> guaranteed that git won't have to use 16 in some git repo, but it is
>> beyond unlikely: Even in a repo with 100M objects, the probability
>> that any given commit (i.e. the one being described) clashes with some
>> other object in the first 15 hex chars is less than 1e-10, and
>> currently a git repo tracking Linus', -stable and -rt only has around
>> 10M objects.
>
>
>I agree that any randomness should be avoided.
>
>My question is, do we need 15-digits?
>
>
>The kernelrelease is formed by
>[kernel version] + [some digits of git hash].
>
>
>For example, "git describe" shows as follows:
>
>v5.9.0-rc4-00034-g7fe10096c150
>
>
>Linus gives a new tag every week (or every two week).
>
>
>So, I think the conflict happens
>only when we have two commits that start with the same 7-digits
>in the _same_ release. Is this correct?
>
>We have 14000 - 15000 commits in each release,
>not 100M.
>
>
  I kinda agree with this...we need to chopped down the excess bits from the
  information . =20

  Indeed , a 15 digits is too long  to keep up.

  ~Bhaskar
>
>
>>
>> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>> ---
>> I could probably fix things by adding a 'git config --local
>> core.abbrev 15' step to the Yocto build process after the repo to
>> build from has been cloned but before building has started. But in the
>> interest of binary reproducibility outside of just Yocto builds, I
>> think it's better if this lives in the kernel.
>>
>>  scripts/setlocalversion | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
>> index 20f2efd57b11..c5262f0d953d 100755
>> --- a/scripts/setlocalversion
>> +++ b/scripts/setlocalversion
>> @@ -45,7 +45,7 @@ scm_version()
>>
>>         # Check for git and a git repo.
>>         if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
>> -          head=3D$(git rev-parse --verify --short HEAD 2>/dev/null); th=
en
>> +          head=3D$(git rev-parse --verify --short=3D15 HEAD 2>/dev/null=
); then
>>
>>                 # If we are at a tagged commit (like "v2.6.30-rc6"), we =
ignore
>>                 # it, because this version is defined in the top level M=
akefile.
>> @@ -59,7 +59,7 @@ scm_version()
>>                         fi
>>                         # If we are past a tagged commit (like
>>                         # "v2.6.30-rc5-302-g72357d5"), we pretty print i=
t.
>> -                       if atag=3D"$(git describe 2>/dev/null)"; then
>> +                       if atag=3D"$(git describe --abbrev=3D15 2>/dev/n=
ull)"; then
>>                                 echo "$atag" | awk -F- '{printf("-%05d-%=
s", $(NF-1),$(NF))}'
>>
>>                         # If we don't have a tag at all we print -g{comm=
itish}.
>> --
>> 2.23.0
>>
>
>
>--=20
>Best Regards
>Masahiro Yamada

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9arwwACgkQsjqdtxFL
KRWb7ggA00FwNIUjGbuIMPwCaVLQVla/X2U6Jo6BltSt/dYbBhmk6cdKU/iVb6cm
3KBXCnmWxZplG5pYiipUrov+DTGYGFyfwq4O0uShHejsXbz7m9hsAL67W4dRdzys
M0iQNVBn4cW4CPiIg9hUzn4Bm78MGltInyouAJNl1PoKOXZIahDsdrx8jQO7r7A1
Tl4OFRir89kZS5LfJJOLwQMIRd64LKpdR2lk/0wOU4+dnJLaOYfNmmusl5hZ8bov
1ExfdcQSta0AMBJzbeJSYl+x2X5Lk16m54MYTFJatq8FTHcBbAK2IxPGc/NiAggh
bLUMDu8/BeuSoWfNg2tefT6Kr7EWfA==
=4X7I
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--
