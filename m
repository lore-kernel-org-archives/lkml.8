Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA04C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0289020672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 17:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OK6kB8Q0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgGFR5l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 13:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgGFR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 13:57:37 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1515C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 10:57:36 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z13so42121911wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 10:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oTojjIFZzclanf7cLLuaYi/sgvjqGLuwhbXDv27Czb8=;
        b=OK6kB8Q0qPe86xIOUaHuGwfdS2zOPVnI1nFVI5idSlyGCaQ0kwkLr5OQ3iqaCDrVgp
         bSOqJkCjp0ec0QS590uLshH3kIWpHf1xbHU4eFZSHTSz2iazne518HLTBvJhqDK56dUJ
         VfvvqQ499iFKyO7u5d9hnovYGKCEt81Di/gCvWZ/6DEke38vxLl9lqh8sFCeusLjL1Ml
         2qR161f3NJOvDObqFI6szLGqFQi4ZzNG3O+MRRM8N5BRRw06NsO/2NWwp4otwehlAyaq
         GjgvDbYRQdLgMd7gAaG1L8Juu1JYUeppORL67+udHl59TzHLYTVJB6lnzxfeszfPKiFn
         3hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oTojjIFZzclanf7cLLuaYi/sgvjqGLuwhbXDv27Czb8=;
        b=aJbAI+gJPsXjo4dM+rGojd4K0a4IRncSlrHIeu2B5azhZZCk2mKQSqL8VAI4rst3Sg
         b+OVhPCFPjtd8GsNUOGtDAfImo0iRo8muKR43HSUQtOSxwOOpLO7hf+Sd6s7BUmsQBeI
         /9hnptU47mNvWXYMEEJhpA6nMDJ2c49QYvi0Th47AyDcSKwp/3O84me8JSdMTiWdAC/W
         kShkotdHS/0eBoUC2/cAwOpEJUgcZ/f8XBo2VyO29jrN/YSldV0eGYrs6LbxuqbBT1hT
         ApPWvfPRjXGZXMehN7pGspRiBwUMKgPjQ8XOBVfZSaM4PHHfXrnIKn0R44+zaLtpv3YI
         s/mw==
X-Gm-Message-State: AOAM532xd1dXs/hZsyp0AY6HvLZySShh2ONYd2qyHSIfkkTj/ig3hj9H
        ehbUFp14XC+sPGTbMJPQl8AjvQ==
X-Google-Smtp-Source: ABdhPJxS0ATrWjLo9sj+XUyy8koys1QP+PJvoeoFNUvPJiTVFA4tFZil89Y+Fn6a3oT6x5JiwFKCRQ==
X-Received: by 2002:adf:b198:: with SMTP id q24mr19941076wra.335.1594058255478;
        Mon, 06 Jul 2020 10:57:35 -0700 (PDT)
Received: from dell ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id r8sm24689046wrp.40.2020.07.06.10.57.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 10:57:34 -0700 (PDT)
Date:   Mon, 6 Jul 2020 18:57:33 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Petr Mladek <pmladek@suse.com>,
        Yinghai Lu <yhlu.kernel@gmail.com>,
        Jason Wessel <jason.wessel@windriver.com>
Subject: Re: [PATCH 25/32] usb: early: ehci-dbgp: Remove set but never
 checked variable 'ret'
Message-ID: <20200706175733.GB3500@dell>
References: <20200706133341.476881-1-lee.jones@linaro.org>
 <20200706133341.476881-26-lee.jones@linaro.org>
 <87imf0mvk7.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87imf0mvk7.fsf@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 06 Jul 2020, Eric W. Biederman wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > 'ret' hasn't  been checked since the driver's inception in 2009.
> 
> Minor quibble the inception was in 5c05917e7fe3 ("x86: usb debug port
> early console, v4") in July of 2008.

I'm only going back as far as the inception of ehci-dbgp.c.

> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>

Great, thanks.

> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/usb/early/ehci-dbgp.c: In function ‘early_dbgp_write’:
> >  drivers/usb/early/ehci-dbgp.c:915:13: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> >  915 | int chunk, ret;
> >  | ^~~
> >
> > Cc: Sumit Garg <sumit.garg@linaro.org>
> > Cc: Daniel Thompson <daniel.thompson@linaro.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Petr Mladek <pmladek@suse.com>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Yinghai Lu <yhlu.kernel@gmail.com>
> > Cc: Jason Wessel <jason.wessel@windriver.com>
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/usb/early/ehci-dbgp.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
