Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE36C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA862083E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 23:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PkjeLn1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730761AbgG3X1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 19:27:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45654 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729896AbgG3X1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 19:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596151624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0dnwClkLytJ7ifAFzBYUf9+c2LFXB//uwoiUu3SHrZU=;
        b=PkjeLn1ljoAuvKewwBlta5xxvPmrcVGjvIIlbmHPfA9KBm45jG6O2rDNRGdGrZxrURts0o
        kZhW94sLLRhYnGr8vhCdECz/p+5ZEIkqPQS153Nyl4u8Ji/ZpDDA9C7ZfjBQnXFvcnOJCA
        +M+wTkt8oqRG2AYv02UMxwq1swPK0PU=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-kCMJhUrpNfGfoedKCekfbQ-1; Thu, 30 Jul 2020 19:27:01 -0400
X-MC-Unique: kCMJhUrpNfGfoedKCekfbQ-1
Received: by mail-qv1-f70.google.com with SMTP id ed5so19182089qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 16:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0dnwClkLytJ7ifAFzBYUf9+c2LFXB//uwoiUu3SHrZU=;
        b=dQ6OICkUL8L75yXRSrgU8jVh//P3nXoiGE3Ni3h59cptlvk9YBmWc7GpEmCY6EI9zn
         Uo47R/RaDTTdZLohUav8hxTuhdwxpvO3Nx6JvL6VkwG89zblGTxIUXcX4JrK1RXvTbl0
         YRQsYFMm4fdYsZ05lGSATemV1znnwf5qsI9liEKNSycx7PqiUDi3acidwIDxNI/y65bc
         slNr9bmZA4+1Gbvs7lL/bi9JLClDp7rVBHJci6my4L32AnpY5OfWWLiOA85kWNoBT9JY
         r4JfP9Vr6Nej4MImzR2y2aEW59byWJHbY7nduS6RuUwAAuB9foWe3X3FzxbCJ2EaOIL3
         7T3Q==
X-Gm-Message-State: AOAM532w5Qb3ZNAK2eU7nNDA2xt3dApWSaXk4NYaFLCp6EJIoHP7GiYQ
        dcNGLpJjzg1L6bWqzzK3aiF1GM+5gS+WdWMe2TKgyHH1N9nl+uGUGnjvJSc5UH9J/KR1wH08P/B
        pgh69fUiC7GLZJJzyEghxCs4j
X-Received: by 2002:a37:b907:: with SMTP id j7mr1665407qkf.120.1596151620676;
        Thu, 30 Jul 2020 16:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuKGfOlmGg3QEK14K8jZU842TxlVJjoO+SmyMrRUFIoGYwljYhJd9v3PKb0IW0TSCGWNyhTg==
X-Received: by 2002:a37:b907:: with SMTP id j7mr1665381qkf.120.1596151620218;
        Thu, 30 Jul 2020 16:27:00 -0700 (PDT)
Received: from xz-x1.hitronhub.home ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id z67sm5873724qkb.27.2020.07.30.16.26.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 16:26:59 -0700 (PDT)
Date:   Thu, 30 Jul 2020 19:26:56 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2] mm/hugetlb: Fix calculation of
 adjust_range_if_pmd_sharing_possible
Message-ID: <20200730232656.GE3649@xz-x1.hitronhub.home>
References: <20200730201636.74778-1-peterx@redhat.com>
 <4680014a-a328-b0c2-dc86-8c1eb4556f69@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4680014a-a328-b0c2-dc86-8c1eb4556f69@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mike,

On Thu, Jul 30, 2020 at 02:49:18PM -0700, Mike Kravetz wrote:
> On 7/30/20 1:16 PM, Peter Xu wrote:
> > This is found by code observation only.
> > 
> > Firstly, the worst case scenario should assume the whole range was covered by
> > pmd sharing.  The old algorithm might not work as expected for ranges
> > like (1g-2m, 1g+2m), where the adjusted range should be (0, 1g+2m) but the
> > expected range should be (0, 2g).
> > 
> > Since at it, remove the loop since it should not be required.  With that, the
> > new code should be faster too when the invalidating range is huge.
> 
> Thanks Peter!
> 
> That is certainly much simpler than the loop in current code.  You say there
> are instances where old code 'might not work' for ranges like (1g-2m, 1g+2m).
> Not sure I understand what you mean by adjusted and expected ranges in the
> message.  Both are possible 'adjusted' ranges depending on vma size.
> 
> Just trying to figure out if there is an actual problem in the existing code
> that needs to be fixed in stable.  I think the existing code is correct, just
> inefficient.

Thanks for the quick review!

I'm not sure whether that will cause a real problem, but iiuc in my previous
example of (1g-2m, 1g+2m) in the commit message, the old code will extend the
range to (0, 1g+2m).  In this case, if unluckily the (1g, 2g) range is a pud
with shared pmd, then imho we face the risk of partial tlb flushing with the
old code, because it will only flush tlb for range (0, 1g+2m) but not (0, 2g).
If that's the case, maybe it worths cc stable.

Anyway, I'd like to double confirm with you in case I missed something.

Thanks,

-- 
Peter Xu

