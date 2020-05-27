Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99186C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71F1120873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 15:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590594279;
	bh=u9oPkAh37VTAfqP4PcrPV7RR+DZcnntoUfHgdZxYdNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=liN2HeyOefwQPnZAS+6UnOH4MrC0qfBF5f7Y6cEdMg7FkFi0550Ia0HWfcXhZuq2D
	 nmTAjmp0YaUOHgZXDvuPbIGx3kd//71ozEfntYkeTJ8Se3Xqrtv0JMZHWE57pBT4ZX
	 uOpsTm5qW9CQHLwr5VZ4nR3cANzXD5TASg0bvlJY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388275AbgE0Poi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 11:44:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:52898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgE0Poi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 11:44:38 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E48320776;
        Wed, 27 May 2020 15:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590594278;
        bh=u9oPkAh37VTAfqP4PcrPV7RR+DZcnntoUfHgdZxYdNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f8+0VMpQWzYcEKAfaN5rpLSXkZ5QsBmmJ39D7SZ/e364KsDu31X5i24Ct19fK2cRM
         d93XY8CRIaUsBo06Qqra2/d9YKI5drix2v5OqLkii36rfapQrNGmhKVNbxSudU662k
         CyJrsbXXq657yEwk1TSUaVBduIUOHCHrHZyiaeDg=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CD6DD40AFD; Wed, 27 May 2020 12:44:30 -0300 (-03)
Date:   Wed, 27 May 2020 12:44:30 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V7 09/15] perf kcore_copy: Fix module map when there are
 no modules loaded
Message-ID: <20200527154430.GA16490@kernel.org>
References: <20200512121922.8997-1-adrian.hunter@intel.com>
 <20200512121922.8997-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512121922.8997-10-adrian.hunter@intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, May 12, 2020 at 03:19:16PM +0300, Adrian Hunter escreveu:
> In the absence of any modules, no "modules" map is created, but there are
> other executable pages to map, due to eBPF JIT, kprobe or ftrace. Map them
> by recognizing that the first "module" symbol is not necessarily from a
> module, and adjust the map accordingly.

Applied,

- Arnaldo
 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  tools/perf/util/symbol-elf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tools/perf/util/symbol-elf.c b/tools/perf/util/symbol-elf.c
> index be5b493f8284..5e43054bffea 100644
> --- a/tools/perf/util/symbol-elf.c
> +++ b/tools/perf/util/symbol-elf.c
> @@ -1458,6 +1458,7 @@ struct kcore_copy_info {
>  	u64 first_symbol;
>  	u64 last_symbol;
>  	u64 first_module;
> +	u64 first_module_symbol;
>  	u64 last_module_symbol;
>  	size_t phnum;
>  	struct list_head phdrs;
> @@ -1534,6 +1535,8 @@ static int kcore_copy__process_kallsyms(void *arg, const char *name, char type,
>  		return 0;
>  
>  	if (strchr(name, '[')) {
> +		if (!kci->first_module_symbol || start < kci->first_module_symbol)
> +			kci->first_module_symbol = start;
>  		if (start > kci->last_module_symbol)
>  			kci->last_module_symbol = start;
>  		return 0;
> @@ -1731,6 +1734,10 @@ static int kcore_copy__calc_maps(struct kcore_copy_info *kci, const char *dir,
>  		kci->etext += page_size;
>  	}
>  
> +	if (kci->first_module_symbol &&
> +	    (!kci->first_module || kci->first_module_symbol < kci->first_module))
> +		kci->first_module = kci->first_module_symbol;
> +
>  	kci->first_module = round_down(kci->first_module, page_size);
>  
>  	if (kci->last_module_symbol) {
> -- 
> 2.17.1
> 

-- 

- Arnaldo
