Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E0BC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C7DD20736
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fwtUFfM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730123AbgDWR7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729991AbgDWR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:59:21 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6AC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:59:20 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so7513497wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 10:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=+3v2CXZ31rJC/XGZqxQoIxPYicngYI/XpXBi168YDUA=;
        b=fwtUFfM1OdfdnPO/OYfjhurTSKSzL3DXgAb8iY48jtF8A9NVVj/4h1b8ZnWDl5Q6Ly
         dLakkA+6/matqGWMo2igyZjLLrLaSNBfM8l+MuY1PYqir4c49wiVymlpujD02aPH+AHH
         mjumaFTpmW4Nc9l5fbuAKgZh8EQnYKRgvww1LKIAecbF9uKP0Fc3brjsb1MznGrxUX35
         hhIivcjttP2ctHYfoIMNJuJ8cUc/Z5W5o6hiGRSt9f18uKP9kTHlKl73Ikq/2gs7J3er
         tLKUI1Ct8g+v7Rwe//6P2rZ8nGUKd2grxo5b4XgFdzCm977HL1lpuX8a+dal+Z0DocON
         tJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+3v2CXZ31rJC/XGZqxQoIxPYicngYI/XpXBi168YDUA=;
        b=BxAQJqjCoyPGNLxuvSdKaliGeiAUnPJDs2qb1pRHhevY3jv3jDc1naVDIoAHILudY6
         Wz4scT8xMnVa8gxCkW09klW69XDzrZZ3K9Y7duknAofAYb8foQ9FcZJWy4xCNwlrv78n
         qUi4vlFQxkgwfG962Kdr4SkTcBQ/dTUb8TTl4K3Eh0D6oWrYQgWJNJDWukNkpoG8rrvh
         BIi38DgBRC+h4HBvOIoOPbFMPf43/YyicI4Ga1j7w5MB25c5gkYxW278tulaaPyLDiFb
         DmmWYzD20yonpcfXxzYVpkc8USRN08StRcYjuaJAkEYMaexlW9Nt4yajUGomVJRECr/X
         5u4w==
X-Gm-Message-State: AGi0PuZg7xpv/3JHN28pG7gMBJkrrFh9xeFyKMAuNmzi9lAngccgsjeV
        RYaPdgtWrMqfRWsA6+HuRbkXXkLL
X-Google-Smtp-Source: APiQypKjfwrSd102BKVGRxcvF2W6xfSgdPV00Pw8kRR2NGkhTtLDYe2lK0xYtIkDMDY7a3K7IdN5sg==
X-Received: by 2002:a1c:750a:: with SMTP id o10mr5317263wmc.161.1587664759616;
        Thu, 23 Apr 2020 10:59:19 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id x23sm4473539wmj.6.2020.04.23.10.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 10:59:19 -0700 (PDT)
Message-ID: <32dbb39debedabd6dbd1a8675760e171c180de9e.camel@gmail.com>
Subject: Re: [PATCH] Changes in w1_therm.c and adding w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, Greg KH <greg@kroah.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Thu, 23 Apr 2020 19:59:18 +0200
In-Reply-To: <307231587661588@mail.yandex.ru>
References: <20200414170248.299534-1-akira215corp@gmail.com>
         <20200423144116.GA7319@kroah.com> <307231587661588@mail.yandex.ru>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 23 avril 2020 à 20:07 +0300, Evgeniy Polyakov a écrit :
> Hi
> 
> 23.04.2020, 17:41, "Greg KH" <greg@kroah.com>:
> > You do not document any of these new sysfs files, why not?
> 
> Looks like there are bigger isues with the patch that I've missed,
> and if I understood correctly, Akira asked to drop this patch
Hi,


Evgeniy, I don't asked to drop this patch, sorry for the
misunderstanding. I will add entries to Documentation/ABI/testing/ by
the end of the week and submit a new patch. Who should I add in the
'Contact' field ?

To answer Greg's comments, we use the kernel subsystems as much as
possible, but for timing and bus protocol reasons, we have to go a
little deeper and control bus transaction as close as possible.

Evgeniy, could you detail the issues you are talking about so I can
adjust if required ?

Thanks again for you time, regards

Akira Shimahara 

