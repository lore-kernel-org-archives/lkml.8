Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC49C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070DA2078E
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 13:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vOte31zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726404AbgFMNml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgFMNmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 09:42:40 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103F0C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:42:39 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id t7so5471569pgt.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 06:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lhjeK9z5v60R6YHO++XPi5NmF7IKqnjXEf4qitMfo/U=;
        b=vOte31zJljugGB1gDdmNCw1Zmf5029uSmTy/iOUH69zfFgblQ5Cpr8W2OmXyDfOKDM
         EHBL0q71Lv6HTpbATGzgAFlEvdM9phMRFou3BnKj50gGjlW1OjyyQ9zvZAbp6Oab31Sf
         BjyPV9h4JNt8Dp6cgMHpvcAwoJAti2LLdnxul2rfod+QSWImXywd8dMoptSqi3Wec43f
         YSkym2V5cgO4zf4uxlvZc0Fcg+k4A3IFZv8SCem0uBbzYydRpf0dO3jwVXeJaPQj5Rs9
         vr+jDX45iCsiTN+XMTsEyQLZ28Bwhely3o8e5oo+2Vhkxtoo+Jk6CcL7ucLEpdjp8Hyq
         UIEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lhjeK9z5v60R6YHO++XPi5NmF7IKqnjXEf4qitMfo/U=;
        b=YYxVFvaIkeGrb1YryeHj0FgITANl/PLZYPpR2E9eQrYoeh1D+80qbi5kU/HUt0Ram3
         JBpVaeXnOeAZeXxN2JXewJ5x6GVTzp9j/p84kdJFGzy27HWj933b6noNrW0fSQAs6b6E
         FYb9fClwDDZmXFKtU3BneUmzj4HJtikxggHvzI72ywXDCOlul+PIzvrulCMho7aqek8J
         8dRhVcV206ej4AQOSpOoz5b2elii+Nt6Xl0TVJsdoo7uKF1u+X1PKSrxT7o5GzBe3Pep
         dJHjn89l2Eup2h1t9QTqbn9W3KiU2XtU3MT55jnRk7KyFM7g62fNft3Tl1SJbkEJQ49a
         SrTg==
X-Gm-Message-State: AOAM531rbunFawVC6X3+MJyuniNDtH5eLZDcQzEhPfmZIej4jGUSNBHm
        syxhkrDPFUPAkyfnaEXdyAQ=
X-Google-Smtp-Source: ABdhPJzB3giL0j3yf3vrpr2UTvpNzC2SsGkvwZhajh/25WwJXbCFV6r7O1I2rhMantYF3ZouqjyX3w==
X-Received: by 2002:a63:4d53:: with SMTP id n19mr12875818pgl.60.1592055758583;
        Sat, 13 Jun 2020 06:42:38 -0700 (PDT)
Received: from localhost ([49.207.210.132])
        by smtp.gmail.com with ESMTPSA id u17sm8050602pgo.90.2020.06.13.06.42.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Jun 2020 06:42:37 -0700 (PDT)
Date:   Sat, 13 Jun 2020 19:12:36 +0530
From:   afzal mohammed <afzal.mohd.ma@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Message-ID: <20200613134236.GA4086@afzalpc>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc>
 <20200613125126.GE23230@ZenIV.linux.org.uk>
 <20200613125615.GF23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613125615.GF23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jun 13, 2020 at 01:56:15PM +0100, Al Viro wrote:

> Incidentally, what about get_user()/put_user()?  _That_ is where it's
> going to really hurt...

All other uaccess routines are also planned to be added, posting only
copy_{from,to}_user() was to get early feedback (mentioned in the
cover letter)

Regards
afzal
