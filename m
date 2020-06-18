Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF75C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8994020890
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 20:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="obxACDEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgFRUh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 16:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgFRUh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 16:37:27 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA8C06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:37:27 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id 35so2957401ple.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 13:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4QQIkRmgHybrTXF8+aaUZbCjNfbygj8GTcvHDxd6YbQ=;
        b=obxACDExqgeubHQInpfsuwNWX7WTaRZj65frJajCO4yTeyAVpyKn5JKbMYAAM8DzDs
         tnt9EQdb2nB1YGxgCobU2a6+yS10AMnN/1l9kbUMKJXMltpbB8dM4V+VaVi/yJpv4t5Q
         f5Q31aCmm+mMkH9G99cOjZbXxdlElGVFZd1wo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4QQIkRmgHybrTXF8+aaUZbCjNfbygj8GTcvHDxd6YbQ=;
        b=QsRQe49e7ptl6+m2fvSg0huGSKFcRZaoxtxqZIjr6YMduDTMK30A149XVs3FEUb728
         XuIGOgkeK8ME3U8bRA/qbuEKfnyAJmg3LeSuMfM80Wx6QcQ4WFsKjw5vndNGMQK5GpyC
         vv4qswZX9sR/cYQsJPzUHpi+ytxJbgpszQ2mG585ok1nFJhrdcH0PEW3at2yk9Wbt+5G
         B0/mFz6iKGONJj2LYufrMO89dXVq0PcTuRHxZv8gxSotQZLj7bdg8OJz+JZgrQSNfJjS
         V8VQoljElu5qFuCnH/2HXWR1VxJRH/nNObe81OIL+uyLziqyzatBqeCX5U4uw1qLHZ1m
         tXiA==
X-Gm-Message-State: AOAM531Qk8vvbpyZMbnLIKtAFBqYRkP1fMzR9pMZwAUf9PfG7cmKg7SH
        DlPFAbXUIGB7UKOqw6bz3c2otQ==
X-Google-Smtp-Source: ABdhPJxf7G59fWv+NZ1bb0k077huOL3svybUSmYEErVS77eiTZSFYthPGZHLN/HYueGaIhq3lFXpwA==
X-Received: by 2002:a17:902:d697:: with SMTP id v23mr5432017ply.323.1592512646691;
        Thu, 18 Jun 2020 13:37:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p30sm3871433pfq.59.2020.06.18.13.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 13:37:25 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:37:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Christoph Lameter <cl@linux.com>,
        Alexander Popov <alex.popov@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, vinmenon@codeaurora.org,
        Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: Expand CONFIG_SLAB_FREELIST_HARDENED to include
 SLAB and SLOB
Message-ID: <202006181330.2FDF47E03D@keescook>
References: <20200617195349.3471794-1-keescook@chromium.org>
 <20200617195349.3471794-2-keescook@chromium.org>
 <20200617200151.GM8681@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617200151.GM8681@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:01:51PM -0700, Matthew Wilcox wrote:
> On Wed, Jun 17, 2020 at 12:53:48PM -0700, Kees Cook wrote:
> > Include SLAB and SLOB caches when performing kmem_cache pointer
> 
> ... SLOB?  Really?  Objects from different kmem caches are mixed together
> on the same page with SLOB (at least last time I looked).  So how does
> this work?

Hmm. I'm not sure. I can't even boot a SLOB kernel these days (even
without these patches). But, pages are shared between kmem caches on
SLOB, then I certainly can't add this check for it. :) I'll adjust this
patch.

-- 
Kees Cook
