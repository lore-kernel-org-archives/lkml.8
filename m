Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB88C76562
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13B624656
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbgB0O1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:27:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:39326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387751AbgB0O1f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:27:35 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00655246AD;
        Thu, 27 Feb 2020 14:27:33 +0000 (UTC)
Date:   Thu, 27 Feb 2020 09:27:32 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 1/8] bootconfig: Set CONFIG_BOOT_CONFIG=n by default
Message-ID: <20200227092732.6a22a71a@gandalf.local.home>
In-Reply-To: <CAMuHMdWEoBrFRhmLEByhDCasuMrbGS4PreRivYRApdsME7x2AA@mail.gmail.com>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220111291.26565.9036889083940367969.stgit@devnote2>
        <CAMuHMdWEoBrFRhmLEByhDCasuMrbGS4PreRivYRApdsME7x2AA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Feb 2020 10:22:00 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > +
> > +static int __init warn_bootconfig(char *str)
> > +{
> > +       pr_warn("WARNING: 'bootconfig' found on the kernel command line but CONFIG_BOOTCONFIG is not set.\n");
> > +       return 0;
> > +}
> > +early_param("bootconfig", warn_bootconfig);  
> 
> Yeah, let's increases kernel size for the people who don't want to jump
> on the bootconfig wagon :-(
> 
> Is this really needed?

Yes, because if someone adds bootconfig to the command line they would be
expecting their bootconfig to be read. If not, we should not fail silently.

Are you really concerned about a tiny __init function that gets freed after
boot up?

-- Steve
