Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C47F6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 919CD207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919283;
	bh=My6svUo2kNhHd0PeK985QXponpPvUA8f6n4aRh+On+U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=l3Rdy3eDoNYuryyofgEzqTTS/RgyPjIFiFk0UZTNmro7ppujlGCEdn3QClj/zvuwX
	 AJw6300V6DtjML8/+qYEohzZH/K7nVJcyAYEvgeyHxGTVi4R1cbBCcD4QzJYZDyCQA
	 yWbzX4PRHT4Ijqwfkk442eur7QGCzYvvCoqbU3eY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgESUOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:14:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:56330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726333AbgESUOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:14:42 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF0620874
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919281;
        bh=My6svUo2kNhHd0PeK985QXponpPvUA8f6n4aRh+On+U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=doWXhgOZ/Tn217FKhCDZGpH2Ewl7152+3tFme1xCEj9hxNdu6ZSFq9ylt0xawHL6b
         BGQpyqizqBQcdoiNkYAWHrR5A0FPksHuJcm5YBnwbA42iVzyQAkdrX2zaXZYJbn0Yc
         4qXFsSMKIKFQhhxgvgLS2q9syeDc0oL6DhwrgPFs=
Received: by mail-wr1-f43.google.com with SMTP id s8so777056wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:14:41 -0700 (PDT)
X-Gm-Message-State: AOAM530loMO0a4KVFkJmNshPxD+dwPiehuAAClTJpqZa+mQlBHAqXExV
        bynFrMGJ4peLH9onY876eALw+VFTsuechkYWz844Ag==
X-Google-Smtp-Source: ABdhPJyb9uYySLuFuVDeEiTJ6aQfYY8ZUnaz0SeqPVUReCjLzytu0pXQ9UC0papM9KgcdASYGYoiJHKk79ZbZwBNmb8=
X-Received: by 2002:adf:a298:: with SMTP id s24mr621894wra.184.1589919279823;
 Tue, 19 May 2020 13:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.016243112@linutronix.de>
In-Reply-To: <20200515235126.016243112@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:14:28 -0700
X-Gmail-Original-Message-ID: <CALCETrWZN89dnwC3DH_cGAxY5dmT_RSrLzj7E_-XZph15AfGjA@mail.gmail.com>
Message-ID: <CALCETrWZN89dnwC3DH_cGAxY5dmT_RSrLzj7E_-XZph15AfGjA@mail.gmail.com>
Subject: Re: [patch V6 16/37] x86/entry/64: Remove error_exit
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
> No more users.

Acked-by: Andy Lutomirski <luto@kernel.org>
