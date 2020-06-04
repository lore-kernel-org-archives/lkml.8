Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546A1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 216F6206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 14:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QXaWkkQ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729069AbgFDOhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 10:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbgFDOhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:37:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24151C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2tvTdBck+ipf49OrMMt2ID3t3c6rSt/FosoZQVmo6lI=; b=QXaWkkQ9W/7uhY2gfBDCuwzj9L
        tYy1piQFt6GyXU/d/dEHEGHrDnmPub8Y3w1q7JTiOaeQPNxH6XfXvc7ct6r6wBYoxpKx1VhZISar0
        anU90/gpPgCeC1Gai18N1PHhfj8t18wZGH2KXx2D3t5exAfu483smEO17ocXOlCUUm83Ww11OBKQB
        fhF53MhuPP1QRY7pojHGiOOTsRUSQSuxkE7iyJ3QwhCugTFsBrPDJTqS6uazE483Ob5CWasO0VT0T
        nXPBS8c4yUtxexFr6BSshdEkBcykFI5fvHfppl5IW9ho2Ps0UgGwG3ytvwlRA6CMYafj7qG0PHDYV
        jxJIZ6KA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgqzQ-0005iR-Kq; Thu, 04 Jun 2020 14:37:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F99C301ABC;
        Thu,  4 Jun 2020 16:37:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 20B3720E06071; Thu,  4 Jun 2020 16:37:01 +0200 (CEST)
Date:   Thu, 4 Jun 2020 16:37:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip] kcov: Make runtime functions noinstr-compatible
Message-ID: <20200604143701.GC3976@hirez.programming.kicks-ass.net>
References: <20200604095057.259452-1-elver@google.com>
 <20200604110918.GA2750@hirez.programming.kicks-ass.net>
 <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAeHK+wRDk7LnpKShdUmXo54ij9T0sN9eG4BZXqbVovvbz5LTQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 04:02:54PM +0200, Andrey Konovalov wrote:

> > Now, luckily Joerg went and ripped out the vmalloc faults, let me check
> > where those patches are... w00t, they're upstream in this merge window.
> 
> Could you point me to those patches?

git log 7f0a002b5a21302d9f4b29ba83c96cd433ff3769...d8626138009ba58ae2c22356966c2edaa1f1c3b5
