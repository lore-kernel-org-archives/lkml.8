Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3364AC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F45920775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD0TNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:13:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726364AbgD0TNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:13:50 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C9D38206B8;
        Mon, 27 Apr 2020 19:13:49 +0000 (UTC)
Date:   Mon, 27 Apr 2020 15:13:48 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] tracing/x86: fix trace event registration for syscalls
 without arguments
Message-ID: <20200427151348.6a55abd9@gandalf.local.home>
In-Reply-To: <adafb601-d1e7-b95b-ae31-fa3844a48851@yandex-team.ru>
References: <158636958997.7900.16485049455470033557.stgit@buzz>
        <adafb601-d1e7-b95b-ae31-fa3844a48851@yandex-team.ru>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020 16:16:20 +0300
Konstantin Khlebnikov <khlebnikov@yandex-team.ru> wrote:

> Bump, bug still present in 5.7.0-rc3
> 
> root@kernel0:~# uname -r
> 5.7.0-rc3-test
> 
> root@kernel0:~# ls -d /sys/kernel/tracing/events/syscalls/sys_enter_{sync,fsync}
> ls: cannot access '/sys/kernel/tracing/events/syscalls/sys_enter_sync': No such file or directory
> /sys/kernel/tracing/events/syscalls/sys_enter_fsync
> 
> On 08/04/2020 21.13, Konstantin Khlebnikov wrote:
> > Syscalls without arguments now has no ABI subs, instead of that macro
> > SYSCALL_DEFINE0() defines __abi_sys_name as aliase to __do_sys_name.
> > 
> > As a result in find_syscall_meta() kallsyms_lookup() returns
> > "__do_sys_name" which does not match with declared trace event.
> > 
> > Also see commit 1c758a2202a6 ("tracing/x86: Update syscall trace events
> > to handle new prefixed syscall func names")

This is the first I've seen of this patch.

> > 
> > Fixes: d2b5de495ee9 ("x86/entry: Refactor SYSCALL_DEFINE0 macros")
> > Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> > ---
> >   arch/x86/include/asm/ftrace.h |    5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> > index 85be2f506272..70b96cae5b42 100644
> > --- a/arch/x86/include/asm/ftrace.h
> > +++ b/arch/x86/include/asm/ftrace.h
> > @@ -61,11 +61,12 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
> >   {
> >   	/*
> >   	 * Compare the symbol name with the system call name. Skip the
> > -	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
> > +	 * "__x64_sys", "__ia32_sys", "__do_sys" or simple "sys" prefix.
> >   	 */
> >   	return !strcmp(sym + 3, name + 3) ||
> >   		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
> > -		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
> > +		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3)) ||
> > +		(!strncmp(sym, "__do_sys", 8) && !strcmp(sym + 8, name + 3));
> >   }

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve

> >   
> >   #ifndef COMPILE_OFFSETS
> >   

