Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611F2C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B00020791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIDJxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:53:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53147 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726425AbgIDJxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:53:24 -0400
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-90baCtXtMOeYl5u8EvLnAw-1; Fri, 04 Sep 2020 05:53:21 -0400
X-MC-Unique: 90baCtXtMOeYl5u8EvLnAw-1
Received: by mail-ej1-f70.google.com with SMTP id d24so2352807ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 02:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zMKB8i+H0w6Y9LNIbp87DMXWitgzoVeMvtbKZQVUiPk=;
        b=rKGQH9t34Ij4Oc22C1DKSXPp5YCn+lq1l4W3dpNswcpepSiT+LxVgukV+lS1zz7h/b
         6/ra4TgdJjOPsjhcG9M4de2qG3FuWLdYGrQvk9OS5TYSoPG3nbaRrSqltmBlHPrM5vcm
         eMYy7eqQ5Z4nrsucTAI2E3j65Ao7/2GIGi66NssobdExy0YAwWbvPFw7Qp9lTFDAv0EF
         w5ZTbah78qoWc7yDLFUozcsqdJMUTCNteukKyQ2hz3qgRs53D4mUos49xhydAAWyHAES
         9gYfey8U71uX1v7UOGoHCi9X6hqJhdfWhQFwYAdTmL9Cg7XJu5WisJ0M1SFNh8bqzby9
         7rYw==
X-Gm-Message-State: AOAM532FX5Mq9hEbycl2m0bg0DNTTxT/6iWlw6CeklAjyyUVcJiuPB8w
        VMB1jw4nwlnaFwaRjbvAFF48i3sHl1fU2UQKcfwP9cJkxPpyd432yBVJHiqInC1Y2Cxv+mmAcqV
        PCTat7Rkw7KnErJReUIn3sVV3
X-Received: by 2002:a17:906:5246:: with SMTP id y6mr6421608ejm.316.1599213200446;
        Fri, 04 Sep 2020 02:53:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOqMHQpmtTAHfOycM5wwMhoCj7YdUznZQXHUScaB+zfolhVaEuHA45DZavkcpkeVW5Dg3PoA==
X-Received: by 2002:a17:906:5246:: with SMTP id y6mr6421585ejm.316.1599213200211;
        Fri, 04 Sep 2020 02:53:20 -0700 (PDT)
Received: from localhost.localdomain ([151.82.223.59])
        by smtp.gmail.com with ESMTPSA id k16sm5802418ejg.64.2020.09.04.02.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 02:53:19 -0700 (PDT)
Date:   Fri, 4 Sep 2020 11:53:16 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as SCHED_DEADLINE reviewer
Message-ID: <20200904095316.GR16601@localhost.localdomain>
References: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4476a6da70949913a59dab9aacfbd12162c1fbd7.1599146667.git.bristot@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/20 11:26, Daniel Bristot de Oliveira wrote:
> As discussed with Juri and Peter.
> 
> Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: linux-kernel@vger.kernel.org
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 592467ba3f4d..56d185210a43 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15363,6 +15363,7 @@ R:	Dietmar Eggemann <dietmar.eggemann@arm.com> (SCHED_NORMAL)
>  R:	Steven Rostedt <rostedt@goodmis.org> (SCHED_FIFO/SCHED_RR)
>  R:	Ben Segall <bsegall@google.com> (CONFIG_CFS_BANDWIDTH)
>  R:	Mel Gorman <mgorman@suse.de> (CONFIG_NUMA_BALANCING)
> +R:	Daniel Bristot de Oliveira <bristot@redhat.com> (SCHED_DEADLINE)
>  L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git sched/core
> -- 

Thanks for the help Daniel!

Acked-by: Juri Lelli <juri.lelli@redhat.com>

Best,
Juri

