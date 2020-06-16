Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC6CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7C2208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="T9PcuYYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgFPOtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgFPOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:49:16 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC9BC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:49:16 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k22so15632425qtm.6
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 07:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CUmJhIGetdIkAi0i6BuHTYP3lWjyyl3D6ViYyQf5Uj4=;
        b=T9PcuYYuyqV5DBP+Yu+qBoWWvsosy7WrOz2UZz9Zck/OOGvvo09KjfNXgQ8YmHT6H/
         eCU+bRWnVVWYfLKI7uTYZiiZiXisshQs0IffavOpsOtanvduJmuOVdtdDjHdJrJJinQx
         2mEgqZU4POO6ZaqSAI10q5E8bC3FnURn+gPrsAVIvA1MkX5MM8+9nYFteJDBnWFeFHyc
         bxboleBlmbyJU+PQ+eusbLckfBFxu805iZ3sEmSEXR/4GSuUjIuTlmlZJsJa2lUeP6+j
         X7xL1UfBG3hpLiuxOMQ//BR3YfrMN8mxysgjo9hY6Xx8mbesxNOrj34Oyczf+uhFQv7y
         2ibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CUmJhIGetdIkAi0i6BuHTYP3lWjyyl3D6ViYyQf5Uj4=;
        b=YfoYmx1U2NVh75blwKR9fCmXzojyledZd/A5JuluUYFHYotIOOQMyLxDjomCprQpn9
         bpC5wTN7XjYe9mPuirfm+sB1Asw+vWKOoS29rYx31TmAuHKNItcITZ3S9cacrRuxakOh
         SWtxic8laUtpdg8NyY71J0ML6K5Ig5fwV3DzDCCBgi8gPOzwXy9Ww1eIY/i5YtQy9S0E
         pGeU2cV/JRZHhirhQ4UeS6sXU1g1q7b2M3ou53VPTX2V3qrh1YS0vZYSMuHQVO7NUE/b
         /TQ9BEeco+zTmbGcxtDwwCwpllAh3XJeMhmFNnmt3gu8OVHCM4R3/3FKi+2zYbdKfaR1
         H2YQ==
X-Gm-Message-State: AOAM531pRietoz17eMOtXleYKBu1U8vtxSvks4jEQkmx1tiqucY+sKS6
        OA9aKl9n51a1fwaO18GAc8ljIJ8DXUQ=
X-Google-Smtp-Source: ABdhPJwj4PjxoL2t78uKg/myLcWJrkgfT9al4jQhoq8LRWuMH2RgCLfzDv9x9ep3f8Ovj0ZUX3FCVA==
X-Received: by 2002:ac8:4281:: with SMTP id o1mr20843587qtl.322.1592318954708;
        Tue, 16 Jun 2020 07:49:14 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id c58sm16783501qtd.27.2020.06.16.07.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 07:49:14 -0700 (PDT)
Date:   Tue, 16 Jun 2020 10:48:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH for v5.8 2/3] mm/swap: fix for "mm: workingset: age
 nonresident information alongside anonymous pages"
Message-ID: <20200616144836.GB616830@cmpxchg.org>
References: <1592288204-27734-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592288204-27734-3-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 03:16:43PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Non-file-lru page could also be activated in mark_page_accessed()
> and we need to count this activation for nonresident_age.

Good catch. Shmem pages use mark_page_accessed().

> Note that it's better for this patch to be squashed into the patch
> "mm: workingset: age nonresident information alongside anonymous pages".
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
