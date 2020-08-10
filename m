Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB418C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87317207DE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 17:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5n55vP+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgHJRCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgHJRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 13:02:06 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E5AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:02:06 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id 25so9570409oir.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=/MnI7B3zOxzyIKLcWyhMemgwkprbfGutdpRcD818nDg=;
        b=A5n55vP+TC4JZw6E018HXxcodkrIuq8f61//SjRYnwqWfDHr4eV9LqFGJyqcCDZJHa
         dTfVQNQr9PZ7d1nPgQaWGNL2kbsF3DX8h6NNreEq828iEUIK0B9FwxkoAoslTGUwR77d
         GDT5olz8hzDT2HYfnB/w+Jn7LUepnXYnM3uQlvK27X4VU4dNemImBpVROCwWogUs+mEs
         3fYoaX34aiFPukU/VD6C2doNCAXyIviXeUa60Rd23Jc1kxSNJHspKDuM9zcFfkTlA5Dr
         +WOT8DV3CnhAtv6vz/o2sEztxFMaCqzwwRtOnBY1yWaF5pojVWtBuH6SAbihScg5lRYX
         NkRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=/MnI7B3zOxzyIKLcWyhMemgwkprbfGutdpRcD818nDg=;
        b=rZsf404LyzCXN8VIHBMkaXHhWG5KWV1pDeNj4fDBzyf7N6IDJpP60VecbhdxtfrPRv
         ciDryKcOoMxD8g9kzbJzvI3K0O/rlCMEAiI4sRczVvoCVUC77YQKtOZScLH/zC8j53TJ
         gX6oZiaBQZEIcLDkbAjClM65/ibm0LM1GlhVSnE4Sbx0fStU2nusw4VnPn+c9VWbAD6V
         C+TqJj9/TPtmXOrvBM/DdR08dcw9etPBmBfXtpAengZmuHq+ZBlmxmjNA4NBv6GCz2Mi
         ZJGGu80RCVqbGxKZr+1BD/253Yl7WT2e6oz9hb9n9wmglCJRYqV4tV/XB/ms5NZ2MeBl
         /1pw==
X-Gm-Message-State: AOAM533tQ6sm/5ax6Aa7rGuvNnhiRxTsU5FISMgWEAPmCI2x0m41KJs5
        3agjiAp17JzE1j509dJSZLjb5CRKtJjN7kBPeIg=
X-Google-Smtp-Source: ABdhPJwCsFU4W6S0LKYSYjaZTPzVDRkh45YZ88cSfK+GqRtH6/acQePGI0/BqMGbpHHRpYFUxZathS0nDV5v3q+dNXc=
X-Received: by 2002:a05:6808:311:: with SMTP id i17mr241805oie.72.1597078925548;
 Mon, 10 Aug 2020 10:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200810155943.2583275-1-daniel.diaz@linaro.org>
In-Reply-To: <20200810155943.2583275-1-daniel.diaz@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 10 Aug 2020 19:01:54 +0200
Message-ID: <CA+icZUXzhDCg64f++F8Rmc_Eq_fGZyTYT3krzT58E6hJySJ3hw@mail.gmail.com>
Subject: Re: [PATCH] x86/defconfigs/32: Unset 64BIT
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 5:59 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
rote:
>
> A recent refresh of the defconfigs got rid of the following
> (unset) config:
>
>   # CONFIG_64BIT is not set
>
> Innocuous as it seems, when the config file is saved again the
> behavior is changed so that CONFIG_64BIT=3Dy.
>
> Currently,
>
>   $ make i386_defconfig
>   $ grep CONFIG_64BIT .config
>   CONFIG_64BIT=3Dy
>
> whereas previously (and with this patch now):
>
>   $ make i386_defconfig
>   $ grep CONFIG_64BIT .config
>   # CONFIG_64BIT is not set
>
> This was found with weird compiler errors on OpenEmbedded
> builds, as the compiler was unable to cope with 64-bits data
> types:
>
>   NOTE: make -j1 bzImage CC=3Di686-linaro-linux-gcc  -fuse-ld=3Dbfd -fdeb=
ug-prefix-map=3D/oe/build/tmp/work/intel_core2_32-linaro-linux/linux-generi=
c-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0=3D/usr/src/debug/linux-generic-main=
line/5.8+gitAUTOINC+1d0e12fd3a-r0 -fdebug-prefix-map=3D/oe/build/tmp/work/i=
ntel_core2_32-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a=
-r0/recipe-sysroot=3D -fdebug-prefix-map=3D/oe/build/tmp/work/intel_core2_3=
2-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd3a-r0/recipe-s=
ysroot-native=3D  -fdebug-prefix-map=3D/oe/build/tmp/work-shared/intel-core=
2-32/kernel-source=3D/usr/src/kernel -ffile-prefix-map=3D/oe/build/tmp/work=
/intel_core2_32-linaro-linux/linux-generic-mainline/5.8+gitAUTOINC+1d0e12fd=
3a-r0/git=3D/kernel-source/  LD=3Di686-linaro-linux-ld.bfd
>     GEN     Makefile
>     CC      scripts/mod/empty.o
>   cc1: error: code model 'kernel' not supported in the 32 bit mode
>   cc1: sorry, unimplemented: 64-bit mode not compiled in
>   /oe/build/tmp/work-shared/intel-core2-32/kernel-source/scripts/Makefile=
.build:280: recipe for target 'scripts/mod/empty.o' failed
>   make[2]: *** [scripts/mod/empty.o] Error 1
>   /oe/build/tmp/work-shared/intel-core2-32/kernel-source/Makefile:1174: r=
ecipe for target 'prepare0' failed
>   make[1]: *** [prepare0] Error 2
>   /oe/build/tmp/work-shared/intel-core2-32/kernel-source/Makefile:185: re=
cipe for target '__sub-make' failed
>   make: *** [__sub-make] Error 2
>
> Fixes: 1d0e12fd3a84 ("x86/defconfigs: Refresh defconfig files")
>
> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>

As a suggestion for the name of the patch:

x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig

- Sedat -

> ---
>  arch/x86/configs/i386_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defc=
onfig
> index d7577fece9eb..4cfdf5755ab5 100644
> --- a/arch/x86/configs/i386_defconfig
> +++ b/arch/x86/configs/i386_defconfig
> @@ -19,6 +19,7 @@ CONFIG_CGROUP_CPUACCT=3Dy
>  CONFIG_BLK_DEV_INITRD=3Dy
>  # CONFIG_COMPAT_BRK is not set
>  CONFIG_PROFILING=3Dy
> +# CONFIG_64BIT is not set
>  CONFIG_SMP=3Dy
>  CONFIG_X86_GENERIC=3Dy
>  CONFIG_HPET_TIMER=3Dy
> --
> 2.25.1
>
