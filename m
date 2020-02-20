Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7269BC11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C2F6208CD
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgBTROf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:14:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTROe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:14:34 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89DAE20801;
        Thu, 20 Feb 2020 17:14:33 +0000 (UTC)
Date:   Thu, 20 Feb 2020 12:14:31 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 4/8] bootconfig: Remove unneeded checksum
Message-ID: <20200220121431.0de871fe@gandalf.local.home>
In-Reply-To: <158220114239.26565.3917262826354805559.stgit@devnote2>
References: <158220110257.26565.4812934676257459744.stgit@devnote2>
        <158220114239.26565.3917262826354805559.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 21:19:02 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Remove checksum of bootconfig because we already use a magic
> word to identify bootconfig. This checksum was used for
> checking whether there is a bootconfig at the end of initrd
> or not. Since we have a bootconfig magic word to identify
> the bootconfig data, we do not this checksum anymore.
> 
> Thus the block image of the initrd file with bootconfig is
> as follows.
> 
> [initrd][bootconfig][size(u32)][#BOOTCONFIG\n]
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>

Hmm, I think the checksum is still good to have, in case of a corrupted
file. Does it hurt to keep it?

-- Steve
