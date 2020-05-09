Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F03BC38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDB5208CA
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588983304;
	bh=04iNIHT/D+y8mL2H3VwMuWm5RnWhaS/X1x6j6jldBNQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GPBwwJ4DvxlMY+5ljwKllDYI1Q7e1qUEW9wVm+usmByy2s68T2q+PWLNxO/RHscWF
	 MYQkkFFSIxf2pzsUc888xDh5T8qgy6u6GDbs9xzMXDc96t0J2rcElRgM3yyi4sz+mN
	 bIhzsSu0JpmJTa6IOsgIFLcEJkO9RElyRCpuzJEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgEIAPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:15:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:38752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727983AbgEIAPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:15:02 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07C992496A
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588983302;
        bh=04iNIHT/D+y8mL2H3VwMuWm5RnWhaS/X1x6j6jldBNQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fnfXFe7TSB/8SepidulViTVdYAdldUWn08mBQGu9C1BQQOvQlk/l6DjtzjSOdDQbr
         S+5OVEgEQuNthe09wovg0PV+3yASAiif0l2FdtyduqG97JKFVRELMqxji+IMMLnWDV
         ptUkodlPS3YV1TCGtp8Ecl9r4MAClWCGrcX579z8=
Received: by mail-wr1-f41.google.com with SMTP id h9so3914514wrt.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:15:01 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ1KboD6NWuIDjhVwreDXwYtqfv2DmHMtX2QZMbfCw3VTK02n2E
        oF3vdQXNLYuz8/IJ1O/+PrRLNeWb1nofh/mLwNnJ/A==
X-Google-Smtp-Source: APiQypKmaMXaSt8iEKR+x00GxdW48hFznd/utZShjM6SrX0pPnGKp7nJpnxjsfEcADAWlK4toqijvCfzMgXH66DbBFI=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr5542385wrs.257.1588983300442;
 Fri, 08 May 2020 17:15:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134112.272268764@linutronix.de> <20200505134341.379326289@linutronix.de>
In-Reply-To: <20200505134341.379326289@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:14:49 -0700
X-Gmail-Original-Message-ID: <CALCETrWk03x6yuQR5CO+VUbwEFJKZdftmHMEG5BDiRWjowX2_Q@mail.gmail.com>
Message-ID: <CALCETrWk03x6yuQR5CO+VUbwEFJKZdftmHMEG5BDiRWjowX2_Q@mail.gmail.com>
Subject: Re: [patch V4 part 2 13/18] x86/kvm: Move context tracking where it belongs
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

On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Context tracking for KVM happens way too early in the vcpu_run()
> code. Anything after guest_enter_irqoff() and before guest_exit_irqoff()
> cannot use RCU and should also be not instrumented.
>
> The current way of doing this covers way too much code. Move it closer to
> the actual vmenter/exit code.

Now you've made me wonder what happens if someone traces
vmx_vcpu_run().  I'm not sure I really want to think about this.
