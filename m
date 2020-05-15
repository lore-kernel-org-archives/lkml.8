Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9CBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3412065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520565;
	bh=NAPmWKKSoSoH/ApSWtU33AgGcKtWRWCqTjdDmj20J+w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ladMq2mK2NdpvkpzjFgyXcgrwWgVCJC/qI5/8QX3d9lNumDSwcA9qAWRtcMYEe7ac
	 wwiBPCOF9+SGM6XxJkX/d9oltZf0XtMSyPMh4r+r3K7c1fVceKhl7h1Q+ZGoG+QwWK
	 BNBgp18oHqyCac/rihFiDXrtWqdC1YVv9kOHgOb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgEOF3Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:29:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:38358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgEOF3X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:29:23 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D6FB2065F
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520563;
        bh=NAPmWKKSoSoH/ApSWtU33AgGcKtWRWCqTjdDmj20J+w=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EUiRT1RWPbzkXn4rBuiFMAgkNKMrMMQBsw1BNL598a3KXvCKeVOhfYlWwJyAtt9sD
         yK6bc9Z5ZLEGNUsCtsbGwmiIFu0ayGx5Qm1580J+3XTuztFvQKNF8cvI7GOPvgLOVI
         xDRCjmW1LqlnlliWtphCYP5hwZInYiRCHRFqBlsA=
Received: by mail-wr1-f52.google.com with SMTP id e16so1926759wra.7
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:29:23 -0700 (PDT)
X-Gm-Message-State: AOAM530rkATXIcv/ZLqUrWN+PW4rS8kKgC/yjYTAyJly2YbliumIziKe
        W4NWOkp/iuc/cpNrC9i/qI4p03LrLPqF1S7NFNhj2A==
X-Google-Smtp-Source: ABdhPJw6KxyOfdySG/CRIM6aqaLtbO/yg7UY6Cwcs7UDiE9YYcRCjppO8JTLdZmhkC/2082B6kQd6zC38kjXGrwXbY0=
X-Received: by 2002:adf:a298:: with SMTP id s24mr2164274wra.184.1589520561696;
 Thu, 14 May 2020 22:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.084882104@linutronix.de>
In-Reply-To: <20200505135315.084882104@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:29:10 -0700
X-Gmail-Original-Message-ID: <CALCETrXJQsWJhwHi0-POiM6gKpSnVL6MYmK2zphg_oPPmpBNow@mail.gmail.com>
Message-ID: <CALCETrXJQsWJhwHi0-POiM6gKpSnVL6MYmK2zphg_oPPmpBNow@mail.gmail.com>
Subject: Re: [patch V4 part 4 18/24] x86/entry: Provide IDTRENTRY_NOIST
 variants for #DB and #MC
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Provide NOIST entry point macros which allows to implement NOIST variants
> of the C entry points. These are invoked when #DB or #MC enter from user
> space. This allows explicit handling of the difference between user mode
> and kernel mode entry later.


Acked-by: Andy Lutomirski <luto@kernel.org>
