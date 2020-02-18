Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F2BC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 000AF21D56
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 19:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pqb2yyN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgBRTVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 14:21:55 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35700 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgBRTVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 14:21:55 -0500
Received: by mail-vs1-f65.google.com with SMTP id x123so13812618vsc.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 11:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xSv9DDEnAlG2dciRnTneRn3tnidN19YOSB5toTxKafE=;
        b=Pqb2yyN0w7qffNOmF++Klqty8EApZpt+vTpwO96CkBOthKTTbo2emX/pWMrHdTKxMQ
         drBaf0GnvxUkz3hzxe1aR+BqD3IB2VsG7GAusv0C9E3H+AWb2uNZGef94zJ2Aui2P2B/
         2Ep+Q6J4EJXbIhX6zkBpeoLaN5SnslzMzzylwmRPTL5juABDetEBBuvjrEGZ9n/MI7EN
         6hMGF9ABvdprAulLQp2WpHVxbi+3rShlBKuOG178q03aURr+GleplGccFDHta3F5e+JL
         6biVwIY8PU8dEXxeFZ2VlCbR/B8aypawHi7ZdCpsh3s8t9WvK4Jc0+rKaPdH6c7dUuEE
         Okcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xSv9DDEnAlG2dciRnTneRn3tnidN19YOSB5toTxKafE=;
        b=i+qnLZWRKnNygZdnOuw/CCrlRlYbU97IO60sZMjb/lmps7luEkc2LjrdpA5fBN1TyH
         XjkBYAbRRFuQ8/UJYA6JWcdXHVmK6LJ9kk7Ava4VFy/0pncmbW2ugdq+rb8WDIprktr1
         QpMdHylYAajYYQFrQzyn/1BSdABrLqZSqBa6DKLPyyXx9A2QS312GYhpnTF16AplbWki
         PUkn6dam/echW6uojAvpckIO5HF7tjOpepaBRJB/JzzVnCiDr7pEjEmpUgXReV0a4m5g
         Gs0kIxJLL4+58msNQU0ZFod+OTIl4sqqmkvMNdP82i2XCma6YCzoSO1zTKXQTH/+CFiy
         Wa7g==
X-Gm-Message-State: APjAAAUSxreFIVULd9Vuvhla6w3jJ0A+wfopPagPaCB6dUwxkCurXk8J
        aVvLPsunRLXbYHT8ICQSUSEYroyG6cK0V4nSgVbv6TnuYCA=
X-Google-Smtp-Source: APXvYqw1t26BaomMybNGSWcMJXnCM8vM+6jtUI37Hb+HSNC+M3powdpKva4u81iGu5oJIIda34VLX1xJl8LoLrNKA2c=
X-Received: by 2002:a67:f4d2:: with SMTP id s18mr11783344vsn.15.1582053713770;
 Tue, 18 Feb 2020 11:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210131925.145463-1-samitolvanen@google.com>
 <CAK7LNAS7UchtP_+2m4AB-hJ=nMwsM-qpkJ+VHU1JGJrn8K1KPg@mail.gmail.com>
 <CABCJKuemBAeySJQY6yxhzbxK=XGBtVSt+6J6WXpO=RoiVXH7GQ@mail.gmail.com> <CAK7LNARyYqmSByD3jQr+TPe1RHEj9CxqRE880AqxA5SU3yUk5A@mail.gmail.com>
In-Reply-To: <CAK7LNARyYqmSByD3jQr+TPe1RHEj9CxqRE880AqxA5SU3yUk5A@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 18 Feb 2020 11:21:42 -0800
Message-ID: <CABCJKudcVo95FcYGJ4223dqVEnkQnQJLx7fVaj1jF21n+sYEcg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: remove duplicate dependencies from .mod files
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sat, Feb 15, 2020 at 8:28 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> masahiro@grover:~/workspace/linux-kbuild$ llvm-nm
> drivers/gpu/drm/nouveau/nouveau.o | sed -n 's/^  *U //p' | sort -u |
> wc
>     572     572   11478

Thank you for testing this!

> Does ACK do this differently?

Yes, the difference is that we use LTO and after looking into this a
bit more, it turns out that when the individual files in the thin
archive are LLVM bitcode, llvm-nm behaves differently and prints out
the symbols for each file separately.

$ llvm-nm drivers/gpu/drm/nouveau/nouveau.o
...
nvif/client.o:
---------------- W __cfi_check
---------------- W __cfi_check_fail
                 U __cfi_slowpath_diag
                 U __ubsan_handle_cfi_check_fail
---------------- T nvif_client_fini
---------------- T nvif_client_init
---------------- T nvif_client_ioctl
---------------- T nvif_client_resume
---------------- T nvif_client_suspend
                 U nvif_object_fini
                 U nvif_object_init
                 U strncpy

nvif/device.o:
---------------- W __cfi_check
---------------- W __cfi_check_fail
                 U __ubsan_handle_cfi_check_fail
                 U kfree
---------------- T nvif_device_fini
---------------- T nvif_device_init
---------------- T nvif_device_time
                 U nvif_object_fini
                 U nvif_object_init
                 U nvif_object_mthd
                 U nvif_user_fini
...

While this output format still works for us, it does generate a lot of
duplicates. Anyway, I think we can come back to this when LTO is
closer to getting upstreamed.

Sami
