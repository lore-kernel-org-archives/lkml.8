Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A326207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 16:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qHm26J+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbgHNQn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbgHNQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 12:43:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966DBC061386
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:43:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d190so7985948wmd.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bw1Tir57DBh//uKbJmgY59q5qNNSVFGXpIBJzyrS4Lw=;
        b=qHm26J+IwYUn5IJa2ysdzXpsHxc1KAt6rMFUFONUIDMIASRMSgivr98FjRGVhasvPQ
         WOuffJNjFYuiO6PKizYbOKXKKNTHX5MrodACxfE93iH8gBsWtSvbMOKl16t3ArUkHyLT
         mRKQgeWXiL1b0FE+8ST0nanOd9slb1k0HMgBryQWBktVC8lHcWezaXAyAZfE2ZRaph4Z
         LPRj51ijyosSxSA7AAO8QZGKG7/oJyUchYsshMvm96tI0sVntS5LDM9bhfKAwsK7gbCA
         CUa+Vw9/IPMPePnJKd6rzUbQSEXow1zb2E9HUKZrTSagHrfeUU2nhE2CiCP7CjLZ1GcI
         fasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bw1Tir57DBh//uKbJmgY59q5qNNSVFGXpIBJzyrS4Lw=;
        b=V1GaOZeC6XcuMXDlOWdA2iXW0pPkQxT/WvKugY7Vc7yQS+IlGmLF99HS9oktfeseO7
         q9QmhKFeuEiwunQ+0P0lCW42oc1C0ajRfRyWzKjNIEpqeMmVlkYjBQtyg4lT7ho+di1u
         ERrgW95VzJ2/HjsF1A78IXymveeN4T8hiGkkWuQgQFoYw6kW5Ra7ZOjS21G3WRSqLhMc
         rOcf/GwYG/Qek1I0Sy91Fv+J3qSyONUflRmkg+Plqp5oeLXpITWLEvMNaqMnIRouWjoO
         GrTZuqHnU5R5YrWni8s9D0ovu2muMJz5l6IEoaKMDKsiufShiE4MoSQBIMc7Bv7slI1Z
         r2lw==
X-Gm-Message-State: AOAM533YI4Rlz7qIUATq2mVlQCPIBApwje6D2VZsfKdoieA50pJnrIXM
        7xDoZK/FQlj+iMQkRQd81O/CuA==
X-Google-Smtp-Source: ABdhPJwmidNzTZJLo6FoNt59fQ9wCqrOkTh1OvEDHY3GA0jq3pvnnNCUEsTLO6WWNVnFhJIs0j0Vxw==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr3391788wmk.145.1597423405005;
        Fri, 14 Aug 2020 09:43:25 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id d11sm17098148wrw.77.2020.08.14.09.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 09:43:24 -0700 (PDT)
Date:   Fri, 14 Aug 2020 17:43:22 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        Martin Langer <martin-langer@gmx.de>,
        Stefano Brivio <stefano.brivio@polimi.it>,
        Michael Buesch <m@bues.ch>, van Dyk <kugelfang@gentoo.org>,
        Andreas Jaggi <andreas.jaggi@waterwave.ch>,
        Albert Herranz <albert_herranz@yahoo.es>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH 07/30] net: wireless: broadcom: b43: main: Add braces
 around empty statements
Message-ID: <20200814164322.GP4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-8-lee.jones@linaro.org>
 <87v9hll0ro.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v9hll0ro.fsf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/net/wireless/broadcom/b43/main.c: In function ‘b43_dummy_transmission’:
> >  drivers/net/wireless/broadcom/b43/main.c:785:3: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> >  drivers/net/wireless/broadcom/b43/main.c: In function ‘b43_do_interrupt_thread’:
> >  drivers/net/wireless/broadcom/b43/main.c:2017:3: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
> >
> > Cc: Kalle Valo <kvalo@codeaurora.org>
> > Cc: "David S. Miller" <davem@davemloft.net>
> > Cc: Jakub Kicinski <kuba@kernel.org>
> > Cc: Martin Langer <martin-langer@gmx.de>
> > Cc: Stefano Brivio <stefano.brivio@polimi.it>
> > Cc: Michael Buesch <m@bues.ch>
> > Cc: van Dyk <kugelfang@gentoo.org>
> > Cc: Andreas Jaggi <andreas.jaggi@waterwave.ch>
> > Cc: Albert Herranz <albert_herranz@yahoo.es>
> > Cc: linux-wireless@vger.kernel.org
> > Cc: b43-dev@lists.infradead.org
> > Cc: netdev@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/net/wireless/broadcom/b43/main.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> Please don't copy the full directory structure to the title. I'll change
> the title to more simple version:
> 
> b43: add braces around empty statements

This seems to go the other way.

"net: wireless: b43" seems sensible.

> I'll do similar changes to other wireless-drivers patches.

Thanks.

Does that mean it's been applied, or is this future tense?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
