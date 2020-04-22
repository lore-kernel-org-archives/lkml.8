Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FACEC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:54:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CB3A20724
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 22:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="grccDY5g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726158AbgDVWyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 18:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725839AbgDVWyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 18:54:46 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7E8C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:54:46 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id i16so2100126ybq.9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1hkThsyt9bGtB9j8NC1A75L5tYk+krUsD870wYCpjgo=;
        b=grccDY5gsDJ5hIEWCdBAC3aLQKWnBAH9o+1yZqpLA7oE0WwwyFQbq8mPDFLPXItXaE
         O3tD1g/qkiIqUkY1o/8lANVEHsCexzPsfHg5zuJRE1uYzzdvHVr8lPyOkcU7A7uYUH6Y
         50bz25QJG/pr4eVVPeIA0fZCsNK47MTFZVPTiWkozxgiz+tSDOypKiVtaT8pmG9Z5o+2
         i/NSLKKbOLjtzaAwHC3OGBFOHg2eqr+UaS3QgwDP6whVswYMpMRi7Q+8Q3WjXtM4O8mG
         G/zRGqyTMP6vT1RwK8qv4vs4Hcr/abLrFTt3ZFJ9rc0tA0ImMDoZz1age+oO++Z7bLe6
         en7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1hkThsyt9bGtB9j8NC1A75L5tYk+krUsD870wYCpjgo=;
        b=YUMc1tTnX41hIwsedun3hebJasgdI5NpPcy1J0pjqzzh1SRUFq3URBNJ6iFxlC7+Ku
         UMne773POXAQ74aKR6ZoxXNr4FoK+pGJBvB/EeFJ2FJQnYYajaw0ago3aHc3DNtP+X6F
         eS1A9tTAUxCHJjfo52y7EnMjglNl951Pab14agmvsJg6iz3rSkd2MLSJFT8Hz3Lmtg6y
         dNYc33MOeZi56FgCiL0lxVZJ94IJ/c3Q3+C0maKGmwjuK8mRj8lgBIlKzfG9nRbyU2UD
         uRbIvzdmjHYqfxDmnczvE1D87P8RiRk0cVRkqC8YMhO+adM1Pn2jISYg18aRA+GA2s4h
         WXBg==
X-Gm-Message-State: AGi0Pub3i6nmK2c76Y1uOVGLUVLAJ71/yFKkSsUb11VVc5Wrb/wSsJcP
        InRsz1grovIZWPBmqbNR7/1Onfeh4vMuhGlw5ohtsiCoX/s=
X-Google-Smtp-Source: APiQypKSA3iG8RJ4S9ABuuHBi5v+zPHefh7pQMT1p5WEIRRe2JN/cU34UXFN5xqaBgolc6AC5fz3XpktcZtm8dVfsD0=
X-Received: by 2002:a25:4c07:: with SMTP id z7mr1966878yba.298.1587596085501;
 Wed, 22 Apr 2020 15:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200422001422.232330-1-walken@google.com> <20200422001422.232330-11-walken@google.com>
 <20200422015829.GR5820@bombadil.infradead.org>
In-Reply-To: <20200422015829.GR5820@bombadil.infradead.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 22 Apr 2020 15:54:32 -0700
Message-ID: <CANN689EnGsJXA8n6JvTryQfkCtARPvtZbkH+9Dd2a4X+fvqU9g@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] mmap locking API: rename mmap_sem to mmap_lock
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 6:58 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Apr 21, 2020 at 05:14:22PM -0700, Michel Lespinasse wrote:
> > Rename the mmap_sem field to mmap_lock. Any new uses of this lock
>
> Shouldn't some of these be folded into the previous patch?

So, I didn't do it because previous patch only handled rwsem_is_locked
call sites. I leaned towards adding as few new API functions as
possible until we figure out exactly what is required.

That said, I agree it seems reasonable to split mmap_assert_locked()
into mmap_assert_read_locked() and mmap_assert_write_locked(), and
convert the lockdep asserts to use these instead.
I'm not sure we need to do it right away though; we are at least not
losing any test coverage with the existing version of the patchset...
