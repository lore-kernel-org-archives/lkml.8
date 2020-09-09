Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053C0C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A106E2087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="gUgD1fzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgIINRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730336AbgIINP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:15:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B21CC061573
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:14:59 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id 16so2335851qkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 06:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lSKQ2gBs091A6cYwdzunzjniesYa3PzG6oul/XWeZkE=;
        b=gUgD1fzUdMJkYbrbBnLLLRaO1hLlP/RZzQ52A4vdBoE3gv6lbt2GQ/lCAUgJYrLVuD
         sZpjud3crykrLs2dP89K6cx9KkJSu79+TSLtAvI/75QZSQ5ntoR07ccC/STN462hPIfP
         fi442MswifED3PyMWn+8NG7EzLEgnGL0iMlDViXlGyj+AcBwOFryTvXeVs9/y3Le6gZ8
         snGUn51PbjD3qhU6rWPh3gTwqdsemNM8leXAVVP3OkkNrzPhldzMiZgkFKo96hu9HnFm
         5kbw2hMOKg7OkqDYhwVSTrnyUG7/rNo6C9DCgvw9Gp/ZGoKrPGw+W9/Sd8xXCPuOddHJ
         vaKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lSKQ2gBs091A6cYwdzunzjniesYa3PzG6oul/XWeZkE=;
        b=l2g/7uqDtDEYAutQnE7/4aMnRQAYajt+kqbMf5to0IusF0M80ICQLhtcvXrD8nYOOv
         oL1/u0Yw6OzQK3rAYGnoMq8JHGyYgSO5BOAbLDXmvWFChwWZ06VU3syoJytkMxIc/lPc
         dK5g4hfrKtVVNo/83+siVBI5RWoGGrN+03Au8fYW0sjvHMBwqqtaDW6satvTDiwIQJKI
         4G3fuQKS+lpzvoyt5/F9GUx2dShcaegURaZNHotQyumGFm/z0brY/YvJMHSJX+lRzMQd
         BgdWJtoORdn44kcRo+GPMecRIEjstomfYFnuhU6TrolTQy3WuDtysZjwBVZ+MoQtwGGd
         uvWQ==
X-Gm-Message-State: AOAM531J14DJtTn99B+EVlS77YArRQMR6VsqBxY8Rdk/CKD51P2bE6dt
        9ugThfRxJxLXGeiM/DBNfdIAOA==
X-Google-Smtp-Source: ABdhPJxAUUa+jSBRbu5cRfiK03kinzrn6jruB7OWvltBz6wW6x0j2Fh1XWhUdsUqw5hQjG7vYx4D+A==
X-Received: by 2002:a37:6f05:: with SMTP id k5mr3306129qkc.408.1599657291331;
        Wed, 09 Sep 2020 06:14:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g203sm2616681qkb.51.2020.09.09.06.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 06:14:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kFzw1-003Jih-Rw; Wed, 09 Sep 2020 10:14:49 -0300
Date:   Wed, 9 Sep 2020 10:14:49 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Zi Yan <ziy@nvidia.com>, David Hildenbrand <david@redhat.com>,
        Roman Gushchin <guro@fb.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>, linux-mm@kvack.org,
        Rik van Riel <riel@surriel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        David Nellans <dnellans@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/16] 1GB THP support on x86_64
Message-ID: <20200909131449.GF87483@ziepe.ca>
References: <20200902180628.4052244-1-zi.yan@sent.com>
 <20200903142300.bjq2um5y5nwocvar@box>
 <20200903163020.GG60440@carbon.dhcp.thefacebook.com>
 <8e677ead-206d-08dd-d73e-569bd3803e3b@redhat.com>
 <7E20392E-5ED7-4C22-9555-F3BAABF3CBE9@nvidia.com>
 <20200908142758.GF27537@casper.infradead.org>
 <20200909121117.GD87483@ziepe.ca>
 <20200909123244.GD6583@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909123244.GD6583@casper.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 01:32:44PM +0100, Matthew Wilcox wrote:

> But here's the thing ... we already allow
> 	mmap(MAP_POPULATE | MAP_HUGETLB | MAP_HUGE_1GB)
> 
> So if we're not doing THP, what's the point of this thread?

I wondered that too..

> An madvise flag is a different beast; that's just letting the kernel
> know what the app thinks its behaviour will be.  The kernel can pay

But madvise is too late, the VMA already has an address, if it is not
1G aligned it cannot be 1G THP already.

Jason
