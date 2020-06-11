Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD541C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:16:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B630620760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591881417;
	bh=IFvRF6e6037/tFMhYBHXzmOZJOY8iAbAS3BWQmF1eCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=IeosmFOwXYzBnL8o2ktKY/ionxfUPqomwJ8/ZYaCbV52KpZCZEKO8/Augr4LcOCT4
	 eZ5cONGJ1YbPYaSUjJi8ysMWfKAdRqZSEnZNg+Xh9qyqN4XdCkKXHFoVuvpFlHQ1g/
	 OzQxUk2ANXWJJ8eA4HPCHcbmy6ndpfoO1tlbWAs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgFKNQ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:16:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgFKNQ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:16:56 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31E3920691;
        Thu, 11 Jun 2020 13:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591881415;
        bh=IFvRF6e6037/tFMhYBHXzmOZJOY8iAbAS3BWQmF1eCY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NPdXgcpEdV+iCuO7GTVWVoXB7FU663HrV0EGE3HAdt1X1Hcy9nzqPogJhRhJc5Six
         /hw4Twn/5neN+ApIO1VDGXIMVgrwX3BN1EzM8v3BHEynJkcLgh5SVV/QCdQfhbPWS4
         Ugzg71pyjuY0lNyGLpIr0P7C9aBy5SFiBpKgvANs=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C166140AFD; Thu, 11 Jun 2020 10:16:51 -0300 (-03)
Date:   Thu, 11 Jun 2020 10:16:51 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, cj.chengjian@huawei.com
Subject: Re: [PATCH next] perf tools: fix potential memleak in perf events
 parser
Message-ID: <20200611131651.GC18482@kernel.org>
References: <20200611014234.24304-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611014234.24304-1-chenwandun@huawei.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jun 11, 2020 at 09:42:34AM +0800, Chen Wandun escreveu:
> Fix potential memory leak in function parse_events_term__sym_hw()
> and parse_events_term__clone().
> 
> 1. Free memory when errors occur.
> 2. Function new_term may return error, so it is need to free memory
>    when the return value is negative.

Try to fix one thing per patch, i.e. first the most obvious one, then
the other that requires going thru the new_term() logic, i.e. first
this, which is super easy to review:

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index c4906a6a9f1a..3ada3874a90a 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2958,8 +2958,10 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
 	sym = &event_symbols_hw[idx];
 
 	str = strdup(sym->symbol);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(term, &temp, str, 0);
 }
 
@@ -2984,8 +2986,10 @@ int parse_events_term__clone(struct parse_events_term **new,
 		return new_term(new, &temp, NULL, term->val.num);
 
 	str = strdup(term->val.str);
-	if (!str)
+	if (!str) {
+		zfree(&temp.config);
 		return -ENOMEM;
+	}
 	return new_term(new, &temp, str, 0);
 }
 

Then you go to the one that requires the reviewer (now or in the future,
trying to figure out why something broke) to look at the new_term()
code, ok?

- Arnaldo
 
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>
> ---
>  tools/perf/util/parse-events.c | 40 +++++++++++++++++++++++++++++-----
>  1 file changed, 34 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index 3decbb203846..3491c18edd71 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -2947,6 +2947,7 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
>  		.type_term = PARSE_EVENTS__TERM_TYPE_USER,
>  		.config    = config,
>  	};
> +	int ret;
>  
>  	if (!temp.config) {
>  		temp.config = strdup("event");
> @@ -2957,9 +2958,20 @@ int parse_events_term__sym_hw(struct parse_events_term **term,
>  	sym = &event_symbols_hw[idx];
>  
>  	str = strdup(sym->symbol);
> -	if (!str)
> +	if (!str) {
> +		if (!config)
> +			free(temp.config);
>  		return -ENOMEM;
> -	return new_term(term, &temp, str, 0);
> +	}
> +
> +	ret = new_term(term, &temp, str, 0);
> +	if (ret < 0) {
> +		free(str);
> +		if (!config)
> +			free(temp.config);
> +	}
> +
> +	return ret;
>  }
>  
>  int parse_events_term__clone(struct parse_events_term **new,
> @@ -2973,19 +2985,35 @@ int parse_events_term__clone(struct parse_events_term **new,
>  		.err_term  = term->err_term,
>  		.err_val   = term->err_val,
>  	};
> +	int ret;
>  
>  	if (term->config) {
>  		temp.config = strdup(term->config);
>  		if (!temp.config)
>  			return -ENOMEM;
>  	}
> -	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM)
> -		return new_term(new, &temp, NULL, term->val.num);
> +	if (term->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
> +		ret = new_term(new, &temp, NULL, term->val.num);
> +		if (ret < 0 && term->config)
> +			free(temp.config);
> +		return ret;
> +	}
>  
>  	str = strdup(term->val.str);
> -	if (!str)
> +	if (!str) {
> +		if (term->config)
> +			free(temp.config);
>  		return -ENOMEM;
> -	return new_term(new, &temp, str, 0);
> +	}
> +
> +	ret = new_term(new, &temp, str, 0);
> +	if (ret < 0) {
> +		free(str);
> +		if (term->config)
> +			free(temp.config);
> +	}
> +
> +	return ret;
>  }
>  
>  void parse_events_term__delete(struct parse_events_term *term)
> -- 
> 2.17.1
> 

-- 

- Arnaldo
