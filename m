Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B238FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 904102067B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 00:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="juQe+upO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgFEABp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 20:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgFEABo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 20:01:44 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD44C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 17:01:43 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n23so4227185pgb.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 17:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=MrpdpocEURe/t3y3gZl3X5wMKrRSnAGOPmZQ5g0avbc=;
        b=juQe+upOZBcu5uYuurfczE1LF3Zyt3bYitv3q9E6S0ccXNZFkB3wZ53YoGbnveWA2Q
         ZwafILlf1ALSg5fDfckDiyifJigjOBUeywvfrSpgvGROo1jnfQvF/sN4untmlIHaVEp5
         XTuq7L2sXQFa3XQtUrTuaWCM+MC6mVfGac0aozm835quSPepv60kDarekyfGHTBg8GCq
         QDCre/K65kmMao7IFxaoqSKXUJsT4ddDi32PH7B1q/sn1UmJll+/5QKv3cycvpQJ7pGM
         yb2KGogoy+eoEfskAlTPlRqoHpgEAPIlADsGFLudYN0sEC+Sl9KjMScpgxvGsF848uix
         qdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=MrpdpocEURe/t3y3gZl3X5wMKrRSnAGOPmZQ5g0avbc=;
        b=rBthlDLR7ukxnbuQ8zDvk+US+Ge78WzwOJG5QpDrnT1Xb5scISSq2Jm2h5OD4A0BbA
         FBzc797Sdr7simZa9pIH3Isgn2F+uNrR/L5xPxCm5ue2MzZmuiThASzWYJI+O6dKw8zt
         yK0RqxANm6JJzmUkkObkZlMIk3UkCAEHnIr0m5RYFsi723q4bq0XS6hYD0ukRTP+lpZl
         I5YjmkRFK4+hy3Av46ElBbACxA8hdSaNdNNCt6SRAesjgt/QzB3a0SRqBB+8M85wmt7X
         yMeH+ytlvriHcH18QprHigeDl5SBbcjBKOyNTMObFbevS67eS6YkXgDz5RKVLSWQ4ijR
         QGJw==
X-Gm-Message-State: AOAM530bixKQckPaKC9m2LYNha2WOqHjHpO/wF0/1aUJyv5T9od6mb40
        xvKydVOEhy9to45W62DK7G4iQg==
X-Google-Smtp-Source: ABdhPJy4hOSc4BH6wa0zaDSNuSgjQdv97BrlAnQP9eXDo87HxRJw5B1jx9UEYZzVsfw42ghgXTuz/Q==
X-Received: by 2002:a62:84d0:: with SMTP id k199mr7145258pfd.156.1591315302557;
        Thu, 04 Jun 2020 17:01:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y10sm5000928pgi.54.2020.06.04.17.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 17:01:41 -0700 (PDT)
Date:   Thu, 04 Jun 2020 17:01:41 -0700 (PDT)
X-Google-Original-Date: Thu, 04 Jun 2020 15:26:59 PDT (-0700)
Subject:     Re: [PATCH] riscv: fix build warning of missing prototypes
In-Reply-To: <7acb6dcf9975bbf3aff4be3b01320fd1b5ba30c1.1590983619.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com, lkp@intel.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-44445efa-712b-441e-a8f2-9821f4e89b3b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 20:55:32 PDT (-0700), zong.li@sifive.com wrote:
> Add the missing header in file, it was losed in original implementation.
>
> The warning message as follows:
>  - no previous prototype for 'patch_text_nosync' [-Wmissing-prototypes]
>  - no previous prototype for 'patch_text' [-Wmissing-prototypes]
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> ---
>  arch/riscv/kernel/patch.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> index 5805791cd5b5..d4a64dfed342 100644
> --- a/arch/riscv/kernel/patch.c
> +++ b/arch/riscv/kernel/patch.c
> @@ -11,6 +11,7 @@
>  #include <asm/kprobes.h>
>  #include <asm/cacheflush.h>
>  #include <asm/fixmap.h>
> +#include <asm/patch.h>
>
>  struct patch_insn {
>  	void *addr;

Thanks, this one is queued up -- for-next is in flux right now, but with any
luck it'll get sorted out soon.
