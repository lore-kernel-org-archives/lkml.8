Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC87FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1A7A20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:59:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IXYLSXwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbgEUP7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbgEUP7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:59:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E0AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:59:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id f189so7699859qkd.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=07EOCluouBpl9qKeod5y2zfCi6Qn4VI7pDSmqQBWZhY=;
        b=IXYLSXwel3alWlcsiMhwa5MUFfdZp4obBq4P/b/2YO4w30NVQ8zgHX5rSFUa7o+eKK
         9f1fGdDBBVc0OFqFAd/O18FcCptIn7Zkgwkub3WQVHdKq2tg26jzaUXTQEzBpX7Fu8m/
         1bw9FmOd3pz/qu1sQHTJNVghAb+fbo01KfMkmrDFGOXBneIgKVLx2hFRnFvRQLlFPp83
         yv0DhcO8+RNpzXAsA4FmGhkK5z43YTbAgomjvwcbAb1m5piJTnPWn3CfDzvjA9YJUgNf
         Teo1AFE7BGZH2kYjSEvv5bNmPivAeFYftHh4uCjULJuA+EYFh9MRixuKfWcI33Z8t4Xg
         iamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=07EOCluouBpl9qKeod5y2zfCi6Qn4VI7pDSmqQBWZhY=;
        b=bHAdmGO7BJ4nKvlRSaC/aS4mUiXdc1Tjt4H+cTzP6H5UrtwIe0c374nGbJw1P2BGR9
         mVRRg9O5M1i8llHyMd3rkIFjCUL5L8+y3J6f9gHB+5esBpMuWL5wJlweMrPgzgtLAjry
         l6/jT/mf8srS+6jkGrFXztP5F5qg7CO/jGkVsAyz1XrBE14wrDgQlDO8UVJ8WcyGZSwN
         pR6GFRao3UftBYzEPX0uLLIgpkcFj9+do4hsySjPSnZbRWLmDgARp0Bg9NUihMQyrxxU
         1jZo0js9Y94I9ozmvFKxMY3PGCX+emTEuXB2Il7c0RzeOHTXc9JEYI2UAGwAzbVuPkRN
         isNA==
X-Gm-Message-State: AOAM531PB+JpIpfhB/7gsDM7JG6grN8xKJjDRlbDEG/5NxkC/Glsf/Si
        RSTdWWSiirhLJPbk3yhnEac=
X-Google-Smtp-Source: ABdhPJzezMvAm3lelajWYabY64b03Vp+yPwoTU/juW+aBerlJNKNG94XQEXvr8B33OCs5RMLU97ajw==
X-Received: by 2002:a37:9d09:: with SMTP id g9mr10683963qke.154.1590076774449;
        Thu, 21 May 2020 08:59:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s55sm5754114qtb.92.2020.05.21.08.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:59:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 21 May 2020 11:59:31 -0400
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Chenggang Wang <wangchenggang@vivo.com>,
        linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RFC PATCH 2/2] init: Allow multi-line output of kernel command
 line
Message-ID: <20200521155931.GA568639@rani.riverdale.lan>
References: <cover.1589916689.git.joe@perches.com>
 <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2b3832fed9370f0f8dfd1ea33dddb1d05a36e265.1589916689.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 12:42:35PM -0700, Joe Perches wrote:
> ARM may have its longest possible command line larger than the longest
> possible printk.
> 
> If necessary, emit the commend line on multiple lines.
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> 
> compiled, untested
> 
>  init/main.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index b63a3c001ac4..b3ebbbc129ae 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -826,6 +826,34 @@ void __init __weak arch_call_rest_init(void)
>  	rest_init();
>  }
>  
> +static void __init print_cmdline(char *line)
> +{
> +#ifdef CONFIG_PRINTK
> +	const char *prefix = "Kernel command line";
> +	size_t len = strlen(line);
> +
> +	while (len > PRINTK_LOG_LINE_MAX) {
> +		char *pos = line;
> +		char *last_pos = pos + PRINTK_LOG_LINE_MAX - 1;
> +		char saved_char;
> +		/* Find last space char within the maximum line length */
> +		while ((pos = memchr(pos, ' ', len - (pos - line))) &&
> +		       (pos - line) < PRINTK_LOG_LINE_MAX - 1) {
> +			last_pos = pos;
> +		}
> +		saved_char = line[last_pos - line];
> +		line[last_pos - line] = 0;
> +		pr_notice("%s: %s\n", prefix, line);
> +		prefix = "Kernel command line (continued)";
> +		line[last_pos - line] = saved_char;
> +		len -= pos - line;
> +		line += pos - line;
> +	}
> +
> +	pr_notice("%s: %s\n", prefix, line);
> +#endif

I might be missing something, but this seems broken:
(1) If there is a ' ', the memchr will set pos to the ' ' the first time
through the inner loop, and then go into an infinite loop? You want
memrchr here but the kernel doesn't seem to have one.
(2) If there are no remaining ' 's pos will be NULL and the last two
lines in the outer loop use it -- those should be last_pos instead?
(3) Once those are fixed, you need to ensure you make progress: if
there's exactly one ' ' remaining, at the very beginning of the
remaining line, you need to print upto the PRINTK_LOG_LINE_MAX, not 0
bytes.
