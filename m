Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2D2C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CC4F20728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:16:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="LfbpGRCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgD0NQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:16:25 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:40362 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726539AbgD0NQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:16:25 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 775452E12B2;
        Mon, 27 Apr 2020 16:16:22 +0300 (MSK)
Received: from sas2-32987e004045.qloud-c.yandex.net (sas2-32987e004045.qloud-c.yandex.net [2a02:6b8:c08:b889:0:640:3298:7e00])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id tNwr2AI5mi-GLHaneK1;
        Mon, 27 Apr 2020 16:16:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1587993382; bh=xBhakYh3mD/x09iVGdm+GWvc9Gudb+FRDfRu28dcZVg=;
        h=In-Reply-To:Message-ID:Date:References:To:From:Subject:Cc;
        b=LfbpGRCeVoujIWmWwoY6QgsWJb09RtwsujJNbyYlrROYQzjzSj7iyj2Gg4b7ly7Kz
         8Vb1kjUCiLVkZ955ce1QcQcfqCa0gbejH6IGVxI91DTSgjoiWuAKkCP+/2PjNqAZxC
         bd2DIF3vs1s26h8pfCGfp6J7XEUC6KgPJNi7OVfM=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net [2a02:6b8:b080:7208::1:1])
        by sas2-32987e004045.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id YdlPsTsS3A-GKWmTCqs;
        Mon, 27 Apr 2020 16:16:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH] tracing/x86: fix trace event registration for syscalls
 without arguments
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
To:     Brian Gerst <brgerst@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
References: <158636958997.7900.16485049455470033557.stgit@buzz>
Message-ID: <adafb601-d1e7-b95b-ae31-fa3844a48851@yandex-team.ru>
Date:   Mon, 27 Apr 2020 16:16:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <158636958997.7900.16485049455470033557.stgit@buzz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bump, bug still present in 5.7.0-rc3

root@kernel0:~# uname -r
5.7.0-rc3-test

root@kernel0:~# ls -d /sys/kernel/tracing/events/syscalls/sys_enter_{sync,fsync}
ls: cannot access '/sys/kernel/tracing/events/syscalls/sys_enter_sync': No such file or directory
/sys/kernel/tracing/events/syscalls/sys_enter_fsync

On 08/04/2020 21.13, Konstantin Khlebnikov wrote:
> Syscalls without arguments now has no ABI subs, instead of that macro
> SYSCALL_DEFINE0() defines __abi_sys_name as aliase to __do_sys_name.
> 
> As a result in find_syscall_meta() kallsyms_lookup() returns
> "__do_sys_name" which does not match with declared trace event.
> 
> Also see commit 1c758a2202a6 ("tracing/x86: Update syscall trace events
> to handle new prefixed syscall func names")
> 
> Fixes: d2b5de495ee9 ("x86/entry: Refactor SYSCALL_DEFINE0 macros")
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>   arch/x86/include/asm/ftrace.h |    5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/ftrace.h b/arch/x86/include/asm/ftrace.h
> index 85be2f506272..70b96cae5b42 100644
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -61,11 +61,12 @@ static inline bool arch_syscall_match_sym_name(const char *sym, const char *name
>   {
>   	/*
>   	 * Compare the symbol name with the system call name. Skip the
> -	 * "__x64_sys", "__ia32_sys" or simple "sys" prefix.
> +	 * "__x64_sys", "__ia32_sys", "__do_sys" or simple "sys" prefix.
>   	 */
>   	return !strcmp(sym + 3, name + 3) ||
>   		(!strncmp(sym, "__x64_", 6) && !strcmp(sym + 9, name + 3)) ||
> -		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3));
> +		(!strncmp(sym, "__ia32_", 7) && !strcmp(sym + 10, name + 3)) ||
> +		(!strncmp(sym, "__do_sys", 8) && !strcmp(sym + 8, name + 3));
>   }
>   
>   #ifndef COMPILE_OFFSETS
> 
