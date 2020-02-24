Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F30EBC35DE4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE73C21556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 23:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/I735s6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgBXX2r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:28:47 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36483 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgBXX2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 18:28:46 -0500
Received: by mail-ot1-f68.google.com with SMTP id j20so10429038otq.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 15:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GAy6f6HwZcvA+vCvtzUtJuDggm1hBgZwofmVHQAmFio=;
        b=i/I735s6mxeQ+bYgCKNvSV+2Ta/apUIoPMAK0Rh038e0Dc/iFJWkRY1CgMaUASM5Z8
         DiLXUWxjFBvRH1tS75s0KEyl8a407zmGS2uF/hrqHbEmBw4WLZ11bsmLZ7VB2wMbE26C
         6rSBZ+ILGnEiKcCrvvnRngKfQ1oUBTjZv7oeUo/B6uMBM5J8yDm/h97hxBpdp2RJJsV4
         ZygrT5pnoh5o3+dEue8Ia38dQt9AjFmXnfn+Cv8uXi5OBvymHWvWNFmvIWWH2ZjwJsJ9
         yH89WwLgEurrHaR89LeitdVaSl0zc+N4ahOZMEwk8h7lkqXIEBy1VVEcu+dd40tbgZcZ
         OaJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GAy6f6HwZcvA+vCvtzUtJuDggm1hBgZwofmVHQAmFio=;
        b=qcn28jFqjeFEru9tSLHI8keXnfz45rQimM+sCtApX4q2leWGNhRFvRBfgJ0JrE0Y0O
         TyhW5nGX1ywlNl5fDij5dV9iIskxu4tH1yPb9RmIwDc/l04zpGFQpjdBSbh257kkT3Ex
         8UyXUDDJzXvx/+8nEYPVktJM9aryj0RTbZvF0VFUVhtfQ9ZAjuxhE5AKT93uc6Ijg1B8
         7uUaFqMgYmpJLPqkDVzcmrSomaZ4dpyG30fgwdpu7jLVl0K35iL5ZwAhTsC6PEK7Nz8A
         9PgTIaVTUiKL9arV3slwQC+VwfgTFucWYxs1DaJbM7lm1pR92WDXP/qXqAS9rqF4aElH
         NgYg==
X-Gm-Message-State: APjAAAXpEXhL77NddJAvJLJcBiTWQd/lI7jIcogW+BuQ4oIYFOsM/lZd
        UEZaKlp6u86d4WfctEqMBqg=
X-Google-Smtp-Source: APXvYqzKROo2ZYdYShwNaz9oDnFGGyfdNXBvEEQlEf+7A3xs9CV0IWAgtjjBNELOOINM/ZD4qDpPnA==
X-Received: by 2002:a9d:48d:: with SMTP id 13mr39635978otm.249.1582586926139;
        Mon, 24 Feb 2020 15:28:46 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id m185sm4528897oia.26.2020.02.24.15.28.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 15:28:45 -0800 (PST)
Date:   Mon, 24 Feb 2020 16:28:44 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arvind Sankar <nivedita@alum.mit.edu>, m@ubuntu-m2-xlarge-x86
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Michael Matz <matz@suse.de>, Fangrui Song <maskray@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 1/2] arch/x86: Use -fno-asynchronous-unwind-tables to
 suppress .eh_frame sections
Message-ID: <20200224232844.GB31729@ubuntu-m2-xlarge-x86>
References: <CAKwvOdn6cxm9EpB7A9kLasttPwLY2csnhqgNAdkJ6_s2DP1-HA@mail.gmail.com>
 <20200224232129.597160-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224232129.597160-2-nivedita@alum.mit.edu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 06:21:28PM -0500, Arvind Sankar wrote:
> While discussing a patch to discard .eh_frame from the compressed
> vmlinux using the linker script, Fangrui Song pointed out [1] that these
> sections shouldn't exist in the first place because arch/x86/Makefile
> uses -fno-asynchronous-unwind-tables.
> 
> It turns out this is because the Makefiles used to build the compressed
> kernel redefine KBUILD_CFLAGS, dropping this flag.
> 
> Add the flag to the Makefile for the compressed kernel, as well as the
> EFI stub Makefile to fix this.
> 
> Also add the flag to boot/Makefile and realmode/rm/Makefile so that the
> kernel's boot code (boot/setup.elf) and realmode trampoline
> (realmode/rm/realmode.elf) won't be compiled with .eh_frame sections,
> since their linker scripts also just discard it.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Suggested-By: Fangrui Song <maskray@google.com>
> [1] https://lore.kernel.org/lkml/20200222185806.ywnqhfqmy67akfsa@google.com/

My previous review conments still stand,

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
