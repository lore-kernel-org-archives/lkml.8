Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D9EC4BA06
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7163121927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 00:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582677355;
	bh=lUYW/JieFo+3U8SOTs/roekhtD0axcNdtmfgtPSYbuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KwZFAEGJSy8mGXlH0j+8A8nwCpVUUurkwuc/VFakyZTh1AYsjzwbjJ2V4B0yscGD1
	 kqu4DihT/UwLZEeWDx+S8rA3tnp8z9upvYg0m5gNXjquO4xmt+daz+OFonFtKZrZiP
	 Ed44OMEBC7R7qDy0rMI+33Ak0O7NPrhBK9/SIzC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729659AbgBZAfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 19:35:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:51156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgBZAfy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:35:54 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00A4F20732;
        Wed, 26 Feb 2020 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582677353;
        bh=lUYW/JieFo+3U8SOTs/roekhtD0axcNdtmfgtPSYbuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xneGdx4DAkXmtf4Ea+0hj91lq35cL7k6SkYoJ29ygmIQvE1kyfXePH+Bdupp2RQWZ
         exQ+mz7qeyCN18YhsFjKq2TmB7BAkJ9lH22aavaqVyDk45mXYhLKGQ7pFaTJfqlJ3z
         cXOQ5aUdqa7ZQnMQxUxOuiuG1bLV+zU59LP8GzG4=
Date:   Wed, 26 Feb 2020 01:35:51 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org
Subject: Re: [PATCH v4 09/27] rcu: Rename rcu_irq_{enter,exit}_irqson()
Message-ID: <20200226003550.GE9599@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.559644596@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.559644596@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:25PM +0100, Peter Zijlstra wrote:
> The functions do in fact use local_irq_{save,restore}() and can
> therefore be used when IRQs are in fact disabled. Worse, they are
> already used in places where IRQs are disabled, leading to great
> confusion when reading the code.
> 
> Rename them to fix this confusion.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

FWIW I'd have called that _irqsafe() as irqsave() suggests some return
value to later restore.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
