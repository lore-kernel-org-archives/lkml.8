Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BED1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDBFD207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 04:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nj3j3mJf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgEUEuH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 00:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgEUEuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 00:50:06 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B3A3C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:50:06 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id n10so2179324ybn.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 21:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQovpB62feiM/Flq10ehHmX5/ME+XTdL88yeHCiDnmY=;
        b=nj3j3mJf5vARfLBXfJfKypDGG/A2zRK+NDoJfYUwuyxm8EV1gdB6JnIZibmqRFYm1D
         A6qQymfG1rExex4987n50x1aJKl1w635lmRFsakgmYQhuMwbh54qURchHPnmw3OGg1a5
         TcylK6NKWZe3FoU+ZclvE6UmSBJXck1GQ9hOxo7laDh6sDE/3/UlTa8BvIaxGss2yXEJ
         DqAwWkLLnwKq0mWOzucFGn+gRaV9uXIQWP/wg2RMY3yQUtsQ1fnX87O0IasAJNzq/ze2
         VJ3DxOM3OVcnqrB/NRh2r4U/DeS6OqT56dL8qlWYuvHjIYzUVZjov5EsjcqDSyNDITiB
         +Mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQovpB62feiM/Flq10ehHmX5/ME+XTdL88yeHCiDnmY=;
        b=EKucvfDiA01V6szvgbWfC6MNzJfxZFQM7KwHlyNjVvbAZ2y/jdJiBl6PyDAWovl+Y6
         w7tiv8ReRc4c7T/mitVJeuYD1tQA42Ja31ZLk9X7pQeS9uLvCbcYCT2AqkOjaKjSn0+A
         aHs51BAPyu/klRyfbVwtFSrp94KAs2vxvPl2VSrsm1tcs6QD8JP8N9AtUSRDtYSi2zUq
         VDzvQikT1FfdfDmogjnzLjWOGfGLo0ycVQSSqY0osCqCpTw/vZr1ezoEsSfwtPm+qxjw
         RDBk4oLXTdcQQFsRYm1Xnp3LPX846y8d4seXykTRXdvRfEZpAKHW28ynKlFYMu9FMXlU
         Jz7g==
X-Gm-Message-State: AOAM531DgVNBRl6gA3Cp8449t3cpcxkaKKBh8zEXZ4weWuSBDujS2czr
        d4IOnMvOJ4VWmoCumTrBxTGhmRNDjNHbH0D38YCJjUPv
X-Google-Smtp-Source: ABdhPJzc9raLqo+uzp6IHrNJ/cibn5mp8G0VNZBH3LAufIZ69mRh8AcshotbvDFEzammyToxbH/khRbnOyaf1dMwMcw=
X-Received: by 2002:a25:3c84:: with SMTP id j126mr12033624yba.287.1590036604956;
 Wed, 20 May 2020 21:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200520052908.204642-1-walken@google.com> <20200520052908.204642-6-walken@google.com>
 <20200520202317.1f7515649dd711b388e40d3f@linux-foundation.org>
In-Reply-To: <20200520202317.1f7515649dd711b388e40d3f@linux-foundation.org>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 20 May 2020 21:49:51 -0700
Message-ID: <CANN689EcGjzBd+GnzG7ix=OU8EDrHi1xFk8E94_0Aspc+aD-LQ@mail.gmail.com>
Subject: Re: [PATCH v6 05/12] mmap locking API: convert mmap_sem call sites
 missed by coccinelle
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <Liam.Howlett@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        David Rientjes <rientjes@google.com>,
        Hugh Dickins <hughd@google.com>, Ying Han <yinghan@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good. I'm not sure if you need a review, but just in case:

On Wed, May 20, 2020 at 8:23 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 19 May 2020 22:29:01 -0700 Michel Lespinasse <walken@google.com> wrote:
>
> > Convert the last few remaining mmap_sem rwsem calls to use the new
> > mmap locking API. These were missed by coccinelle for some reason
> > (I think coccinelle does not support some of the preprocessor
> > constructs in these files ?)
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mmap-locking-api-convert-mmap_sem-call-sites-missed-by-coccinelle-fix
>
> convert linux-next leftovers
>
> Cc: Michel Lespinasse <walken@google.com>
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Laurent Dufour <ldufour@linux.ibm.com>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Jerome Glisse <jglisse@redhat.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Liam Howlett <Liam.Howlett@oracle.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ying Han <yinghan@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Michel Lespinasse <walken@google.com>
