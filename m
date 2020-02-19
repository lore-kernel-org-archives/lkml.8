Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C9AC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3346C24683
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbgBSTnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:49514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSTnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:43:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C84207FD;
        Wed, 19 Feb 2020 19:43:35 +0000 (UTC)
Date:   Wed, 19 Feb 2020 14:43:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH 3/6] tracing: Wrap section comparison in
 tracer_alloc_buffers with COMPARE_SECTIONS
Message-ID: <20200219144333.1ce3f9ea@gandalf.local.home>
In-Reply-To: <20200219192249.GA8840@ubuntu-m2-xlarge-x86>
References: <20200219045423.54190-1-natechancellor@gmail.com>
        <20200219045423.54190-4-natechancellor@gmail.com>
        <20200219093445.386f1c09@gandalf.local.home>
        <CAKwvOdm-N1iX0SMxGDV5Vf=qS5uHPdH3S-TRs-065BuSOdKt1w@mail.gmail.com>
        <20200219181619.GV31668@ziepe.ca>
        <CAKwvOd=8vb5eOjiLg96zr25Xsq_Xge_Ym7RsNqKK8g+ZR9KWzA@mail.gmail.com>
        <20200219192249.GA8840@ubuntu-m2-xlarge-x86>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 12:22:49 -0700
Nathan Chancellor <natechancellor@gmail.com> wrote:

> Yes, thank you for the analysis and further discussion! I have done some
> rudimentary printk debugging in QEMU and it looks like these are produce
> the same value:
> 
> __stop___trace_bprintk_fmt
> &__stop___trace_bprintk_fmt
> &__start___trace_bprintk_fmt[0]
> 
> as well as
> 
> __stop___trace_bprintk_fmt != __start___trace_bprintk_fmt
> &__stop___trace_bprintk_fmt != &__start___trace_bprintk_fmt
> &__stop___trace_bprintk_fmt[0] != &__start___trace_bprintk_fmt[0]
> 
> I'll use the second one once I confirm this is true in all callspots
> with both Clang and GCC, since it looks cleaner. Let me know if there
> are any objections to that.

Myself and I'm sure others would be fine with this approach as it is
still readable. I was just against the encapsulating the logic in a
strange macro that killed readability.

I haven't looked at the resulting assembly from these, and will
currently take your word for it ;-)  Of course, I will thoroughly test
any patches to this code to make sure it does not hurt functionality.

-- Steve
