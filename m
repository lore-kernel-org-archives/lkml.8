Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69DC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:01:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD52D207DE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 01:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d9oof434"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHUBBi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 21:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbgHUBBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 21:01:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB82C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 18:01:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w9so216041qts.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OxdQmW2oX9NgI5mQQ7VEZQKRJIIZoe0SIp1V2OIQN94=;
        b=d9oof434BR4dRx1VQjJfCxUgsEJ1qEfPbSQxwzU/G4IyTUT8CxMoV5e9BNjUHDCDZj
         bxNfaDBcC3LAWPmyLuj1dDR4fpvTsHmkIIYW48cC7saYyAjyjLkkk+L+nTs5tFtcHWM4
         Y+AjNeUtJUA9GdZyCMYWEmc71khedRSOrGhorLE1GGncgMydqmeclzKykoXteG1cL2ot
         Pz7l92hDeWnzPRrGwCDbuccMbJHyiMkdOZYBunp8ax6FuZAVU0UIAD3uklzpPlH3FtwH
         +ykRnpHN0KBNDKqEyYOwnZl9bgzQD3BW/WhMzaucnfsecPjUL33fjpxqGgcHTqysjVM4
         plAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OxdQmW2oX9NgI5mQQ7VEZQKRJIIZoe0SIp1V2OIQN94=;
        b=hL1IBW1u+yd/9w5y5PtUFIo6G363UG6U922Xgs3mAtMNuwJ/WfmQzwNlaz5/WjLGFG
         WGLIibnbDFSNU0471eK/ru9lDnGuwPkIPmSGXsKydCN3893cJ4YPJ5qnfIsxQk3OjWEg
         hQUCLpVNW1yy7U8zbvfkwDHYux3YpzXBwxENh9eOVtoHJDN/oo9PQPBvQ3qRd37OxTSq
         kRPJYxla5INTgDiecG8qE8dWXDpaDCyRWiEkjW8Qv/bU68g1u/UVuWfNgx65d31TM/U+
         RP5gJJK5o6gMrf0ZSCpxZmtow4LlP1JyAsgY8W2ZySvmxNqN75b9WhFeuRpRICijJLdc
         1hHw==
X-Gm-Message-State: AOAM532tYW8jXQCiJ5ljA6hKIuYFEj41yF+lXgBTHzMVlVOGX/Hgmei+
        HR697bFwC1/heS5Rkw1oIZZyQQ==
X-Google-Smtp-Source: ABdhPJxWnqVox2CDbULIHZsYUdHlAUpcgCqK94Sn8VKlIOWKUYxc3cR1yDf68hoH4mK7EJQWgs9hnQ==
X-Received: by 2002:ac8:22ea:: with SMTP id g39mr558713qta.146.1597971696292;
        Thu, 20 Aug 2020 18:01:36 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d15sm199619qka.91.2020.08.20.18.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 18:01:35 -0700 (PDT)
Date:   Thu, 20 Aug 2020 21:01:33 -0400
From:   Qian Cai <cai@lca.pw>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [mm] c566586818:
 BUG:kernel_hang_in_early-boot_stage,last_printk:Probing_EDD(edd=off_to_disable)...ok
Message-ID: <20200821010132.GC4622@lca.pw>
References: <20200818002351.GC18179@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818002351.GC18179@shao2-debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 08:23:51AM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: c5665868183fec689dbab9fb8505188b2c4f0757 ("mm: kmemleak: use the memory pool for early allocations")

I might see one of those early boot failure before. In my case, the bare-metal
system was reset. Can you try to narrow down to a smaller
CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE (assume 0 works if your bisecting was
correct) that works?
