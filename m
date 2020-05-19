Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B66F20873
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589919268;
	bh=ZqTQuHxYH0MkHUC6dVn+CA/0CjNcHAiHxB0bgMmBd68=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zg1pxDGRCKsG+N7mEJaDMSr5i51e6XclWl0Gl9W1nJBUNuO1emT6oO0UrtOFTExJs
	 ezo/EeY5L8LkVWUrj2Ys6/ZdyaYReQjvJG8suKAgzaP11batr00OxL3dd32hnQEK2q
	 TEfCCjFqxFEWHFDuvOPY3xQ4IiD0ewiyxW128RTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgESUO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:14:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgESUO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:14:27 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C40D207FB
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 20:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589919266;
        bh=ZqTQuHxYH0MkHUC6dVn+CA/0CjNcHAiHxB0bgMmBd68=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gxn+9vWGngvikBrEk3ZPZORhFQ3Pv+QDl5P0/jWdVVjyUSDmvsuHsvgxnZMwBURaW
         N/+6ChpmWebTRn056qY3NJ0/JoxI9URsksny99YMNMosPHSMp+fUKEjbOYWRdCfDZS
         kT+epaPf3Dz5nmjGjQP+PMDvHiNe4D594DzlDCuE=
Received: by mail-wr1-f50.google.com with SMTP id k13so823136wrx.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:14:26 -0700 (PDT)
X-Gm-Message-State: AOAM531uXPXLIEVv22ijks7qTP/Vu6xDwGauX2JDX7s9Vc2PgCRMXug2
        CCOGSTD/7cGpvc94/4yrlTtcq2Q+4e+f/BIhe67Akg==
X-Google-Smtp-Source: ABdhPJwKhSdNdUVZLlt9aw0CGJpK84ubff9HxyFuvvlt3AbD8GHEgGuei5C2Yn+pOpTpMdJYT5Xd8qlnBCo0xNl1RSs=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr580223wrs.257.1589919264778;
 Tue, 19 May 2020 13:14:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235125.921971685@linutronix.de>
In-Reply-To: <20200515235125.921971685@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 13:14:13 -0700
X-Gmail-Original-Message-ID: <CALCETrV=qqk7ouxFTC4_Huc5xLxd1z4s6vkHX8zkfb-ez91jLA@mail.gmail.com>
Message-ID: <CALCETrV=qqk7ouxFTC4_Huc5xLxd1z4s6vkHX8zkfb-ez91jLA@mail.gmail.com>
Subject: Re: [patch V6 15/37] x86/entry: Change exit path of xen_failsafe_callback
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
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> xen_failsafe_callback is invoked from XEN for two cases:
>
>   1. Fault while reloading DS, ES, FS or GS
>   2. Fault while executing IRET
>
> #1 retries the IRET after XEN has fixed up the segments.
> #2 injects a #GP which kills the task
>
> For #1 there is no reason to go through the full exception return path
> because the tasks TIF state is still the same. So just going straight to
> the IRET path is good enough.

Seems reasonable:

Acked-by: Andy Lutomirski <luto@kernel.org>

Although a look from a Xen person might be nice too.
