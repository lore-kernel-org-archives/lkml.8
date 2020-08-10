Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1DAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2897F20825
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 16:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u/V8VaNP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgHJQPK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 12:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgHJQPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 12:15:08 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD4CC061756
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:15:08 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so9394395oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 09:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=LtOO8tTDsz23p1VL2F1YvuwBgRvOqA9SqB5+iyGA+yk=;
        b=u/V8VaNPux7Lw+qKOFlBp+/VoP8IgQeExE3EfDleOqZuE1inlfYhJaXlhHVp3BAhva
         LsBdme3yXknrKSWVZ2+ntUTHcE3vxAMYyW0+p1fVzdjy5bLCu+miiSZgJ/KsQcjFkFdA
         yJ5alpAlJ6V/sLRRnoZC4Gyc5khXS5bfjnrnbyIUgY8w/IHkGbTieYRQzxrV8WzKgk/f
         1JeIkbD/DvAo2TUFEoxGOyEbhpgSslmKzTp0chbh8gysjYudaj8l1hWeQGSywDOxVvkc
         51WxyGYOa7dm7YaN+Sowt5fS/7xj3AxQG+X3Ug7D+uPAZTJQc2siXtP20cL8tYUVCW3W
         5KIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=LtOO8tTDsz23p1VL2F1YvuwBgRvOqA9SqB5+iyGA+yk=;
        b=ExahLye7loyWVzg3nKEQQ15R+gUK8NyeZUD5cUCG5qRYzG+TPhzfgKAXNJVUaZTFjS
         GuI45xTAfLd30G0OIBcIpePX/TB8nYwOtx2QbUnXFLljN0e0Ab5gTUK2HGl+qO6RZIeo
         VXzEDShLxYL6/1Ngr8hNXXEor9C+6q0C3no/VBDYY+hgi6mx7MaTmDE6+6cLHRE8cy0M
         p+JF/ziWNyGRblRTU5S4nP3JJDQpJRBVCLX+oaCE4JpV3Qk0Gj+0bWWhSEeBaZ/WQSdK
         i7oV6u/cFKJknwRSbDVixI8AQyc/RlzYuAFIXpNDQ1+eara/7kA6PuX+rEiw2oOJBdER
         AlAQ==
X-Gm-Message-State: AOAM533xPsZQYZd+mrJGtuVnx6hdKyGptBXrypZbP+b6R621j6Ybfbvz
        6M4747NJSJyXHoLfGg7b7BPBfs7rer5l0at5lQ8=
X-Google-Smtp-Source: ABdhPJxtDexpmq3QcsjPd+LmIBVJRto9+xeSvh2sDSNVGTCRWNDSpPK1o5v8ReILbvg6riwUMy3KZxpjafDKaGoi3U8=
X-Received: by 2002:aca:724f:: with SMTP id p76mr61831oic.35.1597076105928;
 Mon, 10 Aug 2020 09:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200810155943.2583275-1-daniel.diaz@linaro.org>
In-Reply-To: <20200810155943.2583275-1-daniel.diaz@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 10 Aug 2020 18:14:54 +0200
Message-ID: <CA+icZUVZm=Mx+g1M+EBaVx=xaXN2j=NhTrkx5DE25vGatSFqcw@mail.gmail.com>
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

Hey cool and Thanks Daniel.

I feel over this "CONFIG_64BIT not set" when I wanted to test the
patchset [0] in ClangBuiltLinux issue #194 ... but never did :-(.

I never reported upstream - it is good you sent out a patch with
explicitly setting CONFIG_64BIT=3Dn when using i386_defconfig.

At least I send a patch to remove a leftover [4].

- Sedat -

[0] https://lore.kernel.org/lkml/20200504230309.237398-1-ndesaulniers@googl=
e.com/T/#u
[1] https://git.kernel.org/linus/ba77c568f3160657a5f7905289c07d18c2dfde78
[2] https://github.com/ClangBuiltLinux/linux/issues/194#issuecomment-662620=
461
[3] https://git.kernel.org/linus/6526b12de07588253a52577f42ec99fc7ca26a1f

> Signed-off-by: Daniel D=C3=ADaz <daniel.diaz@linaro.org>
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
