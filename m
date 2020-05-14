Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B999C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE272054F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 01:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="vCn7iHjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727063AbgENBD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 21:03:59 -0400
Received: from mail.efficios.com ([167.114.26.124]:55540 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgENBD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 21:03:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 227EC2A0C69;
        Wed, 13 May 2020 21:03:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id qV-qlIZVrOTJ; Wed, 13 May 2020 21:03:57 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BB45A2A0CE1;
        Wed, 13 May 2020 21:03:57 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BB45A2A0CE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589418237;
        bh=hXBU3QUuInsUb1JtzUTfZZwJmkDP2Ma/nMGfhh4Bv7Y=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=vCn7iHjXgoTkMY6L1zFsV4k1tez3/LBSEtfNfJjJ1nq8vJbMplFHKL5B1ay1mIg7w
         +B0KBkmACsw5ah5DSGypnGIMoAFaO78E2vJP1TcJyO5kBAtGYqXQU6lOBfQt6unJTR
         lu4PXyi1PwJI+gtWIDjKupMKwSUloqoAxSqk91hRjKSTv/s2IDSlx0snaaVmwqfVci
         HeImMFnqWNEqKK+mt2Nxz7FhuN7xZQf2zV+XqA4DB/HHQo7zjCtkj9xj+w5MX24t7n
         TR7DgNLigMv3+iXkS9ZPVaPTkSvxNIzOUxPYyQ3clvNYEIl0gXp7hwrRcHIQDtrmzd
         g2rSSVv8Xe9TQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LIoA_XXQe_2s; Wed, 13 May 2020 21:03:57 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id A37B62A0DBA;
        Wed, 13 May 2020 21:03:57 -0400 (EDT)
Date:   Wed, 13 May 2020 21:03:57 -0400 (EDT)
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
        Will Deacon <will@kernel.org>
Message-ID: <1162756176.20618.1589418237644.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134904.364456424@linutronix.de>
References: <20200505134354.774943181@linutronix.de> <20200505134904.364456424@linutronix.de>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: Provide rcu_irq_exit_preempt()
Thread-Index: gfBm5HH4Gi6x4jgVEjQ8K0HuQTpl/g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:44 AM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> 
> +/**
> + * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
> + *			  towards in kernel preemption

Not sure what "towards in" means.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
