Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F2DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FA720575
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="QpyHdQtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732769AbgEMXql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:46:41 -0400
Received: from mail.efficios.com ([167.114.26.124]:46456 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbgEMXql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:46:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 25E232BFCD6;
        Wed, 13 May 2020 19:46:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zdyYnyxu1i5k; Wed, 13 May 2020 19:46:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CF8D62BFF55;
        Wed, 13 May 2020 19:46:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CF8D62BFF55
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589413599;
        bh=hYcJuwIbx5ygOgCVc4s7f4GT06EL6D/GrL5te5eHrR4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=QpyHdQtqi4lW/p9NpFAY6WR5+Zzk3BsHT6s4s8XncXqwsLApkuBgsat64EeHiKpuS
         Y8/bHOaq6OTeNVq2ULfXc0pn5SDujrvYBsblYX2Myi235K5bPGsYgToqPVprjCnX5W
         xZJFTpWUhp90ohMI0srTHoM5MsqHe+bGpko/6zp4sxsg0gqysmyLVEhNzOmIMrN7MX
         getvc0RnuRM9ZjPlW9qNAsVV0o7bdpLbF8cvIZHN8LXKukt6O9LfZZ2ZH+VPp4Uchn
         LmZuObFe5D4UKp5SE0ZSNTGTnw8wAtqII7ImOZBPiFZvkd4AGcRyvIU40P/b5oeHq6
         SxH1wnNuouoJg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aONHcFiVDbEL; Wed, 13 May 2020 19:46:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id BBD342BFE29;
        Wed, 13 May 2020 19:46:39 -0400 (EDT)
Date:   Wed, 13 May 2020 19:46:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <365632030.20393.1589413599743.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134101.048523500@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134101.048523500@linutronix.de>
Subject: Re: [patch V4 part 1 30/36] lockdep: Always inline
 lockdep_{off,on}()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: lockdep: Always inline lockdep_{off,on}()
Thread-Index: v1XMf2ohSUFR6Yptr41TJyRdxIX6Cg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> + * Split the recrursion counter in two to readily detect 'off' vs recursion.

recrursion -> recursion

> + */
> +#define LOCKDEP_RECURSION_BITS	16
> +#define LOCKDEP_OFF		(1U << LOCKDEP_RECURSION_BITS)
> +#define LOCKDEP_RECURSION_MASK	(LOCKDEP_OFF - 1)
> +
> +/*
> + * lockdep_{off,on}() are macros to avoid tracing and kprobes; not inlines due
> + * to header dependencies.
> + */
> +
> +#define lockdep_off()					\
> +do {							\
> +	current->lockdep_recursion += LOCKDEP_OFF;	\
> +} while (0)
> +
> +#define lockdep_on()					\
> +do {							\
> +	current->lockdep_recursion -= LOCKDEP_OFF;	\
> +} while (0)

Now that those on/off are macros rather than functions, I wonder if
adding compiler barriers would be relevant ?

Thanks,

Mathieu

> 
> extern void lockdep_register_key(struct lock_class_key *key);
> extern void lockdep_unregister_key(struct lock_class_key *key);
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -393,25 +393,6 @@ void lockdep_init_task(struct task_struc
> 	task->lockdep_recursion = 0;
> }
> 
> -/*
> - * Split the recrursion counter in two to readily detect 'off' vs recursion.
> - */
> -#define LOCKDEP_RECURSION_BITS	16
> -#define LOCKDEP_OFF		(1U << LOCKDEP_RECURSION_BITS)
> -#define LOCKDEP_RECURSION_MASK	(LOCKDEP_OFF - 1)
> -
> -void lockdep_off(void)
> -{
> -	current->lockdep_recursion += LOCKDEP_OFF;
> -}
> -EXPORT_SYMBOL(lockdep_off);
> -
> -void lockdep_on(void)
> -{
> -	current->lockdep_recursion -= LOCKDEP_OFF;
> -}
> -EXPORT_SYMBOL(lockdep_on);
> -
> static inline void lockdep_recursion_finish(void)
> {
>  	if (WARN_ON_ONCE(--current->lockdep_recursion))

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
