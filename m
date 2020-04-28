Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF49C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF678206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 03:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588046358;
	bh=1IXxGa91emG7hgRc3PxbmCiaIe6KSK/m6RIHO5u6QpM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R4pRhdyuYT/xD9Rh/3je2ZKv8jMW4gphq+GvgiLej+K4VIPThjmNhbl6UwgJln00T
	 YW3TqtnJjVlyjixQK7VXN93BmqywpaK0oL8UQCT3X6990mTMB1lm0XmUFhw/6N7XTr
	 uU2eC2XnxUdjG7CqxH7mu/Mz/P0x0568ssOvUJiU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1D7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 23:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgD1D7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 23:59:17 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D44C03C1A9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:59:17 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id l19so19926612lje.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVBS2zR8u10QnId+SjIws+E/mbDlgxt11FVLpUCy9Fk=;
        b=fSI/ijUiq7Zsrz+mYpIid9wBMr+ufvXZJdEGYfYAV6Wa7WrfJcI8pP8JyJG39ryg8H
         oS3R8qQuk5cLe0fU2CCWNj05+kTTXNRrrHruAKyDUm0TOEQcvdS9B6OBB0/HcU2kGNsZ
         OclGbGyiNhfGDIr+gFIj8hC2fmRzB7XJRVfjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVBS2zR8u10QnId+SjIws+E/mbDlgxt11FVLpUCy9Fk=;
        b=M/LerMAol63W7J6vL/n6k8090ptK/wQ8iWo4WvXACTyR4/bkWiMlo+D7HcVgfMJAYr
         /pZXfAoqdS2EF1KziHF2/sFyV7sWizxz8fbW4XfwRpPhxCJrjxfCR+GrTF/L/CaY3j3r
         f2LQtExaL+eXel8nd2cDhzpbbHrp1lZcsjmzFLYOp8c1RODMbmDysPG+7fcbeUsG0y9W
         SLc3CAvjB3ZPobD1xzCUEaDeOxjk8ElKA2N+WzcsVAa2tc+Fxts1zrmsdi1SB0CJ/KOH
         EWUL7NV6lOsv4DaMGG3ezNSqPqc+cjevsuNHOE4ylifxpUbXI4Wg71G4M2cqtOMgArdz
         Y6hg==
X-Gm-Message-State: AGi0Pub3bN5meCH00WfGzvh0gyKht/UfdQ1pVCrbozMX9FKZQydBwVBF
        lScag5p+3HBXQACkYO+PhLitFKwV1Ys=
X-Google-Smtp-Source: APiQypIdCRIqJ1tbT0EYNXz6SfBYQCorTWZKBj7GxgwmYQeim4lGGVSBF+jNOjc1mz3rjGJHdrOBug==
X-Received: by 2002:a2e:96c2:: with SMTP id d2mr16874214ljj.214.1588046355165;
        Mon, 27 Apr 2020 20:59:15 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id k11sm12958668lfe.44.2020.04.27.20.59.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 20:59:14 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id t11so15653501lfe.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 20:59:14 -0700 (PDT)
X-Received: by 2002:a2e:7308:: with SMTP id o8mr16201494ljc.16.1588045856507;
 Mon, 27 Apr 2020 20:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200428032745.133556-1-jannh@google.com> <20200428032745.133556-6-jannh@google.com>
In-Reply-To: <20200428032745.133556-6-jannh@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 20:50:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
Message-ID: <CAHk-=wgBNSQhH1gyjo+Z2NFy4tOQnBQB4rra-jh+3XTpOjnThQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] mm/gup: Take mmap_sem in get_dump_page()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 8:28 PM Jann Horn <jannh@google.com> wrote:
>
> Properly take the mmap_sem before calling into the GUP code from
> get_dump_page(); and play nice, allowing __get_user_pages_locked() to drop
> the mmap_sem if it has to sleep.

This makes my skin crawl.

The only reason for this all is that page cache flushing.

My gut feeling is that it should be done by get_user_pages() anyway,
since all the other users presumably want it to be coherent in the
cache.

And in fact, looking at __get_user_pages(), it already does that

                if (pages) {
                        pages[i] = page;
                        flush_anon_page(vma, page, start);
                        flush_dcache_page(page);
                        ctx.page_mask = 0;
                }

and I think that the get_dump_page() logic is unnecessary to begin with.

               Linus
