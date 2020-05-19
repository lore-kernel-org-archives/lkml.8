Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D54BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4542B20825
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 13:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UMSCBBn1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbgESNMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 09:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727910AbgESNMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 09:12:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6E82C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:12:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id a13so4058140pls.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 06:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tP3FYLJTEOKIQuZjUVuFnSt4+UqOra+Nq23ilJVgNow=;
        b=UMSCBBn1RAFWT0BEnx3zAKHFYgcwBu68yvRFSmFP3/60DhHebXXJtIKmgESpIyuExi
         nkVffnBvT4peV+6xjRAz3FKF3+gLke64AiFSD8RGA/4IeY4cBjh7WudwFlTiqE+4lc+Y
         5tnTOtl/qwDtXcIHO+usY6vTciSEIh1OMrqwSLF4GrMZ+Lif5d3lCYaR802wgxF1Ft1M
         FyT7ZD1liB1ASRa8/dsRu6+AOkx13me3CFrlhEK3CQ3ejdou+9vdbtIxmfGQtHQdOX0j
         FGzKAnO4b+cXzj6EdTGe3ZbDm1mZR8xZP5PJovx8dA8L4xWYA4PMNg41r9gIqIY0RG6C
         I+mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tP3FYLJTEOKIQuZjUVuFnSt4+UqOra+Nq23ilJVgNow=;
        b=XGDJ+6wTHWx+3g2qkKA4mFfBlMGkiOPlwrk7W2q4V8x85Z3oFTzbeJdMU1k+g5Vj7v
         tD33EnSsRhncAOjgAoB0wk5oCA/sSBYP7v87QKHf0NB0SVJ8yzWRae4FpGL4i/IOoi5m
         KaJi/NZpN4itZ3fFYgcgKI0N0Uk4ciI7hDFveH5q4jLmkzTUYy84VmV/2B02I2KPhXRe
         2plQatmGlQb0mTvx4M706IxU5VtLlAB3qiRStIBdlw8BzMo5q8Rza9wMLbE/86cpVorZ
         oTxGj9kXJQJsIIm/fyuedUxKbw2vSWTo5Uo1G7xZPgT6JPCj153vud6Mbc/6trc9xZfJ
         RctA==
X-Gm-Message-State: AOAM531V3FyY3ValNj/EkzbLT4pun1u/lNBV5GFjiqny9r4vw8jinfsx
        3BXhux9FbrAaVtBtRoWKq1UT8g==
X-Google-Smtp-Source: ABdhPJx5ZbSASX3HAjT47JMmPgnjN3/L3hcV7gQLSUBTPT/CsFk5mHZrTCoE9SHkrHSwN4IwxuYwig==
X-Received: by 2002:a17:902:a989:: with SMTP id bh9mr21280140plb.44.1589893954295;
        Tue, 19 May 2020 06:12:34 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id t20sm2208401pjo.13.2020.05.19.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 06:12:33 -0700 (PDT)
Date:   Tue, 19 May 2020 06:12:31 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200519131231.GE189720@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com>
 <20200424013958.GC158937@google.com>
 <25ca9d8a-7c2a-b82e-f727-fcc940f19f2b@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25ca9d8a-7c2a-b82e-f727-fcc940f19f2b@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 01:07:26PM +0200, Vlastimil Babka wrote:
> Any plan about all the code comments mentioning mmap_sem? :) Not urgent.

It's mostly a sed job, I'll add it in the next version as it seems
the patchset is getting ready for inclusion.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
