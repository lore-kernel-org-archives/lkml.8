Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2076AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED1CC207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:38:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qv2+OeLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbgEYIit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387973AbgEYIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:38:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6DC6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:38:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id c75so8413726pga.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XCNePfcFeZcrf5Eou3lbRIvzewUZbCCeirH/2H9XiB0=;
        b=Qv2+OeLWkkynJLNx/9pa6LONdtMYtntFb7Q4uKgrP14xqfcaFBc/ACm6u9WjJrF54f
         FcH3Wy3YCGGQWhW9+yYoIviK25fuO/bCOtI/PHlbKo1PED8046e9/722IdPKn5NmpBoR
         4g1qfyV9l9W6HnKlWLg2zv40bnOBzXPBjPrfLnEL8mj1iwBmvUmw5vbBu794pz8C4V2y
         EaO8BHNZI+eJkStOTpnD6ecp+y1Dba4BOKF3mvjVuSchj62lhkygg+iUSSXDLl6zQt9a
         CkJBCpRd6WtIy9Cj6O6tFMmevNkvjyCJIIkkMgoCj9GkUo7XL8d2WKm9cDmiKvwDEIZ6
         0l1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XCNePfcFeZcrf5Eou3lbRIvzewUZbCCeirH/2H9XiB0=;
        b=ZzcOEq8lG9QBbUkEQ4eo2meM2Y6tcoRTouC5F8iPYxEkn7Vqld+/Fpc0v7xMfZGRP9
         8UdzLYZE+NLQ08eBTGkNKy9L3Fga/dKK9d0+oYw7bAAT4mlMGEW7DFvf7roo+abmShYq
         g9R4ATpRQ8mPjDGydWYtGcseBDAYG8KmFn61FL7owASD73Zer8GlzCkGNOCUef8cmyuj
         T6TuDP30X7UcIp58fuO+Aa07iTViNv/ou5FKqtmCY0AlQTghirFCXSv0C7Z2PxoF12JO
         h48nvL/T8ML0o3YeIS8S4zh5jHoJbPTkb/WC2NwDNK7glldtxGdVO39JbgpvcfqO+q6u
         rurg==
X-Gm-Message-State: AOAM530InWHEctjvNIjJktpp9xLUATb8vV+e5pLXUz/F1mqYml2ltWKg
        L/pPs2Mvz3GZmz7yBBtZzCY=
X-Google-Smtp-Source: ABdhPJxUEOs+Dq2RLzCvaC9oAoEOX8apkkmbyjwDEh0JRj+UpShyUG0zPH3pkL5Pw90iFDDBpEv3Gg==
X-Received: by 2002:a62:178b:: with SMTP id 133mr15484871pfx.238.1590395927219;
        Mon, 25 May 2020 01:38:47 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id lj12sm12514746pjb.21.2020.05.25.01.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 01:38:46 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Mon, 25 May 2020 17:38:45 +0900
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] printk: Move and rename maximum printk output line
 length defines
Message-ID: <20200525083845.GD755@jagdpanzerIV.localdomain>
References: <cover.1589916689.git.joe@perches.com>
 <a21d75fce03991d3c8eb1f4d130572d8a04f8686.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a21d75fce03991d3c8eb1f4d130572d8a04f8686.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/21 11:40), Joe Perches wrote:
> Make the printk output maximum line length globally available.
> 
> This can be used to emit logging messages lines that exceed
> the single printk maximum length line.
> 
> e.g.: the kernel boot command on ARM can be up to 2048 chars

Speaking of the kernel boot command I still think that we can use
the existing approach here - split the command line and feed it
token by token to pr_cont(). printk() will handle everything
internally without exposing any implementation details (different
prefix sizes which depend on .config, etc. etc.) and requiring less
code.

> +/* Maximum length of a single printk */
> +
> +#ifdef CONFIG_PRINTK
> +
> +#ifdef CONFIG_PRINTK_CALLER
> +#define PRINTK_PREFIX_MAX	48
> +#else
> +#define PRINTK_PREFIX_MAX	32
> +#endif
> +#define PRINTK_LOG_LINE_MAX	(1024 - PRINTK_PREFIX_MAX)
> +
> +#else
> +
> +#define PRINTK_PREFIX_MAX	0
> +#define PRINTK_LOG_LINE_MAX	0
> +
> +#endif

!CONFIG_PRINTK case is concerning.

We depend on correct zero-sized LOG_LINE handling, otherwise things
like "p + PRINTK_LOG_LINE_MAX - 1" or "(p - line) < PRINTK_LOG_LINE_MAX - 1)"
are ticking bombs, waiting for !PRINTK config and off-by-one writes/reads.
Unless the code in question does more checks or is wrapped into
'#ifdef CONFIG_PRINTK', like you did in your print_cmdline() patch.

We may do a counter measure here, and simply undefine PRINTK_LOG_LINE_MAX
for !PRINTK config, thus forcing any code which uses PRINTK_LOG_LINE_MAX
to be wrapped into `#ifdef CONFIG_PRINTK`. But I think that pr_cont()-based
loop is safer and is easier to code.

If we set to implement "print any random very large string", then I'd
prefer to do it on the printk() side, just like was suggested by Andrew,
rather than forcing people to implement similar loops in various parts
of the kernel.

	-ss
