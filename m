Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC64C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD7E92065F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 13:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wTAAXqYW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728768AbgGPNT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 09:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728374AbgGPNT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 09:19:57 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15365C061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:19:57 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so10269010wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 06:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Opa04oEqgTBiOKYS1pjpUdtak0oL8WBVStzXqF1+/8=;
        b=wTAAXqYWiNlP2B6mjWEgbI3KTLl2M0kIkndJjf3MujFAWW6KxBgEHGHnK6nLsvxQUr
         uNgBkwVHPilPpPR06GmDjPi2JrQ0jdDsCMihlJEk9FBcMg0Krm8g2F14514JnrBaooXY
         ueu2SQbxihXqtyfVhrolWOPfnc8ouBq15nSh8Yo1YM5S1/Xxu4qMnNFBi/K/eKppxuZs
         GR6RLTrq5iVnR/rOOo/1PhFSyUv7yUDXRWj0d5d0tRE1eauZk9bDibb/+TZsMU3rb5qF
         uvBU2KmfSz5ySW/3Gbl2KKGrQVT1eB/mEYz/y/oUWRiKJSR3JD6Phk20cSntOYmLKPoa
         H6rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Opa04oEqgTBiOKYS1pjpUdtak0oL8WBVStzXqF1+/8=;
        b=BBFol5pYipsv1uKeZKVrc0fZD86+HGhfkn/X12eVea9wPvtmwiPGVoiaOECpUlu68X
         A6nUsmIEEwws0HuwSl42ISIu/BzAiAy7/XOBv2G8WlC3tO0nCGpxeQzUYGrY+seuxPCW
         xNLeibVS3M0FLo6BvPHCwuHNo9CbzwFU/yly5xpA/kPZxWkJ1UnINaRaztgs1nC5NoOP
         e2J0aAHO77ZcmYNOooHmhqyvZbU+u/5GrZYuMCJfvTB/fEMzuxMJnolcE8psI/V4G6pq
         umW2DU0bMvHG/aRdVkJu4dB2cW3WAKBP+ODY9Xk4I6NH3zQJ0YbeAyJx7RlCeYxaDJ+k
         EYMg==
X-Gm-Message-State: AOAM530IuQVKdoWkPLxQP0hpBj8MCn4K2OkS0/VCdu7a1w7QYhFUaThL
        FqXpyFdb1T5zoAaxgV5xF/of0JsPekgb/3H8ItbdXQ==
X-Google-Smtp-Source: ABdhPJylq+3o0Lu5wXx1xEQJXkr2imDIzJcWCeXrqYKBHTAAktFAHHv5KdeprXPI7ialRp6Hxj+DFYXMEvHWz62F8/Y=
X-Received: by 2002:a1c:2d91:: with SMTP id t139mr4306095wmt.3.1594905595633;
 Thu, 16 Jul 2020 06:19:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1594886530.git.zong.li@sifive.com> <628efa24c79a493e39ce6ef13017ae52eaf13388.1594886530.git.zong.li@sifive.com>
In-Reply-To: <628efa24c79a493e39ce6ef13017ae52eaf13388.1594886530.git.zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 16 Jul 2020 18:49:42 +0530
Message-ID: <CAAhSdy38QtmA-D2iOyC=dwrwtfVWfEiYQY529zJVsPS+FwTuzg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] riscv: Fix build warning for mm/init
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 6:35 PM Zong Li <zong.li@sifive.com> wrote:
>
> Add static keyword for resource_init, this function is only used in this
> object file.
>
> The warning message as follow (with W=1 build):
>
> arch/riscv/mm/init.c:520:13:
> warning: no previous prototype for 'resource_init' [-Wmissing-prototypes]
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/mm/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 92002952c621..66f5952f39c0 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -517,7 +517,7 @@ void mark_rodata_ro(void)
>  }
>  #endif
>
> -void __init resource_init(void)
> +static void __init resource_init(void)
>  {
>         struct memblock_region *region;
>
> --
> 2.27.0
>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup
