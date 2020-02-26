Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44659C4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13DF221744
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 01:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cMZyruXs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729854AbgBZBc3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 20:32:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37306 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729395AbgBZBc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 20:32:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so551909pfn.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 17:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QGVoInCNmu8ZzMYmZXdTHXHi+j3WLOo8+btiFix0h28=;
        b=cMZyruXsJf+pGUh7iEAlG5NywteERqKsrsx7J98svJV4/9Xln+d/iie6kpru3zcKvS
         yw3R+sEA8r5MvMBbXohJ62LLc4RH5VrOHVvWumGNwBAxozyFDkVpFiV0uOf9lSsck96W
         ohLXDCKiarMkJZbreViNDGewyU7jADg1d+A3tgr/naBCpgrvY49Q8UI2GXDSUngtRdOr
         k6YoeVSo4i/U52qxoDvgpeSy/SjQPGAvaip4bQn6110e0L6iRSiTsbtxjFEl+gVn7rrT
         lhDdSj05O2eCngCrgUvJcdHlpWVc3vwqPA+HwWgFhWAQo3if9YK9MuhJT1//L4wi9tI4
         t2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QGVoInCNmu8ZzMYmZXdTHXHi+j3WLOo8+btiFix0h28=;
        b=r+XSeqgYoMIyJMRBPxlMW/yJLMa1gFuyfnOuSdPgVMFf2eHzOVr9FcMmJj1KJAv13z
         LVVwgyui8Wsa5RP6IbtDabEezHf1uFVEnhLCrQD/EPMSvFN9DVXGI6/3m0Qd6UDHKaPU
         Z6pKPminHk6xa4ZaaIeBwfuFb4j9N3b+5oYZZfevfihIatBdgH9oRP3+KcG/yG+xBF5s
         TsqF4fb6VQQJvrFQjUHLzTNOymuIpOm1L7syxt91SXgC3ey5McIqyvtIXAXkhyJkVFxy
         RJw2oJrkAS8HF8Rj+zVZLkkByJVc15cs0RcrAgzEBOmTCkY1zhFVNoCVnoKb7/BIsPu6
         jeMQ==
X-Gm-Message-State: APjAAAX9kQ/xu80oX59N/Onum1LPZ0azvU3RmdZH670L+CFb9sLK7ORk
        JzHgnDP0sOtggmXuc8DPQWWXtA==
X-Google-Smtp-Source: APXvYqw5igQcRBjvwdMbNMWg7/TudhemJKHFEauczrz/uXC69lZrRHVFe5sstpLf5F0sd3qHQFlC5g==
X-Received: by 2002:a62:16d0:: with SMTP id 199mr1643753pfw.96.1582680747619;
        Tue, 25 Feb 2020 17:32:27 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id b3sm349178pfr.88.2020.02.25.17.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 17:32:25 -0800 (PST)
Date:   Tue, 25 Feb 2020 17:32:24 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm, page_alloc: Disable watermark boosting if THP
 is disabled at boot
In-Reply-To: <20200225141534.5044-3-mgorman@techsingularity.net>
Message-ID: <alpine.DEB.2.21.2002251728520.14021@chino.kir.corp.google.com>
References: <20200225141534.5044-1-mgorman@techsingularity.net> <20200225141534.5044-3-mgorman@techsingularity.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020, Mel Gorman wrote:

> Watermark boosting is intended to increase the success rate and reduce
> latency of high-order allocations, particularly THP. If THP is disabled
> at boot, then it makes sense to disable watermark boosting as well. While
> there are other high-order allocations that potentially benefit, they
> are relatively rare.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  mm/huge_memory.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b08b199f9a11..565bb9973ff8 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -472,6 +472,7 @@ static int __init setup_transparent_hugepage(char *str)
>  			  &transparent_hugepage_flags);
>  		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
>  			  &transparent_hugepage_flags);
> +		disable_watermark_boosting();
>  		ret = 1;
>  	}
>  out:

Seems like watermark boosting can help prevent fragmentation so it 
benefits all hugepage sized allocations for the long term and that would 
include dynamic provisioning of hugetlb memory or hugetlb overcommit?
