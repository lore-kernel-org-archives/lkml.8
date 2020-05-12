Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22E5C2D0F9
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF82E23126
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="OT7cqfnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731103AbgELT7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730950AbgELT7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:59:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D45CC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:59:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id i14so13869407qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sg2a6fyKRQRSKPyMiUgq/bNuu0wOUTmUYFCGZhrn034=;
        b=OT7cqfnzqlQcrm3j3lZ8ug/HxoHDbCEOgPbhYZSq0oSzfbW9NTTuwi6FVDWBSVS0c8
         ZFCOYNPc6rkkh8n2hg221SKSo5p7n1cfUPpaVPQnUO+YnriXHAeBHl5DJlmkpOHuFU15
         3GCSoTfT2owPbi2c1KFKsyh04YfdJdgj8Gp7zvfVk8n1CQHnNRXF03Dh+rrhG0nz8HVD
         3LNui8wk3HRf728C/0ByTSQ+jSG6lmA6O55Z3du3Li9onvFoO9rSB+twGwy2UhgPOwGy
         TGEN0vtOiI4I6iQ+j0svwE9QSj/MZ4+W9c/iEO8ohFdsKUy6fOo5bXOlKCvkuSaAjBAP
         OAdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sg2a6fyKRQRSKPyMiUgq/bNuu0wOUTmUYFCGZhrn034=;
        b=oaCVR2ZP4e32m7RYlMOmFD0AJZlaBcOQCVt84iwqc7wrtnthyYTMsbl3i+W1/vZucg
         erxKpg/yyYF1F4aX9JUL8RJ9b7+KF9e8PPLkRCl7Cti4XgmrpLzfUVY6UVsCwRSsFbgn
         WC/RBZ5xx7+wFT/5IZxVmVZHiK2ZwcbdXnDGHPu3/OJUK72o2sBSLRTYfww37OIX6hhA
         Wifo3VIAwVqcOUO4IMFaxopuZ4yXjnuNAGlgjgliTvSE+miez2LsRJW2iZjTLuMStLe/
         xyCswddi+k8QWwKQ8he364+WWOAZ4fJsVNuLl8AJ4KKrpsxenshBypVFUNBv1qFmQz5P
         QazQ==
X-Gm-Message-State: AOAM533FBXWOR7UOAyK4GK6cvmHneoqFpkhwO+GMYlJXKmA64kcOlTaF
        umHTa7B+LLzjeadb+UrrAOh7SA==
X-Google-Smtp-Source: ABdhPJxbcK6lfd/Nxn8gQyx7XBGZvs9eg60XbAfVRNq5h29RM1mvRc3znjsSPHIdHHJ0/LVvCAjjrw==
X-Received: by 2002:a37:6547:: with SMTP id z68mr9489696qkb.197.1589313573539;
        Tue, 12 May 2020 12:59:33 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id h12sm9953357qtb.19.2020.05.12.12.59.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 May 2020 12:59:33 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jYb3s-0002Oo-KA; Tue, 12 May 2020 16:59:32 -0300
Date:   Tue, 12 May 2020 16:59:32 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     jglisse@redhat.com, Ralph Campbell <rcampbell@nvidia.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mm/hmm/test: fix error return code in
 hmm_dmirror_init()
Message-ID: <20200512195932.GB9154@ziepe.ca>
References: <20200509030234.14747-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509030234.14747-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 03:02:34AM +0000, Wei Yongjun wrote:
> Fix to return negative error code -ENOMEM from the alloc_page() error
> handling case instead of 0, as done elsewhere in this function.
> 
> Fixes: 5d5e54be8a1e ("mm/hmm/test: add selftest driver for HMM")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  lib/test_hmm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Thank you, I squashed this into the original commit

Jason
