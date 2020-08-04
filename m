Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E033CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8B1A207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596567760;
	bh=bT0VZqEi+grdliT6UaafruzREm3efnOvWjKAy597liM=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oGSV33WOVaAkPBKuG+c2k94FpMY1QY1kOIQGJrD5W9zaMWIMPQBV4Fpihk1K8VzXx
	 /RajnHVFsnfTFMz8P49k9CS71JkTTMjYHIEwSEEfJGQYZWAR3AhHzPz68ysdM4Pq8i
	 TjVoban3kkHC+31AC9w8Vz0Sc7J04r6KlYxY+GYI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHDTCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:02:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgHDTCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:02:37 -0400
Received: from [192.168.1.28] (cpe-70-114-128-244.austin.res.rr.com [70.114.128.244])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEADB207FC;
        Tue,  4 Aug 2020 19:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596567756;
        bh=bT0VZqEi+grdliT6UaafruzREm3efnOvWjKAy597liM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lQ0jhb9ytCAzxKCsUmNzfmtFikrE7NDwtwECi5l8O/6DP7F6FopJv1i7j9lXlSmr/
         Z5/giswx1BMYuQKF45Py9gXsjxWVmk1fuWoyNHm3h7nthaMyDXvFnbHDtN3ifiY9Qv
         vk6mAlR5SX9sU2zJsvdJ9xCv1iqvegr7pPIigHgg=
Subject: Re: Build error caused by "arm64: dts: agilex: add nand clocks"
To:     Markus Mayer <mmayer@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Device Tree <devicetree@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <CAGt4E5tMdG9gZbx43MeXpiPnqe0sy9bYKQmZ1oJCSwTL=Xf7Dg@mail.gmail.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
Autocrypt: addr=dinguyen@kernel.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e19005d8-3a2f-c688-775d-92067390853b@kernel.org>
Date:   Tue, 4 Aug 2020 14:02:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGt4E5tMdG9gZbx43MeXpiPnqe0sy9bYKQmZ1oJCSwTL=Xf7Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Markus,

Thanks for catching this.

There's a commit that is going through the clock tree that will fix this:

commit c2710fdf935bb1286e8eb6a6b44991bab1fe87af
Author: Dinh Nguyen <dinguyen@kernel.org>
Date:   Tue Jun 16 15:24:15 2020 -0500

    dt-bindings: agilex: add NAND_X_CLK and NAND_ECC_CLK

    Add the NAND_X_CLK and NAND_ECC_CLK clocks.

    Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
    Link:
https://lore.kernel.org/r/20200616202417.14376-1-dinguyen@kernel.org
    Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Once the clock updates get merged, this should get fixed. I'll be more
mindful of this in the future.

Dinh


On 8/4/20 1:48 PM, Markus Mayer wrote:
> Hi,
> 
> I don't know if anybody else is seeing this, but for me the commit
> "arm64: dts: agilex: add nand clocks"[1] is causing a build error
> while generating DTS files for ARM64.
> 
> The error goes away when I drop the commit.
> 
> $ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make defconfig dtbs
>   HOSTCC  scripts/basic/fixdep
>   HOSTCC  scripts/kconfig/conf.o
>   HOSTCC  scripts/kconfig/confdata.o
>   HOSTCC  scripts/kconfig/expr.o
>   LEX     scripts/kconfig/lexer.lex.c
>   YACC    scripts/kconfig/parser.tab.[ch]
>   HOSTCC  scripts/kconfig/lexer.lex.o
>   HOSTCC  scripts/kconfig/parser.tab.o
>   HOSTCC  scripts/kconfig/preprocess.o
>   HOSTCC  scripts/kconfig/symbol.o
>   HOSTCC  scripts/kconfig/util.o
>   HOSTLD  scripts/kconfig/conf
> *** Default configuration is based on 'defconfig'
> [...]
>   DTC     arch/arm64/boot/dts/freescale/imx8mq-pico-pi.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mq-thor96.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8qxp-ai_ml.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtb
>   DTC     arch/arm64/boot/dts/freescale/imx8qxp-mek.dtb
>   DTC     arch/arm64/boot/dts/freescale/s32v234-evb.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hi3798cv200-poplar.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hi6220-hikey.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hip05-d02.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hip06-d03.dtb
>   DTC     arch/arm64/boot/dts/hisilicon/hip07-d05.dtb
>   DTC     arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb
> Error: arch/arm64/boot/dts/intel/socfpga_agilex.dtsi:313.15-16 syntax error
> FATAL ERROR: Unable to parse input tree
> make[3]: *** [scripts/Makefile.lib:309:
> arch/arm64/boot/dts/intel/socfpga_agilex_socdk.dtb] Error 1
> make[2]: *** [scripts/Makefile.build:497: arch/arm64/boot/dts/intel] Error 2
> make[1]: *** [Makefile:1306: dtbs] Error 2
> make: *** [Makefile:336: __build_one_by_one] Error 2
> 
> Regards,
> -Markus
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d4ae4dd346cd49302d157b129ead2f60d3a82534
> 
