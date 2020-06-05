Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A6BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A516E207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AqB3Nh2m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728242AbgFEVGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEVGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:06:52 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5617FC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:06:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nm22so3157846pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KxCH5EFraXoQSEVf3oiNZdVbXVBoYbhiatH91ouNAhE=;
        b=AqB3Nh2mTRZNCXSeorHCNmPub68+StVvbdM9uqA0v/3Yb3F91Cs5xewCqGEpfFrNHK
         FO1K+k2kdb9Skdy/iEqfAG/yRuLdkl2FmeJHFJK2Yoc+cTqTUIvq6DuSuJ55FJffurvr
         sYO6fsoN3uCqh+5ieK6JgXecwbgdXOM7W8u9c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KxCH5EFraXoQSEVf3oiNZdVbXVBoYbhiatH91ouNAhE=;
        b=R6T9mTyYSMwpwIgZa3ROgRwRs+g6G750nRa60jfwLXjW7rYpU4EmK9tx1u70i5bGZr
         IrfBJuZFQ0fpoeJq0PBo+NDKNxN2gBQ1kSL3cG7tQ0cvncXZYnkHdz/by9ZXMLYEWQ/g
         7NQli/5WFyUmT0u9XPk3BoHhd4s2xpKvsOTrowI7l4hQYJQylL5kF3P800fn6Qq6zn3z
         DPApmlIiS7ZbCy7Nto5/ZAxN1eouZfAgFwRr/IbL7BlAdGPF/AVzyRx7guA+30THi7uq
         stY5dtaHrzstVhfzO4+AHzXWQkiXrFy7xTOfiN9lYNnU8vahREawBLMw8aJZ0e11fnZH
         aEIA==
X-Gm-Message-State: AOAM532MZgqUKedSQZiULfP48JGT1NRTHDo8mQE2+wfbFnj+Y4snLRg4
        Mx+Zk9G8JGu1Ea3L9llLYulkAQ==
X-Google-Smtp-Source: ABdhPJwRIjKh0eeXvoAeIZcWHp5tbfvmDAMH4VkEyiDjLHJF5f6StU5vQ6ved+Dmiup8SU8qxDzpPw==
X-Received: by 2002:a17:90a:ae11:: with SMTP id t17mr5275490pjq.157.1591391210874;
        Fri, 05 Jun 2020 14:06:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y9sm9183236pjy.56.2020.06.05.14.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:06:50 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:06:49 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
Subject: Re: [RFC PATCH 3/5] mm, slub: remove runtime allocation order changes
Message-ID: <202006051406.A7AF17B6@keescook>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-4-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-4-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:17PM +0200, Vlastimil Babka wrote:
> SLUB allows runtime changing of page allocation order by writing into the
> /sys/kernel/slab/<cache>/order file. Jann has reported [1] that this interface
> allows the order to be set too small, leading to crashes.
> 
> While it's possible to fix the immediate issue, closer inspection reveals
> potential races. Storing the new order calls calculate_sizes() which
> non-atomically updates a lot of kmem_cache fields while the cache is still in
> use. Unexpected behavior might occur even if the fields are set to the same
> value as they were.
> 
> This could be fixed by splitting out the part of calculate_sizes() that depends
> on forced_order, so that we only update kmem_cache.oo field. This could still
> race with init_cache_random_seq(), shuffle_freelist(), allocate_slab(). Perhaps
> it's possible to audit and e.g. add some READ_ONCE/WRITE_ONCE accesses, it
> might be easier just to remove the runtime order changes, which is what this
> patch does. If there are valid usecases for per-cache order setting, we could
> e.g. extend the boot parameters to do that.
> 
> [1] https://lore.kernel.org/r/CAG48ez31PP--h6_FzVyfJ4H86QYczAFPdxtJHUEEan+7VJETAQ@mail.gmail.com
> 
> Reported-by: Jann Horn <jannh@google.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
