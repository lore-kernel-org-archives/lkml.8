Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75168C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:46:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F5DA2072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:46:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="UicR4JIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbgFIOqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730603AbgFIOqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:46:38 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E389EC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 07:46:37 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f18so21040689qkh.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K/z6d17bM6CZ1yRiOWNL2RNldGzd1FsrG0sI3iVgOdY=;
        b=UicR4JIbN42s8kz0OU+6/Ag9GZZSbq+0yM4FgBbXTtyCBq58aliQiGguIJJDXNrkKS
         96LEnAh88GMRNcnytADnFry3HoOGQY0ByuYcVHq9xTgM2aQ+uQVa4V2mt2bJS5A9HyPT
         VdGzC4RdpUtv4WmbAtK1nVmNWKyb8GbBXIXpCUKvND0akz6zL2J03wQKTvvL5ppjGcwI
         lfUD+Xp624KOABogal8AdKwZhNOH3tTVeMtDtZ2mnhqVSsZSLrs+y6s4gDH4qm8oQiJ5
         UXhgne+FHZwC71UMSeaUiUYUZ06acXylqoK7As8lUhTs3cI1b7UJzr2jS5uPuwNUgq8o
         kzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K/z6d17bM6CZ1yRiOWNL2RNldGzd1FsrG0sI3iVgOdY=;
        b=EZmTAt4F/qJ7xb0mjvNIL+i/6a6vaHzo8hrpAi229FcjWCxmu0VuW4W/yD9zxEBgNF
         mOk8b8nTwexdMG6aLRDVGtMvOTYZBaoDIWLbTe3ccNq79f1KBLsDhJRP+W6Ys2SkRDMK
         pRDiLb8ll3R/Az0KkireyQn/7DpDrSFEIx0lTm8MMvkgBQJSbdEXkX5AwfZ4OwqZCwyw
         FCOvlqEo5x26o9x+ieDoKs2pkN3e6jvP9DCkH2TUA5hGEQd4lKk+4fXVWnC6T/3OM1b9
         8vI819LZe4QDKfCxgmI+N7V1Gc4A++IAcdJMrQNX8k5f2DZoLZdlgYfNLFloFc+lypuS
         hkXA==
X-Gm-Message-State: AOAM531YGmWkS2+RHIPDqEOxtfKYUQn10qd2Dq49Z0VzESa/EXW9JI+7
        wfjBOgXWKxwX8lOAy77rDv4tHg==
X-Google-Smtp-Source: ABdhPJzUlzfAEXmBIoUGNXohwOf1MQpFCkJG/fDZNnAITRiz9+WNk5lph79IKWPxvKqUzgaRsRxMcw==
X-Received: by 2002:a37:7c6:: with SMTP id 189mr27091666qkh.24.1591713997119;
        Tue, 09 Jun 2020 07:46:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:b568])
        by smtp.gmail.com with ESMTPSA id b4sm9087946qka.133.2020.06.09.07.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 07:46:35 -0700 (PDT)
Date:   Tue, 9 Jun 2020 10:45:51 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org, mhocko@suse.com,
        minchan@kernel.org, mm-commits@vger.kernel.org, riel@surriel.com,
        torvalds@linux-foundation.org
Subject: Re: [patch 113/131] mm: balance LRU lists based on relative thrashing
Message-ID: <20200609144551.GA452252@cmpxchg.org>
References: <20200603230303.kSkT62Lb5%akpm@linux-foundation.org>
 <a60f7866-3b32-7a0e-5d0a-a48d77f845a8@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a60f7866-3b32-7a0e-5d0a-a48d77f845a8@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:15:33PM +0800, Alex Shi wrote:
> 
> 
> 在 2020/6/4 上午7:03, Andrew Morton 写道:
> >  
> > +	/* XXX: Move to lru_cache_add() when it supports new vs putback */
> 
> Hi Hannes,
> 
> Sorry for a bit lost, would you like to explain a bit more of your idea here?
> 
> > +	spin_lock_irq(&page_pgdat(page)->lru_lock);
> > +	lru_note_cost(page);
> > +	spin_unlock_irq(&page_pgdat(page)->lru_lock);
> > +
> 
> 
> What could we see here w/o the lru_lock?

It'll just be part of the existing LRU locking in
pagevec_lru_move_fn(), when the new pages are added to the LRU in
batch. See this older patch for example:

https://lore.kernel.org/linux-mm/20160606194836.3624-6-hannes@cmpxchg.org/

I didn't include it in this series to reduce conflict with Joonsoo's
WIP series that also operates in this area and does something similar:

https://lkml.org/lkml/2020/4/3/63
