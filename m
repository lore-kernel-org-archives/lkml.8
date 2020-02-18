Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A66C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085BC21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 17:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgBRR5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 12:57:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:37338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRR5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 12:57:50 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8713C20679;
        Tue, 18 Feb 2020 17:57:49 +0000 (UTC)
Date:   Tue, 18 Feb 2020 12:57:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-ID: <20200218125748.5085929c@gandalf.local.home>
In-Reply-To: <20200218132724.GC14449@zn.tnic>
References: <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <20200207114617.3bda49673175d3fa33cbe85e@kernel.org>
        <20200207114122.GB24074@zn.tnic>
        <20200208000648.3383f991fee68af5ee229d65@kernel.org>
        <20200210112512.GA29627@zn.tnic>
        <20200211001007.62290c743e049b231bdd7052@kernel.org>
        <20200210174053.GD29627@zn.tnic>
        <20200211110207.7e0f1b048cc207e1a31ddd31@kernel.org>
        <20200218132724.GC14449@zn.tnic>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Feb 2020 14:27:24 +0100
Borislav Petkov <bp@alien8.de> wrote:

> Btw, if you remove the boot config with the tool (-d) and still boot
> with "bootconfig" it says:
> 
> [    0.043958] bootconfig size -23483140 greater than max size 32767

I was aware of this but after you reported this, I don't like it.

Masami,

Can you add code to insert "magic" text at the start of the bootconfig
appended to the initrd file? Perhaps just have "BOOTCONFIG", and then
if it's not there we warn "bootconfig on command line but not found in
the initrd". I'm starting to not like relying on the size and checksum
only to determine if the bootconfig exists. We need to get this patch
before 5.6 is released.

> 
> so you need to check presence of bootconfig blob and limits in the
> parsing code too or so.
> 
> In any case, this is only my opinion, of course, and I might very well
> be missing something.

OK, what if we put it as default 'n' but we still check if "bootconfig"
is on the command line. And if it is, we warn with something like:

#ifndef CONFIG_BOOTCONFIG
	pr_err("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set in this kernel\n");
#endif

-- Steve

