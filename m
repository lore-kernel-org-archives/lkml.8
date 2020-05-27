Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B39C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C8C02084C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SOduy4lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgE0O0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389036AbgE0O0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:26:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD95C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:26:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j16so11759556wrb.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 07:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=34HLjmK1c/0lja18IFDaAvizeeni+8A0+yLrcuOnt6s=;
        b=SOduy4lkCkwjmI0QeG65K/wrRqpjJZA/vXAizxeSh0GB1X8T15UW2rQCpNPvZgrKfZ
         O91e+QYG9T2eKn58qnQRjF5eEBbiQfXs2puDFq3m0jTb52GKancfabRHa8DrG2THbNE+
         Hi2jgORhG/V5iVIuSLPTlRiHz9c4kHi9UT4cbBt+WI7+pyU+NHFUjhQMrSFGo7rtGb8e
         zeFvPgPAMaqpygmZGccY2Yt/MDKdxOjyDXZKK0tHqj1CcJRf9QXC9jeR/HQZxCZYfroa
         rOD9nOv2x+sUwCVjog7sroyYWZezkHh0+lMbl5x2HvE9vZLQh7sCI1ENH0K7ed+I0MfN
         4F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34HLjmK1c/0lja18IFDaAvizeeni+8A0+yLrcuOnt6s=;
        b=PVLnDabHbvQAuk7oZsHLpIYK+6+0v1dGFmnnPAM+n+e7XwHYqipO54Kqwur7wYA+xJ
         c3nkA6rbLfyg4uk/FH8aDiumI53411p+AOow7OT9tmifOW0eESFKktwWqTJWUOhe5R1C
         EaXXUm5cZRPie9Q4TOeIftJZrpAdPhwkclUODnZhj3pWjej7Cucwm5WdBG2wzfGAvrMe
         5FsYKhaNcjp6+vuRRTdvNKe6Mv0Qc9Cqdl0ZtdRtoseU+fz0CAydy4aH7B9bW9ZhH9RI
         H3IJC92jJtZTwKvrjT9Ntmhf27hQQdM80AdiYuOYe4QovtycqIjrQX4TP0N/pEvJjRqj
         A/tg==
X-Gm-Message-State: AOAM532w/AjlzMGxkaSwfpv8WGrJGCKQX794jaXHJtUAjXf0nCMSkXcN
        UCqgW5fVzZynre7gnEzKaIDNLBs8LGc=
X-Google-Smtp-Source: ABdhPJzwIDHcPXyeTxEti9Ruu7DNpDNyxtg30jFdfYqrdsdmnDgGXlaE7BHx5Dtsw5qH3gme0lumxQ==
X-Received: by 2002:adf:f601:: with SMTP id t1mr15339842wrp.244.1590589612081;
        Wed, 27 May 2020 07:26:52 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id h5sm2998033wrw.85.2020.05.27.07.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 07:26:51 -0700 (PDT)
Date:   Wed, 27 May 2020 15:26:49 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] kdb: Check status of console prior to invoking
 handlers
Message-ID: <20200527142649.aa3kgqvo2n4q4kyx@holly.lan>
References: <1590560759-21453-1-git-send-email-sumit.garg@linaro.org>
 <1590560759-21453-3-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590560759-21453-3-git-send-email-sumit.garg@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:55:57AM +0530, Sumit Garg wrote:
> Check if a console is enabled prior to invoking corresponding write
> handler.
> 
> Suggested-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
>  kernel/debug/kdb/kdb_io.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/debug/kdb/kdb_io.c b/kernel/debug/kdb/kdb_io.c
> index f6b4d47..349dfcc 100644
> --- a/kernel/debug/kdb/kdb_io.c
> +++ b/kernel/debug/kdb/kdb_io.c
> @@ -564,6 +564,8 @@ static void kdb_msg_write(char *msg, int msg_len)
>  		kdb_io_write(msg, msg_len, dbg_io_ops->write_char);
>  
>  	for_each_console(c) {
> +		if (!(c->flags & CON_ENABLED))
> +			continue;
>  		c->write(c, msg, msg_len);
>  		touch_nmi_watchdog();
>  	}
> -- 
> 2.7.4
> 
