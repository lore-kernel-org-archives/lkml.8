Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3F6FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A8F420708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934878;
	bh=PzODOPszK7QJGg/Pd4aGE1e041moSgSo4TpWtr4ybCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YC0cG+SZRy82u7H/lqcyTjTjvOq5ab0bR3NC6XkMn9xR6pAHMholtZvrYa/C38DSf
	 mzTqtjh8lCLzExZJL+ctHthUNaDb4HvBjdtpIP2IimN08ttDv7B+aON1nzDqjyttzZ
	 zisCmghF9JAS6+4QBr9arn3T+94ePZKLNk+j+p2s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgETAeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgETAeh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:34:37 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D4FB2088E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934876;
        bh=PzODOPszK7QJGg/Pd4aGE1e041moSgSo4TpWtr4ybCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=trWWJXX8op+fu6pgvYVSw25Z27AYPC5YP+IQyNji+o6E02Y+xAaVhoXXIT83O6JN+
         Y0+5dza5REnUS+EtfB1j5MjENJPKlH0/vr77ABtk/rsWyw7fRFL1tZRt1tsGaAqkuF
         qGnVk4PpfThhbrOq1eYJuPSpv9g0eUroy/Yzvkg4=
Received: by mail-wm1-f46.google.com with SMTP id w64so1107848wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:34:36 -0700 (PDT)
X-Gm-Message-State: AOAM533smvwbOSgK68dzJW2kdlss5SNz0A+Ik7tcuOq0jvzlEKERvxHP
        qGc4i/+EZoxrd24XR6Ge2ZXWj32MDGkouI4w+RClQA==
X-Google-Smtp-Source: ABdhPJzOFowFHUsqK6nOJ4QBbMuNarMpQnu3lzAt1u+BATbyGaJZTyGsU+pE5IcZTYy5WwNZd3gx1g/r1gEmrbqBmH0=
X-Received: by 2002:a1c:2bc2:: with SMTP id r185mr2059578wmr.49.1589934874890;
 Tue, 19 May 2020 17:34:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.699422368@linutronix.de>
In-Reply-To: <20200515235127.699422368@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:34:23 -0700
X-Gmail-Original-Message-ID: <CALCETrVA9R4aTwtibx5JaMT0wcDDc-S4=_oBwfE5FB7OQhsbXA@mail.gmail.com>
Message-ID: <CALCETrVA9R4aTwtibx5JaMT0wcDDc-S4=_oBwfE5FB7OQhsbXA@mail.gmail.com>
Subject: Re: [patch V6 33/37] x86/entry: Make enter_from_user_mode() static
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
> The ASM users are gone. All callers are local.

Acked-by: Andy Lutomirski <luto@kernel.org>
