Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C9EC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FAFF20715
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ig3oOK65"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbgDXB0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:26:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725888AbgDXB0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:26:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8F5C09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:26:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o10so3827802pgb.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 18:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NC0XHk8DQ3We4ZUfMs3NMjRQujIHbpO9VgcwaCx/kO0=;
        b=ig3oOK65f7HvPazjGSWn8LXJCkLx1h6pDj1wg/l1sGgKh7vU8p9lD/lLFXQG2VdpRg
         S/+ST8aWjhIHom4pKFuzxsE/VbfOIOcTHr4QLO5B20mg+miTUWrqBpnQ0I0YBz6peQoG
         03qqX2Zqe92JUyBw2bBw3RBraBfc9ASWbd3cz1x8zIf03Mo/reg01ZLs00nK1NjVrzoI
         G7V93jM5WcpvZ3LZGh7x7FreEqehtwKPum4wQld5JrHwnNbQoDzoJ2PpvZCafzR6zQVE
         BeDrXZFUzeRTiiIWWW5VFeN7Sz8Qk9yKHYV7MKE5tu2JEL0JC/DV9xPIUaJahmdEoLJi
         W6HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NC0XHk8DQ3We4ZUfMs3NMjRQujIHbpO9VgcwaCx/kO0=;
        b=koopxQ39PMJeme1+mVWFkrhsvg5PpDBl9rQixB9VTANXsGvRdB8ikHXfPcSg4GDRPR
         hAHsg8Eax5fj3kZ/aafXUrfmDpWu0qao4bheOuXEHxEXLp/jUmIDB7aONfRS6tJs59+f
         Ua2Vn9TyfRn5xdGsGjg6xEztEBCg7A8cbCemJnmGVi28w7WlocJIDdYlZIbSLLAgFDAO
         ufsl743j7o9ts15PtdKSA7KNdJ7Ht0z2bfGc+l+4Ry0vhy70RWaUtAdG6RBWfL+rEzGP
         nzvDVoBeUuvxxE9N6gkebYfEQRnmkUHgpBszc1TGxCbA4Nb/25uBV1Ka1FIxirW8u5gv
         Zg5A==
X-Gm-Message-State: AGi0PubvjwrOSpK8Y7OFGAoqD53QaRBXxsRl06h0JBoUlVBJ2pYQLP4z
        3r3hhk1nNi84tEa03J5tV2MYKQ==
X-Google-Smtp-Source: APiQypK2SvJkAooR10gUB68thVM/WtfJkS1JRI/Qbi6RKU0AgQ/JZazSgMLJG/oMmrcB4sveZvJqEQ==
X-Received: by 2002:aa7:8a9a:: with SMTP id a26mr6377618pfc.77.1587691576899;
        Thu, 23 Apr 2020 18:26:16 -0700 (PDT)
Received: from google.com ([2620:15c:2cd:202:2523:d194:de3b:636f])
        by smtp.gmail.com with ESMTPSA id q201sm3978352pfq.40.2020.04.23.18.26.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 18:26:14 -0700 (PDT)
Date:   Thu, 23 Apr 2020 18:26:12 -0700
From:   Michel Lespinasse <walken@google.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>
Subject: Re: [PATCH v5 10/10] mmap locking API: rename mmap_sem to mmap_lock
Message-ID: <20200424012612.GA158937@google.com>
References: <20200422001422.232330-1-walken@google.com>
 <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
 <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
 <20200423015917.GA13910@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423015917.GA13910@bombadil.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 06:59:17PM -0700, Matthew Wilcox wrote:
> On Wed, Apr 22, 2020 at 03:54:32PM -0700, Michel Lespinasse wrote:
> > On Tue, Apr 21, 2020 at 6:58 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Apr 21, 2020 at 05:14:22PM -0700, Michel Lespinasse wrote:
> > > > Rename the mmap_sem field to mmap_lock. Any new uses of this lock
> > >
> > > Shouldn't some of these be folded into the previous patch?
> > 
> > So, I didn't do it because previous patch only handled rwsem_is_locked
> > call sites. I leaned towards adding as few new API functions as
> > possible until we figure out exactly what is required.
> > 
> > That said, I agree it seems reasonable to split mmap_assert_locked()
> > into mmap_assert_read_locked() and mmap_assert_write_locked(), and
> > convert the lockdep asserts to use these instead.
> 
> Just add mmap_assert_write_locked() -- some of these places can be called
> with the rwsem held for either read or write; it doesn't matter which.
> Others need it held for write.  There aren't any places (that I'm aware
> of) that need to assert that it's held for read, and not held for write.
> 
> > I'm not sure we need to do it right away though; we are at least not
> > losing any test coverage with the existing version of the patchset...
> 
> It seems like a better way to remove users of the term 'mmap_sem' than
> just converting them to use the new 'mmap_lock'.

Hmmm, OK. I updated changes 09/10 and 10/10 based on this feedback. I
do not want to resend the entire series, so I am going to send just
these two changes as replies to this message and call these v5.5 :)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
