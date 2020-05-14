Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EAAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B452065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 16:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQceKUU/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgENQqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 12:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbgENQqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 12:46:33 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7867C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:46:32 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z72so24041024wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HUlduk20pJ/YFrIISsBIBK2of0+byvpGgbvvctRJeGk=;
        b=PQceKUU/1haqRj40OIFIjnM5sSf2/ZevJjBcPrhqlKpdnvlCVRHUZjFasyT6s2gbKt
         ei8hSv7nDTicLFZGy8b+nafcNk5H915KBYgpIELwoFjcHL4SXtx98ObxXqa3BRUQS27y
         L7JUB2Y/YBrd0IfJMGk8GxTcRYHAyeffTBE2F4JxJdg6Pqguhkwoc98KjVAEz9cK+mws
         llyOP59Yr1UXKB3Njg75VgkXgzU5m6ocojxK1kosFG8+XOCcrUeHXEUgqMTjnMwA+lxz
         uBoWWFsGOHRX/9IJnJRds+JkyP7MVmqGmxDDS9UKZbeBfl6GOtqq1PQvHkZG1no0nHbB
         KFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HUlduk20pJ/YFrIISsBIBK2of0+byvpGgbvvctRJeGk=;
        b=EPe3y8D1Tz8hPSO4WqaTagzjO3Yw6sLmRoXsS6YCxgjB3eFKsfyw/Drf3VBopPoMJI
         99rvRm24Oy5la1K61ntn2EEZaggLYqHzJG/MWVQ8qS1XAL0Dg44XaKACuxt3TdBbRm5+
         Bi304RI2JEMrJXDyyGhqtlTd1tJ+Dz6QMz844ocy0PmpcrHMCP9jmMFd0GLLCQGsQxd5
         vEdnUr6TYHWXVniF3352sW1k8tUY0+CSgfRWhuyNv6/EraWUZ68DES8vXvBwXwQESmGL
         ocOB6qNIPwFoFVGNG7hbtaaUpBVCV9jg+E7ww1Vf7XkOVQHq7oThGmGVz0RRteqlKOhg
         Jrbw==
X-Gm-Message-State: AGi0PuaP3PQs9mcxUfC/X8+h2clhZsetOKhh/tiL5bN2W/8uo9MNqhsR
        t9XApNA7b4323/+GvWubLuMIHQ==
X-Google-Smtp-Source: APiQypI/LDHjZUzeL5oJx26MJ3l61l+D6DdDQwwkICEHNhEVW9aLlvjJ2lBXTRu3pzLbj36mXJzdSQ==
X-Received: by 2002:a1c:6884:: with SMTP id d126mr30492018wmc.179.1589474791525;
        Thu, 14 May 2020 09:46:31 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id n128sm14603108wmb.47.2020.05.14.09.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 09:46:30 -0700 (PDT)
Date:   Thu, 14 May 2020 17:46:29 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net
Subject: Re: [PATCH 09/11] kdb: constify sysrq_key_op
Message-ID: <20200514164629.6jxixnmi3tal5yfx@holly.lan>
References: <20200513214351.2138580-1-emil.l.velikov@gmail.com>
 <20200513214351.2138580-9-emil.l.velikov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513214351.2138580-9-emil.l.velikov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:43:49PM +0100, Emil Velikov wrote:
> With earlier commits, the API no longer discards the const-ness of the
> sysrq_key_op. As such we can add the notation.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jiri Slaby <jslaby@suse.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: Jason Wessel <jason.wessel@windriver.com>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: kgdb-bugreport@lists.sourceforge.net
> Signed-off-by: Emil Velikov <emil.l.velikov@gmail.com>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> Please keep me in the CC list, as I'm not subscribed to the list.
> 
> IMHO it would be better if this gets merged this via the tty tree.
> ---
>  kernel/debug/debug_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
> index 2b7c9b67931d..355bea54ca0e 100644
> --- a/kernel/debug/debug_core.c
> +++ b/kernel/debug/debug_core.c
> @@ -920,7 +920,7 @@ static void sysrq_handle_dbg(int key)
>  	kgdb_breakpoint();
>  }
>  
> -static struct sysrq_key_op sysrq_dbg_op = {
> +static const struct sysrq_key_op sysrq_dbg_op = {
>  	.handler	= sysrq_handle_dbg,
>  	.help_msg	= "debug(g)",
>  	.action_msg	= "DEBUG",
> -- 
> 2.25.1
> 
