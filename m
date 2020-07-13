Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A4FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B1F20578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594655311;
	bh=FiLSo9R0STPJ54NQ+j4cquzz90YqRrZ+tVdT8FICfPw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0aPtosy8tS1faz0Jb76yI/NyseJLF1r/H9bMVQxExCnuw6J9tzJJ4quZviZWKiPlJ
	 9mIO2dNzfM2DSYNHcNKJuAYA/7HwWBBsLRcAi9wrwy8EmfXOXHcyltl4abr38H4XNU
	 xGvqNZ/pOp2KxIMDbBU5enbDIpPtTYxLv0fqYzh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730057AbgGMPsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:48:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:43286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729492AbgGMPs3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:48:29 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74402207BC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:48:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594655309;
        bh=FiLSo9R0STPJ54NQ+j4cquzz90YqRrZ+tVdT8FICfPw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u/HSfMU9F7rxmTiqX4sRr4Pk8VxlDbewsgkjIe6pG2nB4ATgq01e1Xrr0clJ4LJmf
         KF6xr1Xv2GX82a28cw4dDUZuiL8A6ohB3EUIdPA0Gz22eJVXxmjte4lc3XkjzocFbw
         v5Jvv0F2fEGEoQbUjFwMLPV7iO/JAL2dOHC42qck=
Received: by mail-wr1-f41.google.com with SMTP id o11so17104053wrv.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 08:48:29 -0700 (PDT)
X-Gm-Message-State: AOAM530tom3A97R68mbGlaHoXk8oCo/OVIXgx6qkqAHNYL7Oz/xQfYxF
        ablweiqaJkwDY2AWBF2o06yFs/RW6MIRaChZOXZYLQ==
X-Google-Smtp-Source: ABdhPJx0toL1Ye0o0H7c4Y3A41BrSlbEq0nHhnxAApxWZf2y0+ABJ/8JMUZOzKNFFHuITvPQPnyOqJdLGjq2hZLzWb4=
X-Received: by 2002:adf:a111:: with SMTP id o17mr79174967wro.257.1594655308027;
 Mon, 13 Jul 2020 08:48:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200710015646.2020871-1-npiggin@gmail.com> <20200710015646.2020871-5-npiggin@gmail.com>
 <CALCETrVqHDLo09HcaoeOoAVK8w+cNWkSNTLkDDU=evUhaXkyhQ@mail.gmail.com>
 <1594613902.1wzayj0p15.astroid@bobo.none> <1594647408.wmrazhwjzb.astroid@bobo.none>
 <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
In-Reply-To: <284592761.9860.1594649601492.JavaMail.zimbra@efficios.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 13 Jul 2020 08:48:16 -0700
X-Gmail-Original-Message-ID: <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
Message-ID: <CALCETrUHsYp0oGAiy3N-yAauPyx2nKqp1AiETgSJWc77GwO-Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 4/7] x86: use exit_lazy_tlb rather than membarrier_mm_sync_core_before_usermode
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Anton Blanchard <anton@ozlabs.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 7:13 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Jul 13, 2020, at 9:47 AM, Nicholas Piggin npiggin@gmail.com wrote:
>
> > Excerpts from Nicholas Piggin's message of July 13, 2020 2:45 pm:
> >> Excerpts from Andy Lutomirski's message of July 11, 2020 3:04 am:
> >>> Also, as it stands, I can easily see in_irq() ceasing to promise to
> >>> serialize.  There are older kernels for which it does not promise to
> >>> serialize.  And I have plans to make it stop serializing in the
> >>> nearish future.
> >>
> >> You mean x86's return from interrupt? Sounds fun... you'll konw where to
> >> update the membarrier sync code, at least :)
> >
> > Oh, I should actually say Mathieu recently clarified a return from
> > interrupt doesn't fundamentally need to serialize in order to support
> > membarrier sync core.
>
> Clarification to your statement:
>
> Return from interrupt to kernel code does not need to be context serializing
> as long as kernel serializes before returning to user-space.
>
> However, return from interrupt to user-space needs to be context serializing.
>

Indeed, and I figured this out on the first read through because I'm
quite familiar with the x86 entry code.  But Nick somehow missed this,
and Nick is the one who wrote the patch.

Nick, I think this helps prove my point.  The code you're submitting
may well be correct, but it's unmaintainable.  At the very least, this
needs a comment explaining, from the perspective of x86, *exactly*
what exit_lazy_tlb() is promising, why it's promising it, how it
achieves that promise, and what code cares about it.  Or we could do
something with TIF flags and make this all less magical, although that
will probably end up very slightly slower.

--Andy
