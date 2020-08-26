Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFBBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 094BD20737
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 18:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="MxnkLlVm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbgHZSUN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 14:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgHZSRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 14:17:31 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9C4C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:17:27 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so2806276wro.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 11:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y6ou1YIg6/FSZwY6sCFlxyJXSS2U1nvtnVmIFITiGPk=;
        b=MxnkLlVmtCcScdoWsKa8tkyeuJTdWCXa+GhoLiRAMUculUoCi6QlgZqMBu50pdj1E2
         ENHqlArPo/uwpjZ7fjUAItyvX4NA/RGIirDmsw3a58G37cfKzv/UDyAqjYGifh8t+30d
         MJdnHS+XiGwEP2ZyX3m2e9ASoK19I/qva0lWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y6ou1YIg6/FSZwY6sCFlxyJXSS2U1nvtnVmIFITiGPk=;
        b=m23aeBDsP70JKFcVxnWWGeN7Rnne17iAzIwtl4aT7P5re7AJrONVTO7+Tk0k0/xdyP
         636seERMngJLYb6T6TYH8FECkHDohUM3sTWdNi9QrZs731aEBfS/P3E+iQr77VpnTdrT
         gyVCjRYKi737ZPskeynDk6J1dMaqTD2TeZ6Jkzuu0SEePaLOroR97/pzkC+KcoA6NlkI
         wSGCIDZuo1uEXFIyY4jMFCqHrLmC7V1s/klvnOTpBE+4v4ca9jYIJjwiCVwDFgs2Cn0s
         nHIBmJuFf21vzFDoBFjh3T7YHuumM2Br3XjQ44Lx8fa6LPb7P2JuKvtGg7gwblsYj9R+
         BWcQ==
X-Gm-Message-State: AOAM530vStcjoA4GB9dpj0S19GTc6wUqDPtHTpgIsYxi/t8fuuiTVKlc
        leSREHBfqDPD4rml2rm0rH2k3Q==
X-Google-Smtp-Source: ABdhPJyGF58PxyEr+qbqcdQwHAQEk+hu1MR5ecSAWIYbHlJJCdRwZbU1YlLYxCkFy3QQ2wJ40JOTKw==
X-Received: by 2002:adf:b1cf:: with SMTP id r15mr17866122wra.118.1598465846190;
        Wed, 26 Aug 2020 11:17:26 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id o2sm7485419wrj.21.2020.08.26.11.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 11:17:25 -0700 (PDT)
Date:   Wed, 26 Aug 2020 19:17:25 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200826181725.GA893402@chrisdown.name>
References: <1598449622-108748-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826141044.GA831829@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200826141044.GA831829@chrisdown.name>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>Xunlei Pang writes:
>>Add cond_resched() at the upper shrink_node_memcgs() to solve this
>>issue, and any other possible issue like meomry.min protection.
>
>I understand the general intent of the patch, but could you clarify 
>your concern around memory protection?

Oh, I see, your concern is just preemption in general rather than a fixing 
anything for the memory protection side. In which case, go for it, but I agree 
with Michael that it would be nice to send v3 with a clarifying comment.

Acked-by: Chris Down <chris@chrisdown.name>
