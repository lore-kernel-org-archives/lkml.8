Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6585FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A5A2081A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 12:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UmMeMog9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgESM5D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 08:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgESM5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 08:57:02 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12CFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:57:02 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so5575326plz.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 05:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vb6RqiVTVLq+YrUuz3LxddPdQqJTjNGlI2TyjoAVayI=;
        b=UmMeMog9h65hOoFUxo5ezFKF35KsGYdjQNjiVmeUA+13MrgKDGigtHSs58ZhwkbR0U
         F7JbpupKVYd/J9zm0+MWWDg/CLbNoqKKuKQgC4SPuW+YIHOmlqkxVjss8cpXoRPh2N43
         EaEPePlLuFDbKrGx9Zskp0g1EpgASSID3ZNnXJx0w7kSuIz9/8djXqp7IGJkrdTaqzUY
         Y7I5Rn7WKjEUF1yj4JDBL2UofpLojH0/rOPkJlQ4yEKbzLNjbhS8z2N+Z2AoDqguUDeA
         6J5iI0tlsK7vTrykiqPBk0hMrA7dYkkBp30VfvJ5KtiYwXyIFAQ1+9OWx39e94gWKkWQ
         oWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vb6RqiVTVLq+YrUuz3LxddPdQqJTjNGlI2TyjoAVayI=;
        b=a/TxE0gwRPWdIfFKFC9wIi/Vao57Y+pvKAgZSXiy6B7CL+41bxYD7hAQcQS1AFo5/i
         RPVwOfbEMPnPeo8jm9zYQaWkoCIpS5FBJZ7s2xs9ZRh4pc29ePu1PkisPY+6dJhldNo6
         OLmqBoODC625mZt5ev0WI05KGIzKjd91XyqSre/RQWfkv4/ryXebKUVtynZJAU6Gn9YD
         Xnlx5I3p+ugDoyCdku/H3Er7p36lE1PApAY+2nEA2nZ22vtMt7CCzGJZRd2NDcOQQ07b
         8upsz4e06mtjMx+fpj3b/Twot4uLJEuJfP7LE74PaTDKS3ztYBZ3mAkpen65/E9EIprE
         8SHg==
X-Gm-Message-State: AOAM5324yty95tDtiC2fFZqqu3yAemNtq6dTHlaJoulNYdodMg+WIk6r
        xHRzLuOcNCvx/7ya6OwrtlkM1CDkeWs=
X-Google-Smtp-Source: ABdhPJw4SNWXARa/duHpULSqdLbi/FXph3PxjLqrhOlWqgGBrEei2TrBrCfbjITfVi7yd4sT5y4ZQA==
X-Received: by 2002:a17:90a:9292:: with SMTP id n18mr4897759pjo.3.1589893022302;
        Tue, 19 May 2020 05:57:02 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id q4sm6761807pfu.42.2020.05.19.05.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 05:56:58 -0700 (PDT)
Date:   Tue, 19 May 2020 05:56:56 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 08/10] mmap locking API: add MMAP_LOCK_INITIALIZER
Message-ID: <20200519125656.GB189720@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-9-walken@google.com>
 <90cfe0e5-2ec9-3a10-0ce6-245bb456a120@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90cfe0e5-2ec9-3a10-0ce6-245bb456a120@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 12:45:06PM +0200, Vlastimil Babka wrote:
> On 4/22/20 2:14 AM, Michel Lespinasse wrote:
> > Define a new initializer for the mmap locking api.
> > Initially this just evaluates to __RWSEM_INITIALIZER as the API
> > is defined as wrappers around rwsem.
> > 
> > Signed-off-by: Michel Lespinasse <walken@google.com>
> 
> 
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> 
> 
> Nit below.
> 
> > +#define MMAP_LOCK_INITIALIZER(name) \
> > +	.mmap_sem = __RWSEM_INITIALIZER(name.mmap_sem),
> 
> "(name).mmap_sem" is safer in a macro?

Thanks, applied in next version.

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
