Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605C3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3A920714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 17:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T9r6OI/Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730058AbgGWR3d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 13:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730026AbgGWR3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 13:29:33 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A99C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 10:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=7zJN/mFgQiaW2M8l3a/yQm6ieB3aj4ZPUJdrICgr1WU=; b=T9r6OI/ZuDxCiAmE//+jYBPvbA
        G+RkSqDK6xbGcMG1dEmF5THGA+7/o99Mlp9fGh4sRFr3vYTG42WBwBTM2JYMLnjSy9+ZOWst/6vbz
        5QewAY2SxYuLDUs87Y51HIHQsiNEYQtg92UXzW0wmjFAktvI0e4D279KCycc2NYIaMCNVFb4koYr6
        wTlz8lc+4+UDhstNru3lkyfXuZOH6vwHUwJpjdRJVWaj2nC2QjWP1CVZCKTVdIqGp7jT3h/K155ev
        x0AeQ+OgZQUZDfeeeHQn3S2kd5yCQRVjkcrpWgr2bpBASOFzrMnwlMCsCG/G9pv3RIpWlumuPC/Mm
        4mkA6sXg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jyf26-0000nu-Or; Thu, 23 Jul 2020 17:29:27 +0000
Subject: Re: [PATCH v2] x86/configs: Remove CONFIG_CRYPTO_AES_586 from
 i386_defconfig
To:     Sedat Dilek <sedat.dilek@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Diego_Elio_Petten=c3=b2?= <flameeyes@flameeyes.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <20200723171119.9881-1-sedat.dilek@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6730f39e-120c-9fec-6bee-f210833d91f2@infradead.org>
Date:   Thu, 23 Jul 2020 10:29:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723171119.9881-1-sedat.dilek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 10:11 AM, Sedat Dilek wrote:
> Initially CONFIG_CRYPTO_AES_586=y was added to i386_defconfig file
> with commit c1b362e3b4d3 ("x86: update defconfigs").
> 
> The code and Kconfig for CONFIG_CRYPTO_AES_586 was removed in:
> 
> commit 1d2c3279311e4f03fcf164e1366f2fda9f4bfccf
> ("crypto: x86/aes - drop scalar assembler implementations")
> 
> Remove the Kconfig relict from i386_defconfig file.

                     relic

> 
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> Changes v1 -> v2:
> - Add CC to Ard and Herbert (see commit 1d2c3279311e)
> 
>  arch/x86/configs/i386_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
> index 550904591e94..3a2a89882350 100644
> --- a/arch/x86/configs/i386_defconfig
> +++ b/arch/x86/configs/i386_defconfig
> @@ -290,7 +290,6 @@ CONFIG_SECURITY_NETWORK=y
>  CONFIG_SECURITY_SELINUX=y
>  CONFIG_SECURITY_SELINUX_BOOTPARAM=y
>  CONFIG_SECURITY_SELINUX_DISABLE=y
> -CONFIG_CRYPTO_AES_586=y
>  # CONFIG_CRYPTO_ANSI_CPRNG is not set
>  CONFIG_EFI_STUB=y
>  CONFIG_ACPI_BGRT=y
> 


-- 
~Randy
