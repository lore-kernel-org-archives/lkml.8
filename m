Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EF6C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11BB2496F
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588985081;
	bh=xjgaAtmSpzrdt65ARtNkcoW6EHl275JUOmFDo+OcSWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YSK3RoSnGVtDtasprFrks8wfE6LjSG0/utVDvBNrFN7bjUp2dlxqHGZHmNtOyrlgM
	 JyruR+P5V0iJbUy+XDW7k75Uv4m1g/weKgKS0AbOTmaQ5EctOttN7xuMXnatvjCPp2
	 QQ5gljzpkvSKb0fDdYz5ie9hs9JUnX8rqBIOAhgs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEIAok (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:44:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:60124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgEIAoj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:44:39 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB1CD218AC
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588985079;
        bh=xjgaAtmSpzrdt65ARtNkcoW6EHl275JUOmFDo+OcSWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V/ms07wsFbhL3UlCeADr9uuzWUvuBGxhDMDLCC8RA3Qc4eW0ujBmw4toIqPQAk5U+
         3W08hLH8OR9q2WSe+odDtjGnuMC0PzXRQbDTsSeeCHJB78x054N+Mjzjm2cHgn5jjL
         dWVf7XPMZL1QguGWxbjrWTeeSpvb7JAEx7ZPzLBc=
Received: by mail-wm1-f45.google.com with SMTP id e26so12024275wmk.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:44:38 -0700 (PDT)
X-Gm-Message-State: AGi0Pub9vSuxu3zsAd8S8BjLdalIfY2R3rgEfSiXV6WUxTWno9lEIJ1A
        urSgCTYjoxryFjctTvoyelsIx2SEMAOzoyySt6ePVw==
X-Google-Smtp-Source: APiQypKPcRk7flgzOpztAgnDIJIh4WDrmm7LmD0GtpU2gSYexC+wENF2r4X6CdaJuyhFYljthW8APy6u6i+B2kmDKVY=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr11671579wmk.21.1588985077213;
 Fri, 08 May 2020 17:44:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134903.622702796@linutronix.de>
In-Reply-To: <20200505134903.622702796@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:44:25 -0700
X-Gmail-Original-Message-ID: <CALCETrVFzhDD-=fi5=nMzSf3BWzjvsoCYhaEOU-VSzyghm7xdA@mail.gmail.com>
Message-ID: <CALCETrVFzhDD-=fi5=nMzSf3BWzjvsoCYhaEOU-VSzyghm7xdA@mail.gmail.com>
Subject: Re: [patch V4 part 3 04/29] x86/traps: Make interrupt enable/disable
 symmetric in C code
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
> Traps enable interrupts conditionally but rely on the ASM return code to
> disable them again. That results in redundant interrupt disable and trace
> calls.
>
> Make the trap handlers disable interrupts before returning to avoid that,
> which allows simplification of the ASM entry code.

Acked-by: Andy Lutomirski <luto@kernel.org>

And thanks!  This has bothered me forever.
