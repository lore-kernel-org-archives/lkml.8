Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791CFC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 11:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F02320825
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 11:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="F5eKxJj+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387772AbgEWLQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 07:16:15 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:52279 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728006AbgEWLQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 07:16:15 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49TglX39TCz9sRK;
        Sat, 23 May 2020 21:16:08 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590232573;
        bh=XdJ4GsUtyCeZgpbb9v8CA5sMkmlRwqHwNrM4xAXS61k=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=F5eKxJj+Hlk8PWkkgX8L7qfqOyREq18UpzzW44RqnKPs0k1u3h76rDnoVchsW4VM+
         MxQ+0faOCx2NxDdKdOSyGLXnN1BXavZQ4kLw+q+SzvtRFC8KDpJscsm/MZ8RXvZMli
         Uik9xq6s4cn6WDZB8RPYvlPHJT9+AX4PoHzD6RdUnV2nqz75vbevwWu8uL+pnDNM+6
         HusW3zRwShhbSgnylftW/6wvDZ1VPVzMrZC88gNUrOk09sKOUTn0KYLirLPXVJPpxe
         muBDDnC/UwyxIqgqk0NEPRmFf7T7Cj4eCZitvEX+FQehuYA+CSviqkgXAzKN7rrxc8
         ZS3RyK3piRHSw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Kees Cook <keescook@chromium.org>, Petr Mladek <pmladek@suse.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Benson Leung <bleung@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/6] printk: Collapse shutdown types into a single dump reason
In-Reply-To: <20200515184434.8470-2-keescook@chromium.org>
References: <20200515184434.8470-1-keescook@chromium.org> <20200515184434.8470-2-keescook@chromium.org>
Date:   Sat, 23 May 2020 21:16:30 +1000
Message-ID: <87pnaugaup.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:
> To turn the KMSG_DUMP_* reasons into a more ordered list, collapse
> the redundant KMSG_DUMP_(RESTART|HALT|POWEROFF) reasons into
> KMSG_DUMP_SHUTDOWN. The current users already don't meaningfully
> distinguish between them, so there's no need to, as discussed here:
> https://lore.kernel.org/lkml/CA+CK2bAPv5u1ih5y9t5FUnTyximtFCtDYXJCpuyjOyHNOkRdqw@mail.gmail.com/
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/powerpc/kernel/nvram_64.c | 4 +---
>  fs/pstore/platform.c           | 8 ++------
>  include/linux/kmsg_dump.h      | 4 +---
>  kernel/reboot.c                | 6 +++---
>  4 files changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
> index fb4f61096613..0cd1c88bfc8b 100644
> --- a/arch/powerpc/kernel/nvram_64.c
> +++ b/arch/powerpc/kernel/nvram_64.c
> @@ -655,9 +655,7 @@ static void oops_to_nvram(struct kmsg_dumper *dumper,
>  	int rc = -1;
>  
>  	switch (reason) {
> -	case KMSG_DUMP_RESTART:
> -	case KMSG_DUMP_HALT:
> -	case KMSG_DUMP_POWEROFF:
> +	case KMSG_DUMP_SHUTDOWN:
>  		/* These are almost always orderly shutdowns. */
>  		return;
>  	case KMSG_DUMP_OOPS:

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
