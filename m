Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C79C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1A0207D5
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FjJJwJCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgFEVHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 17:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727888AbgFEVH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 17:07:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E143C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 14:07:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so4181061plo.7
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LAKOPXbe4RPyKHwWm8SyOT1HEgYJl1gtZcKOt6lUg6c=;
        b=FjJJwJCcf9AvvSyyshowMJu/voV+MLp0TA3WCFDzlRbz7EjF1WrlqA+c4PDQTjbA5b
         brD8n1tfCs4jieTe0se2Q4IciRQUKhmKKrzlbDGyZhO/VvGMHb1tRrqGRtg8I/Sm5Gex
         pwrQhBd4qfmx9o2usDhyuWrosKBbMETOBq3v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LAKOPXbe4RPyKHwWm8SyOT1HEgYJl1gtZcKOt6lUg6c=;
        b=nEwX2szpB5YGYElSylQAMheAddL474MNX5U/qXgyeGEI1da5HJK5Pj64Rg8iDCKsmU
         m6Kgh8H2ja4msS+MY2norD7DsAuDSJ5qIKYmGapB3aj2B9ySYdMcQ/11NYx0nGS6g3wU
         bYMVhHLDVlaPjw20eLH2RR9Qy3+F8JOoXGbAs2Jw7Kok0WZoNz9gwRAhGj32NZ5MnoTk
         DL+ug0fjs1vNacSss5cB6Ac9ypxZKcPGiCHLbP7u5CQKmczHPUL6uvJyOiFl+tjnCpkR
         9wbhW4bElRSpMYnviB1EWRByjgqKMA+mXdThihN2HOOOdIxaM9G+X9Hl6WM3M/IT+fPc
         EzIQ==
X-Gm-Message-State: AOAM530tV2pSH/zP/5QtJZSH0ANZcGUnuufOYP8Y088zQJEEGcyHIiVd
        FsXIIEZ5dT4GR0Id9dLsUzZ9ug==
X-Google-Smtp-Source: ABdhPJynPweyb9yyxMtn15+LBtzfHV7x58u9sRCi1LH2+vF1aXgbJMfpp86VUeLqomjGYKh/hm6pIg==
X-Received: by 2002:a17:90a:db90:: with SMTP id h16mr5145656pjv.119.1591391248908;
        Fri, 05 Jun 2020 14:07:28 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u7sm450764pfu.162.2020.06.05.14.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 14:07:27 -0700 (PDT)
Date:   Fri, 5 Jun 2020 14:07:26 -0700
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
Subject: Re: [RFC PATCH 5/5] mm, slub: make reclaim_account attribute
 read-only
Message-ID: <202006051407.2B00B067@keescook>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-6-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200602141519.7099-6-vbabka@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 04:15:19PM +0200, Vlastimil Babka wrote:
> The attribute reflects the SLAB_RECLAIM_ACCOUNT cache flag. It's not clear why
> this attribute was writable in the first place, as it's tied to how the cache
> is used by its creator, it's not a user tunable. Furthermore:
> 
> - it affects slab merging, but that's not being checked while toggled
> - if affects whether __GFP_RECLAIMABLE flag is used to allocate page, but
>   the runtime toggle doesn't update allocflags
> - it affects cache_vmstat_idx() so runtime toggle might lead to incosistency
>   of NR_SLAB_RECLAIMABLE and NR_SLAB_UNRECLAIMABLE
> 
> Thus make it read-only.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
