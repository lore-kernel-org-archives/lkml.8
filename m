Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FC4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171B6206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=familie-tometzki.de header.i=@familie-tometzki.de header.b="XW6RzidC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389015AbgEZSjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388499AbgEZSjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:39:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6962CC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:39:40 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id e2so24878849eje.13
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=familie-tometzki.de; s=google;
        h=from:date:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=9yva+qG0CZWgeaDfnOWSXKHYV4l94Ce4oRRp5BLm0Oo=;
        b=XW6RzidCRYP2Urt2pLVgj+Y2vf8lofpnePp5ZiqYjWjPn/rcD6GCDfwn2F6QE3Pg34
         ISBbXtqD2nuqvPNYgmx4/rjBYdoCjm7Kl4/b2NA9942py6RSyMGL8HKPsA9KOndNvPw/
         NjGzW/RkogQmoz4+uKVWxXevo1NoqZ8uxTwoZvpFaiCphEJ5YpxjkBKR4yfkyvh3xyKd
         IoMz/T9laR7tZZ8QjiGKGnSC9J34Tr74DAkymOMCGv/4+PVSWiJjosKfpOgb6Fw8nTY1
         wdy6nerj9ivOhppgEGvWg7vzPGg6M96VoLEQhHit1NnGIZqeOeBUXvTP/gvQdGVUC02l
         z7cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=9yva+qG0CZWgeaDfnOWSXKHYV4l94Ce4oRRp5BLm0Oo=;
        b=Jx5hosr3iO0cQBTpdbA9AG4hjbBl8QJE2txBwjJk/3KFbCv08f6UBnjmWutCsfKrh1
         Iln7kUnDO3hHr2ghGK16o/ZOxiF42ISvNaHd0FsNxD1Ty7tJXU1cJKm5PtH9EOWINhw7
         +uDX4rHQq3IxKlgO8hY4NxM0z58IWYW8r1f8/3l6YlUfG3rrSXs2OwvVOGA/qVwyeHAZ
         bLrKDQpIFHePC8jpgr3c7oIt/xuVgQ3tmhSqkWojSi/a29mPG/rjHG4WTC58n6I70uUM
         jk8Vifboq36TnGGYmVOrsoKGTAhUKeC3oMxjbflNj345F/Ar26s7BYU2CG8v5UWlQ/Y5
         2lnA==
X-Gm-Message-State: AOAM532oMvIvvhdl9CPc8VFE1Aa9dOGCl+NS4GybeeUWAivkURouR4PC
        ICo3S1kG63QmiYoABfHbwVpyzQ==
X-Google-Smtp-Source: ABdhPJw9DBtVBj1Op2rbWQHpDcoVvB1GpyA0iV2tDzjriXZdh1QOuZlv8wwGB2XXOIkkrHxsK4HuZw==
X-Received: by 2002:a17:906:9617:: with SMTP id s23mr2263738ejx.505.1590518378411;
        Tue, 26 May 2020 11:39:38 -0700 (PDT)
Received: from centos.familie-tometzki.de (p54944fd8.dip0.t-ipconnect.de. [84.148.79.216])
        by smtp.gmail.com with ESMTPSA id af15sm528840ejc.89.2020.05.26.11.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 11:39:37 -0700 (PDT)
From:   damian <damian.tometzki@familie-tometzki.de>
X-Google-Original-From: damian <dti+kernel@familie-tometzki.de>
Date:   Tue, 26 May 2020 20:39:34 +0200
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Subject: Re: [patch V9 20/39] x86/irq: Use generic irq_regs implementation
Message-ID: <20200526183934.GA3960@centos.familie-tometzki.de>
Mail-Followup-To: Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20200521200513.656533920@linutronix.de>
 <20200521202118.704169051@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202118.704169051@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Thomas,

with this patch i got the following build error:

  LD      .tmp_vmlinux.kallsyms1
/home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: arch/x86/kernel/irq.o: in function `get_irq_regs':
/home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:19: undefined reference to `irq_regs'
/home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: arch/x86/kernel/irq.o: in function `set_irq_regs':
/home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:27: undefined reference to `irq_regs'
/home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: /home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:27: undefined reference to `irq_regs'
/home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: arch/x86/kernel/irq.o: in function `get_irq_regs':
/home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:19: undefined reference to `irq_regs'
/home/damian/kernel/buildroot/output/host/bin/x86_64-buildroot-linux-uclibc-ld: arch/x86/kernel/irq.o: in function `set_irq_regs':
/home/damian/kernel/buildroot/output/build/linux-custom/./arch/x86/include/asm/irq_regs.h:27: undefined reference to `irq_regs'

Best regards
Damian

