Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2CFDC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8591520738
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 18:26:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvTJgXKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHSS0D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726817AbgHSSZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 14:25:56 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47D1C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:25:53 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id n128so18015027oif.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=2LFNBHgjYStPtiYjN5+A3oNUrC4aUB8RGtOJANH38co=;
        b=rvTJgXKbEMuPzQir9P3piCVWE0IotVUVVRD5+jZ50NCpkJrEeLFOa807vkWTobANLH
         Lg2bVVZn1njtsa0z4BnoghhtwkHpjMT/AOI+ulkRQumxYpLvkRoVF5NMl+JtwoYhEBAI
         zJgdfkAfXeYlucA/fspB6ITFm5gX7KyhIO7J3U2fM/V1NF3uUDPMdQGP6cvaR07vaWi6
         OEg3HUmP9Th9+YGRcuBtA/ASlbtAK+D40yvqlbL7lzsPLxgYVQ+lrztR4wIEBYF46wjS
         nO+N23f1fgRoPlY6jZOdgMUrTRHQ2n4keGEpxGZjccK5vNsV7HMPYY0HBJoTZdd1giFh
         yLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=2LFNBHgjYStPtiYjN5+A3oNUrC4aUB8RGtOJANH38co=;
        b=V0AymrJJ/Y86ARimFpzkSCNldReHWnQTNM/vdc7o6aEAIGC6blvQXJQVUeZO/KMdPR
         FG6XVLabvP0RwyHLLV3YKcEY02t7YytmJ8CyQP/sVU3SaLzBrOdfKKn9mwlIOAc4vbxZ
         NZmFKZ/G4UTlRd8DLB0IZp150Cy5PoQ91lkggVcLFhh0dCZA2lXXqkVlOhnjGG06p3rZ
         3YlxzOLfhmShoCzlAeILgtpT4HQUS44qB6bJ75ufGy/fhkOB4kNuxxnN6vUPr/RGKiGk
         PQp/XYjgMX1ZAHYd/4W/CaN19i/WK96XJldMqIuNMVIitlrsRXTtQK3gFPk0s+q2jjh5
         zUvg==
X-Gm-Message-State: AOAM530pkuTgkGXu1FgNmmPApAQFiBMgcxeJV9xRBVK/LTcLmc9WK8Cu
        FkvOIXVpO57rXUATZs/bNYgE6SBHzdrN54zNdGg=
X-Google-Smtp-Source: ABdhPJzkOnOxhKBPJWXgNq8IPr7MZLDmfWIzBSnr8Gb+5otoBmfI9a0Fjq2i6tdrgH4v4kQRdq6yr5f+XdNFXPGmbC4=
X-Received: by 2002:aca:724f:: with SMTP id p76mr4037574oic.35.1597861552495;
 Wed, 19 Aug 2020 11:25:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200810155943.2583275-1-daniel.diaz@linaro.org> <20200819173225.3821449-1-daniel.diaz@linaro.org>
In-Reply-To: <20200819173225.3821449-1-daniel.diaz@linaro.org>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 19 Aug 2020 20:25:40 +0200
Message-ID: <CA+icZUUNCmAY1P_bdUMUmGFZPztTTE_G4j-Q+9zHmU-i422rEA@mail.gmail.com>
Subject: Re: [PATCH v2] x86/defconfigs: Explicitly unset CONFIG_64BIT in i386_defconfig
To:     =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Diego_Elio_Petten=C3=B2?= <flameeyes@flameeyes.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 7:32 PM Daniel D=C3=ADaz <daniel.diaz@linaro.org> w=
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
> whereas previously (and with this patch):
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

Thanks for v2 of your patch.

Tested-by: Sedat Dilek <sedat.dilek@gmail.com>

- Sedat -

> ---
> v1 -> v2: Clarify subject
>
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
