Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F100720716
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 21:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597093206;
	bh=/EApQc1y+qMeZHuAQ9GQLJayac33NATwUwPS05wX/yY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Q2WJzTeZ45kLDrS7eneaWQnxhoDwtWpXPgfZy2RHRQ0x1mlMLoaCD4BzPVCGzHCn0
	 cRDdQ6e0uL76u/3EX/NHuiy3C1+ojq9RRWDdrKcZ/1P6DK0NoFk4uzytPUJguIDjR4
	 72gVEZmb9LH183FC0o0ByjpnA2zDjM3oosOz9fBY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHJVAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 17:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgHJVAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 17:00:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02386C061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:00:03 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id v12so11128430ljc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XE964JtRrnbPzfIgw8hsWmmkQxF1l3PNEIiQ473glW0=;
        b=XU6kgKTA0t5S71cshC71mRLr/HfDgId3V8TMmACRiw0cuP1gZncd1Ngb4/aY/gO0eY
         3mMsXFyAQAmST2ZzCR/3z63Bh/JP8VBzZEahUMBvHS2bN3lACs0/JP7UKaJrWg4mpNVQ
         pZjUEfg0Q6fp1/zeQpr1PkhEuepxiGxJcm6wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XE964JtRrnbPzfIgw8hsWmmkQxF1l3PNEIiQ473glW0=;
        b=NzdPfNDNBZsLqW6wzKH/ub6IpmLCpLz4PVJb7WwRERLLCT5fGrvQgGf9JLNyr7Ag7O
         np7UlvtgRRw9+5l4nsl0OVMjm0aTgvBj1McJ8Tm0odeX7A+Sh0jQfEaxsXVtVNGGjyDJ
         srNiLXgk3xGypgAjL6JEgWfdHpBEW/Aex0PDtZaOt/MMes2/cPEgXNVBMbH31S+xjj87
         NLggJ2AfaIvMMnWgcKJylYiO52q6QBn95w8YM0lyIiVu6ZFO2nV1M89npkp16i/Hl5Mt
         5NQVd0H1pcLfuxLO54MVTGuky4jHSY5FyTnBaq9R/WBBvWt/bUahsKxIZ5/uOq8J+pwy
         YK2g==
X-Gm-Message-State: AOAM531dByqY5F5vGBtHEd+/IOas9AZ3t5fk6Xi93JHFrsYHhVrWsDe/
        Z+daR15PzyCBrCM2i2v7tlXkiXtnXzI=
X-Google-Smtp-Source: ABdhPJxBFfnVwnJMc/cRPRY5twwVAkdEz6b11rzRhI4m9oFBVgQLAtgVEqFF9xRIHGutvTYpx2stQg==
X-Received: by 2002:a2e:9396:: with SMTP id g22mr1533698ljh.446.1597093202041;
        Mon, 10 Aug 2020 14:00:02 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id c4sm9604471ljk.70.2020.08.10.14.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 14:00:01 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id z14so11179897ljm.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 14:00:00 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr1353407ljc.371.1597093200342;
 Mon, 10 Aug 2020 14:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200810145701.129228-1-peterx@redhat.com> <CAHk-=wiSF+aKhDOewxQGCGUPyGnA=K7OtAczL5M7aisA5mgFzg@mail.gmail.com>
 <20200810191520.GA132381@xz-x1> <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
In-Reply-To: <CAHk-=whUVHA-=4mwGaUA42teESc2mX1nwZjbbOMQsvPaoYxh3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 10 Aug 2020 13:59:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgyF30ap_tREfey7J9w0MyYDxso1ui-e98U0yYi9pPmhQ@mail.gmail.com>
Message-ID: <CAHk-=wgyF30ap_tREfey7J9w0MyYDxso1ui-e98U0yYi9pPmhQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/gup: Allow real explicit breaking of COW
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 1:51 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> See? That's the whole point. It doesn't _matter_ if you're only
> reading the data, without the COW you may be reading the _wrong_ data.

Example safe users:

 - if you hold the mmap_sem the whole time, you're fine

 - if you only look up the page mapping for some tracing reasons, you're fine

 - if you can explain some other reason why you don't care that some
other process might be changing the data from under you, you might be
fine.

But the point is, you need to _explain_ it. Not just say "I don't want COW".

                  Linus
