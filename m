Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F15C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27BC0208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 08:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZneWMIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgGaIow (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 04:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730268AbgGaIov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 04:44:51 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73628C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:44:51 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so3364713pjr.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RQQdPxyY0GeHXSyCibl+PmSmlkZL8y9bNuIzzHntUAg=;
        b=jZneWMIpJgUVgJL8rhZpk7LFvHIkO9m+4F6uBmJQZEkhIG/ucuJuaY0/L18sTcfROW
         bWt31DIdWMFW8Ur9icruaCulA1nWxAoHiHU2wSRWevVV5oTU0aai37Gmdzz3l7xLsFHB
         VY6Z72ea8K+VgYPibzZbVFq+zUjm5w5769Gg2n7tWfb1f6lU6HeC02sCEP5jqVqNg4rQ
         vAK7kxhqWs6RmoaO8StcIMn2OaKNQhAHfb6AvwEXqMbhyOIBKq8W4GtZ/hPQKhJ4gOSv
         Ierity1JBYG6dgGNffaseVGFvOWDBB1uaRfPSfun4kNhH0syFuPFYtNwOAptTe4EwkjK
         Z14A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RQQdPxyY0GeHXSyCibl+PmSmlkZL8y9bNuIzzHntUAg=;
        b=g4sShSj1mZAkpBwA3FRbV3ggqoXOZpedozP4iybvWQphVF5z9knyjqOvaVDSLafrAo
         JcPde3bC51jCwmxgLgNNDx5YZ4tjbtuDJUZUDDSErikcNxV9YraRMOoVrYXdoPOHpKWE
         jdrkDRGXyckEaNnikZdt/HsypOuQW+Bq9KK53zxlfDSJ/JxWxECxoanD5VueOGNjrTBR
         26Mto0mgotllNg0oYtbI7HDWrfcF4iKkRagGxshYgF/P9NZmEH5BGWp2QBWV9W+9cEyk
         FHbJKEMRAfJV18hwEAwtVndgju4Whsp72TB2wXRts55YTY6OiKW15PCpxUd/9yoTYTF1
         x76A==
X-Gm-Message-State: AOAM5313GZcQvAeiNow0U3mss+2K0i/U0MAgEbrHqCbwH/4GHjXrmM7N
        X6tfMXCz5vxUzg2hP5gxv275oGGertTdcDfhm4IjQ7YV
X-Google-Smtp-Source: ABdhPJwTnVwcTWp+COM9IMmXknPPqWRbFEyM2gN80kq6c3aCbRBUPIxGI+ESqB4imBTLnNvYfxhsm9OvW4RdO4+Snkw=
X-Received: by 2002:a62:758f:: with SMTP id q137mr2684719pfc.170.1596185090952;
 Fri, 31 Jul 2020 01:44:50 -0700 (PDT)
MIME-Version: 1.0
References: <8b64c9f9e54351d841daea663f0579de3c103f15.1596103176.git.eswara.kota@linux.intel.com>
In-Reply-To: <8b64c9f9e54351d841daea663f0579de3c103f15.1596103176.git.eswara.kota@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 31 Jul 2020 11:44:34 +0300
Message-ID: <CAHp75Vere3B3CJ0fWkPL2h=qfgYrq93wON86_wmqa2FaK8E3=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] x86/tsr: Fix tsc frequency enumeration failure on
 Lightning Mountain SoC
To:     Dilip Kota <eswara.kota@linux.intel.com>
Cc:     "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Tanwar, Rahul" <rahul.tanwar@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy@infradead.org>, cheol.yong.kim@intel.com,
        chuanhua.lei@linux.intel.com, qi-ming.wu@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 1:01 PM Dilip Kota <eswara.kota@linux.intel.com> wrote:
>
> Frequency descriptor of Lightning Mountain SoC doesn't have all the
> frequency entries so resulting in the below failure causing kernel hang.
>
> [    0.000000] Error MSR_FSB_FREQ index 15 is unknown
> [    0.000000] tsc: Fast TSC calibration failed
>
> So, add all the frequency entries in the Lightning Mountain SoC frequency
> descriptor.
>

I'm wondering if you get Tony's blessing for this change...
In any case, one nit-pick below and Cc Tony for the next version.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 0cc5359d8fd45 ("x86/cpu: Update init data for new Airmont CPU model")
> Fixes: 812c2d7506fd ("x86/tsc_msr: Use named struct initializers")
> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>



> ---
> Changes on v2:
>   Add description in the comments explaining about frequency entries.
>
>  arch/x86/kernel/tsc_msr.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/tsc_msr.c b/arch/x86/kernel/tsc_msr.c
> index 4fec6f3a1858b2..83b54c65aad2f3 100644
> --- a/arch/x86/kernel/tsc_msr.c
> +++ b/arch/x86/kernel/tsc_msr.c
> @@ -133,10 +133,15 @@ static const struct freq_desc freq_desc_ann = {
>         .mask = 0x0f,
>  };
>
> -/* 24 MHz crystal? : 24 * 13 / 4 = 78 MHz */
> +/*
> + * 24 MHz crystal? : 24 * 13 / 4 = 78 MHz
> + * Frequency step for Lightning Mountain SoC is fixed to 78 MHz,
> + * so all the frequency entries are 78000.
> + */
>  static const struct freq_desc freq_desc_lgm = {
>         .use_msr_plat = true,
> -       .freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000 },

> +       .freqs = { 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000, 78000,
> +                  78000, 78000, 78000, 78000, 78000, 78000, 78000 },

Keep 8 per line (or 4 per line).

>         .mask = 0x0f,
>  };
>
> --
> 2.11.0
>


-- 
With Best Regards,
Andy Shevchenko
