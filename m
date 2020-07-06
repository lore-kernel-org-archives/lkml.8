Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7BCC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D1F720760
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="vB/nvAwt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgGFKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbgGFKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:08:21 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB36C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:08:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id 9so44519991ljv.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kGb++Oj9rl3Cq6rtcCZ3Q51WnJpX5i2BfarNm4RLaXQ=;
        b=vB/nvAwt42ueZDWAJ17ouUoS6PUXx9gV9fQr0d213CkbXYjCbXcyPuXXir6YlKSj+6
         mtlaD9hmfMaCdwkeH8PIQb5H7dUWTfkCPBEoBISCHhvPQkUWItV/t2tE9XpGsNf67IRN
         5J/qUUiJIwD0o3Peq5xFHUaI/xqSHoxKdCCdERWkuyM+cn7SZgip7nLJpBUPtfMVS0jp
         kjqY8oWs79Pcli1FKp1UqAG/yb0MXhUILIEBWw3y39Ux7zv4OxKmZe4Fhfo8Q7Gdoeyh
         o3L8h6XSo7dipq+GodOdsvgQp/nd8RLir9rL/ybenanpxw3/nR33Yb6Hs5GLOm4VxRIM
         xOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kGb++Oj9rl3Cq6rtcCZ3Q51WnJpX5i2BfarNm4RLaXQ=;
        b=hyWEutMyW27bITbrwDzh7xbcTcmXw/ZJxiznrUsKgXpPkkEyABDMlaT0+/X8RAndHK
         SLRf9kL33Cs0vjvbQ8x3rykGjwACXCyE3+Rpl4CkkGlLcxaSUGplzgYAgX63j5CS7W10
         mIHUgAgAPDg7zNrqFFjqQhqG6owzQ+k/oADBSVrJ7agWGtn3+naqUb4mda68DfJZATG8
         GUY15rZd9dwCDuEYEmzU1QW1OWVlaHPMZ6xuNDuTlPInAIAhzS8V2I+yeQdpJ+/qeE6A
         uszKfmwnbMnZ4PAB6ePMcbozGLoAzD+a7dO96Se8+1YDaDYVa10Zj1kQ6lfeLZ/pXHR/
         wxkg==
X-Gm-Message-State: AOAM530t3+iD9orNcjguqjKcrZvDBKVWlLHDyh8OZbbFqiMAkQkQEpus
        e3xuDCG7a8GNaWzzGOlwTMkpNA==
X-Google-Smtp-Source: ABdhPJyLhQdDzhBS4eUh9v56575OycEkKyAgGdWCb0ZinjOPHLYjK5/5dNC8R7jurOvD6vvMoUA5Nw==
X-Received: by 2002:a05:651c:1105:: with SMTP id d5mr15181275ljo.62.1594030099343;
        Mon, 06 Jul 2020 03:08:19 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id l4sm3962327ljc.83.2020.07.06.03.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:08:18 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 489EA10220C; Mon,  6 Jul 2020 13:08:19 +0300 (+03)
Date:   Mon, 6 Jul 2020 13:08:19 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, vbabka@suse.cz, willy@infradead.org,
        thomas_os@shipmail.org, thellstrom@vmware.com,
        anshuman.khandual@arm.com, sean.j.christopherson@intel.com,
        aneesh.kumar@linux.ibm.com, peterx@redhat.com, walken@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, digetx@gmail.com
Subject: Re: [RESEND Patch v2 0/4] mm/mremap: cleanup move_page_tables() a
 little
Message-ID: <20200706100819.flwgozlstn3zl66u@box>
References: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626135216.24314-1-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 09:52:12PM +0800, Wei Yang wrote:
> move_page_tables() tries to move page table by PMD or PTE.
> 
> The root reason is if it tries to move PMD, both old and new range should be
> PMD aligned. But current code calculate old range and new range separately.
> This leads to some redundant check and calculation.
> 
> This cleanup tries to consolidate the range check in one place to reduce some
> extra range handling.

The patchet looks good to me. I have few nits, but nothing substantial.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
