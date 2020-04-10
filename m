Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE580C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E82B20936
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 03:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIrHtHD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDJDp5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 23:45:57 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38375 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgDJDp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 23:45:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id k11so239415wrp.5;
        Thu, 09 Apr 2020 20:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xTD8jqLlyYTauiGbffTw5JArkDLk+kEpu+J7BOSObAA=;
        b=jIrHtHD3eVDB4o2K9fZ6SYpFWqv66O3QgKUSr9wLyIIOFI+xwEQUUB0RoJRKoWu/lk
         3N22KRkgVpUHZmji3bKQJqgtBcxAuM3vonhAc+4Cc+ZIzo+qy/QUfH4QqPP3KMra3jsj
         BFVcmTUYnRpJKzoNNQ2vUZFejdAGXf8mFDGYYehjcisndSDRtU56VO1qcGOrBLdR97A+
         KEYaUo78t31Lwf4AyPipPLcAvynfo9yYnzn5J4FIP67FR0R9w/qevYR9XnGRDMnY83pk
         5wRXYwL7YbG3nF8/al4qhGIQ5IjxlA/zg1sgpa3DVhURe24NBqwE0MZ3ouTlQH597qwn
         vZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xTD8jqLlyYTauiGbffTw5JArkDLk+kEpu+J7BOSObAA=;
        b=bPxZXqMKsp95/bREXRDK4FmniPaxMMoaVQvbEkKKE5KwN0//Bx50S0oy6Ci/67Z76b
         6+zU+yUKLettItg3/zC7H04IYOQdAhwtEoAQgNQ1mn2vsLuWPOzVfQGJU03+hmqY95gl
         W8OjrMNnDanps1JSk7H4WgsWcxMh0EroRD9kx7lNsUy/pAWsx1pPu/mkLqUVtZL4uwQH
         iQoORHLapJpa1HS/sojRVnJqqHOiOCKyBfi4iujukhZJPyCImMJN2HI3/GdN7/cCteri
         nwPLXsPcjuw6RkSyfV5t+ynTPS7T4RrIDM7sFN22LRjqxQTgyru5uGBWskYnIyu2CjQE
         MZ6w==
X-Gm-Message-State: AGi0PuavTtEePFBxx8nsUVhAG17kPt04E00R8hOqT0wAadpXpEHGpphi
        miyIgD3pwMALMUFkQ5mTDsoGCS6DFYDRJd3HnRvSEC+J
X-Google-Smtp-Source: APiQypK+6oiYdmYVei4clXzwDHywzqlfmDFgVXzV+CwMdP3SEr9xkQ9HbMDkBCL7vxLBY781R9P01r8CZgBU69TJAtM=
X-Received: by 2002:adf:e98a:: with SMTP id h10mr2420186wrm.370.1586490353317;
 Thu, 09 Apr 2020 20:45:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200408160044.2550437-1-arnd@arndb.de> <CABOV4+UocLs3jLi7-vTi8muiFqACVdxH7Td8=U1ABveLnmyCuw@mail.gmail.com>
 <CA+nhYX0H-czfJ6Kg+FK7X2=hHQK185UOLGoPdEP3nqWQWcA+bg@mail.gmail.com>
