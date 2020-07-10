Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C880EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A472B2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 11:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="lJv7SRzZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgGJLA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 07:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgGJLAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 07:00:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E018DC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 04:00:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so5981993ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 04:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=EcXb80b30+tpFcdAM3LkbXH4OtvQdy0dqwPo/8t73Kg=;
        b=lJv7SRzZvI52d/GkPLIWxZELIIqVT+/yUEvPHEZM++z5EjEIgVM1Q9PbOahTy8nLz+
         jXUpfCbkx1kO0P1DFNFGgDQcxfr+Asvm+l1KRytTFKB6sJb/OQdZqA/F+F9IMCviIATT
         rnm6SYJqjXcE9rZUVzgDzM0JNbT/z1KImQ9HhXBgWgy9fqBsaWR1LkSHvEB6TFE19YNg
         DqLZMwgYRGi9Q6NReAmqqCNEB/GY0W4qJB+gUuGIMbu/HlMMUfYsLRagelH/LLFlFfqQ
         FIYmhiBqw9T5Mw8cQ+C03NO05h9sIW9Jd0TsShukw0edOombPiOI0e9z5iP1lWkndvY9
         DKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EcXb80b30+tpFcdAM3LkbXH4OtvQdy0dqwPo/8t73Kg=;
        b=N3PaEBefSmU8AI5nM+lAZfjLrUton+TUdbUJh4iroRdKFWSQuz0H4CX7CY6QMfaGs5
         mgpnMc+jjsfdaVfQTDVtVYewRILQKZYcQPTspWnewMjXUhiWoqZYR5SRNwA5h+DoPR5U
         8KXC4rco8bNP7kXgr8Qieedfn2CdiLW/yPxnYpMtfe2XD1ivypcvE6bxqCPyUBbW1cTg
         VONCqcegY9ip+tG982KBNwjWQiPZ24e53E3bzvJ8+I0va9hY0DIp7h08TML4mYTcljXD
         mW5utNhIc4RnDUcCgP2RCNhPwbjuisVtgHYCaERkZGbDYkvpfcDowqK+FRI+/r8GINuX
         6hbw==
X-Gm-Message-State: AOAM530Yq0/96qcF4pbZAtvqualA+ndQCFXbS1pLb3/1pX7W9o3jWSPC
        6FjTsVOUkJfBviy+AbE/6yLp0A==
X-Google-Smtp-Source: ABdhPJz4WZbU5C4FhPBXfdsSPpIyNA3SNZczQAfzocvErK+Kz2A3rFV0UWXcHpqjcCVyU/WFLrPW2g==
X-Received: by 2002:a2e:7c07:: with SMTP id x7mr29045507ljc.166.1594378833261;
        Fri, 10 Jul 2020 04:00:33 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id g7sm1800509ljl.7.2020.07.10.04.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 04:00:32 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 712EB10222B; Fri, 10 Jul 2020 14:00:34 +0300 (+03)
Date:   Fri, 10 Jul 2020 14:00:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [GIT PULL] EFI fixes
Message-ID: <20200710110034.zthb7lctf7xwj2yt@box>
References: <20200628182601.GA84577@gmail.com>
 <CAHk-=wgD+q+oDdtukYC74_cDX5i0Ynf0GLhuNe2Faaokejj6fQ@mail.gmail.com>
 <20200708162053.GU4800@hirez.programming.kicks-ass.net>
 <CAHk-=wggLLv8dY7ViOm7rdHxVNKJUkZMuR90vXO307WkBT8qrw@mail.gmail.com>
 <CAK8P3a1GFjM5-ENf7XL6jjUvRdJhgjzYpSGD5R7TmW6oWEhYRA@mail.gmail.com>
 <20200709103459.wenqhbp52vesr7e5@box>
 <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Cd30gthLj-Kw8dsNa2Cse3YfUs9q8c=nc7fHtQ-QLSg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:09:36PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 9, 2020 at 12:35 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Thu, Jul 09, 2020 at 11:30:27AM +0200, Arnd Bergmann wrote:
> > > The most interesting version to require in the future would be
> > > gcc-7, which IIRC is the point at which we can just use -std=gnu99
> > > or -std=gnu11 instead of -std=gnu89 without running into the
> > > problem with compound literals[1].
> >
> > It is gcc-5, not gcc-7. This commit:
> >
> > https://gcc.gnu.org/git/?p=gcc.git;a=commit;h=d303aeafa9b4
> 
> Ok, glad I was wrong here. I confirmed that with gcc-5 or higher I
> can build a kernel with -std=gnu11 or -std=gnu99 instead of
> -std=gnu89, but gcc-4.9.4 fails with anything other than gnu89.
> 
> I forgot why we care though -- is there any behavior of gnu11
> that we prefer over the gnu99 behavior, or is it just going with
> the times because it's the right thing to do? All the interesting
> features of c11 seem to also be available as extensions in
> gcc-4.9's gnu89, though I could not find a definite list of the
> differences.

Last time (llist_entry_safe() thread) it came up due to local variables in
loops feature that is not available for gnu89. Both gnu99 and gnu11 is
fine. Maybe we should leave it to default for the GCC (gnu17/gnu18 in
gcc-10).

-- 
 Kirill A. Shutemov
