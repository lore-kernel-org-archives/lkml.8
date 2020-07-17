Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93866C433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F7A322B49
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 14:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qxLVFWXS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgGQOGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 10:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727932AbgGQOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 10:06:42 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19DAC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:06:42 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id u12so7629640qth.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 07:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n79cHK14c7WjGW54arM/ZzG9LDrpbEmQtp+ZnZq2Zbs=;
        b=qxLVFWXSBzVOgf0tOJdWkvaseXUBniTV5HupaHUiI4U2q4+aKRnmX/dWQymX2rzAta
         nmX64UvqolTMSaA6zGeFgV62hyOFfo+CUdQH907lPcyzIfdf4W/6vSzpjr8KMiYL12A8
         0XIkhTLOFVpsLJlzvXMV8fFPmDcgKCPmOo1+z6QpFOw871JW6iZxC2Z/l6zrFDLf4SYx
         wUr6ze4nrOSNMemZ+zk+W4LXhsmVkSb/D7dg7nxa1kJXm/dRWzdT7zlKJ7Jr88xgw66R
         uV/BW3GSzlEydiJagiv4eWwsaaMnW2OaFNdIq9YE7cVOG6yHtiZgFOqFDJmb6likQmW5
         445A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n79cHK14c7WjGW54arM/ZzG9LDrpbEmQtp+ZnZq2Zbs=;
        b=rky/W6GbbCEpPpdy63Wq9w1vyr1dp5+/+rUJp1CjGEjwfJe9Ogu0dnz+h7IllGMIQ4
         nWZOB4RYj0a6rhncWMSou7nv7Qtc1KEhCkCHVMW6DqfcGS/J1D7F9P+Q6rrZ/8M16c1p
         fydf7wz/pb6q9Xw0FmN8xt9MbAUJOaVp8lmqCa7QjSqxYUlsae6FOkIbA1iLxyXus+58
         wP/YtpuQq5Uhe3lm+pLH0YYoMDJHOpjZJGcTjm1ZLia7jZpm8aLEGo8tQdZRu1iv6CaV
         tOsPReW7AOD3P61JGDPyq4Bn/O0WbkpganhKnxn2TtxsiGScUEgzJbtcjIWENpIWkj/t
         LtJg==
X-Gm-Message-State: AOAM533Jey8Qg2o+vwF36fvBqYMdWK/9b9Y6EjjGSX2sMbPQVL0bnoKq
        2XZU3Lgn7fQxXNtuC2GTw3HolQ==
X-Google-Smtp-Source: ABdhPJx3MCZgwWOSpwWP7h0UDqwBEhWJ0YHnBmdUpDipf7AvrZ/96DipyQUxQJD1KzzlUfi8TGV0hw==
X-Received: by 2002:aed:2e07:: with SMTP id j7mr10972924qtd.338.1594994801450;
        Fri, 17 Jul 2020 07:06:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:be7d])
        by smtp.gmail.com with ESMTPSA id 15sm9849064qkm.93.2020.07.17.07.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 07:06:40 -0700 (PDT)
Date:   Fri, 17 Jul 2020 10:05:47 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v6 5/6] mm/swap: implement workingset detection for
 anonymous LRU
Message-ID: <20200717140547.GB265107@cmpxchg.org>
References: <1592371583-30672-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592371583-30672-6-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592371583-30672-6-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 02:26:22PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> This patch implements workingset detection for anonymous LRU.
> All the infrastructure is implemented by the previous patches so this patch
> just activates the workingset detection by installing/retrieving
> the shadow entry.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
