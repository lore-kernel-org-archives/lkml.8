Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 397E0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1186621927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="bcbScya9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633868AbgDPPwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387689AbgDPPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:52:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9970AC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:52:09 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id m19so5918104lfq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FfAE3K8uyhxoa402bGrMeSvXqOseWRk+R6RkoAmXNwQ=;
        b=bcbScya9mobQkne7CdnBOoVV0Pajye6caK4t9DX8OVKbpk4KPaho2o6R7qNTWu5hnS
         pnX3o2qdBH68qltybzBhi3TbamMqIgkeQ5uVLW/l+hzuqqCtAYuUiJ7hUJyF3fKI7Vvl
         UxZBC24nupXXkjC5dj6Wxo4LhFM+Dnwu3vdLc/ZcAac2M9dNVfNoNra8OD5jYJjHJ75m
         oEcYZ3ZVRC1k/pC4TWuqO3PMHvCmaf5O1YZKzraCCc6lletIanyHf+q7M41QIaxksWlX
         qAZfNCcK3TUwerJja/lIYutfXFqR80lcGYOsiXSp5aTtmCyhuAiZ9MluAoLWqb4AfwNy
         Z1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FfAE3K8uyhxoa402bGrMeSvXqOseWRk+R6RkoAmXNwQ=;
        b=E3/KOMPDjSw7NXTDRwcoeuA60Sn5jqrCFp2bO55MfUhX7UwyhPNc26wqcpd6SgsSnQ
         DCafx7NaTUrSCfToCNh7egZc5xoKG0wfeCurt0IYaSQRqTWtsRKKAHT6XyR6V72np0Sp
         dFzQo+Xi9pwBU7d+cf1s+DkNQrqfjJhjP6CXakKIod9jonH0jHv1vWkzEYavR3XxFTM6
         AvKhbjMi40kFnsgtWUX5zMdtvCyQ8OYAdUut10cG83ymnbADdW2Yc09BB/QLUljlQkGr
         mo2/J+3pI1h2G6Bj5xXR+F8VzorIAqisGIwQA4apkeTJpCkByPxGvwjiRUTNuIoLUIb7
         TXqg==
X-Gm-Message-State: AGi0PuZEhG5F7KIf68agv9k+UrmlAvONBzsNG96Wqe15MAJptWEI8SK/
        tn3DdqbWz++1z3o85Ibzc4bWKA==
X-Google-Smtp-Source: APiQypKWeWNUzL67I509RIb9cMtVwbJ40Fy04qdiLCdyRp3hf4Kij6z4C0dlcJSnwDWpHBjQm6okLQ==
X-Received: by 2002:ac2:5e86:: with SMTP id b6mr6319687lfq.65.1587052328016;
        Thu, 16 Apr 2020 08:52:08 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w16sm15683130lfk.49.2020.04.16.08.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2020 08:52:07 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0F317102E22; Thu, 16 Apr 2020 18:52:06 +0300 (+03)
Date:   Thu, 16 Apr 2020 18:52:06 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        akpm@linux-foundation.org, Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3, RESEND 8/8] khugepaged: Introduce 'max_ptes_shared'
 tunable
Message-ID: <20200416155206.bqpd5p45oud4chg6@box>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-9-kirill.shutemov@linux.intel.com>
 <fcbfabac-1837-a4ea-1333-15445587e9fd@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbfabac-1837-a4ea-1333-15445587e9fd@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:25:30PM -0700, Yang Shi wrote:
> > @@ -595,6 +626,12 @@ static int __collapse_huge_page_isolate(struct vm_area_struct *vma,
> >   		VM_BUG_ON_PAGE(!PageAnon(page), page);
> > +		if (page_mapcount(page) > 1 &&
> > +				++shared > khugepaged_max_ptes_shared) {
> > +			result = SCAN_EXCEED_SHARED_PTE;
> 
> It may be better to extract the check into a helper? For example, bool
> exceed_max_ptes_shared(struct page)?

It might be reasonable as part of wider cleanup: the same has to be done
to khugepaged_max_ptes_none and khugepaged_max_ptes_swap.

Volunteers? :P

-- 
 Kirill A. Shutemov
