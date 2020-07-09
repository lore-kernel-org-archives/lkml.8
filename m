Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59784C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043362070E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 07:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="F0rG8coo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgGIHZd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 03:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgGIHZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 03:25:31 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3581DC061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 00:25:31 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 95so1007430otw.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 00:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pag+RcEqQEamOjfbOEguYU2pFk2Ny9rxa5wKpcW4W0g=;
        b=F0rG8cooNYI+AtqjAzaVgiBMKgGIwFKGt3eV86gNAcJE5PGpK8mcqdaZ6bCEyFrGiQ
         1UyqqbcTs0YYt4yzktkNusLxF750IWBKUaVdQ3/PVEwqwPjtB/RE3A4fj7bV3CbXazld
         r94M5mu53hV9sOXDj7QKaxV9RKyhomECStcG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pag+RcEqQEamOjfbOEguYU2pFk2Ny9rxa5wKpcW4W0g=;
        b=SE5+VY1eQv3tBbwVNmAdZk/M25ma/VSRI010vcA3KWA0yRGUXTrsXJ/jd+CRislN8p
         /+WxVRUoqrOnirusQeiAgM2ZgE6cEIBeUE66cmNxz8b9NYqhM0rJIeraQA2qhAPj57tj
         xT799AQydA2qMhFKvls4uXQD3g6dXZPDoRzgTDuizpHLZwaf3ScteBq2u6UC5hdToXep
         FMIzxafuYToiXbUfLCxTzZcdjVV8LRVkEgp7NaYUcEwckuFU4BC3Um11oF507ajwYtc+
         Rh+s+H3Z4DmkuhSU+ztN7Qzq6BQczeA0HWnc4LaUDqbiiv6YH0iY5cLVTGi7sODR3J90
         eCqw==
X-Gm-Message-State: AOAM533tNvUgeBvwwE0EJF/hrzxy/Pbscl26o+NriRPHg8LeHjKIVv/H
        g94VcnAJdEKKEZeduCTsaSvSUVDbGWnKYWlF9/9Iz7zQ
X-Google-Smtp-Source: ABdhPJxSzSQRWs2P88SyaSpqBzsbq4KX4iqq22DX5CfdfEZl5KM4nNt9yjQRtppW60x06rUB9yIpnJKfDE7wFZpZG9I=
X-Received: by 2002:a05:6830:1613:: with SMTP id g19mr39306609otr.303.1594279530544;
 Thu, 09 Jul 2020 00:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Thu, 9 Jul 2020 09:25:19 +0200
Message-ID: <CAKMK7uHuOD4v9ZU0d5THBhdD=97xO--N8bWd3+Na38vsHKO5Zg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH v3] CodingStyle: Inclusive Terminology
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sjpark@amazon.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Dave Airlie <airlied@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 8:30 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> Linux maintains a coding-style and its own idiomatic set of terminology.
> Update the style guidelines to recommend replacements for the terms
> master/slave and blacklist/whitelist.
>
> Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> Acked-by: Dave Airlie <airlied@redhat.com>
> Acked-by: SeongJae Park <sjpark@amazon.de>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Chris Mason <clm@fb.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Replied to the old version, once more here so it's not lost.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
> Changes since v2 [1]:
> - Pick up missed sign-offs and acks from Jon, Shuah, and Christian
>   (sorry about missing those earlier).
>
> - Reformat the replacement list to make it easier to read.
>
> - Add 'controller' as a suggested replacement (Kees and Mark)
>
> - Fix up the paired term for 'performer' to be 'director' (Kees)
>
> - Collect some new acks, reviewed-by's, and sign-offs for v2.
>
> - Fix up Chris's email
>
> [1]: http://lore.kernel.org/r/159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com
>
>
>  Documentation/process/coding-style.rst |   20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index 2657a55c6f12..1bee6f8affdb 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -319,6 +319,26 @@ If you are afraid to mix up your local variable names, you have another
>  problem, which is called the function-growth-hormone-imbalance syndrome.
>  See chapter 6 (Functions).
>
> +For symbol names and documentation, avoid introducing new usage of
> +'master / slave' (or 'slave' independent of 'master') and 'blacklist /
> +whitelist'.
> +
> +Recommended replacements for 'master / slave' are:
> +    '{primary,main} / {secondary,replica,subordinate}'
> +    '{initiator,requester} / {target,responder}'
> +    '{controller,host} / {device,worker,proxy}'
> +    'leader / follower'
> +    'director / performer'
> +
> +Recommended replacements for 'blacklist/whitelist' are:
> +    'denylist / allowlist'
> +    'blocklist / passlist'
> +
> +Exceptions for introducing new usage is to maintain a userspace ABI/API,
> +or when updating code for an existing (as of 2020) hardware or protocol
> +specification that mandates those terms. For new specifications
> +translate specification usage of the terminology to the kernel coding
> +standard where possible.
>
>  5) Typedefs
>  -----------
>
> _______________________________________________
> Ksummit-discuss mailing list
> Ksummit-discuss@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/ksummit-discuss



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
