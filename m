Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E086EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF83A2084E
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 02:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583373933;
	bh=4/yYZeasUHcBXD9kPikDChohZZBiAD117w7wYjAcInY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Vg/nL5j5b0Bz6O47zHb/VjXBuOp5dnl1Ch/TvqpfdLMy3c57v6ESDwpviJAflugCU
	 vr+q9mFgVXOtdRPGn3JJaB4R6I9BR1XmLgtUBBLKitdmFJ31FEfEBIuyHgdmsQrivP
	 9h9A6a3Fercok+q9e//rHQaGKOpdJhjIEa8GQNXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgCECFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 21:05:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbgCECFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 21:05:32 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC28E20848;
        Thu,  5 Mar 2020 02:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583373931;
        bh=4/yYZeasUHcBXD9kPikDChohZZBiAD117w7wYjAcInY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ikcN1fWphYRKEFANggbbk/EdEVfFYDfl6T3xJ+49SDj7rNRp/tgUBaqL36YmVvSvH
         69jINLPxA3tuX9oAoBUUlwwRq+AdQPiwuENNRNCiJpIC7rwRjZt00ERNW2MqBTcnjW
         DVhzWvpUzzgSDe7496ABJLVloPibbaUp07jlY6kg=
Date:   Thu, 5 Mar 2020 11:05:27 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/2] bootconfig: Support O=<builddir> option
Message-Id: <20200305110527.65bfeb515237fb81c8b69d42@kernel.org>
In-Reply-To: <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
References: <158323467008.10560.4307464503748340855.stgit@devnote2>
        <158323468033.10560.14661631369326294355.stgit@devnote2>
        <27ae25f5-29c6-62f3-5531-78fcc28b7d3c@infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Mar 2020 15:04:43 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 3/3/20 3:24 AM, Masami Hiramatsu wrote:
> > Support O=<builddir> option to build bootconfig tool in
> > the other directory. As same as other tools, if you specify
> > O=<builddir>, bootconfig command is build under <builddir>.
> 
> Hm.  If I use
> $ make O=~/tmp -C tools/bootconfig
> 
> that works: it builds bootconfig in ~/tmp.
> 
> OTOH, if I sit at the top of the kernel source tree
> and I enter
> $ mkdir builddir
> $ make O=builddir -C tools/bootconfig
> 
> I get this:
> make: Entering directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
> ../scripts/Makefile.include:4: *** O=builddir does not exist.  Stop.
> make: Leaving directory '/home/rdunlap/lnx/next/linux-next-20200304/tools/bootconfig'
> 
> so it looks like tools/scripts/Makefile.include doesn't handle this case correctly
> (which is how I do all of my builds).

Yes, I think that should be fixed in another patch. What about below?

diff --git a/tools/scripts/Makefile.include b/tools/scripts/Makefile.include
index ded7a950dc40..6d2f3a1b2249 100644
--- a/tools/scripts/Makefile.include
+++ b/tools/scripts/Makefile.include
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 ifneq ($(O),)
 ifeq ($(origin O), command line)
-	dummy := $(if $(shell test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
-	ABSOLUTE_O := $(shell cd $(O) ; pwd)
+	dummy := $(if $(shell cd $(PWD); test -d $(O) || echo $(O)),$(error O=$(O) does not exist),)
+	ABSOLUTE_O := $(shell cd $(PWD); cd $(O) ; pwd)
 	OUTPUT := $(ABSOLUTE_O)/$(if $(subdir),$(subdir)/)
 	COMMAND_O := O=$(ABSOLUTE_O)
 ifeq ($(objtree),)


Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
