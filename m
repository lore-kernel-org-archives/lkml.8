Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D722C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62C782074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TSIId/1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFANwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgFANwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:52:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4018C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:52:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c71so10727769wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F1iw9Hpuck8AM8pRE4CycfNLHeehYd1Uv2fKCoA7nVo=;
        b=TSIId/1ncWMqN+hGQdSVvMkwitQDP6VHScTb8Az3eCuxj4f3lZoIe88wlMIWn1JHlj
         2xlFTZ8z198hworkDJ2HnxqChv8tpVESrk8IcWVgt02p2ih4u7YCInsdviZ7N1a0I/wO
         0ty+3fMSgMBqhP1IhckAjSKmRNwge5I/b32gOZcUE5OixkI8TLpHxbG3OhPw0oDWFhVd
         1esVIf2OgydLZxW37XotF7n/mNDE8/q7/6uvjcily6AvU68l/ukAYE5YTPuM/i5svOUg
         dcoR7SafHASJo/wbQfaxT/VMENu6SfkZu/aDRwSGato+dmBhRho1ffoUTIqZDUOcKg8j
         jtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F1iw9Hpuck8AM8pRE4CycfNLHeehYd1Uv2fKCoA7nVo=;
        b=puz8oRMoi947BQVXd7ZW0Cp2vBWWgXvECwljmRP1JcsIw0ODPjOMDDIDQYj9JL3maJ
         va1pWznTd9H2O5qLD4Sy7HKQOI49VUbAYRr4lS95SrCZtjtPZTyw2t7g4bANvjfAQlbG
         x8F2vPoDG2g4KdxM2Fh9lfLfWI0cMt5j56EOi3len8Tuii8sNjcNHQD73sfef+yy9Dz3
         1/MVdHxIzyB4+X/FVsfDpzeA54298ipv+S8Ew9tVTJN7AY8BCuZz/nFaoAdtdB2czRpy
         TgUXH2twD4jdqNkytyD1NAu0UGNdsR2zxndZO/3rI1Yh5FeGm1A4wzSUe+biapG0ITgA
         /kjw==
X-Gm-Message-State: AOAM531sYsrSbB+YkzQ7AheADQEbcu3xvpQvKm9vtVwT/7dfirRasHVm
        vQZTBwz9c/wgBwy4379E4DrIHw==
X-Google-Smtp-Source: ABdhPJwK0wSNqyh9HH7lkQBQTDnu5WXcRVpX2yRw14fQmdb6zMGEXGXjfFVoUe52g2sy30zpADSMEw==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr15221133wmk.94.1591019566888;
        Mon, 01 Jun 2020 06:52:46 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id p10sm22190936wra.78.2020.06.01.06.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 06:52:46 -0700 (PDT)
Date:   Mon, 1 Jun 2020 14:52:44 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>, sumit.garg@linaro.org,
        akashast@codeaurora.org, mka@chromium.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdb: Don't call the deinit under spinlock
Message-ID: <20200601135244.al7rtetn6o4bolgs@holly.lan>
References: <20200526142001.1.I523dc33f96589cb9956f5679976d402c8cda36fa@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526142001.1.I523dc33f96589cb9956f5679976d402c8cda36fa@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 02:20:06PM -0700, Douglas Anderson wrote:
> When I combined kgdboc_earlycon with an inflight patch titled ("soc:
> qcom-geni-se: Add interconnect support to fix earlycon crash") [1]
> things went boom.  Specifically I got a crash during the transition
> between kgdboc_earlycon and the main kgdboc that looked like this:
> 
> Call trace:
>  <snip>
>  ...
> 
> The problem was that we were holding the "kgdb_registration_lock"
> while calling into code that didn't expect to be called in spinlock
> context.
> 
> Let's slightly defer when we call the deinit code so that it's not
> done under spinlock.
> 
> NOTE: this does mean that the "deinit" call of the old kgdb IO module
> is now made _after_ the init of the new IO module, but presumably
> that's OK.
> 
> [1] https://lkml.kernel.org/r/1588919619-21355-3-git-send-email-akashast@codeaurora.org
> 
> Fixes: 220995622da5 ("kgdboc: Add kgdboc_earlycon to support early kgdb using boot consoles")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Just found this in my inbox... which suggested I forgot to post an
"Applied" last week when I pushed it for linux-next.

Expect the kgdb PR for this cycle shortly!


Daniel.


> ---
> 
>  kernel/debug/debug_core.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 4d59aa907fdc..ef94e906f05a 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -1089,7 +1089,6 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  		}
>  		pr_info("Replacing I/O driver %s with %s\n",
>  			old_dbg_io_ops->name, new_dbg_io_ops->name);
> -		old_dbg_io_ops->deinit();
>  	}
>  
>  	if (new_dbg_io_ops->init) {
> @@ -1104,8 +1103,10 @@ int kgdb_register_io_module(struct kgdb_io *new_dbg_io_ops)
>  
>  	spin_unlock(&kgdb_registration_lock);
>  
> -	if (old_dbg_io_ops)
> +	if (old_dbg_io_ops) {
> +		old_dbg_io_ops->deinit();
>  		return 0;
> +	}
>  
>  	pr_info("Registered I/O driver %s\n", new_dbg_io_ops->name);
>  
> -- 
> 2.27.0.rc0.183.gde8f92d652-goog
> 
