Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B5FC2BA83
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 00:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1DC206DB
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 00:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBHAxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 19:53:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:33416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726995AbgBHAx3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 19:53:29 -0500
Received: from oasis.local.home (unknown [12.174.139.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9750206CC;
        Sat,  8 Feb 2020 00:53:27 +0000 (UTC)
Date:   Fri, 7 Feb 2020 19:53:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Mark Salyzyn <salyzyn@android.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] random: add rng-seed= command line option
Message-ID: <20200207195326.0344ef82@oasis.local.home>
In-Reply-To: <20200208004922.GE122530@mit.edu>
References: <20200207150809.19329-1-salyzyn@android.com>
        <20200207155828.GB122530@mit.edu>
        <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
        <20200208004922.GE122530@mit.edu>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2020 19:49:22 -0500
"Theodore Y. Ts'o" <tytso@mit.edu> wrote:


> My preference would be to pass in the random seed *not* on the
> command-line at all, but as a separate parameter which is passed to
> the bootloader, just as we pass in the device-tree, the initrd and the
> command-line as separate things.  The problem is that how we pass in
> extra boot parameters is architecture specific, and how we might do it
> for x86 is different than for arm64.  So yeah, it's a bit more
> inconvenient to do things that way; but I think it's also much
> cleaner.

Hmm, if the boot loader could add on to the bootconfig that Masami just
added, then it could add some "random" seed for each boot! The
bootconfig is just an appended file at the end of the initrd.

-- Steve
