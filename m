Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE269C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C572B20772
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 03:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ih5wU/tF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgFEDFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:05:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 23:05:16 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E451FC08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 20:05:15 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so4216284pfi.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 20:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iGSfS1l6NGIAmf6k8iiNDfox+1IWNuUJtYSGHnPjBSo=;
        b=Ih5wU/tFno1MRScUPa8fWbJ94l2PqPYGyO9gkn0CogMFdq9c+NlsSfIVv6jDPI5A/y
         N/jSaxCtntso4FPy9vy5yj13QIu1azSOrajQMUGd/pdCSX0bXA8Z6mmK1Bt4uC1adPQe
         +lpFL+IAzSyK+SNzhtSWN/HMwQFh6l9LHGBsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iGSfS1l6NGIAmf6k8iiNDfox+1IWNuUJtYSGHnPjBSo=;
        b=s9IhnyzAZ9jfLiAJqgc2JvUl2Fm0sv9G4z5KtwldEzirqS1R115KwBz6gnaj2Kwazj
         1Bw8qNUyOIJwc+5SOz1E4WV2KjJy2LdmLkRXISDvRzn3b+e8+v9CQqhv/KckRAPfy8Mu
         5xvlJXDCtNDQeQGqmnQcStHAIgJ9Lx3KmKS+A9hwi6B83ZYpbhfYbhrREs8tqUHYiuF4
         vE9K+rtXo4QVuX9FCq8sIm0a3Ma8gB/A/albGgayL1YjPS7uQwGdwUOaupipp68Xgkci
         plm6Wg/GsUL+di0o1GXQZCYvfcEBvhH5DQL6lH7fd5j8nFlcpcUHoVLt0a9pi5aIdhQ3
         VZPQ==
X-Gm-Message-State: AOAM532UPCHyL1O1X3fs+r6c/vWmbH9Gd6T+g7yCRln24Xy9lupOYaKD
        loRWv8n/rMDDM540/LtEgQtRrZlVTKpvbw==
X-Google-Smtp-Source: ABdhPJxu6SThssJrT/yGatRAMtvhGZ2lihbb/FfPjZLarCEWq/n9N6eR5l8PXd0miWxGCELea/5hmA==
X-Received: by 2002:aa7:9298:: with SMTP id j24mr7643715pfa.209.1591326315480;
        Thu, 04 Jun 2020 20:05:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b14sm5677430pft.23.2020.06.04.20.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:05:14 -0700 (PDT)
Date:   Thu, 4 Jun 2020 20:05:13 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Whitcroft <apw@canonical.com>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: Re: [PATCH] checkpatch: Avoid missing typo suggestions
Message-ID: <202006042003.D5A8E0A@keescook>
References: <202006031618.DA25142@keescook>
 <a3c22bbd360d2148bf097d3c55a89ea13e07b719.camel@perches.com>
 <202006041503.C9BFD40255@keescook>
 <d111107687395f9a98ae8f074b599fee1be14f99.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d111107687395f9a98ae8f074b599fee1be14f99.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 06:02:05PM -0700, Joe Perches wrote:
> Huh?  Did you test this?

I didn't, no. I was going off my earlier discoveries about how the
"msdos" thing got parsed weird. My apologies!

> $ ./scripts/checkpatch.pl --strict -f test_spell.c 
> CHECK: 'Cambridg' may be misspelled - perhaps 'Cambridge'?
> #4: FILE: test_spell.c:4:
> + * Cambridg

Thanks for sorting this (and me) out! :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
