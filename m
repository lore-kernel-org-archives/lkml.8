Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9DEC2BA12
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 713B121744
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 14:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="Hf1KZ1qQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391063AbgDCOgE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 10:36:04 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34102 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgDCOgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 10:36:03 -0400
Received: by mail-lj1-f194.google.com with SMTP id p10so7213413ljn.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 07:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zmPYYW3fxClIYaAQ3d5kwhebWv1mnQ+1ShHjdxdDtmU=;
        b=Hf1KZ1qQmdj/mjtE6P1FKY3Ud/bzbLAgQS3JOTKm2ISSGkHwg51cYv/VioKxVCzdQp
         faSw1d9n5ma/2y5jkAkLT9AM+nz5dJwa08TSRC3KmEl6tehcIshqDmgOu4EogubN1dJk
         /JDmM5l+j5eM+9wEeOQqAugI7/x38sVvEmhQ6XBZdKTSP6ywp2e4s+5nQeCL4CAfDdVt
         GO7eOfw+2WyrGTCC1kJdLSrvPAYoUXIMmrt9Je3F8+7XXG6sJUNz3cizBYC2Agu8Kh0e
         wDla8AziaQ2B1yRbT2cOBRXBceBm9b1WZdFh68d9lHbQ1OtQA2donIqzy1o5DLmnjyl8
         cacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zmPYYW3fxClIYaAQ3d5kwhebWv1mnQ+1ShHjdxdDtmU=;
        b=fF1yMnaK+SCMFbVPtpAGmThURHuVFftu5ABowqMp3iym2/mvf0cMzJE05FBrd9JCME
         k82fKBWbtC3JpePKbhMyhw13Z1MY11sLG5nUPPcn2XKsP7cvRxliPqkrv/4N/dzBzofg
         pVsCl9Tsf2zlAjUmlAMhg7txpYSzVdP83OsAsc0Z2Ax9p15GF98qWVQFbZGJVgGdJdy6
         h9IdE3uXr88Pe1z//WMBQ4cvjBNRRHn05EoMaegOUgIPggZ6dzvM6vO72EOAdA4GtCbM
         M1eUWBP6MlrEFiUrS90/TRwo3MyElf8ZyfBTfLhvNqFBCHOhi6N8OjI+CY/pH2rrlKdK
         MHGg==
X-Gm-Message-State: AGi0PuYpxNvz1Enq8VIzMgho+P8Ch0e4WLkI4rhFOmR9zHN1xdj+B8Ix
        nCvSy6bSWT9Yz89+7Ncd/ZJ93LZwJEo=
X-Google-Smtp-Source: APiQypIMtF298Yl8bns41YZvM//TAVUblf05xp8RS423ZldCdYW94Ak2bpOVE3gTdd9ciXzdKrrYAw==
X-Received: by 2002:a2e:6809:: with SMTP id c9mr4915106lja.251.1585924561034;
        Fri, 03 Apr 2020 07:36:01 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id p5sm5923335ljn.99.2020.04.03.07.35.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 07:36:00 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 94A6D10132D; Fri,  3 Apr 2020 17:35:59 +0300 (+03)
Date:   Fri, 3 Apr 2020 17:35:59 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     kirill.shutemov@linux.intel.com, hughd@google.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: thp: don't need drain lru cache when splitting and
 mlocking THP
Message-ID: <20200403143559.aex2w7utvkf5rr5y@box>
References: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585337380-97368-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 03:29:40AM +0800, Yang Shi wrote:
> Since the commit 8f182270dfec ("mm/swap.c: flush lru pvecs on compound
> page arrival") THP would not stay in pagevec anymore.  So the
> optimization made by commit d965432234db ("thp: increase
> split_huge_page() success rate") doesn't make sense anymore, which tries
> to unpin munlocked THPs from pagevec by draining pagevec.
> 
> And draining lru cache before isolating THP in mlock path is unnecessary
> either.
> 
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Andrea Arcangeli <aarcange@redhat.com>
> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
 Kirill A. Shutemov
