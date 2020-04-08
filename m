Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E42D0C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B970B206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 01:25:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CrKM7ZbT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbgDHBZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 21:25:44 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:45448 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726407AbgDHBZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 21:25:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586309143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lM7goQi5iDZRKfqm5MbWtS0yDwFe6ni2YZ0TOqXzILY=;
        b=CrKM7ZbTTKrS6gVMHmByfM+51rvi4BAsexYCm1yIOJB7h2xePaO2LOj2Sg/ChugXgIARPB
        6JrNMQXJ0GwuOdWmlQHp2p0GCx5Acl5AFrlZtyV5mVBH61bJxWwQWZrSS6uSMltcK7dDUx
        uHgIbph2GLjCN6IyW62it2MueYJqTzU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-uy93qyq7NkaKwtalbL9lNA-1; Tue, 07 Apr 2020 21:25:41 -0400
X-MC-Unique: uy93qyq7NkaKwtalbL9lNA-1
Received: by mail-qk1-f198.google.com with SMTP id r64so1346494qkc.17
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 18:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lM7goQi5iDZRKfqm5MbWtS0yDwFe6ni2YZ0TOqXzILY=;
        b=W47OWUfSJL99KwF3RU4sOtk83iCNywJOQ8exg8KzkvzsHQC9FcYB+VMGWVk3/L1BKU
         +PGXF7i6PFa/Ij8WoML1FheNDSnqcXppY17/zOWv1ETQm9xNxP6aDW/UMBUuLRtp28f0
         rzaWUocO4kaV83oxvuaoDxBSfgINP+7jruZTBDgfftZUy6b1P+TEd46C7npkNE4Sa2mI
         Q/nhMj4jfWQ3hbQX4bHN9ZBHQ2yNlrTkx+FyK0HyZv8Ir1uxTqauIFbXqkJfhKinMMVy
         qFUJVyeFvJ1cOOlYeHxuTuWaYBn3CJkv3wOfQ59AXYTdXfGnD+hDgJfOjt+WY7NdLbsm
         dgpg==
X-Gm-Message-State: AGi0PuY8WA3dcTdRRIpXLW2rnuHirDM7Ee0qYV1QPCgR3ULhgUXdVX3O
        kf6WMLMq1RYStFeoYcLDxspV8juBC6bt4dGmO2nS6ueeTLiPd8ETp9nqXqbdqzLU4GS6w5q8q2q
        eWcmG3ZVXkN8Rky0OX3PkzVvp
X-Received: by 2002:aed:2e07:: with SMTP id j7mr5312117qtd.40.1586309140582;
        Tue, 07 Apr 2020 18:25:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypLgUqE+QHH3SuksCDeKtpWwmj+2h4BnQPxOzlmzsRUG0L7NoQHj2y0UA6ks4SwMpFr9ptJdsA==
X-Received: by 2002:aed:2e07:: with SMTP id j7mr5312093qtd.40.1586309140263;
        Tue, 07 Apr 2020 18:25:40 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id n67sm1479346qke.88.2020.04.07.18.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 18:25:39 -0700 (PDT)
Date:   Tue, 7 Apr 2020 21:25:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     syzbot <syzbot+18638e81a805a2d96682@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brian Geffon <bgeffon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: BUG: unable to handle kernel paging request in
 get_pfnblock_flags_mask
Message-ID: <20200408012538.GC66033@xz-x1>
References: <00000000000018a92305a2ba57e0@google.com>
 <20200407220837.GB66033@xz-x1>
 <CAHk-=wjQJQM=V6CDPrU2FJVEi4zZsr8-w8a0We8tF5K66J_ZOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQJQM=V6CDPrU2FJVEi4zZsr8-w8a0We8tF5K66J_ZOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 05:04:52PM -0700, Linus Torvalds wrote:
> On Tue, Apr 7, 2020 at 3:08 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > Thanks; I think this is a dup of previous one too:
> 
> Peter, since the two nasties are both fairly bad, would you mind
> sending me your two patches and I'll just apply them directly.
> 
> I've seen them fly by, but I think they both happened inside the
> threads discussing the problem, and I'd much rather have the final
> patch sent to me explicitly (with confirmation that syzbot tested them
> - again I _think_ I saw that fly by too, but my mailbox is fairly
> chaotic..)

Sure, I'll post a small series very soon with the two verified patches
formally.

Thanks,

-- 
Peter Xu

