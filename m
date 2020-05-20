Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C3FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DEC120849
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934626;
	bh=wf3QGE+jOUgmDKaZ/bBj5o/Z9+gYbBdvv8wlYlrwj8g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zaljuhfI1WM2z2Gl0dZENMDetE8mdx6Emhjzy7bc5WtQcywH0e7vdJJpC2bCqyDs/
	 PmU5//KSI63N4u0nrL9/d+DBZbQaGvBaLq1ETK43vWo8E5ZggV3lIdYLSDXsMwUDLN
	 NB3l9TUcTKDr1FCs8i9ykLPxBULaZ9aHAWGmI+i0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgETAaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42490 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728039AbgETAaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:30:24 -0400
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2470120899
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934624;
        bh=wf3QGE+jOUgmDKaZ/bBj5o/Z9+gYbBdvv8wlYlrwj8g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OrxovbxHlmzoeGQHeuWbhgPKUSPliHFTim5aE6wMy5V55VrIeo53jicjdlphiZk6g
         jgsvHR9YsW7YpiC3KucPvb1UuUWKO1EHbq2u/8h+WWHnY22Ncbe81enLXY8SuvCXuD
         FHVOxGx+d1rO7PirMgVfYMjCziEFlTUekzEm1U4I=
Received: by mail-wm1-f47.google.com with SMTP id z4so971391wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:30:24 -0700 (PDT)
X-Gm-Message-State: AOAM532d4ZQ3PyZ4bZ1Wnuwc5uvLp60Tlcx8zZ4+KAoRFj5WrsZrSnSw
        ex3IvMDmjxOxKbXEuWxhD/+1JtGFqGgpKwxe5Dl1gQ==
X-Google-Smtp-Source: ABdhPJzbCL+4VtDsIgdlH29i1OM9yNGiM76+CoE3hV6Mp7SAcNJ3H5jJEJgrh7/IUEWh5u79FwKzy5DJEQ4EAiZgU+8=
X-Received: by 2002:a1c:b3c1:: with SMTP id c184mr1898104wmf.36.1589934622625;
 Tue, 19 May 2020 17:30:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.101900776@linutronix.de>
In-Reply-To: <20200515235127.101900776@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:30:10 -0700
X-Gmail-Original-Message-ID: <CALCETrWSMtpMMpYAAYa1jyBugNOFhcM1nM=MpXidfYFx6AQsEA@mail.gmail.com>
Message-ID: <CALCETrWSMtpMMpYAAYa1jyBugNOFhcM1nM=MpXidfYFx6AQsEA@mail.gmail.com>
Subject: Re: [patch V6 27/37] x86/entry: Convert KVM vectors to IDTENTRY_SYSVEC
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> Convert KVM specific system vectors to IDTENTRY_SYSVEC*:
>
> The two empty stub handlers which only increment the stats counter do no
> need to run on the interrupt stack. Use IDTENTRY_SYSVEC_DIRECT for them.
>
> The wakeup handler does more work and runs on the interrupt stack.
>
> None of these handlers need to save and restore the irq_regs pointer.

Acked-by: Andy Lutomirski <luto@kernel.org>
