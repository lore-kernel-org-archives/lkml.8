Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E48C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D29D2078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 08:57:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ANgZo75l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503065AbgDPI5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 04:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502975AbgDPIyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 04:54:17 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116C7C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:54:11 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a25so3913221wrd.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Gn7oXfoGCRvoMbfplo6Pb14LOH1Awil1DJDkiOGVDA=;
        b=ANgZo75lCcjV734wSTxcu1rem1hvUQY9dUge/mBQetsuentv23rJlSRrGoYm+gKbnW
         +1ppqgKe+wI7w8MMAm4UsgjLC7Sq5gRO5PbuQ/ZHGNzQVtiSA+gaLzKB3xv8oFPlXNGi
         vZK82B9+TPzJtwaWEeoekqDyPy58ly5rewSxozAE11rbNCYy1e5f0p24l/167A75P8oQ
         nSxd2un7HnOLt5z1GzMONG7FYv7GNpuHcgVXDmV4UZi8YeomQ6BQQvo81aMN0DPGG5EA
         SVce1GKH/R6nfaaBJ/0psVsb+eOWca16adx0PRM2FiyuFteCkCiB8Hb/N9LYVsVixM8m
         cyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Gn7oXfoGCRvoMbfplo6Pb14LOH1Awil1DJDkiOGVDA=;
        b=rC1Y58929ISVsjbXWU1ajpBAc2Agl5lRbPr4IlYtVl8z/t9BkGLuDWVGqq84IkMPPU
         BYVGqnKlGRw5flm6xgnq0R5oOi447E6cZDAWY7+vwbmww2hKGO7KaYmbxgz3YzRdTxiL
         vnxXBQAiwa+CBwcXMEu2j/Re1q1froO1xrw0PsxpPQZgJyBIHY9sWMuT30NZnvyYM6IW
         PzQXSIp6uAB/epH5uio2bzNHMdd9YnaVdU3By7NceUQ9yNZZSG9l4O1WGkufmfjseKf6
         fs8+2zRpUclvdKjE5wWddabfF81BoFoqA2Al+/OLbyslGDVjmFIz8xHXTg3KJlGQpiD6
         /NbA==
X-Gm-Message-State: AGi0PubcmG/efMoB8fln5yfIlGxTwhTFxbdwOC2OZnwq8j/VcHV7NZ4q
        xxibG6wWcUY1baEGAqjGpX4i2g==
X-Google-Smtp-Source: APiQypK49a7tE2PU7rlG+OoBz58EGTIHngL7sj2g3M9u+J/luNQNGQV9Ak1+2qtK4eqbh7Dz8O6WwQ==
X-Received: by 2002:a5d:60ca:: with SMTP id x10mr10505214wrt.407.1587027249479;
        Thu, 16 Apr 2020 01:54:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id k184sm2776749wmf.9.2020.04.16.01.54.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 01:54:08 -0700 (PDT)
Date:   Thu, 16 Apr 2020 09:54:05 +0100
From:   Quentin Perret <qperret@google.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     Doug Anderson <dianders@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        ctheegal@codeaurora.org, valentin.schneider@arm.com,
        qais.yousef@arm.com, LKML <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200416085405.GA215493@google.com>
References: <20200414161320.251897-1-qperret@google.com>
 <CAD=FV=Vo4h43vS1K1+ziAJhQ3UG+Zrx8JN8Q1tkMWU1Oh6OavA@mail.gmail.com>
 <20200415082001.GA256573@google.com>
 <CAD=FV=UB7OZzQO46dV7KOHGqRkgbtaSgLfq55yddyx0L_e37Fg@mail.gmail.com>
 <20200415174718.GA30565@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415174718.GA30565@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 Apr 2020 at 19:47:18 (+0200), Patrick Bellasi wrote:
> Honestly I was almost there to ask for the same cleanup. :)
> 
> If you get rid of the useless variable we can go back to the exact
> same code modified by the commit we are fixing, i.e. 1a00d999971c.
> 
> So, not strong opinions here too, but if it's not a big problem I
> would post a cleaned up v2.

Alright, that works for me. I'll send a v2 shortly.

Thanks!
Quentin
