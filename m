Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD76C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BA52074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="hRvZ3q3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633969AbgDNVff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731763AbgDNVfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:35:30 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C33C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:35:30 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q22so1494045ljg.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 14:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jj2SfzpXG2vA6JlDKL4eiWHkk7cpfBu8IVq5OsaqiRc=;
        b=hRvZ3q3jq55HSrnCkkzeAGXrTsL41FHYn1NHzaoFXqmZ2lbV/tDRtYA+szFTAYL++r
         +x40YLtlUaHAd0iY4V7aUVJBSpUjdhHbK+Ld9VHczwxKML3hUcGWw0ke84L2CkBFo000
         gjhpcvbO/YAYp6A++dcyJNSPMVxBKIwqXTmDUVQgVKJ2CaIXgOWoboB525DBWT77p6l4
         NkaQk9XmEvimNONPKimGJtViDpiChtH18vH/T084/VMRr3ARuNqGl8ay1zi8SPoFTqBQ
         I0g5HXhNV0/ysU2bhAtPYjL/p/hTk01RxBXAeBWVWh7whYa4ydVyzwlInaoAz4kMLG9k
         YJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jj2SfzpXG2vA6JlDKL4eiWHkk7cpfBu8IVq5OsaqiRc=;
        b=rtilguCrjV+x4DgQo6JBh2ABxjsbFuxg0fboB8YLJ6D0aQ4YbHflYe9mwzoCVMQW/I
         THiygfLN3p0GqWo4Zkdbg7ffIMCvdbv2kCGmtMBKy5nEVEjO1uNQXd+SjHLnxOqshqZs
         n8Dpzr36HzjNRhTumDPMqMK1TCFvvrk0RxFmOm9mcc0+jaL38ZKOOF38g9hx2Nd/ZLBt
         czaek7ZqVdGFANYYpMwaxMpNgR/UIrKlGcaTHbr97QgB+DDiWak8CuILA7asRBprvmf1
         rq7qv/9gs+rqAXF0nIHbcaepjxDfzEjPoIH2asspn6a77s0vC2pvIgJa62RDdCuwOEuI
         33Cw==
X-Gm-Message-State: AGi0PuajhKon78Wr7GqEW7wRu/xcJsmmkwqudwQcj2NRhsYvusejYem4
        Y27LyOyJK8I4yQGNLt1LFJ/wcw==
X-Google-Smtp-Source: APiQypLVgR917IPyg1HTf6YZfxptuXp5hCiH3thAs8A9VHxzojJCJhEzYrQLLbyXF5YtOE7TyA1xuQ==
X-Received: by 2002:a2e:a310:: with SMTP id l16mr1283122lje.255.1586900128696;
        Tue, 14 Apr 2020 14:35:28 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x17sm9863062ljc.33.2020.04.14.14.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 14:35:27 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id B619D1029A3; Wed, 15 Apr 2020 00:35:26 +0300 (+03)
Date:   Wed, 15 Apr 2020 00:35:26 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3, RESEND 5/8] khugepaged: Allow to collapse a page
 shared across fork
Message-ID: <20200414213526.ecn3zcgnqxoveddq@box>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-6-kirill.shutemov@linux.intel.com>
 <0efcc512-6f12-1ff0-9885-871172fac766@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0efcc512-6f12-1ff0-9885-871172fac766@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 01:48:22PM -0700, John Hubbard wrote:

[Thanks for all your suggestions and corrections]

> > +	if (IS_ENABLED(CONFIG_DEBUG_VM) && expected_refcount > refcount) {
> > +		pr_err("expected_refcount: %d, refcount: %d\n",
> > +				expected_refcount, refcount);
> > +		dump_page(page, "Unexpected refcount");
> 
> 
> I see two issues with the pr_err() and the dump_page() call:
> 
> 1. You probably want to rate limit this, otherwise you'll have a big
> problem if lots of pages are pinned!

Nope. Only if kernel is buggy. See below.

> 2. Actually, I don't think you'd want to print anything at all here, even with
> rate limiting, because doing so presumes that "unexpected" means "wrong". And I
> think this patch doesn't expect to have GUP pins (or pin_user_pages() pins, ha),
> but that doesn't mean that they're wrong to have.

See condition. We only do it if refcount is *below* expected refcount. It
should never happen. Pinned page would have refcount above expected.

-- 
 Kirill A. Shutemov
