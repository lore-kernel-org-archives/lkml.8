Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109AAC54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:00:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E609220776
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 23:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDXXAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 19:00:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbgDXXAs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 19:00:48 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFDAB20736;
        Fri, 24 Apr 2020 23:00:47 +0000 (UTC)
Date:   Fri, 24 Apr 2020 19:00:46 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUGFIX PATCH 1/1] bootconfig: Fix to remove bootconfig data
 from initrd while boot
Message-ID: <20200424190046.0471c3b5@gandalf.local.home>
In-Reply-To: <158774605193.7423.573803007569761807.stgit@devnote2>
References: <158774604073.7423.11492815214537711118.stgit@devnote2>
        <158774605193.7423.573803007569761807.stgit@devnote2>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Apr 2020 01:34:12 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> If there is a bootconfig data in the tail of initrd/initramfs,
> initrd image sanity check caused an error while decompression
> stage as follows.
> 
> [    0.883882] Unpacking initramfs...
> [    2.696429] Initramfs unpacking failed: invalid magic at start of compressed archive
> 
> This error will be ignored if CONFIG_BLK_DEV_RAM=n,
> but CONFIG_BLK_DEV_RAM=y the kernel failed to mount rootfs
> and causes a panic.
> 
> To fix this issue, shrink down the initrd_end for removing
> tailing bootconfig data while boot the kernel.
> 
> Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: stable@vger.kernel.org
> ---

Thanks Masami! I pulled this into my urgent queue.

-- Steve
