Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD82C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C037920735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="ZcZyAY3W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgCWQuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:50:05 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40234 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWQuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:50:04 -0400
Received: by mail-qk1-f193.google.com with SMTP id l25so11104613qki.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DAmo83OU6Z9FY3EAp1eIchXxAfwetYnQdz8RvRwBuLE=;
        b=ZcZyAY3Wd1okpJtclZ7/IBkX8wfbqKUNN5lO1oFhQNxyLZ1FZsPVoKOeBj/ZuiMW80
         4jLbw4Rh6Xn56iu+4PnTK7aYWQJhH9qrOEN7YukpCw7h9Xzm7X78NSxn2wc+gybfdhrd
         MpbcwW4y9psWgwKT2m9gUau5GEfxyzMbv2/H94x8pttsANppUemk62gfr/LEPNvWZ0uC
         66DRMIIGGYQNJWeM31j9rwS5A6NxmIjoBGTv4i1PfbEbV3lLWFhHgI9ZgwVJvaHE4VUT
         ltDS7BPoEw1CtiidbjM0Emm1Bg2qJioiKVsI74SOl37DJxnwyDyaHNFWFHW3WIcZ1Fzn
         UvFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DAmo83OU6Z9FY3EAp1eIchXxAfwetYnQdz8RvRwBuLE=;
        b=iJD9gSEz0xXhIIYlPcz27/ECUy5g0GHh98XprDmQUjq9A8xkZzt0uNNGtnPjXepMO+
         Es14f2uot5tjKCGQRMDZrbEnoul6aXo/G9R5fqeo/Wwy06C7Ol4c21YFtLwmV4/r43Jp
         4xyQWxYWMuADCEjLfRKeZHr6LxTZgmppkY2Fqe8nx/KYS7FZAevzU4P7x9YGWaJ4MuUr
         PyYMt0UxNHyRMJkpQHSrO8TffuO5jyeZAnNS6i9ymEuB7AHmqe7EYzW2sj9YKWsNb9Ka
         WBaNGSqpVe0/3Z82GSRvEd0RRHF6+c/rh2wLV5EetpmqcdXk8Nz55sAnrhg/Mx+RbXXs
         Ix3Q==
X-Gm-Message-State: ANhLgQ1VDdxVQhQuPChvgPipKL3vqRrIE0vSiUyoUa6OnKbJf1tayDAG
        ZJBv9HIB6N3XR8ieql1suXeQQg==
X-Google-Smtp-Source: ADFU+vunnDaxvXSc+qWcDivkYalaGTqTcWCY6d7czPBN8l0n8CQRm4WMoMRQwRLqQtEBHK26LLPJWA==
X-Received: by 2002:a37:a297:: with SMTP id l145mr20930518qke.322.1584982203273;
        Mon, 23 Mar 2020 09:50:03 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id p17sm3561970qkk.18.2020.03.23.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:50:02 -0700 (PDT)
Date:   Mon, 23 Mar 2020 12:50:01 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     js1304@gmail.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>, kernel-team@lge.com,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH v4 4/8] mm/swapcache: support to handle the exceptional
 entries in swapcache
Message-ID: <20200323165001.GB204561@cmpxchg.org>
References: <1584942732-2184-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1584942732-2184-5-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584942732-2184-5-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 02:52:08PM +0900, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> Swapcache doesn't handle the exceptional entries since there is no case
> using it. In the following patch, workingset detection for anonymous
> page will be implemented and it stores the shadow entries as exceptional
> entries into the swapcache. So, we need to handle the exceptional entries
> and this patch implements it.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
