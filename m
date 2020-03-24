Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E337EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2ABF20774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585064323;
	bh=5TdNzYhbtu79d3LH4mgSqN1onpzmNEQFlvSIglXpQXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TP4jehXcLQvYPu5FpgTSQxtLLdn6NflXUUEqhSECNDkI/RADay8FnR0v9WXNY60YK
	 qQFPnzf+tDndMMckXjlAIlsaISQ8NxlKt/h2HJ68RQSMZvSWeBuEbQHt8LftcbAvEi
	 bEO95EAKYZzxtz44K4NQs94x6TUr9O1/kR0m3BBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgCXPim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727601AbgCXPik (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:38:40 -0400
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE2720714;
        Tue, 24 Mar 2020 15:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585064319;
        bh=5TdNzYhbtu79d3LH4mgSqN1onpzmNEQFlvSIglXpQXk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lkCV5+KAG2Vj6fL2EWoen1jj+N6/Fm1McDIF45bAs1lBOVA/Sl+E5YdeN1GBXIBMJ
         HPryegNdz9kLamMQad3OmVJ6uXP/61WbZ8GtbWDwwbyL9+XJIotJF6uqzcWIFMp7Nd
         6gtHhlrUbV1z7AaJuB6jbfBYjg2ccPoa6TTpthfA=
Date:   Tue, 24 Mar 2020 16:38:37 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Paul McKenney <paulmck@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Subject: Re: [patch V3 02/23] rcu: Add comments marking transitions between
 RCU watching and not
Message-ID: <20200324153837.GB20223@lenoir>
References: <20200320175956.033706968@linutronix.de>
 <20200320180032.614150506@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320180032.614150506@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 06:59:58PM +0100, Thomas Gleixner wrote:
> From: "Paul E. McKenney" <paulmck@kernel.org>
> 
> It is not as clear as it might be just where in RCU's idle entry/exit
> code RCU stops and starts watching the current CPU.  This commit therefore
> adds comments calling out the transitions.
> 
> Reported-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Link: https://lkml.kernel.org/r/20200313024046.27622-2-paulmck@kernel.org

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