In-Reply-To: <CA+nhYX0H-czfJ6Kg+FK7X2=hHQK185UOLGoPdEP3nqWQWcA+bg@mail.gmail.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Fri, 10 Apr 2020 11:45:16 +0800
Message-ID: <CAAfSe-s=dZe=6y7UH8CBcddL1BKoLOAvi24RekgdmVv0StxTTA@mail.gmail.com>
Subject: Re: [PATCH] [RFC] clk: sprd: fix compile-testing
To:     Sandeep Patil <sspatil@android.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Apr 2020 at 04:17, Sandeep Patil <sspatil@android.com> wrote:
>
>
>
> On Wed, Apr 8, 2020 at 11:09 PM Chunyan Zhang <zhang.lyra@gmail.com> wrot=
e:
>>
>> Hi Arnd,
>>
>> Thanks for finding out this and fixing it, but we have a minor concern
>> for changing ARCH_APRD back to bool.
>>
>> On Thu, Apr 9, 2020 at 2:57 AM Arnd Bergmann <arnd@arndb.de> wrote:
>> >
>> > I got a build failure with CONFIG_ARCH_SPRD=3Dm when the
>> > main portion of the clock driver failed to get linked into
>> > the kernel:
>> >
>> > ERROR: modpost: "sprd_pll_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.k=
o] undefined!
>> > ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9863a-clk.ko] undef=
ined!
>> > ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9863a-clk.ko] undef=
ined!
>> > ERROR: modpost: "sprd_comp_ops" [drivers/clk/sprd/sc9863a-clk.ko] unde=
fined!
>> > ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9863a-clk.ko] undef=
ined!
>> > ERROR: modpost: "sprd_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] unde=
fined!
>> > ERROR: modpost: "sprd_sc_gate_ops" [drivers/clk/sprd/sc9863a-clk.ko] u=
ndefined!
>> > ERROR: modpost: "sprd_clk_probe" [drivers/clk/sprd/sc9863a-clk.ko] und=
efined!
>> > ERROR: modpost: "sprd_clk_regmap_init" [drivers/clk/sprd/sc9863a-clk.k=
o] undefined!
>> > ERROR: modpost: "sprd_pll_ops" [drivers/clk/sprd/sc9860-clk.ko] undefi=
ned!
>> > ERROR: modpost: "sprd_div_ops" [drivers/clk/sprd/sc9860-clk.ko] undefi=
ned!
>> > ERROR: modpost: "sprd_mux_ops" [drivers/clk/sprd/sc9860-clk.ko] undefi=
ned!
>> >
>> > This is a combination of two trivial bugs:
>> >
>> > - A platform should not be 'tristate', it should be a 'bool' symbol
>> >   like the other platforms, if only for consistency, and to avoid
>> >   surprises like this one.
>>
>> After a discussion, we decided to change ARCH_SPRD to tristate, the
>> idea was that we hope we can simply switch all sprd drivers' configs
>> (whose default is ARCH_SPRD) to 'm' by setting ARCH_SPRD=3Dm, or switch
>> all them to 'y' by setting ARCH_SPRD=3Dy, instead of changing them one
>> by one. This requirement originally came from that Google GKI project
>> asks all vendor drivers to be built as modules.
>
>
>
> Unfortunately, even if ARCH_SPRD can be tristate, we found out (like Ard =
did here) that none of the other platform symbols can be tristate :(.
>
> So, we are going to enable all CONFIG_ARCH_XXXX in our defconfig[1]. Chun=
yan, Please feel free to submit that patch to AOSP for that.
>
> This does present us with a problem. We found that a bunch of drivers are=
  'default y if ARCH_XXX'. A lot of them have no symbol dependencies on the=
 code that gets compiled with ARCH_XXX. They depend on it only because "the=
 driver is only needed for the XXX SoC or the family".
>
> For example, enabling CONFIG_ARCH_MEDIATEK, will end up building almost a=
ll drivers in drivers/pinctrl/mediatek as far as I can see.
>
> This does add up. It increases the size of the kernel considerably. I hav=
e plans to send out the comparison in the future (later this year) once we =
are done collecting all def configs and see how bad that is.
>
> The only sane way I can see that can be resolved (if people agree that's =
a problem), is to make the ARCH_XXX code tristate-able and make the ARCH_XX=
X Kconfig select every driver it needs, instead of the other way round.

If we making the ARCH_XXX Kconfig select all drivers it needs, we will
not have chance to custom the kernel Image for debug purpose. For
example we can bringup a minimum system with only serial driver on
sprd platforms.

>
> All that being said, It is obviously not ok to have the allmodconfig brok=
en like this without adding explicit dependencies as suggested above, or re=
vert CONFIG_ARCH_SPRD to be a 'bool'.

We see this broken because I shouldn't leave clk Makefile a tristate
compile [1] after changing ARCH_SPRD to be tristate.

If we will make ARCH_SPRD tristate-able in the future and you all
aggree that, I would like to do it now, and pay more attention to
Makefiles and dependencies.

I can also make a change like below:

diff --git a/drivers/clk/sprd/Kconfig b/drivers/clk/sprd/Kconfig
index e18c80fbe804..9f7d9d8899a5 100644
--- a/drivers/clk/sprd/Kconfig
+++ b/drivers/clk/sprd/Kconfig
@@ -2,6 +2,7 @@
 config SPRD_COMMON_CLK
        tristate "Clock support for Spreadtrum SoCs"
        depends on ARCH_SPRD || COMPILE_TEST
+       depends on m || ARCH_SPRD !=3D m
        default ARCH_SPRD
        select REGMAP_MMIO

Arnd, Stephen, Sandeep, what do you think? Does that make sense?

Thanks,
Chunyan

[1] https://elixir.bootlin.com/linux/v5.6.3/source/drivers/clk/Makefile#L10=
8

>
> So fwiw,
>
> Acked-by: Sandeep Patil <sspatil@android.com>
>
> - ssp
>
> 1. https://android.googlesource.com/kernel/common/+/refs/heads/android-5.=
4/arch/arm64/configs/gki_defconfig#45
