Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54424C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11D4224649
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581593103;
	bh=u89RHGxbm9J5ipnJ2KrUaoYIGThv2G7lF8zGF6Beppk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=yN1YBKSqE0BgSHO5x7HujvjRk6zgqCAEuRyQDsa3mMkyYZXOEegKQ2jNcxYqHuEb3
	 3vGrQKmwb5WbQ/afMTbsPfZiVMKLuT4wAWH8/CDECivDQVoZHIWPgqoojrCDnhaHZL
	 loYNBHlKzMW/PFLmX0GlNMvSAz/lJ3gXGELMxGh4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729772AbgBMLZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:25:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729428AbgBMLZC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:25:02 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77BEA2073C;
        Thu, 13 Feb 2020 11:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581593101;
        bh=u89RHGxbm9J5ipnJ2KrUaoYIGThv2G7lF8zGF6Beppk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IaWD/klxAnWV6lF4Cy+Rne9otNMrgt2GLA+FMZLnyrBVczVf+28JPuV5cZiQnGwbc
         1HkL4xhMzJVhlee33uIiEB4XnqW3nato4XVe7JwC+kCDJg3uIr73rreQJ6Y9olfJ10
         k+ujksx5S6FonNv7BA4aaXNo5QkqkrB5znZW+5kg=
Date:   Thu, 13 Feb 2020 20:24:54 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Mark Salyzyn <salyzyn@android.com>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-Id: <20200213202454.f1bb0e65ccc429bde039111b@kernel.org>
In-Reply-To: <20200207195326.0344ef82@oasis.local.home>
References: <20200207150809.19329-1-salyzyn@android.com>
        <20200207155828.GB122530@mit.edu>
        <d35bacd4-ba3f-335d-85c4-57e87abd8e9a@android.com>
        <20200208004922.GE122530@mit.edu>
        <20200207195326.0344ef82@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 7 Feb 2020 19:53:26 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Feb 2020 19:49:22 -0500
> "Theodore Y. Ts'o" <tytso@mit.edu> wrote:
> 
> 
> > My preference would be to pass in the random seed *not* on the
> > command-line at all, but as a separate parameter which is passed to
> > the bootloader, just as we pass in the device-tree, the initrd and the
> > command-line as separate things.  The problem is that how we pass in
> > extra boot parameters is architecture specific, and how we might do it
> > for x86 is different than for arm64.  So yeah, it's a bit more
> > inconvenient to do things that way; but I think it's also much
> > cleaner.
> 
> Hmm, if the boot loader could add on to the bootconfig that Masami just
> added, then it could add some "random" seed for each boot! The
> bootconfig is just an appended file at the end of the initrd.

Yeah, it is easy to add bootconfig support to a bootloader. It can add
a entropy number as "rng.seed=XXX" text after initrd image with size
and checksum. That is architecutre independent way to pass such hidden
parameter.
(hidden key must be filtered out when printing out the /proc/bootconfig,
but that is very easy too, just need a strncmp)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
