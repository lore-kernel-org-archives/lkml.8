Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA54BC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9338206F9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ohUd4Clm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393079AbgDOEjS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388614AbgDOEjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:39:14 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65698C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:39:14 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id f13so12133170qti.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=T0ov2Qm19NGfhDx7kb+Qpp+SBwZz53FIlhxAVVfKxI4=;
        b=ohUd4ClmbLBtja20CTalUO+WoLl1ve/CYr2CKbobL6GFJjNAc/LB440d9rYAIaczm+
         Kh1RiX35n8e3voiqIitcaGFBnH91SfJlcl57iEyZB4hlEhvesoMX2eOXRdntSRzr+hkH
         dOgBVJDAi3bFtryful1Kxe6qHJjkhz8LI+/jrG88Tceh+0BEVEYbpFpYF0ghcHG85Bds
         xGbea9oZ/UqbxOf2r/VOb2z4UXNriOnt8vLpgXJTQ3e/vG7ky2SV4TLQSwKYnh7deLwR
         oAwhiU7x7YTEH6UiJ6nFbWPhGeJ7/i28lQNYphRYEI0IgJ7Lpo8+wtqijJbG7rp5t8sG
         Io+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T0ov2Qm19NGfhDx7kb+Qpp+SBwZz53FIlhxAVVfKxI4=;
        b=oKFYgYVL2LVQ1g7GuHwiDbkepz0EQmKwbnr0nlwVdOUa86azxYy0U9xaT7HCOjdIS/
         N2y4nZWLcKbmDJxZDkLwzFefJTePR3j8sJCZzpvze8Gf2CHWUzHw7xtboAUrWKpduVfh
         klw4fo2RH7mRv8kcwgZ98hXhGJdfaWuhb6Cp+XKAbCOLMbjM2aXHlX6xHIM9jJp4gUF/
         5EXFDias8Z0SFdwsMvcAPpdchVpSdP+mz38N946sG6NehJlPsi6sQ/kRaDt8dkfwSafB
         phuT7522tVtk05bLrWnMRh//VFd9Ny2N3UgTrkQXK3BzAPZy7+8MvJEJqihvouGlMwD8
         hr5Q==
X-Gm-Message-State: AGi0PuaanJ5ti4raC0sZbIa7EFdLfkDL7M0JV09+JUluqu2pHVariMXa
        T/h3ggglkxVb6G2U6vNBAiWguw==
X-Google-Smtp-Source: APiQypIM5GoBSgbWbxjSMNs5ZNvz31Ab4J1vE8UwPpZfVZ7JsFAzFEaxoKJVsfy/rFJmxjNa4l9+dw==
X-Received: by 2002:ac8:543:: with SMTP id c3mr18876077qth.8.1586925553554;
        Tue, 14 Apr 2020 21:39:13 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::e623])
        by smtp.gmail.com with ESMTPSA id i56sm5581998qte.6.2020.04.14.21.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:39:12 -0700 (PDT)
Date:   Wed, 15 Apr 2020 00:39:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: Do not high throttle allocators based on
 wraparound
Message-ID: <20200415043911.GA147015@cmpxchg.org>
References: <20200331152424.GA1019937@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331152424.GA1019937@chrisdown.name>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:24:24PM +0100, Chris Down wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> 
> If a cgroup violates its memory.high constraints, we may end
> up unduly penalising it. For example, for the following hierarchy:
> 
> A:   max high, 20 usage
> A/B: 9 high, 10 usage
> A/C: max high, 10 usage
> 
> We would end up doing the following calculation below when calculating
> high delay for A/B:
> 
> A/B: 10 - 9 = 1...
> A:   20 - PAGE_COUNTER_MAX = 21, so set max_overage to 21.
> 
> This gets worse with higher disparities in usage in the parent.
> 
> I have no idea how this disappeared from the final version of the patch,
> but it is certainly Not Good(tm). This wasn't obvious in testing
> because, for a simple cgroup hierarchy with only one child, the result
> is usually roughly the same. It's only in more complex hierarchies that
> things go really awry (although still, the effects are limited to a
> maximum of 2 seconds in schedule_timeout_killable at a maximum).
> 
> [chris@chrisdown.name: changelog]
> 
> Fixes: e26733e0d0ec ("mm, memcg: throttle allocators based on ancestral memory.high")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org # 5.4.x

Oops.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
