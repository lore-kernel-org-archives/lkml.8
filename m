Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CB5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D71720A8B
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404857AbgFXQEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 12:04:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404503AbgFXQEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 12:04:11 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33C682077D;
        Wed, 24 Jun 2020 16:04:10 +0000 (UTC)
Date:   Wed, 24 Jun 2020 12:04:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>, dianders@chromium.org,
        groeck@chromium.org
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
Message-ID: <20200624120408.12c8fa0d@oasis.local.home>
In-Reply-To: <20200624084524.259560-1-drinkcat@chromium.org>
References: <20200624084524.259560-1-drinkcat@chromium.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 16:45:24 +0800
Nicolas Boichat <drinkcat@chromium.org> wrote:

> trace_printk is only meant as a debugging tool, and should never be
> compiled into production code without source code changes, as
> indicated by the warning that shows up on boot if any trace_printk
> is called:
>  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
>  **                                                      **
>  ** trace_printk() being used. Allocating extra memory.  **
>  **                                                      **
>  ** This means that this is a DEBUG kernel and it is     **
>  ** unsafe for production use.                           **
> 
> If this option is set to n, the kernel will generate a build-time
> error if trace_printk is used.
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>

Interesting. Note, this will prevent modules with trace_printk from
being loaded as well.

-- Steve
