Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B83CC4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 553A224694
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 15:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbgBZPFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 10:05:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51796 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgBZPFk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 10:05:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19D53ACE0;
        Wed, 26 Feb 2020 15:05:39 +0000 (UTC)
Date:   Wed, 26 Feb 2020 16:05:37 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Thomas Gleixner <tglx@linutronix.de>
cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch 03/15] x86/entry: Add IRQENTRY_IRQ macro
In-Reply-To: <20200225231609.216265343@linutronix.de>
Message-ID: <alpine.LSU.2.21.2002261604350.25150@pobox.suse.cz>
References: <20200225224719.950376311@linutronix.de> <20200225231609.216265343@linutronix.de>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  
> +/* Entries for common/spurious (device) interrupts */
> +#define DECLARE_IDTENTRY_IRQ(vector, func)			\
> +	idtentry_irq vector func
> +

idtentry_irq is defined in the next patch (04/15). Wouldn't it be better 
to move it here?

Miroslav
