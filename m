Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55472C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DB620737
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QxSjkDa8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgCKTzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:55:03 -0400
Received: from mail.skyhub.de ([5.9.137.197]:48822 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387418AbgCKTzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:55:02 -0400
Received: from zn.tnic (p200300EC2F12AA006409EF873197E31D.dip0.t-ipconnect.de [IPv6:2003:ec:2f12:aa00:6409:ef87:3197:e31d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4932B1EC0CE5;
        Wed, 11 Mar 2020 20:44:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1583955884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qhR6fZY9T1iS1MlozbrwkvsgypJ7t9l1Cqgx8z0l+kI=;
        b=QxSjkDa88cjKLLavCeDIljf3TJTfbpfbXYijlZarldmJUMiZo8E2ovyQL0oOO0w3QRL619
        4rZ5pA3j48Xqft54Rhc+/eNztqXUw93f+Y+SKPGkqGvHi+1vFhT1fIuqAugLvom2WqzvWf
        4p1J9rX8TTK11yvJ3fSlQV0Cex0eCWA=
Date:   Wed, 11 Mar 2020 20:44:46 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Jann Horn <jannh@google.com>,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-hardening@lists.openwall.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/6] x86/elf: Add table to document READ_IMPLIES_EXEC
Message-ID: <20200311194446.GL3470@zn.tnic>
References: <20200225051307.6401-1-keescook@chromium.org>
 <20200225051307.6401-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200225051307.6401-2-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ozenn Mon, Feb 24, 2020 at 09:13:02PM -0800, Kees Cook wrote:
> Add a table to document the current behavior of READ_IMPLIES_EXEC in
> preparation for changing the behavior.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  arch/x86/include/asm/elf.h | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
> index 69c0f892e310..733f69c2b053 100644
> --- a/arch/x86/include/asm/elf.h
> +++ b/arch/x86/include/asm/elf.h
> @@ -281,6 +281,25 @@ extern u32 elf_hwcap2;
>  /*
>   * An executable for which elf_read_implies_exec() returns TRUE will
>   * have the READ_IMPLIES_EXEC personality flag set automatically.
> + *
> + * The decision process for determining the results are:
> + *
> + *              CPU: | lacks NX*  | has NX, ia32     | has NX, x86_64 |
> + * ELF:              |            |                  |                |
> + * -------------------------------|------------------|----------------|
> + * missing GNU_STACK | exec-all   | exec-all         | exec-all       |
> + * GNU_STACK == RWX  | exec-all   | exec-all         | exec-all       |
> + * GNU_STACK == RW   | exec-none  | exec-none        | exec-none      |

In all those tables, you wanna do:

s/GNU_STACK/PT_GNU_STACK/g

so that it is clear what this define is.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
