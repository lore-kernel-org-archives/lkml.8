Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB46BC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:02:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A98FE20756
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BbUjf0Dx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730823AbgEVSCV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 14:02:21 -0400
Received: from merlin.infradead.org ([205.233.59.134]:51392 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730674AbgEVSCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 14:02:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BzGVoYi7lusRQAJzrnCE6lDqe1qUxbheoT+A3b9PhsQ=; b=BbUjf0DxmZbE7vMsoDTX+agpyC
        vQk96e0N/CKRdTq03SRxDoA9kXQTJHweJuNq4kAm1mJZBrgQ3CfZBbhhZKZeCPgQTPDSwS7yq3FVo
        grzskRCdDWF2XZ3/EYZHw0QyNmRerw6gQDI851fIr5nhuBF26xSIIbsdU4+S5MqoHXqvc7oKodXTO
        9Zm+wZZqSQpl3yXh7DSYVnVlAnJxGk6necklRg1aamOQg6Bwbu2SuW38AziE97XMp73yCHautbsfE
        Zh4RbLZIfOApClRpQsxDKg+GHRPRsmb8+Kt6EzhtM8V+04yMuD3yCDOC1Q7/P2w79rlI6e1MmdpZY
        vasXWTFw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jcBzP-0008Cl-Sb; Fri, 22 May 2020 18:01:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8530C301AC6;
        Fri, 22 May 2020 20:01:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 756A62B7F3D20; Fri, 22 May 2020 20:01:45 +0200 (CEST)
Date:   Fri, 22 May 2020 20:01:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 09/25] Documentation: locking: Describe seqlock design
 and usage
Message-ID: <20200522180145.GR325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-10-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519214547.352050-10-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:45:31PM +0200, Ahmed S. Darwish wrote:
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index d35be7709403..2a4af746b1da 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1,36 +1,15 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef __LINUX_SEQLOCK_H
>  #define __LINUX_SEQLOCK_H
> +
>  /*
> - * Reader/writer consistent mechanism without starving writers. This type of
> - * lock for data where the reader wants a consistent set of information
> - * and is willing to retry if the information changes. There are two types
> - * of readers:
> - * 1. Sequence readers which never block a writer but they may have to retry
> - *    if a writer is in progress by detecting change in sequence number.
> - *    Writers do not wait for a sequence reader.
> - * 2. Locking readers which will wait if a writer or another locking reader
> - *    is in progress. A locking reader in progress will also block a writer
> - *    from going forward. Unlike the regular rwlock, the read lock here is
> - *    exclusive so that only one locking reader can get it.
> + * seqcount_t / seqlock_t - a reader-writer consistency mechanism with
> + * lockless readers (read-only retry loops), and no writer starvation.
>   *
> - * This is not as cache friendly as brlock. Also, this may not work well
> - * for data that contains pointers, because any writer could
> - * invalidate a pointer that a reader was following.
> + * See Documentation/locking/seqlock.rst for full description.

So I really really hate that... I _much_ prefer code comments to crappy
documents.
