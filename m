Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B66FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AD642224D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 14:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbRJEWvy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHJOxK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 10:53:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45974 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726528AbgHJOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 10:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597071188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q9TqSnIMVwxHy1nFrUyMg9B9EzCfp0PQ28lqABt/29c=;
        b=WbRJEWvy6RidJkmhaCJfV65m/mbA5cjJdSGNbqEvw97mau8aSxBzf3t3utMoyPQy55Dp3b
        ln+fLOCSl2FwY9XAZYev0B46XnvJ2CgMo+1X/BFq2A4LLSzztG2rpqZqEy1lX8zAhI9diX
        Vsv+SMbkotrs9WZzi+utJGjSR6zCKPk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-tN_RNI5bP4q3jikMuyMQxA-1; Mon, 10 Aug 2020 10:53:07 -0400
X-MC-Unique: tN_RNI5bP4q3jikMuyMQxA-1
Received: by mail-qt1-f197.google.com with SMTP id b1so7602083qto.17
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 07:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9TqSnIMVwxHy1nFrUyMg9B9EzCfp0PQ28lqABt/29c=;
        b=hqc8oIwsoJvgly/WfsLEXDbD0omXGaeNWR36QptYslkuxzzzV42XyUfCpLJybL+h+a
         KOK77r5Vcf+g3c++zF31anZE6XzsjJG48pDPSWHX8F5cX2pVjodoQkcnV1CpQXvRool4
         eczUi025fBAEM9DmD5Yv0t1zxQf/uNTuk+ibQjTacjAWbx5eAp+ZySUQH/YtYHtU1SWS
         KOfmVUJ1z2EUQfPGPadPwuEHDz92hHdL7TtJJ6Pr2ZGdF1KkmQrtbfOxwFZtp3MyjUwd
         GW27OPPvebge4MPK2Li4NyusQeg+9hG9I4fldID8BgNKhfOUcNHR614edtKcn3uqoDkd
         djOA==
X-Gm-Message-State: AOAM531OJXoMZqI02tELrctA4wt2+RjlRSdD3ZjGJOVvRja6Zqrfy4hh
        4j/qD40m/CSwZ0dnLZZND4GD5UrUCK7ByD3h7PN2b6dcqOTBIO7ys6/xexdHd74QJihzJuHjceG
        ixSNFfvm9lDYaU9QsYgu/MmNC
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr29209732qvo.178.1597071186712;
        Mon, 10 Aug 2020 07:53:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx35KSUYtVpyur7/ktMciwY/MrlNHdD5p6sLrBAE56nAd6pvBUCzhXIljMTe+dNVHg9NAJ28g==
X-Received: by 2002:a0c:e8c9:: with SMTP id m9mr29209706qvo.178.1597071186495;
        Mon, 10 Aug 2020 07:53:06 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id y7sm16728866qta.36.2020.08.10.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 07:53:05 -0700 (PDT)
Date:   Mon, 10 Aug 2020 10:53:03 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>, Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] mm/gup: Allow real explicit breaking of COW
Message-ID: <20200810145303.GA16451@xz-x1>
References: <20200808223802.11451-1-peterx@redhat.com>
 <20200810122419.GA19656@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200810122419.GA19656@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 02:24:19PM +0200, Christoph Hellwig wrote:
> This patch only seems to add a flag, but no actual user of it.

Oops, right.. I'll repost with below squashed into it:

diff --git a/mm/gup.c b/mm/gup.c
index 6f47697f8fb0..9d1f44b01165 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -870,6 +870,8 @@ static int faultin_page(struct task_struct *tsk, struct vm_area_struct *vma,
                return -ENOENT;
        if (*flags & FOLL_WRITE)
                fault_flags |= FAULT_FLAG_WRITE;
+       if (*flags & FOLL_BREAK_COW)
+               fault_flags |= FAULT_FLAG_BREAK_COW;
        if (*flags & FOLL_REMOTE)
                fault_flags |= FAULT_FLAG_REMOTE;
        if (locked)

Thanks,

-- 
Peter Xu

