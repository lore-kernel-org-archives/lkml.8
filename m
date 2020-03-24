Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416B9C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C8B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcGNII9z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCXMuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:50:07 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:34337 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgCXMuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:50:06 -0400
Received: by mail-qk1-f194.google.com with SMTP id i6so9934693qke.1;
        Tue, 24 Mar 2020 05:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Oxd53iX68NFjfCWz3pd0ZHCEAkaKEJ/HIu3Y9e6Inm4=;
        b=kcGNII9z7piGjh7QUBOQC3g0oys4C+eYw+F6jyfoMSV7vkMoDOUo7c4P95goHN5Kn7
         CXb+GOoKou0at2uw0qyLCcPrtLFP1tM5iwH142oG3MxRlLzzWkYcI/HCsfq7R8tSVLtS
         3ym4jsvd5DpyPehremRfWqwfSXVKB9y+HGKoyKT0hpScrdbdDYFj7M5hc55IZ+MGEZq0
         5JAzDH0AHdQKuzXaV7dPyHjZbTlnI2ln/Fjqcqxyf5vHpF3xhJskUAhTCCcrSZJNv08m
         /TqzCshXeXJZZFMYrLNBTVhrc7DThN5+TqXhL4THNoc4dSFeoa46UY1MfpK4+W7KjZku
         9WXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Oxd53iX68NFjfCWz3pd0ZHCEAkaKEJ/HIu3Y9e6Inm4=;
        b=bTAS4y0zbfHRTemSbvPJFZMmetYzK7OlEnuNumFCPyypQISMX9ECdxdNuktNnJ1Vql
         ew/Zh5TTR3ISZ1DHU1buLf2ojzV4olkSX0PR+zsvKAaBKR0WYwVkCqzx0Rg1IjgkL5KL
         7Lu/i0QEo5EHickfzuq3DsUkTRsuYf8MYGqX1bu79S4p2qtDEAQcn+yeI/nVTVj9j7Sa
         yFz1p3H2X9CPvSWMPjGLisN2yw2MGPTL8pWzzMSSjjabEJntOIYawup4gTrWObqobqgn
         i4yKlBsjczTDnldIt2V+l+2gPZZqzoYaWmsn6tI8yzpGvJRE7Ec7oQlpUu2p7jOvl0tm
         1pHA==
X-Gm-Message-State: ANhLgQ0nGvSm+L0KjcLPIEi0K4WxIqRf+WiWXsgKVZObROHjfuQabD8Q
        InzwXDdWNlyFum03ncCPKYA=
X-Google-Smtp-Source: ADFU+vuxD35OxoRSnXUiwdzHhbyHkB9UQdLE2jLgUBAARHP3BSnQQkF7bbd/93MKr59e9qwZA6KtEA==
X-Received: by 2002:a37:f511:: with SMTP id l17mr25463353qkk.479.1585054205330;
        Tue, 24 Mar 2020 05:50:05 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z6sm12559020qka.34.2020.03.24.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 05:50:04 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C5BAE40F77; Tue, 24 Mar 2020 09:50:01 -0300 (-03)
Date:   Tue, 24 Mar 2020 09:50:01 -0300
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, kan.liang@linux.intel.com,
        zhe.he@windriver.com, dzickus@redhat.com, jstancek@redhat.com,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] perf cpumap: Fix snprintf overflow check
Message-ID: <20200324125001.GA21569@kernel.org>
References: <20200324070319.10901-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324070319.10901-1-christophe.jaillet@wanadoo.fr>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 24, 2020 at 08:03:19AM +0100, Christophe JAILLET escreveu:
> 'snprintf' returns the number of characters which would be generated for
> the given input.
> 
> If the returned value is *greater than* or equal to the buffer size, it
> means that the output has been truncated.
> 
> Fix the overflow test accordingling.
                                  y

You forgot to CC David and add this to your patch, which I did:

Suggested-by: David Laight <David.Laight@ACULAB.COM>

Ok?

- Arnaldo
 
> Fixes: 7780c25bae59f ("perf tools: Allow ability to map cpus to nodes easily")
> Fixes: 92a7e1278005b ("perf cpumap: Add cpu__max_present_cpu()")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: keep snprintf
>     modifiy the tests for truncated output
>     Update subject and description
> ---
>  tools/perf/util/cpumap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/util/cpumap.c b/tools/perf/util/cpumap.c
> index 983b7388f22b..dc5c5e6fc502 100644
> --- a/tools/perf/util/cpumap.c
> +++ b/tools/perf/util/cpumap.c
> @@ -317,7 +317,7 @@ static void set_max_cpu_num(void)
>  
>  	/* get the highest possible cpu number for a sparse allocation */
>  	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/possible", mnt);
> -	if (ret == PATH_MAX) {
> +	if (ret >= PATH_MAX) {
>  		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>  		goto out;
>  	}
> @@ -328,7 +328,7 @@ static void set_max_cpu_num(void)
>  
>  	/* get the highest present cpu number for a sparse allocation */
>  	ret = snprintf(path, PATH_MAX, "%s/devices/system/cpu/present", mnt);
> -	if (ret == PATH_MAX) {
> +	if (ret >= PATH_MAX) {
>  		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>  		goto out;
>  	}
> @@ -356,7 +356,7 @@ static void set_max_node_num(void)
>  
>  	/* get the highest possible cpu number for a sparse allocation */
>  	ret = snprintf(path, PATH_MAX, "%s/devices/system/node/possible", mnt);
> -	if (ret == PATH_MAX) {
> +	if (ret >= PATH_MAX) {
>  		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>  		goto out;
>  	}
> @@ -441,7 +441,7 @@ int cpu__setup_cpunode_map(void)
>  		return 0;
>  
>  	n = snprintf(path, PATH_MAX, "%s/devices/system/node", mnt);
> -	if (n == PATH_MAX) {
> +	if (n >= PATH_MAX) {
>  		pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>  		return -1;
>  	}
> @@ -456,7 +456,7 @@ int cpu__setup_cpunode_map(void)
>  			continue;
>  
>  		n = snprintf(buf, PATH_MAX, "%s/%s", path, dent1->d_name);
> -		if (n == PATH_MAX) {
> +		if (n >= PATH_MAX) {
>  			pr_err("sysfs path crossed PATH_MAX(%d) size\n", PATH_MAX);
>  			continue;
>  		}
> -- 
> 2.20.1
> 

-- 

- Arnaldo
