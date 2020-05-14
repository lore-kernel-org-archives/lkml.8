Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC065C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7AC9206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589431598;
	bh=zKLcKBv0BlEg4gzpxLldHmvEVK3LMckXWe4eq6osFzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=msTctMMEiyUa2kMLRoKudXrX4+Dp0qAwBlhT2bPR1IvQwXFXJHvVjElx6RSZGVI5n
	 xWjNz0ebpS8f1J24nQs9VLXES+8uT38WO9pjX3hbcXczI+F46PBtEwez1tfm0jSgJU
	 RBfG7w3jy5octprAWL7NgkXl0eT/LBb6GCF5mqzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgENEqh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33972 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENEqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:46:37 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A139206DC
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589431596;
        bh=zKLcKBv0BlEg4gzpxLldHmvEVK3LMckXWe4eq6osFzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o0Uu/yDX3iRg9P81iDfwju6nNGbjgmf/bIGLvZ0Q77/+L4BPkK33mg2NR6wsKSfbi
         gEXWsdqIX+rwihFDfelbtgzDQkW/8QmT2meHKXple+ONEc4RcremSgtPn3QLi7fBvy
         ygzIs+RoNlyZdfFvTly4BtShPjYAyG1FftLhZ+kM=
Received: by mail-wr1-f43.google.com with SMTP id 50so2074294wrc.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:46:36 -0700 (PDT)
X-Gm-Message-State: AOAM533K1gJoUBa4RMQ76MnG+AFwTfzCQ0veHZAwc97HCdOWkZef6Izg
        D66YybbJ4/54MJ8xWEBTYNRrzr+0J05LyEEAwWv3rQ==
X-Google-Smtp-Source: ABdhPJyaMuv58f05Aebmv504prA/xwPd4w/6wdI0NOJrves+4GBJPX/vuBpmjFVKU8WhJ/1g4ZW35eYaM6+jvBPOH1Y=
X-Received: by 2002:adf:f446:: with SMTP id f6mr3026281wrp.75.1589431595028;
 Wed, 13 May 2020 21:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134905.150248012@linutronix.de>
In-Reply-To: <20200505134905.150248012@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:46:23 -0700
X-Gmail-Original-Message-ID: <CALCETrU3bbbFL+a1Tx=w+QyBYh96bPjWX5dgO2UMh8ypcY6zLQ@mail.gmail.com>
Message-ID: <CALCETrU3bbbFL+a1Tx=w+QyBYh96bPjWX5dgO2UMh8ypcY6zLQ@mail.gmail.com>
Subject: Re: [patch V4 part 3 19/29] x86/entry: Convert Coprocessor segment
 overrun exception to IDTENTRY
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
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #OLD_MF to IDTENTRY:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
