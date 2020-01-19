Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B09D5C33CAF
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0C5208E4
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Htb8a7DQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgASWHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 17:07:50 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34290 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgASWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 17:07:50 -0500
Received: by mail-pl1-f196.google.com with SMTP id c9so7008210plo.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 14:07:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=/hL29TjD11NGp8Ljf9rHQ0/AomEN8AOZ3o3x8TsgXFk=;
        b=Htb8a7DQKkL06WtZXoCSnCOkhCYVkwPXtAjHrfTT4Xf/VJ7nmB6lqnfWKNBWwhtOS3
         siqlOUsxdP8pNvX68Wd1JyIArmQdGVKeeaqGXGHBnTRBjNnc8aCDLm1rl9WvpmeKx/Pj
         QopS5fa0Wg1ErVLFS6THufGI7FsHFbapGRaFomm+XycZKqMzdZm/OJuBOnyPp7Wf0nQE
         En/g4tVfelYvlC+Y8w9P9YCoe/9zOAkU3xct1fPfoQwy8JP0pUXHmioI7m94tgNchdEt
         /qaA/zvDDagxoYQ7uAx2SQtsfeG6IOBrkr4O7YrZwCKAhnagumI5u15CBCCBeV2Si05a
         DNOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=/hL29TjD11NGp8Ljf9rHQ0/AomEN8AOZ3o3x8TsgXFk=;
        b=kybcLyEJGPOiOn9C7jvvjgH5u25i4d63Ykr2XYp3Y0gjty415tCzp1gJ9QRwPS0Y6w
         fx0/mqMQ4vJb6HbxaxoCmyYfJSD2Ve2TrH3MsPJcT4udq0aFJ+P0Y9PT5jzum4pQ9760
         B9uC/vjQ5rizhfzlV4yZxP6hobljfWxnY0k/YrQnuwlvsYCd4B2B1q2AGZXgDln87OGo
         lJQj6tyTwTibla9iT7T3BKv/L/ixWE3F/NCoeyhKdXdrlZvNZglfUDDmCKIgbRsFt+SU
         6CJC9/Z7dFNmuudQlHgGa2SOlRtZ67uncUG+3cwEeg9hN+IDje4/kfBmMWw9yZn3WkjP
         DFaQ==
X-Gm-Message-State: APjAAAWMaWUIMPbxGGydJEk5r91zTi207u7UgFJXrvL9HMQDMUzKwN/Y
        bj4bSCPFvv7Fn0F1W3PxbqOISSvgDqk=
X-Google-Smtp-Source: APXvYqy3TwdlfQVbRBki8jvV+Ha5LEu15W292YWV3lv0kmcreU2NGVrJBpZ3J28RMy/c6CpAjCfdzQ==
X-Received: by 2002:a17:90a:cf07:: with SMTP id h7mr19741769pju.66.1579471669229;
        Sun, 19 Jan 2020 14:07:49 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id p17sm35685755pfn.31.2020.01.19.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 14:07:48 -0800 (PST)
Date:   Sun, 19 Jan 2020 14:07:48 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Wei Yang <richardw.yang@linux.intel.com>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm/page_alloc.c: bad_[reason|flags] is not necessary
 when PageHWPoison
In-Reply-To: <20200119131408.23247-5-richardw.yang@linux.intel.com>
Message-ID: <alpine.DEB.2.21.2001191407360.43388@chino.kir.corp.google.com>
References: <20200119131408.23247-1-richardw.yang@linux.intel.com> <20200119131408.23247-5-richardw.yang@linux.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020, Wei Yang wrote:

> Since function returns directly, bad_[reason|flags] is not used any
> where.
> 
> This is a following cleanup for commit e570f56cccd21 ("mm:
> check_new_page_bad() directly returns in __PG_HWPOISON case")
> 
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>

Acked-by: David Rientjes <rientjes@google.com>
