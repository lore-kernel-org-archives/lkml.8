Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DAB6C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 700A620724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V45a9cT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgCRSwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:52:43 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:35806 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRSwn (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:52:43 -0400
Received: by mail-qv1-f68.google.com with SMTP id q73so4082334qvq.2
        for <Linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jQ3Kfzufsl/+Dunw5pCtvlq7LvUxar+THlhwghWtaDc=;
        b=V45a9cT8el3+qJh7vUZWj9WcSoZYpuRHafW/YQn6Q/YJ4rPzQrI3OIkFQBDqS6x2qQ
         zPfM+tSXOZ9aze3B2oTk4eH41+5xhTAb9jyjIendhrX+i6zqXGGMGy+y/WIolEFXtUCV
         4ibtv4SzUBn3okcn2brHK8Wz1bZZZMJhxL5FIlzViO2MVjVtdZ4nWcSzBu+GFBXyBHxa
         2IL5pKQ7KqeBQtuBuu4U/VbJrmF8oipkYTS57r80BPktSxRgm1KYb1ufJE8K+QOSHqm9
         YQlR9yAupHFZWSDjU+cVsZwwjinu/ypM+8s9d/7wmTepgnqDMRJoo//Err2lYzO64Hu3
         2MTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jQ3Kfzufsl/+Dunw5pCtvlq7LvUxar+THlhwghWtaDc=;
        b=DGvDOB4Y6DxpY8fWwitv+SrEhflOIc5ljxiL0dKMcHlctki0wdwQKdZ9U4zIAOmNfN
         hcOWp++2cDoIwmL4/dz5uSEynm3uqkKGIUYeUjNxPfU3oA9bjvR3BvYVhTRGzg14N8XQ
         UgRa4+kC4KrIr5KhOLdZoKe6Css+SaYoSzjosKp4e4dpMRETDmC6H+A3CciN1aN0TwP0
         WZMtssIqaISWDQdvFtCTsfZxy4K8XLgy4HB63rlT/dNuRu0AtCKXY6D0WZQD7hAadKh0
         9I8jmK9i308p/ggElWjcLNAubDvCAp598k7sqxFsuyHS3zrRVNwd7QBmLdBD+clCE1a0
         CLxg==
X-Gm-Message-State: ANhLgQ25m34Bm3wuVlEZrzgDKp2Q1TO2bcRRTHaY0uW1GjGIUSQ6mjPD
        rRbsbJdU9NU2u7xPtdxt8KuxB1z4V7M=
X-Google-Smtp-Source: ADFU+vsqKGwNuFCU5KHcahJMcqoSYcUYArjLvnHXUCK/ihnIcRkpnfeBhAFEsPdoG/KsirzyDx7Rfw==
X-Received: by 2002:a0c:c246:: with SMTP id w6mr5869909qvh.250.1584557561471;
        Wed, 18 Mar 2020 11:52:41 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id p38sm5374171qtf.50.2020.03.18.11.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 11:52:40 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B5728404E4; Wed, 18 Mar 2020 15:52:38 -0300 (-03)
Date:   Wed, 18 Mar 2020 15:52:38 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v7 2/3] perf report: Support a new key to reload the
 browser
Message-ID: <20200318185238.GL11531@kernel.org>
References: <20200220013616.19916-1-yao.jin@linux.intel.com>
 <20200220013616.19916-3-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220013616.19916-3-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Feb 20, 2020 at 09:36:15AM +0800, Jin Yao escreveu:
