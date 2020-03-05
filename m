Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784DCC3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541C820726
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="RR6nLtAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCESgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:36:18 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44367 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgCESgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:36:17 -0500
Received: by mail-wr1-f66.google.com with SMTP id n7so8239685wrt.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=NuoA3fuPswQR3q6MZEyPSq0NTYh8WVfp4GhRULEWRIY=;
        b=RR6nLtANxW9IiN4v3USYLxGNCnrYUqcerZ41dSbNfgtylvE//xJdTrZEBL+kNgm39E
         GW38qiN3bLqBFwcftKaWbuQrsZfUGSiWHD1yTQOF/wl6lElGraB+5LU/2usxQN+DFhcE
         oci1LJb9PY8XkR1F4BEGDEgap7+++0Iv12xcc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=NuoA3fuPswQR3q6MZEyPSq0NTYh8WVfp4GhRULEWRIY=;
        b=q3uGXoCKdNp5M+T/QJihKh4rFlQExG+tQr68sWIhkFEYmWn3iVT9RlNpAju6Uf5Szy
         HsICjHR/nlj5gUuUz/kWhPCf2T9J+sL9P5+Bqt4xShET3nZQy1sGwROMTh5F20TzxT1e
         A94Vdl0piEahfVTkmf0lHQPThnPn/7t3pP2oN10xPE4Rin1Di9OwIol4TzqGr0eAimbM
         duSpuyNCO5O9mVaotcP8gJeDr9YHZotErVXpkiHtJ7pK5AC92QoFvUI/bTYvZsvzg8RS
         md649iJSXDByZe2p67xYOfUUYTIFWbucovc8HGHSk8D3tgtvf7PjXT2CQTTHpMLy74yc
         XyLA==
X-Gm-Message-State: ANhLgQ3CuIFTe+L+hdIVRSX8VThWZUd2HTuoCs80uOp2TpacA3rWjZOV
        RqN+NXmCcYCz+nEuwX+LpE5csg==
X-Google-Smtp-Source: ADFU+vtdNZNZmPNSsajXjWtBz/3Labc+zWb3NvUh2WOyO/hINkn6LFD5bSu91HFy6qp5a616NzYT4w==
X-Received: by 2002:a05:6000:100d:: with SMTP id a13mr258226wrx.330.1583433375392;
        Thu, 05 Mar 2020 10:36:15 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:6808])
        by smtp.gmail.com with ESMTPSA id x17sm5432831wrt.31.2020.03.05.10.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:36:15 -0800 (PST)
Date:   Thu, 5 Mar 2020 18:36:14 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Make mem_cgroup_id_get_many() __maybe_unused
Message-ID: <20200305183614.GB752201@chrisdown.name>
References: <20200305164354.48147-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200305164354.48147-1-vincenzo.frascino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincenzo Frascino writes:
>mem_cgroup_id_get_many() is currently used only when MMU or MEMCG_SWAP
>configuration options are enabled. Having them disabled triggers the
>following warning at compile time:
>
>linux/mm/memcontrol.c:4797:13: warning: ‘mem_cgroup_id_get_many’ defined
>but not used [-Wunused-function]
> static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned
> int n)
>
>Make mem_cgroup_id_get_many() __maybe_unused to address the issue.
>
>Cc: Johannes Weiner <hannes@cmpxchg.org>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Thanks, I didn't notice you've already posted it before replying on v1 :-)

Acked-by: Chris Down <chris@chrisdown.name>

>---
> mm/memcontrol.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/mm/memcontrol.c b/mm/memcontrol.c
>index d09776cd6e10..2b9533ed52f5 100644
>--- a/mm/memcontrol.c
>+++ b/mm/memcontrol.c
>@@ -4794,7 +4794,8 @@ static void mem_cgroup_id_remove(struct mem_cgroup *memcg)
> 	}
> }
>
>-static void mem_cgroup_id_get_many(struct mem_cgroup *memcg, unsigned int n)
>+static void __maybe_unused mem_cgroup_id_get_many(struct mem_cgroup *memcg,
>+						  unsigned int n)
> {
> 	refcount_add(n, &memcg->id.ref);
> }
>-- 
>2.25.1
>
>
