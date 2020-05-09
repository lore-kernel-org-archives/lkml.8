Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F3C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B155218AC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588983123;
	bh=Z9ay5G7kVhk0/W94a8FszZdzNnoqYJYAFv5+/llRIMQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RS1WA+jOuKKmInUf//SXblpmcpbP+cpuHXjblUDGKmA5xEzN4fZBz3kavyz0giBM3
	 sArqoW7cRGpWDMGz4luDw1T9hl2u/oMWqK2hzHFiG1zxXFy2NSobwIoHyHw/enISeZ
	 gav8IuRhguheBGK+z2dkH3i9ovEXd5wMquIYINzg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgEIAMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:12:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgEIAMB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:12:01 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F2ED24969
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588983120;
        bh=Z9ay5G7kVhk0/W94a8FszZdzNnoqYJYAFv5+/llRIMQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NupPm2ODrBD4E2tV0/HJJKWz7akh6IvXH8iWwT7PRfPklPMBDFz0/0zRwHkLsDRA2
         PtMxLal6bFkdYB91FBi39dSprRPpd7dAkx40KYnfJ8D6vhO7LmSSbybT+7NZ6XgX19
         UrNrqXsGIOfei01cAHaFS2Tos6LkMzkXHK2zKWrs=
Received: by mail-wr1-f53.google.com with SMTP id x17so3896964wrt.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 17:12:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuZmw4ynHPEYPBPjJ7vcmkt5H9cp8af2HTcSQZoVFRGNvZDxu1dH
        T2AqVBJnnaIS6fEqxUgiquk1Zob3zy2wnk/OEeX/Dg==
X-Google-Smtp-Source: APiQypKHR1tOfFO3FnY67bmAApr7rlEfZ3AKZG8Zmq/g15c31ChGjv30mZdQyzttNu5/dXdSNamINFZusWUp0Hf5HiY=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr4962321wro.70.1588983119008;
 Fri, 08 May 2020 17:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134112.272268764@linutronix.de> <20200505134341.272248024@linutronix.de>
In-Reply-To: <20200505134341.272248024@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 17:11:47 -0700
X-Gmail-Original-Message-ID: <CALCETrW7dNE2eoYANRjkRMzdXDh0jDD=cDT4WaKhQKsxYkkb4w@mail.gmail.com>
Message-ID: <CALCETrW7dNE2eoYANRjkRMzdXDh0jDD=cDT4WaKhQKsxYkkb4w@mail.gmail.com>
Subject: Re: [patch V4 part 2 12/18] x86,objtool: Make entry_64_compat.S
 objtool clean
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

On Tue, May 5, 2020 at 7:14 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Currently entry_64_compat is exempt from objtool, but with vmlinux
> mode there is no hiding it.
>
> Make the following changes to make it pass:
>
>  - change entry_SYSENTER_compat to STT_NOTYPE; it's not a function
>    and doesn't have function type stack setup.
>
>  - mark all STT_NOTYPE symbols with UNWIND_HINT_EMPTY; so we do
>    validate them and don't treat them as unreachable.
>
>  - don't abuse RSP as a temp register, this confuses objtool
>    mightily as it (rightfully) thinks we're doing unspeakable
>    things to the stack.
>

Acked-by: Andy Lutomirski <luto@kernel.org>

> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Did a From line get eaten?