> Sometimes we may need to reload the browser to update the output since
> some options are changed.
> 
> This patch creates a new key K_RELOAD. Once the __cmd_report() returns
> K_RELOAD, it would repeat the whole process, such as, read samples from
> data file, sort the data and display in the browser.
> 
>  v7:
>  ---
>  Rebase to perf/core, no other change.
> 
>  v6:
>  ---
>  No change.
> 
>  v5:
>  ---
>  1. Fix the 'make NO_SLANG=1' error. Define K_RELOAD in util/hist.h.
>  2. Skip setup_sorting() in repeat path if last key is K_RELOAD.
> 
>  v4:
>  ---
>  Need to quit in perf_evsel_menu__run if key is K_RELOAD.
> 
>  v3:
>  ---
>  No change.
> 
>  v2:
>  ---
>  This is a new patch created in v2.
> 
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  tools/perf/builtin-report.c    | 6 +++---
>  tools/perf/ui/browsers/hists.c | 1 +
>  tools/perf/ui/keysyms.h        | 1 +
>  tools/perf/util/hist.h         | 1 +
>  4 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
> index 862c7f8853dc..842ef92c3598 100644
> --- a/tools/perf/builtin-report.c
> +++ b/tools/perf/builtin-report.c
> @@ -635,7 +635,7 @@ static int report__browse_hists(struct report *rep)
>  		 * Usually "ret" is the last pressed key, and we only
>  		 * care if the key notifies us to switch data file.
>  		 */
> -		if (ret != K_SWITCH_INPUT_DATA)
> +		if (ret != K_SWITCH_INPUT_DATA && ret != K_RELOAD)
>  			ret = 0;
>  		break;
>  	case 2:
> @@ -1469,7 +1469,7 @@ int cmd_report(int argc, const char **argv)
>  		sort_order = sort_tmp;
>  	}
>  
> -	if ((last_key != K_SWITCH_INPUT_DATA) &&
> +	if ((last_key != K_SWITCH_INPUT_DATA && last_key != K_RELOAD) &&
>  	    (setup_sorting(session->evlist) < 0)) {
>  		if (sort_order)
>  			parse_options_usage(report_usage, options, "s", 1);
> @@ -1548,7 +1548,7 @@ int cmd_report(int argc, const char **argv)
>  	sort__setup_elide(stdout);
>  
>  	ret = __cmd_report(&report);
> -	if (ret == K_SWITCH_INPUT_DATA) {
> +	if (ret == K_SWITCH_INPUT_DATA || ret == K_RELOAD) {
>  		perf_session__delete(session);
>  		last_key = K_SWITCH_INPUT_DATA;

Are you sure this shouldn't be:
	
		last_key = ret;

?

I'm applying it to test now anyway,

- Arnaldo

>  		goto repeat;
> diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
> index f36dee499320..7c091fa51a5c 100644
> --- a/tools/perf/ui/browsers/hists.c
> +++ b/tools/perf/ui/browsers/hists.c
> @@ -3440,6 +3440,7 @@ static int perf_evsel_menu__run(struct evsel_menu *menu,
>  					pos = perf_evsel__prev(pos);
>  				goto browse_hists;
>  			case K_SWITCH_INPUT_DATA:
> +			case K_RELOAD:
>  			case 'q':
>  			case CTRL('c'):
>  				goto out;
> diff --git a/tools/perf/ui/keysyms.h b/tools/perf/ui/keysyms.h
> index fbfac29077f2..04cc4e5c031f 100644
> --- a/tools/perf/ui/keysyms.h
> +++ b/tools/perf/ui/keysyms.h
> @@ -25,5 +25,6 @@
>  #define K_ERROR	 -2
>  #define K_RESIZE -3
>  #define K_SWITCH_INPUT_DATA -4
> +#define K_RELOAD -5
>  
>  #endif /* _PERF_KEYSYMS_H_ */
> diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
> index 0aa63aeb58ec..bb994e030495 100644
> --- a/tools/perf/util/hist.h
> +++ b/tools/perf/util/hist.h
> @@ -536,6 +536,7 @@ static inline int block_hists_tui_browse(struct block_hist *bh __maybe_unused,
>  #define K_LEFT  -1000
>  #define K_RIGHT -2000
>  #define K_SWITCH_INPUT_DATA -3000
> +#define K_RELOAD -4000
>  #endif
>  
>  unsigned int hists__sort_list_width(struct hists *hists);
> -- 
> 2.17.1
> 

-- 

- Arnaldo
