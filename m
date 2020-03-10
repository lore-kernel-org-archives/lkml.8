Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53DDC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79B5A21927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="aFgrtOZZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727691AbgCJXog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:44:36 -0400
Received: from mail.efficios.com ([167.114.26.124]:34406 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJXof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:44:35 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 20C7A27476D;
        Tue, 10 Mar 2020 19:44:34 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id BJH6Vj_tmi3S; Tue, 10 Mar 2020 19:44:33 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CC528274B12;
        Tue, 10 Mar 2020 19:44:33 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com CC528274B12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1583883873;
        bh=z0CZ5BDP/bPYsfUHAyyCYLhKCiCgBs+Fa95vk3eflNY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=aFgrtOZZzlVg1Vq+mwn7SEQo+yDdeAUSCQ+yAeUaioV4yoU/W5PuL+t73Ro6mKR+9
         qlaEuPLgqS7+6xckue5Rmr69V8TFglYb2c+BLSG+cGYsnhRROEk2Vf1IMdlxE9NDh/
         5WsiretoccD5INP9CYWauB6Bo1Y/PD5GsdLTzA601wUIfL9rK1k1sItvoMA21APvBG
         3gyW7I7nosfTpLRyIaZAv2UbKkGyvVbxzdsXPXBLM6EtkJOicNYRFG5wlI8tYsNxtp
         8gWdr964dLmlPV0jRu+QgFhRUgZNnzX3nI7iFZiF8ENIRXGUvZMakjpe8zalBtsuOW
         UOSEl2O+8Uzpw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id QEdAuE4C3nIE; Tue, 10 Mar 2020 19:44:33 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id C0E16274B11;
        Tue, 10 Mar 2020 19:44:33 -0400 (EDT)
Date:   Tue, 10 Mar 2020 19:44:33 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     paulmck <paulmck@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        fweisbec <fweisbec@gmail.com>, Ingo Molnar <mingo@kernel.org>
Message-ID: <561555431.24628.1583883873699.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200310205319.GH2935@paulmck-ThinkPad-P72>
References: <20200310202054.5880-1-mathieu.desnoyers@efficios.com> <20200310205319.GH2935@paulmck-ThinkPad-P72>
Subject: Re: [PATCH] tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF73 (Linux)/8.8.15_GA_3895)
Thread-Topic: tracepoint: rcuidle: use rcu_is_watching() and tree-rcu
Thread-Index: vey7Ut0oe4XznGp7WKM844oLFaeAmQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Mar 10, 2020, at 4:53 PM, paulmck paulmck@kernel.org wrote:

> On Tue, Mar 10, 2020 at 04:20:54PM -0400, Mathieu Desnoyers wrote:
>> commit e6753f23d961 ("tracepoint: Make rcuidle tracepoint callers use
>> SRCU") aimed at improving performance of rcuidle tracepoints by using
>> SRCU rather than temporarily enabling tree-rcu every time.
>> 
>> commit 865e63b04e9b ("tracing: Add back in rcu_irq_enter/exit_irqson()
>> for rcuidle tracepoints") adds back the high-overhead enabling of
>> tree-rcu because perf expects RCU to be watching when called from
>> rcuidle tracepoints.
>> 
>> It turns out that by using "rcu_is_watching()" and conditionally
>> calling the high-overhead rcu_irq_enter/exit_irqson(), the original
>> motivation for using SRCU in the first place disappears.
> 
> Adding Alexei on CC for his thoughts, given that these were his
> benchmarks.  I believe that he also has additional use cases.

Good point! Sorry I forgot to add Alexei to my CC list for that
patch.

> But given the use cases you describe, this seems plausible.  This does
> mean that tracepoints cannot be attached to the CPU-hotplug code that
> runs on the incoming/outgoing CPU early/late in that process, though
> that might be OK.

Do you mean standard tracepoints or rcuidle tracepoints ?

Are there any such tracepoints early/late in the cpu hotplug code today ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
