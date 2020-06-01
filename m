Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D7AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:13:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B3AF2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 07:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gt23ufON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbgFAHNx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 03:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgFAHNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 03:13:52 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEDEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 00:13:52 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id t9so1736251ybk.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 00:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8G5e47VCYmMLxbmWX246QzIMcLb/13MX6jpSeHuhiU=;
        b=gt23ufON9rw6knQ9JjR60Z+pEcYeNMdcdhBfRfB/Z8e9uLGT/rq4lKnMVHsjhSnUxS
         ZTXUCEiDQTLjZ71uXOsiQP8Wg7YUxcEDc3JzHFxIWXPgg1624eNoORe/9C/9S66lTOzr
         8hr16cJkp/3C+3uwmR0JQfJWfwaLYC4GfLwM/YdwbeBv2EDUHfuNvykofn1+7OHhALxw
         mBVa07ry5ItbFl+sFceb5O0XU1sxfrDj9mn/vzcvCAbmuMrNs85VwQj9mmiIh6rAGASS
         koCW3Jc/fqFjNPFcShCzwCtguI23bapFEr8/PcIg+nOeLf5SoorIJaugMUCxjZ1Gxwz2
         tR1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8G5e47VCYmMLxbmWX246QzIMcLb/13MX6jpSeHuhiU=;
        b=TfOVlNjJtS9+DqO823DKwVvrIhkyMGJBK94YGPbIqWzAOINbcOOV0qqPIKBsWJndJW
         3hdCwuNXkqJuMGn1v2+iZKk04gteLQzBKz//R9zE3gx5aTdC3AgDCuQpXKKybv1N+3ob
         pdZiYMlsl7ef79jwDUkoNtdgx/0/XsuyphUwingVO6fm5tL4xh6bedole84MucCqkfkk
         kHuSvngfRYIcuwdPPq/sE6kRd4x7Wccb1dcTHiLrWE8XhyxEnl+GEcpC0W0FgcKSwzhL
         tJpNLOOUIBP8VOpN9Przsl47zY4Jl3EdVqDwhhKrDMvvSHG+bp5rqmssjCO6j5wSVgRI
         y3Hw==
X-Gm-Message-State: AOAM533+s/z6KwI9uSnbOImKKcFoWHjJoTf41O18oaaaf4YANXbig7/A
        Urg53KMPuv09uJB/1PSRebDoEOPLuTDwx4KpIcDy1w==
X-Google-Smtp-Source: ABdhPJwEeiKpzrV2PGUSDmSUhasZpzuc3dmkXCR9uBeolzJDc/0BPSj4eWeOChrgjoS8reCcu2DnUSYLtw+/k0wCt4Y=
X-Received: by 2002:a25:2447:: with SMTP id k68mr3486087ybk.69.1590995631736;
 Mon, 01 Jun 2020 00:13:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200529082701.13457-1-maxim.uvarov@linaro.org>
 <20200529082701.13457-2-maxim.uvarov@linaro.org> <20200601014901.GB794847@linux.intel.com>
In-Reply-To: <20200601014901.GB794847@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 1 Jun 2020 10:13:40 +0300
Message-ID: <CAD8XO3Ztoz8scEq9Rt_SMHCU6pSgf6NGSX+UNLQPy=0g56EXVw@mail.gmail.com>
Subject: Re: [PATCHv5 1/3] optee: do drivers initialization before and after
 tee-supplicant run
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jun 2020 at 04:49, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, May 29, 2020 at 11:26:59AM +0300, Maxim Uvarov wrote:
> > Some drivers (like ftpm) can operate only after tee-supplicant
> > runs because of tee-supplicant provides things like storage
> > services.  This patch splits probe of non tee-supplicant dependable
> > drivers to the early stage, and after tee-supplicant run probe other
> > drivers.
> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > Suggested-by: Sumit Garg <sumit.garg@linaro.org>
> > Suggested-by: Arnd Bergmann <arnd@linaro.org>
>
> $ scripts/get_maintainer.pl drivers/tee
> Jens Wiklander <jens.wiklander@linaro.org> (maintainer:TEE SUBSYSTEM)
> tee-dev@lists.linaro.org (open list:TEE SUBSYSTEM)
> linux-kernel@vger.kernel.org (open list)
>
> tee-dev is missing. Please resend.
>
> /Jarkko

tee-dev@ is in CC.
