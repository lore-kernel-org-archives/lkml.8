Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0418C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEAF42080C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 18:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E5rFtQwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHLSxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLSxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 14:53:07 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65255C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:53:07 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t10so1504522plz.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mvT9RAGgSpw435+n1f/WsXfGBWWLgcTYIOxF/LfVB2Y=;
        b=E5rFtQwaqN5eeGvsDQ27/TvbwqKxFxXTL1048fKnJEqT4AxiG9QcsdUlPl+WFBow9B
         Zp8AQCh1S2z/fkjWfikMT4/jLfa0OUEq3xQk+4ECLtLCOYvlp0ITvbjS8FPRRHrWH1ps
         pFrlEWTi9HeETFb2vEaa7D+eZYX5zptymFIifZe9Abb54eraBfsJicthzuyAgpzRGBwo
         NuJ2C38C3XM3veHhiuSOxLDP8AIdywbiykEEqizIWs3mdPnJlRV2HMYZ+gX2yTa5CiUn
         xUkqLI7h0gk6K0d12a1zYjsFFaOtF7Ck/znPTgx+W57xAPBFKqhnWNvazvgXyxtC9jJ/
         dKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mvT9RAGgSpw435+n1f/WsXfGBWWLgcTYIOxF/LfVB2Y=;
        b=TAbiPrCkSO4WqUj5LVwqBEswcfp8TRZWjxgLzcH9wjVMC4Mlxo3knfyhWXeNGCvu++
         uIWy9IEEq64f+pg2xEPqqipEWxLoBDIb4kYGHiXpJviWZyFis51hnTbShIqAlfDhK9tF
         rLvKV/TrXQ8eJHsQNIw3bEX0n1zr4uXN8Buu5KFUF9rtaF41J+BuD/k7l/3UitxGv3jg
         /eXce+rMod7dRsEAuiFc/I35p+jeSUYo4dKqhRTar5vhh2bbfprU0LWhbJSC3Uhoso/t
         iHtCD2LY41PZRIIDYPyZXTAknv7Kq7mqZ7Lfv8HAORtrVZT3GY4CP5QW1ix+VS4VaEF8
         EdGw==
X-Gm-Message-State: AOAM533Vp1T/Cs5y6uV0MNekve6LXpIE5ALhbEIG49T9dbiL+8mqV+t9
        YcUmqR9/tlsSxYfkth2dDL57vQ==
X-Google-Smtp-Source: ABdhPJwS9qbBcIMDlcZDb7L0uk0p7olkjj0HlvUX0LKK70mOSI+aSf/OttudoE01nHPFbo9DfayEYQ==
X-Received: by 2002:a17:90b:808:: with SMTP id bk8mr1264847pjb.63.1597258386773;
        Wed, 12 Aug 2020 11:53:06 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id d127sm3120353pfc.175.2020.08.12.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 11:53:06 -0700 (PDT)
Date:   Wed, 12 Aug 2020 11:53:05 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Charan Teja Kalla <charante@codeaurora.org>
cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        mhocko@suse.com, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in
 free_pcppages_bulk()
In-Reply-To: <848b7d60-2995-d9ae-0055-f3864dece11f@codeaurora.org>
Message-ID: <alpine.DEB.2.23.453.2008121152420.3738823@chino.kir.corp.google.com>
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org> <fdf574c8-82be-6bde-b73b-c97055f530a8@redhat.com> <848b7d60-2995-d9ae-0055-f3864dece11f@codeaurora.org>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Aug 2020, Charan Teja Kalla wrote:

> >> Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
> >> ---
> >>
> >> v1: https://patchwork.kernel.org/patch/11707637/
> >>
> >>  mm/page_alloc.c | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index e4896e6..839039f 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> >>  	struct page *page, *tmp;
> >>  	LIST_HEAD(head);
> >>  
> >> +	/*
> >> +	 * Ensure proper count is passed which otherwise would stuck in the
> >> +	 * below while (list_empty(list)) loop.
> >> +	 */
> >> +	count = min(pcp->count, count);
> >>  	while (count) {
> >>  		struct list_head *list;
> >>  
> >>
> > 
> > Fixes: and Cc: stable... tags?
> 
> Fixes: 5f8dcc21211a ("page-allocator: split per-cpu list into
> one-list-per-migrate-type")
> Cc: <stable@vger.kernel.org> [2.6+]
> 

Acked-by: David Rientjes <rientjes@google.com>
