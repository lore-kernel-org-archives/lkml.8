Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC46C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33C53207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 14:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589983274;
	bh=BDNtqPfixaGPXHmy4aaEnNMCMcHQWxQTdhCB4L+54W4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=mXgQyoRK1T+6b4fv6KGXX0VlicZodaMouRbY4qLqidVVZfXDgNXDO8AyxHgmQ1ezT
	 +uVcIU6xmFV6m0csmX7o9ei43t2H4WVqDPzTsGUdoXH+xTGFJA3YFoYBZC9lqsG9lR
	 dqEWK+o61D7PHrjEgrn97gCRY1unCuwiSXk/W9Kg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgETOBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 10:01:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:47240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbgETOBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 10:01:13 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A922E20756;
        Wed, 20 May 2020 14:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589983268;
        bh=BDNtqPfixaGPXHmy4aaEnNMCMcHQWxQTdhCB4L+54W4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0TS6d83MvK9M9azZbyjEjOV13UPf0ijHKPiIJl5dhRUnxxkJD+aZLx+6p1NW94vFa
         BGJYMMFeQTlXaTNkxnjUzBxyyjav4BaeA61XxPhcg/bL/zJFSaAabxQARtHLw8nZro
         waynX92icbwJ86RCSKZ7URGqpykfkLTbHDjYTYPc=
Date:   Wed, 20 May 2020 23:01:03 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     =?UTF-8?B?546L56iL5Yia?= <wangchenggang@vivo.com>
Cc:     "'Steven Rostedt \(VMware'" <rostedt@goodmis.org>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Kees Cook'" <keescook@chromium.org>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Dominik Brodowski'" <linux@dominikbrodowski.net>,
        "'Arvind Sankar'" <nivedita@alum.mit.edu>,
        "'Mike Rapoport'" <rppt@linux.ibm.com>,
        "'Alexander Potapenko'" <glider@google.com>,
        <linux-kernel@vger.kernel.org>, <kernel@vivo.com>
Subject: Re: [PATCH] init/main.c: Print all command line when boot
Message-Id: <20200520230103.4b34de53c7d5f62368ca30b5@kernel.org>
In-Reply-To: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
References: <010201d62d8d$bf7605f0$3e6211d0$@vivo.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 May 2020 11:29:46 +0800
王程刚 <wangchenggang@vivo.com> wrote:

> Function pr_notice print max length maybe less than the command line length,
> need more times to print all.
> For example, arm64 has 2048 bytes command line length, but printk maximum
> length is only 1024 bytes.

Good catch, and if you use bootconfig, you can expand it longer than that.

> 
> Signed-off-by: Chenggang Wang <wangchenggang@vivo.com>
> ---
>  init/main.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/init/main.c b/init/main.c
> index 03371976d387..4cf676cc3305 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -825,6 +825,16 @@ void __init __weak arch_call_rest_init(void)
>  	rest_init();
>  }
>  
> +static void __init print_cmdline(void)
> +{
> +	const char *prefix = "Kernel command line: ";
> +	int len = -strlen(prefix);
> +
> +	len += pr_notice("%s%s\n", prefix, boot_command_line);

Why don't you use saved_command_line here? Those can be different
and the effective one is saved_command_line.

> +	while (boot_command_line[len])
> +		len += pr_notice("%s\n", &boot_command_line[len]);

Also, don't append "\n" unless you are sure there is an actual
option separator (not a space, because the option can be quoted.)

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
