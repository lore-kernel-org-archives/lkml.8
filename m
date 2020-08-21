Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEAEAC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE9D5207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgHUMTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:19:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55504 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgHUMSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:18:21 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2DA22ACCF;
        Fri, 21 Aug 2020 12:18:47 +0000 (UTC)
Date:   Fri, 21 Aug 2020 14:18:16 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        linux-mm@kvack.org, Pavel Machek <pavel@ucw.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@redhat.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Vrabel <david.vrabel@citrix.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm: Track page table modifications in
 __apply_to_page_range() construction
Message-ID: <20200821121816.GJ3354@suse.de>
References: <20200821085011.28878-1-chris@chris-wilson.co.uk>
 <20200821100902.GG3354@suse.de>
 <159800481672.29194.17217138842959831589@build.alporthouse.com>
 <20200821102343.GI3354@suse.de>
 <159800635942.29194.13489565974587679781@build.alporthouse.com>
 <159800988352.29194.8498025838223804532@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159800988352.29194.8498025838223804532@build.alporthouse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 12:38:03PM +0100, Chris Wilson wrote:
> In the version I tested, I also had
> 
> @@ -2216,7 +2216,7 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
> 
>         if (create) {
>                 pte = (mm == &init_mm) ?
> -                       pte_alloc_kernel(pmd, addr) :
> +                       pte_alloc_kernel_track(pmd, addr, mask) :
>                         pte_alloc_map_lock(mm, pmd, addr, &ptl);
>                 if (!pte)
>                         return -ENOMEM;
> 
> And that PGTBL_PMD_MODIFIED makes a difference.

Right, thanks. Added that too.
