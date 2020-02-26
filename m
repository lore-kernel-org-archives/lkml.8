Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4047C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6204F2468A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 13:49:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="rOYLBwuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbgBZNtf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 08:49:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38269 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZNte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:49:34 -0500
Received: by mail-qk1-f194.google.com with SMTP id z19so2641578qkj.5
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 05:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yWqfStOVOE4upSG3IQV9mFoVvDm1OYcG0f/E2Oz8iac=;
        b=rOYLBwuy/fjzuNxUGQ6b//BhL9lHBCg/kbnuC59/WT7EbqyYyZNYhvfUMSTAT8OzFd
         0SSuBCRr5Tq9m74HCpK7PJFKzIUktmIdK1BICVFNc7jtIOEPNOX+9SHMU5Uu/z86fYEt
         iBIjyAWFJ9Zpqm+dH64xkcKQDma9MvNgx/nW7zdtoMga26C66BaOzzqC9YWcLQ7af3ul
         ROuMdUfYcTZSM8fYtiw2f9ob+C0HL5ZlGLkXvVVCtldqVurWf1+iJCkGzaFczsgwjoe6
         VupvlDzJ+m9WBV9TUWMtVJkgotWN6+Q6oQs+npLFlArYuFeWNNUtZOVaEGFu9txcXvKu
         Xieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yWqfStOVOE4upSG3IQV9mFoVvDm1OYcG0f/E2Oz8iac=;
        b=h3xpvewiiDyXYmnsYG7KgC/wvo6LVFr6dd9S9GzRkiVrJjsYHK51P/akxdvu02py07
         d7XKEcCwrajd4oB7IBj06+15twsarBfU8Ao1PUpbzxW/NVGUUHqBuRO0chff+a8j6N82
         PPC71agJNERbvCwaOxD1y6motkB+LaGqwLeEhpS3eLuxRRF+daB3HPkPAaL1y0ExFqoX
         0prMiKwTjHM5Bq+Sc9uud+K/lXVPicJ99BNQV3kMm/LCtsEG6zEBx/npXL5Yq6O9eLrE
         o7LD75gpq28x/IpbSHj8I5Mu4Lek4JbJ1DZy3jbe4kDGymhiQtDHBSdRVJyVOzYgKS7o
         i66g==
X-Gm-Message-State: APjAAAXT937n3PRZT1f2XDA2gXrrE4dw39MqKdjtdOfgiC2/7u4wA5Ho
        kHyKxueqgBpUBBK6hF5sWJOUmA==
X-Google-Smtp-Source: APXvYqwqXodEu/+Qo3AslL0WACLqRQ2rZCIJq0S6tvjIRCfy29QY+jBhijhWAkoSAToml2XSUS0yFA==
X-Received: by 2002:a05:620a:1279:: with SMTP id b25mr5653871qkl.385.1582724973567;
        Wed, 26 Feb 2020 05:49:33 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 79sm1147768qkf.129.2020.02.26.05.49.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2020 05:49:32 -0800 (PST)
Message-ID: <1582724970.7365.121.camel@lca.pw>
Subject: Re: [PATCH v2] mm/vmscan: fix data races at kswapd_classzone_idx
From:   Qian Cai <cai@lca.pw>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 26 Feb 2020 08:49:30 -0500
In-Reply-To: <20200226040612.GW24185@bombadil.infradead.org>
References: <20200226035827.1285-1-cai@lca.pw>
         <20200226040612.GW24185@bombadil.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-25 at 20:06 -0800, Matthew Wilcox wrote:
> On Tue, Feb 25, 2020 at 10:58:27PM -0500, Qian Cai wrote:
> > pgdat->kswapd_classzone_idx could be accessed concurrently in
> > wakeup_kswapd(). Plain writes and reads without any lock protection
> > result in data races. Fix them by adding a pair of READ|WRITE_ONCE() as
> > well as saving a branch (compilers might well optimize the original code
> > in an unintentional way anyway). While at it, also take care of
> > pgdat->kswapd_order and non-kswapd threads in allow_direct_reclaim().
> 
> I don't understand why the usages of kswapd_classzone_idx in kswapd() and
> kswapd_try_to_sleep() don't need changing too?  kswapd_classzone_idx()
> looks safe to me, but I'm prone to missing stupid things that compilers
> are allowed to do.

Right, I did capture the race this time. I'll post a v3.

[  924.803628][ T6299] BUG: KCSAN: data-race in kswapd / wakeup_kswapd 
[  924.809949][ T6299]  
[  924.812170][ T6299] write to 0xffff90973ffff2dc of 4 bytes by task 820 on cpu
6: 
[  924.819630][ T6299]  kswapd+0x27c/0x8d0 
[  924.823509][ T6299]  kthread+0x1e0/0x200 
[  924.827471][ T6299]  ret_from_fork+0x27/0x50 
[  924.831774][ T6299]  
[  924.833987][ T6299] read to 0xffff90973ffff2dc of 4 bytes by task 6299 on cpu
0: 
[  924.841442][ T6299]  wakeup_kswapd+0xf3/0x450 
[  924.845838][ T6299]  wake_all_kswapds+0x59/0xc0 
[  924.850409][ T6299]  __alloc_pages_slowpath+0xdcc/0x1290 
[  924.855769][ T6299]  __alloc_pages_nodemask+0x3bb/0x450 
[  924.861040][ T6299]  alloc_pages_vma+0x8a/0x2c0 
[  924.865612][ T6299]  do_anonymous_page+0x170/0x700 
[  924.870443][ T6299]  __handle_mm_fault+0xc9f/0xd00 
[  924.875276][ T6299]  handle_mm_fault+0xfc/0x2f0 
[  924.879849][ T6299]  do_page_fault+0x263/0x6f9 
[  924.884334][ T6299]  page_fault+0x34/0x40 
