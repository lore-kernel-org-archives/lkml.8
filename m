Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94D52C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 628CD208C7
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UvJOh2wd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgFRUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgFRUsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:48:19 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F88BC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:48:19 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bh7so2948598plb.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wHSbymKQDDBwBrZLoO+dcxDF79vuSWQfqndXQUqIEM=;
        b=UvJOh2wdpig8UGI1kDYufCna/uzFb9g2HxW+FlbTg9OLYcsUNyA7Zm+5loP2mfDTaP
         ao6/eXd7oGrSYxq+ZBHv0038e5LdVHhpg+l3qnpvf/6iejyxs5UQQ+Jmsh6cA+dnC3Fp
         7M+DCKEzdagkxKHjqKsKnFTHlgXEhgiFKKL5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5wHSbymKQDDBwBrZLoO+dcxDF79vuSWQfqndXQUqIEM=;
        b=g/6sSJfLf8sPZYW83angy4PVzb3X1ex7Ua7CVWsJH6VrdMeewGVbJpgO33wkmzuOWp
         0z1GOdaMsezXBzQZtea+wGy8MiFY447xJqXAfJj5GhTYcyCSGkoWLrp+TjvlT0Xz+iip
         gMbQ4CaXBjBRmY3Ayne83oZd46g0gYL9U1X7ZlK/Te7baiZEsYjwtjOpOzHpOgUWJCoJ
         2WQi+PGXpgCy7PUbbyzG3NZT26R0VdIn8idUQn0HUX3n0V7ik/lqdOeCwUbHKLf4icXn
         LDqF5gZQtE9qG3YBD+VPWjghz9UzAMibHnmnFtTJnSkpa2RE1HWlMz8Y+jlLWJHVP58J
         uEQA==
X-Gm-Message-State: AOAM5330AgjQlbAc1sPM5BFCCNrBoew0hT4KqERMEoGV9tf6UfaWYBJo
        K2QbPuD3Y7Vva7psqELOj6TFUhH3bMw=
X-Google-Smtp-Source: ABdhPJwxQ4Kfo5lluDI1fVk+5aVGpXScF8cH5rCNSpV+eNigyHi64sJBCw3omrWvi0tBKsfW6crGog==
X-Received: by 2002:a17:90a:4d09:: with SMTP id c9mr152642pjg.137.1592513298942;
        Thu, 18 Jun 2020 13:48:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 1sm3678364pfx.210.2020.06.18.13.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:48:18 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:48:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
Message-ID: <202006181346.ECCBE1FC0E@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006171103.327F86B1C@keescook>
 <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
 <202006181249.8B826D9@keescook>
 <alpine.DEB.2.22.394.2006182155260.2367@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006182155260.2367@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 09:56:18PM +0200, Julia Lawall wrote:
> @@
> identifier i,fld;
> expression e;
> @@
> 
> \(\(i\|e.fld\|e->fld\) \& E\)
> 
> The e will match all of the variants you are concerned about.

Ah, I see! Okay, that's good. And the "& E" part is to effectively
collect it into E (as in, both the left and right of the & must match).

So to do the matching from earlier:

@@
identifier i, fld;
expression e, ARG1, ARG2;
@@

array_size(\(\(i\|e.fld\|e->fld\) \& ARG1\), ARG2);


?


-- 
Kees Cook
