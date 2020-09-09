Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A94C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:02:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202FA2166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:02:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="dgIxAhSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730640AbgIIRCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730520AbgIIPrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:47:16 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E60EEC061373
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 07:17:57 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id y4so3750606ljk.8
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 07:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RI+bxv5VZflN6t2kKylQhV08+/GCPgbygshc8DXvDRw=;
        b=dgIxAhSw/d+KeaJLhyjaMwi9TdxfkI7HLOKZDlzi73AQBXjyD3sj4Ezv0ST0qI3kVj
         dVrcM35E5fBcLfotWOkVSbzco3ejp6fTIF13sGxcqMhkH1jrZ7F6kGnBFqLswBbEA4wQ
         Lu6wa3K4F92LZMwycMHAtIuPK400uLTm7CEiXYsC1akHJ2ZooKeUaWeAIALiLCz5e5Bs
         l+GTFj9e+iVlFJWrJTptnBNeOCtB6bMwPwVzLeH+VHsvFWL8IFeyb3jNKp9XETcZtP25
         Bin9CViLVt1+GnUjkBunWFxgnClU2IhijD+5lyK/uCwcf9MBU+7AOgKcTg5aT9xD0XBu
         5LjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RI+bxv5VZflN6t2kKylQhV08+/GCPgbygshc8DXvDRw=;
        b=DQQmAde1yzM52GIQFTL6ErrM1GnN9LRG1GVT6ZS+qi62UQyqy4JHiPPH+hJa4SV9N+
         8l+3poTz2YUnlM5xrRZWLhEjyFr9bLUBnsxV0XvKFQ45BMzq7xdMOtie3OACKZmwf6UW
         AwtTVmrplVX7UUE/gjdVDH3zQP+umaZ3ZfOIeJgwqb3hXNGg/r45iFw2UXtNl9nUkAzc
         tdO83qUxEVJTGSiZCCXeya5T9Z8nzdM/IEAp+qAIHwb+cEDBS4MSze3RIigDDtSF8tvR
         mPZSE9+Pz1g6SOu+vU/KKtuYlEtgdE2pUQRU6NNJ5VcV1q8sa3Hq++ib0jX2hIc31sKI
         IcNA==
X-Gm-Message-State: AOAM532kfAArB2V9z9nNucGWZQeYKsduYWQ4G6XzSlwz0EjwJwuBPKHO
        BDtw15EbqP+NGgUIB2CfC32sLQ==
X-Google-Smtp-Source: ABdhPJxJ1cka0/yw3k+K2Latb67SojZMHiT6GzCn48C/9jxpCdPi3NJrrI9YQkpJNaCI30I7JUmjfg==
X-Received: by 2002:a05:651c:1253:: with SMTP id h19mr1906184ljh.55.1599661076370;
        Wed, 09 Sep 2020 07:17:56 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l15sm785890lje.16.2020.09.09.07.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 07:17:55 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id A10F71036AE; Wed,  9 Sep 2020 17:18:00 +0300 (+03)
Date:   Wed, 9 Sep 2020 17:18:00 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 06/16] mm: thp: add 1GB THP split_huge_pud_page()
 function.
Message-ID: <20200909141800.4ueixh2gw5lv4deh@box>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902180628.4052244-7-zi.yan@sent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902180628.4052244-7-zi.yan@sent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:06:18PM -0400, Zi Yan wrote:
>  25 files changed, 852 insertions(+), 98 deletions(-)

It's way too big to have meaningful review.

-- 
 Kirill A. Shutemov
