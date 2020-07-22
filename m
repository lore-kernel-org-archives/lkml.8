Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132A4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:38:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF23F2073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:38:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afEtrL1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgGVCin (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731621AbgGVCin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:38:43 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C3C061794;
        Tue, 21 Jul 2020 19:38:42 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d1so230453plr.8;
        Tue, 21 Jul 2020 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vNRW7z5cqSryapjbTJumBqetCY3C3HUg/svKvIOBSpc=;
        b=afEtrL1sXJiLMGMhqiM6tfsfpIgUqIhg/yoDKKj6xaKj37o3j29zKPXT6Nm5RETNYP
         dIXrNmyhf1GzW/UnbKge7XpAoBittGZE8u17bKid0xV0kkZycBHb+ojS3VOvOiU5JNOp
         0PXo71A/sB9jm4eh/XtSlIBt/WTW3S4AtWffJRTXsg6F5906AmC6weOs50smsAGn/g9q
         qPaTPqvutmSnpnE55SRqilCCsWgbNHe8adk3w5jAZcEFM2X1PwCa9kMzQu1iMjDqdzwP
         v6lfKKzGee6m7bUDc7twPCTA+9y6XWsdx/VGcY7s0K0SuUv5CNSi0jJ4pEjbimaTFw2x
         AfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=vNRW7z5cqSryapjbTJumBqetCY3C3HUg/svKvIOBSpc=;
        b=qaVqNou0fk4elxW1MlPsRtGhBdJZm0sxyVrsNfj726/w27JflHmHYsUc5AxZQfuq38
         kECdmOpun/0Lh6p2TR5WHnMcV4M1Jb58+vKjczcU2coA6zyV90cBgpEyzCv1d9x/1lD3
         60nAmHKFQkL2UU1PstT6c+s/MS+QuDHhBlHahbATIOheBBK+M0leJPMFHmjqjgASQDot
         lPD7UwyXcOYfxcf4OD7gQAIZoJoR+tgO+5BaFRunhBLm5bEj43NmUBn83QRurPzeGCHu
         Wp7nncSR0PFuebkgTHmnLSNGZicjUDcozMugGrBQUt+HwIQ3CPOXlvSRTcypLJAz5et9
         yTtA==
X-Gm-Message-State: AOAM5307Ve4aIlyi6ZaubSPzki+5lJW/qFIaAuwomP8MGhfvrToQ6GeU
        7yl5B4AlJVK+JHAsc6cbZnZNBq0Q
X-Google-Smtp-Source: ABdhPJwTJE/4ZseohlMQmRrdxEbrI/0srpGzpJejTObobsX+uMoJRp9M2Oxi5vp2nz7micD52WE6wQ==
X-Received: by 2002:a17:902:ee94:: with SMTP id a20mr22145813pld.337.1595385522324;
        Tue, 21 Jul 2020 19:38:42 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x7sm21133592pfq.197.2020.07.21.19.38.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Jul 2020 19:38:41 -0700 (PDT)
Date:   Tue, 21 Jul 2020 19:38:40 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: add missing EXPORT_SYMBOL() for __delay
Message-ID: <20200722023840.GA55317@roeck-us.net>
References: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wob2clos.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 11:38:43AM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> __delay() is used from kernel module.
> We need EXPORT_SYMBOL(), otherwise we will get compile error.
> 
> ERROR: "__delay" [drivers/net/phy/mdio-cavium.ko] undefined!
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

I must admit that this patch completely baffles me. __delay was
already exported, only elsewhere in the file. With this patch
in place, it is exported twice, and all sh builds in -next fail
with

In file included from include/linux/linkage.h:7,
                 from arch/sh/include/asm/bug.h:5,
                 from include/linux/bug.h:5,
                 from include/linux/thread_info.h:12,
                 from include/asm-generic/current.h:5,
                 from ./arch/sh/include/generated/asm/current.h:1,
                 from include/linux/sched.h:12,
                 from arch/sh/lib/delay.c:8:
include/linux/export.h:67:36: error: redefinition of '__ksymtab___delay'

Guenter

> ---
>  arch/sh/lib/delay.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sh/lib/delay.c b/arch/sh/lib/delay.c
> index dad8e6a..540e670 100644
> --- a/arch/sh/lib/delay.c
> +++ b/arch/sh/lib/delay.c
> @@ -29,6 +29,7 @@ void __delay(unsigned long loops)
>  		: "0" (loops)
>  		: "t");
>  }
> +EXPORT_SYMBOL(__delay);
>  
>  inline void __const_udelay(unsigned long xloops)
>  {
