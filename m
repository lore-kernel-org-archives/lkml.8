Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88CCFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48BD520756
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589935607;
	bh=FR/66lhQPGU3oYhtsyGKqgKaTvciTidOvN3l0A7PLms=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RUVeECj3FtvuTcoG0voLha+UJEpueIq37BHe0UBw34vCwwfM3ec64vSIZMFkPgJCc
	 XFwrG0BUD/dWbWK6UcTSVz0uq4+zgtbQGzBkZQimR2m7IY9M4MTCUibi/5iF/lUWp5
	 rNmtkZp4RJ6+ebfnxohLablNbv6bOtTrYDLmIZJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgETAqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETAqq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:46:46 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B12520835
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589935605;
        bh=FR/66lhQPGU3oYhtsyGKqgKaTvciTidOvN3l0A7PLms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=d8OHrcJd8P9AdwPxP4lvYdJ2t3uZECdTDL4u0BNKsLn++tb2tmoyfoS8GXBPoXYmg
         MHttQlJWd0Jjf+xthnfX/ULinplORCqKkhue/s6lPJ32Ipdd77Qcml5bpXzTCsPsng
         4BeAO9G07SpXU5ehEq7IWiTdZZ+pCBLa/YSFHilA=
Received: by mail-wr1-f46.google.com with SMTP id j5so1394824wrq.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:46:45 -0700 (PDT)
X-Gm-Message-State: AOAM530Ur1zEjbAvwEhg5kqf7x9ZAbgzaX+h2vawWfJZWmP2XvMX3Nzr
        7zJZC3qD60hMf+QTQTne2gpf25ZbZTqLoLHKk7ySxQ==
X-Google-Smtp-Source: ABdhPJyfMgOeytcrUm9PfPDept0RQcPG19FyC6sON8zKhdWdeBnYKm0VtkBXoVWcERXAbepFlWnSabrRna/labDrBYg=
X-Received: by 2002:adf:a389:: with SMTP id l9mr1572429wrb.18.1589935603905;
 Tue, 19 May 2020 17:46:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.903812024@linutronix.de>
In-Reply-To: <20200515235127.903812024@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:46:32 -0700
X-Gmail-Original-Message-ID: <CALCETrU80Tw16JdbYgnK+2TWg4VYtO-2SfMeOCUkkdpuKWuWOQ@mail.gmail.com>
Message-ID: <CALCETrU80Tw16JdbYgnK+2TWg4VYtO-2SfMeOCUkkdpuKWuWOQ@mail.gmail.com>
Subject: Re: [patch V6 35/37] x86/entry/64: Remove TRACE_IRQS_*_DEBUG
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
> Since INT3/#BP no longer runs on an IST, this workaround is no longer
> required.
>
> Tested by running lockdep+ftrace as described in the initial commit:
>
>   5963e317b1e9 ("ftrace/x86: Do not change stacks in DEBUG when calling lockdep")

Acked-by: Andy Lutomirski <luto@kernel.org>
