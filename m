Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53850C3F365
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2093B20578
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cO+c2hi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbgB0Nu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:50:28 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33545 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730527AbgB0Nu0 (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:50:26 -0500
Received: by mail-qk1-f195.google.com with SMTP id h4so3176286qkm.0
        for <Linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 05:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ZtJYarfQ4PUER8bNBbaBiuSEQmdlVvpEQQaAlVS/lE=;
        b=cO+c2hi+XjV0sk2B/DcuqXeYLyiIWTbO6dvLpso8eixlvu++TdGtBCtVYCOWBMkaO+
         8+pkUMnYObjk1u6Oy80/RVAfWhWbm/6UHFbt44yejGgyl+hAen19HbFF7PjhU+rEQvpV
         YmF3upgICQyLbOqRFxm8WSiHu5LqBliz1lAjCW4/A4fyb2be/dOYutJjP3I5Qbs4jC9B
         FVMNBsqx7GJ8nwsrn0WC52nWyfqXBKfyxlK9Q1q4JTd7KfUCYUXRM9BM4SFMZeLOpLcs
         lAf4rq/NWCE3bF/ORlvqOH/IM3iECjTEF2G1zBQPpYihzHUUmPH5Pyijlfx1EB19HeDo
         zzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ZtJYarfQ4PUER8bNBbaBiuSEQmdlVvpEQQaAlVS/lE=;
        b=n424h3Q1sf4hJbOpYk6gd3QpgaDn0AlubC1i6QFzVWQUV7VxP/8tL1fLddeNSSjz98
         JIZXYQHyhqKOD9dWrQgAy8SlQnWLsw3+VLZ4WDjQqFpoCKXr9nlpBlierJ2UeMKB7Q4m
         C5oJljexHSdlhLS4nNCtVZoUiAlcrwn4EVWTYEUbeNIWmGMvaOt7z21A93hlUtWMr0dZ
         GkvAelj52WEVvRtkCAWPqxuQv7flWT5wkVjsgykv2XvGqDvA0LTj7VMiy5M3dgeXafnx
         AmebNmmF5ahCa93nET+Z4JblOqwieHnS0wlnZ8+ibMcryUbb7RzfEgJ7/nj6yZmzby1M
         m2/w==
X-Gm-Message-State: APjAAAWbXEQMaaDTcoXLZM2NrTvzwpvUgNLhHxheAtVVIAHsH36Q9sKt
        C1BC9s1MqTsI2qLTikSIU+s=
X-Google-Smtp-Source: APXvYqwIGdwF+x6VN9ZzGaR7ucIPL5ke/J64C3tdTG/fu1R+si4XJwN8SpXUiGTHHvvFb7rV/AuyIQ==
X-Received: by 2002:a05:620a:7ee:: with SMTP id k14mr5656030qkk.170.1582811426059;
        Thu, 27 Feb 2020 05:50:26 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id j22sm3071847qkk.45.2020.02.27.05.50.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 05:50:25 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 558B8403AD; Thu, 27 Feb 2020 10:50:23 -0300 (-03)
Date:   Thu, 27 Feb 2020 10:50:23 -0300
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v3 0/2] perf report: Support annotation of code without
 symbols
Message-ID: <20200227135023.GD10761@kernel.org>
References: <20200224022225.30264-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224022225.30264-1-yao.jin@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 24, 2020 at 10:22:23AM +0800, Jin Yao escreveu:
> For perf report on stripped binaries it is currently impossible to do
> annotation. The annotation state is all tied to symbols, but there are
> either no symbols, or symbols are not covering all the code.
> 
> We should support the annotation functionality even without symbols.
> 
> The first patch uses al_addr to print because it's easy to dump
> the instructions from this address in binary for branch mode.
> 
> The second patch supports the annotation on stripped binary.

I'm considering this a new feature, so I'll leave this for perf/core,
i.e. for the next release, ok?

I'm now going thru the pure fixes that should go to perf/urgent, please
holler if something you think should go in now is not in my perf/urgent
branch.

- Arnaldo
 
>  v3:
>  ---
>  Keep just the ANNOTATION_DUMMY_LEN, and remove the
>  opts->annotate_dummy_len since it's the "maybe in future
>  we will provide" feature.
> 
>  v2:
>  ---
>  Fix a crash issue when annotating an address in "unknown" object.
> 
> Jin Yao (2):
>   perf util: Print al_addr when symbol is not found
>   Support interactive annotation of code without symbols
> 
>  tools/perf/ui/browsers/hists.c | 43 +++++++++++++++++++++++++++++-----
>  tools/perf/util/annotate.h     |  1 +
>  tools/perf/util/sort.c         |  6 +++--
>  3 files changed, 42 insertions(+), 8 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 

- Arnaldo
