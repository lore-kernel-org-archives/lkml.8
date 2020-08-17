Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C656C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA9620578
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2fXnGI8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgHQIuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgHQIuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 04:50:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE98C06138A
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:50:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so14103704wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 01:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eQE7UF8DcCewmzSExxx8eeLn2OA5wnv+ShoIew846L0=;
        b=t2fXnGI8Eiq75t3Fr7pvFXGeaPB45TrrNEcEf2MQZrEzQlzGozv7kzn6K+2YbNFu8Q
         knbVVXOiR+rUUVo8ZguLLDgascNUPNw/DEuc31brqfInPvx0DpJEMOtcKHzuNVjzpLHT
         6Uby23FLuB+1E8oBo6am19Y5h4O5YWDDfdagNi1AIQtRWTlh5sdWjyBZX9y4Xw8In+qp
         oaVWN2rKf+15QA7nWU6+nnUtI9oqcNxN5OaqtKPwG5WJAQ05b8VaPHVfZmkTNIpM9Nl2
         HWghu2YMdmq0yhsYem1feZIY67Q3zQ/FWocs7vqG0Ffyaiwu5q3i/D5EKfqIrWeE5rUo
         hMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eQE7UF8DcCewmzSExxx8eeLn2OA5wnv+ShoIew846L0=;
        b=S4iCa1L+TJcjP+97tknJB1ZsEnCNgH52J/IF8b/7Rs6M14SFFWH6YCkoZvV0R6SlKx
         y9eAGClBTEgzGDd+yH169NtO7Wsd9PdhxKKi6xvoRW7yZT4EBbeXULCJgpf96xX+XnGA
         5u6QIov649vBm3gUQRb0Bd+VVbXU7jT1fFZEecUaRrcaLeN0nEBbUvMVszt2hQ8MPee5
         SaXG0DsJsKHKZ/ZmxCQ+AdfiHlUyxCDZTWXVEtHa49Onak20BO8qZeG6cpRzeTKYy7wX
         Xf459nuftcLMa0Qm/lzWQBwemcVxSION/heVPa9ZoEYqMFdNb3ZppwGn+mPpyL2ijz85
         22jQ==
X-Gm-Message-State: AOAM530FPlVkXq0ho9PeM9NIc9eh7umnbMERKlwsmTrgFXUDEUDicaEX
        uIEVCn+jffQLFA+qp0v4bFze2jbjZL6mlQ==
X-Google-Smtp-Source: ABdhPJzBHRCazJeaD7mDx5OHG3g9GCrXdWG7uSkk/PgwI614rp3oMJEXUmBMhVIDuZoNpllti0kOkg==
X-Received: by 2002:adf:f151:: with SMTP id y17mr15077238wro.179.1597654220812;
        Mon, 17 Aug 2020 01:50:20 -0700 (PDT)
Received: from dell ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id h10sm30102985wro.57.2020.08.17.01.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 01:50:20 -0700 (PDT)
Date:   Mon, 17 Aug 2020 09:50:18 +0100
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
Message-ID: <20200817085018.GT4354@dell>
References: <20200814113933.1903438-1-lee.jones@linaro.org>
 <20200814113933.1903438-8-lee.jones@linaro.org>
 <87v9hll0ro.fsf@codeaurora.org>
 <20200814164322.GP4354@dell>
 <87eeo9kulw.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eeo9kulw.fsf@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020, Kalle Valo wrote:

> Lee Jones <lee.jones@linaro.org> writes:
> 
> > On Fri, 14 Aug 2020, Kalle Valo wrote:
> >
> >> Lee Jones <lee.jones@linaro.org> writes:
> >> 
> >> > Fixes the following W=1 kernel build warning(s):
> >> >
> >> >  drivers/net/wireless/broadcom/b43/main.c: In function ‘b43_dummy_transmission’:
> >> >  drivers/net/wireless/broadcom/b43/main.c:785:3: warning: suggest
> >> > braces around empty body in an ‘if’ statement [-Wempty-body]
> >> >  drivers/net/wireless/broadcom/b43/main.c: In function ‘b43_do_interrupt_thread’:
> >> >  drivers/net/wireless/broadcom/b43/main.c:2017:3: warning: suggest
> >> > braces around empty body in an ‘if’ statement [-Wempty-body]
> >> >
> >> > Cc: Kalle Valo <kvalo@codeaurora.org>
> >> > Cc: "David S. Miller" <davem@davemloft.net>
> >> > Cc: Jakub Kicinski <kuba@kernel.org>
> >> > Cc: Martin Langer <martin-langer@gmx.de>
> >> > Cc: Stefano Brivio <stefano.brivio@polimi.it>
> >> > Cc: Michael Buesch <m@bues.ch>
> >> > Cc: van Dyk <kugelfang@gentoo.org>
> >> > Cc: Andreas Jaggi <andreas.jaggi@waterwave.ch>
> >> > Cc: Albert Herranz <albert_herranz@yahoo.es>
> >> > Cc: linux-wireless@vger.kernel.org
> >> > Cc: b43-dev@lists.infradead.org
> >> > Cc: netdev@vger.kernel.org
> >> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> >> > ---
> >> >  drivers/net/wireless/broadcom/b43/main.c | 6 ++++--
> >> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >> 
> >> Please don't copy the full directory structure to the title. I'll change
> >> the title to more simple version:
> >> 
> >> b43: add braces around empty statements
> >
> > This seems to go the other way.
> >
> > "net: wireless: b43" seems sensible.
> 
> Sorry, not understanding what you mean here.

So I agree that:

  "net: wireless: broadcom: b43: main"

... seems unnecessarily long and verbose.  However, IMHO:

  "b43:"

... is too short and not forthcoming enough.  Obviously this fine when
something like `git log -- net/wireless`, as you already know what the
patch pertains to, however when someone who is not in the know (like I
would be) does `git log` and sees a "b43:" patch, they would have no
idea which subsystem this patch is adapting.  Even:

  "wireless: b43:"

... would be worlds better.

A Git log which omitted all subsystem tags would be of limited use.

> >> I'll do similar changes to other wireless-drivers patches.
> >
> > Thanks.
> >
> > Does that mean it's been applied, or is this future tense?
> 
> It's not applied yet, there will be an automatic "applied" email once I
> have done that.

I see.  Thanks for the clarification.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
