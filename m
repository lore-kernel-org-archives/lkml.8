Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B94C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39EB92076C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VQZwUq3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIJOcf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 10:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731127AbgIJO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 10:29:09 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243D5C06179B
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:28:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id w16so6109241oia.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 07:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=inIFVMzh2cK+gIjB1/6vqch+0n+qm5nu5qiM5tL0M/o=;
        b=VQZwUq3LMO6SQzI5bj2Bxqai3S8LLAkeql3BGl5ZNdb+ICqjYu/F1MQEAjlZe8LbF8
         6eY1SC942QYJ0qqsWoqyaXFQtSVjY93Hq4MWI9yHAqu92uPFkhJA1BQSq6rYWuWmwObN
         sjGl4c4frsWrUGVnX17iM8ENNT2HRXEvVM9cev5oFrkzM+R6mkQsLvbZJDtUGzIHgKKg
         Ms4n8t6Fc7I/AOwIZu2FDlKJkEd6QJ12ZXvdW+lcV3wrBKiObIjXzlA42ALrlyuXCcKU
         4I05MbEuTMENQrcHA498Dp9JYZt43G4uropluoi4lXLvdXOi1F1DrmNcaUXlGRwPPgpu
         QY6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=inIFVMzh2cK+gIjB1/6vqch+0n+qm5nu5qiM5tL0M/o=;
        b=eOV6c5i9Ca/AU6y3QQCDeKbZlZVwqp2ZdO+GsggOqNjZ1KG4KZNcOEuCcDh0z2Scl1
         qKscpd3ax5sSr8i+6vY7jJGEXI4q+Tz+xVF2svxaFbHCaD1WvE1Zu/s23ySoDIYQq0nN
         jB0sTVsn9qMvWZln4a4r0x1L7SlyyKXGZH51xcghL4/RBaGsZjKPjnyt2EeFgQkmR+p7
         mfpKOsY87H99jdTvKjmN3Gq6z27qgB/Y/Nw3ZDeluMmpW1kIzc6uK2YlzMuJLBvLoe3s
         Ikf67Fhjj69shjPGrQVrxLegJ/VQF2oTnlYFG9cpWjIdL+b/qbygCpJhVQPQfD+zJhBq
         rK2Q==
X-Gm-Message-State: AOAM533w0WVwfEdVHlCTueGk+IGkrALVFnVufWZl7d1OjY22POt4NAGP
        8ujWoR26lIbgpX6aGgxwJexs0/3TXc4=
X-Google-Smtp-Source: ABdhPJyoQ7G3tNadZOpmO+uJuLJDMeMkkwshwsD1aDZwF3ucdJTLkGHhPyh9kQSCRPEfxZTIvdFC5w==
X-Received: by 2002:aca:b706:: with SMTP id h6mr176063oif.23.1599748107317;
        Thu, 10 Sep 2020 07:28:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q62sm925803ooa.12.2020.09.10.07.28.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 07:28:26 -0700 (PDT)
Subject: Re: [PATCH] scripts/setlocalversion: make git describe output more
 reliable
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <91104720-e389-a53d-37f6-1de4d665474f@roeck-us.net>
Date:   Thu, 10 Sep 2020 07:28:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 4:26 AM, Rasmus Villemoes wrote:
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
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Makes sense to me.

Acked-by: Guenter Roeck <linux@roeck-us.net>

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
>  	# Check for git and a git repo.
>  	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
> -	   head=$(git rev-parse --verify --short HEAD 2>/dev/null); then
> +	   head=$(git rev-parse --verify --short=15 HEAD 2>/dev/null); then
>  
>  		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
>  		# it, because this version is defined in the top level Makefile.
> @@ -59,7 +59,7 @@ scm_version()
>  			fi
>  			# If we are past a tagged commit (like
>  			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
> -			if atag="$(git describe 2>/dev/null)"; then
> +			if atag="$(git describe --abbrev=15 2>/dev/null)"; then
>  				echo "$atag" | awk -F- '{printf("-%05d-%s", $(NF-1),$(NF))}'
>  
>  			# If we don't have a tag at all we print -g{commitish}.
> 

