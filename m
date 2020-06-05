Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9838C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B9B207D0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mHh7+1LB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgFEVGa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEVGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:06:30 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F23C5C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:06:29 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i12so3161196pju.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S4FEoewm7+mx4PK2KzhQc8E6W3fYSng1kE7iZTT8U+o=;
        b=mHh7+1LBtqILuDGDB4ibTtLAcR9xu59SwPQMzCn2d5dN4draU4SArwCSKhrcP22jbQ
         PozPITIP1pGAllImab1JzOqljaaK3f3MGVIIBaAUk5nFjj4WO+45vwDc621nbB8qaGwv
         aFlZjSdw6juIs9y+5Uekz0X1dZprlV7voNq10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S4FEoewm7+mx4PK2KzhQc8E6W3fYSng1kE7iZTT8U+o=;
        b=guVoTm4x9NLT/PA64b+h+jAKDdg89GTkyhbJWcYCEBAGKSZrzQYe1dE1Hcwih78FfH
         9vp5eO6CQI4wU2UhA8/9IeclSX3hf6qQlrWAjviNXoHf2+gIIOlQ2wTGsdYZptgLhIWx
         21bIixCJKAuOExsaT+K/2nF4ChWTw/k+IvflHfRbt7l6h2EiHQLUP7oqQApLyvFGGu2/
         /Sb8sfI+E5+p3Dv63nsjhChM0u6oeo0nPz0N6WtkdnyVdF3NLFX2HuwC+GzRo6Xvh3wV
         6sNUwZiqUCR+zdpdpS+bBdOWR2BLB/dM7pQ7863GCkEf0eqJZwVOTCyxRdLNheAfH1iR
         e8xg==
X-Gm-Message-State: AOAM531ZqhYQIMFgTiIIsRYYN77a3mpNcNRz2ixA8lTPU+f64v/xMDW6
        6XB2hkOJmZq1AQDbiXKC6uFZ4w==
X-Google-Smtp-Source: ABdhPJwE39JaU3icWGUNcL21FFOr0U7ilIORnK/KdechHmsfMr/IG5eaWKnock+V9Ayxwu0pgMJvdA==
X-Received: by 2002:a17:902:8f85:: with SMTP id z5mr11648050plo.152.1591391189221;
        Fri, 05 Jun 2020 14:06:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a14sm435194pfc.133.2020.06.05.14.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:06:28 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:06:27 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 1/5] mm, slub: extend slub_debug syntax for multiple
 blocks
Message-ID: <202006051401.9AB3D2CAD@keescook>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-2-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-2-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:15PM +0200, Vlastimil Babka wrote:
> The slub_debug kernel boot parameter can either apply a single set of options
> to all caches or a list of caches. There is a use case where debugging is
> applied for all caches and then disabled at runtime for specific caches, for
> performance and memory consumption reasons [1]. As runtime changes are
> dangerous, extend the boot parameter syntax so that multiple blocks of either
> global or slab-specific options can be specified, with blocks delimited by ';'.
> This will also support the use case of [1] without runtime changes.
> 
> For details see the updated Documentation/vm/slub.rst
> 
> [1] https://lore.kernel.org/r/1383cd32-1ddc-4dac-b5f8-9c42282fa81c@codeaurora.org
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  .../admin-guide/kernel-parameters.txt         |   2 +-
>  Documentation/vm/slub.rst                     |  17 ++
>  mm/slub.c                                     | 177 +++++++++++++-----
>  3 files changed, 144 insertions(+), 52 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 6253849afac2..6ea00c8dd635 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -4613,7 +4613,7 @@
>  			fragmentation.  Defaults to 1 for systems with
>  			more than 32MB of RAM, 0 otherwise.
>  
> -	slub_debug[=options[,slabs]]	[MM, SLUB]
> +	slub_debug[=options[,slabs][;[options[,slabs]]...]	[MM, SLUB]
>  			Enabling slub_debug allows one to determine the
>  			culprit if slab objects become corrupted. Enabling
>  			slub_debug can create guard zones around objects and
> diff --git a/Documentation/vm/slub.rst b/Documentation/vm/slub.rst
> index 4eee598555c9..f1154f707e06 100644
> --- a/Documentation/vm/slub.rst
> +++ b/Documentation/vm/slub.rst
> @@ -41,6 +41,11 @@ slub_debug=<Debug-Options>,<slab name1>,<slab name2>,...
>  	Enable options only for select slabs (no spaces
>  	after a comma)
>  
> +Multiple blocks of options for all slabs or selected slabs can be given, with
> +blocks of options delimited by ';'. The last of "all slabs" blocks is applied
> +to all slabs except those that match one of the "select slabs" block. Options
> +of the first "select slabs" blocks that matches the slab's name are applied.
> +
>  Possible debug options are::
>  
>  	F		Sanity checks on (enables SLAB_DEBUG_CONSISTENCY_CHECKS
> @@ -83,6 +88,18 @@ in low memory situations or if there's high fragmentation of memory.  To
>  
>  	slub_debug=O
>  
> +You can apply different options to different list of slab names, using blocks
> +of options. This will enable red zoning for dentry and user tracking for
> +kmalloc. All other slabs will not get any debugging enabled::
> +
> +	slub_debug=Z,dentry;U,kmalloc-*
> +
> +You can also enable options (e.g. sanity checks and poisoning) for all caches
> +except some that are deemed too performance critical and don't need to be
> +debugged::

Just for more clarity, how about:

 ... debugged by starting the list with "-" (to mean "all except the
following")::

> +
> +	slub_debug=FZ;-,zs_handle,zspage
> +
>  In case you forgot to enable debugging on the kernel command line: It is
>  possible to enable debugging manually when the kernel is up. Look at the
>  contents of::

Everything else looks great; very nice! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
