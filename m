Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2085AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:06:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F235C217D8
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 10:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="skKTE+Cp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgGNKGJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 06:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgGNKGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 06:06:08 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541C1C061755;
        Tue, 14 Jul 2020 03:06:08 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id p1so6826168pls.4;
        Tue, 14 Jul 2020 03:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eYpCQfk/q2dXlOvqggXDmkrAf68vEnrgzdjskwoJL6M=;
        b=skKTE+CpIsdKXt3/0nlblro53GUANKxqNtTyG/+IjykwtXnPLWN2ztxla7THEHgzH7
         uGA61QgHlK6eFYdNEtt05P9FNTsqwXikvAR1Ha+CP/QySTYvzeYrAnHwE5yjRheYfkO/
         3BEh2FAMbrPvrpuECImvgbgZ1V5H1FpUGVxoZp2KucYUsnHYB4PLIulj4r4ENMZDvtJ8
         vV7uzdGS0DQcmvh9J7T0xybMq5uPoaoQP0Vevf+QkaRjV8Ou3Qz+9/sRjvMOuUjhtCGw
         0Qnud8/LutL7ucYLB4wlJBDecFp7+rv6x36+NC858rm/VBy1Rp3nADTExX47SdkXqxZJ
         hCVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eYpCQfk/q2dXlOvqggXDmkrAf68vEnrgzdjskwoJL6M=;
        b=NNoc0RBC3JBd8GR3LqFsl7/BmCwYGQJvNgBlQk2HDzopnL3b6/bcN/bba/jZCe0XmX
         8K6iM7+DDC2QA3vSZb+bI9LXJE+FFouhWKdt0JTE9hUb5GJysxjhKSNZwSaiSl5+LnMD
         SQ9jAg6gGXFz9EcxbYToih7M90OfYNIELWkw0DcLqwLjpR0zKd7i900UBKOstDcMakjf
         dekyKrW9NKJQ0h5/oIxv5WnKYWfRRb32YYG/TLydNSvZYtIiILCBRZIjp7Ut6vYd0AuU
         +AAJ55Qj9dlGgKcCRX7USAZmmxW5sV8JI79R6ETHralCSw0S2CNtkOZ5BjDcJsg7MSch
         LRPg==
X-Gm-Message-State: AOAM530zoQ573+u/WxR+0T1rWmUDfSje488ynPwlC99JVgtsHX0lsIJ7
        qmKvoJIwrHIpFAuj2fL752c=
X-Google-Smtp-Source: ABdhPJztQv0rhQk5gYPwf/IdL9QA4paHfVHV8Ckv+UiFjvEVBFFyA/8krZQ1RQWQcTOCzHtMwAZ6UA==
X-Received: by 2002:a17:90a:ea0f:: with SMTP id w15mr3999097pjy.138.1594721167865;
        Tue, 14 Jul 2020 03:06:07 -0700 (PDT)
Received: from localhost (g175.219-103-161.ppp.wakwak.ne.jp. [219.103.161.175])
        by smtp.gmail.com with ESMTPSA id l9sm2084386pjy.2.2020.07.14.03.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 03:05:55 -0700 (PDT)
Date:   Tue, 14 Jul 2020 19:05:45 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] OPENRISC ARCHITECTURE: Replace HTTP links with HTTPS ones
Message-ID: <20200714100545.GD437393@lianli.shorne-pla.net>
References: <20200710062019.28755-1-grandmaster@al2klimov.de>
 <20200713113430.1c1777bb@lwn.net>
 <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXoUME_dCOZP1N0tXyMv61edfNECM4-n4NPa56YbBCncw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 09:22:39AM +0200, Geert Uytterhoeven wrote:
> On Mon, Jul 13, 2020 at 7:37 PM Jonathan Corbet <corbet@lwn.net> wrote:
> > On Fri, 10 Jul 2020 08:20:19 +0200
> > "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> > >  Documentation/openrisc/openrisc_port.rst | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/openrisc/openrisc_port.rst b/Documentation/openrisc/openrisc_port.rst
> > > index 4b2c437942a0..657ac4af7be6 100644
> > > --- a/Documentation/openrisc/openrisc_port.rst
> > > +++ b/Documentation/openrisc/openrisc_port.rst
> > > @@ -8,7 +8,7 @@ target architecture, specifically, is the 32-bit OpenRISC 1000 family (or1k).
> > >  For information about OpenRISC processors and ongoing development:
> > >
> > >       =======         =============================
> > > -     website         http://openrisc.io
> > > +     website         https://openrisc.io
> > >       email           openrisc@lists.librecores.org
> > >       =======         =============================
> >
> > Applied, thanks.
> 
> Is that site accessible for anyone? It times out for me.
> 

It should be,  It was working a few days ago when I updated it last.  Perhaps
there is an issue caused by the github outage yesterday.  I will look into it.

-Stafford
