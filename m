Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3169CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAC6206D5
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FvddjP1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbgEFU1Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgEFU1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:27:23 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F2C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:27:23 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id h26so2731766qtu.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=h9NXJIvjjH/Rl72iYfyKegofVVENLKU0hyNt0M/oxek=;
        b=FvddjP1RAtXwjyJ2v1v5L5hwr86W46TOjebg2C17znlj3hb3eTVCiyHcMrJypSsiHQ
         VHj+fQYqhd906YB4zMHo8iHHmm5Gj2Jx1RqtR6IK0C656GMsus48FD0H8+RRuWtiSyIy
         Tdn2YYzNfqXORj1UibQEonRcZi8LH6VRTZi8VpTtdtf9peBxRwJ+YdF7tTq081wv/Tmv
         cZOn5C2+WhNEExkN+FWZDM1YL59KR5jyD2XbqiG77H3uTWPWa/nMewlnyZiEzH8OYBS0
         BRl6EAVjyZaIjErMhDEn0EsD4/QBRHrsIGt0Ps0k3n4xlsRK+oFnUJVLr5UczC7+A5ck
         4CiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h9NXJIvjjH/Rl72iYfyKegofVVENLKU0hyNt0M/oxek=;
        b=WU9+WWgF9gesXp1T+amHZFmh9HVX28PLJ+AcIKRFwMcDAHyKmx5GZ6Fdqj7wgb0W2g
         P/jMHQXyQZ0lIJ8E+nvk3hZSFEBHGdWwMuB/MkZNfHHv1zv7X7S5/NmiaQqBoGSh+EHd
         CrN5Mt6gdc/gSba/RyOKjb9AOZODTUeHotCA3Nj6WHHcREoKIb+7DI/VoWkIifdnaoJX
         SDHt5MGqAQZuMm58Y0ngmegLBzvbDLPz5oYxbj4OaJyFwiz6tQrZRs8m88Q3ngaXUCQM
         3Ydt0DhkHDktCXM9GKY7bgskRYzmp7fNFQYwAo1ge0UQPGLo6g6Vf2LbEZ33Q6qR8drO
         eLrg==
X-Gm-Message-State: AGi0PuZg/ilSud9DikOc6Ch7igGBLclS0uQwk7xX7aZffWbdsD0Amj0p
        xHuiUTMbR6kXp4G6kH/RlYMsr5lOaJk=
X-Google-Smtp-Source: APiQypKKjmTK2+dnWq+kBpmP96Str8N92SCN4ApSblee2LWSM6cHKKDDdSlAVuNPZgfUOPrZZ6mEqw==
X-Received: by 2002:ac8:44aa:: with SMTP id a10mr10730827qto.230.1588796842700;
        Wed, 06 May 2020 13:27:22 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x34sm2587505qta.43.2020.05.06.13.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:27:22 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A10F409A3; Wed,  6 May 2020 17:27:20 -0300 (-03)
Date:   Wed, 6 May 2020 17:27:19 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 11/11] perf docs: extend record mode docs with info on
 --ctl-fd[-ack] options
Message-ID: <20200506202719.GJ9893@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <e7d6ffe1-0166-e98a-9693-a944107b9f0e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7d6ffe1-0166-e98a-9693-a944107b9f0e@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 09:30:50PM +0300, Alexey Budankov escreveu:
> 
> Extend perf-record.txt file with --ctl-fd[-ack] options description.
> Document possible usage model introduced by --ctl-fd[-ack] options
> by providing example bash shell script.

Ditto, combine this patch with the one that introduces these options.
 
> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 39 ++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index 561ef55743e2..eabb00ed2f5d 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -613,6 +613,45 @@ appended unit character - B/K/M/G
>  	The number of threads to run when synthesizing events for existing processes.
>  	By default, the number of threads equals 1.
>  
> +--ctl-fd::
> +--ctl-fd-ack::
> +Listen on ctl-fd descriptor for command to control measurement ('e': enable events,
> +'d': disable events. Optionally send control command completion ('a') to fd-ack
> +descriptor to synchronize with the controlling process. Example of bash shell script
> +to enable and disable events during measurements:
> +
> +#!/bin/bash
> +
> +ctl_dir=/tmp/
> +
> +ctl_fifo=${ctl_dir}perf_ctl.fifo
> +test -p ${ctl_fifo} && unlink ${ctl_fifo}
> +mkfifo ${ctl_fifo}
> +exec {ctl_fd}<>${ctl_fifo}
> +
> +ctl_ack_fifo=${ctl_dir}perf_ctl_ack.fifo
> +test -p ${ctl_ack_fifo} && unlink ${ctl_ack_fifo}
> +mkfifo ${ctl_ack_fifo}
> +exec {ctl_fd_ack}<>${ctl_ack_fifo}
> +
> +perf record -D -1 -e cpu-cycles -a                        \
> +            --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
> +            -- sleep 30 &
> +perf_pid=$!
> +
> +sleep 5  && echo 'e' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "resumed(${e1})"
> +sleep 10 && echo 'd' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "paused(${d1})"
> +
> +exec {ctl_fd_ack}>&-
> +unlink ${ctl_ack_fifo}
> +
> +exec {ctl_fd}>&-
> +unlink ${ctl_fifo}
> +
> +wait -n ${perf_pid}
> +exit $?
> +
> +
>  SEE ALSO
>  --------
>  linkperf:perf-stat[1], linkperf:perf-list[1], linkperf:perf-intel-pt[1]
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
