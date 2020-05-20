Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D79AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052E7206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 15:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589989051;
	bh=A3Xf9DnnZfqg9PPvqUfrn95TlwnI4sMKC/Q/EpeQAGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1ol3GSQGIjpg37kxbJTUHyJk3zcTGVQrJtV64C+9Hup5+QrmlQGBoSLPK7F/DQkbl
	 sNFOLML5rmzNdM6UnINT7OF+7ZiM+h301Zp7DpvzR4tXmPp4pV0WseblsJ+oNo8gI+
	 cLkjPJREuYTTGFt2BB8rMIboAY60qei4KF7tGBIo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgETPha (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 11:37:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgETPh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 11:37:29 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84773206B6;
        Wed, 20 May 2020 15:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589989048;
        bh=A3Xf9DnnZfqg9PPvqUfrn95TlwnI4sMKC/Q/EpeQAGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SIfc/PwVEc+/9IJFjULSELYLVkCIBpozHk0c/tGZvdzhBXzN1stVqEHoTdXAzDVKy
         pb5Xt1FLib1XjGFfgcMQUhOHbIq3sR4AVU6MnQgLhKYmUkXjDHk31L+Kx2Kk1pjT8f
         EncQdOetBmMh/2AdZU1m3v2HQYj777BaVA58kTAQ=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AC65E40AFD; Wed, 20 May 2020 12:37:25 -0300 (-03)
Date:   Wed, 20 May 2020 12:37:25 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf config: Add stat.big-num support
Message-ID: <20200520153725.GK32678@kernel.org>
References: <1589988775-9995-1-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589988775-9995-1-git-send-email-pc@us.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 20, 2020 at 10:32:55AM -0500, Paul A. Clarke escreveu:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> Add support for new "stat.big-num" boolean option.
> 
> This allows a user to set a default for "--no-big-num" for "perf stat"
> commands.

That is super cool, these polishing patches using infrastructure already
in place for configuring user preferences, great.

One thing you forgot was to change 'man perf-stat's entry for
--no-big-num to state that this is now possible, can you please do that
and send a v2?

- Arnaldo
 
> $ perf config stat.big-num
> $ perf stat --event cycles /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>            803,684      cycles                                                      
> [...]
> $ perf config stat.big-num=0
> $ perf config stat.big-num
> stat.big-num=0
> $ perf stat --event cycles /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>             790448      cycles                                                      
> [...]
> 
> There is an interaction with "--field-separator" that must be
> accommodated, such that specifying "--big-num --field-separator={x}"
> still reports an invalid combination of options.
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
> Testing results with a matrix of:
> - nothing in .perfconfig, stat.big-num=0, stat.big-num=1
> - --field-separator not set, --field-separator=:
> - no "--big-num", --big-num, --no-big-num
> 
> $ perf config stat.big-num
> $ perf stat --event cycles /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>            803,684      cycles                                                      
> 
>        0.000592761 seconds time elapsed
> 
>        0.000672000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --big-num /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>            809,599      cycles                                                      
> 
>        0.000576090 seconds time elapsed
> 
>        0.000627000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --no-big-num /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>             793870      cycles                                                      
> 
>        0.000574928 seconds time elapsed
> 
>        0.000625000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --field-separator=: /bin/true
> 790255::cycles:346960:100.00::
> $ perf stat --event cycles --big-num --field-separator=: /bin/true
> -B option not supported with -x
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -B, --big-num         print large numbers with thousands' separators
>     -x, --field-separator <separator>
>                           print counts with custom separator
> $ perf stat --event cycles --no-big-num --field-separator=: /bin/true
> 764548::cycles:335938:100.00::
> $ perf config stat.big-num=0
> $ perf config stat.big-num
> stat.big-num=0
> $ perf stat --event cycles /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>             790448      cycles                                                      
> 
>        0.000567659 seconds time elapsed
> 
>        0.000619000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --big-num /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>            751,377      cycles                                                      
> 
>        0.000534888 seconds time elapsed
> 
>        0.000587000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --no-big-num /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>             803738      cycles                                                      
> 
>        0.000576151 seconds time elapsed
> 
>        0.000657000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --field-separator=: /bin/true
> 774897::cycles:339986:100.00::
> $ perf stat --event cycles --big-num --field-separator=: /bin/true
> -B option not supported with -x
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -B, --big-num         print large numbers with thousands' separators
>     -x, --field-separator <separator>
>                           print counts with custom separator
> $ perf stat --event cycles --no-big-num --field-separator=: /bin/true
> 814619::cycles:358260:100.00::
> $ perf config stat.big-num=1
> $ perf config stat.big-num
> stat.big-num=1
> $ perf stat --event cycles /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>            787,680      cycles                                                      
> 
>        0.000555401 seconds time elapsed
> 
>        0.000623000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --big-num /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>            783,287      cycles                                                      
> 
>        0.000562255 seconds time elapsed
> 
>        0.000636000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --no-big-num /bin/true
> 
>  Performance counter stats for '/bin/true':
> 
>             748802      cycles                                                      
> 
>        0.000525658 seconds time elapsed
> 
>        0.000586000 seconds user
>        0.000000000 seconds sys
> 
> 
> $ perf stat --event cycles --field-separator=: /bin/true
> 785868::cycles:344508:100.00::
> $ perf stat --event cycles --big-num --field-separator=: /bin/true
> -B option not supported with -x
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -B, --big-num         print large numbers with thousands' separators
>     -x, --field-separator <separator>
>                           print counts with custom separator
> $ perf stat --event cycles --no-big-num --field-separator=: /bin/true
> 794273::cycles:349600:100.00::
> $ 
> --
>  tools/perf/builtin-stat.c |  6 ++++++
>  tools/perf/util/config.c  | 13 +++++++++++++
>  tools/perf/util/stat.h    |  2 ++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index e0c1ad23c768..c39305907940 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -821,10 +821,16 @@ static void sig_atexit(void)
>  	kill(getpid(), signr);
>  }
>  
> +void perf_stat__set_big_num(int set)
> +{
> +	stat_config.big_num = (set != 0);
> +}
> +
>  static int stat__set_big_num(const struct option *opt __maybe_unused,
>  			     const char *s __maybe_unused, int unset)
>  {
>  	big_num_opt = unset ? 0 : 1;
> +	perf_stat__set_big_num(!unset);
>  	return 0;
>  }
>  
> diff --git a/tools/perf/util/config.c b/tools/perf/util/config.c
> index ef38eba56ed0..8e65f1fa421f 100644
> --- a/tools/perf/util/config.c
> +++ b/tools/perf/util/config.c
> @@ -17,6 +17,7 @@
>  #include "util/event.h"  /* proc_map_timeout */
>  #include "util/hist.h"  /* perf_hist_config */
>  #include "util/llvm-utils.h"   /* perf_llvm_config */
> +#include "util/stat.h"  /* perf_stat__set_big_num */
>  #include "build-id.h"
>  #include "debug.h"
>  #include "config.h"
> @@ -452,6 +453,15 @@ static int perf_ui_config(const char *var, const char *value)
>  	return 0;
>  }
>  
> +static int perf_stat_config(const char *var, const char *value)
> +{
> +	if (!strcmp(var, "stat.big-num"))
> +		perf_stat__set_big_num(perf_config_bool(var, value));
> +
> +	/* Add other config variables here. */
> +	return 0;
> +}
> +
>  int perf_default_config(const char *var, const char *value,
>  			void *dummy __maybe_unused)
>  {
> @@ -473,6 +483,9 @@ int perf_default_config(const char *var, const char *value,
>  	if (strstarts(var, "buildid."))
>  		return perf_buildid_config(var, value);
>  
> +	if (strstarts(var, "stat."))
> +		return perf_stat_config(var, value);
> +
>  	/* Add other config variables here. */
>  	return 0;
>  }
> diff --git a/tools/perf/util/stat.h b/tools/perf/util/stat.h
> index b4fdfaa7f2c0..4bd6dc6cb6aa 100644
> --- a/tools/perf/util/stat.h
> +++ b/tools/perf/util/stat.h
> @@ -132,6 +132,8 @@ struct perf_stat_config {
>  	struct rblist		 metric_events;
>  };
>  
> +void perf_stat__set_big_num(int set);
> +
>  void update_stats(struct stats *stats, u64 val);
>  double avg_stats(struct stats *stats);
>  double stddev_stats(struct stats *stats);
> -- 
> 2.18.2

-- 

- Arnaldo
