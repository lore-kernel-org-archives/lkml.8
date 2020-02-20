Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B5AC11D24
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCCF6208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 22:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="1sM+flAa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729090AbgBTWCl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 17:02:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42755 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727656AbgBTWCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 17:02:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id o28so24038qkj.9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 14:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Qs+LhNiBMIj9A7PLEkqadpwwdn4t7ZJVTcZjDGn03PM=;
        b=1sM+flAalAjdf9H+ABF4RBpnc7mgf/EB1PkQ3GIvPhatEPuYG/+kZZYytUx2breYo9
         oBS4Cz3/NHUDHKrF1wClmlsU2wMQWRh9jUeUVFlKDnYU1XDy2DbPjMAN6/dFKk+WparC
         n2mnFSbEJsFPwZS1Vkfj9gnphTLnT9mqRYcdYb3mcnuK5c108UQ0b24WLrAoGSNFpyha
         iPLMyEc4PN5W+kfi2o4BOepzuEVVQ0MwF8HwWATiYKm8p4b2uSETdNaNTVOHwu7ULX5K
         9cl6gc557oQYGhjYLQyYi1BtFt0PWyzSVcxVJSRFwVQAzbgf64CESMf7EXkdNMTvkNc/
         T1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qs+LhNiBMIj9A7PLEkqadpwwdn4t7ZJVTcZjDGn03PM=;
        b=ULxBLP9CBFbF2sIPUgaEiAVtFUfK43VzLUy8BmdtjNyw29MgKcQstZwZYr42dfRZbr
         ek0NStSWKHH7qKE5FPX3H2xL0yRXwazjK8fmqakUvVUS+cuvoLUo6jxwwBMn2mw2e7V8
         ejYUT/+jgXbd25rtn+Q7yISFi+tpVENIuclfxYnka3zEPtSdeunQkAnujJGS4wST3gzB
         P7mJRqeG3obafYF4xR7LU5BdQUxYF4hfLjJWjJw70q4JLbDAtziEPfXmx9Bhd7vX4p6n
         17RpM9s8wz96qpMvMKrgyMJ6r/9AF1QPyfOLfrJQ7v9CcVHUY+muursuVHg7uaU/N9C0
         +aAg==
X-Gm-Message-State: APjAAAVaNnQy1nmGqea8ZdzhjAgsderc9NVFeotBErhJx0NJXEDFk5Im
        6RrkN/G5Hmv+OMp2IXa9aQZYiw==
X-Google-Smtp-Source: APXvYqzeLjYnxMcLPrrXE8eCyXI/Ol0Il3CHL5hbzaE2ieHBb3/wY1MEQ7PKwGJEA0oW/FVjRgCOZA==
X-Received: by 2002:a05:620a:1037:: with SMTP id a23mr29030822qkk.82.1582236160287;
        Thu, 20 Feb 2020 14:02:40 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:3504])
        by smtp.gmail.com with ESMTPSA id e16sm518875qkl.32.2020.02.20.14.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 14:02:39 -0800 (PST)
Date:   Thu, 20 Feb 2020 17:02:38 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <schatzberg.dan@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Down <chris@chrisdown.name>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH v3 3/3] loop: Charge i/o to mem and blk cg
Message-ID: <20200220220238.GB68937@cmpxchg.org>
References: <cover.1582216294.git.schatzberg.dan@gmail.com>
 <78060dcbf6578b4da6081f9f48b24b33726c5083.1582216295.git.schatzberg.dan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78060dcbf6578b4da6081f9f48b24b33726c5083.1582216295.git.schatzberg.dan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 11:51:53AM -0500, Dan Schatzberg wrote:
> The current code only associates with the existing blkcg when aio is
> used to access the backing file. This patch covers all types of i/o to
> the backing file and also associates the memcg so if the backing file is
> on tmpfs, memory is charged appropriately.
> 
> This patch also exports cgroup_get_e_css so it can be used by the loop
> module.
> 
> Signed-off-by: Dan Schatzberg <schatzberg.dan@gmail.com>

The cgroup bits look good to me.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
