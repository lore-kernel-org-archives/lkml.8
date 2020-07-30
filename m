Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52452C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2683020842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jul0GeYc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgG3NAG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:00:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726581AbgG3NAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:00:05 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66389C061794
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:00:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id mt12so4130582pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 06:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fwFyMOazKKiYzOl4gTWFUgJME/fvexSQw+gleCBjVCQ=;
        b=Jul0GeYcWOTtedHn0n+65O4obMnCkCJmwB7ba/iE8q423Xc9LUXKyRQeZ1a/GDCcXD
         VURadFwqX0wIDTd5htC23tikixUe/cwhPmGxhEAoKuaqN7SHs0LYSr4XDMD0tJKc+KVL
         rAJcgPAQqJmLIK2dW0SHZS1DFOoLHQ6HjfkhSjkf7SCUUzX2L1/t5ubpsla6GlsElx90
         r80AUL1V9q42J7fqR+unLwVNcDS9rRKrjJtrZqGb3edJrNz3ySpd2Fs3A0cI6p+AO5Nd
         1TTo/4xK/pG/qPT1/+tIOCbvE80zd9DeebkgFyi2nRNXfrMmCsNkHp2CeMalTTgVPSD7
         CGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fwFyMOazKKiYzOl4gTWFUgJME/fvexSQw+gleCBjVCQ=;
        b=soatttYljkEnpaSGvR/4u4A13H+FWGzi69sBPgKuhjX1I+rXOfaQdR1zIowSsoLc2m
         oSeWoNoK4nSn5Oo6epJ4CG/+VwKn0y1gnyAfXQTNWndM92p4AZRnuAZ+23C9M/GXpl/F
         71ujduhVcYikJw6bZDjc4Yo4k1ePDyziDtLLj7Knk+o2UpCtE9DswK3cmytOJ3bSNc1y
         kB460efvvGnhNxLK2WdSUk9U76FSOxfSSypcuzKbm+6zUxlb+07y41vswjHTz7bfI6Xo
         BwzB/OBxQe4mpkI9S1HJ8P+Sw03ZTNJmm9f4GQZbTGXOxp+xU25CkzsGVHPBJ7I8MqBU
         HhUA==
X-Gm-Message-State: AOAM531m/LmT3E5prw30ll0cY8nBjr+a5YDAs9dxpYnUQKur0Tdm5H29
        xKe3sZ/AUwL59vPLJl2eLdgPso5FRodRHA==
X-Google-Smtp-Source: ABdhPJyuefbwDvMhZKXxCqSv0gsmfFOOhdLXVfl1m4Bkpw7ImrhKA08NUgsI1dyUUkS/fFijfU7mZA==
X-Received: by 2002:a17:902:b403:: with SMTP id x3mr7825079plr.250.1596114004975;
        Thu, 30 Jul 2020 06:00:04 -0700 (PDT)
Received: from localhost ([103.29.143.67])
        by smtp.gmail.com with ESMTPSA id g8sm6149026pgr.70.2020.07.30.06.00.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Jul 2020 06:00:04 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:00:05 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        james.morse@arm.com, peterx@redhat.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: Re: [PATCH] arm64: mm: add message to die() in die_kernel_fault()
Message-ID: <20200730210005.000069a0.zbestahu@gmail.com>
In-Reply-To: <20200730122723.GN25149@gaia>
References: <20200730114757.13592-1-zbestahu@gmail.com>
        <20200730122723.GN25149@gaia>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020 13:27:23 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> On Thu, Jul 30, 2020 at 07:47:57PM +0800, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Just to identify the kernel fault more clearly.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  arch/arm64/mm/fault.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> > index 8afb238..3a753c7 100644
> > --- a/arch/arm64/mm/fault.c
> > +++ b/arch/arm64/mm/fault.c
> > @@ -289,7 +289,7 @@ static void die_kernel_fault(const char *msg, unsigned long addr,
> >  	mem_abort_decode(esr);
> >  
> >  	show_pte(addr);
> > -	die("Oops", regs, esr);
> > +	die("Oops - Page fault", regs, esr);
> >  	bust_spinlocks(0);
> >  	do_exit(SIGKILL);
> >  }  
> 
> Don't we already print enough information prior to die()?
> 

Yes, we have. But "Oops" is a little common. Add specific message is just to avoid to
use it repeatedly by other callers just like die("Oops - BUG",,), die("Oops - KASAN",,).

Moreover, die() will call panic() if require, panic() does not know which oops it is.
We can let panic() know it for debug expansibility such as store the panic message to
reserved memory.
