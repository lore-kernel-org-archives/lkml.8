Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA825C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4F7A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 20:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="r54QaoLh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726750AbgEGUfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 16:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726218AbgEGUfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 16:35:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0500EC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 13:35:06 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b188so7623056qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 13:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RSDWBO3KlSH7VUaml385yztVrt94O/2spKycJW0cj/0=;
        b=r54QaoLh54AUaLYcMXfF56LEl3r+ooemYCoqO7ird14qYPBgk+62dOPtF7vzatUcbV
         TI3dAf4vwvc6fqdSnpT5VVVntfLPsbm7TOVZwgePR0+8l471+2W99dDqiUxzazExetKX
         2D04O4ZoLBnVFXEgZRHkSXONB2MPOpGWxoxumdV8WAdHwDr1mA7o051gdl5p4kl9iJ0K
         aRNRtGRMR6m3YiPGHP6X4eXqSXxiJDR3uImh+palqnnsrf1bwQuO/N0Ob+junxtbcIxB
         eyX0IXQP/lqCC0vmcAy9nERkERqWEpc0q4jOmLMsWsFillX71G0FWZTWqr+V5p9eNMZN
         PSNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RSDWBO3KlSH7VUaml385yztVrt94O/2spKycJW0cj/0=;
        b=FWv91soS55DtavNT3imYFGCc+crqSmTd3p+UolmJ/PmfkstqwChXRHbD+0CInVVcYr
         0StpwgbGu8itgIe5JgPTiQyn7mQ05qTiboMgu8QzXIO/R84hMLPrDc0qWFlm+zKbaMLK
         Ec82vfywuHQpiXy3ecek+STvUhOOI5bO9jBWgvtoXlncHURxyEZ1V6BWp3gA75frT7F2
         avL7czDzeP7/PzGB/8K8BL+GrTcU2ED058upx6OXx2tNLMnzy1SzbpcrOflmvnIKhy2t
         9t46d+w2reXqgMbr3EiIx0RK1Ymw8K1iJG7yIx8k1VpCJ2rIuKzPbPR7NOeYjA8zPeIy
         I4ig==
X-Gm-Message-State: AGi0PuZaY3EkaNhfausflsN/yXMNY9YXJvZ4/6f/v+j6R3+JJY+1YYIa
        91GP/XLO7I81HFd2CxPcFu7G0Q==
X-Google-Smtp-Source: APiQypJnQGp+W8vdB4wl6qofgeQ17bUrjsLYFEjiibo3uV4je5mhYeTV9b+raRIejY0clyGjHc0k7A==
X-Received: by 2002:a37:82c1:: with SMTP id e184mr17283899qkd.186.1588883705299;
        Thu, 07 May 2020 13:35:05 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id 124sm5220016qkn.73.2020.05.07.13.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:35:04 -0700 (PDT)
Date:   Thu, 7 May 2020 16:34:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/19] mm: memcg: prepare for byte-sized vmstat items
Message-ID: <20200507203449.GB161043@cmpxchg.org>
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-3-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422204708.2176080-3-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 01:46:51PM -0700, Roman Gushchin wrote:
> To implement per-object slab memory accounting, we need to
> convert slab vmstat counters to bytes. Actually, out of
> 4 levels of counters: global, per-node, per-memcg and per-lruvec
> only two last levels will require byte-sized counters.
> It's because global and per-node counters will be counting the
> number of slab pages, and per-memcg and per-lruvec will be
> counting the amount of memory taken by charged slab objects.
> 
> Converting all vmstat counters to bytes or even all slab
> counters to bytes would introduce an additional overhead.
> So instead let's store global and per-node counters
> in pages, and memcg and lruvec counters in bytes.
> 
> To make the API clean all access helpers (both on the read
> and write sides) are dealing with bytes.
> 
> To avoid back-and-forth conversions a new flavor of helpers
> is introduced, which always returns values in pages:
> node_page_state_pages() and global_node_page_state_pages().
> 
> Actually new helpers are just reading raw values. Old helpers are
> simple wrappers, which perform a conversion if the vmstat items are
> in bytes. Because at the moment no one actually need bytes,
> there are WARN_ON_ONCE() macroses inside to warn about inappropriate
> use cases.
> 
> Thanks to Johannes Weiner for the idea of having the byte-sized API
> on top of the page-sized internal storage.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
