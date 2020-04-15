Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40DDC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF3620774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="k6cxtDap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731268AbgDOVwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729648AbgDOVwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:52:11 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE15C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:52:08 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id l14so5507043ljj.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IX3wruZGY7llk5Qpla+wL2jsH4dCdrR/VQCtvdqHmRU=;
        b=k6cxtDappj81zBUBPie6lxpMF2nrL97TYrGrAUOqCxfT4ky97R2Q3AeRJ4OedvXDUb
         Z03X1+zL+NZq5pX5Kud2gRwyHgVI17jNHK6K0umHL2Rq5ffhAB0igQul8/tH9U+BnEi8
         ZMDbunyV3k1qL1EQXP4oRETQw/GSz9tJqz+8t0EhoJ1acPcpERKWqjkHuuuJUGRwEVCI
         claL8VjyEGg/JVKhIdUcn3GS+tjGqCzn8YJ8Pi0tUwYE9EkTSiRe/wsgRZRVLOn47SIC
         9MhqsjBDY0opeQ0rCR1PwSRIi79wRW+/Qkh81mRYp4/CkCGXvsxROPLLF61tXqBq5MjN
         km1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IX3wruZGY7llk5Qpla+wL2jsH4dCdrR/VQCtvdqHmRU=;
        b=tc7QJsQfK292iP8De9cXZJAWJnUfiqupRy8rCGLNKui3tvbMXMO7ihyqMfPF4spv0u
         6CecuOfdzHupKQxpEFFCC0PutY5osowe+AT5LlMuj301wTepWxs+9/deVIY0QR6lfz1E
         6uFYjiZLyqX6Da7pascYMwmsWjk2kB0h7ivUs/lSclrv6uUFgw/oGI8ZOAi+3nYC4u5z
         Eon4e2fHn0eljx2mTsNYhJTUGvjCeCssgEBwI9fQmQ18q+J9S+p+pU8Kj1tvNMnQJsEu
         B2DUht/W+csB2rD8TCoQcZgfdPlVFMMlHVC3Aw9BZiUFfk4jrSJTeb3si6sSXRomufMN
         4LjA==
X-Gm-Message-State: AGi0PuabcCMeO0oUOb3mC1vZWhu5vgeKrWhAT1dVF7MooqiVowtz3RD+
        gYKa4uGSdAYErdcUMSh084kExw==
X-Google-Smtp-Source: APiQypLpChKCJYEqRpL8WtEqmh7slqCO4E/fzWqWoWPMT9Y2cxDHgHEDbxL4lL0lF3xb0Rp533ii+Q==
X-Received: by 2002:a2e:140e:: with SMTP id u14mr2981970ljd.252.1586987527267;
        Wed, 15 Apr 2020 14:52:07 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id x24sm13542101lfc.6.2020.04.15.14.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 14:52:06 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id D17A7102C64; Thu, 16 Apr 2020 00:52:05 +0300 (+03)
Date:   Thu, 16 Apr 2020 00:52:05 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <yang.shi@linux.alibaba.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3, RESEND 6/8] khugepaged: Allow to collapse PTE-mapped
 compound pages
Message-ID: <20200415215205.eaihc5snfe4ffhju@box>
References: <20200413125220.663-1-kirill.shutemov@linux.intel.com>
 <20200413125220.663-7-kirill.shutemov@linux.intel.com>
 <20200415144426.a146ef173140f5bc396a6dcd@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415144426.a146ef173140f5bc396a6dcd@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 02:44:26PM -0700, Andrew Morton wrote:
> On Mon, 13 Apr 2020 15:52:18 +0300 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com> wrote:
> 
> > We can collapse PTE-mapped compound pages. We only need to avoid
> > handling them more than once: lock/unlock page only once if it's present
> > in the PMD range multiple times as it handled on compound level. The
> > same goes for LRU isolation and putback.
> > 
> > ...
> >
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -515,17 +515,30 @@ void __khugepaged_exit(struct mm_struct *mm)
> >  
> >  static void release_pte_page(struct page *page)
> >  {
> > -	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_cache(page));
> 
> I have
> 
> 	dec_node_page_state(page, NR_ISOLATED_ANON + page_is_file_lru(page));
> 
> here.  Is there some prerequisite which I wasn't able to find?

The patchset is on top of v5.6. It has been changed since. See
9de4f22a60f7 ("mm: code cleanup for MADV_FREE").

Look like a trivial fixup is required.

-- 
 Kirill A. Shutemov
