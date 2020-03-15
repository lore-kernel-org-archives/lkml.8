Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594E8C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D0120578
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 08:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ay+2V4sH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgCOIS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 04:18:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55324 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727756AbgCOIS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 04:18:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id 6so14278607wmi.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 01:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bIdO2DD9SS58shQaI+L75kVmCFLCfvHKiwc1M49jAT0=;
        b=ay+2V4sH5dFVbqHqfzxJ9qOQZ2y3OLeLccxpD0pfwtd9I+pBtYkK0mvCKX8x10Hdbe
         H7euB4kz2RwOyD2+mNxIl9ZWMXaNnwzjlAB910zZColpVhTHkKA+md8TYVkiY0V3QsOg
         I7b7BnYV4i5nsvi+qbiWFczXjFJPutx0H3AB41/Ah/XFJ8yKzx+fHV5yR85t1sEL8Fuu
         xeNco7xZ19VujSR1l980NIFyzw4FozakcEcNYj868N2UrJCOG6kZUjxqsyP2mAffcXbc
         V2J8iwPIuY7KkDwnXtGNo6frZH4rRcDzZyZ3Oo0BRauk3mZO/1LaEcYxbTXV1uREDBjf
         G4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=bIdO2DD9SS58shQaI+L75kVmCFLCfvHKiwc1M49jAT0=;
        b=KeivFb3seFMUHSnPbiYJTiCfBdBtfm1wVFC10Nk+80H9oSqQgwSkTR8wjOcjg44+6N
         qapCMnuw1UIa0HWiGuy/AS16yc3FvFXukeylPXDZuV/qOVyu6dZSF8mrJoNJSiVDNFG5
         XvnbxBdGVgWADNpeqtqk17N7Wod/cLN6+3gFvHeN+FgaBN+At3iIZk+0fuLkZGjYzrzl
         i5tbeNynNe7RkyMuwhQGKcQ7RCR6XXFT1mNZdFf7VBEBeEtnV7/E1av9Ax2zmmqPnZRb
         O4oRh8YX7o69QxpRf9MqHg1zwzoKs5kImFG6ilaXPA/QEQSIw6tbLfBijaKSfsoKYwyP
         6Ucg==
X-Gm-Message-State: ANhLgQ0EY42CEreSjurj4b6H0mpTZC86Fywe2mKqxDqwXyGWXPBnGJo6
        CFmjHM2YKJyjCB9H15+LVys=
X-Google-Smtp-Source: ADFU+vumiWAhOGnJquqo1N4StHWr1Li6Q/nrOllp5GIISU6iTtGORSshLBqJc7b7YvGZKUIa8CXUjQ==
X-Received: by 2002:a1c:b144:: with SMTP id a65mr16208631wmf.54.1584260336166;
        Sun, 15 Mar 2020 01:18:56 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id b4sm1349519wmj.12.2020.03.15.01.18.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 15 Mar 2020 01:18:55 -0700 (PDT)
Date:   Sun, 15 Mar 2020 08:18:54 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Minchan Kim <minchan@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [RFC 2/3] mm: Add a new page flag PageLayzyFree() for MADV_FREE
Message-ID: <20200315081854.rcqlmfckeqrh7fbt@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200228033819.3857058-1-ying.huang@intel.com>
 <20200228033819.3857058-3-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228033819.3857058-3-ying.huang@intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 11:38:18AM +0800, Huang, Ying wrote:
>From: Huang Ying <ying.huang@intel.com>
>
>Now !PageSwapBacked() is used as the flag for the pages freed lazily
>via MADV_FREE.  This isn't obvious enough.  So Dave suggested to add a
>new page flag for that to improve the code readability.

I am confused with the usage of PageSwapBacked().

Previously I thought this flag means the page is swapin, set in
swapin_readahead(). While I found page_add_new_anon_rmap() would set it too.
This means every anon page would carry this flag. Then what is this flag
means?


-- 
Wei Yang
Help you, Help me
