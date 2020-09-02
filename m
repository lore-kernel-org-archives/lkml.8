Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF318C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C392E2072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:48:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iOo7RQZt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgIBSs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbgIBSsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:48:54 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB9C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:48:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 92so4398523qtb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IAZmJcGSADpKomYs9EJjVcf5Ol1FIgBcbrtPEk8iKqE=;
        b=iOo7RQZtWH3T1aKczc1Zfz7wtbIXrsunDFSqQubu1MAkmqhyWqmjcKxVyr5EkTsbrD
         +BKMT8QlzGw936IJeCNp5kjoiS27cxdja8YVg25EfSQFGsDYhcpk+MfkwOyb+PRoecu+
         tKCFGVVejOZPgYbxp39vwVyBNruH1p9j/QpOFG/m64EfwgOQ/tPMtIST82gWgzjMFA9M
         lAH0PPWIenpoL5MXHJYjlEv1CkiUPoYrrK+yvJ1E5VhecoAi+2pcmbKgTw4/LV3ulecS
         2pPWAvD8l4WvqFeg80uCvXF1yJNAYaO4aZMSe8jaEuYpAmM2XPY8qO05e8IlUpbCTPZq
         oq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IAZmJcGSADpKomYs9EJjVcf5Ol1FIgBcbrtPEk8iKqE=;
        b=WiArrjB7kr+QeKtksupR6+vxvC7MKbfGLncIJry2U6/2bYXHcemhBG2BzqtDMjW7Tf
         wVyfRbZ8WB4UDlSkCcG5ohQS2KBtmvK8Z1VP09LPpIHCouvw8Tr7t/zyhcvw+rpqIQAS
         sEHIj1l79nc3YmeoQUvB88chjORk98EwCcZhc7KzXMMeb0eBkG7vqX2+wNgOvw10e/nR
         OZAa0cebG9ff7mHl1u9qWECT6GeF0U25O4ep5cWrfz4/1H/kbtl/bL+R4a9QHoZ8G+f6
         537H+v9FAw+FAQnyanSQd5LX4kfpzhrQAbrs8Mi69hTr4dZoFtWo4xteI4iKLv4fcyhg
         adUg==
X-Gm-Message-State: AOAM530HaG5+FFwq34ooalErwdeG7EQY+Yf/ufVCFR3Uy2ed+KQlVQo3
        p1vz31HKY7JNuRyBWuNI96qWVA==
X-Google-Smtp-Source: ABdhPJz9TDGFI/zT81Y7z8xsM0mVbiopCrzAgSNgeJfHXFsCnHnolPGXBDlckYXMZ6bO0v1QyQ0VsQ==
X-Received: by 2002:ac8:411c:: with SMTP id q28mr8038280qtl.254.1599072533619;
        Wed, 02 Sep 2020 11:48:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d47sm196272qta.63.2020.09.02.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 11:48:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDXoS-005xTU-BT; Wed, 02 Sep 2020 15:48:52 -0300
Date:   Wed, 2 Sep 2020 15:48:52 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Roman Gushchin <guro@fb.com>,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200902184852.GH24045@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200902184053.GF24045@ziepe.ca>
 <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E78A0F18-223C-44A8-BCBA-73CF7AF6F8A5@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 02:45:37PM -0400, Zi Yan wrote:

> > Surprised this doesn't touch mm/pagewalk.c ?
> 
> 1GB PUD page support is present for DAX purpose, so the code is there
> in mm/pagewalk.c already. I only needed to supply ops->pud_entry when using
> the functions in mm/pagewalk.c. :)

Yes, but doesn't this change what is possible under the mmap_sem
without the page table locks?

ie I would expect some thing like pmd_trans_unstable() to be required
as well for lockless walkers. (and I don't think the pmd code is 100%
right either)

Jason

