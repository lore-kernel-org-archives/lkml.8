Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5278C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 881352072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 23:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgHUXjU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 19:39:20 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:58900 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726884AbgHUXjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 19:39:17 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22203819-1500050 
        for multiple; Sat, 22 Aug 2020 00:39:11 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200821153412.5902e4ed0699615d8de4a595@linux-foundation.org>
References: <20200821123746.16904-1-joro@8bytes.org> <20200821153412.5902e4ed0699615d8de4a595@linux-foundation.org>
Subject: Re: [PATCH v2] mm: Track page table modifications in __apply_to_page_range()
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, Pavel Machek <pavel@ucw.cz>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Vrabel <david.vrabel@citrix.com>,
        Joerg Roedel <jroedel@suse.de>, stable@vger.kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>
Date:   Sat, 22 Aug 2020 00:39:09 +0100
Message-ID: <159805314945.32652.6355592202796435703@build.alporthouse.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton (2020-08-21 23:34:12)
> On Fri, 21 Aug 2020 14:37:46 +0200 Joerg Roedel <joro@8bytes.org> wrote:
> 
> > The __apply_to_page_range() function is also used to change and/or
> > allocate page-table pages in the vmalloc area of the address space.
> > Make sure these changes get synchronized to other page-tables in the
> > system by calling arch_sync_kernel_mappings() when necessary.
> > 
> > Tested-by: Chris Wilson <chris@chris-wilson.co.uk> #x86-32
> > Cc: <stable@vger.kernel.org> # v5.8+
> 
> I'm trying to figure out how you figured out that this is 5.8+.  Has a
> particular misbehaving commit been identified?

The two commits of relevance, in my eyes, were

  2ba3e6947aed ("mm/vmalloc: track which page-table levels were modified")
  86cf69f1d893 ("x86/mm/32: implement arch_sync_kernel_mappings()")

I can reproduce the failure on v5.8, but not on v5.7. A bisect would
seem to be plausible.
-Chris
