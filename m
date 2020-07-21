Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2FBC433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F6D220792
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595347780;
	bh=sNmbc7KHOeVZrAwkp+5Dno/XRXWqnpjzUcXRAU65btA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Dm/XT8N2w7GCXoQPCCbF0AOjCe4BzRP6vX1FcBpyGen9bLmdIXi2/DaWLLsBkQuts
	 sq273vo+VpHKIbB0Ed6JmBQtniwtPSMv2qiZqHyp96fjkgwBZH/WhojwItfm/YqrYG
	 YnFvlFkHzJXSKxBeKrpE+Iduhz6ff59QUtnsA368=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728519AbgGUQJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:09:39 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:43644 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgGUQJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:09:39 -0400
Received: by mail-il1-f195.google.com with SMTP id i18so16885154ilk.10;
        Tue, 21 Jul 2020 09:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MAFnSJ9nfMA+aM1fdOKhLqLRIwC/D6r6rOu7Wq8LJQU=;
        b=CuJRSN08c4y5kExyF86sZgRSJG2k2wYK8FwSJrXr9YZipAGPClYmkdu4mDjaP0AHXp
         GmixksZhr0wfCw9GmS5yNUi4B2r5TirxhYiLLQzbs7OzcbzzqDxDpMsragk9qbt8CWRL
         VgeUnY2NZDtgkh6QbsWz/97g2PXhHv0ESuha31Tbh9tu4E6bBihhMNkjs61CmE9g6349
         Qrzr4TOdmH0rdsHix9FChlDvzTLTY94EI5mPOj7dIbVFHOlDeBCtsvB8NO3q63l8EY08
         n4m5sWVS0gGnwtswOAEHHydvz4EDUDx7EEKJgztUnG3aE1xTBnGJCmMqW6UC/X0Pv+RZ
         q/kA==
X-Gm-Message-State: AOAM533rhfBtOhrVq/nxBuCfaKOetC2kh47oIBXSTyT2C7KSNW2BOwq7
        D/J509gR5pY3VKy0SHUqXJwpmVMQAFmw
X-Google-Smtp-Source: ABdhPJz0uCodnN2b+0uHsM5KcqfLRxa9mPLd8qxPeebl+S3wN2JyK2Dag3ihJB+mmf/jI3cqcRZxNA==
X-Received: by 2002:a92:d308:: with SMTP id x8mr28150239ila.3.1595347778144;
        Tue, 21 Jul 2020 09:09:38 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id e21sm11034941ioe.11.2020.07.21.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 09:09:37 -0700 (PDT)
Received: (nullmailer pid 387737 invoked by uid 1000);
        Tue, 21 Jul 2020 16:09:35 -0000
Date:   Tue, 21 Jul 2020 10:09:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     linux-kernel@vger.kernel.org, jsarha@ti.com, airlied@linux.ie,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, tomi.valkeinen@ti.com, robh+dt@kernel.org
Subject: Re: [PATCH for v5.9] drm/tilcdc: Replace HTTP links with HTTPS ones
Message-ID: <20200721160935.GA387686@bogus>
References: <20200719172438.60536-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200719172438.60536-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jul 2020 19:24:38 +0200, Alexander A. Klimov wrote:
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
>             If both the HTTP and HTTPS versions
>             return 200 OK and serve the same content:
>               Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---
>  Continuing my work started at 93431e0607e5.
>  See also: git log --oneline '--author=Alexander A. Klimov <grandmaster@al2klimov.de>' v5.7..master
>  (Actually letting a shell for loop submit all this stuff for me.)
> 
>  If there are any URLs to be removed completely
>  or at least not (just) HTTPSified:
>  Just clearly say so and I'll *undo my change*.
>  See also: https://lkml.org/lkml/2020/6/27/64
> 
>  If there are any valid, but yet not changed URLs:
>  See: https://lkml.org/lkml/2020/6/26/837
> 
>  If you apply the patch, please let me know.
> 
>  Sorry again to all maintainers who complained about subject lines.
>  Now I realized that you want an actually perfect prefixes,
>  not just subsystem ones.
>  I tried my best...
>  And yes, *I could* (at least half-)automate it.
>  Impossible is nothing! :)
> 
> 
>  Documentation/devicetree/bindings/display/tilcdc/tilcdc.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
