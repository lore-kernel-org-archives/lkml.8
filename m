Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE25C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC47B20752
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 23:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20150623.gappssmtp.com header.i=@fireburn-co-uk.20150623.gappssmtp.com header.b="fzokSh7W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgEKXMk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 19:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKXMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:12:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749E0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:12:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v4so8653335qte.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=csemUG+Ws7y0HqXk83MvG8Thvpme39pvo0VkZNRmLXc=;
        b=fzokSh7WiZFo8q6L5pePoTIAZFJir6Zga/NG9zxxbybfgcd1CQW2huCb+nrtEfEHxg
         g4h0JTkB5lBnPRxfdX1rAQeFFkH1m3HdZKDQ/P3iOlL0UYS/mTjyWFpIRwnjDuvw32nP
         3x2800pskSnAWdX5vy4XvICrArt0MvLzBiSajuMgwfDSVH5xmGDbbfki09K17vSN9g6b
         tBYGvV20KYJZxrxZvPWl9RmWMBlsksLVWWWsJNZxFmEgUgdg41eTkLsMhs/XTx43jq6O
         lN9DcWn4eIok/JsJl2bPISU03qjpzxM1QIDoYg2jURr67ErMid6zyPGjuldoQ4SgVQsM
         l6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=csemUG+Ws7y0HqXk83MvG8Thvpme39pvo0VkZNRmLXc=;
        b=MSp7GvUmgj8Y58U+pFNBZl3A+qxgZ/LyNAhn10aEOIcnRiWYx3jGb1BC2EoynbLlkJ
         CvI1p4SW6pEeQrAUGrKfoM3K1/+HLmcF2Mwfr1SM4TAnyMC81/jL2lRTHu44haaMi2fj
         Dadfuf735AcY+Iyauu6y2tT6rYqAX4vAPuFZJQYKlqr7Z0PC4Nqb6V+h7EGgJD09tS0z
         qLeRdpCPduG7sR4eHyebHY63996l/8LOWLPRShP193pLXP3Cehqdl3Kgb9FJJewXVfRH
         VjxC8kd/C/atF+B8W5b72DOcY7q9Itvd4kzaKsq8n6EUn3On4xawThYHx2tqvnLl72LX
         8H2A==
X-Gm-Message-State: AGi0PubghxZVRBb/WnNNwS6jT7BsDjioSwa829bTX/K84tnec/WXEumL
        T4V33redPXMda+sOcpu3w/coKvGq4in44A9NrQK/CQ==
X-Google-Smtp-Source: APiQypJYYUE4mplfB1hqUJ5bDjw3xJwOop4c0BYWrp/iwgO+p19OIswihhZiWOKMBZioWG8Dx/CbHTOIqzKMfjBlcrY=
X-Received: by 2002:ac8:6f75:: with SMTP id u21mr12718239qtv.161.1589238757632;
 Mon, 11 May 2020 16:12:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200511225324.GA1307788@rani.riverdale.lan> <20200511225849.1311869-1-nivedita@alum.mit.edu>
In-Reply-To: <20200511225849.1311869-1-nivedita@alum.mit.edu>
From:   Mike Lothian <mike@fireburn.co.uk>
Date:   Tue, 12 May 2020 00:12:26 +0100
Message-ID: <CAHbf0-HLKiq_+erhHfV9XqMhfchN2975nAsuya4-oXEOUNdhiw@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Mark global variables as static
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feel free to add my tested by


On Mon, 11 May 2020 at 23:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
>
> Mike Lothian reports that after commit
>   964124a97b97 ("efi/x86: Remove extra headroom for setup block")
> gcc 10.1.0 fails with
>
>   HOSTCC  arch/x86/boot/tools/build
>   /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
>   error: linker defined: multiple definition of '_end'
>   /usr/lib/gcc/x86_64-pc-linux-gnu/10.1.0/../../../../x86_64-pc-linux-gnu/bin/ld:
>   /tmp/ccEkW0jM.o: previous definition here
>   collect2: error: ld returned 1 exit status
>   make[1]: *** [scripts/Makefile.host:103: arch/x86/boot/tools/build] Error 1
>   make: *** [arch/x86/Makefile:303: bzImage] Error 2
>
> The issue is with the _end variable that was added, to hold the end of
> the compressed kernel from zoffsets.h (ZO__end). The name clashes with
> the linker-defined _end symbol that indicates the end of the build
> program itself.
>
> Even when there is no compile-time error, this causes build to use
> memory past the end of its .bss section.
>
> To solve this, mark _end as static, and for symmetry, mark the rest of
> the variables that keep track of symbols from the compressed kernel as
> static as well.
>
> Fixes: 964124a97b97 ("efi/x86: Remove extra headroom for setup block")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> ---
>  arch/x86/boot/tools/build.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>
> diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
> index 8f8c8e386cea..c8b8c1a8d1fc 100644
> --- a/arch/x86/boot/tools/build.c
> +++ b/arch/x86/boot/tools/build.c
> @@ -59,14 +59,14 @@ u8 buf[SETUP_SECT_MAX*512];
>  #define PECOFF_COMPAT_RESERVE 0x0
>  #endif
>
> -unsigned long efi32_stub_entry;
> -unsigned long efi64_stub_entry;
> -unsigned long efi_pe_entry;
> -unsigned long efi32_pe_entry;
> -unsigned long kernel_info;
> -unsigned long startup_64;
> -unsigned long _ehead;
> -unsigned long _end;
> +static unsigned long efi32_stub_entry;
> +static unsigned long efi64_stub_entry;
> +static unsigned long efi_pe_entry;
> +static unsigned long efi32_pe_entry;
> +static unsigned long kernel_info;
> +static unsigned long startup_64;
> +static unsigned long _ehead;
> +static unsigned long _end;
>
>  /*----------------------------------------------------------------------*/
>
> --
> 2.26.2
>
