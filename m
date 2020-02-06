Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30B6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C62EF21741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nJ2sCcr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbgBFLSm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:18:42 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:46512 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727649AbgBFLSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:18:41 -0500
Received: by mail-oi1-f194.google.com with SMTP id a22so4165062oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dYQuztr5x7HOTEbo7y727kXqDcOFz4Xay/pJ3yDZkOc=;
        b=nJ2sCcr7VGOXE/AGUV1PHd0w5o+dEwmm9WveatUop3DxNVgCiY8VJA3/MGX1Z76kC/
         hX+6VntHCNmi1bAZGjQBMMvyuxHXNv6u0k6kYVlxtrrN3MnAELiG2z6Cl2ZPOHA/QtMx
         LMWHrhb7XN3Yhpph3DtCYQvgdOoJrD6UGf+zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dYQuztr5x7HOTEbo7y727kXqDcOFz4Xay/pJ3yDZkOc=;
        b=fHxuAlSQ86u4KnlJHQkQT7awzPRYsnaRduZ8tOsiyp3hmznZ7eVPbrOey0YrU1ot6I
         5MxPvgtPEMKS2Qd2E1q0bhZJTGMd+5vT/aPH8qw1lSMwNDb+5Zr9lfcFkZoR80QGlN/w
         4gdw3wYwgqqSFJVbZ3WHwUCZFi2Dkq25BkqryNQNKSygH/wUCqXfQUeaUTVkwf+F3e/Q
         KsjggmmPjkeri3hucsFju+rTcx4g9255NV2EE0mHj3omAfVWgbRe7tQWcXCzWRFyvyIK
         snLlvjTgG/MxNoOkiZ5vKoY5DAjk/zv9vizx5zY6n/QC6kj/hcebYJs5g+ct43hOIb/a
         gqgA==
X-Gm-Message-State: APjAAAX7IclMACqjYNkcOuBPiQfFr4TlUHii7G9LJTpg4TEoJozDFLto
        6SymQTUXp8KvGYRwoH57CcuTbwRmPF0=
X-Google-Smtp-Source: APXvYqymu+kLcwT6ajD1KPRDN2ZyU8G0RbyJt0QfpqPU+bsU8U82GZbBa8DD17a4VXAGjC/2fE/V2Q==
X-Received: by 2002:aca:ab52:: with SMTP id u79mr6205614oie.145.1580987920960;
        Thu, 06 Feb 2020 03:18:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j24sm1025130otk.7.2020.02.06.03.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:18:40 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:18:38 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
Message-ID: <202002060316.A0027DEB@keescook>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109150218.16544-1-nivedita@alum.mit.edu>
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

Thank you! As you know from the fg-kaslr thread[1], I ran into this (10
year old!) bug while helping there. I could not figure out why .bss was
getting allocated into the on-disk image.

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

Acked-by: Kees Cook <keescook@chromium.org>

-Kees

[1] https://lore.kernel.org/lkml/202002060251.681292DE63@keescook/

-- 
Kees Cook
