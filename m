Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AABC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45CEE22261
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 14:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599662926;
	bh=I/BuSjwh37WfU0KbhjgeLgeoZag8kYlwsv0uru7BOck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NgfTladA/iNTcfio6KuhnBO2dauyxpuM0+eRvTlYosNF1XJ+0NCLMy0FEbJhuEOdk
	 0NY0chtsbxSpNdkQMxx50RmY5vHC2sW3X0RYyVdeOZ4JcrsEkYvgvRfU78hC9Onxeg
	 Y2ojMAH7eT7jgjFGGS5fcTNWtB38gQ1KkeOHOBp8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730544AbgIIOsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 10:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:37098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730179AbgIIMfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 08:35:40 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.37.151])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBCDF21D82;
        Wed,  9 Sep 2020 12:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599654478;
        bh=I/BuSjwh37WfU0KbhjgeLgeoZag8kYlwsv0uru7BOck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dHXD+AqK7CQ2nI30zlH5jAj4Y25gkwqhowHovWDzHgLRWec7KI/CclOURxZBbua80
         tXmoj7W3W7CFlWNNJrDeFzlZOX1vNPtmzHxExA+/oy098NDSIAg49AJgKPDJ7IEYq5
         TzhLJy0eW7LQ8w0KwyA1ul8PcMWuFLcDsocZXRmo=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7820840D3D; Wed,  9 Sep 2020 09:27:55 -0300 (-03)
Date:   Wed, 9 Sep 2020 09:27:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH 1/3] perf list: Remove dead code in argument check
Message-ID: <20200909122755.GA3788224@kernel.org>
References: <20200909055849.469612-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909055849.469612-1-namhyung@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Sep 09, 2020 at 02:58:47PM +0900, Namhyung Kim escreveu:
> The sep is already checked being not NULL.  The code seems to be a
> leftover from some refactoring.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

There is a missing --- separator from the description to the patch, I
had to add it so that 'git am' works on it, please check.

- Arnaldo

I.e. it should be right here:

---

> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 0a7fe4cb5555..10ab5e40a34f 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -92,13 +92,6 @@ int cmd_list(int argc, const char **argv)
>  		else if ((sep = strchr(argv[i], ':')) != NULL) {
>  			int sep_idx;
>  
> -			if (sep == NULL) {
> -				print_events(argv[i], raw_dump, !desc_flag,
> -							long_desc_flag,
> -							details_flag,
> -							deprecated);
> -				continue;
> -			}
>  			sep_idx = sep - argv[i];
>  			s = strdup(argv[i]);
>  			if (s == NULL)
> -- 
> 2.28.0.526.ge36021eeef-goog
> 

-- 

- Arnaldo
