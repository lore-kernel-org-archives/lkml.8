Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41D3B21475
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uGcFgkay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgE1Ivt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbgE1Ivs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:51:48 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715FBC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:51:48 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so32423596ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ChVmxnsorYXBU1u6m+PwijMJWe2EJswsgCuSrn12zNc=;
        b=uGcFgkaybUgqCGlEeapyqGRshtgRePxtUYtwcmiimmp4kSmM8Hb3MdL61WY8zzZSq9
         xvafOpuF/qrYwDZ/1Kf4lzEWLcVP4u11TyTJ7VRH20zIZtf3+pXMFD+Qzf7lsGUQ7Z5j
         quOv5WKzTrUCdbTzp1T3a8Bt/V3HJLy4o3hiAOUY1TZZTILF6/d8zDL8zdWgRwrQFgSI
         x2fq1vrBiIE46Hcn14ucNhPfXsCTWjJeNcQszDCUT3SgTTuSpM2kIM973qKr0t8rWefO
         wP42bPXB3AgS9GYwtJxXvc2JmJYY4jcei5FlVtCNLpGx+jh5pRHx+RPFgmydpLqLDUQX
         OG6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ChVmxnsorYXBU1u6m+PwijMJWe2EJswsgCuSrn12zNc=;
        b=C/r035FX6xRWBz3593NaUIALErhXCVn5WWQ3siL2j4AQ+R9AVJybuwQ9SpXcu70Yvm
         CYWhiFkKbAvapeKzgvFR9z5GX09LcWasx9xRhjCOMTjVjtqzPEh/OxStGaMvvWW5eYMR
         sOqm062ZOux29JfVxviTy0j3DnQeIBUG1CwbJbZW5bOq4tMixWjlXIJYpDzU9kdRHMRN
         68m+GFVtEqxS3zwWrc2lSEraHqztHo630Eqnh0ANgYTL9YeLNSv8WnTOr5Mxva7HrACC
         Qmd9uZXkuNmS4a9cLuB7HQZV5o1qEwDcwFT8o0bcl53fmvkVua9UsVEN/4MRG0+sM/yK
         XsAA==
X-Gm-Message-State: AOAM532VsGr905TvlnEaIltpaN8mpym7dIwABoLW3pNBnTQgG0uQGg3V
        n1E1r7mJ5KIpCj8e32ttM6jGEU1sb3Vv3U52s/JO7rjdJLs=
X-Google-Smtp-Source: ABdhPJxRvvlOMlDxeKdcj9DEz+j4kWuU93/Boidwo8oiPnLc0ELH/SOG7sdaZyPywx5vEc266LAtRigvqgFL+GuhwKU=
X-Received: by 2002:a2e:574e:: with SMTP id r14mr999367ljd.411.1590655906848;
 Thu, 28 May 2020 01:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LSU.2.11.2005231837500.1766@eggly.anvils>
 <20200526160140.GC850116@cmpxchg.org> <alpine.LSU.2.11.2005271402410.6459@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.2005271402410.6459@eggly.anvils>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 28 May 2020 14:21:35 +0530
Message-ID: <CA+G9fYv-UDOobEH4S5ZtBiG6UwvcQ0J-95aRdzs-6C1ze5uq6g@mail.gmail.com>
Subject: Re: [PATCH] mm,thp: stop leaking unreleased file pages
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 at 02:58, Hugh Dickins <hughd@google.com> wrote:
>
> On Tue, 26 May 2020, Johannes Weiner wrote:
> > On Sat, May 23, 2020 at 06:50:15PM -0700, Hugh Dickins wrote:
> > > When collapse_file() calls try_to_release_page(), it has already
> > > isolated the page: so if releasing buffers happens to fail (as it
> > > sometimes does), remember to putback_lru_page(): otherwise that page is
> > > left unreclaimable and unfreeable, and the file extent uncollapsible.
> >
> > Oof, I could imagine that was painful to debug (unless you already
> > suspected file THP due to a targeted test or similar). Kudos.
>
> Thanks, but I have to refuse both your admiration and sympathy:
> mercifully, it was just something I noticed by source inspection
> when working there.
>
> I did then put in a debug count to see if it ever got hit in practice,
> and checked after big multi-testing runs: it was sometimes hit, but
> certainly not often, and I don't know what it was racing with when
> it happened - would depend on filesystem anyway (ext4 in our case).
>
> Saying "source inspection" reminds me: there is another funny in there,
> but I don't think it matters very much in practice, and might need
> rather a lot of testing to justify any particular patch: where
> page_cache_sync_readahead() asks for PAGE_SIZE pages!
>
> "end - index" seems a more reasonable number to me: but then we
> might find that reading ahead into the next huge extent had actually
> been a useful optimization (and those readahead functions impose
> their own caps, so PAGE_SIZE shouldn't work out too outrageously).

My two cents,
Do you have a test case / test steps to validate this patch ?

- Naresh
