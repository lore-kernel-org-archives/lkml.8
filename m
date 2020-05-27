Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400B1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:08:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4F5207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 14:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590588482;
	bh=C+fyE5snjSW0wurnYjLepMoojkVqeGo12cjI4Sl3UGY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MEUJd5l0EodUR3wawBlap22X73wcEndVlgkKq/Q1JGtVFyy75lZLRy46C1GoNGfTm
	 m3Q3hfKBMARtrvSA8ZESJD7PCOf6+xmVtK+H/txvprV92Zsy/QWwabUZmUH4Xojjan
	 iyLHneiYn+EFll1EqNGEW93RVZc85BajumexYgCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388779AbgE0OIB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 10:08:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388623AbgE0OIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 10:08:00 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8FAA207D3;
        Wed, 27 May 2020 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590588480;
        bh=C+fyE5snjSW0wurnYjLepMoojkVqeGo12cjI4Sl3UGY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EfwTqzFJqXFu0FZiDOyRAvOGH8n+GxPdxahnlUxU6Z4tTdsdydEYQ0vaaIqTjF9vA
         hTisCa8TdDT0aIwZ2nl1FLanYc651GLRGlnl9nd6UgJQMu4drhamKS0TbiXVbnElBR
         10MfWQoFEAcN3+8Rdp8+bHlCooUpZmkPaeYOLUwI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EC13940AFD; Wed, 27 May 2020 11:07:53 -0300 (-03)
Date:   Wed, 27 May 2020 11:07:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nick Gasson <nick.gasson@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] perf jvmti: Do not report error when missing debug
 information
Message-ID: <20200527140753.GD14219@kernel.org>
References: <20200427061520.24905-1-nick.gasson@arm.com>
 <20200427061520.24905-3-nick.gasson@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427061520.24905-3-nick.gasson@arm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 27, 2020 at 02:15:15PM +0800, Nick Gasson escreveu:
> If the Java sources are compiled with -g:none to disable debug
> information the perf JVMTI plugin reports a lot of errors like:
> 
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
>   java: GetLineNumberTable failed with JVMTI_ERROR_ABSENT_INFORMATION
> 
> Instead if GetLineNumberTable returns JVMTI_ERROR_ABSENT_INFORMATION
> simply skip emitting line number information for that method. Unlike the
> previous patch these errors don't affect the jitdump generation, they
> just generate a lot of noise.
> 
> Similarly for native methods which also don't have line tables.
> 
> Signed-off-by: Nick Gasson <nick.gasson@arm.com>
> ---
>  tools/perf/jvmti/libjvmti.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/perf/jvmti/libjvmti.c b/tools/perf/jvmti/libjvmti.c
> index 50ef524b5cd4..a9a056d68416 100644
> --- a/tools/perf/jvmti/libjvmti.c
> +++ b/tools/perf/jvmti/libjvmti.c
> @@ -41,7 +41,11 @@ do_get_line_numbers(jvmtiEnv *jvmti, void *pc, jmethodID m, jint bci,
>  	jvmtiError ret;
>  
>  	ret = (*jvmti)->GetLineNumberTable(jvmti, m, &nr_lines, &loc_tab);
> -	if (ret != JVMTI_ERROR_NONE) {
> +	if (ret == JVMTI_ERROR_ABSENT_INFORMATION || ret == JVMTI_ERROR_NATIVE_METHOD) {
> +		/* No debug information for this method */
> +		*nr = 0;
> +		return JVMTI_ERROR_NONE;
> +	} else if (ret != JVMTI_ERROR_NONE) {
>  		print_error(jvmti, "GetLineNumberTable", ret);
>  		return ret;
>  	}
> @@ -93,6 +97,9 @@ get_line_numbers(jvmtiEnv *jvmti, const void *compile_info, jvmti_line_info_t **
>  					/* free what was allocated for nothing */
>  					(*jvmti)->Deallocate(jvmti, (unsigned char *)lne);
>  					nr_total += (int)nr;
> +				} else if (ret == JVMTI_ERROR_ABSENT_INFORMATION
> +					   || ret == JVMTI_ERROR_NATIVE_METHOD) {

Please add the || operator at the end of the line next time, I'm fixing
this up this time,

Applied,

- Arnaldo

> +					/* No debug information for this method */
>  				} else {
>  					print_error(jvmti, "GetLineNumberTable", ret);
>  				}
> @@ -262,7 +269,9 @@ compiled_method_load_cb(jvmtiEnv *jvmti,
>  	if (has_line_numbers && map && map_length) {
>  		ret = get_line_numbers(jvmti, compile_info, &line_tab, &nr_lines);
>  		if (ret != JVMTI_ERROR_NONE) {
> -			warnx("jvmti: cannot get line table for method");
> +			if (ret != JVMTI_ERROR_NOT_FOUND) {
> +				warnx("jvmti: cannot get line table for method");
> +			}
>  			nr_lines = 0;
>  		} else if (nr_lines > 0) {
>  			line_file_names = malloc(sizeof(char*) * nr_lines);
> -- 
> 2.26.1
> 

-- 

- Arnaldo
