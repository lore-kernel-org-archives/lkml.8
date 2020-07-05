Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 989C0C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7588A20771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:41:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R/0LXiyo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgGEAlZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEAlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:41:25 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6EBC061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 17:41:24 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ch3so328476pjb.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 17:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QbFiXrrIEyvT0l7kEooCW9inKSOU3LfnxtOYU9+rKpc=;
        b=R/0LXiyon5iW32zpBoiBvUT6KZjGXecOrCxDzP+nM0LcJLi+ceqmCRIKPRPHPY9Bec
         rsjNzYGrAnIkaBjaQ6zzgbS3cPLzyHOxmMvBumK3hilOB8CzbpvyP58gcWPSfI8geS+B
         EolHNrrfZliq2q5diX+E+gBZFHLewCSv/sYWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QbFiXrrIEyvT0l7kEooCW9inKSOU3LfnxtOYU9+rKpc=;
        b=aggI4xchxYX9jBGnJsSEHF4I4iqIjF1CVJMGlE+2/bQtLS5IVKpwEb7YvUaPCUf+QL
         dvOjnLWqs9q76/d0Ew9qUKn+2qbKm11EJJ9Mq6GhY68C2neLtpk4oVTFQgI1NNzwZo16
         ohnJPChQO9tG7hARiUjlMlS3Dbhsj0wg9o3oD1e3utkywmWICxt22Kab5sVCYA68weqs
         +veiWI7o8ME1dTe+q6UQiXuSYS23T/XzmBk0rvXWhtmaHXIWMfE/5qcB6ZsJtJk9NVKM
         EFj3txoefcP4ZaJ2omzfU7i9QKHdvE3PQ7jkZ4YQSJEfvbHre9x570PBqv9FrHulOh2/
         CqGw==
X-Gm-Message-State: AOAM532FdEHgqo6sloMYvxBPVyAz6j4wis8AeJTp7qeNCPgKnuWthLSS
        1/u+zBA3DSnukVAbz1VZkWXhng==
X-Google-Smtp-Source: ABdhPJw+SIuINDri1NDMi5D0Z1z9ASnH5tdB1fzwC8CA2Ht8Fh8zrjBqQRln5he/ExMdVYRFb6O30w==
X-Received: by 2002:a17:90a:cf01:: with SMTP id h1mr45199854pju.234.1593909684251;
        Sat, 04 Jul 2020 17:41:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x22sm15623429pfr.11.2020.07.04.17.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 17:41:23 -0700 (PDT)
Date:   Sat, 4 Jul 2020 17:41:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     torvalds@linux-foundation.org, Jonathan Corbet <corbet@lwn.net>,
        Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CodingStyle: Inclusive Terminology
Message-ID: <202007041703.51F4059CA@keescook>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> Recent events have prompted a Linux position statement on inclusive
> terminology. Given that Linux maintains a coding-style and its own
> idiomatic set of terminology here is a proposal to answer the call to
> replace non-inclusive terminology.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Kees Cook <keescook@chromium.org>
> Signed-off-by: Chris Mason <clm@fb.clm>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

(nit: isn't this a Co-developed-by chain, not a SoB chain?)

Acked-by: Kees Cook <keescook@chromium.org>

Comments below...

> ---
>  Documentation/process/coding-style.rst          |   12 ++++
>  Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
>  Documentation/process/index.rst                 |    1 
>  3 files changed, 77 insertions(+)
>  create mode 100644 Documentation/process/inclusive-terminology.rst
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..4b15ab671089 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>  
> +For symbol names, avoid introducing new usage of the words 'slave' and
> +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> +'denylist'.

Keeping "master" in a "master/slave" pairing (i.e. replacing only
"slave") seems incomplete to me. If "master" is paired with "slave", it
should be replaced too. Potential examples: 'primary', 'leader', 'principle',
'controller', 'sender', 'initial'.

Similarly, for "whitelist/blacklist", "whitelist" needs to replaced when
"blacklist" has been. For example, seccomp documentation[1] uses
"allow-list" and "deny-list".

[1] https://man7.org/linux/man-pages/man2/seccomp.2.html

> +Exceptions for introducing new usage is to maintain a userspace ABI, or

and API?

> +when updating code for an existing (as of 2020) hardware or protocol
> +specification that mandates those terms. For new specifications consider
> +translating specification usage of the terminology to the kernel coding
> +standard where possible. See :ref:`process/inclusive-terminology.rst
> +<inclusiveterminology>` for details.

Let's add:

 Where possible, old instances of this language should be replaced when
 it is not tied to external specifications nor userspace ABI/API.

>  
>  5) Typedefs
>  -----------
> diff --git a/Documentation/process/inclusive-terminology.rst b/Documentation/process/inclusive-terminology.rst
> new file mode 100644
> index 000000000000..a8eb26690eb4
> --- /dev/null
> +++ b/Documentation/process/inclusive-terminology.rst
> @@ -0,0 +1,64 @@
> +.. _inclusiveterminology:
> +
> +Linux kernel inclusive terminology
> +==================================
> +
> +The Linux kernel is a global software project, and in 2020 there was a
> +global reckoning on race relations that caused many organizations to
> +re-evaluate their policies and practices relative to the inclusion of
> +people of African descent. This document describes why the 'Naming'
> +section in :ref:`process/coding-style.rst <codingstyle>` recommends
> +avoiding usage of 'slave' and 'blacklist' in new additions to the Linux
> +kernel.

