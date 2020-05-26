Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33424C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:31:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDC220849
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590514319;
	bh=LuwNFAOjejtAL3QBuOHKZKH1+40s4wNfdL2VicxTud0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=b/UyrW9c4kP8oBWqbCTnlc7ezS1yANTY6xKmpcE0Oofsr+YiSB76rv3FCr6y+vELY
	 cQj9Cy5mvIGcnXVu4OS0L20c8Fa5ISYROlb3GVoSfpa8q/rr86Kg/FTJr+c2mN4RxT
	 eJtL+vcM6MYXQdvsNz7wlTXZTnvfEM12lFeuuJlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgEZRb6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728138AbgEZRb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:31:57 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C64C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:31:57 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id g20so9812208qvb.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 10:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QycW+biAD72KqTVySFX7OgzIfNJ+JITMcUnoB8nhmFM=;
        b=Q8UcuakEyeLbGLEdUDnNytNtdt62H2efob7q+wV2c/p5a1vtkd76WfMTGOpMGkrZk9
         vohAO91u5zu3db0GgdfVCLb9edvjZzB6OELlJOdIQUWVUWgabDswr/xjhTV70fSAzdos
         a06QRzmwojzyiY8h9XbAptPeeE1lqccKXJrsmuOK9N2LN+9+C7LVgUnuSooQqWmcezcB
         F3X1eLkPl4IgsmF007yjQ5hUzC3p50ZwS2Jp2kgw8UjbtZdH1naxh0yG4FLbUx4HxIk0
         aZcUp6SSeLHN6KRkXrUuYLOjxeL7BzxcJ2DdQw+FHsWintLcDC8LLut4oyWIhRM+eS0q
         61BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=QycW+biAD72KqTVySFX7OgzIfNJ+JITMcUnoB8nhmFM=;
        b=NkoWfG2+y8A8RC/Do6Zm80lPJ7sCwV6nz/CLmBElKb+WiJi3u6lS77asM++tYd7pgX
         0K/XUkYbk2O++jxGVzUGXxlLjS9yTl3WQ96to2hmfqmm9wwcbDQWJ6ghL9FjD6/hAATn
         Ktp/8EcKSHjP/uN3MuW56PfUdmjDGjH9uNhBUvDDQke51B/SwqgDT2zrhDZJ98Tv51Nt
         vwVo4kQwIHWSos3EmFovStkYNnrrpU5XUzqt1v7wjVd6VpP3bhjST9+DvPbqsnOVii16
         e7uDxIGAot+SVW7TI5Zrrove2366kX1+Nvz8Uqlp7Rvlaz5mYc7zUx3O3vY0nsbMuu+e
         4I8w==
X-Gm-Message-State: AOAM5308ZX1clCRQWG3SVh4JdHrD0t+VDVbx4eBOBI+sN5yaBmRseOOk
        abZHVb9ZYMKIGANO0IYC8Ng=
X-Google-Smtp-Source: ABdhPJwREGivODvBgRQdvivFlvjeJqwTO44pGaghHiGrgVCn+80O/WZeGO5ZXP2dUAL/J9Q+Pb/juA==
X-Received: by 2002:a0c:a144:: with SMTP id d62mr20445972qva.229.1590514316799;
        Tue, 26 May 2020 10:31:56 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:85c0])
        by smtp.gmail.com with ESMTPSA id s45sm311216qte.26.2020.05.26.10.31.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 10:31:56 -0700 (PDT)
Date:   Tue, 26 May 2020 13:31:53 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 2/5] mm: memcg/percpu: account percpu memory to
 memory cgroups
Message-ID: <20200526173153.GE83516@mtj.thefacebook.com>
References: <20200519201806.2308480-1-guro@fb.com>
 <20200519201806.2308480-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201806.2308480-3-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 01:18:03PM -0700, Roman Gushchin wrote:
> Percpu memory is becoming more and more widely used by various
> subsystems, and the total amount of memory controlled by the percpu
> allocator can make a good part of the total memory.
> 
> As an example, bpf maps can consume a lot of percpu memory,
> and they are created by a user. Also, some cgroup internals
> (e.g. memory controller statistics) can be quite large.
> On a machine with many CPUs and big number of cgroups they
> can consume hundreds of megabytes.
> 
> So the lack of memcg accounting is creating a breach in the memory
> isolation. Similar to the slab memory, percpu memory should be
> accounted by default.
> 
> To implement the perpcu accounting it's possible to take the slab
> memory accounting as a model to follow. Let's introduce two types of
> percpu chunks: root and memcg. What makes memcg chunks different is
> an additional space allocated to store memcg membership information.
> If __GFP_ACCOUNT is passed on allocation, a memcg chunk should be be
> used. If it's possible to charge the corresponding size to the target
> memory cgroup, allocation is performed, and the memcg ownership data
> is recorded. System-wide allocations are performed using root chunks,
> so there is no additional memory overhead.
> 
> To implement a fast reparenting of percpu memory on memcg removal,
> we don't store mem_cgroup pointers directly: instead we use obj_cgroup
> API, introduced for slab accounting.

The overall approach makes sense to me but it'd help to have a high level
comment explaining what's going on and why.

Thanks.

-- 
tejun
