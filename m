Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF3DC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE332072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598112919;
	bh=isMvzDNGOUiMNk2BIEA3QEi93PSQ3Y8CgtPqLIRZLZk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MX2XxJzbE4yZFDwfSWngOyBEJcBsgDjXdADOXhKZDhdTdd5vvlMETwz7AgDdge5sD
	 r4WIjXxJksUywZGqZOrCa9nziROHCLEhTzhTHTVrzbh7EeIYJYaCE0CVZ06ogJf/lQ
	 vBwV28GdBd8mdT1329wHqGN2EQKiEY/DKZFg+uB4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHVQPS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHVQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:15:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D1C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:15:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c8so2363550lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z361/QagF8IRa312xvMzCBJJ5mRG1KZKw3X9EJJOzvE=;
        b=USe4atxT1XGsmUmY4JfdNKlZap4kgabPBgLIVxlFlrZTNkT1blbP1Qe1piPCnR05M7
         LnI1nx4ew0ih5FZWnknrsgZJYXPZiz2ItoCnZhcYUSjLwHjxB9EPD68EGydBBEXDjr8/
         EU5dtBVxqqbT6L431sOPltWgOHKfxgirUbBZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z361/QagF8IRa312xvMzCBJJ5mRG1KZKw3X9EJJOzvE=;
        b=n0uwOCrAy9XxmiBNvL9Ex1AZpOrADIxXC82hfoU8oW0nfmUo7ODQXpQgpJDeF4bSjX
         e+8ApbiEMZ/JeRt51LiyE8DbZ9sI11255JtM88Y0eTpwskMnIQQBtY6+cvXvgTiJDiry
         /N5jSNx/tpnf/RTRiN//6qtevM1Wd07sN8JRRMVrgBKAdA0CW+c4zGwTEhFqGseYxtQo
         QSBwm68jueqUBbscyjnovz2wBU5ZEGgcGwK8OvYFDY0v467oJzR5S0Mga3SH6WmtvmNG
         IYbjT3svsblv3z9Uy/kEEqk6QJAThSaUFTTlb4If/oUpAJ4U3bChYOIp7zqBqf3c+yij
         qFTQ==
X-Gm-Message-State: AOAM532g6VZknnMYX53NpXOMAyYgWrqbiPGXvVqQovAr42ygcmdWQWVd
        wfjZiZ7ZWfU5InEumQelfb5LQG+itTmkXw==
X-Google-Smtp-Source: ABdhPJxGFQyR6X7jfGwNve2VYTk84FXXXS0mySEKqGAXYzOnBgbMhOrZ4CsqfT7EPLBmd5Jv9k7j5Q==
X-Received: by 2002:a05:6512:31c2:: with SMTP id j2mr3806248lfe.85.1598112910705;
        Sat, 22 Aug 2020 09:15:10 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id a17sm1076795ljd.123.2020.08.22.09.15.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Aug 2020 09:15:09 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id t6so5070696ljk.9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:15:09 -0700 (PDT)
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3483497ljk.421.1598112908980;
 Sat, 22 Aug 2020 09:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200821234958.7896-1-peterx@redhat.com> <20200821234958.7896-5-peterx@redhat.com>
In-Reply-To: <20200821234958.7896-5-peterx@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Aug 2020 09:14:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgchPHqevEZ1radW1vLHKGGSaq_SCVHKgxHmQt70OSSfg@mail.gmail.com>
Message-ID: <CAHk-=wgchPHqevEZ1radW1vLHKGGSaq_SCVHKgxHmQt70OSSfg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm: Add PGREUSE counter
To:     Peter Xu <peterx@redhat.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 4:50 PM Peter Xu <peterx@redhat.com> wrote:
>
> This accounts for wp_page_reuse() case, where we reused a page for COW.

If we do this, wouldn't it make more sense to also count the COW case
to see how they match up?

Right now we count faults and major faults. So as a result you can can
calculate minor faults trivially.

But if you count page reuse, you can't calculate any stats on it,
because most of the minor faults will presumably be for new pages
(either zero or cached file mappings).

So the "pgreuse" seems to be a counter without any context to it.

IOW, I get the feeling that either we should do this properly (and
maybe count "dirty faults" and "access" faults, at which point the
reuse case becomes a subcase of the dirty ones) or we shouldn't do it
at all. Creating a counter without any way to sanely compare it to
anything seems a bit pointless.

                Linus
