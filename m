Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30BDC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994C3206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="BPMLO0Tm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404127AbgDCPUU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:20:20 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38386 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403991AbgDCPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:20:20 -0400
Received: by mail-qt1-f194.google.com with SMTP id z12so6723221qtq.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pcySYvcjsOIXyHu4jeus+Gw8MtcUshidVKxTeJv8K+g=;
        b=BPMLO0TmyHJ12cXzSNYL9F5s7rDKsc+quN7feDOTATPnaoZZ1WuPeHjqFkh771hN8I
         5ClXJXIdndynCbHw1/KwNjdgz3L5zj7TWXo7HC90T3YUk1pKG/dDbNtjTgZL3b8ekPmX
         qG0pWrfP/jMZpl+0sihgIj54o1czyUj9EtHKTbFmNxL8ojwsKIKNxgiiWtyfRAYHI2u/
         CuwnXaudaY80eigJJzUl1R4WVZLpYQdHcbLWpD9GJ7+PzO3E0aXv8PSLTp9LDkf09Vg1
         HDb93LncSH0MmoyQTMT7Gwe9hSJqe+QMKgqQD8SxGJMi8QPZWXmJEfmBkGgcMNavsSBp
         gxNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pcySYvcjsOIXyHu4jeus+Gw8MtcUshidVKxTeJv8K+g=;
        b=BijYKQlii6oCOt9/BFcuvZ/ECimIKOrYirpVWTLRvhgYBRZqWLBj2sR9SyIO6G2IDs
         yVOYgnXyoglET0MlNw5hc70TfA5VpEoqLrkuY4v3n8J4ZFYsCCkTWZtnQItTH6Rb2qtD
         jQYwo/PWMe6SobBGFqkLog2DbdIkcsYiLiJ/D1xKwHiqPtlPJ+yaTLIb+9hPWwD3vi0P
         6Sny1wMX2dtjDfolOQS6ZQ/ZUET++peEp8M4GQXUmcGs3vUoLcgCxH+hnl26pntxUX+4
         iFNQp51DD9KpiiEa4RNRko9fjeCWXAFEhQrhiPj0VWPUS3jfCY/u6EpIFgOfDq95Oi5V
         nf4g==
X-Gm-Message-State: AGi0PuYLUCCnuwWmuSOE5qayLqAvmihtJscMlL54gSnhiiujasO7lBK1
        n/yfW5ycFN0pkCeQQjHGkJVk2A4xd9k=
X-Google-Smtp-Source: APiQypLbTERbvPmsxDL1wybDZrIftPcrRBiydzX1x4UkOvNQX1XdN+On/LZJmWYaA9eDavn1M07RuQ==
X-Received: by 2002:ac8:7385:: with SMTP id t5mr8787026qtp.222.1585927218874;
        Fri, 03 Apr 2020 08:20:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::da28])
        by smtp.gmail.com with ESMTPSA id f1sm6106148qkl.72.2020.04.03.08.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 08:20:18 -0700 (PDT)
Date:   Fri, 3 Apr 2020 11:20:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     peterz@infradead.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Daniel Drake <drake@endlessm.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH] psi: fix randomized calculation in record_times()
Message-ID: <20200403152016.GA69203@cmpxchg.org>
References: <1585904125-2819-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585904125-2819-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:55:25AM -0400, Yafang Shao wrote:
> @@ -690,7 +690,10 @@ static void psi_group_change(struct psi_group *group, int cpu,
>  	 */
>  	write_seqcount_begin(&groupc->seq);
>  
> -	record_times(groupc, cpu, false);
> +	if (groupc->total_tasks)
> +		record_times(groupc, cpu, false);
> +	else
> +		groupc->state_start = cpu_clock(cpu);

This change appears is a no-op. If there are no tasks,
groupc->state_mask is 0, and the only thing record_times() does is

	groupc->state_start = cpu_clock(cpu);

Did you encounter actual problems, or are you just reading the code?
