Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81558C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:29:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50483217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 16:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1RKE5N1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgBEQ32 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 11:29:28 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35077 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726359AbgBEQ32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 11:29:28 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so2433065qki.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 08:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MsrrVulbZqmpS62WjvEb6sitgf3QvwZDf40VZAyVo28=;
        b=O1RKE5N1nT3P3pfqLAn8sWSvxxpXrQISBApODx6VkyRFs0gkEoYGr3H/7DZ+IVDNnu
         avIbf8wDt4p3lfawFSvf7WYGOyW4JfhT2Hhu7xSem7+DfUdJfIoQws+LuGCQUI/2dHUc
         u6KIYzPmMbuG/jAqd7TOdYtoseKkqEKhR2LRPUwp554zGWk+39sAwt88ggfvnzTlVs2v
         e0cp8HXHb3zolfMd704U/xtEJ/0V0POy7y+9HCItSgdhb9UxCoNyS+vDWc60FSQ4RSqD
         7f6PfvFa7fIyidLLvatITFI2JGY3Wlan2UOLMQ5rQr1wKYRk5kTmTKE8Q+PCAy5TQEbp
         sC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=MsrrVulbZqmpS62WjvEb6sitgf3QvwZDf40VZAyVo28=;
        b=ViMyBdlcZwybIvJUlKr+sr9LJ7RWj21efNJz7x8Dv9ZorwG4WwjjyUlfRkOxDkUDMW
         ZiOoRFsFClrXKVErF/SgqUx65ckLehbN/da5wvUzgDRCUg+yMkZakUt4FDCUt/3ZNe5g
         aa9Y/6JACtT/emujxRUzXLmqz536syRn9Dl8gv2kXkLNZE4A/J4XfX+HkA1/k0XlMUWQ
         K3DFsSO9U8nSwQUAHKnJwrioOxf6ie+4U40q/aUtO1IrjbYoKSSIPqXkvHIsRu5NZ94k
         0t7IwI26arOgCEx9/YINeBG0dPMCtFncvAqJq53SaNFD8ykgAHUMIVuKBnTCkrpeuVr7
         tthQ==
X-Gm-Message-State: APjAAAVvJexcHqJEgz0ldTB2QxqhaezOy0NwAo86ILkconG75FmqEpr1
        AQuzMqJTRmpqJDpMyN0b8/M=
X-Google-Smtp-Source: APXvYqwllt2YNKibvaW2dxGtUajiJVVyiRAypQYl5rJBF5aMxSLjIUmYj8+uwYV7fajPtCUGXiruOA==
X-Received: by 2002:a37:e20a:: with SMTP id g10mr2744394qki.423.1580920165354;
        Wed, 05 Feb 2020 08:29:25 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d25sm53738qkk.77.2020.02.05.08.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 08:29:24 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 5 Feb 2020 11:29:22 -0500
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <20200205162921.GA318609@rani.riverdale.lan>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200109150218.16544-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 10:02:17AM -0500, Arvind Sankar wrote:
> Commit 5b11f1cee579 ("x86, boot: straighten out ranges to copy/zero in
> compressed/head*.S") introduced a separate .pgtable section, splitting
> it out from the rest of .bss. This section was added without the
> writeable flag, marking it as read-only. This results in the linker
> putting the .rela.dyn section (containing bogus dynamic relocations from
> head_64.o) after the .bss and .pgtable sections.
> 
> When we use objcopy to convert compressed/vmlinux into a binary for the
> bzImage, the .bss and .pgtable sections get materialized as ~176KiB of
> zero bytes in the binary in order to place .rela.dyn at the correct
> location.
> 
> Fix this by marking .pgtable as writeable. This moves the .rela.dyn
> section earlier so that .bss and .pgtable are the last allocated
> sections and so don't appear in bzImage.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/compressed/head_64.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> index 58a512e33d8d..6eb30f8a3ce7 100644
> --- a/arch/x86/boot/compressed/head_64.S
> +++ b/arch/x86/boot/compressed/head_64.S
> @@ -709,7 +709,7 @@ SYM_DATA_END_LABEL(boot_stack, SYM_L_LOCAL, boot_stack_end)
>  /*
>   * Space for page tables (not in .bss so not zeroed)
>   */
> -	.section ".pgtable","a",@nobits
> +	.section ".pgtable","aw",@nobits
>  	.balign 4096
>  SYM_DATA_LOCAL(pgtable,		.fill BOOT_PGT_SIZE, 1, 0)
>  
> -- 
> 2.24.1
> 

Gentle reminder.

https://lore.kernel.org/lkml/20200109150218.16544-1-nivedita@alum.mit.edu
