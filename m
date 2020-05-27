Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEFD6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C115A20890
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="RlxA8nhx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgE0TmS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgE0TmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:42:15 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889B5C05BD1E
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:42:15 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id c12so10389615qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y/I/vYOeWDaLgdvChn7OrIXfp4eLue4GU8kN/nhBY2M=;
        b=RlxA8nhxtnbe+M7ZmnAYSboT5jXDfDT3lRgHDb3QDO3TptnDvqzSH740c9GLdH/Y93
         omLhViyqr9nb//4nmPJ4HJcm8/TnvQaL5CGLPvU4kkejJwSNUnm7Nz5t4S8CkrnHBIaA
         +mWFD2PvRFwBkBvzsfrPIZWinsBvUkoMK5XF5BTr/bTLDk/PpGSjMiqrg5FyKiTCq28j
         y3B1plMcOn7oSf1nhOTOzvoUBAgp11763/xU8eouz+Q6vV9EGtUYjyc32wepuZPMd8al
         RWnsMFh8khsCbK8upqC1wfzet39Ti0hyVtDbH6wH+XPHilIv/Cfrn1EH+VwpxKfcsH9O
         /ODw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y/I/vYOeWDaLgdvChn7OrIXfp4eLue4GU8kN/nhBY2M=;
        b=tpPhfDBaHVvf8u9NohSUEXX6Lysa5LwjRaQQ2+VokXe1nabkpzZx+oD1hdSrGPnnOu
         hZ5f6CuJ+RNXZwMlCNSeFzKmfwe/S7cRb1Xm8YbUSjSjI0WXSowDU3aBNRHBgUQyZ7PT
         xVyDhIMhxhPl4rV0+5RefARbuFLHLSXB+CHbRdMOniUmvPqUgxdSCXAc61ZyEQsP5LQg
         c7yYUdtCVK3otaSQsIKdid2XDSYJjiPCZbukxm2LFSEwpS6oK5Suz4fWlwMbiQwqAw98
         Fu7ttA+t5QIYnCl/FLyjlbDCbuUNP/OEPvctv3w8Ra3SM5XEX2OwGZ2r158wxbuRFJKM
         HjNg==
X-Gm-Message-State: AOAM532SPw/ejkoUaoWq0oO9ftTm4Od4MHNlTdaidHPjqZLn3kT0E5B6
        +WaXhguL68H/lvtdkjSp1TwGyg==
X-Google-Smtp-Source: ABdhPJwkT/j72pG3A4CaMBtW17UHMziTMfasgq+/mkgPkKOHVgWgZr8k8tkH6Zt7dSQl+w/lh/x4+A==
X-Received: by 2002:aed:3b56:: with SMTP id q22mr5925119qte.345.1590608534781;
        Wed, 27 May 2020 12:42:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2535])
        by smtp.gmail.com with ESMTPSA id m10sm3236312qtg.94.2020.05.27.12.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:42:13 -0700 (PDT)
Date:   Wed, 27 May 2020 15:41:48 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 3/3] mm: fix LRU balancing effect of new
 transparent huge pages
Message-ID: <20200527194148.GA47905@cmpxchg.org>
References: <20200527182958.252402-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527182958.252402-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 11:29:58AM -0700, Shakeel Butt wrote:
> From: Johannes Weiner <hannes@cmpxchg.org>
> 
> Currently, THP are counted as single pages until they are split right
> before being swapped out. However, at that point the VM is already in
> the middle of reclaim, and adjusting the LRU balance then is useless.
> 
> Always account THP by the number of basepages, and remove the fixup
> from the splitting path.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

This is now already in mm as part of the "mm: balance LRU lists based
on relative thrashing" series that I sent out last week and where it
was originally from.
