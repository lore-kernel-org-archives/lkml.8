Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C29C34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ABD24671
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgBSPgS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:36:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:42162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726645AbgBSPgS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:36:18 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 403CE2465D;
        Wed, 19 Feb 2020 15:36:16 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:36:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove()
 notrace/NOKPROBE
Message-ID: <20200219103614.2299ff61@gandalf.local.home>
In-Reply-To: <20200219150744.604459293@infradead.org>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.604459293@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 15:47:28 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> --- a/arch/x86/lib/memcpy_32.c
> +++ b/arch/x86/lib/memcpy_32.c
> @@ -21,7 +21,7 @@ __visible void *memset(void *s, int c, s
>  }
>  EXPORT_SYMBOL(memset);
>  
> -__visible void *memmove(void *dest, const void *src, size_t n)
> +__visible notrace void *memmove(void *dest, const void *src, size_t n)
>  {
>  	int d0,d1,d2,d3,d4,d5;
>  	char *ret = dest;
> @@ -207,3 +207,8 @@ __visible void *memmove(void *dest, cons
>  
>  }
>  EXPORT_SYMBOL(memmove);

Hmm, for things like this, which is adding notrace because of a single
instance of it (although it is fine to trace in any other instance), it
would be nice to have a gcc helper that could call "memmove+5" which
would skip the tracing portion.

-- Steve
