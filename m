Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD8CC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD2820643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFppU/it"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEGOwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEGOwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:52:23 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF713C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:52:21 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id g16so4911444qtp.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WL/t9qE3+BAvQf1Jr0p8vij392YMfCOS2shO2YG+Teg=;
        b=lFppU/itbca0im+qFX0dAnObD6Uxu4HbNf+tXnjPVzJKx4BP6YrzJFJyGoIaRVErgV
         UGcWaG0c5e2k5Pkg7pJvUKXDeDBTO3ArpjPwuKLaCCndBiSQuuRZhTDe2PEXhCKgfWAA
         9J8t80FAEiKY8Iv8FjYtpN5H2z6iEJGXmAxyOMKAaNypRmtxGE9w8bYP1jp5UADJgIXt
         0dzSyR1byTembSnpND7VGWRq/wMCsquUoGsCLaPqnu1rVGaBssurq7Bwi79iyuJG5aib
         TqevVY92nN3DOPdDk4R937IX7xyYg8lq/aWo/76F6q0vhwVVu/oFuWGj2fsbYQ+5IAXP
         3trw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WL/t9qE3+BAvQf1Jr0p8vij392YMfCOS2shO2YG+Teg=;
        b=efE+0ISqy5RuV76i+CrFb7ZVbz/C1aRfhcf1SVqHkjIr8fX6HrcFrqfDMz3w0fANtL
         PUQQhgyvnK8vzwFTmmc8A5GaDjBdxwWlfklYJomaqnsFUGakeuPWs+U4f2Yqpr+W7zNC
         C1I15f+zoAtwShpmmfmHZUGD6sx20ClGOiYq4xS6hgubaJ9ThkBEQ8rLvy1my1biKl8l
         39efm5AQuJvwUoMOXe0aLGpln3HX8P9Ll8PqC84DrSoIxwG5JksdGbAPC4UUPNOvzG+b
         l8JHrsAstlW0ZKbusei32wTdZwFdTY6J2ZN5kh2aiyl2AX3SsPjURlDaFNJdV9ZBcaPI
         0GXA==
X-Gm-Message-State: AGi0Pubb9/cplzHJ+WWLcKhBbBifucMnbWI0yObPw728Lz+o280aa7Lj
        cNuV9kGYevsCMZaOFiYRahM=
X-Google-Smtp-Source: APiQypJ7U0tDQwluiuO0qo5gFGm1ZkQtVRZy2uGUyDkcmmW6DUf2eLVMRCz3PBubAw/aXteZFuf6zA==
X-Received: by 2002:ac8:6684:: with SMTP id d4mr8291352qtp.189.1588863140985;
        Thu, 07 May 2020 07:52:20 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id w69sm4214507qka.75.2020.05.07.07.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 07:52:20 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B60740AFD; Thu,  7 May 2020 11:52:17 -0300 (-03)
Date:   Thu, 7 May 2020 11:52:17 -0300
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>, Paul Khuong <pvk@pvk.ca>
Subject: Re: [PATCH 1/5] perf tools: Do not display extra info when there is
 nothing to build
Message-ID: <20200507145217.GA32641@kernel.org>
References: <20200507095024.2789147-1-jolsa@kernel.org>
 <20200507095024.2789147-2-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507095024.2789147-2-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 07, 2020 at 11:50:20AM +0200, Jiri Olsa escreveu:
> Even with fully built tree, we still display extra output
> when make is invoked, like:
> 
>   $ make
>     BUILD:   Doing 'make -j8' parallel build
>     DESCEND  plugins
>   make[3]: Nothing to be done for 'plugins/libtraceevent-dynamic-list'.
> 
> Changing the make descend directly to plugins directory,
> which quiets those messages down.

Thanks a lot for getting rid of that nuisance :-)

- Arnaldo
 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.perf | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 94a495594e99..30e41dcd4095 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -278,6 +278,7 @@ strip-libs = $(filter-out -l%,$(1))
>  
>  ifneq ($(OUTPUT),)
>    TE_PATH=$(OUTPUT)
> +  PLUGINS_PATH=$(OUTPUT)
>    BPF_PATH=$(OUTPUT)
>    SUBCMD_PATH=$(OUTPUT)
>    LIBPERF_PATH=$(OUTPUT)
> @@ -288,6 +289,7 @@ else
>  endif
>  else
>    TE_PATH=$(TRACE_EVENT_DIR)
> +  PLUGINS_PATH=$(TRACE_EVENT_DIR)plugins/
>    API_PATH=$(LIB_DIR)
>    BPF_PATH=$(BPF_DIR)
>    SUBCMD_PATH=$(SUBCMD_DIR)
> @@ -297,7 +299,7 @@ endif
>  LIBTRACEEVENT = $(TE_PATH)libtraceevent.a
>  export LIBTRACEEVENT
>  
> -LIBTRACEEVENT_DYNAMIC_LIST = $(TE_PATH)plugins/libtraceevent-dynamic-list
> +LIBTRACEEVENT_DYNAMIC_LIST = $(PLUGINS_PATH)libtraceevent-dynamic-list
>  
>  #
>  # The static build has no dynsym table, so this does not work for
> @@ -756,10 +758,10 @@ $(LIBTRACEEVENT): FORCE
>  	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent.a
>  
>  libtraceevent_plugins: FORCE
> -	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
> +	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR)plugins $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) plugins
>  
>  $(LIBTRACEEVENT_DYNAMIC_LIST): libtraceevent_plugins
> -	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR) $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)plugins/libtraceevent-dynamic-list
> +	$(Q)$(MAKE) -C $(TRACE_EVENT_DIR)plugins $(LIBTRACEEVENT_FLAGS) O=$(OUTPUT) $(OUTPUT)libtraceevent-dynamic-list
>  
>  $(LIBTRACEEVENT)-clean:
>  	$(call QUIET_CLEAN, libtraceevent)
> -- 
> 2.25.4
> 

-- 

- Arnaldo
