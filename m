Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E01F3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:07:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90F8207DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:07:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="mrT4+Uij"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGIQHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgGIQHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:07:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB98BC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 09:07:51 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 9so3010495ljv.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 09:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5NDVNZtnnxjHdL2IznMhqyyOaM1UEpBRYfaH8/wnyRA=;
        b=mrT4+UijHeMtAjfWDqqY584BReFIKqdUGRL55LAuh/wgkJjAMTTfUV68ACSvuJRFdh
         DQGSmM0SQWbj99NdyhvkMwvFU7pUt3HMuk4Fk4HmdQk+PpxOyWLIQGiwMZSzPgzDS0Ny
         g1BLBl2A6cB7SIlq17kDmdR0xR/GAT4Gw0DjtW3LEjsqqWV5NGg/W1HiiKWVEr8XUWSs
         Wt/3Q8Nia+nRo/GmBK9Vqu7JzMDjlce+aF8L/pcUpyMbWm3ZNjusdgADGs6Ts2xbZTeN
         3hkbBJiLmTpl17KO7+GFcuIJhJxF6N5LMlpuDyh5pWRodiBSuQql6h/P/+XwVn8rq5B2
         sA9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5NDVNZtnnxjHdL2IznMhqyyOaM1UEpBRYfaH8/wnyRA=;
        b=mOpXa18Fa01xxrKd2b+z5akQOXFsYXntg6XGPm/YBD+pjFV2tYDZESYu3NYezAjEpH
         q9Tb7bpPaNNhvJQO5rmqocNe3M7LikgZ2zuLwe/Hqfu9MqTuyErSgUGSKcTFRCuXvdul
         ILhKGT0+IfprvR5N7NkEPQqYn+Z4hrLJS2QFsChGbkowMHTQ2Q0HW4TSDoSa6nABH1pB
         UdhHqGKo7p/4h5vC7SeqKxGwmU8Vq2GV0Xkjunjz/JnUiJAI3seFPBEzxxNM1WP7ishv
         rpcGQhCcQ+E62HJDg1NUgnfFWEB8wgLVJneiq1zeRyAukmO7ni4JOC+7j7wpUboYPHQ/
         Jo8w==
X-Gm-Message-State: AOAM531PghqJYtXXZw3cJv1AsB51WoD2s1ohWDYVlU20iahohECHku8Q
        DzCb92Eo+QHXgNsf4kAupTKCBQ==
X-Google-Smtp-Source: ABdhPJyNqFCflNKSSRWKotYhcWShpJYaIkEFcLWrAqbJRcRQMrVhEr9U9utz7KkSedxkzEMyWD8A0A==
X-Received: by 2002:a2e:9006:: with SMTP id h6mr26401383ljg.148.1594310870147;
        Thu, 09 Jul 2020 09:07:50 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id o1sm1070797lfi.92.2020.07.09.09.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 09:07:49 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id EA65610222B; Thu,  9 Jul 2020 19:07:50 +0300 (+03)
Date:   Thu, 9 Jul 2020 19:07:50 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: a question of split_huge_page
Message-ID: <20200709160750.utl46xvavceuvnom@box>
References: <df2597f6-af21-5547-d39c-94c02ad17adb@linux.alibaba.com>
 <20200709155002.GF12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709155002.GF12769@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 04:50:02PM +0100, Matthew Wilcox wrote:
> On Thu, Jul 09, 2020 at 11:11:11PM +0800, Alex Shi wrote:
> > Hi Kirill & Matthew,
> > 
> > In the func call chain, from split_huge_page() to lru_add_page_tail(),
> > Seems tail pages are added to lru list at line 963, but in this scenario
> > the head page has no lru bit and isn't set the bit later. Why we do this?
> > or do I miss sth?
> 
> I don't understand how we get to split_huge_page() with a page that's
> not on an LRU list.  Both anonymous and page cache pages should be on
> an LRU list.  What am I missing?

Right, and it's never got removed from LRU during the split. The tail
pages have to be added to LRU because they now separate from the tail
page.

-- 
 Kirill A. Shutemov
