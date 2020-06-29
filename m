Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8E9C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BD25208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H/jEqMD1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390416AbgF2VYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729502AbgF2SuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:16 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5DCC031C40
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:50:16 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x3so2747961pfo.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 11:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=IvtcfFZZb6MrwnG6pfelExB/xyAxufFTua0HopUMxCU=;
        b=H/jEqMD1SdPz6aA0pAK8ExCaF3JVkU35Md8uqDiJLGEEGf7E5Leit4kCJJ1irK9uIb
         Tzx6RKVhPjKznVV634fxBlhD9fMVYiRVb/MmZRnN9Qq5ikDNYxyzq0YNseNiceylR7tL
         KYLHl0LE6ur7y11jNaH7Ugj8sFCWRn9rw3XDdJkWG8mJcxCo5sWLxNL+NBMxJqEqaUwi
         X+X/M1/BWx0+c504Rm7O3KDFBHmrznaS9OK5h5UYz0C3uA0aJwmrlVLO7AODVCASBl3i
         QN6Raks5jplfCGtxAE++JPFO42hrsDclow1zfk89aWp55h09EMI+Qx8SZzMJ+w39iIkn
         Splg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=IvtcfFZZb6MrwnG6pfelExB/xyAxufFTua0HopUMxCU=;
        b=B1dL7z6CseH3QFtCM5PoymrN1WvE+/PR9x/BWSs5UB/ysduiO6WvQJLLEsbtX12jmc
         ynqnuczVIYUso1QgcZj+K3vRitwBtSoliNrEXb3eVZq+24m+/675G6UV/eC7yFM73DjC
         ha076JXsi+972uuHVNFLf4HJVobFCX0APTa8kNgjnbysZr22yGBNqzCiGqmaSertL23I
         do5XLQmz5jW8Ggbyg3wfJ75xmvHXpC5TfvlTlMZBNN2On5hKlcIQcNaMq1HpYw0LTexl
         F2Bl2T8P7VrofOIoQHz8Sfe2MlG0av9QwrJQKIje0PiwIyDHuqNEd+7iBztPIp/itSjT
         plNQ==
X-Gm-Message-State: AOAM532WjAC/L2B3dT80OcRfGpR8B7vCE2J7FMWZ7nRCt55njwINkr/1
        7AzV6RofrXpED5vsWjbSLePZbQ==
X-Google-Smtp-Source: ABdhPJxL3kQ0LFQSbczS6Y5Fq3oezIBxASxtVF6xl94kQKNiE4hpG9cpR01wPsXtOn/372mJgk3tKA==
X-Received: by 2002:a63:525a:: with SMTP id s26mr11270037pgl.155.1593456616190;
        Mon, 29 Jun 2020 11:50:16 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x22sm406823pfr.11.2020.06.29.11.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:50:15 -0700 (PDT)
Date:   Mon, 29 Jun 2020 11:50:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Su Hui <sh_def@163.com>
cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove the redundancy code
In-Reply-To: <20200629173047.GA38128@ubuntu>
Message-ID: <alpine.DEB.2.22.394.2006291149040.1030250@chino.kir.corp.google.com>
References: <20200629173047.GA38128@ubuntu>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, Su Hui wrote:

> remove the redundancy code, the zone_start_pfn
> is assigned from zone->zone_start_pfn
> Signed-off-by: Su Hui <sh_def@163.com>

I don't think this is redundant, it's used by memory hotplug when onlining 
new memory.

> ---
>  mm/page_alloc.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..3372a8c9fbc4 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -6215,8 +6215,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
>  	if (zone_idx > pgdat->nr_zones)
>  		pgdat->nr_zones = zone_idx;
>  
> -	zone->zone_start_pfn = zone_start_pfn;
> -
>  	mminit_dprintk(MMINIT_TRACE, "memmap_init",
>  			"Initialising map node %d zone %lu pfns %lu -> %lu\n",
>  			pgdat->node_id,
