Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62C70C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EFDA206EB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 11:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595678316;
	bh=NeplPc88+u3yjtRMKqs3Edqye3mxn57lmYUY7hxPejQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Fh0rO/CGrWvYgus1Frwpom1JupVfYmHESdPQcE5Qrd+3jgKnxQ/GdWMCWFiZauM+o
	 OWig0e1BbNxOxhCm6Zk3/1sa8l/vklIMg8MwBZVrxwIOTe7bY8jPLhSQx9VYTDuHOo
	 1CR3SyCe5T9boqkRiWCZgJEBtbpWv5Xt4ZZED/x0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGYL6d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 07:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726583AbgGYL6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 07:58:32 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C4AC0619D3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 04:58:32 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id f12so12496211eja.9
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oE38+3eAsf8EjWmAJL5WaGlwmAoBPDTAgpsWA6S6L0o=;
        b=FhQiL6EEWLd8OW5E6JvYmCVVqZFcbaUU17zMhyAo/K1ZZlt7MQ7U0ZxrdZRfq7EoPY
         w2e8GFKBqNYMpqXrMjkdKzI2wZw/YejudNySEDh9Jga+mRNSlLHCkEMcLTjR+/L+FTBv
         MyNKvUJBDuii7W89TSge07rWcFws5JG7yJiTaHiJoxqgxADDn3XpgOHK0gcbpBEFFBoB
         3ra51tzO3kLNVL8wZHx10K2s0USGwuDeq+cOa1wPTUgCXt4vaLRZ4xPXuD7bMk45bTup
         eDKkSt2bPNUXjP9fZ7+vof4zUI+4k2+nflaTsYv3u49DSGTyfZ1SG46AwUmfjxGJRGqh
         yDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=oE38+3eAsf8EjWmAJL5WaGlwmAoBPDTAgpsWA6S6L0o=;
        b=F/VdkZ2dv0evfRbQL8PEX0T5AVS17Cm8P3yH7dZPZrEvxYWkR+ZKKJTSg3hgMEmWl4
         Nu05GCTTgBOYS0yALkx8eBa++JVmdHRU6EVeo4LPfSZnZWEA8rk+wW8Qcbp1nSHh/ux6
         h2ijgiP287QOFHYk3YUFRqUV6rJcOSN4F2jzfwZX+D3VS0QX0JzRapUiC/Lj2GxXSx42
         T5Gn5L6dmYwS4yobhELweUR+NX1/xIwwygSIXQPPkbCX3JOnS0I8wlOsxCL+djvOIBK8
         oc0WfN2v+mfxq9XfZ5BN2FOFJYxLAVYfoQzUy9a3Q3d7YE7c6yQN5n1+oCM7BUw/ji/t
         l+eA==
X-Gm-Message-State: AOAM532e0qVGtGIxWj117hbY4tDxWFTU+4ReLnHK+tKV30VQYXehKW+T
        H447ksYOi25wgleumxQ9YjI=
X-Google-Smtp-Source: ABdhPJyyQzLboxXtyBD6XUHWGSzmKwDRS8o+dQ6G5u4F5rWWuJY3/mH6KqsiZJPZaBvkclLW3NW5Kw==
X-Received: by 2002:a17:906:c44c:: with SMTP id ck12mr13744342ejb.145.1595678311076;
        Sat, 25 Jul 2020 04:58:31 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f16sm2721345ejr.0.2020.07.25.04.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 04:58:30 -0700 (PDT)
Date:   Sat, 25 Jul 2020 13:58:28 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        will@kernel.org, paulmck@kernel.org, hch@lst.de, axboe@kernel.dk,
        chris@chris-wilson.co.uk, davem@davemloft.net, kuba@kernel.org,
        fweisbec@gmail.com, oleg@redhat.com
Subject: Re: [RFC][PATCH 1/9] irq_work: Cleanup
Message-ID: <20200725115828.GA1006124@gmail.com>
References: <20200722150149.525408253@infradead.org>
 <20200722153017.024407984@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722153017.024407984@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Peter Zijlstra <peterz@infradead.org> wrote:

> Get rid of the __call_single_node union and clean up the API a little
> to avoid external code relying on the structure layout as much.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/gpu/drm/i915/i915_request.c |    4 ++--
>  include/linux/irq_work.h            |   33 +++++++++++++++++++++------------
>  include/linux/irqflags.h            |    4 ++--
>  kernel/bpf/stackmap.c               |    2 +-
>  kernel/irq_work.c                   |   18 +++++++++---------
>  kernel/printk/printk.c              |    6 ++----
>  kernel/rcu/tree.c                   |    3 +--
>  kernel/time/tick-sched.c            |    6 ++----
>  kernel/trace/bpf_trace.c            |    2 +-
>  9 files changed, 41 insertions(+), 37 deletions(-)
> 
> --- a/drivers/gpu/drm/i915/i915_request.c
> +++ b/drivers/gpu/drm/i915/i915_request.c
> @@ -196,7 +196,7 @@ __notify_execute_cb(struct i915_request
>  
>  	llist_for_each_entry_safe(cb, cn,
>  				  llist_del_all(&rq->execute_cb),
> -				  work.llnode)
> +				  work.node.llist)
>  		fn(&cb->work);
>  }
>  
> @@ -478,7 +478,7 @@ __await_execution(struct i915_request *r
>  	 * callback first, then checking the ACTIVE bit, we serialise with
>  	 * the completed/retired request.
>  	 */
> -	if (llist_add(&cb->work.llnode, &signal->execute_cb)) {
> +	if (llist_add(&cb->work.node.llist, &signal->execute_cb)) {
>  		if (i915_request_is_active(signal) ||
>  		    __request_in_flight(signal))
>  			__notify_execute_cb_imm(signal);

Hm, so I was looking at picking up some of the low risk bits (patches #1, #2, #4)
from this series for v5.9, but the above hunk depends non-trivially on the
linux-next DRM tree, in particular:

  1d9221e9d395: ("drm/i915: Skip signaling a signaled request")
  3255e00edb91: ("drm/i915: Remove i915_request.lock requirement for execution callbacks")
  etc.

We could add it sans the i915 bits, but then we'd introduce a semantic 
conflict in linux-next which isn't nice so close to the merge window.

One solution would be to delay this into the merge window to after the 
DRM tree gets merged by Linus. Another would be to help out Stephen 
with the linux-next merge.

What would be your preference?

Thanks,

	Ingo
