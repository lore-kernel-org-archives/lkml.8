Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5065AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF112067D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oRUZOeRa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732695AbgF2Tcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733238AbgF2Tcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:45 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5771FC0307B0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:55:55 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u8so7934844pje.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8FZDkBiuioOBRxwHsKCkUje2d5GjB8iXiN+bbHKyAe0=;
        b=oRUZOeRabJBXny6lhg7jbx/B/9od7jh1hwhJ7VRIVhMP5M1PLzRZkVyb74w2D+gcLF
         ZmLL8lPCnYn10ztmqHqkWeL9I3t7mGQs/FnV1NY0WJc+WKBbt2domMXgRUDMaDZK9CFC
         Z7LgAO/XRYdSRj6w5ca0Dpu9Fj0Ogxx6wWP60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8FZDkBiuioOBRxwHsKCkUje2d5GjB8iXiN+bbHKyAe0=;
        b=TgFwO5jHbLkvv5CE9FZgTmUybypCU5Zi4W4eYnEfynBBDC98+AqXy3qzSD+b47W2wj
         8jXDrKzRNsOr+EOiRwJofom46hSstnjXbzyUd9jA4llxPTrCPHrVHhEFaBzSKbZPXJep
         dNss5NRQ0Un7QJY8unyFQouuTAuNEU1ppfoSKXYdrs3HRin4oVWTckWDJoTOYX4s814J
         5iOO/lV97OBLVacXeJxwCczsS/qnWe5df6jUpeftUnMeel2gb2yMFN/mXhs7M2kXoNZ1
         ocPwlbHn54FQTNLglgUg23ldFtOhSyKDVxJegvJqPDy83HkonxYtef/KPVO2HahoTjya
         KvNg==
X-Gm-Message-State: AOAM530CkZ6ZoIkek09tzr/HtoterRm8LMBnabIFOxiQ4NrK6Vbd4Y+M
        SQqQhzDcH7+qAk69yfhdi1hqKQ==
X-Google-Smtp-Source: ABdhPJz02X0iAnH1VWJyzrKsMKGwrhNEnyTt5WGDZBvjx3l7kWinsKTAPbnA4h5q/ePh1BH8ckh24g==
X-Received: by 2002:a17:902:b414:: with SMTP id x20mr4523246plr.143.1593446154911;
        Mon, 29 Jun 2020 08:55:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r17sm167810pfg.62.2020.06.29.08.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:55:54 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:55:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] x86/boot: Add .text.* to setup.ld
Message-ID: <202006290854.CCFE11C@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-5-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-5-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:25AM -0400, Arvind Sankar wrote:
> gcc puts the main function into .text.startup when compiled with -Os (or
> -O2). This results in arch/x86/boot/main.c having a .text.startup
> section which is currently not included explicitly in the linker script
> setup.ld in the same directory.
> 
> The BFD linker places this orphan section immediately after .text, so
> this still works. However, LLD git, since [1], is choosing to place it
> immediately after the .bstext section instead (this is the first code
> section). This plays havoc with the section layout that setup.elf
> requires to create the setup header, for eg on 64-bit:

Eep! I guess this was a linking case I missed for adding
--orphan-handling=warn to my orphan handling series. (I will add that.)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
