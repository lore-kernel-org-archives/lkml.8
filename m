Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F603C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72EFD217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 15:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579620275;
	bh=7VkYr9NSHgXJNId+ZkFnO6kM3gMQsAHlVVEEAr5S5iE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pB0vlIAAgO3b9nRxvBgselbHgY3UuID6QcLtitK2Y721L02u1p7yBwQ8opOjaqGHi
	 nBvH2LU94w5Ot/j/d4EH2Umx2cSVFonqU4NL1WUCX7vMki7LHVuUOTEtWMsSIj4XIh
	 ODEb78NIPZH1Up1WvXMhFnKUcRC1/vfO2QXilq04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbgAUPYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 10:24:34 -0500
Received: from conssluserg-02.nifty.com ([210.131.2.81]:50360 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727508AbgAUPYe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 10:24:34 -0500
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 00LFOMvC020513
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 00:24:22 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 00LFOMvC020513
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1579620263;
        bh=hT4cfrVYUNJPdXLZYNW8nx8XfS2S9IHAEXWJB9a5qQs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M4yK3QiNsYp2WtgSLE2CSMBYuT65r8bdKaGgNUoH9A3GwxOCqXfrqgvCedtc4cHuW
         U2Ndj5mItH2ouvZh3Xy293mYrqIy+5dlbn4FlmQE6litXXljm91rDXlm6OVnjpVktA
         eXCNb9WLqUxMT2bcO+8z3KlaAjqovFNQGltKW7Mb//jkBNypFcevW2TVu782EaHopk
         0B37JO6L7ImHPZMyFaVpSs47VyQSS3AMrGiIS2A5PQIpaZkSnV9N6ZN/LzHAbs4GJl
         ClV5OZ5HXoI41Jh9jodXw5+eJPU6lHmg6UPJghFgMpSg+TfLTzfV4sooSp4X+/oS6T
         wT5btMazsdpxQ==
X-Nifty-SrcIP: [209.85.222.46]
Received: by mail-ua1-f46.google.com with SMTP id 73so1125554uac.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 07:24:22 -0800 (PST)
X-Gm-Message-State: APjAAAWRTJnIYKYmnmhmN/YuxxHB8d6tCPYVWIY4ByZLEqRrC7ABUk1X
        kwj5EtCOE04ZmvPENIiWbh1Hc5EIRoUxzHmyA7Q=
X-Google-Smtp-Source: APXvYqyVG2I15i8f1wNhUebZbsH9RXVtwMlz5AWZnFTIjvszireuTZHsziwZJOZYG1kUq0zCfifxuyjcHdP3rerRO7Q=
X-Received: by 2002:ab0:6509:: with SMTP id w9mr3190475uam.121.1579620261607;
 Tue, 21 Jan 2020 07:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20200121134739.22879-1-erosca@de.adit-jv.com>
In-Reply-To: <20200121134739.22879-1-erosca@de.adit-jv.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Jan 2020 00:23:45 +0900
X-Gmail-Original-Message-ID: <CAK7LNASm=7P3cJ=SB3hmPjqWTii1Lv2pf3p0xc-hx0XNTdaJHw@mail.gmail.com>
Message-ID: <CAK7LNASm=7P3cJ=SB3hmPjqWTii1Lv2pf3p0xc-hx0XNTdaJHw@mail.gmail.com>
Subject: Re: [PATCH] arm64: kbuild: remove compressed images on 'make
 ARCH=arm64 (dist)clean'
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, Jan 21, 2020 at 10:48 PM Eugeniu Rosca <erosca@de.adit-jv.com> wrote:
>
> From: Dirk Behme <dirk.behme@de.bosch.com>
>
> Since v4.3-rc1 commit 0723c05fb75e44 ("arm64: enable more compressed
> Image formats"), it is possible to build Image.{bz2,lz4,lzma,lzo}
> AArch64 images. However, the commit missed adding support for removing
> those images on 'make ARCH=arm64 (dist)clean'.
>
> Fix this by adding them to the target list.
> Make sure to match the order of the recipes in the makefile.
>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>

Please change Cc with my

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Thanks.


> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
> ---
>  arch/arm64/boot/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/Makefile b/arch/arm64/boot/Makefile
> index 1f012c506434..cd3414898d10 100644
> --- a/arch/arm64/boot/Makefile
> +++ b/arch/arm64/boot/Makefile
> @@ -16,7 +16,7 @@
>
>  OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>
> -targets := Image Image.gz
> +targets := Image Image.bz2 Image.gz Image.lz4 Image.lzma Image.lzo
>
>  $(obj)/Image: vmlinux FORCE
>         $(call if_changed,objcopy)
> --
> 2.25.0
>


-- 
Best Regards
Masahiro Yamada
