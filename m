Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5670EC47247
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3355620721
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:25:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B98dTBwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbgEDVZQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726469AbgEDVZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:25:15 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBB1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 14:25:14 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id w6so326551ilg.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 14:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=2Zv4G+VzNcrRYGRaLUVhI8DhRnEm8hPxZxVB7VoicFU=;
        b=B98dTBwlQXRYGsKg56YCnInz+NoQZ5+A4ZtN/Y7PIF4xdwoHLXGyFVpzMHa9dth7YG
         MeWkTLCm6xl2dtKPboMnsQ8/T+Mnt4GiNk7VXCv45UI6vx4f4zIM8Bw2r897kzenDknO
         fyDSlqjNMdNC3wg9lLhdr4HP8ZfQ4GckwJrqpappDSjf0JaXkUdBk3mTmhA0QG/UzlzZ
         mk76oxVMs5w+82K5zekIfahN26epbZoGwoEK7ZSIOJ8q0vzrK6NBGpFUVduJkwUliKcX
         6vaU7aLhxO4/rRhZUdML/mXK9WjGcRRqZE76iq4zY1u8GOqrmOTWWvmPwG65+rrp41/9
         E33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=2Zv4G+VzNcrRYGRaLUVhI8DhRnEm8hPxZxVB7VoicFU=;
        b=QkvUJHZga9A8cpC1V+ymdS+MVm3Mnz5i/LjIHi9wprXlMvw44xMd10vgaw4OHCAItR
         3AFFj9kmT+q/x7IH7kJb9KihCSd8P3PkJNboRzvWJ0BD/NVYmYEsfSYFC4EGcnC40mSb
         g8cVIdgaFc1LmUEm2BkcHZoGfEKMJUEs1xPUjausWfXTGTeAwI4L4p/hNk+f+/8SxEMe
         TingWBXeKzCFbkD5SximxBa7/Il+w9+aNSClxZ4JMbJrdAjVrz090oHAt9hkEUtIWNK8
         wCIfbCddFIpQPsmjBAPGVI/Pn7eXSNdIQVdYlqmSIlplgAauT4Am4wjI2QNjP4z7lJ9K
         I9QA==
X-Gm-Message-State: AGi0Pua2PnUAz7EIob9k+568+OZMDVF7RxDgkWKilFSXtv5+9Z8Ay0iA
        08+i7H0xwHMvUGCvvgcfLdmsKHyMfIY=
X-Google-Smtp-Source: APiQypJw+MuaKqMTHGzwTcZ2ZxqAvmO/FGIkpdUBnRL32Ka73PuGg0F0UUNyL/s3NlIAWa7JTpnHPg==
X-Received: by 2002:a63:4f0e:: with SMTP id d14mr175207pgb.445.1588627513782;
        Mon, 04 May 2020 14:25:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id gl12sm372771pjb.27.2020.05.04.14.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:25:13 -0700 (PDT)
Date:   Mon, 4 May 2020 14:25:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Kevin Hao <haokexin@gmail.com>
cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v5.6-rt] mm: slub: Always flush the delayed empty slubs
 in flush_all()
In-Reply-To: <20200504033407.2385-1-haokexin@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2005041424590.224786@chino.kir.corp.google.com>
References: <20200504033407.2385-1-haokexin@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020, Kevin Hao wrote:

> After commit f0b231101c94 ("mm/SLUB: delay giving back empty slubs to
> IRQ enabled regions"), when the free_slab() is invoked with the IRQ
> disabled, the empty slubs are moved to a per-CPU list and will be
> freed after IRQ enabled later. But in the current codes, there is
> a check to see if there really has the cpu slub on a specific cpu
> before flushing the delayed empty slubs, this may cause a reference
> of already released kmem_cache in a scenario like below:
> 	cpu 0				cpu 1
>   kmem_cache_destroy()
>     flush_all()
>                          --->IPI       flush_cpu_slab()
>                                          flush_slab()
>                                            deactivate_slab()
>                                              discard_slab()
>                                                free_slab()
>                                              c->page = NULL;
>       for_each_online_cpu(cpu)
>         if (!has_cpu_slab(1, s))
>           continue
>         this skip to flush the delayed
>         empty slub released by cpu1
>     kmem_cache_free(kmem_cache, s)
> 
>                                        kmalloc()
>                                          __slab_alloc()
>                                             free_delayed()
>                                             __free_slab()
>                                             reference to released kmem_cache
> 
> Fixes: f0b231101c94 ("mm/SLUB: delay giving back empty slubs to IRQ enabled regions")
> Signed-off-by: Kevin Hao <haokexin@gmail.com>

Acked-by: David Rientjes <rientjes@google.com>
