Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EE2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CF1206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mb7bMxo7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727021AbgHXAYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 20:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43622 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726737AbgHXAYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598228656;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCADZNh/J/32boJoS2MavSc2bQ2MKxckveY0wBleR1o=;
        b=Mb7bMxo7xVUrj1AGEI9d4aJ0bvBxIfIF0Zqs2UXiWroShWGyz4NzLqOmkLeFbrWhwdRxX2
        dAaayhfbwy469aVbRT6zuiEreo49Rx3GKBLh8k3/KxLRqD0uD4sz94tvt9Lil6NUpLzpr9
        j/IC9OWL97fwuiH6x1ULPez1YFedDls=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-1hBX7jA1N3GJXvpHjPzsmQ-1; Sun, 23 Aug 2020 20:24:14 -0400
X-MC-Unique: 1hBX7jA1N3GJXvpHjPzsmQ-1
Received: by mail-qv1-f70.google.com with SMTP id q4so5235221qvu.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 17:24:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCADZNh/J/32boJoS2MavSc2bQ2MKxckveY0wBleR1o=;
        b=YE4lYr7UvTM7PZI3TW5gbp5iShupyik0YLPPENFfNBxGyodfKUWxTDFUC7RY/9IvEw
         b+qDLXr09xcgI3BmxKbOEncHWmKjqdpw9zoK1pNdo4MRDPGOVHM7rQa/Vg2ObPnwzook
         yx6Ro2evzIGyAuVtrP6aUuaEujglTPsQWgVwdfIdQneQRuf2pzva7O8nFijzegyJ5f+m
         DMNCy1SuH1CxzNveOnNMn2mP1m/Du2CD6DUNtuGm+yJxKFd93jmwf7K+QzMqc2cHmq01
         SClT/cec2j2viQtvbzJ6PS+T1uhmshf53yCRJ0AUBmZ1bdHybyeBdFxkppYhXtvJBhxe
         7J9A==
X-Gm-Message-State: AOAM533q2kYNFgHIGplLTjPw9bBP2wt5Xgj5TM05+ZL7XsbR9BLtTlAf
        CEuXLfGfxNO6As/buNBW+6OmiRDixjJt4Bl6Cz9lRr5wwPreNUUZXjrBBQ51Cen81fatfrR6jKU
        5uJsulWQlH7VQVEZeF1QicpkJ
X-Received: by 2002:a37:6193:: with SMTP id v141mr2721369qkb.94.1598228654215;
        Sun, 23 Aug 2020 17:24:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzkcTolph1Y5YpkQJT+t0zUoDh4CQuIN98lIrZp0YWFuOexKcrn7yV6gBF7cIru30yYY3y13A==
X-Received: by 2002:a37:6193:: with SMTP id v141mr2721350qkb.94.1598228653981;
        Sun, 23 Aug 2020 17:24:13 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca. [70.53.122.15])
        by smtp.gmail.com with ESMTPSA id a15sm6827522qkc.29.2020.08.23.17.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 17:24:13 -0700 (PDT)
Date:   Sun, 23 Aug 2020 20:24:11 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 4/4] mm: Add PGREUSE counter
Message-ID: <20200824002411.GB6231@xz-x1>
References: <20200821234958.7896-1-peterx@redhat.com>
 <20200821234958.7896-5-peterx@redhat.com>
 <CAHk-=wgchPHqevEZ1radW1vLHKGGSaq_SCVHKgxHmQt70OSSfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgchPHqevEZ1radW1vLHKGGSaq_SCVHKgxHmQt70OSSfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 09:14:53AM -0700, Linus Torvalds wrote:
> On Fri, Aug 21, 2020 at 4:50 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > This accounts for wp_page_reuse() case, where we reused a page for COW.
> 
> If we do this, wouldn't it make more sense to also count the COW case
> to see how they match up?

Is wp_page_reuse() only used in cow?

I saw that the callers of wp_page_reuse() are:

        (1) finish_mkwrite_fault
        (2) wp_pfn_shared
        (3) wp_page_shared
        (4) do_wp_page

Since (1) is only called by either (2) or (3), while (2) and (3) apply only to
shared memories, so I'm kind of sure the statistic is done via the changed path
in do_wp_page() that is touched in patch 1 (my program was using private
anonymous pages).  Maybe I missed something, though..

> 
> Right now we count faults and major faults. So as a result you can can
> calculate minor faults trivially.
> 
> But if you count page reuse, you can't calculate any stats on it,
> because most of the minor faults will presumably be for new pages
> (either zero or cached file mappings).
> 
> So the "pgreuse" seems to be a counter without any context to it.
> 
> IOW, I get the feeling that either we should do this properly (and
> maybe count "dirty faults" and "access" faults, at which point the
> reuse case becomes a subcase of the dirty ones) or we shouldn't do it
> at all. Creating a counter without any way to sanely compare it to
> anything seems a bit pointless.

Yeah I haven't thought deep about this statistic, imho it would be something
nice to have (besides helping me to verify the tests) so I still posted it
instead of keeping it in the local repo.  If this statistic is not liked by
anyone, then we can definitely drop it.

Thanks,

-- 
Peter Xu

