Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72B9C2D0F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855892074F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 21:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkZV9t2h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgDHVM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 17:12:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37390 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgDHVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 17:12:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id z6so1427977wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=+AwwgEHFD5bilNHg0VD/JP6P2YBOrf+uHd0tB2xL4pE=;
        b=HkZV9t2hAwjvaNhBlInKGUCm/hr7/K/Ey+6xiClnyWaqye+9xiel5MCdKkVIKQ+4kI
         wI9jPSDGtZSRGvJTfzk2yFoyO4eObyDs0r/Jyse9iJx/i2u6HjeJriDGvfNYZCj/FJ6Q
         IDgu+b70BhF07VBMWANUNUnWhyt4h3GSVMFJsJWZmoRbY/8eFXBz6rAtRHJd22KdmAAl
         zqNClInIVowsg7lsCCRIuCEK/XJX1csE/bTALDy1j3WnoFWpcJApeb7ef6q74Nwqu4xc
         jEn8bm+Kt6pjX1kcSfnv7wyV1ujlLtgPPVMiueehgLrfhGFxsoiRjoI+HVW7WUM7Ernd
         5GWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=+AwwgEHFD5bilNHg0VD/JP6P2YBOrf+uHd0tB2xL4pE=;
        b=hcAFcz1GWIYPmOmuqX5cfB5bsb9QmTyqn/IRNJ7BaEJuToRXLwgBGUmP5qS2wNCEu4
         rLbA6SiRcnTeobkqIv/IiT2xyXvLwOwVSze05kxCQUqd56a7E8tvuF5RIX7weSnuYiAR
         JepeNrdxYJ57Hzrt6Lk8OyCnD7IsrPrYlUS2v3pv+T1phWNARzxtgFtADGJg6CPMK///
         OqxdHn5Efd+Kfyk3n0JXHIxRcZ+KeQiJkhRHqjwZ6RBZmUUa6TMRJZDyytPqzAgOX1In
         D1mzOcLxdSYXeHADX2W7Kh/5HgTs4oUwzDeYWuvJzvYikmolFnElAXLy6P1jFEcTSXw7
         /hiw==
X-Gm-Message-State: AGi0Pub/ecDFqEgIsc3LhnbWyU/ZdE+e1ahCSPWHUtVwn9yxMbbKWYmR
        qph+ZJ0GL+K5LLMSgGeOLkIDUbvMw9vw0UIo/wWKbm0z
X-Google-Smtp-Source: APiQypIEA+vymPWIIq5+2XuP34UflBloAgSXy7ew6JLfr6plXXbaqmNJRlxdTY3HEMwJyuv/xPkyzLlHszjkF8+Cgz0=
X-Received: by 2002:a7b:c927:: with SMTP id h7mr6424887wml.122.1586380375005;
 Wed, 08 Apr 2020 14:12:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200408205323.44490-1-natechancellor@gmail.com>
In-Reply-To: <20200408205323.44490-1-natechancellor@gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 8 Apr 2020 23:12:43 +0200
Message-ID: <CA+icZUUTEEZww3qT0jfFP0ZgUPXoF1_uOHMT4ZecrQxumE1Zmg@mail.gmail.com>
Subject: Re: [PATCH] x86: mmiotrace: Use cpumask_available for cpumask_var_t variables
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 10:53 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> When building with Clang + -Wtautological-compare and
> CONFIG_CPUMASK_OFFSTACK unset:
>

Hi Nathan,

thanks for the quick patch.

I can confirm I have no CONFIG_CPUMASK_OFFSTACK set.

Regards,
- Sedat -


> arch/x86/mm/mmio-mod.c:375:6: warning: comparison of array 'downed_cpus'
> equal to a null pointer is always false [-Wtautological-pointer-compare]
>         if (downed_cpus == NULL &&
>             ^~~~~~~~~~~    ~~~~
> arch/x86/mm/mmio-mod.c:405:6: warning: comparison of array 'downed_cpus'
> equal to a null pointer is always false [-Wtautological-pointer-compare]
>         if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
>             ^~~~~~~~~~~    ~~~~
> 2 warnings generated.
>
> Commit f7e30f01a9e2 ("cpumask: Add helper cpumask_available()") added
> cpumask_available to fix warnings of this nature. Use that here so that
> clang does not warn regardless of CONFIG_CPUMASK_OFFSTACK's value.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/982
> Reported-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  arch/x86/mm/mmio-mod.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
> index 109325d77b3e..43fd19b3f118 100644
> --- a/arch/x86/mm/mmio-mod.c
> +++ b/arch/x86/mm/mmio-mod.c
> @@ -372,7 +372,7 @@ static void enter_uniprocessor(void)
>         int cpu;
>         int err;
>
> -       if (downed_cpus == NULL &&
> +       if (!cpumask_available(downed_cpus) &&
>             !alloc_cpumask_var(&downed_cpus, GFP_KERNEL)) {
>                 pr_notice("Failed to allocate mask\n");
>                 goto out;
> @@ -402,7 +402,7 @@ static void leave_uniprocessor(void)
>         int cpu;
>         int err;
>
> -       if (downed_cpus == NULL || cpumask_weight(downed_cpus) == 0)
> +       if (!cpumask_available(downed_cpus) || cpumask_weight(downed_cpus) == 0)
>                 return;
>         pr_notice("Re-enabling CPUs...\n");
>         for_each_cpu(cpu, downed_cpus) {
>
> base-commit: ae46d2aa6a7fbe8ca0946f24b061b6ccdc6c3f25
> --
> 2.26.0
>
