Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6834C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4584205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432286;
	bh=ddUrr9hDxrQIH4knLjpMqEzMT//jpgk9POSIeLe7uys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=R+8Imdx8P6XzjUkJscNvwen4GMFT4HplduoaYzeTJOa/DLxWaHWOoo4mUmz/j8lTp
	 1H4Yf5+vQqPS8x+oTOPC/yCBWFjjPGtpSFFnDYxvT+SUsNxoJN64eNegKEotjGkBz1
	 cYk83ad3Giw+So4HMpKDHWMHe1xIEl4TGte9RKNA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgENE6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:40516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENE6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:58:05 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E64F920760
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432285;
        bh=ddUrr9hDxrQIH4knLjpMqEzMT//jpgk9POSIeLe7uys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OPKI7rfrwk0FT5Juh68b6rV1OZT6nLgnH+rIs2CT2ZUmBgp0YzQUh2ds+q07WngyL
         zwS8GfyXA9XO8SNnZKgbCU4ZzbaNqygj+vNJtHcvua/7l8HOUzq7usoFFheLWtGPi6
         lrCaHsGpE+f54hjMyKRCmdEdBaD/FbfbGvfKjyZg=
Received: by mail-wr1-f53.google.com with SMTP id e1so2137496wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:58:04 -0700 (PDT)
X-Gm-Message-State: AOAM530/q0hOtps4euV0XqiiFHzGSpOLbUJs2v+8/Lb+Cw9fjd25rVyS
        XoPBRmo07FXoL+ly+onhywTohVayrSjy3wi5/3Wi9g==
X-Google-Smtp-Source: ABdhPJyzev78VR2eFEzu4QpBQY9fCsckfXycHjuyN1cID5gIUY7DfOPSBvhO6KI9OIPJwYzC51Emw003YwUrtGrNtHI=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr3073367wro.70.1589432283319;
 Wed, 13 May 2020 21:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135313.517429268@linutronix.de>
In-Reply-To: <20200505135313.517429268@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:57:52 -0700
X-Gmail-Original-Message-ID: <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com>
Message-ID: <CALCETrXVQsdPafvH56_nF+CKU94wgq-T71=EB6eSBnz70Cd0Rw@mail.gmail.com>
Subject: Re: [patch V4 part 4 02/24] x86/int3: Avoid atomic instrumentation
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Use arch_atomic_*() and READ_ONCE_NOCHECK() to ensure nothing untoward
> creeps in and ruins things.
>
> That is; this is the INT3 text poke handler, strictly limit the code
> that runs in it, lest it inadvertenly hits yet another INT3.


Acked-by: Andy Lutomirski <luto@kernel.org>

Does objtool catch this error?
