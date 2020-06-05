Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08177C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6979207D8
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mXXZdi6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgFEVHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEVHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:07:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D865BC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:07:12 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o8so5736124pgm.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DIl1c/a1tJwzu9tj9OScxdWzLfr1jbFnh4gamMfxa4U=;
        b=mXXZdi6vgof7yFFLz8NliqYNwbHFEsnjcD1553WxFYKTO+lNtkWjleP7CfaBTgtaLT
         kIUVtn5rZ05qv7bMbRv7xg4VnziO3GIAvq3eObq5WOeJTUYqEK90uH8n4lq86F/4xRkd
         o67qykTVOGIsy++F8bU8ZV7fdZi5diKQuY3rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DIl1c/a1tJwzu9tj9OScxdWzLfr1jbFnh4gamMfxa4U=;
        b=OisGn0ZRe5TsbI98JIq+xmxPDH0YQ2LAig26E4/HqHzl+WPaBTXek2Gtl9OwGaXOXs
         dY7Iaf3FjXLk3BG1SeTtwnMq3iBhkLNJJ1MY21SsCPliuf0L1NOSqeRkmeoIzCil3U/H
         Uvt4SPYX07RbAaBccpSO87DIClQVqFQ5fj7ZULunEIBbNDWCJPoOZaqw0OjKBCvbjiYB
         ucP1LdgtdkiJtRJW1E7IdYQWOPj5TIpVfN4uWcCT2vy77N5AcHqL3CmbXLzh3iKfukVw
         F9duXJkoIVnm5EZVyrwk1sWbZP9agFa1FoTrsW5jgCdmxxv7c/3zSxq9AnPKYcCLfPPS
         0RHQ==
X-Gm-Message-State: AOAM532Ey2La5Z0pe/IXMZ5SyNlGeE/Z9pb/T0Onyn7objqj1U4cuqlE
        VxyymlSpBtbLY4vstTrOd6meTw==
X-Google-Smtp-Source: ABdhPJw3UK7yUcQVNPpsOFwlgYtR9GiEv04lfxyiuj3QJg6BkE/hP4K05bbCQ0Ja4mdmIJqn069GoA==
X-Received: by 2002:a65:6801:: with SMTP id l1mr11113171pgt.73.1591391232412;
        Fri, 05 Jun 2020 14:07:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id ca6sm8589394pjb.46.2020.06.05.14.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:07:11 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:07:10 -0700
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
Subject: Re: [RFC PATCH 4/5] mm, slub: make remaining slub_debug related
 attributes read-only
Message-ID: <202006051407.F7E66272DA@keescook>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-5-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-5-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:18PM +0200, Vlastimil Babka wrote:
> SLUB_DEBUG creates several files under /sys/kernel/slab/<cache>/ that can be
> read to check if the respective debugging options are enabled for given cache.
> Some options, namely sanity_checks, trace, and failslab can be also enabled and
> disabled at runtime by writing into the files.
> 
> The runtime toggling is racy. Some options disable __CMPXCHG_DOUBLE when
> enabled, which means that in case of concurrent allocations, some can still use
> __CMPXCHG_DOUBLE and some not, leading to potential corruption. The s->flags
> field is also not updated or checked atomically. The simplest solution is to
> remove the runtime toggling. The extended slub_debug boot parameter syntax
> introduced by earlier patch should allow to fine-tune the debugging
> configuration during boot with same granularity.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
