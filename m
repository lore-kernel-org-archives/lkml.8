Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1967AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71642071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 05:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590384411;
	bh=pCHxpRzu0SHn3FZpuvh6arg6yGtLbMF78utQxMUr1K8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iiuyRX+sULSEtpmePK3bfyUD/KC8b+OC1E+O6g/Oiuwv8uQC6zg2bV9712a1i2ulf
	 IZTBP56Y7+f/YpE97qOKOi1JkHEjP10zO5ZX72p/fWld/i/9fAJftqaNPrAYDUUXtZ
	 CzLlR8fiCh/Ay8yDjA0/QA1WOKntEXKD9QDaWxL0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729587AbgEYF0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 01:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgEYF0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 01:26:50 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B85C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:26:50 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u12so10750426wmd.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 22:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cGHuLYnzmJpInQmuSvjFCogJYddfNcUGSEHPGssolu4=;
        b=GiX67yidlDu8OB35gIslyP23GTHKkmdhRismpec965HOWwZM2nDTSG5tXihdZhAcdd
         fafFDX3mCvb2wvyd+F1gwzJbK4WBiw7fS0HfDK8EDhiEnJpYuLcPm+dW+B40xhEey736
         EFJ7j+UtxIZ9JiRSGLPS1/MJivKWJpl/D53+wIdoESHp5DNYC894Sx1WUwX9A71iU7jL
         x6YoJoCxqczm5AlALlZa7xHfxjmSh0X1EWRnP/gK1aQFZt0r9L+vtY0juW+IJRfXgHDy
         eOeSxqKTXb78Fkr876uBFjQ7HhNmJ0DbGGIqOuW/JhIP4/0o1M7ou0NkUdlzLR/b+j07
         toEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=cGHuLYnzmJpInQmuSvjFCogJYddfNcUGSEHPGssolu4=;
        b=ZKSAiebOJQz1i+Pmjn42wBI8UDd9lJstC/uqcMR3+47B+uotkHuNJtcwSdZputTxEs
         HTkDIyPmd06jjm6z4ghNhyPfRbE+2+12SI2T+c8PDYWRWnew7wgu354KRrS0rG8o8hkD
         JCpKtzAKxRYEkmB+TpHgb9ujF2BhmqLY9NG9uZ7ArqEMYDPKWHT5xl9b4KiKoR1olMEK
         sgFdY3vwOT4QBZb1PjKwpjG38njSWOHXl6FSQKqDnMhJY8XEEuB5OU6XL9pv5NPYpZ6a
         0LajmPw4VjVg8dzlQGop95bEuxLCy9N7qGZp/tRXTvrpdxD2bYmfP2i65JO5qgovMWzz
         +fQg==
X-Gm-Message-State: AOAM533vKijPtZaaRIPEXn8ssb/MyO2kCDkBX2rhwo2rkWI+vHtZOVnd
        uP51VHI31xQpkNqyljvMM+4=
X-Google-Smtp-Source: ABdhPJyK52aVPpm9fMo92sbWFXauKXnrfuMFFi/1FMe6k2Otpvm6UNH8FlTcq91/bDG4v8ETgD/Jtw==
X-Received: by 2002:a7b:cc92:: with SMTP id p18mr24677324wma.174.1590384408559;
        Sun, 24 May 2020 22:26:48 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id q4sm3609449wma.47.2020.05.24.22.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 22:26:47 -0700 (PDT)
Date:   Mon, 25 May 2020 07:26:45 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jirka Hladky <jhladky@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        valentin.schneider@arm.com, Hillf Danton <hdanton@sina.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optimise try_to_wake_up() when wakee is descheduling
Message-ID: <20200525052645.GA3168707@gmail.com>
References: <20200524202956.27665-1-mgorman@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524202956.27665-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> The following two patches optimise try_to_wake_up() when the wakee is
> descheduling. In a vanilla kernel, there can be excessive time spent
> spinning on p->on_rq. This is fine if it's a strictly synchronous wakeup
> and the waker is going to sleep but in other cases, the waker spins until
> it can do work that can be deferred to the wakee.
> 
> The first patch frontloads work that can be done before p->on_rq is
> checked.  If it's a wakeup on a CPU that does not share cache then the
> wakelist is used instead of spinning. The second patch goes a little
> further and uses the wakelist if the wakee is descheduling and is the
> only task running on the target CPU.
> 
> The performance impact is documented in the changelog of the second patch.
> 
>  kernel/sched/core.c  | 81 ++++++++++++++++++++++++++++++++------------
>  kernel/sched/sched.h |  3 +-
>  2 files changed, 61 insertions(+), 23 deletions(-)

Thanks, these are really nice improvements, those latency spikes in netperf
runs were always annoying, and they've been there forever I think.

I've applied these two patches to tip:sched/core:

  c6e7bd7afaeb: ("sched/core: Optimize ttwu() spinning on p->on_cpu")
  2ebb17717550: ("sched/core: Offload wakee task activation if it the wakee is descheduling")

In 2ebb17717550 I resolved the conflict with a recent cleanup by PeterZ:

  90b5363acd47: ("sched: Clean up scheduler_ipi()")

... which had a drive-by cleanup of ttwu_queue_remote() as well.

Thanks,

	Ingo
