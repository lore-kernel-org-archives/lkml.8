Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477A4C2BB85
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C39C20732
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 07:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aZOzCafi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgDKH6P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 03:58:15 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:42536 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgDKH6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 03:58:15 -0400
Received: by mail-pg1-f193.google.com with SMTP id g6so1970174pgs.9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Apr 2020 00:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=EehHYzmjydlDblKb5eenxnncMIMEQFB8m6zXlNX8Y54=;
        b=aZOzCafixFqiLR84tkgtkDDcAPF2VhN/8KTpJpvBhQkAt3tqIuQeq3btfm0BOQf6BV
         eKQ4/LK2/Qt/TNcRgHuoHaqNfLZymEp0Z9XJhJPlCYI+bNCQqEQdkHXEJOaVSsIsz/h1
         Q8CqhE5SIYjJl5e7oBcgN3ow7vDkp79ABjVmLjvZlPO3jEklv4EOjTq9ggsg+3EmbvL5
         L4UiCiakywz9K4phwwtKxC/unC67/5/kZZM1IV4GwIhRuFTOgGCpVmwCXFA9jGa4UhiN
         hUPT8bcFh6b4azbPjUaaa5EWM/x/ePtQY9QcKHVrVkTyjCZVJI8qAp4rR1uv1101us9h
         RSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=EehHYzmjydlDblKb5eenxnncMIMEQFB8m6zXlNX8Y54=;
        b=FoR3M7fWGe92It2qb9UkTDjqAIaBANkxgLkfpdLB41nzGxLS4n0bJTVzPlBaB5R8dd
         6dQxXQv7hPoDjGIk7Md9S0STtNYXytt/Pit3s+60Zhh5E85I2SJ4i9Z40ddLh7GrTh1a
         gSZ995Jt3l6q03oD3xpuowHYkipm+N4GBaZ/dQS6apyR+UzouO2MofgVNkcCBjhp76yD
         ALGV1bZDdUg/6wZ80Qkk2blKshsFQp+OHkfBhq6EKAZyTYe0hvymQyyslpmAYstRpgs+
         eQFJ4kJrpU2+SZ1S7kF3RXtLN34kUO1BRQiogdUZ7XBtky3RUo6j1S3GEFEAUKX9XJ2v
         R/SQ==
X-Gm-Message-State: AGi0PuYKMuhWdps/bAGyDWZ34JW3ofbx9X/GvRwr2A5n3WxZk5Nt46NE
        qkBRjr13gYaGcNUQ7A7Qi2Y3EA==
X-Google-Smtp-Source: APiQypIxO3Mmi+Q1QMMfto2TPeI5ZK2HS9RSIig+k3sWeHIpq8UjI+qQbNqphhKRzlrq2DFvyP4Z1w==
X-Received: by 2002:aa7:99d1:: with SMTP id v17mr9279712pfi.165.1586591893917;
        Sat, 11 Apr 2020 00:58:13 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p188sm3501495pfg.184.2020.04.11.00.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2020 00:58:13 -0700 (PDT)
Date:   Sat, 11 Apr 2020 00:58:12 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Ethon Paul <ethp@qq.com>
cc:     akpm@linux-foundation.org, cl@linux.com, penberg@kernel.org,
        iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slub: Fix a typo in comment
 "disambiguiation"->"disambiguation"
In-Reply-To: <20200411002247.14468-1-ethp@qq.com>
Message-ID: <alpine.DEB.2.21.2004110058030.165229@chino.kir.corp.google.com>
References: <20200411002247.14468-1-ethp@qq.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020, Ethon Paul wrote:

> There is a typo in comment, fix it.
> 
> Signed-off-by: Ethon Paul <ethp@qq.com>

Acked-by: David Rientjes <rientjes@google.com>
