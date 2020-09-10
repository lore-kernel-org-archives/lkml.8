Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB080C2D0A7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58275206A1
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 21:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599772230;
	bh=g4XA0OhZdTxYHsjGUoM4EODYDVaBXCCLgN8ikHiReSE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=PK0cWd/Z1qShH7ISBOiFJxg7dowdqSJ5vFAny9iu9yHXa6oFBSnEUBNluV/XtI4JI
	 WY9vTAGJZ7MWPWAxOm+rVTTUY4IzbgDYgFMKkbV6IlaLbAJuokUgwJ6QX2MPGA5Erj
	 yEBKOcZ9p294D3pUFrcd58SB9+Xv5E1VEgc+EWSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgIJVK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:10:27 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:56145 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgIJOex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:34:53 -0400
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 08AEYdgG016269
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 23:34:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 08AEYdgG016269
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599748480;
        bh=sRzKztLNYO9dVkooKp3ATkjmauOzjgVG2OeZtQ33KmE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=h+ZfW4R2E7GlVJvBXsfaLsAoG03hssdcPru3bjK+VsTNORsAFrILbDvsBz7VUC11S
         Ln+tAukmipUzcWGlZn2i6V4MkR/XNR9IyyunUotmyS8H1jep+vzepji+3kWADzrajn
         v7/8CUrI2tqezY1St+GCcJzq5SnwcFklqPCSojqcTskxfawXbiBhHoNsnHOq61vULO
         iR/DnLDfviFB2YJqpT9duAfSBgL8YBLvt3BOz860l/uI0oqoll/IQIhjzcJXbF2oXe
         04G2Fa+jJamApEbrjIprOXRW93RU7oQwbHk8tF/U9fkLdujFk8k8Br6PCgmkmkfYE/
         4Hw3usw2+5zMA==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id bh1so1009613plb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:34:39 -0700 (PDT)
X-Gm-Message-State: AOAM533YmHht3gv3U3Zyv6SGsSTlPsMslIwQ0EigAhbRyCKOeWW5KeZz
        ThTdAz4QwpL8ovLShQ8IDG47U06lcVE14Wj10Tk=
X-Google-Smtp-Source: ABdhPJw7e5OMq90ugQRkmYXK0HqYljmS43OHOyJIx8xvojK9zEk4Wyk9oDQKXJ9vjnQgz53soIJqwDSsBOEPtFXqpEc=
X-Received: by 2002:a17:90b:1211:: with SMTP id gl17mr219548pjb.87.1599748479069;
 Thu, 10 Sep 2020 07:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 10 Sep 2020 23:34:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
Message-ID: <CAK7LNARE6NpCYAd7=--m-oO8_LweBWhP2aWfSRdTz=TX8dM5rw@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more reliable
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 8:57 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> When building for an embedded target using Yocto, we're sometimes
> observing that the version string that gets built into vmlinux (and
> thus what uname -a reports) differs from the path under /lib/modules/
> where modules get installed in the rootfs, but only in the length of
> the -gabc123def suffix. Hence modprobe always fails.
>
> The problem is that Yocto has the concept of "sstate" (shared state),
> which allows different developers/buildbots/etc. to share build
> artifacts, based on a hash of all the metadata that went into building
> that artifact - and that metadata includes all dependencies (e.g. the
> compiler used etc.). That normally works quite well; usually a clean
> build (without using any sstate cache) done by one developer ends up
> being binary identical to a build done on another host. However, one
> thing that can cause two developers to end up with different builds
> [and thus make one's vmlinux package incompatible with the other's
> kernel-dev package], which is not captured by the metadata hashing, is
> this `git describe`: The output of that can be affected by
>
> (1) git version: before 2.11 git defaulted to a minimum of 7, since
> 2.11 (git.git commit e6c587) the default is dynamic based on the
> number of objects in the repo
> (2) hence even if both run the same git version, the output can differ
> based on how many remotes are being tracked (or just lots of local
> development branches or plain old garbage)
> (3) and of course somebody could have a core.abbrev config setting in
> ~/.gitconfig
>
> So in order to avoid `uname -a` output relying on such random details
> of the build environment which are rather hard to ensure are
> consistent between developers and buildbots, use an explicit
> --abbrev=15 option (and for consistency, also use rev-parse --short=15
> for the unlikely case of no signed tags being usable).
>
> Now, why is 60 bits enough for everyone? It's not mathematically
> guaranteed that git won't have to use 16 in some git repo, but it is
> beyond unlikely: Even in a repo with 100M objects, the probability
> that any given commit (i.e. the one being described) clashes with some
> other object in the first 15 hex chars is less than 1e-10, and
> currently a git repo tracking Linus', -stable and -rt only has around
> 10M objects.


I agree that any randomness should be avoided.

My question is, do we need 15-digits?


The kernelrelease is formed by
[kernel version] + [some digits of git hash].


For example, "git describe" shows as follows:

v5.9.0-rc4-00034-g7fe10096c150


Linus gives a new tag every week (or every two week).


So, I think the conflict happens
only when we have two commits that start with the same 7-digits
in the _same_ release. Is this correct?

We have 14000 - 15000 commits in each release,
not 100M.





>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> I could probably fix things by adding a 'git config --local
> core.abbrev 15' step to the Yocto build process after the repo to
> build from has been cloned but before building has started. But in the
> interest of binary reproducibility outside of just Yocto builds, I
> think it's better if this lives in the kernel.
>
>  scripts/setlocalversion | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 20f2efd57b11..c5262f0d953d 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -45,7 +45,7 @@ scm_version()
>
>         # Check for git and a git repo.
>         if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
> -          head=$(git rev-parse --verify --short HEAD 2>/dev/null); then
> +          head=$(git rev-parse --verify --short=15 HEAD 2>/dev/null); then
>
>                 # If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
>                 # it, because this version is defined in the top level Makefile.
> @@ -59,7 +59,7 @@ scm_version()
>                         fi
>                         # If we are past a tagged commit (like
>                         # "v2.6.30-rc5-302-g72357d5"), we pretty print it.
> -                       if atag="$(git describe 2>/dev/null)"; then
> +                       if atag="$(git describe --abbrev=15 2>/dev/null)"; then
>                                 echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
>
>                         # If we don't have a tag at all we print -g{commitish}.
> --
> 2.23.0
>


-- 
Best Regards
Masahiro Yamada
