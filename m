Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CFC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCEEC2067D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hlMTj6kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbgGNVHu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgGNVHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:07:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469F5C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:07:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id d27so34618qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=11WJyEAm3+xbqzduMNqA3WjbGwHVjoCwQAhn6aCLeDs=;
        b=hlMTj6kjGIKoGE7fT8lAFF/hZ8rq9g/khJg8CTst9mUJ30kwFBOXM/gBMJLKWne0Zc
         OvMPQ8t9KYsoBOOiaO3vq5XAv4tOSbqTCMZ5okH35+/D2yA6je1eftwRr0UhxyTsQXXX
         0911LRC6Suq/A8tWS4Ln+pDFF4NNPosS5jl42xCwK/zb0FJdfJGKx9MWb3lXikz6zNCW
         ++eg0AGqes4BZ1S4JkALVEDTczxy1oo9RoManqXY4kuWll9Ca78WvASO2wGP8t40GgoW
         CIFTV68bEEYY1S3gp9InQAbsTaqD0g2B4SNWv/tAQn1RX44zpzQpnxIr9BJ7JsZQqyRl
         /klQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=11WJyEAm3+xbqzduMNqA3WjbGwHVjoCwQAhn6aCLeDs=;
        b=IEnpwY4KTBGt8jSjbTjM2LL/0MvcA3ZXBDLTomBIqPvJ9TEbN6F4P8uZ2lwb6Ayeax
         NVOVFtY4+D9gorLJb263YNQBbh73e+cqW19H9+kv/k64Dj3ELrPjPuVrUFn/oA4aZIaE
         W9BpeI0+drHteblsuNeW+VdNabR51Y9PP0MJOtEQ0Vb8iZ1uSOvOFj2JkalTA/a1XD5C
         h2oo5vmbtx8i/hue2WgFtctEZgxo9NdGYqcAbaBKQc15uB7BYty4wbU95zC+jSX5/CSi
         ZdqkCXIjaiJI//azdkbcVDdoMIYd9UHRtEHsLmPRL7eNmLez2aKC7oFQ5AOw1wfvmUv/
         7hTg==
X-Gm-Message-State: AOAM531qjCgfSVg1JUwFGysgWGdkY1A/67UI5FjzHXdE7q0N6gpPplYJ
        7p7W+ekydlQBtsYOGxgAGFU=
X-Google-Smtp-Source: ABdhPJzgleKBQPpfNsJkCIT0b1MEwvXSjtSn6u3Qy1MPOFCIhV6AjsxvdIagPpEMB7h1s+qaMv8RoQ==
X-Received: by 2002:aed:3b99:: with SMTP id r25mr6640502qte.315.1594760868524;
        Tue, 14 Jul 2020 14:07:48 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m20sm21772838qkk.104.2020.07.14.14.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 14:07:47 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 17:07:45 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200714210745.GA918357@rani.riverdale.lan>
References: <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan>
 <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <CA+icZUXBggJtwtWmyXEwgu1WztrcTiLrZCW1_QqSw2SiThOkfQ@mail.gmail.com>
 <20200714202100.GB902932@rani.riverdale.lan>
 <CA+icZUVcyAfXqyAQp+bjb0bx5z2Q0Bfyt899AxJASXY-GCRCrA@mail.gmail.com>
 <CA+icZUUtcQhzO=1KToJyhL0-kWFvV6Ow49u_28Ez9AhvkVjWEw@mail.gmail.com>
 <20200714203537.GD902932@rani.riverdale.lan>
 <CA+icZUX93x_vhG-j+H+ktC_vt1d0f-KWZ+0L+hf1dnr=0L9h7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUX93x_vhG-j+H+ktC_vt1d0f-KWZ+0L+hf1dnr=0L9h7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:43:11PM +0200, Sedat Dilek wrote:
> If we move to LDFLAGS_vmlinux we can drop the "call ld-option" as both
> linker GNU/ld.bfd and LLVM/lld.ld support this?

No, because ld.bfd only started supporting it from v2.26, and the kernel
aims to be buildable with v2.23.

> 
> Do we need to adjust the comments?
>  # Compressed kernel should be built as PIE since it may be loaded at any
>  # address by the bootloader
> 

It looks fine, no?
