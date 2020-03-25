Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC0DC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 895DC206F6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 19:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qagseZ7B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbgCYTSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 15:18:02 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45745 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727174AbgCYTSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 15:18:02 -0400
Received: by mail-qt1-f195.google.com with SMTP id t17so3176289qtn.12;
        Wed, 25 Mar 2020 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zWxj3PdIvUUpkGReApO1ODxbBTgGA9xvm/zAEMplovk=;
        b=qagseZ7BisKt4vbRff0G9w5Fciqz7y5bUFx9MCP/Qo24wbY9c5SsDODqIVKXl/tAuB
         DrtbaKvpsJra/RlrljZPRUFqn/kFszcxHL2VpagZUis7++EKenxefHfjhV2S3rgqwH/w
         CJvixbUSjDv7HNFdycAaPCKxdUdDfKl6WO4Khb5fstFI9OjB5sNxqDuVLfZ4POB9lxA0
         sNdGweMpxwwehX/MKeBJ7xawpqszvUQeoyvg2alyUWPSNXyMan+RmPTm2P0S6KoW4Dqv
         n5HLUsEVMbyF/1AXKjI9xb50+F/wG1tH74B6P0Gle/Sr+4oIPCAOoBmuxYFUO6RE04MS
         dUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zWxj3PdIvUUpkGReApO1ODxbBTgGA9xvm/zAEMplovk=;
        b=GOABxAUljX6mgOkod31yGxsuK/bkPpTLamG1KzQdZRsaXEYWfX+p7TOoz5zc1iINI8
         Ej05b1Omf8Jd+erG6LhjYoVxWFegJxKejVj91purysWCWaGpsKdZ+30CJCHr+iedMPsm
         ZD1WAf/ur55bRFYC/eoGD5tH8BIxPUpIoN/ELYMsdyjyi/mu2HWWFS4bIjFcmRQRLO8Z
         /uguMf67a/5j+rNyXgm8+JiQK+99oV9N/ZeQFDTRhjLSvxlTdgepKtOGUC7QIlfDZkWs
         NOQK0V2Ue2t1QN+/nLuDpAuyzRmYWfUu1nKxPvLoQA+6BTLDrwf7kWaPYPrKFHUa+nDf
         rBuQ==
X-Gm-Message-State: ANhLgQ2WpfCU3nh8NDD293ZITl+p5Fzn/ZuZek9C5sWgoqGNpqnUhjo+
        uVnQKOoqMspu7XIL8/EEmHg=
X-Google-Smtp-Source: ADFU+vsbDJcnuLb/90+roQJSvOWGHCibEqOM43TnWZFtuk/pLdx1xwSLjVns4WLRe2mrux+VJsjyKg==
X-Received: by 2002:ac8:7501:: with SMTP id u1mr4617686qtq.149.1585163880718;
        Wed, 25 Mar 2020 12:18:00 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id t53sm17979357qth.70.2020.03.25.12.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 12:18:00 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EB23A40F77; Wed, 25 Mar 2020 16:17:57 -0300 (-03)
Date:   Wed, 25 Mar 2020 16:17:57 -0300
To:     Tony Jones <tonyj@suse.de>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf tools: update docs regarding kernel/user space
 unwinding
Message-ID: <20200325191757.GG14102@kernel.org>
References: <20200325164053.10177-1-tonyj@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325164053.10177-1-tonyj@suse.de>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 25, 2020 at 09:40:53AM -0700, Tony Jones escreveu:
> The method of unwinding for kernel space is defined by the kernel config, 
> not by the value of --call-graph.   Improve the documentation to reflect 
> this.

Fixed the callgraph -> call-graph bit, as you pointed out privately,
applied.

About your question, to get the answer in some public location as
documentation about perf usage:

> As an aside, for record path, do you know where PERF_SAMPLE_CALLCHAIN
> is actually set before being passed to kernel space?

So, I think is somewhere down from perf_evsel__config()... its in:

	perf_evsel__set_sample_bit(evsel, CALLCHAIN);

which is set at:

$ perf probe -x ~/bin/perf -L __perf_evsel__config_callchain
<__perf_evsel__config_callchain@/home/acme/git/perf/tools/perf/util/evsel.c:0>
      0  static void __perf_evsel__config_callchain(struct evsel *evsel,
                                                   struct record_opts *opts,
                                                   struct callchain_param *param)
      3  {
      4         bool function = perf_evsel__is_function_event(evsel);
      5         struct perf_event_attr *attr = &evsel->core.attr;

      7         perf_evsel__set_sample_bit(evsel, CALLCHAIN);

      9         attr->sample_max_stack = param->max_stack;

     11         if (opts->kernel_callchains)
     12                 attr->exclude_callchain_user = 1;
     13         if (opts->user_callchains)
     14                 attr->exclude_callchain_kernel = 1;
     15         if (param->record_mode == CALLCHAIN_LBR) {


Line 7 of __perf_evsel__config_callchain(), so lets use perf probe +
perf trace + perf callchains to see where perf callchains are asked from
the kernel:

[root@seventh ~]# perf probe -x ~/bin/perf __perf_evsel__config_callchain:7
Added new event:
  probe_perf:__perf_evsel__config_callchain_L7 (on __perf_evsel__config_callchain:7 in /home/acme/bin/perf)

You can now use it in all perf tools, such as:

	perf record -e probe_perf:__perf_evsel__config_callchain_L7 -aR sleep 1

[root@seventh ~]#
[root@seventh ~]# perf trace -e probe_perf:*callchain*/max-stack=16/ perf record -g sleep 1
     0.000 perf/14860 probe_perf:__perf_evsel__config_callchain_L7(__probe_ip: 5263069)
                                       __perf_evsel__config_callchain (/home/acme/bin/perf)
                                       perf_evsel__config_callchain (/home/acme/bin/perf)
                                       perf_evsel__config (/home/acme/bin/perf)
                                       perf_evlist__config (/home/acme/bin/perf)
                                       record__open (/home/acme/bin/perf)
                                       __cmd_record (/home/acme/bin/perf)
                                       cmd_record (/home/acme/bin/perf)
                                       run_builtin (/home/acme/bin/perf)
                                       handle_internal_command (/home/acme/bin/perf)
                                       run_argv (/home/acme/bin/perf)
                                       main (/home/acme/bin/perf)
                                       __libc_start_main (/usr/lib64/libc-2.29.so)
                                       [0] ([unknown])
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.020 MB perf.data (8 samples) ]
[root@seventh ~]#

That [0] is the ugly part here, have seen it before, need to nail it
down, unsee it and all the rest seems ok, right?

- Arnaldo
