Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21C5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 767002078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="K6SqQUN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730553AbgHZOKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727115AbgHZOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:10:48 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A61C061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:10:47 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b14so1956967qkn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 07:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=07tvp8tVnrNw0e+tjr1QQnFIWOj/9N9xxnjDg1Dj00Y=;
        b=K6SqQUN8bdHK9sa+izhojjrbFpSuAwM1EM8gaAaK2UQZcDkd7jp4MSY9sWz+TgOC9q
         Ew/yxmU3JV0Qj/Wi0mw9w6VbwioBytFjVidB+UdF1T4c6UHFwcWGrBe4CT0q4M3aErez
         cVhOcHqjMFlaqBOXb9WKF666y6UVO1pGelyuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=07tvp8tVnrNw0e+tjr1QQnFIWOj/9N9xxnjDg1Dj00Y=;
        b=Diqflc9nwOYlZV+88B6JZV3mDYfEAML26EgA0w0ZgehxkwC/SVDYGPpI91nDwjgjUz
         WEh9SaBPOHwDuYfOZw5+Cme5iQLWuMrEs87KhyXonrNlbgcT+JqTDgEkYfU8a4LSk+xR
         rOICBUbWkYL9A/2tvbxaRalXYGloOMT672YiCVMuDaInLOXsqW/FnM6f2Dcv3JDW3LaI
         1J/Y2AHflyZBAg+eNMZFR/IB8ie1WOwbiPJct4O7RMp1oTGhUhXMB22TdYNqP72H/7Ot
         V3ZW8oLyiuXEiMVcEsIystoWwec7pVLbvvoMIRd7WDMvpSSXvB4HYfXArOjovcAsiRx0
         YLlQ==
X-Gm-Message-State: AOAM532qLPmlY6G/WVg3zqREEpeBBWV8JBOc5ZmIwofwu0/J1/m3rQWn
        Wjg89t4G8P3j856d1yO6RLmxEw==
X-Google-Smtp-Source: ABdhPJxZa4zJgLUey7TcyfqsJlg8vcBGdBaX+/p8GayLjM0Nnrm1I869irmbDo9IbceOBPOgmWa4iA==
X-Received: by 2002:a37:7407:: with SMTP id p7mr14409179qkc.350.1598451047035;
        Wed, 26 Aug 2020 07:10:47 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:fd2b])
        by smtp.gmail.com with ESMTPSA id b23sm2041262qtp.41.2020.08.26.07.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 07:10:46 -0700 (PDT)
Date:   Wed, 26 Aug 2020 15:10:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200826141044.GA831829@chrisdown.name>
References: <1598449622-108748-1-git-send-email-xlpang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1598449622-108748-1-git-send-email-xlpang@linux.alibaba.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xunlei,

Xunlei Pang writes:
>Add cond_resched() at the upper shrink_node_memcgs() to solve this
>issue, and any other possible issue like meomry.min protection.

I understand the general intent of the patch, but could you clarify your 
concern around memory protection?
