Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1078CC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:05:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2B22063A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588874753;
	bh=t12honBDppcMtC39atYWosMLZLOq8/S52nAqPhOENKc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=NHKZzRcdgZtJesRTwSX+tc1jAWK3oVr/7UG0Sa+xqoIJ7L2nvUXAMBT5xPq6gbiiU
	 Rpi0MbKiZIL/vRrlSEU41ysQWXi4ZBqV09t2SeEB0ICIf9RgYamxSoSH8gdyWzv9io
	 S+jjgLd1Jqg3zp2FbNPrpz9YTK2yd36ITHcRrM9I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgEGSFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 14:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbgEGSFw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 14:05:52 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9701E21835
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 18:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588874751;
        bh=t12honBDppcMtC39atYWosMLZLOq8/S52nAqPhOENKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CYKeVueYxchvPKyGrurGV8FrOlxvmOSuZ394PWpt/pK8cf4nJd/ec415nJunoTwNQ
         KghxOCLsI8tANKadlLuFvkGr27Yl7iVut34uV+zAVK9rHvtZEDe32TnhpXc665HmMb
         TpiH84isSTMk7gdNCZlPDnlflnKyXMPVvGuZlomA=
Received: by mail-wm1-f41.google.com with SMTP id u16so7839297wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 11:05:51 -0700 (PDT)
X-Gm-Message-State: AGi0PuYIsWtR9CgW/uQkpcWH6tM8LD3Hw4WPL7RJrBcKLSfCkd5dtPt7
        qDIjm0rn6DaItjX2CivwvD8XSlCrsX3HgfFFABWAFQ==
X-Google-Smtp-Source: APiQypJa73RTPZHUBSMpbX8CdKJ1utp8jAStgkb82bfQlXTNFAP1uBSn3nPVJ4rGyY0p2guQJEgHVCXvidBH+PyC8/4=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr11408000wme.176.1588874750143;
 Thu, 07 May 2020 11:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200505131602.633487962@linutronix.de>
In-Reply-To: <20200505131602.633487962@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 7 May 2020 11:05:37 -0700
X-Gmail-Original-Message-ID: <CALCETrWUH6hB6C0-FzaxvGCtJ=W414+B+0zEnME+C4Pc4CYiPg@mail.gmail.com>
Message-ID: <CALCETrWUH6hB6C0-FzaxvGCtJ=W414+B+0zEnME+C4Pc4CYiPg@mail.gmail.com>
Subject: Re: [patch V4 part 1 00/36] x86/entry: Entry/exception code rework,
 preparatory patches
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

On Tue, May 5, 2020 at 7:13 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Folks!
>
> This is the hopefully final version of the rework of the entry and
> exception code to ensure that instrumentation cannot touch the fragile
> parts of the hardware induced entry and exception code trainwreck. It
> further ensures correctness vs. RCU and moves quite some code out of the
> assembly code into C.

Other than the minor comments I sent, part 1 all looks good to me.
