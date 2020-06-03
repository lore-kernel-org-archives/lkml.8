Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7E4C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E54F2077D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNnQsOil"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgFCXXQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726021AbgFCXXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:23:15 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59271C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 16:23:14 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so2652991pga.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OHXqHmdEIWmolOHqBQdLbpGPOBdhsN5mGbl5Z7dihm0=;
        b=GNnQsOilzofgEYJh9lHoKd/7SaAphs7mb8mGKLG5EAsvhRBFgLNdq4woM5NAbDJu6l
         Pr2+q2lcs9RLPEYyPLo4BanmwhsFaxzP82ef0uZq7b+1tHHu5HcYzIKT5gjiNCanz7rK
         8vac1/5wbGys9LUJVjgAxHY0u4HfWlHZaw+u36Pb/+1ex697r9Gupyk1ImyZh85hCnOX
         W4kLEvmnFVXTG0GAHfO0/K0NTeTyI/epECgxtbMNtm0LJtDHPFTqA4/exz2ZNOkE7P46
         j4d/OUCyqKrciPA5m+4Roa4pHY7RBhX2R4wkAGsGOpxzt3ZIxODYbMGg+vz5L4o4yeL0
         ynSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=OHXqHmdEIWmolOHqBQdLbpGPOBdhsN5mGbl5Z7dihm0=;
        b=OojI5YiB6Cj1nTK+dNQdS5FyZ6/93Gyk83K6LRL90/DhSiF8rDG28A0BTh/QYBjkaS
         gxozomXuvahb1oXxUfrz5DdDfWr8jMohHrGUk2oghi8inarjj2edpI5qzyofx5kvGghM
         w+jWjZ3o2mW8m5Tkz4GdxbW0rd6723l4hZw0Vg1Ddx5OwdLrsRRIOj8AmKT6xn8egsfp
         XfVL1s6U1YZctHynBuzKap/qJDoSXSlP50hB2pyRTHy6jxW8X6gntUFpJ9X8vichpX50
         yM9ucXYmJyHl6z4DL9ev0Elhg309aGo//fFoasIG6bsLAW2gwltsBJ60VqlG9VW2FEph
         vUPQ==
X-Gm-Message-State: AOAM533MhcfaNedSM3NbvfGib8x2kmT5wvDL9+HSl4qQGH14kcpx6KtC
        xbQeKK97ynzAhtl9Fwn/G5UdHExU
X-Google-Smtp-Source: ABdhPJxmnnHvb7jn8ksxZJU8ffEXJSXzpxU7d6KbuVqPXcvw1LWEMNxmjpnoQ4waaPnayhEvi/Kn6Q==
X-Received: by 2002:a62:fc52:: with SMTP id e79mr1427392pfh.5.1591226593457;
        Wed, 03 Jun 2020 16:23:13 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l3sm3394161pju.43.2020.06.03.16.23.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Jun 2020 16:23:12 -0700 (PDT)
Date:   Wed, 3 Jun 2020 16:23:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: track which page-table levels were modified
Message-ID: <20200603232311.GA205619@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 09:52:22PM -0700, Joerg Roedel wrote:
> Track at which levels in the page-table entries were modified by
> vmap/vunmap.
> 
> After the page-table has been modified, use that information do decide
> whether the new arch_sync_kernel_mappings() needs to be called.
> 
> [akpm@linux-foundation.org: map_kernel_range_noflush() needs the arch_sync_kernel_mappings() call]
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Acked-by: Andy Lutomirski <luto@kernel.org>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H . Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@elte.hu>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Link: http://lkml.kernel.org/r/20200515140023.25469-3-joro@8bytes.org
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

This patch causes crashes with all my ppc64 boot tests, in various
locations depending on the platform. Reverting it together with its
companion "mm/ioremap: track which page-table levels were modified"
fixes the problem.

Various logs are at
https://kerneltests.org/builders/qemu-ppc64-master/builds/1442/steps/qemubuildcommand/logs/stdio

Just for completeness, bisect log attached.

Guenter

---
# bad: [f6aee505c71bbb035dde146caf5a6abbf3ccbe47] Merge tag 'x86-timers-2020-06-03' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
# good: [b23c4771ff62de8ca9b5e4a2d64491b2fb6f8f69] Merge tag 'docs-5.8' of git://git.lwn.net/linux
git bisect start 'HEAD' 'b23c4771ff62'
# good: [c41219fda6e04255c44d37fd2c0d898c1c46abf1] Merge tag 'drm-intel-next-fixes-2020-05-20' of git://anongit.freedesktop.org/drm/drm-intel into drm-next
git bisect good c41219fda6e04255c44d37fd2c0d898c1c46abf1
# bad: [1966391fa576e1fb2701be8bcca197d8f72737b7] mm/migrate.c: attach_page_private already does the get_page
git bisect bad 1966391fa576e1fb2701be8bcca197d8f72737b7
# bad: [c5d6c13843880ad0112f0513f3eb041b258be66e] Merge tag 'mmc-v5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad c5d6c13843880ad0112f0513f3eb041b258be66e
# bad: [94709049fb8442fb2f7b91fbec3c2897a75e18df] Merge branch 'akpm' (patches from Andrew)
git bisect bad 94709049fb8442fb2f7b91fbec3c2897a75e18df
# good: [a29adb6209cead1f6c34a8d72481fb183bfc2d68] mm: rename vmap_page_range to map_kernel_range
git bisect good a29adb6209cead1f6c34a8d72481fb183bfc2d68
# good: [56446efab9ce4961fe0fe6bbc5bc66374b08b9f3] Merge branch 'uaccess.__copy_from_user' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs
git bisect good 56446efab9ce4961fe0fe6bbc5bc66374b08b9f3
# good: [17839856fd588f4ab6b789f482ed3ffd7c403e1f] gup: document and work around "COW can break either way" issue
git bisect good 17839856fd588f4ab6b789f482ed3ffd7c403e1f
# good: [ebcdd3074a729f9ba351278e1b42d7ae7fcdf236] arm64: use __vmalloc_node in arch_alloc_vmap_stack
git bisect good ebcdd3074a729f9ba351278e1b42d7ae7fcdf236
# bad: [86cf69f1d893d48fdb0382a940f2523409406423] x86/mm/32: implement arch_sync_kernel_mappings()
git bisect bad 86cf69f1d893d48fdb0382a940f2523409406423
# good: [d8626138009ba58ae2c22356966c2edaa1f1c3b5] mm: add functions to track page directory modifications
git bisect good d8626138009ba58ae2c22356966c2edaa1f1c3b5
# bad: [6c0c7d2b365b21a413f6d75772a8a4a2c7d36916] mm/ioremap: track which page-table levels were modified
git bisect bad 6c0c7d2b365b21a413f6d75772a8a4a2c7d36916
# bad: [2ba3e6947aed9bb9575eb1603c0ac6e39185d32a] mm/vmalloc: track which page-table levels were modified
git bisect bad 2ba3e6947aed9bb9575eb1603c0ac6e39185d32a
# first bad commit: [2ba3e6947aed9bb9575eb1603c0ac6e39185d32a] mm/vmalloc: track which page-table levels were modified