... usage of 'master/slave', 'slave', 'whitelist/blacklist', and
'blacklist' in the Linux kernel.

> +
> +On the triviality of replacing words
> +====================================
> +
> +The African slave trade was a brutal system of human misery deployed at
> +global scale. Some word choice decisions in a modern software project
> +does next to nothing to compensate for that legacy. So why put any
> +effort into something so trivial in comparison? Because the goal is not
> +to repair, or erase the past. The goal is to maximize availability and
> +efficiency of the global developer community to participate in the Linux
> +kernel development process.
> +
> +Word choice and developer efficiency
> +====================================
> +
> +Why does any software project go through the trouble of developing a
> +document like :ref:`process/coding-style.rst <codingstyle>`? It does so
> +because a common coding style maximizes the efficiency of both
> +maintainers and developers. Developers learn common design patterns and
> +idiomatic expressions while maintainers can spot deviations from those
> +norms. Even non-compliant whitespace is considered a leading indicator
> +to deeper problems in a patchset. Coding style violations are known to
> +take a maintainer "out of the zone" of reviewing code. Maintainers are
> +also sensitive to word choice across specifications and often choose to
> +deploy Linux terminology to replace non-idiomatic word-choice in a
> +specification.
> +
> +Non-inclusive terminology has that same distracting effect which is why
> +it is a style issue for Linux, it injures developer efficiency.
> +
> +Of course it is around this point someone jumps in with an etymological
> +argument about why people should not be offended. Etymological arguments
> +do not scale. The scope and pace of Linux to reach new developers
> +exceeds the ability of historical terminology defenders to describe "no,
> +not that connotation". The revelation of 2020 was that black voices were
> +heard on a global scale and the Linux kernel project has done its small
> +part to answer that call as it wants black voices, among all voices, in
> +its developer community.
> +
> +Really, 'blacklist' too?
> +========================
> +
> +While 'slave' has a direct connection to human suffering the etymology
> +of 'blacklist' is devoid of a historical racial connection. However, one
> +thought exercise is to consider replacing 'blacklist/whitelist' with
> +'redlist/greenlist'. Realize that the replacement only makes sense if
> +you have been socialized with the concepts that 'red/green' implies
> +'stop/go'. Colors to represent a policy requires an indirection. The
> +socialization of 'black/white' to have the connotation of
> +'impermissible/permissible' does not support inclusion.
> +
> +Inclusion == global developer community efficiency.

Let's add:

 Beyond just Linux
 =================

 For those of us in the kernel community involved in specification
 development or similar larger ecosystem conversations, please help
 steer those discussions to avoid these terms in new specifications
 or APIs.


> diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
> index f07c9250c3ac..ed861f6f8d25 100644
> --- a/Documentation/process/index.rst
> +++ b/Documentation/process/index.rst
> @@ -27,6 +27,7 @@ Below are the essential guides that every developer should read.
>     submitting-patches
>     programming-language
>     coding-style
> +   inclusive-terminology
>     maintainer-pgp-guide
>     email-clients
>     kernel-enforcement-statement
> 

-- 
Kees Cook
