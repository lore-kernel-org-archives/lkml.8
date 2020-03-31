Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FC2C2D0F1
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E49AD20848
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 17:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="pZsnQlx7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgCaRES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 13:04:18 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33042 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCaRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 13:04:18 -0400
Received: by mail-wr1-f66.google.com with SMTP id a25so27025913wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 10:04:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3MfpJb9zskhXycF6Q+P3UTVTg3zrJvxkcEUgjbQFmfg=;
        b=pZsnQlx7/55ukASiC3RMQ5r/VpGpt2sx3fZv4j1t5eR0lL10S2G4wpBjHN2OsIgtCn
         KDGVXMzzasVXuh0uhzi5yOdpNZ+vUfAIwB7wIP+I1kFSUB+EG32TYMcVi5PRnLZKPf4c
         0M7AXZdWVpu+HwUc1q3BzVJz1NqBP6gcWGb00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3MfpJb9zskhXycF6Q+P3UTVTg3zrJvxkcEUgjbQFmfg=;
        b=sJSARRuo75aDA9fgGmLv9I4lRAa4jcdotGaKHReqFqrxHLV794VxZXE6yIq65VY0/1
         6EU/fKSinEzDf5+wEDHE9RK1Q4gtj3wpQJ4r1vm9Voq6dcxFJvaW3SbWiU8LJL5HiECa
         XMdsL+MLi5z7y23uHZuOcVU+5d5Uh+TM44g+pEkNmRQTL7u/pD774+KFT5UtsotnZprC
         HX8ZDKoqiRil9ATKWBLJMXnxjjaVxYgb5bho0Uyn5ZFfhdc1klTHU4COXRWo+x/fiAgz
         Vik8tMa4vT9chRT7v2rCclNuqk8rkCazl8Q85775HcJ1l5op5e81ceF3SVzsrM04/Ta/
         IDiQ==
X-Gm-Message-State: ANhLgQ3huNNmNskzJn7fiHM36WdYa3LDM0y+wUF/zmxc/W1KvqEmMWpw
        SJ3MZVnRyv3qFwukOYrtST5KmDCTYq4FPQ==
X-Google-Smtp-Source: ADFU+vsyRM3LsPUxIXkBsY97QN1fJN2ENc2TMRygohrVkAY6lDjYhTsc8BzhHSDzgxzhXYr4e9HAFA==
X-Received: by 2002:adf:916f:: with SMTP id j102mr20527218wrj.335.1585674256639;
        Tue, 31 Mar 2020 10:04:16 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:27bd])
        by smtp.gmail.com with ESMTPSA id r9sm4700820wma.47.2020.03.31.10.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 10:04:16 -0700 (PDT)
Date:   Tue, 31 Mar 2020 18:04:10 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200331170410.GB972283@chrisdown.name>
References: <20200331152424.GA1019937@chrisdown.name>
 <20200331155752.GN30449@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200331155752.GN30449@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>I find this paragraph rather confusing. This is essentially an unsigned
>underflow when any of the memcg up the hierarchy is below the high
>limit, right?  There doesn't really seem anything complex in such a
>hierarchy.

The conditions to trigger the bug itself are easy, but having it obviously 
visible in tests requires a moderately complex hierarchy, since in the basic 
case ancestor_usage is "similar enough" to the test leaf cgroup's usage.
