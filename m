Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D95DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0166F20825
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ZskJd2rQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgEUMYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgEUMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:24:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A82C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:24:45 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id j21so8604455ejy.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 05:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i8JutcblGoAISDN3hurAlHLL13/lujc4PGXCcoNOdiE=;
        b=ZskJd2rQupY8tV+of+gT2pNGrghG1kvcp0tUt8lYVHWX2N2357xtDLydnxma2icUrj
         b0RUe9qLlaHWLEn5ePS8DecHifXObN+IFUNHUwWuvKcDjwbkP7AMXFLIg+NakaL4dG4H
         XE7j3wic9ZZzBWOrSIpnnr08PFqEOA4rd/aeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8JutcblGoAISDN3hurAlHLL13/lujc4PGXCcoNOdiE=;
        b=KAIHpHs+AsvoKTFnh/yzomtRCtR0fTPI+bPFAz756GR6Li+dP3fRqoYgbyCpdIwfb8
         bwvK/eJSdrpfQDmS/Xt0a8jsV5nptXzSay+zQtNKxVrUSmoIq1/2ZYnKRc8aS5lO2fcv
         hphcNyazx7ANPKf6XFi5YGs/DIOEwMQZKtKaMdm5JJfu76DKd6zEl0SdATTOhkc5T5YX
         QoJqT0DI/9BJvOJrRsmDsFNvDO8//fakVaR5n12d/d+6k9CR01qDp/GN3nbJAP2gC2u7
         eXAHK1hXeuROuUtxUVt2Rg5z5FzSnA7bYefb4Pj2D8jhYkKse+frAjYWAEIzCvlxWrHd
         Ugcw==
X-Gm-Message-State: AOAM530uRPx7eFXIjAeJEcLFlUwqPulUPP1kAIy94Em2/Gs1enJp8JWp
        gLC1BpN4bdxXPA0Cd9c1bFRwxA9KYcfgPW0Y
X-Google-Smtp-Source: ABdhPJz9jOOFoXAERCPYL+3i/XvpdtIhar1Xat8M0XTI6E609A9G6xutGG1kGY9fXEK4RxSZ9o8ukg==
X-Received: by 2002:a17:906:3b8d:: with SMTP id u13mr3240093ejf.256.1590063884112;
        Thu, 21 May 2020 05:24:44 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id qn17sm4672101ejb.125.2020.05.21.05.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:24:43 -0700 (PDT)
Date:   Thu, 21 May 2020 13:24:38 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521122438.GC990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520202650.GB558281@chrisdown.name>
 <20200521071929.GH6462@dhcp22.suse.cz>
 <20200521112711.GA990580@chrisdown.name>
 <20200521120455.GM6462@dhcp22.suse.cz>
 <20200521122327.GB990580@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521122327.GB990580@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Down writes:
>A cgroup is a unit and breaking it down into "reclaim fairness" for 
>individual tasks like this seems suspect to me. For example, if one 
>task in a cgroup is leaking unreclaimable memory like crazy, everyone 
>in that cgroup is going to be penalised by allocator throttling as a 
>result, even if they aren't "responsible" for that reclaim.

s/for that reclaim/for that overage/
