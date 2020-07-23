Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A461C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44197208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOCkns2k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbgGWQBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726621AbgGWQBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:01:02 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B69C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:01:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id k6so4757246ili.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 09:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to:cc;
        bh=uy8YjtIOm5/mHhIarB8bi8rTCccFOhuH7AXPf94Yjc0=;
        b=bOCkns2kjK4tQ7nK4AZBYEXht9wqeHhhoRPjyx2HihDOGPN9HATVQ9UbCw29VehWXO
         fYikqIE+5KlyTRp+wr5zcRBDcvdWHTDNJzyeuPxDxaIe1hqpRf3OXt0VorXUYkQ/tuAj
         XsTPGryE0CSeVEcY23NOr+RgrPjsJ89nTgNg4YBbUX+T0GjHGI4K1lRR/fiPdslOLYKc
         WiNp/4F6kCgRhk0wHZI6nXUmAF6w6rrkxJhHMZUuUBLEZtwRbw68XKreRwXMafNw6n/s
         RCMMeetgK3TpS97LBFX/rhyJlL71syNXImKsuRllSA3CaQRA+Ji0+KMmE8SCsnvBtHTN
         yhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:cc;
        bh=uy8YjtIOm5/mHhIarB8bi8rTCccFOhuH7AXPf94Yjc0=;
        b=FMPiivXOtkJOCF9Zl+r6toIJwL70n2jDiZMHbjwW2TCkwoqgI1tP0ArZ1I8q3muwpF
         NaPpTJypChnV410mpL7IwGk2CuFRvQf5m+/EmXERH5ZjXasl8EVlxnmTdIk3wTbKElb+
         vdVKqJ+NjtF6jUcvjAONEc0ze3I1G3IWcBPOrNKaFbmhsoUohnsXIG5rzmWnu3BM1RfO
         ZeXuLZi6mVSfTMDIyneRdnwW7LgRHVjPwBpT/AaTmvO3tduobpdG4Lz3C+P0gZCV24UN
         XEdFQHwsiGaQuZY1nqjvo6sVmiEGCParwBjrgujqBS8UqoDZ0rkRQk0C5UY0GiTwXJhO
         237Q==
X-Gm-Message-State: AOAM531hesDKrNVpDqx8Hv2bXMraiQexnLw2Vxphn/xeiAPCSPwo/1fc
        LM0uuU/NayoluKe5OoEW+C3wWKFWEbklU7FNYHGM2JbCJxs=
X-Google-Smtp-Source: ABdhPJwb1OV4C5J50AeoD6W5KAHBi8EL2H4W01vdmPlWtXfqgXqHRdO9CKlJ8or2X4oXQlYWvb3MfT+3fIUaw0PE8iI=
X-Received: by 2002:a92:8b11:: with SMTP id i17mr5498736ild.212.1595520061208;
 Thu, 23 Jul 2020 09:01:01 -0700 (PDT)
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Thu, 23 Jul 2020 18:00:50 +0200
Message-ID: <CA+icZUVvGm8N5Z7M1zXRGo-hZ5pSanQ=+iEEgUd2j33aGiC7TA@mail.gmail.com>
Subject: Re: x86/build: Move max-page-size option to LDFLAGS_vmlinux
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC me I am not subscribed to this ML ]

[1] says:
"
This option is only required for vmlinux on 64-bit, to enforce 2MiB
alignment, so set it in LDFLAGS_vmlinux instead of KBUILD_LDFLAGS. Also
drop the ld-option check: this option was added in binutils-2.18 and all
the other places that use it already don't have the check.

This reduces the size of the intermediate ELF files
arch/x86/boot/setup.elf and arch/x86/realmode/rm/realmode.elf by about
2MiB each. The binary versions are unchanged.

Move the LDFLAGS settings to all be together and just after CFLAGS
settings are done.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
"

Hi Arvind,

I have tested this on top of Linux v5.8-rc6 with a snapshot version of
LLVM/Clang/LLD v11.

Without your patch:
$ grep "max-page-size=0x200000"
build-log_5.8.0-rc6-4-amd64-llvm11-ias.txt | wc -l
16935

With your patch:
$ grep "max-page-size=0x200000"
build-log_5.8.0-rc6-6-amd64-llvm11-ias.txt | wc -l
4

I was able to build and boot on a Debian AMD64 system.

Feel free to add:

   Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

Regards,
- Sedat -

[1] https://lore.kernel.org/patchwork/patch/1277806/
