Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E139C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AD92076D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 13:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594993715;
	bh=A/hm+ncUzrilRPL6Iq4RL68tleP0XF+QknAVyixwc1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=k7RFJutu0nCYRpwWTGHm8TXGY6DiW12B/mcHfqiZfGHa2DINFXqA6BFlURhwAfPzJ
	 BTP4DHv9DwiIJG9d6F6QsO1R6coB30RxWhgvY77j+pZQM+OHCBZ5yHmvitd7mBdf9k
	 pB+epztiC5YbK4BBbFvlPrlqhMuEVtOu4oOsCPGs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgGQNsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 09:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:39536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgGQNsc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 09:48:32 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07E9E2076A;
        Fri, 17 Jul 2020 13:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594993712;
        bh=A/hm+ncUzrilRPL6Iq4RL68tleP0XF+QknAVyixwc1g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CvOlz5oabVzstaOLVZA61byXNbjnvEktZKypAf7I3zp3ssUX3umwgbYI67tlmWbpr
         26D6NXncecHSsTC2cJ8rycyhNySsKMgBDS+r3DJr201xopxc69WB7rL2dsdtv9wOQP
         4DdCDro/S8Hbq2zGvJ8lIAccd2ZW/vts0mBz4DzQ=
Date:   Fri, 17 Jul 2020 22:48:26 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>, sumit.garg@linaro.org,
        pmladek@suse.com, sergey.senozhatsky@gmail.com, will@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2 0/3] kgdb: Honour the kprobe blacklist when setting
 breakpoints
Message-Id: <20200717224826.80f8353e5dfdfaab22421385@kernel.org>
In-Reply-To: <20200716151943.2167652-1-daniel.thompson@linaro.org>
References: <20200716151943.2167652-1-daniel.thompson@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Thu, 16 Jul 2020 16:19:40 +0100
Daniel Thompson <daniel.thompson@linaro.org> wrote:

> kgdb has traditionally adopted a no safety rails approach to breakpoint
> placement. If the debugger is commanded to place a breakpoint at an
> address then it will do so even if that breakpoint results in kgdb
> becoming inoperable.
> 
> A stop-the-world debugger with memory peek/poke intrinsically provides
> its operator with the means to hose their system in all manner of
> exciting ways (not least because stopping-the-world is already a DoS
> attack ;-) ). Nevertheless the current no safety rail approach is
> difficult to defend, especially given kprobes can provide us with plenty
> of machinery to mark the parts of the kernel where breakpointing is
> discouraged.
> 
> This patchset introduces some safety rails by using the existing kprobes
> infrastructure and ensures this will be enabled by default on
> architectures that implement kprobes. At present it does not cover
> absolutely all locations where breakpoints can cause trouble but it will
> block off several avenues, including the architecture specific parts
> that are handled by arch_within_kprobe_blacklist().

This series looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

To fix the build error with ipw2x00 driver, please feel free to
include my fix patch.

Thank you,

> 
> 
> Daniel Thompson (3):
>   kgdb: Honour the kprobe blocklist when setting breakpoints
>   kgdb: Use the kprobe blocklist to limit single stepping
>   kgdb: Add NOKPROBE labels on the trap handler functions
> 
>  include/linux/kgdb.h        | 19 +++++++++++++++++++
>  kernel/debug/debug_core.c   | 25 +++++++++++++++++++++++++
>  kernel/debug/gdbstub.c      | 10 +++++++++-
>  kernel/debug/kdb/kdb_bp.c   | 17 +++++++++++------
>  kernel/debug/kdb/kdb_main.c | 10 ++++++++--
>  lib/Kconfig.kgdb            | 14 ++++++++++++++
>  6 files changed, 86 insertions(+), 9 deletions(-)
> 
> --
> 2.25.4
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
