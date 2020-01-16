Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07D0C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C91DF208C3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="T/c/Nc6b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392256AbgAPSdB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:33:01 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42717 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403840AbgAPRYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:24:54 -0500
Received: by mail-qt1-f196.google.com with SMTP id j5so19467835qtq.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPrmqLJiP71VA0NeSCTEgrXiIHb5kLqqrkQ2JxiPGho=;
        b=T/c/Nc6bCUmuGGYnx1mXNg/wgMTrK3EvK5NFy5avi9BI9aT7kuWce6IxNfrkIpAWW0
         iR3P24nqtNcVGBXiyJ7MI5JseF7tB3k1jcbrdsGZUMVibmkTIybMqOZWo6qQ753qpTYO
         c5ZGa85I+xjZMTgsSS6UjvhAsHpENoK10hL1sSkGFhJUwfcA6VBwxyoe/uAxOPPOKJkf
         8vQW2xc4GCrqjGKMcMFDphepzX+SXVRJUpH8V6vMXJx8rF7kAgHgyz+wyV3KLFbILyYu
         20Y+pBa88uStAUTQLjOTMRgIBIB3dXfcwBZS0tWfKMEzcJamwSP7Xt/HQSCa3rF3oIJw
         H6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPrmqLJiP71VA0NeSCTEgrXiIHb5kLqqrkQ2JxiPGho=;
        b=nWlgXFmA5ko7vtvBqAgT3Nul0GIunjGNbCsmg2Vhq+rQEsWRajFtwBwBuKueYChMr5
         owzQaY9XkwEce8/MHvAy6+ZVxR8l3u9mXoIvKzIYPBe7Shj6LGw8kHXgXau9ur1hxeM6
         GnQRlEhmkFyimYaLFVYsByeRQh636x+aFarLKsXPOV3KompePjLP3ex6fmSskbqUtrHr
         5KDCQ0Z/q7l6ah8qOPh3cc+dRLstOFXR9Uk1w6otb4Ff3uzDXaNrd5XpephpPeUus00I
         Z7xvINMneVi8bZ8GLI9lVRqdmf2zrNRVRvY+mn5Cg0/NEmRxK2/Ey7XFcbrkfPgsKqCA
         FoNQ==
X-Gm-Message-State: APjAAAXftsSQ7h4o8eoBDQU+zKtwb4OCPSZaZYgUl/prfPhLae1atWt/
        rqm5Z8GJ/UAE+yCwACcN01EDsg==
X-Google-Smtp-Source: APXvYqxxqV46E3xnhe2R/O4tw7/YVw+xjh9fYHOBoymWRu1GkQeW5Hkm+Nfw9QCWg2PhbIGK3pBGbg==
X-Received: by 2002:aed:24ec:: with SMTP id u41mr3553692qtc.220.1579195493467;
        Thu, 16 Jan 2020 09:24:53 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id g18sm10401144qki.13.2020.01.16.09.24.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:24:52 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:24:51 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 4/6] mm: kmem: switch to nr_pages in
 (__)memcg_kmem_charge_memcg()
Message-ID: <20200116172451.GD57074@cmpxchg.org>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109202659.752357-5-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:26:57PM -0800, Roman Gushchin wrote:
> These functions are charging the given number of kernel pages to the
> given memory cgroup. The number doesn't have to be a power of two.
> Let's make them to take the unsigned int nr_pages as an argument
> instead of the page order.
> 
> It makes them look consistent with the corresponding uncharge
> functions and functions like: mem_cgroup_charge_skmem(memcg, nr_pages).
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
