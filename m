Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06BCC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A66D72082E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="QZgu/08O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgGJOS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgGJOS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:18:29 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF3EC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:18:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id e4so6648099ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hqzEtb6lJ3c0NcggDQj1ymj1IRTrDK0wwDPKEgU7aSA=;
        b=QZgu/08OSA6XnyWA57RMAzQtyx6+bzQmhj9oSowti7m8Jm/o2VZrvNCmaNliGShNFy
         MlWKqC57fJEIaZYoJ37QYZX6pj088paJDSrjYcwO9diYyJ9X/SOQzpQCKpBFpXSIE7sg
         IOUXKRRWtsT1qhJjSiHwMUf3kq8PXEf27vBahzoKdWiIkgXRrKl+G5PuT0rMMwmh5eyF
         dgfMaHaZidY8RlnVQUBpfBEMwlhmuTcd+0CqGX/39ER8fkDMwvYb2zqFTrtPYbnxZYqf
         A5rWoGBuCQ+8Iu4aIN2BR/b5/L3IsvlfrAAVjk6dzHwxDKyZUr39OMAJODi+Vnkc8R3I
         +v9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hqzEtb6lJ3c0NcggDQj1ymj1IRTrDK0wwDPKEgU7aSA=;
        b=HbbmApnXtECsC03MF97girTUQRKbJvmMpvT4pJ2TYkSGNgVrQHvFT5xHJpNf39Legc
         HQrL3RsoxE0IFDyMal6dApjf1i2zXhRGOGPwT60DHdY/C6l4rAuhv/mlvvS7pItZpWge
         +NozJjVLiE6fvbq/jPBqKGpYWHvzdYkxAgoaQSJXUZ/IzJp4sUirewE9nN4mtDPmUU7N
         WDrZP2Vn7Mv64A4D6GkEavKBB9hUtr7rKgxGjR2U2LVxwJpA++iQlnIL50RrCuxr6Kan
         8nuCMxfKtn9AY5nn1cYRlQNsE6h8TeG57q3HrthZF/rlYnVHt38C7zVLJc5eVaEjpGjX
         tuTA==
X-Gm-Message-State: AOAM533EG+O2opa0olHP2csy2koH1aL+1zIHpqM463vOjhrCfi0ljfZz
        HAOzD+w4WvgbRNGwsMUNQOx6gQ==
X-Google-Smtp-Source: ABdhPJw4YIBFhRszLIM91bvvWb4kJUAWyZp6wXB7s1GFSa7nu8MbdV3GVah+NY70CPU6gerT+l+1Tw==
X-Received: by 2002:a2e:9792:: with SMTP id y18mr36925694lji.172.1594390706942;
        Fri, 10 Jul 2020 07:18:26 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id z7sm1954324ljj.33.2020.07.10.07.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 07:18:25 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E1FC910222B; Fri, 10 Jul 2020 17:18:27 +0300 (+03)
Date:   Fri, 10 Jul 2020 17:18:27 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Kill THP deferred split queue?
Message-ID: <20200710141827.netxb2rimpge4qkd@box>
References: <CAHbLzkq5rSHUSbHegM5mURytS7nEDyHHbxOYn8DaBwYB0qGocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHbLzkq5rSHUSbHegM5mURytS7nEDyHHbxOYn8DaBwYB0qGocw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 07, 2020 at 11:00:16AM -0700, Yang Shi wrote:
> Hi folks,
> 
> The THP deferred split queue is used to store PTE mapped THP (i.e.
> partial unmapped THP) then they will get split by deferred split
> shrinker when memory pressure kicks in.
> 
> Now the page reclaim could handle such cases nicely without calling
> the shrinker. Since the THPs on deferred split queue is not PMD mapped
> so they will be split unconditionally, then the unmapped sub pages
> would get freed. Please see the below code snippet:
> 
>                              if (PageTransHuge(page)) {
>                                         /* cannot split THP, skip it */
>                                         if (!can_split_huge_page(page, NULL))
>                                                 goto activate_locked;
>                                         /*
>                                          * Split pages without a PMD map right
>                                          * away. Chances are some or all of the
>                                          * tail pages can be freed without IO.
>                                          */
>                                         if (!compound_mapcount(page) &&
>                                             split_huge_page_to_list(page,
>                                                                     page_list))
>                                                 goto activate_locked;
>                                 }
> 
> Then the unmapped pages will be moved to free_list by
> move_pages_to_lru() called by shrink_inactive_list(). The mapped sub
> pages will be kept on LRU. So, it does exactly the same thing as
> deferred split shrinker and at the exact same timing.
> 
> The only benefit of shrinker is they can be split and freed via "echo
> 2 > /proc/sys/vm/drop_caches”, but I'm not sure how many people rely
> on this?
> 
> The benefit of killing deferred split queue is code simplification.
> 
> Any comment is welcome.

The point of handing it in shrinker is that these pages have to be dropped
before anything potentially useful get reclaimed. If the compound page has
any active PTEs you are unlikely to reach it during normal reclaim.

-- 
 Kirill A. Shutemov
