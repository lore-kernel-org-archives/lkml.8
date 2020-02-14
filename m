Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0102DC3B19D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC238206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 14:30:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d/sObma4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgBNOab (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:30:31 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36429 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729339AbgBNOaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 09:30:30 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so9377828qki.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 06:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VxTsuQ2jC9FVJWAVO/RbbknunRgb4+8qZM/Lwfhbn5Y=;
        b=d/sObma4wUTwK+USSVFl+ODM3F711ZwnC1Q+A6yE1D/8d63eiTit9quWJNbbxaf9Ex
         oB689jfOxpbewaThmoIikgsFDEptu5EUFL03M9BQ3vRHYz4MRhFqWzO16LEa2BmQpUCW
         KPwLtOYda8vU9UcQkyaQ4UdKP9SE+tL/mLwqC63CNtXXaEN6PzMEVN+THLpNfItCzBC5
         uXzi7VXTopIvtIXMoEeKWGWDP/AfrxIsxk9fzTglR/KOiFx+gcVwIfNI1zqkPxHhK0PN
         mV9wVwNUgNbriyttIdUvYoCarx1qqLaLrDY5rXGxBKdjwKS8seUMtQq1isL2o+30zUok
         zBBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VxTsuQ2jC9FVJWAVO/RbbknunRgb4+8qZM/Lwfhbn5Y=;
        b=T9f+BWVCQzaBL2cfBz3no2H3mpuO9DBS1j/rZFzqyz2Eswmat2hCIoPWGMLUVaZeS+
         AAOv8xOiPq0YsfTyEXHr6n0WuipUCCu1Vow+zjO+wr11maNgNIdUIYK0o/ij+IOkwOTi
         JBWZi/98nYuXaGd5gxA9gZ5SEUg4z6GAst0TzBYGf92desKCFNqY4dansJ0Q0uc33AOa
         kgtLk4OSiSv9xJfX6R0xcQJeBfgPwHAlsXNZQF1cYzmIib5Hd/a6YGU4AOrZskhDYrWq
         cSL1kQ/0VlFSegywXquC+W7H5BLTV6HK32jiwWknGeMpjHJp6RVI8Ya4ZIy8FwQw9hLw
         BZSQ==
X-Gm-Message-State: APjAAAUApaJcVRq7eqTqRlTysy32Ov+ogAJGs+HgJoNttl8rmvUc8hVp
        dnS/TG6lpERYBeSLaR3FFsFY2A==
X-Google-Smtp-Source: APXvYqzKVa+LZt0RGukTPAwnccfxcSaV4SAUv9kkFSOqCz37/OBUJY7V3A2UevIidCK5DCRm0A2jlg==
X-Received: by 2002:a37:bc6:: with SMTP id 189mr2661820qkl.459.1581690629316;
        Fri, 14 Feb 2020 06:30:29 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id d25sm3252655qtq.11.2020.02.14.06.30.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 06:30:28 -0800 (PST)
Message-ID: <1581690626.7365.61.camel@lca.pw>
Subject: Re: [PATCH -next v2] mm: annotate a data race in page_zonenum()
From:   Qian Cai <cai@lca.pw>
To:     paulmck@kernel.org
Cc:     akpm@linux-foundation.org, elver@google.com, david@redhat.com,
        jack@suse.cz, jhubbard@nvidia.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 14 Feb 2020 09:30:26 -0500
In-Reply-To: <20200213192659.GJ2935@paulmck-ThinkPad-P72>
References: <1581619089-14472-1-git-send-email-cai@lca.pw>
         <20200213192659.GJ2935@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-02-13 at 11:26 -0800, Paul E. McKenney wrote:
> On Thu, Feb 13, 2020 at 01:38:09PM -0500, Qian Cai wrote:
> >  BUG: KCSAN: data-race in page_cpupid_xchg_last / put_page
> > 
> >  write (marked) to 0xfffffc0d48ec1a00 of 8 bytes by task 91442 on cpu 3:
> >   page_cpupid_xchg_last+0x51/0x80
> >   page_cpupid_xchg_last at mm/mmzone.c:109 (discriminator 11)
> >   wp_page_reuse+0x3e/0xc0
> >   wp_page_reuse at mm/memory.c:2453
> >   do_wp_page+0x472/0x7b0
> >   do_wp_page at mm/memory.c:2798
> >   __handle_mm_fault+0xcb0/0xd00
> >   handle_pte_fault at mm/memory.c:4049
> >   (inlined by) __handle_mm_fault at mm/memory.c:4163
> >   handle_mm_fault+0xfc/0x2f0
> >   handle_mm_fault at mm/memory.c:4200
> >   do_page_fault+0x263/0x6f9
> >   do_user_addr_fault at arch/x86/mm/fault.c:1465
> >   (inlined by) do_page_fault at arch/x86/mm/fault.c:1539
> >   page_fault+0x34/0x40
> > 
> >  read to 0xfffffc0d48ec1a00 of 8 bytes by task 94817 on cpu 69:
> >   put_page+0x15a/0x1f0
> >   page_zonenum at include/linux/mm.h:923
> >   (inlined by) is_zone_device_page at include/linux/mm.h:929
> >   (inlined by) page_is_devmap_managed at include/linux/mm.h:948
> >   (inlined by) put_page at include/linux/mm.h:1023
> >   wp_page_copy+0x571/0x930
> >   wp_page_copy at mm/memory.c:2615
> >   do_wp_page+0x107/0x7b0
> >   __handle_mm_fault+0xcb0/0xd00
> >   handle_mm_fault+0xfc/0x2f0
> >   do_page_fault+0x263/0x6f9
> >   page_fault+0x34/0x40
> > 
> >  Reported by Kernel Concurrency Sanitizer on:
> >  CPU: 69 PID: 94817 Comm: systemd-udevd Tainted: G        W  O L 5.5.0-next-20200204+ #6
> >  Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385 Gen10, BIOS A40 07/10/2019
> > 
> > A page never changes its zone number. The zone number happens to be
> > stored in the same word as other bits which are modified, but the zone
> > number bits will never be modified by any other write, so it can accept
> > a reload of the zone bits after an intervening write and it don't need
> > to use READ_ONCE(). Thus, annotate this data race using
> > ASSERT_EXCLUSIVE_BITS() to also assert that there are no concurrent
> > writes to it.
> > 
> > Suggested-by: Marco Elver <elver@google.com>
> > Signed-off-by: Qian Cai <cai@lca.pw>
> > ---
> > 
> > v2: use ASSERT_EXCLUSIVE_BITS().
> > 
> > BTW, not sure if it is easier for Andrew with Paul to pick this up (with
> > Andrew's ACK), since ASSERT_EXCLUSIVE_BITS() is in -rcu tree only (or likely
> > tomorrow's -next tree).
> 
> Here are the options I know of, any of which work for me:
> 
> 1.	I take the patch given appropriate acks/reviews.
> 
> 2.	Someone hangs onto the patch until the KCSAN infrastructure
> 	hits mainline and then sends it up via whatever path.
> 
> 3.	One way to do #2 is to merge the -rcu tree's "kcsan" branch and
> 	then queue this patch on top of that, again sending this patch
> 	along once KCSAN hits mainline.  Unusually for the -rcu tree,
> 	the "kcsan" branch is not supposed to be rebased.
> 
> Either way, just let me know!

I suppose it is up to Andrew what he prefers. I may have another pile of patches
depends on some of those KCSAN things (except the data_race() macro) are coming,
so I'd like to find a way to get into -next first rather than waiting to send
them in April (once KCSAN hit the mainline) if possible.

> 
> 							Thanx, Paul
> 
> >  include/linux/mm.h | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > index 52269e56c514..0d70fafd055c 100644
> > --- a/include/linux/mm.h
> > +++ b/include/linux/mm.h
> > @@ -920,6 +920,7 @@ vm_fault_t alloc_set_pte(struct vm_fault *vmf, struct mem_cgroup *memcg,
> >  
> >  static inline enum zone_type page_zonenum(const struct page *page)
> >  {
> > +	ASSERT_EXCLUSIVE_BITS(page->flags, ZONES_MASK << ZONES_PGSHIFT);
> >  	return (page->flags >> ZONES_PGSHIFT) & ZONES_MASK;
> >  }
> >  
> > -- 
> > 1.8.3.1
> > 
