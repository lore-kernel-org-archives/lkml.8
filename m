Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1ACC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE99207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592509725;
	bh=2WbucPymt+u2OYToSgRJLcWsjqsg4OQUL7wnpsVWJKM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nPUteJM8pUbjvMnuu7mVE0m4kPA7vOtZiHD3BfSwEbHnKA7ZU0+YH1dzzH1oXQ2/N
	 /JhuvA9f9yI6Ya8Lg3jwIMvqkkVD5ldbZ1Ynbh3DwY6QqcPaxIczeGjMgi3dUyqrw/
	 ablKbKyZiiOGD5S64bfmZyHL+6f9/ggLjtiAdptQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729311AbgFRTso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbgFRTsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:48:42 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F154AC0613ED
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:48:41 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id o4so4203517lfi.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zAj23S3Mp6rRGO4SN+Gp5C3WPkcIYgiIEGIXxkjYIf0=;
        b=O8vGhvfOfOq9wLj1E8rP/VwqEBx1zwNPyHW+trZ6ABPefealuQSSUilZwTmE1SLwx3
         zEwIy5hJ4gIay72KjTq2B1QzBGNJ+P/4jwxTdP42XjdJJEBlYBl/eBUwneIpV2J18exN
         a/r+v/+JeACo1IVMd6iMfbPGsYHL+wiwfVYwk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zAj23S3Mp6rRGO4SN+Gp5C3WPkcIYgiIEGIXxkjYIf0=;
        b=gp8Yxu0FLIZqtu60URtxUy/HIvcIi39fkjtfAb5CuUOvJNdjHbqvnGhbVOhcW559WO
         YfkrYdwsNLZRQuuaMWsL46P9/a43wMyzf4SsfS5uE2RLIwmqAo2sjpIFei0oSWpf/Zu1
         tkjwtSJytcub5vUPzW/DSRRFm7uVd+RWbmWbxxNP8euyxJELlQ/0YNJlQ1MlAtHYGuhT
         9fUbDNMbdFavxoIENncKUphLfqLKTC01OUNr6MsibES7bnd9GzupPQYrBmf30aTeAk/j
         NgEsFtFZVhc3GwMsV/eJGQYje362ZmD7xi1HXXT0OhXGB5IVsQSDGODIjhwzGz5a+Wat
         Etpw==
X-Gm-Message-State: AOAM530GR0qZzhRt7t7YkkZb0g8fufkJ8XuAA3cba/esc9oPOdXGH4Ad
        O4wii75LJ/tlFQiaR3e4zRO6uZ80S0Q=
X-Google-Smtp-Source: ABdhPJxX1C79ywH8Cmtsr6C5Sv3ezUzAPj3UouKzhRHHc7F1pdgolQ35n8KRod/TcqSqTEmS3dXqqw==
X-Received: by 2002:ac2:558f:: with SMTP id v15mr3193613lfg.187.1592509719879;
        Thu, 18 Jun 2020 12:48:39 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id v28sm943505lfd.35.2020.06.18.12.48.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jun 2020 12:48:38 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i27so8702447ljb.12
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:48:38 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr9039ljk.314.1592509718255;
 Thu, 18 Jun 2020 12:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200617073755.8068-1-hch@lst.de>
In-Reply-To: <20200617073755.8068-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 18 Jun 2020 12:48:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
Message-ID: <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
Subject: Re: rename probe_kernel_* and probe_user_*
To:     Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Explicitly added architecture lists and developers to the cc to make
this more visible ]

On Wed, Jun 17, 2020 at 12:38 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Andrew and I decided to drop the patches implementing your suggested
> rename of the probe_kernel_* and probe_user_* helpers from -mm as there
> were way to many conflicts.  After -rc1 might be a good time for this as
> all the conflicts are resolved now.

So I've merged this renaming now, together with my changes to make
'get_kernel_nofault()' look and act a lot more like 'get_user()'.

It just felt wrong (and potentially dangerous) to me to have a
'get_kernel_nofault()' naming that implied semantics that we're all
familiar with from 'get_user()', but acting very differently.

But part of the fixups I made for the type checking are for
architectures where I didn't even compile-test the end result. I
looked at every case individually, and the patch looks sane, but I
could have screwed something up.

Basically, 'get_kernel_nofault()' doesn't do the same automagic type
munging from the pointer to the target that 'get_user()' does, but at
least now it checks that the types are superficially compatible.
There should be build failures if they aren't, but I hopefully fixed
everything up properly for all architectures.

This email is partly to ask people to double-check, but partly just as
a heads-up so that _if_ I screwed something up, you'll have the
background and it won't take you by surprise.

               Linus
