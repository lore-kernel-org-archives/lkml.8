Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D47C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C458A2065E
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="fdRk2pV/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730702AbgIDN5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbgIDN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:56:55 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F0C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:56:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so6821394wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3CfhOVBGf9H9WuZ53+AjLGNuQZrbQHmVtlD/DJasis=;
        b=fdRk2pV//7myN++zX937AgchN/lF0cwlO5vO83mfaGxBG4q2HNIp6zqYMK+Zt8XOrY
         NjIrgYIWeNUh7JSDxmG4kHraRhjqpHbzpktsGfa+SbGMh8a1sbPyoF7IpXSqtyfgCZgb
         FjYvTaKTlO6LYbE6ZfU35PIcl9HijlW13E5wiZ3iwZzpaAqnbWl0F90OQZckY/wZU1gf
         A7VBE9ubp+vKLCJg6fKumSbKRAtz1MrQAzug3FVEuNdgU48dFmCQgmCLn7cJ0gcWBPA2
         7tqETp6BTfcc3ari0Ghn5Ue2uktePy4RJzl6OEpDYyEMYCo7NS+BaGeEN2Hb/6BUmrOC
         /SQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B3CfhOVBGf9H9WuZ53+AjLGNuQZrbQHmVtlD/DJasis=;
        b=DuQjmLciBdahbgniMOva/Uq2pYAznn1HyMaPByrMIKdxRL2vbHWxKVzL/Ex7gIx4lC
         7o56lYi/VEXS5P+wUcnk12I9RvyJKjZooVcO5j5UcFRcnwR7OL1swJLfPA2hD7LgYYwx
         jTz08vQLfgvVi0H/TSmfYgkY3/5WYf5T0esUu0z0hQZFqnJQyo8CyPLK8ARBiyUr4IFQ
         JaHQ7VTbgNG5YbhxhSQtsdravPJafpNR/CN9gvSkgNuDgoPbkIqd84itOUfD7lqWml7Z
         DtPB6WtAcnQDWvSU+/ilUzs2vW27mxv8YRxAQMf0tcRr226dpOGrK3ZKK5xsP8ebvzWN
         FlFA==
X-Gm-Message-State: AOAM533KyfcbqaAQ7BSXRSJ/mzc00aBEyN/5cOcrc8FGkd0oTa5TTE6b
        0v+wMIlYNJCLAeIYtsxuinBvFSzk+ooQqYKtJxtjT0pYQ6Q=
X-Google-Smtp-Source: ABdhPJy/VGdC6pW/0FhrX+k0bZPZot8TzrPX4TwKJOQtaQsxu0J0wg1pUbQsc0YgMyp5M+kryqPhp8FcaB2m6mL+Fk0=
X-Received: by 2002:adf:eecb:: with SMTP id a11mr7878596wrp.356.1599227813312;
 Fri, 04 Sep 2020 06:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-32c8d053-acbd-4c72-b41d-8d6042ac639d@palmerdabbelt-glaptop1>
 <CAHk-=wi_tf4qsiBj5UD0GG3wz8Hi5NrHzqdrx+CwtfAY+_UiGg@mail.gmail.com>
 <20200904083109.GA9182@infradead.org> <CAAhSdy3S8FfMAWih_VoBHw0xd-7c=urzuJ+PPdug9iX_pWyTsQ@mail.gmail.com>
 <20200904094617.GA27846@infradead.org> <CAAhSdy2x0ROqoTzzZRZgKCTL99WPy-8e4CQ921sf-=GQDm_gxA@mail.gmail.com>
 <f1be6ee1-0802-82ca-ffdb-4c294925cd9a@kylinos.com.cn> <20200904130044.GA7842@infradead.org>
In-Reply-To: <20200904130044.GA7842@infradead.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 4 Sep 2020 19:26:41 +0530
Message-ID: <CAAhSdy2N8L015z0-RirjXLjdzt+OrCtzzKzivsMeQXoH9Nc8Cw@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Fixes for 5.9-rc2
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 6:30 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Sep 04, 2020 at 08:58:25PM +0800, Qiu Wenbo wrote:
> > I can confirm this patch also breaks K210 support. It seems that
> > csr_read(CSR_TIME) will trigger an illegal instruction exception on K210.
>
> CSR_TIME is trapped by just about every implementation I know (which is
> explicitly allowed by the spec).  That is why we should never use it
> from common M-mode code.

Finally, I was able to replicate this issue by manually hacking QEMU to
not emulatie TIME CSR for virt machine.

It seems this issue is only seen on older QEMU and Kendrtye K210.

I am working on a fix for this issue.

Thanks for reporting.

Regards,
Anup
