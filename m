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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CDEC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813A72063A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beHTKUlq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728887AbgEFUWj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726495AbgEFUWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:22:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DDC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:22:38 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f13so3608282qkh.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9s4I1o5IX8Wg3SHujx9lxLs/R1td5fuwj/H84wrEJI=;
        b=beHTKUlqp5XjjG6AK5zSrrUylmowierhhUXhyTI2hrMVKM0luwyjMnPSOAI95wvBkM
         5y18/CVUT+oGu6IaFS6Oo3mhyPn3qs8k7cdY5oG6LLIO426dzmQY/xsrzQ+brYaAkmw8
         6rzliHX0qw8pyqO9LnCHIC3B3UZKrX4bglm1JyCek43GP62kivJb2S5aX0VKm4syTBkW
         ioR3GzhyReaRTv8okeVIMdLOKoikpTTZZLsPZQ+tScYAJXUYo27bZ7JON2iEdN8slKPQ
         kbifUpyM2OdLglm+M13PxG3/uUgsK4LqTnPOcLyE/ZVVdHhNjvBZ50Y4hHA4yH30fHAU
         B2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9s4I1o5IX8Wg3SHujx9lxLs/R1td5fuwj/H84wrEJI=;
        b=cx7kdzrfhli7RYpt2PpeZ0CNRVOq6ZM8QrlxXagO7fx6tjDm3w5yanvQNEkwEAYW50
         cPw6Xwp+cNAh55Nwtz0qL6cN8e3V5G22vRdXR0C/gUAhlTyMuS5PSOY1CXI1a+E2MA4+
         hMVod9a/BGAAPi6LIvhlpkvetiNCX1BsyyUpnVTFqobkvyz+kNCnDl8CrxnpKH7iInsj
         F/piyMkCZ3iXBGxvXXzMSTJCjrib95B5MXJqptF7Og5BgABRK1aC0F44F2GahTFr9DYL
         NbeFiR4KB6jzCQOtcF9FbjYieBhJUUhb1FHs2gCKPbk91C86G5vrw8g5dHJdVbYJdVwJ
         mUnw==
X-Gm-Message-State: AGi0PuZ0WLKQY9MxDRXN8i4I+gG05hERA0TZ2SOfL5n/gKkrh9w08FPZ
        ZdRgwp97jCWaiejdxGibamI=
X-Google-Smtp-Source: APiQypL/sxHUM6T38hPCuD62zSydsds8AC//JUP+NDtjPb4/dzPHhCBKn3OCcUwFK5fHk9o+qQh5vg==
X-Received: by 2002:a37:a749:: with SMTP id q70mr10715738qke.68.1588796557931;
        Wed, 06 May 2020 13:22:37 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id z90sm2501612qtd.75.2020.05.06.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 13:22:37 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1B947409A3; Wed,  6 May 2020 17:22:35 -0300 (-03)
Date:   Wed, 6 May 2020 17:22:35 -0300
To:     Alexey Budankov <alexey.budankov@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 07/11] perf docs: extend stat mode docs with info on
 --ctl-fd[-ack] options
Message-ID: <20200506202235.GG9893@kernel.org>
References: <d582cc3d-2302-c7e2-70d3-bc7ab6f628c3@linux.intel.com>
 <fb7c1fb9-2f6b-eb4b-d256-51253b29b4ac@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb7c1fb9-2f6b-eb4b-d256-51253b29b4ac@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 06, 2020 at 09:22:55PM +0300, Alexey Budankov escreveu:
> 
> Extend perf-stat.txt file with --ctl-fd[-ack] options description.
> Document possible usage model introduced by --ctl-fd[-ack] options
> by providing example bash shell script.

Please update the docs in the same patch that introduces the options
being documented.

- Arnaldo

> Signed-off-by: Alexey Budankov <alexey.budankov@linux.intel.com>
> ---
>  tools/perf/Documentation/perf-stat.txt | 40 ++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> index 3fb5028aef08..19ed53e08294 100644
> --- a/tools/perf/Documentation/perf-stat.txt
> +++ b/tools/perf/Documentation/perf-stat.txt
> @@ -164,6 +164,46 @@ with it.  --append may be used here.  Examples:
>       3>results  perf stat --log-fd 3          -- $cmd
>       3>>results perf stat --log-fd 3 --append -- $cmd
>  
> +--ctl-fd::
> +--ctl-fd-ack::
> +
> +Listen on ctl-fd descriptor for command to control measurement ('e': enable events,
> +'d': disable events). Optionally send control command completion ('a') to fd-ack
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
> +perf stat -D -1 -e cpu-cycles -a -I 1000                \
> +          --ctl-fd ${ctl_fd} --ctl-fd-ack ${ctl_fd_ack} \
> +          -- sleep 30 &
> +perf_pid=$!
> +
> +sleep 5  && echo 'e' >&${ctl_fd} && read -u ${ctl_fd_ack} e1 && echo "enabled(${e1})"
> +sleep 10 && echo 'd' >&${ctl_fd} && read -u ${ctl_fd_ack} d1 && echo "disabled(${d1})"
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
>  --pre::
>  --post::
>  	Pre and post measurement hooks, e.g.:
> -- 
> 2.24.1
> 
> 

-- 

- Arnaldo
