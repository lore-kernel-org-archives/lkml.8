Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935E1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6633B2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589522054;
	bh=aQRlHZNu/lRsBXYwjlKy4ShAMPEg6hfGuxPA78tUUqA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=z4m79Wt7lEI7sOhylbAKB71e2PF4X0b2VEDUHhka1zk/oJ2VQUPQriXVkQ48gqsL3
	 HNK1eFp/lS7mgsyGooVC1zZzjDaq7sstoQvvNZ1xcH9f4j8hsYAqDUEEBRIBTb/G3t
	 nEuOCIucY0y3tfi2frzvQyEk4ZivN/aIyQpF8lis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgEOFyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:54:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726460AbgEOFyM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:54:12 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEEA20767
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589522052;
        bh=aQRlHZNu/lRsBXYwjlKy4ShAMPEg6hfGuxPA78tUUqA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1P5wzf30Pr09CLlQGqvlWiK5Vdj5XGh+WiITTR6yt83gt94X57VVFmoNhaNR6LJ6F
         xa4ncmEq22p8C2hzbV8Kix275O95flqqe/1k3gjGHVwOniC8rQxk0c5nLT81KB/a3R
         yQ5bhh2dwhnYtzZpiLYs2hfR7n8TtJW88b8GUkpE=
Received: by mail-wr1-f43.google.com with SMTP id j5so2032653wrq.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:54:12 -0700 (PDT)
X-Gm-Message-State: AOAM5314QycLZ4k4M8WrN4PcqqAtLvvH5KbJWTx9fv5ysG9EJCvFXDwZ
        0GTHVSFejS65AM5QPRI7onCG5P1zKA8f1pBgraiwMA==
X-Google-Smtp-Source: ABdhPJx+A4xph+3v5AP4X6m8unWs/6GANgvp+1Ea/rnLgEPkSV3kNNWIudie0Sx/+tPbJISvOkQtWepFYeHEB7rWPhw=
X-Received: by 2002:adf:f446:: with SMTP id f6mr2225808wrp.75.1589522050730;
 Thu, 14 May 2020 22:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200505135341.730586321@linutronix.de> <20200505135828.223678901@linutronix.de>
In-Reply-To: <20200505135828.223678901@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:53:58 -0700
X-Gmail-Original-Message-ID: <CALCETrWxC80dzSoPXEQJntYxiWNq7K3nH0wgLg6BeStnH-=+FA@mail.gmail.com>
Message-ID: <CALCETrWxC80dzSoPXEQJntYxiWNq7K3nH0wgLg6BeStnH-=+FA@mail.gmail.com>
Subject: Re: [patch V4 part 5 01/31] genirq: Provide irq_enter/exit_rcu()
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
> irq_enter()/exit() include the RCU handling. To properly separate the RCU
> handling provide variants which contain only the non-RCU related
> functionality.

Acked-by: Andy Lutomirski <luto@kernel.org>
