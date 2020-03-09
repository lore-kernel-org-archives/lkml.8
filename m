Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52D5C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:52:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D00D20663
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="GYqByHGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727464AbgCISwm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:52:42 -0400
Received: from mail.efficios.com ([167.114.26.124]:42734 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbgCISwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:52:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7A6EC268442;
        Mon,  9 Mar 2020 14:52:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id unUE-b_3TSZu; Mon,  9 Mar 2020 14:52:40 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 336B2268722;
        Mon,  9 Mar 2020 14:52:40 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 336B2268722
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583779960;
        bh=pE8bJ9ixsc7cm2JfC2ndvLTF4nXTDmZja0Dbm38GqhM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=GYqByHGEkCTsDiWNmXVoDMf+F0+Xg+MvIb3gf7SAq62tWNg2Ok9zz+tb+J2ZPmEvi
         czlzV2bCpyas3Lc+++jfI3rxJxfFMR48C0Zq4i3k9p2uoMqEgB5DSGQLPlFnj7QBh1
         Cd6966Ss+9ilIBAzNku7N6lyZutGwVGbULDy8/V1qUBmEjW/BZyl9+Zzbs/CY38lGz
         L/5dhsnJgcavErn+qvesncShw/2UnWd3r2O39AczFSWyqE/44MQrSSb/m2szrpyfJQ
         jMqkyO2dVd+N5A8uhQD5/sygPOGaRFfYtdtZTLLcbILXO3dHNczuTp46d7i45pV6Tt
         IDG38QXW9Wcvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id if5RhueP52Ff; Mon,  9 Mar 2020 14:52:40 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 26AA3268441;
        Mon,  9 Mar 2020 14:52:40 -0400 (EDT)
Date:   Mon, 9 Mar 2020 14:52:40 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        paulmck <paulmck@kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Frederic Weisbecker <frederic@kernel.org>
Message-ID: <1851876075.21840.1583779960064.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200309144427.0ce0eabc@gandalf.local.home>
References: <87mu8p797b.fsf@nanos.tec.linutronix.de> <1403546357.21810.1583779060302.JavaMail.zimbra@efficios.com> <20200309144427.0ce0eabc@gandalf.local.home>
Subject: Re: Instrumentation and RCU
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: Instrumentation and RCU
Thread-Index: NW7KV4uXEwGhR5W3UrelonrIpWyYaQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 9, 2020, at 2:44 PM, rostedt rostedt@goodmis.org wrote:

> On Mon, 9 Mar 2020 14:37:40 -0400 (EDT)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> So I think we could go back to plain RCU for rcuidle tracepoints if we do
>> the cheaper "rcu_is_watching()" check rather than invoking
>> rcu_irq_{enter,exit}_irqson() unconditionally.
> 
> You mean something like this?

I have a hard time applying this patch to any tree I can fetch, so
I will use caution and say: probably not. ;-)

And when I say "go back to plain RCU", I really mean removing use of SRCU
from the tracepoints until we have other purposes for it (e.g. taking
faults within specific tracepoint probes such as syscall enter/exit).

Thanks,

Mathieu

> 
> -- Steve
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 5f4de82ffa0f..1904dbb3a921 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -164,7 +164,7 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 		struct tracepoint_func *it_func_ptr;			\
> 		void *it_func;						\
> 		void *__data;						\
> -		int __maybe_unused __idx = 0;				\
> +		int __maybe_unused __idx = -1;				\
> 									\
> 		if (!(cond))						\
> 			return;						\
> @@ -179,8 +179,8 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 		 * For rcuidle callers, use srcu since sched-rcu	\
> 		 * doesn't work from the idle path.			\
> 		 */							\
> -		if (rcuidle)						\
> -			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
> +		if (rcuidle && !rcu_is_watching())			\
> +			__idx = srcu_read_lock_notrace(&tracepoint_srcu); \
> 									\
> 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
> 									\
> @@ -199,7 +199,7 @@ static inline struct tracepoint
> *tracepoint_ptr_deref(tracepoint_ptr_t *p)
> 			} while ((++it_func_ptr)->func);		\
> 		}							\
> 									\
> -		if (rcuidle)						\
> +		if (rcuidle && __idx != -1)				\
> 			rcu_irq_exit_irqson();				\
> 									\
>  		preempt_enable_notrace();				\

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
