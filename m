Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 028A9C47257
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C812C21473
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588872932;
	bh=lncvbRIJtEWrXr/nx1Zzug/elFtPcJ+w7jc6HUXkj5M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nWU5PgeD17E+qslNK2jgyj9oYxwgnh423dvq4TPFRjTSRH63hOdYxkg/Rw7r13Fey
	 ZoCjFmijiIvX9yWvm7c2s87FasdtBpSWg5Fs4TTHKsj1iltAljk1zIEbcCmvCocZV/
	 Euw6jCsSezNK+BgVS1/ThjPzBIG7DMNfEbN+4uS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgEGRfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:35:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:34000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgEGRfb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:35:31 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ABCB424962
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 17:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588872930;
        bh=lncvbRIJtEWrXr/nx1Zzug/elFtPcJ+w7jc6HUXkj5M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oabPy4HQ0E14YCEFK66CDg1iM98007TazU78IqhjmFtCRowrd8sUrWD3sQpVvWYGi
         e+mjPEE9tODehrCSmCLHU6TVynWS7MeTtCDJ5Ok5i4OrN/aSyfyZJ+wBV34AmFhtXI
         1QbvX4Rtax/aPPgTd4dlVDWq/1V7MyhL9ggkVf58=
Received: by mail-wr1-f48.google.com with SMTP id h9so7408682wrt.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:35:30 -0700 (PDT)
X-Gm-Message-State: AGi0PuaPKYEndEgiejsaWxDMmhw7WouTeQplHWn0vhiDHzAnAaHSIJGN
        hcWMSGPzhroxh9YkHL1KeTdIZVM8VtkSYN5aBvVIDQ==
X-Google-Smtp-Source: APiQypJ6FaG7+7wJQ0z/6pQSUnMeTmkxE4/lfOrdeRLUaQT1+0HBtDPEAslxw56ktq8vz0V6cHIzYbX4HxDclXmDZps=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr3383432wrs.257.1588872928961;
 Thu, 07 May 2020 10:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de> <20200505134058.560059744@linutronix.de>
In-Reply-To: <20200505134058.560059744@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 10:35:17 -0700
X-Gmail-Original-Message-ID: <CALCETrVwq_qsvimNN2Bag+9P8jhd9fYpzYEc+iKobMsAFb1X4Q@mail.gmail.com>
Message-ID: <CALCETrVwq_qsvimNN2Bag+9P8jhd9fYpzYEc+iKobMsAFb1X4Q@mail.gmail.com>
Subject: Re: [patch V4 part 1 05/36] x86/entry: Flip _TIF_SIGPENDING and
 _TIF_NOTIFY_RESUME handling
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Make sure task_work runs before any kind of userspace -- very much
> including signals -- is invoked.

I certainly approve of the change, but anything that fundamentally
relies on this makes me uneasy.  I'll keep an eye out for potential
problems.
