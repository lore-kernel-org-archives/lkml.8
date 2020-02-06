Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984A6C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73457218AC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgBFWj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgBFWj4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:39:56 -0500
Received: from oasis.local.home (unknown [12.156.218.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7090F214AF;
        Thu,  6 Feb 2020 22:39:54 +0000 (UTC)
Date:   Thu, 6 Feb 2020 17:39:45 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [for-next][PATCH 04/26] bootconfig: Add Extra Boot Config
 support
Message-ID: <20200206173945.0596d32a@oasis.local.home>
In-Reply-To: <7280e507-cafd-f981-88b5-0e7d375e26d4@infradead.org>
References: <20200114210316.450821675@goodmis.org>
        <20200114210336.259202220@goodmis.org>
        <20200206115405.GA22608@zn.tnic>
        <20200206234100.953b48ecef04f97c112d2e8b@kernel.org>
        <20200206175858.GG9741@zn.tnic>
        <7280e507-cafd-f981-88b5-0e7d375e26d4@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020 10:10:28 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> old news: some Kconfig symbols are Special & Important.  ;)

Well, to me its as important as the kernel command line itself, and
printk(). I know printk() can be disabled, should that be default 'n'?

What I really like about this, is that you can have custom kernel
configs for each initrd. My fear is if this is default off, an initrd
that use to boot may no longer boot, because of a forgotten enabling of
this.

-- Steve
