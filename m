Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCEDEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9F5206F5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:32:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RfxcZguE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgGMQc1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:32:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D28C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:32:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id d4so6251870pgk.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OvYqhPR3ywLRItiGcXvwvSYep0JkZDTcTilUbAMAoyw=;
        b=RfxcZguEYvmQmkGRpx7lJye5zT9WILLnEhbhmSKl1AqrLRhxM8y9gtTfzfRDlX66x1
         ib5WqIcmnPIZcGPNEo2WD3z8yPHy9dHfH3HyHZ/5ax78GIwr5RwdTEvI3cmy+XiBUw56
         uSd9Sl8s4j5CIupRbPAlr9UzPnfN3LEKSlTzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OvYqhPR3ywLRItiGcXvwvSYep0JkZDTcTilUbAMAoyw=;
        b=KSwrkX85C+ZjJiBk0syvYQmT9crRldpnp9mnLcl8PpBobz0tKWAk/6mWha2CLS1nYH
         taW2uqYeyHASpcu1ZMngrRNxrrFjPuRp1F2p/NJY4laIEhE+1NEZrJhhtdnQdwcP5y6c
         YUX57af4DDvSewdScw65dlOuWgx6+yQZNGpfw4xUL8tuntjJSn7pfu97WoUfFML5kKQT
         5z1IE1jHnhHJBEI+5ZSnCFU7UW5FwGcIUGK75sxIIbT5hbgZd38OERgL7DcouovonE7y
         cvZyoXF98Pi8hJFQ7SCv6J6lWkWoPt6n+YU4yfK/7Uxiab1hgtPe2lM0E2t9Db+TQm8R
         66uQ==
X-Gm-Message-State: AOAM530EgafI8qoT8DQiJ7CpIR7Vmxt60v29qVN8IiIqqy9QSLunY0l/
        tNwfyTd27rPO0FbuEkC9TnwVRg==
X-Google-Smtp-Source: ABdhPJwVyn+Pk9SC7AVkhPqLpBMV6Wm13ViN5M4jai2zNLPp/RZKRS4va2Y7SvvCx145FW9/DOuFCg==
X-Received: by 2002:a05:6a00:14c1:: with SMTP id w1mr649973pfu.92.1594657946329;
        Mon, 13 Jul 2020 09:32:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id x10sm13288052pgp.47.2020.07.13.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 09:32:25 -0700 (PDT)
Date:   Mon, 13 Jul 2020 09:32:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     re.emese@gmail.com, kernel-hardening@lists.openwall.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gcc-plugins: Replace HTTP links with HTTPS ones
Message-ID: <202007130932.65FA9A6@keescook>
References: <20200713135018.34708-1-grandmaster@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713135018.34708-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 03:50:18PM +0200, Alexander A. Klimov wrote:
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

Thanks! Applied to for-next/gcc-plugins

-- 
Kees Cook
