Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 047D6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C82FA20760
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520214;
	bh=Ky51v5BgL4uAG/kzZjdIe4k8SSM/0MecFmdfyDLxjJY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xa9Wu1GOLg9Z4EYAjwZlEuSg7R0Oy/D/kL5WEIeStwM8ESTIG75yhCQ/lr6wI1rH+
	 jzAulAtsOGJbv9CqvlbdxEDxB8imk1p6K/kvBNZafcCI63y25Lv2TYeM2savQg8Cr2
	 ogJZyRcE/muKWQX/EPPFDYYjRDXsJaGptND2At88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgEOFXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:23:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:59810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726000AbgEOFXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:23:33 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DD6207BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520213;
        bh=Ky51v5BgL4uAG/kzZjdIe4k8SSM/0MecFmdfyDLxjJY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pmuFVVK/jXZyveATyVxrrGE4cjQ05Tw1OvFo8qa//b5KkfCM2Wd/O2uph2A+yn7jX
         UjWvDWBvn/HnYzxDGN4eMHH43iByZnr+ukrVDr/CgCovU9prVM2aMk1EL/0Uef14+Y
         XgdyRcTF0g8TW8kG0OrUBDrMi2Fk2wfEIyH9NZ3I=
Received: by mail-wm1-f52.google.com with SMTP id u188so1125342wmu.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:23:32 -0700 (PDT)
X-Gm-Message-State: AOAM533PbjFKquLTBUs9snLPW2wr23/L8BrIhd2XBRHZalF9gJmLlj81
        l+eWR6gLS5OKvl5Ij+DWCtegxOSFLpOF6LTW4yv6dA==
X-Google-Smtp-Source: ABdhPJxV31oB4go2kwPiEWCdQPp98jLuYdv1bOLNPdJl0NdwCtpDlSsnY3xUmHlmKhL4l1+TeF5XcLMSftk3+StfLuQ=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr2034453wmr.49.1589520211169;
 Thu, 14 May 2020 22:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.243936614@linutronix.de>
In-Reply-To: <20200505135314.243936614@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:23:18 -0700
X-Gmail-Original-Message-ID: <CALCETrU2Mi8_yL4WWneVhLBgu3kpaa5nxfeH7s_UTy-36KRghw@mail.gmail.com>
Message-ID: <CALCETrU2Mi8_yL4WWneVhLBgu3kpaa5nxfeH7s_UTy-36KRghw@mail.gmail.com>
Subject: Re: [patch V4 part 4 09/24] x86/mce: Move nmi_enter/exit() into the
 entry point
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
> There is no reason to have nmi_enter/exit() in the actual MCE
> handlers. Move it to the entry point. This also covers the until now
> uncovered initial handler which only prints.

Acked-by: Andy Lutomirski <luto@kernel.org>
