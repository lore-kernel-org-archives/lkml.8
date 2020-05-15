Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A12C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7980B2075F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520300;
	bh=0p4MU9sh09UIkFcUSyxNYENjUyCA8wdnYR5djowsWds=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eu3/2WuDLBldzHvezbP9Y8MDZMUQLKsiaBvB+ZADLGzWDUCveUUASfMb3nzNSlIAC
	 VvJn0Gpg/ugGXYL/7u7DbbX0FFgE+3b9xjzkIDV3xKjOGN1yzM2asxhoYAvvY9gjL9
	 flVPPi0VUVhHcyX7MeiKFIY748kJOu6EIhmT/gG0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbgEOFY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgEOFY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:24:59 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9798207CB
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520298;
        bh=0p4MU9sh09UIkFcUSyxNYENjUyCA8wdnYR5djowsWds=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ikwtUa/gDF6fJgChKS0y0UollW3L4h//gNNj6zLIgUyaQylRw/Hb/4m/YJfpyRXjY
         ftWzMFVS0cyZ3hU+wPi9BmpQ8SBEDsUr0zY1EJy8UfAbNNBeZFTkMcc4ykAPvAl06V
         vw8ZGi74SHtKSkhugFP9sUu452R4gY0Yt4g8Slc8=
Received: by mail-wm1-f43.google.com with SMTP id f13so906442wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:24:58 -0700 (PDT)
X-Gm-Message-State: AOAM531Dq/haussTaZCACVB7Wjk/KRSITOemoSjDtqYu0LDdD4+rNHg6
        Pmk9keMLdNF15qGic5NcbPHX3E574pyesZhP31Wj0A==
X-Google-Smtp-Source: ABdhPJwEqHdowY9NniUCQHeBVoG3ZlWxFICr2MtxsYmj4V8ZPbATgegyODakKp4Ov6wnJ/I4JqmkRmafHJCXi/2wkoc=
X-Received: by 2002:a1c:8141:: with SMTP id c62mr1024333wmd.21.1589520297084;
 Thu, 14 May 2020 22:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.426347351@linutronix.de>
In-Reply-To: <20200505135314.426347351@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:24:45 -0700
X-Gmail-Original-Message-ID: <CALCETrU0Kc9Rj6i1U10eiD5fD2c-f=vA3dAbhmFSorBB_a-Ypw@mail.gmail.com>
Message-ID: <CALCETrU0Kc9Rj6i1U10eiD5fD2c-f=vA3dAbhmFSorBB_a-Ypw@mail.gmail.com>
Subject: Re: [patch V4 part 4 11/24] x86/mce: Use untraced rd/wrmsr in the MCE
 offline/crash check
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
> mce_check_crashing_cpu() is called right at the entry of the MCE
> handler. It uses mce_rdmsr() and mce_wrmsr() which are wrappers around
> rdmsr() and wrmsr() to handle the MCE error injection mechanism, which is
> pointless in this context, i.e. when the MCE hits an offline CPU or the
> system is already marked crashing.
>
> The MSR access can also be traced, so use the untraceable variants. This
> is also safe vs. XEN paravirt as these MSRs are not affected by XEN PV
> modifications.


Acked-by: Andy Lutomirski <luto@kernel.org>
