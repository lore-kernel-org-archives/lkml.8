Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B12C35E0D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9784F2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgBYRxi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:36720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731067AbgBYRxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:53:37 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB96F20838;
        Tue, 25 Feb 2020 17:53:36 +0000 (UTC)
Date:   Tue, 25 Feb 2020 12:53:35 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bootconfig: Fix CONFIG_BOOTTIME_TRACING dependency
 issue
Message-ID: <20200225125335.5bbc3ed4@gandalf.local.home>
In-Reply-To: <c9604764-bd0f-67e9-56c8-fb6ffaf9b430@infradead.org>
References: <20200225220551.d9a409bc04b77cdf48eae3ea@kernel.org>
        <158264140162.23842.11237423518607465535.stgit@devnote2>
        <c9604764-bd0f-67e9-56c8-fb6ffaf9b430@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 09:49:25 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> > Fixes: d8a953ddde5e ("bootconfig: Set CONFIG_BOOT_CONFIG=n by default")
> > Reported-by: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>  
> 
> Hi,
> I'm no fan of "select", but this does fix the kconfig warnings and
> build errors that I have reported.  Thanks.

I'm not big on select either, but this is fine (I'm running it through my
tests now).

> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Is it OK if I change this to "Tested-by:"?

-- Steve
