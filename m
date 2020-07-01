Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC677C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8988820760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 20:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m7ZV4ZqQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGAUDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 16:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbgGAUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 16:03:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B648EC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 13:03:04 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so4904523pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 13:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=h+1Zhw+IU5Q0TCwvXbDCPP03c9PbqFM6QbL3RKeglzg=;
        b=m7ZV4ZqQ8dOTQW70jelDPr+AgEtdHXqgtBl2IgnF8daantVBxjfVIMK1Gm8F0Li+oI
         BxefPgOgTQmCaBj+1lln0RS9uWIH5LCJU7gk7KR2SdjqjdbouPMoV38yKEEhDWStJCD8
         txk92EdtNZ31+swmcPZgxROjzV0toLSKWPt0Z/IGgj4fpbAspLLAgqqPeWx8ImLB6gjk
         b1WYj9qFzqvEkIMskziaG0QSnhRU49ZDaS7Z4Wfeo1H0npKeSez+MuLu9oZKekqHYcZd
         YUx9TrsSVGTjQYoH8C3lkeRO8GgtA6g+VV4oT4g19iMBZe6OPhKArE84hfJRK8QWZfp2
         Fc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=h+1Zhw+IU5Q0TCwvXbDCPP03c9PbqFM6QbL3RKeglzg=;
        b=qZL3L0QAdqvAa/t3oMxIMggHxiILzZ87OXrF2BJSE6XAAAG5wtV6R/JxkktdWZ7PWq
         MTVXR28DI9jTpxkSU9z7qAOKmspOjRnGBGyOFmDAcvHKpqvB0wAjcPRswIGY4M02o5dF
         Ziq+6lqpLEJLs/u2u/ZuuCl+BHOg80O1f5/wvP7rVirjhDWQsiwTNfEhjwQl5nr2plXK
         mIIHABw3+8c6aoIrD1zFJ4DIFUxGPrVHM+MPvZURTBlHJyv+oUlR0PWuVw1d2WyRdQdZ
         KOGvhEoiGePzxku0M8XnkOn0YTde5StGEKCOZJWgo8mOXwvwG30BypYMP3Ic5olPX2bF
         ZeMQ==
X-Gm-Message-State: AOAM530ux0PyhEyK4Z0cfd9PuWSxVEcx0i1Hoq/H2SflqAu51zMww6L2
        ZBCWPNUIemXg5RMMmpiGQ9Az/XCfHPY=
X-Google-Smtp-Source: ABdhPJwjsX59K7TNEodj6s9VSLwhn8IML/5qqPGnMeNAlqTTpcG08YE/nNMw432H+LegU0Apgf7xPQ==
X-Received: by 2002:a17:902:d20c:: with SMTP id t12mr23683155ply.291.1593633783951;
        Wed, 01 Jul 2020 13:03:03 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id oc6sm6464478pjb.43.2020.07.01.13.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 13:03:02 -0700 (PDT)
Date:   Wed, 1 Jul 2020 13:03:01 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Dave Hansen <dave.hansen@linux.intel.com>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        ben.widawsky@intel.com, alex.shi@linux.alibaba.com,
        dwagner@suse.de, tobin@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [PATCH 3/3] mm/vmscan: replace implicit RECLAIM_ZONE checks with
 explicit checks
In-Reply-To: <20200701152627.8761147E@viggo.jf.intel.com>
Message-ID: <alpine.DEB.2.23.453.2007011256280.1908531@chino.kir.corp.google.com>
References: <20200701152621.D520E62B@viggo.jf.intel.com> <20200701152627.8761147E@viggo.jf.intel.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jul 2020, Dave Hansen wrote:

> diff -puN include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper include/linux/swap.h
> --- a/include/linux/swap.h~mm-vmscan-node_reclaim_mode_helper	2020-07-01 08:22:13.650955330 -0700
> +++ b/include/linux/swap.h	2020-07-01 08:22:13.659955330 -0700
> @@ -12,6 +12,7 @@
>  #include <linux/fs.h>
>  #include <linux/atomic.h>
>  #include <linux/page-flags.h>
> +#include <uapi/linux/mempolicy.h>
>  #include <asm/page.h>
>  
>  struct notifier_block;
> @@ -374,6 +375,12 @@ extern int sysctl_min_slab_ratio;
>  #define node_reclaim_mode 0
>  #endif
>  
> +static inline bool node_reclaim_enabled(void)
> +{
> +	/* Is any node_reclaim_mode bit set? */
> +	return node_reclaim_mode & (RECLAIM_ZONE|RECLAIM_WRITE|RECLAIM_UNMAP);
> +}
> +
>  extern void check_move_unevictable_pages(struct pagevec *pvec);
>  
>  extern int kswapd_run(int nid);

If a user writes a bit that isn't a RECLAIM_* bit to vm.zone_reclaim_mode 
today, it acts as though RECLAIM_ZONE is enabled: we try to reclaim in 
zonelist order before falling back to the next zone in the page allocator.  
The sysctl doesn't enforce any max value :/  I dont know if there is any 
such user, but this would break them if there is.

Should this simply be return !!node_reclaim_mode?
