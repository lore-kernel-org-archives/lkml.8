Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BC7C2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:31:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA7562078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585729910;
	bh=SosAPIgty62arZjGRGAxn9l2VAMh2Nt8knVNSWRc2Ro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BfS0yOL4MCNJqTydEd8oRMhhSwylbnjunXdaElNPsxG6IkPGvVGzLKGr5H7jj1f7a
	 gBF3E0E4qspoAysVy46Wz4Vmutu4BFmgVCV1sw33YeeFXx05lTNGg3zB+7EzBCS7jP
	 6QURGUVHx2tgN4svMKHRTIhziareDDyWD1oA7NmE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbgDAIbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:31:49 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40352 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgDAIbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:31:48 -0400
Received: by mail-wm1-f67.google.com with SMTP id a81so6129251wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WVdUIRS1ycLvk6rcBuIPpHGovPPX241fTsOlQTbUJ+g=;
        b=FYF+3GGFE9+703iuOEHH4UJTPws9kugHBbHMtw5M7AKyr0eoYbU8QvuklSpHn0LEha
         TGOSLeFRRuGu/ftxViX7Phv29V1YZhkHtmR7y0Gf6uYxhe5nxQTuhV/c8OUpNZMpv/eW
         nnHA2onQecsqdfhkQelr/nAAu2xpkKWRzwJE+fZzhmUgdU2SgFS8azLeGZJzjMiHNVxJ
         xni+Hnh4KAQDPxSgf0dEY1VhTJsMUMEIjCP1HjtZu38ryyNigen51GAYJn3tnMhM1Tu7
         Z5MLiEeGmAEkWc9BcAJSmQJQ3sIxp7Xn9Vp9pMzriXFAB9Ct3Epj2uAbQ2ldffwZCCd3
         FLzw==
X-Gm-Message-State: AGi0PuawOfeYdvVgN0M5SaLehtr/rgY4focameafy320zKfNX6JNFqBX
        g+irwI0dBVfW8UqLrSntTew=
X-Google-Smtp-Source: APiQypLCzLi28uZ9bahmO7Z3PVZGhnTzNbaVcCbmHy+m/fBgPgeXw3iorTSbzaO9gBIS13y1kYck6w==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr3097856wmi.55.1585729907100;
        Wed, 01 Apr 2020 01:31:47 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id j188sm1722851wmj.36.2020.04.01.01.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 01:31:46 -0700 (PDT)
Date:   Wed, 1 Apr 2020 10:31:45 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Rik van Riel <riel@surriel.com>
Subject: Re: [PATCH] mm, trivial: Simplify swap related code in
 try_to_unmap_one()
Message-ID: <20200401083145.GF22681@dhcp22.suse.cz>
References: <20200331084613.1258555-1-ying.huang@intel.com>
 <20200331094108.GF30449@dhcp22.suse.cz>
 <87tv24j9hq.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tv24j9hq.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-04-20 09:11:13, Huang, Ying wrote:
[...]
> Then what is the check !PageSwapBacked() && PageSwapCache() for?  To
> prevent someone to change the definition of PageSwapCache() in the
> future to break this?

Yes this is my understading. It is essentially an assert that enforces
the assumption about swap cache vs. swap backed being coupled.
-- 
Michal Hocko
SUSE Labs
