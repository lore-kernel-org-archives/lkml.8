Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C184C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C0D220747
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591879351;
	bh=L1QAzfDIJTaNMjeS4vXX3SCcFVvZ5SmhAVMUgbEjC8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=s3GsufJ6WeCFDM+74QqvD0AIxGDaYKBybw3KnnT80iM0ciybiO3MYT2MJKa6+SIy4
	 SD2zWKjgnydjbpNyCtASZhkMHuONZVY+4oANQQ4kdX1qeD9PGk/Ehi95naW839FxGt
	 cwFdrdgGQKx5DuHgN0gYgFI8US4Tl6xlZ2xmGF/A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFKMmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:52404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgFKMmQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:16 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AD26207ED;
        Thu, 11 Jun 2020 12:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591879335;
        bh=L1QAzfDIJTaNMjeS4vXX3SCcFVvZ5SmhAVMUgbEjC8o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vd5VoEajxjyibQSKqnM6tQFSKLeW7GNkcleAtFqB5TFOxQ2UXahssgIjrDl5vtJZJ
         pWaCzciklLlMcaWlioEEWcwh5tialB3j69uKlcwmh4LdPceYM/93Mkd+ErcLt/tzvM
         aVjsDMB2NZT0WR9RBDB5vCoMcLcya5cg9hsXn29g=
Date:   Thu, 11 Jun 2020 21:42:09 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        sumit.garg@linaro.org, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, will@kernel.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [RFC PATCH 0/4] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-Id: <20200611214209.bd8fcd290d745ae50d898e69@kernel.org>
In-Reply-To: <20200605142953.GP2750@hirez.programming.kicks-ass.net>
References: <20200605132130.1411255-1-daniel.thompson@linaro.org>
        <20200605142953.GP2750@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jun 2020 16:29:53 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Fri, Jun 05, 2020 at 02:21:26PM +0100, Daniel Thompson wrote:
> > kgdb has traditionally adopted a no safety rails approach to breakpoint
> > placement. If the debugger is commanded to place a breakpoint at an
> > address then it will do so even if that breakpoint results in kgdb
> > becoming inoperable.
> > 
> > A stop-the-world debugger with memory peek/poke does intrinsically
> > provide its operator with the means to hose their system in all manner
> > of exciting ways (not least because stopping-the-world is already a DoS
> > attack ;-) ) but the current no safety rail approach is not easy to
> > defend, especially given kprobes provides us with plenty of machinery to
> > mark parts of the kernel where breakpointing is discouraged.
> > 
> > This patchset introduces some safety rails by using the existing
> > kprobes infrastructure. It does not cover all locations where
> > breakpoints can cause trouble but it will definitely block off several
> > avenues, including the architecture specific parts that are handled by
> > arch_within_kprobe_blacklist().
> > 
> > This patch is an RFC because:
> > 
> > 1. My workstation is still chugging through the compile testing.
> > 
> > 2. Patch 4 needs more runtime testing.
> > 
> > 3. The code to extract the kprobe blacklist code (patch 4 again) needs
> >    more review especially for its impact on arch specific code.
> > 
> > To be clear I do plan to do the detailed review of the kprobe blacklist
> > stuff but would like to check the direction of travel first since the
> > change is already surprisingly big and maybe there's a better way to
> > organise things.
> 
> Thanks for doing these patches, esp 1-3 look very good to me.
> 
> I've taken the liberty to bounce the entire set to Masami-San, who is
> the kprobes maintainer for comments as well.

Thanks Peter to Cc me.

Reusing kprobe blacklist is good to me as far as it doesn't expand it
only for kgdb. For example, if a function which can cause a recursive
trap issue only when the kgdb puts a breakpoint, it should be covered
by kgdb blacklist, or we should make a "noinstr-list" including
both :)

Thus, Nack for PATCH 4/4, that seems a bit selfish change. If kgdb wants
to use the "kprobes blacklist", we should make CONFIG_KGDB depending on
CONFIG_KPROBES. Or, (as I pointed) we should make independent "noinstr-list"
and use it from both.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
