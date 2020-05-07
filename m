Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3777DC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0593220731
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="JYC32j/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgEGVGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726218AbgEGVGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:06:10 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C215C05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:06:10 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id s9so1320635qkm.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NEeebNbM/M0OFPawcEwiP7KQRHS26VREdoUS4zdOewE=;
        b=JYC32j/tVnDFyZT5cYi5BA4MS8gBSFnKpZe1g7y+WWKiAfQZ5EJtQTrCYRiguXAA2l
         0vJ7cSu9q8Xr9H+/xflgKxprjziO6nUU0m7xAn8VfL6xKLvxxDNKL95b+nfZgyUxXtfY
         OYFZrMyS7894JTbZAsi9npqMeADUMfGvvSzL8mEc+eiwUY9CgOj9HYnA0M7QMYVPJTv7
         Y2ciFMaL72giuvY6ENJegOReYfVmdOC34oZ8grdvBs6wYWx5dlara1Zb+FCCQLhN9OUv
         xNIpdubzwyETlxZKfGC0XPp7JAThtjvREjJjOUiA/Y7VelnvQgT1oEmJ4YrXFO9uLnnF
         s1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NEeebNbM/M0OFPawcEwiP7KQRHS26VREdoUS4zdOewE=;
        b=hZTiar3ySeGRRnOn3MbspsttONZ5Jnzm91t9fil/VeZOoDXI0j2nOaayBpETvqDRHU
         dXHpBr0FTbR8VF7H+PyIFYYtaGkcuXrw1u/fjMtK1wI4066RyeI0aX4eRTJ365VQlmNc
         wIUiLZb8Mzd32wxPy9T0/33gYvKNEzHW2OeSLwbDbj3IfZ9w6dY2Dbha8O66zaKqfgy0
         oz0i1DEAq6eL2Qqj11PQ2DZFi1/075kio3Owp9PK/8HJZP6tUslYEXQj7yLAnrNF0cbz
         0HmHVPEAP/vuWauDM+7wjfr4AMMZ7q+w1bMwrw7DUfHmR1d3MdzJAxqMzyoxlaQD6YqJ
         KrJw==
X-Gm-Message-State: AGi0Pua3lJm8vtzN1pVzp7KAD4K06/hzURmGz8v7clajEO3MDpontUVZ
        BhMFrouQ6KIsKSlwcXKkBJPSVNo5a5g=
X-Google-Smtp-Source: APiQypJsEx7aeCPdLDnanbySV4gX1hXU71wlsuantZoJhLj50yE07ICZgNKiJA9SVzPbUFe4vnX9lw==
X-Received: by 2002:a37:6409:: with SMTP id y9mr16506966qkb.184.1588885569875;
        Thu, 07 May 2020 14:06:09 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id x19sm4049983qkh.42.2020.05.07.14.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:06:09 -0700 (PDT)
Date:   Thu, 7 May 2020 17:05:53 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
Message-ID: <20200507210553.GE161043@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-11-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-11-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:46:59PM -0700, Roman Gushchin wrote:
> Deprecate memory.kmem.slabinfo.
> 
> An empty file will be presented if corresponding config options are
> enabled.
> 
> The interface is implementation dependent, isn't present in cgroup v2,
> and is generally useful only for core mm debugging purposes. In other
> words, it doesn't provide any value for the absolute majority of users.
> 
> A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> and also allows to get any additional information without a need
> to recompile the kernel.
> 
> If a drgn-based solution is too slow for a task, a bpf-based tracing
> tool can be used, which can easily keep track of all slab allocations
> belonging to a memory cgroup.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
