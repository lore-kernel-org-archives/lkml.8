Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D715C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:51:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5358C207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:51:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rhCK9Muj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgGTBvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTBvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:51:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5239FC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:51:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id p1so7954803pls.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=O7ndZbT5qEKJ/XEIAl77Slw4yrcNUd2ImapnvXMAGJg=;
        b=rhCK9MujJTfDVyJrSZRsFYeBlPLhGmBShAMAJF55rDi7a80Ws+5VZsoW7rds38aBOL
         V/Vjb9uH2hHcdjU+5de/4G71YUI3P+xfqQYYRXe85aaA1b2AN7gwHjNMeQvOQRNvOefs
         FTZq6YF8YTMY4rcHkBZOWNfCqqF+W+4sya6qnBKnfIA7HkVa/p4vsG96LKj2lCMuBYUR
         SJOBSBXjgon/aiwAIzqptFC/tTh0TaurYIoh0hmpz0D/cO2Bwg+6S3wNwJf3zgC7wr8W
         94Ln/CLWgaO31vRtK0f00NbCT082RontR+dnnp8PaO0ArtN27KVyw54KbSCcnLKYUKne
         UpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O7ndZbT5qEKJ/XEIAl77Slw4yrcNUd2ImapnvXMAGJg=;
        b=tGiXbZ8m/67CKQ72g1aqO+UE/rJk8QeNRuEjBVyhIBVd0nnsZc7+1JMQcAOyCsTzh5
         hDne6VsKVuuawRNeuOZh/exr5zJPYjADMxWqsuKdyWnOJf70J7517hgTeDR3Ji8kiBXE
         ROZDMBJ10mhH2NaRshaB0uS2oxlFHi0Q0ql5GUvyGBqWOwHIF4Z2Nmib5abXrNydjUaO
         LD5IUm8NYiSysWgPJ8t9DDmgagtq7/o1dQN43cRxNthBkZ9BSuhm+TldtlQALYKJ6xDi
         P32N2RBO9YBQT7CWinlIxKbHt+0IxJCCU1z7ltbCnzhU9w5iq3JViSzpwEThP89Zn80i
         DgFw==
X-Gm-Message-State: AOAM532y2nsUU/y5aRU7DIdJ0JvCPPqr7hB2RxiU5LEfUfPKuXbWMCd5
        TBrkiHA4B+RupObYNphRX5U=
X-Google-Smtp-Source: ABdhPJzhJRwpFZdm99wWLVbs6bRETaeCYnjSApug/kFqCnCFDLTadLVrRpRgiq+Uzyb0D2S23wB8lA==
X-Received: by 2002:a17:90a:89:: with SMTP id a9mr21971215pja.171.1595209859713;
        Sun, 19 Jul 2020 18:50:59 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id c132sm14720972pfb.112.2020.07.19.18.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 18:50:59 -0700 (PDT)
Date:   Mon, 20 Jul 2020 10:50:57 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] printk: store instead of processing cont parts
Message-ID: <20200720015057.GA463@jagdpanzerIV.localdomain>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <20200717234818.8622-3-john.ogness@linutronix.de>
 <20200719143527.GA566@jagdpanzerIV.localdomain>
 <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg70es2rSYsHbBcWrBPsoHmbZ8vmeqTS_Kypv6zHAwQjA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/07/19 11:27), Linus Torvalds wrote:
> On Sun, Jul 19, 2020 at 7:35 AM Sergey Senozhatsky
> <sergey.senozhatsky@gmail.com> wrote:
> >
> > Can we merge lines that we don't want to merge?
> >
> >    pr_cont()  ->  IRQ -> pr_cont() -> NMI -> pr_cont()
> 
> That pr_cont in either IRQ or NMI context would be a bug.
> 
> You can't validly have a PR_CONT without the non-cont that precedes it.

Do I get it right, what you are saying is - when we process a PR_CONT
message the cont buffer should already contain previous non-LOG_NEWLINE
and non-PR_CONT message, otherwise it's a bug?

lockdep (I'll trim the code)

static void __print_lock_name(struct lock_class *class)
{
 ..
	name = class->name;
	if (!name) {
		name = __get_key_name(class->key, str);
		printk(KERN_CONT "%s", name);
	} else {
		printk(KERN_CONT "%s", name);
		if (class->name_version > 1)
			printk(KERN_CONT "#%d", class->name_version);
		if (class->subclass)
			printk(KERN_CONT "/%d", class->subclass);
	}
}

static void print_lock_name(struct lock_class *class)
{
	printk(KERN_CONT " (");
	__print_lock_name(class);
	printk(KERN_CONT "){%s}-{%hd:%hd}", usage, ...
}

static void
print_bad_irq_dependency(struct task_struct *curr,
{
 ..
	pr_warn("which would create a new lock dependency:\n");
	print_lock_name(hlock_class(prev));
	pr_cont(" ->");
	print_lock_name(hlock_class(next));
	pr_cont("\n");
 ..
}

pr_warn() is LOG_NEWLINE, so cont buffer is empty by the time
we call print_lock_name()->__print_lock_name(), which do several
pr_cont() print outs.

I'm quite sure there is more code that does similar things.

But, overall, isn't it by design that we can process pr_cont()
message with no preceding non-cont message? Because of preliminary
flushes. Example:

CPU0

 pr_info("foo");    // !LOG_NEWLINE goes into the cont buffer
 pr_cont("1");      // OK
 -> IRQ / NMI / exception / etc
 	pr_alert("error\n"); // flush cont buffer, log_store error message (it's LOG_NEWLINE)
 <- iret
 pr_cont("2");      // cont buffer was flushed. There is no preceding non-cont message
 pr_cont("3");
 pr_cont("\n");

Or am I misunderstanding what you saying?

	-ss
