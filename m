Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13B7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D74420787
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586213679;
	bh=wRV7YAY98sYhAKukUD1dijKDGjhJ0KcfEsGpp4oZP7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z2DSj5XhLMv5QmC+apww0l24nMLM0mvLG0T9kJM1CKZe/8AP9xleiYLuh86cVlskz
	 sbrfbuUK2gpc/Kvww1LCquvhA536Hyhn449H1dQ7o+e2KsHbNgf9MKIRSqLYSxTn+g
	 U0z7d5rnVP7eEASYehLiv0a4iEEcBZ39SJx6MHoo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgDFWyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:54:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgDFWyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:54:38 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02F2A2080C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Apr 2020 22:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586213677;
        bh=wRV7YAY98sYhAKukUD1dijKDGjhJ0KcfEsGpp4oZP7Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xme1q/fTkimi/YRHPtRcNB2y/4Jw/KM+RFzQATkGIVheH5m4VJvKVUTqXqKGGxzll
         15uWFSw79dF198qpg34D/YXAFSjzv7htd8sopjXQdwrIPH5RmqcoxIBpNPmMNKw5mb
         mpeSy4ilsoe+izd3NsEgUY0409cQb/XyrpMaTxrI=
Received: by mail-wr1-f52.google.com with SMTP id 31so1566636wre.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:54:36 -0700 (PDT)
X-Gm-Message-State: AGi0PuYC/UG8HQM+jY/kgc2LirhPYeDuZL2gVlWIoFGgAT6V06N5DnQQ
        kpkpzysP7y+AYK3WgwgE7oIg8Zz6nBS4VC7f4ZU5sQ==
X-Google-Smtp-Source: APiQypImmf3zpzAJUpsgMcXL39iTGPv/ksypgpjR4cere/f8yMmJUIOE+7J1L+nyJYYpiBlradvcxIBKL5YNVgUxip8=
X-Received: by 2002:a5d:460c:: with SMTP id t12mr1534701wrq.75.1586213675349;
 Mon, 06 Apr 2020 15:54:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200403163007.6463-1-sean.j.christopherson@intel.com>
 <20200406125010.GA29306@infradead.org> <20200406140403.GL20730@hirez.programming.kicks-ass.net>
 <20200406152411.GA25652@infradead.org> <20200406153902.GA9939@infradead.org>
 <20200406160157.GS20730@hirez.programming.kicks-ass.net> <20200406171058.GA5352@infradead.org>
In-Reply-To: <20200406171058.GA5352@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 6 Apr 2020 15:54:23 -0700
X-Gmail-Original-Message-ID: <CALCETrX-OccmPmJw5cXQEVb0d0OuJGmK_9vsf+dGo6Kqkp+7FA@mail.gmail.com>
Message-ID: <CALCETrX-OccmPmJw5cXQEVb0d0OuJGmK_9vsf+dGo6Kqkp+7FA@mail.gmail.com>
Subject: Re: [RFC PATCH] x86/split_lock: Disable SLD if an unaware
 (out-of-tree) module enables VMX
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Laight <David.Laight@aculab.com>,
        Doug Covelli <dcovelli@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 10:11 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Mon, Apr 06, 2020 at 06:01:57PM +0200, Peter Zijlstra wrote:
> > Please feel free to use my pgprot_nx() and apply liberally on any
> > exported function.
> >
> > But crucially, I don't think any of the still exported functions allows
> > getting memory in the text range, and if you want to run code outside of
> > the text range, things become _much_ harder. That said, modules
> > shouldn't be able to create executable code, full-stop (IMO).
>
> This is what i've got for now:
>
> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/sanitize-vmalloc-api

You have:

 mm: remove __get_vm_area

Switch the two remaining callers to use __get_vm_area instead.

The second line contains a typo :)

Otherwise this looks pretty good.
