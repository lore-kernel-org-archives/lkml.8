Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1B5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3941207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589920116;
	bh=cv6xmqv3ovI2yurgdTY3UYx7aV+dLrOOzyq3cQI3jNM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DxYolx6UZnC+OylobtKNo/3gZEJMOUxEp42uUOM5nGCUm+LfLQQQz2yTZyeTc+Ypw
	 NU8YcI8Lcg57cYAceQXzg1Nh4nbxHtxoB8uMVqhaYvpHXM4IqdcThz+wTCdIdnbikJ
	 FIWTCuoNHszfRhyQN0/tdizrUmUG+117Y99NVeng=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726447AbgESU2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:28:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgESU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:28:35 -0400
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0B9C20826
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589920115;
        bh=cv6xmqv3ovI2yurgdTY3UYx7aV+dLrOOzyq3cQI3jNM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EEIqQDcFGkxw2H8DcIYC/z9+BzWGvVYeClibfhMZ8CwOonGz1NJ0MCDGSfLGsRl5o
         h6zkCOhbfr4kmz9Y9SkFh2tumCccwccwKtJPyg4ZeLWpfDvr6KXstobansgyrm12b4
         FqNc8H2EFVInJF4zEp9/Kzd8qnmPfux7SskQ4vQw=
Received: by mail-wr1-f54.google.com with SMTP id e16so831156wra.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:28:34 -0700 (PDT)
X-Gm-Message-State: AOAM532xtdj19ZXkg9POYgAlyMiaSqgEQj8AoCtgzc3VBXHN+qXs+0Ad
        vxaCd55CfY5hgLWDLVd73aaA8iOnFqVJFmi/hugdEg==
X-Google-Smtp-Source: ABdhPJw0+oYmcGYQ4tCAMqU9iVvzlx9KHoJD1psit8jzF4RBp3Z4bw3DnZCwrw8oZxqMP/AAizYzwzMlpHRCG/gTY5w=
X-Received: by 2002:adf:a298:: with SMTP id s24mr666239wra.184.1589920113319;
 Tue, 19 May 2020 13:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235126.617248111@linutronix.de>
In-Reply-To: <20200515235126.617248111@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:28:21 -0700
X-Gmail-Original-Message-ID: <CALCETrUAv91_07LNLmCtuXbp8c5hQVoGW_cYDf6ZgTBSuvwbcQ@mail.gmail.com>
Message-ID: <CALCETrUAv91_07LNLmCtuXbp8c5hQVoGW_cYDf6ZgTBSuvwbcQ@mail.gmail.com>
Subject: Re: [patch V6 22/37] x86/entry: Use idtentry for interrupts
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
> Replace the extra interrupt handling code and reuse the existing idtentry
> machinery. This moves the irq stack switching on 64 bit from ASM to C code;
> 32bit already does the stack switching in C.

Acked-by: Andy Lutomirski <luto@kernel.org>
