Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E472C11D1B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1469B206EF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 20:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTCaAxg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgBTUFZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 15:05:25 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:51050 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728770AbgBTUFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 15:05:25 -0500
Received: by mail-pj1-f65.google.com with SMTP id r67so1323326pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 12:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AM1AiYiIhAr8XdPP/BPciMkpM20+lBQrHGm2LLEISDc=;
        b=lTCaAxg+atkTw/KGP3m5VplsBAN/kWSpDjgAlM8Igr+a1sNmdzHD2rx5fB5o3IhXPH
         RAy7xzNQrh+ZcTNTwroQf75JBOIBK4gXmhJ5zDM6AYt4yCQFvEAOIOZB4Og5F2cm+aYr
         3zJNHZvcgdIM69biK+8wzmvvgSiGd8QDV4ZDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AM1AiYiIhAr8XdPP/BPciMkpM20+lBQrHGm2LLEISDc=;
        b=NE0daaLZTzt4fyPgQvOWt89BurSMjvIzA0LqZag3vnXF2NyQka93JsbTAc1Mzs9/mV
         QQYiheP+hEHTHPN/qSPXeUiXoKGdD0YydrME+yJwoWgotCBuIWQoDtXiZQRXypl4VzXq
         pig80mjnLyiIfIpBxCvoNxBdQ/IyMlPbCxjfqpv22RPRZIiIy5bQRLiIJrV3W4XNCKWx
         gisWapEMHclSJL+uvP3xgakLllUMsPaYr7vT3b1kHYq+XKgjL2emXLmAErD50YT+A/bC
         0S9PrXCFbPDmc6uFpkSjQ7EkLZJC/AcZdLJi3jjv+VqkyTPB37ePcZc+w0xxP9omvFxo
         SDyw==
X-Gm-Message-State: APjAAAUeztJum9Q44+V5HKRKrBBWEjr2xGNOo9zOpF2dqPH3afrbPO/P
        /fVnTwvINqAa1/C4rQvi5sjBBw==
X-Google-Smtp-Source: APXvYqw3Kx3/mRCnqMTvzz5MIjrcTa/0IfhIihZu3PCJsDr+kPXc0CbGTglNzPe5nUHCADYpbjISSw==
X-Received: by 2002:a17:90a:af81:: with SMTP id w1mr5712258pjq.14.1582229123159;
        Thu, 20 Feb 2020 12:05:23 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r145sm433935pfr.5.2020.02.20.12.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 12:05:21 -0800 (PST)
Date:   Thu, 20 Feb 2020 12:05:20 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [Regression] Docs build broken by commit 51e46c7a4007
Message-ID: <202002201158.2911CE2388@keescook>
References: <CAJZ5v0he=WQ6159fyaYYffdi66y596rVo7z1yLyGFcH45PXNUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0he=WQ6159fyaYYffdi66y596rVo7z1yLyGFcH45PXNUg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 07:50:47PM +0100, Rafael J. Wysocki wrote:
> On two of my systems the docs build has been broken by commit
> 51e46c7a4007 ("docs, parallelism: Rearrange how jobserver reservations
> are made").
> 
> The symptom is that the build system complains about the "output"
> directory not being there and returns with an error.
> 
> Reverting the problematic commit makes the problem go away.

How strange! This must be some race in the parallel build. AFAICT,
"output" is made in the first sub-target (Documentation/media). This
doesn't look entirely stable (there's no ordering implied by the "all"
target in there)...

Does this work for you?


diff --git a/Documentation/Makefile b/Documentation/Makefile
index d77bb607aea4..5654e087ae1e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -62,7 +62,8 @@ loop_cmd = $(echo-cmd) $(cmd_$(1)) || exit;
 #    e.g. "media" for the linux-tv book-set at ./Documentation/media
 
 quiet_cmd_sphinx = SPHINX  $@ --> file://$(abspath $(BUILDDIR)/$3/$4)
-      cmd_sphinx = $(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
+      cmd_sphinx = mkdir -p $(abspath $(BUILDDIR)) && \
+	$(MAKE) BUILDDIR=$(abspath $(BUILDDIR)) $(build)=Documentation/media $2 && \
 	PYTHONDONTWRITEBYTECODE=1 \
 	BUILDDIR=$(abspath $(BUILDDIR)) SPHINX_CONF=$(abspath $(srctree)/$(src)/$5/$(SPHINX_CONF)) \
 	$(PYTHON) $(srctree)/scripts/jobserver-exec \

-- 
Kees Cook
