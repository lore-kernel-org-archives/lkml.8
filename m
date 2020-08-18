Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C0AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:18:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62AC6204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 10:18:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="s4u3GuRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgHRKSF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 06:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgHRKSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 06:18:01 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD49C061344
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 03:17:59 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c12so14704350qtn.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 03:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m1d0Rse+qIi8qOmerhrf+MBXKELTuAtcs3p/xFrqf9w=;
        b=s4u3GuRFjGb61CKAXSbV1lMqnOMke9WVYpJMh0BBQqdPfrVKbnnOMGI9JvyBbgPm6e
         x6rVvOlI1ANNxy8+m3bcc1IECDj2KsJGcWVy2WR+CvANx/bwNtWdEoEKDgNVzfp3pHop
         hA9rOJBnJ6hFK8QUbuzjs02965lEQZmkx0qyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m1d0Rse+qIi8qOmerhrf+MBXKELTuAtcs3p/xFrqf9w=;
        b=KTGFy6D82uX+g2fTylFViiVSyJg//aryWtOh8MfgfgcZrttG67K7PGNJiGKO4x5of+
         NDgtcdxJjupN5+Y9iBIVQM7fno5Sf0URUSIr69lz+faSe7l50CMQrWAT3ViKobRsua0m
         ykdjvJGlIBq+bea42Gt/Miq+MoQMqsmaJgzh1we5vboVHNv8w9eHlS8s9oXGyOceQXrh
         i/KG7YwG9zjrN+CGCBMjXehwoSnE1fRyiZlNqEj2vPst0ulWBA12VX8dqqTYYOFG6vra
         JEwt1wkfCuhfNiFZWpb3X3JiHdK8SXoPoAEXqE97twKZR2d95Q/s+tYTDyNiiVTKBe4u
         GXdw==
X-Gm-Message-State: AOAM533xTwbF8OC/22otVNtUlblqXIB0NAnSyzoGbYZydWemw8q2hmzo
        rc8ooOIBGHRgNCNjsC5pLsi0yA==
X-Google-Smtp-Source: ABdhPJwu2U26qaTDnNyVaIc78vhIlLEidrEGudHY3cyjqUjwF2jv5oW0015yCO0u1NOmZFEU8PeD0g==
X-Received: by 2002:ac8:65c2:: with SMTP id t2mr16990912qto.370.1597745878056;
        Tue, 18 Aug 2020 03:17:58 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:179c])
        by smtp.gmail.com with ESMTPSA id w1sm20614419qkj.90.2020.08.18.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 03:17:57 -0700 (PDT)
Date:   Tue, 18 Aug 2020 11:17:56 +0100
From:   Chris Down <chris@chrisdown.name>
To:     peterz@infradead.org
Cc:     Michal Hocko <mhocko@suse.com>, Waiman Long <longman@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC PATCH 0/8] memcg: Enable fine-grained per process memory
 control
Message-ID: <20200818101756.GA155582@chrisdown.name>
References: <20200817140831.30260-1-longman@redhat.com>
 <20200818091453.GL2674@hirez.programming.kicks-ass.net>
 <20200818092617.GN28270@dhcp22.suse.cz>
 <20200818095910.GM2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200818095910.GM2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

peterz@infradead.org writes:
>But then how can it run-away like Waiman suggested?

Probably because he's not running with that commit at all. We and others use 
this to prevent runaway allocation on a huge range of production and desktop 
use cases and it works just fine.

>/me goes look... and finds MEMCG_MAX_HIGH_DELAY_JIFFIES.
>
>That's a fail... :-(

I'd ask that you understand a bit more about the tradeoffs and intentions of 
the patch before rushing in to declare its failure, considering it works just 
fine :-)

Clamping the maximal time allows the application to take some action to 
remediate the situation, while still being slowed down significantly. 2 seconds 
per allocation batch is still absolutely plenty for any use case I've come 
across. If you have evidence it isn't, then present that instead of vague 
notions of "wrongness".
