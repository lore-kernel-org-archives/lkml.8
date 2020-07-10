Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B21CC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258C32078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 08:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="CXjTDGyU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGJIOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJIOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 04:14:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406B7C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:14:37 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id u25so2721067lfm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 01:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=EdqYNjnn4lFnDb/Ltl3KnhokXyLvpEwpSaEOucEsDeQ=;
        b=CXjTDGyUkcbgXKv4Qefq/jkn6TTSEZ65GZRlyaUe9sNQkeXIZOocWKy+0KuaYGdSVV
         MBMrfNZUPp3xKF0DBbqPpxiuk5yUEQMhL7bE391khlQIMLtot4+Qh3hyXg7Aq/3cb8Kf
         hgmoAM6a7diDOgTv2UwrvxGppkos5FF1ycsco+lQ/pzODcNptrQ9pmlqaOqKMhd5lQYJ
         /UsX2L8Og7LX3VT3TJ1e1LlgMRh8FNA0tGX4VxSN15Cl2czArgt1GNRouXO+Bb9QaUoM
         oTR4QQXuXPcYwPfcZA/5sT8/AXAjfjrV70jXDgE9Z1jv4z8Y7VDSS9jEioJDA7IM0F9U
         1+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EdqYNjnn4lFnDb/Ltl3KnhokXyLvpEwpSaEOucEsDeQ=;
        b=JRgl+0/O/uKqBZOCgctumZY4KZ//K6fSX1t/0o0qW0lEjG2wtf8loAH2Chkh0UC6mf
         6hm8G3y1fDkSU+wfC5KsFVVpKfFGc3OGSCrX6C0s6c2vyyoNCfvZs3SChMiV3Db/9AK9
         YLuBKagxbgZS+ZAFxZGqKPgnUz35m/OxaWjlhgHVZZ6/xV1WDnWP00i6Wjb/eiVhhhoU
         p3yoe1z3DodN4a2f5JdseYElkhQI+1v984258SGAowdXcPxLEvDRQHa+vbfRGskogtGR
         /FjEhak+ejt9wD2V1wD9+vA4qqqavPhkBd5zUEB9M4Z5qXtMwTCp14ot4EFqWS3F9DNs
         Cv/Q==
X-Gm-Message-State: AOAM531r3+wPqmV23gxhfhgp/z6nQdkNTsRR3umDGvxFXPDQjAKS4T5I
        4/swHoYmchmXpkt2iiXObFkh5A==
X-Google-Smtp-Source: ABdhPJzJ+asruIY1JGYqEOmk9ijAqDtgjs0Gka4N81Senyhf3C/IPjxWcoT9T4BKvPOgZZQDaTJ0qg==
X-Received: by 2002:a19:ecc:: with SMTP id 195mr42789720lfo.71.1594368875511;
        Fri, 10 Jul 2020 01:14:35 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id i8sm1654396ljg.57.2020.07.10.01.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:14:34 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id BC1F610222B; Fri, 10 Jul 2020 11:14:36 +0300 (+03)
Date:   Fri, 10 Jul 2020 11:14:36 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     Dmitry Osipenko <digetx@gmail.com>, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        yang.shi@linux.alibaba.com, thomas_os@shipmail.org,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        peterx@redhat.com, aneesh.kumar@linux.ibm.com, willy@infradead.org,
        thellstrom@vmware.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [Patch v4 0/4] mm/mremap: cleanup move_page_tables() a little
Message-ID: <20200710081436.3f75omeq5xpjeoc6@box>
References: <20200708095028.41706-1-richard.weiyang@linux.alibaba.com>
 <3cab86b0-586e-781b-1620-f28b00c57d44@gmail.com>
 <20200710011410.GC51939@L-31X9LVDL-1304.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200710011410.GC51939@L-31X9LVDL-1304.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:14:10AM +0800, Wei Yang wrote:
> On Thu, Jul 09, 2020 at 10:38:58PM +0300, Dmitry Osipenko wrote:
> >08.07.2020 12:50, Wei Yang пишет:
> >> move_page_tables() tries to move page table by PMD or PTE.
> >> 
> >> The root reason is if it tries to move PMD, both old and new range should be
> >> PMD aligned. But current code calculate old range and new range separately.
> >> This leads to some redundant check and calculation.
> >> 
> >> This cleanup tries to consolidate the range check in one place to reduce some
> >> extra range handling.
> >> 
> >> v4:
> >>   * remove a redundant parentheses pointed by Kirill
> >> 
> >> v3:
> >>   * merge patch 1 with 2 as suggested by Kirill
> >
> >>   * add patch 4 to simplify the logic to calculate next and extent
> >
> >Hello, Wei!
> >
> >Unfortunately you re-introduced the offending change that was fixed in
> >v2 and today's next-20200709 on ARM32 is broken once again:
> >
> >BUG: Bad rss-counter state mm:db85ec46 type:MM_ANONPAGES val:190
> >
> 
> Ah, my bad, I forget the error we met last time. It is the different format of
> pmd_addr_end.
> 
> Sorry for that.
> 
> @ Kirill
> 
> If you agree, I would leave the extent/next calculation as it is in patch 3.

Okay.

-- 
 Kirill A. Shutemov
