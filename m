Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39379C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 144CA207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NKiIB31r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgETMsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgETMsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:48:20 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C9DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:48:19 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id l3so1219737qvo.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=je/KbnslOZKPvi+gdbk2BorRQK9HerFcoy4nD5X6lMM=;
        b=NKiIB31rUNec8vPy5B581Ac3XHacW4bKFkiRsrE64Ih4KYBq8+vE7e6JqfUsABdEEs
         vpEWvb2tq7FEsIQQ7SlWvqCtsFj8Y6eQz8bHkER5KF5DxHCd3cF8ddiES1gge5xyggyC
         woCsKccdrLS1Pa2+DKIj1RFtH4b/rdouJtV4rI89ssc0/a0Pfvbnrdcbpj5X1PYFe/du
         NlfzXFkUIsb/bxVA1uLZfeUJib3SXDMEgFDgU+pr04YShYQZ1xwhYE3oe3BxJg+ltOav
         rSDV7Wnut8vVcWwyY3O2fDe6KMHW5muXkuRMe6RltEdiK3sknldDfVTCcTf5EcwVoyMv
         c5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=je/KbnslOZKPvi+gdbk2BorRQK9HerFcoy4nD5X6lMM=;
        b=PbhXe1JdAElWCO7OBz9Vy7H1H3gJ2novntRnCj7q+EjW5PvijanOVi9ddX5X3DKTUi
         f6vWrdJWPY3FqiYEeBCYoYFNnQ/uCap7EWTkYIgENcery6X4FiBT1IYergNHZ1eO6vWx
         wpPkhOOz/GHPXv5l02H1Ooi/ms4oW1M9vCTdgr6vkX97brqAKxrJ98rgBCxvpLe9scuT
         /MkD3gSjR8MC1fi/xmIouKIJaDi4u0EtTN7sk0J2AFlzGjIzk/zZISwg904O8zuZ3jgb
         E/uiJKeVRag10tFZIaPkpSwsHwRxpwePY72b7kHECNSMsOEkwdbUiCrxvtXrupJ9khaH
         bnxQ==
X-Gm-Message-State: AOAM531heG5bSiLK0+YzJqatBnDYulIJuc5TminVhmquRCE/4g+F6bXh
        zZ5+0k2pJg942deTnfjyNMkc5A==
X-Google-Smtp-Source: ABdhPJxB9IgoFEYhXyhWQbtJRUK6zs/WfyptsnOZKIDXlwXkNioof1JO/WpAsbbm3+41MY2mjsIJLg==
X-Received: by 2002:a05:6214:42f:: with SMTP id a15mr4609714qvy.212.1589978898653;
        Wed, 20 May 2020 05:48:18 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j83sm1912436qke.7.2020.05.20.05.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 May 2020 05:48:18 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jbO8v-00063L-Du; Wed, 20 May 2020 09:48:17 -0300
Date:   Wed, 20 May 2020 09:48:17 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Michel Lespinasse <walken@google.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5.5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200520124817.GG31189@ziepe.ca>
References: <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
 <20200424012612.GA158937@google.com>
 <20200424013958.GC158937@google.com>
 <f20ab834-cddb-eaa7-c03e-18f0c4897a33@linux.ibm.com>
 <20200519131009.GD189720@google.com>
 <7c540ac9-ba44-7187-5dc2-60b4c761e91c@linux.ibm.com>
 <20200519153251.GY16070@bombadil.infradead.org>
 <10d48b77-5c6e-2e10-84e6-16cdd76a45f1@nvidia.com>
 <CANN689EubtJL2mbcz5Au05nW87gVuY-19r7nZd9x0y320PUb0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689EubtJL2mbcz5Au05nW87gVuY-19r7nZd9x0y320PUb0g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 07:39:30PM -0700, Michel Lespinasse wrote:
> > > I think this assertion should be deleted from this driver.  It's there
> > > in case get_user_pages_fast() takes the mmap sem.  It would make sense to
> > > have this assertion in get_user_pages_fast() in case we take the fast path
> > > which doesn't acquire the mmap_sem.  Something like this:
> 
> I like this idea a lot - having might_lock assertions in
> get_user_pages_fast makes a log more sense than doing the same at the
> call sites.

+1 I've wanted to see more complete lockdep annotations in gup.c for a
while now.. There has been a number of bugs this would have caught

Jason
