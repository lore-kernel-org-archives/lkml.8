Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E371C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552D72078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 20:51:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RDFrFy3o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgEUUvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 16:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729538AbgEUUvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 16:51:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B9FC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:51:42 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f15so3433614plr.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 13:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=H6dqckf1vTL0+A9F3eub9FsB+SNy/hjV+N0HkKmEeVI=;
        b=RDFrFy3ov/aGsnUPaB0stZXoE0ABQ4rYXo9u6vo64Wka9qQ5Ip677wBiOOO4ti7m7b
         7bdkb270ao4fLFVqp03QuW9N10vSSExILol4Vju1tgR6CLePeLQCKKzz7+gBP9YVAjft
         ohwJob5MiJkgWON81j9KYKoUQRX8b1RR7Ot95LcYdQ+SKfpObt84NmVre2uAPo1oUNvD
         mR/O6pEK6t1IoP0HABsAJ397okttkiiOG7xhLa0O14PFRyNLUS0mCPeB6STd/4Ai2dn1
         QDzj2jTs8mIvzrwwHj2IuwpWFVQRcpk3AT4Boo4tFN+P1RsHYIlNB73Ecu7qpM2kWhyr
         LQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=H6dqckf1vTL0+A9F3eub9FsB+SNy/hjV+N0HkKmEeVI=;
        b=f14UJwccwv8moPyTcL3v7qDyuoys+fJ91oocY8Sxa0GbziZE6oBeaCsOoX6Q7M8ajy
         cxrx8jzjzTznAm135bmlZI1BD5vKFJmsx9Tj84ikAfy3zDsQJ29gPiQJ1k+n0xvirfaN
         JtInYNnnunvj5h3UMvC0Ki4UNGfyazBc+GFiWKatFRcJJoyCn50AkXY8RhJH0MMDUEEo
         U5268iqLpx8JvEPSg4UWxEolwiSXX3TCcDQBcHk3Fo1p+COAZi/x23OvQTkCz/eZnVEj
         GgqAAkeXk60biIYLntekcF0uaEFXeWlrjJHvWL9hGRjaoI083BbUr80p6dONK3D7EGHs
         l4bA==
X-Gm-Message-State: AOAM533HzrcK2AbPjsKtC/xI60b6KT1q2/MVOASmCBJm/WYZP9YCw98f
        Ghx4Inpube9Vp7SpvbzqaIpbJQ==
X-Google-Smtp-Source: ABdhPJyR9KDT5sKxbq+zDNn8chbjGus5VItWf4O0/TqMAfQJvHcRdTIOSUdWXWU9ys+VztoTdJWclQ==
X-Received: by 2002:a17:902:d907:: with SMTP id c7mr11675558plz.200.1590094302242;
        Thu, 21 May 2020 13:51:42 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id lj8sm5220209pjb.1.2020.05.21.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 13:51:41 -0700 (PDT)
Date:   Thu, 21 May 2020 13:51:41 -0700 (PDT)
X-Google-Original-Date: Thu, 21 May 2020 13:50:30 PDT (-0700)
Subject:     Re: [RFC PATCH linus] RISC-V: gp_in_global can be static
In-Reply-To: <20200518050227.GA13086@f1dbffaf4744>
CC:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     lkp@intel.com
Message-ID: <mhng-7dafbf2e-2bf8-447f-bb31-c3c640d0e898@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 May 2020 22:02:27 PDT (-0700), lkp@intel.com wrote:
>
> Fixes: 52e7c52d2ded ("RISC-V: Stop relying on GCC's register allocator's hueristics")
> Signed-off-by: kbuild test robot <lkp@intel.com>
> ---
>  process.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index 610c11e916068..3b2933839d492 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -22,7 +22,7 @@
>  #include <asm/switch_to.h>
>  #include <asm/thread_info.h>
>
> -unsigned long gp_in_global __asm__("gp");
> +static unsigned long gp_in_global __asm__("gp");
>
>  extern asmlinkage void ret_from_fork(void);
>  extern asmlinkage void ret_from_kernel_thread(void);

Thanks.  Looks like this is actually a real bug: gp_in_global was supposed to
have the "register" keyword, and missing that appears to cause the __asm__ to
be ignored.
