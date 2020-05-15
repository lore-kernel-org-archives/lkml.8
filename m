Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5730DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 301B720671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589521382;
	bh=znbHUnsThBKBrYTWI95KP2LVtdrW14mFKp69v3/IN4Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=KiA+uFRfriQANa5J5HDojnxXq+OD+IZOAJzSZ6hMJ+OvHdJnd1ZZBU50wtrp7Ql23
	 BfsVV4tFZp9A94F/ssF8EKqiqR2bONzKGtYb8oa0IKPi684f+HQs1zqmQKnP9170HP
	 nTTrLT5nuNc1vM+RCABF8tnBTClAynp5OPz1QI8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgEOFnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:43:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:47614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbgEOFnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:43:00 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7AA320671
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521380;
        bh=znbHUnsThBKBrYTWI95KP2LVtdrW14mFKp69v3/IN4Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fY7/LdrFLVzJ1RFLRwHkd21rxTIdjwkGzur7R0tbKy2wFQiXgjvs1eoNU093yzjv/
         0L1zwZBaUkWqpLqgcDOON20Vb3OtbHSydtgAgDWwiLrGvs5ajfTyovhd3ob9m/DEhv
         saGi2fcM7Yama4Bso7k0MC1slJxlHm+qHSPCvBwY=
Received: by mail-wm1-f49.google.com with SMTP id f134so969546wmf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:42:59 -0700 (PDT)
X-Gm-Message-State: AOAM533DxLfxi7lwDUsq3laS8J3FsMcbxPIV0d7WOCZDM5jn9NM3xTNk
        KLzQGaP6LcYkTs5uhZDU/t+pitbRGdqVXwplwZ6J3w==
X-Google-Smtp-Source: ABdhPJyL3w1yemsbeii5Sf/MreWsp7ZwCcC1MYxSYMzBmYif7TwzYpstH1iFBLe6VkWdsJHNvhstLg5lraaT25nvCks=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr2005852wme.176.1589521378526;
 Thu, 14 May 2020 22:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.686797857@linutronix.de>
In-Reply-To: <20200505135315.686797857@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:42:47 -0700
X-Gmail-Original-Message-ID: <CALCETrU3J=yv1_WD1VhQ5suTsT9oH9tWnPGU1BFH7N_8Jd7rUw@mail.gmail.com>
Message-ID: <CALCETrU3J=yv1_WD1VhQ5suTsT9oH9tWnPGU1BFH7N_8Jd7rUw@mail.gmail.com>
Subject: Re: [patch V4 part 4 24/24] x86/entry: Convert double fault exception
 to IDTENTRY_DF
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
> Convert #DF to IDTENTRY_DF
>   - Implement the C entry point with DEFINE_IDTENTRY_DF
>   - Emit the ASM stub with DECLARE_IDTENTRY_DF on 64bit
>   - Remove the ASM idtentry in 64bit
>   - Adjust the 32bit shim code
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
