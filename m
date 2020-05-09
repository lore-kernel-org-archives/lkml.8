Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83EAC38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88B4821473
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588984859;
	bh=RCw11NNfdLA9O2Gfd0f9tHY27w1jPYg/KFp+7vwuzdg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=k7GknY6CDaZcfx9mT4haLG8Yl8b8UVKrJOAj5y+noxOWp6nLZjCusxLH3rL7lS+y7
	 H5xgsy0DMfDftAGIxQNQJo3AqUFgpJLtTO8RCJpmS+OUTICyJOAp6JFG4zNlpA4Vpw
	 05PAcCe+hMSZYbNAXAVShhvhnhNoCNUHWHg8Vqgg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgEIAk6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:55684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgEIAk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:40:58 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C731324956
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588984858;
        bh=RCw11NNfdLA9O2Gfd0f9tHY27w1jPYg/KFp+7vwuzdg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yJptV3Wm8w/A4pC+pvYOUyvkPnUZdeANLxfdfyjyGQGrEk9gXrd2NRZBgCoNP4e6i
         U1vwKIIb4GmzzATiJnBf30UtsbTktKMywC2plS2rUvWjW2CZjXUUnDQU1lkppQRD36
         ee0+a59lte/mITYaCkmuccYPYHFSpDqeIdI5AvQ0=
Received: by mail-wm1-f50.google.com with SMTP id m24so2396945wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:40:57 -0700 (PDT)
X-Gm-Message-State: AGi0PuYckpdgxZC1Itgb27fdlBDWLhRZax5y0wVBulDy4+6tv7cCVMps
        rYZsORpJvU5Hxu0YWFwSBTuT03wZ9DPP9KssP/aNGw==
X-Google-Smtp-Source: APiQypLkEzHCvuzLfausBBeLT2C0NSBCgttRWUiv4mRrwscFYLcZKHc+Z4XrNWPFi5vEA2Au2LZM9rc/aio/S/tTJXE=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr18423641wme.176.1588984856328;
 Fri, 08 May 2020 17:40:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134903.531534675@linutronix.de>
In-Reply-To: <20200505134903.531534675@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:40:45 -0700
X-Gmail-Original-Message-ID: <CALCETrWbQKyf2+bvCszt03agZWnfxfLqi-rqeGMKE8a-3ygQxg@mail.gmail.com>
Message-ID: <CALCETrWbQKyf2+bvCszt03agZWnfxfLqi-rqeGMKE8a-3ygQxg@mail.gmail.com>
Subject: Re: [patch V4 part 3 03/29] x86/entry: Disable interrupts for
 native_load_gs_index() in C code
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

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> There is absolutely no point in doing this in ASM code. Move it to C.
>

Acked-by: Andy Lutomirski <luto@kernel.org>
