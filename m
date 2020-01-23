Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A141C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C64922522
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:36:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wsgMKH/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAWJgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:36:18 -0500
Received: from merlin.infradead.org ([205.233.59.134]:60542 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbgAWJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YixZocxPtvbPBg+61NfVP/W8TQN9iRjk5ZtElvThCac=; b=wsgMKH/3+zhqxyAE0Yn4q+6ZNM
        1i3hdKBlyLh13TkJcOydPEUGqTACaIsumP7f4saKJMOf9CotWZyy7cQol+DrVydLgWlquRUj1R/+A
        QTtk/hlHgTdnyuzwgO2xpEAHHeAYZS/v0+nGoUaorAkteno8SiiQJEF+jczEOeVLgq/5M1hZqeRPW
        jGyaWRn4+jQkfd5mAilEiDw+XSoDA/hWa4jyJ9JUsnINqttpc0E/2L3E2QG8fiJKqlzIBjal2EsVG
        hN9qn5NhMhngueMvfbdw01OKeC/8f3T90IhuigH3lrLYVJhggjeqz952q50KeVMJP5T0ZaK7+5m3Q
        93HnfLGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iuYuE-0002qM-Jg; Thu, 23 Jan 2020 09:36:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E8574300B8D;
        Thu, 23 Jan 2020 10:34:24 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DE3D42B70D34E; Thu, 23 Jan 2020 10:36:04 +0100 (CET)
Date:   Thu, 23 Jan 2020 10:36:04 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Qian Cai <cai@lca.pw>, Will Deacon <will@kernel.org>,
        mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Message-ID: <20200123093604.GT14914@hirez.programming.kicks-ass.net>
References: <20200122165938.GA16974@willie-the-truck>
 <A5114711-B8DE-48DA-AFD0-62128AC08270@lca.pw>
 <20200122223851.GA45602@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200122223851.GA45602@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:38:51PM +0100, Marco Elver wrote:

> If possible, decode and get the line numbers. I have observed a data
> race in osq_lock before, however, this is the only one I have recently
> seen in osq_lock:
> 
> read to 0xffff88812c12d3d4 of 4 bytes by task 23304 on cpu 0:
>  osq_lock+0x170/0x2f0 kernel/locking/osq_lock.c:143
> 
> 	while (!READ_ONCE(node->locked)) {
> 		/*
> 		 * If we need to reschedule bail... so we can block.
> 		 * Use vcpu_is_preempted() to avoid waiting for a preempted
> 		 * lock holder:
> 		 */
> -->		if (need_resched() || vcpu_is_preempted(node_cpu(node->prev)))
> 			goto unqueue;
> 
> 		cpu_relax();
> 	}
> 
> where
> 
> 	static inline int node_cpu(struct optimistic_spin_node *node)
> 	{
> -->		return node->cpu - 1;
> 	}
> 
> 
> write to 0xffff88812c12d3d4 of 4 bytes by task 23334 on cpu 1:
>  osq_lock+0x89/0x2f0 kernel/locking/osq_lock.c:99
> 
> 	bool osq_lock(struct optimistic_spin_queue *lock)
> 	{
> 		struct optimistic_spin_node *node = this_cpu_ptr(&osq_node);
> 		struct optimistic_spin_node *prev, *next;
> 		int curr = encode_cpu(smp_processor_id());
> 		int old;
> 
> 		node->locked = 0;
> 		node->next = NULL;
> -->		node->cpu = curr;
> 

Yeah, that's impossible. This store happens before the node is
published, so no matter how the load in node_cpu() is shattered, it must
observe the right value.
