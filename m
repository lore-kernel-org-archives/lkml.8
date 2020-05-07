Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A17EC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C25C20870
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 16:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDnZdIO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727898AbgEGQs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 12:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgEGQs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 12:48:29 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DAEAC05BD43;
        Thu,  7 May 2020 09:48:29 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so5344167qtb.5;
        Thu, 07 May 2020 09:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AW9obtpRiN4Zo8/2lcP9bYif4k8AZtpEDBW00i0F1NU=;
        b=PDnZdIO4uYXlA6i6pYBaT2h7w7OwsnxjQi2eLCtOpG8nH/roZD6HOR3Do6fK494Hae
         ut1c9hjmbgbjCS/UM+78aJfkZULzfV6RDz05rpNP7H0wEbjRLYmyYJjp/lA0cYPvXZ1W
         KmO2lerDHQf42NQnn346T2oMWDxV0fY9UHYO4eJN4e7qlGUkm+kBU55GBmcsXj4lzAWt
         rHJouyTlIWmhOpemgI5b5mZ4YoIfEdx1JaQw2f9GZJ8ULHuyCXhj4yc3JwS44PGqnENH
         xwfXsq1zxim6ZN9icKIPWgBTrmOSPHwGyUf75+SO09D9KT+Wu2P/VZWCl/G6tav8XLDR
         csag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AW9obtpRiN4Zo8/2lcP9bYif4k8AZtpEDBW00i0F1NU=;
        b=V16wJsBD3SnIWGZe5B7WXJs85qcfox92LxZgvFQQTkl/BVDY2Dou1FhoE8q6dsUwdg
         rBnz6ii3QPbcpJYNm8PEFenXB5te3LstJt/BTM81CM8b0/S5ilEAqHJ93NL5VxXWIEvM
         ABB7ygLa+QyzdonDzS6wJGJY+YfV6UGMsPvkPNps7IgADyOcHIWOdm+dkkyA9lawiwxf
         JnK5ZeVfLZao7pPsxpoYlrzdNSK5QcMR2RBuVJG+dq56sUcpHQuJCHoDWmcs/Pztr4TH
         7Gku7azgKjTqbzHCeYRLW4dKbIiEE083Z+P5IXYWwsMC0DUGeBxaDdeKJvZmsmQmcjei
         RQHw==
X-Gm-Message-State: AGi0PubHFWZG19OkaSlKZq8evJPl/alyjDJyibtGsA/cBEPADmpZqqAp
        +j16nUYd20k0lC3oNhB+9uA=
X-Google-Smtp-Source: APiQypI51ovO3vBIG2b64isldWqr3WuMch9oE6T7UjEbFytw0Ds2FYR9OuZ4FsE6UEfPjyLKSS5bnQ==
X-Received: by 2002:ac8:7448:: with SMTP id h8mr15637409qtr.225.1588870108254;
        Thu, 07 May 2020 09:48:28 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id d63sm4689492qkb.52.2020.05.07.09.48.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 09:48:27 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9F82B40AFD; Thu,  7 May 2020 13:48:25 -0300 (-03)
Date:   Thu, 7 May 2020 13:48:25 -0300
To:     "Paul A. Clarke" <pc@us.ibm.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        ananth@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        naveen.n.rao@linux.vnet.ibm.com, sukadev@linux.ibm.com,
        mpe@ellerman.id.au, irogers@google.com
Subject: Re: [PATCH 1/2] perf: Fix POWER9 metric 'lsu_other_stall_cpi'
Message-ID: <20200507164825.GE31109@kernel.org>
References: <1588868938-21933-1-git-send-email-pc@us.ibm.com>
 <1588868938-21933-2-git-send-email-pc@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588868938-21933-2-git-send-email-pc@us.ibm.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 11:28:57AM -0500, Paul A. Clarke escreveu:
> From: "Paul A. Clarke" <pc@us.ibm.com>
> 
> The metric definition is too long for the current value of EXPR_MAX_OTHER.
> Increase the value EXPR_MAX_OTHER sufficiently to allow
> 'lsu_other_stall_cpi' to build properly.

I already have a patch from Ian that bumps this further:

[acme@five perf]$ git log -p tools/perf/util/expr.h
commit 26d3350db3e4668c1b1ff7f81c419afe71a2e8d9
Author: Ian Rogers <irogers@google.com>
Date:   Fri May 1 10:33:26 2020 -0700

    perf expr: Increase max other

    Large metrics such as Branch_Misprediction_Cost_SMT on x86 broadwell
    need more space.

    Signed-off-by: Ian Rogers <irogers@google.com>
    Acked-by: Jiri Olsa <jolsa@redhat.com>
    Cc: Adrian Hunter <adrian.hunter@intel.com>
    Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
    Cc: Andi Kleen <ak@linux.intel.com>
    Cc: Haiyan Song <haiyanx.song@intel.com>
    Cc: Jin Yao <yao.jin@linux.intel.com>
    Cc: John Garry <john.garry@huawei.com>
    Cc: Kajol Jain <kjain@linux.ibm.com>
    Cc: Kan Liang <kan.liang@linux.intel.com>
    Cc: Leo Yan <leo.yan@linaro.org>
    Cc: Mark Rutland <mark.rutland@arm.com>
    Cc: Namhyung Kim <namhyung@kernel.org>
    Cc: Paul Clarke <pc@us.ibm.com>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
    Cc: Song Liu <songliubraving@fb.com>
    Cc: Stephane Eranian <eranian@google.com>
    Link: http://lore.kernel.org/lkml/20200501173333.227162-6-irogers@google.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
index 87d627bb699b..40fc452b0f2b 100644
--- a/tools/perf/util/expr.h
+++ b/tools/perf/util/expr.h
@@ -2,7 +2,7 @@
 #ifndef PARSE_CTX_H
 #define PARSE_CTX_H 1

-#define EXPR_MAX_OTHER 20
+#define EXPR_MAX_OTHER 64
 #define MAX_PARSE_ID EXPR_MAX_OTHER

 struct expr_parse_id {

 
> Before:
> --
> $ perf list | grep lsu_other
>   lsu_other_stall_cpi
> # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> Cannot find metric or group `lsu_other_stall_cpi'
> 
>  Usage: perf stat [<options>] [<command>]
> 
>     -M, --metrics <metric/metric group list>
>                           monitor specified metrics or metric groups (separated by ,)
> --
> 
> After:
> --
> # perf stat -a --metrics lsu_other_stall_cpi /bin/sleep 1
> 
>  Performance counter stats for 'system wide':
> 
>        438,086,889      pm_cmplu_stall_lsu        #     1.74 lsu_other_stall_cpi
> [...]
> --
> 
> Signed-off-by: Paul A. Clarke <pc@us.ibm.com>
> ---
>  tools/perf/util/expr.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/util/expr.h b/tools/perf/util/expr.h
> index 87d627bb699b..a0991959cca4 100644
> --- a/tools/perf/util/expr.h
> +++ b/tools/perf/util/expr.h
> @@ -2,7 +2,7 @@
>  #ifndef PARSE_CTX_H
>  #define PARSE_CTX_H 1
>  
> -#define EXPR_MAX_OTHER 20
> +#define EXPR_MAX_OTHER 28
>  #define MAX_PARSE_ID EXPR_MAX_OTHER
>  
>  struct expr_parse_id {
> -- 
> 2.18.2
> 

-- 

- Arnaldo
