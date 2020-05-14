Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFCC5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D130F206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431656;
	bh=cUOOvbAlTUvF4yuAaPRuysWH/grNtVq0r18hf4xegog=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=hxduyk0nLILg/GR4XNZXnMITgziJ9QC1zc6MM97kyDQzQhvSEMGr67r0t26zSDLKo
	 cXDObIHLfJR9VyZo82ht1cly94HJZ7ctdVhygiPfZqBiiIcMeaeaAuv+LfyXVVqGZ9
	 mO58RlQRpfZYQqrax/718Cag1nFqsH7MRHAEvTdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgENErg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:47:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:34956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENErf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:47:35 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CC0B207BB
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431655;
        bh=cUOOvbAlTUvF4yuAaPRuysWH/grNtVq0r18hf4xegog=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PRYtGqAS/RrhCmhn1N30hkrvUDFLCgMrubbbIvdhkTTvo2Uc16nvdKAJLtqsOCbsM
         lFKUuNZNGZyRRtz/fJrghvNawtdFht16X5CsqMg9Gt+/hY2MsRGXOPST3p/su9i7pr
         4F449LPKkHH9UUfJbUFaUu0Gk315FDNzDznaZVUE=
Received: by mail-wr1-f43.google.com with SMTP id h17so2093744wrc.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:47:34 -0700 (PDT)
X-Gm-Message-State: AOAM532KjVKPgAlzwCYUGUGkg1ZpswrG7ehq0lyGgaNHpiR/Mfgc+FF+
        /+OKASlMg6UUJtrJkKJTGr6XjucnTfWgrPC92hHSQw==
X-Google-Smtp-Source: ABdhPJwP41B1KzZCRqkq1XDuH9EaW7w1X8ZSf6D4eY6NxBftBo1rhtCM+qTBb7e2bYvEC5YtVT6qYDqDIUABwTqfero=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr3036758wro.70.1589431653434;
 Wed, 13 May 2020 21:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.443591450@linutronix.de>
In-Reply-To: <20200505134905.443591450@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:47:21 -0700
X-Gmail-Original-Message-ID: <CALCETrXeuNkgfSiK2Z8rEBnCx-_uoSfYwO1xNKaoWwAShx51CA@mail.gmail.com>
Message-ID: <CALCETrXeuNkgfSiK2Z8rEBnCx-_uoSfYwO1xNKaoWwAShx51CA@mail.gmail.com>
Subject: Re: [patch V4 part 3 22/29] x86/entry: Convert Segment not present
 exception to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #NP to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
