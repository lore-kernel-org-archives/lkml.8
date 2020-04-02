Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E26CC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:47:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C46E206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 18:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmknKzAV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389861AbgDBSrA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:47:00 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33916 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389065AbgDBSrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 14:47:00 -0400
Received: by mail-qk1-f196.google.com with SMTP id i6so5240156qke.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dXVWLfrzQLz9ldDmZiHb+Wo0RX97FUTCGHhMzjSQ8AM=;
        b=fmknKzAV4KERhKF4ax56ab+yVFpGt8rMySmTpQMATDetlRC9mOj1r+Rb6PUgKIInsy
         Te5zA32yR7rmWCU/71iMPboESBFTmKU9L68scqxy0ys968lIIn/3F1i6klHb5Q4ER057
         XPYThOAEpQ2twwWUS1+RnCCISuamaHvfjT5L9jhbO2KfIOberOWnZ5s1I8L55VOp6/pm
         EgUgzhK9NEwOv5Zx3OOEjy2qUQAYhWG084Th2VghrjZsLB/ZURLpeClzlJncjvjmunLd
         ajMaRE14Z+Y2op5ujI/nZsJ8A5T3MdeJ6xfDruJQxesjAsMPy2JhkodYWrCkXyDodRrU
         IFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dXVWLfrzQLz9ldDmZiHb+Wo0RX97FUTCGHhMzjSQ8AM=;
        b=XOexIp7OuF6pJ26Sa890vNSVTWtKsm1yU70SrqFlRVemqjjwO3o6MIUbNH5MQB5GBi
         oXQ+VBQZFydNA3zeYRcEEKUL5x+JVB5+r/wESt+NFOpcen4673XOQuXX3+Ux5USFFSnE
         xF2oiXNE5wol5uIPq0uHqwcOihmylYpIALL1oUnxoFzkM0fma84cm69rQX3EpfSnIXQE
         H8PXaTvjqiaEJLLIbwOFP1VlgBPG7hEzOMAKrrTuaNQHkBjIs7iGJz4Vy4deNS6kJrED
         SaCgTtEjvAq8JhTQoYehk79eXUrRtD8I2zzJr4tsSvuSxhKcAGwcvtNOPPBHZARv/adS
         QHOw==
X-Gm-Message-State: AGi0PuZpbklMx+O48hxAYuU3N6mjxV4z4rDfxxwr9csPOC2RVb6E9zj/
        M3aKy8XPUpBlINCiECYDKPg=
X-Google-Smtp-Source: APiQypKb+DA2rsVAPRzri9hSl8z855dEJtKx3rj+8iRejodaUSf25tiUZpLte7S+dGyK1uITTn63cg==
X-Received: by 2002:a37:9d53:: with SMTP id g80mr140671qke.116.1585853218615;
        Thu, 02 Apr 2020 11:46:58 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id m10sm4247636qte.71.2020.04.02.11.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 11:46:58 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0AA8A409A3; Thu,  2 Apr 2020 15:46:56 -0300 (-03)
Date:   Thu, 2 Apr 2020 15:46:56 -0300
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH] perf script: add -S/--symbols documentation
Message-ID: <20200402184656.GA23243@kernel.org>
References: <20200402174130.140319-1-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402174130.140319-1-irogers@google.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Apr 02, 2020 at 10:41:30AM -0700, Ian Rogers escreveu:
> Capture both that this option exists and that symbols can be hexadecimal
> addresses.

Thanks, applied.
 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  tools/perf/Documentation/perf-script.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
> index 99a9853a11ba..963487e82edc 100644
> --- a/tools/perf/Documentation/perf-script.txt
> +++ b/tools/perf/Documentation/perf-script.txt
> @@ -412,6 +412,14 @@ include::itrace.txt[]
>  --xed::
>  	Run xed disassembler on output. Requires installing the xed disassembler.
>  
> +-S::
> +--symbols=symbol[,symbol...]::
> +	Only consider the listed symbols. Symbols are typically a name
> +	but they may also be hexadecimal address.
> +
> +	For example, to select the symbol noploop or the address 0x4007a0:
> +	perf script --symbols=noploop,0x4007a0
> +
>  --call-trace::
>  	Show call stream for intel_pt traces. The CPUs are interleaved, but
>  	can be filtered with -C.
> -- 
> 2.26.0.rc2.310.g2932bb562d-goog
> 

-- 

- Arnaldo
