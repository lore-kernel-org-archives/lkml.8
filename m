Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8724CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:23:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BC320663
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 21:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591997009;
	bh=GWbucJlHAKAuWyG/jAfjMXZVJTNUvUMWRMBjIDkwRHc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qoJbd2ZHgLUdllWSO1eWuaGZBwRDHBYyINo/R6+1jSi9xjr6TDztlZPBNd3FuzMcb
	 JFUIxjjCnggw1wcwMcbBEJrnwEGPvPY+N1s0jOPbkuxtuUAGhESKh3Fria3ArzV6bz
	 qcmyPCTWXrvqeImq2+jmQDvbhKtF5neMjn8HIDxc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgFLVX1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 17:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLVX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 17:23:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB4CC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:23:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so8129418ljg.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DneVe3TvWGEFvY6ffxpfkbEvILOh996RTrpL4zTe4ME=;
        b=CpTHsPKeHgGX6LiwbKToRuV9OL2n9dMtvwuGysyrQpMMf72lp5zL0WSu9rHSerWf2N
         zG9LyevjHKt99IxDAnQTFaj//Gu06xM++Y4DnEEjALpphE1egQt/xUuLx69pcxqlqjGM
         Ba0+PsCCetnKw1M1i5D11aI6ya1VSI3UeGMu0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DneVe3TvWGEFvY6ffxpfkbEvILOh996RTrpL4zTe4ME=;
        b=QtJ3MKLeI58ExIzs5/ufwyibKNGvJEBytYu3uXavnh3SC6+cUCSuEEQqnV1YyOmixX
         pveeu1wWQBmCii0h/B8Ze75xbvVHqkmBvBWwk82fa7/kY0Yl/1CvKmVmOrHt142VqhFZ
         IObeD+BdpNx+geZZZk4tvAa+Ea9vZjjJ2rh+6xyO7wOd/aX4q2zkVGeXfcoMIDMZZIG7
         TMQpUB5+hWUnjJ75PXXfQhAzKE2UuxlFwLSqqt7uj0uKebTTG8Xyd/tn5mDVSaVbnuok
         NvcZOTEHfeQjI8SUvjhkKMPch/4pdFLwgYdLGwvnxoPI0Nhs6urZHtNytjGz4BTdc2L9
         +t/g==
X-Gm-Message-State: AOAM530/W0ia4Eox5mF8zOMnYfknsRtJweJ9WJKJoJ8qWe0T2oMLskWB
        zeR/X24b83gpqSVqpBzSEnMMzdBSqOw=
X-Google-Smtp-Source: ABdhPJx4eZWLoBx3bA8PZPhxeWnyoQR0L6rf70aXNq/8TdW1Jgg5wl5d8v+AtSGmX/VPrg7vtVccVg==
X-Received: by 2002:a2e:7219:: with SMTP id n25mr7281359ljc.168.1591997002939;
        Fri, 12 Jun 2020 14:23:22 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id f16sm2321020lfa.10.2020.06.12.14.23.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2020 14:23:21 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id e4so12699978ljn.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 14:23:21 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr7212084ljn.70.1591997000694;
 Fri, 12 Jun 2020 14:23:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
In-Reply-To: <CAJ-EccOy4qDpbfrP5=KH40LSOx1F4-ciY2=hFv_c+goUHLJ6PQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jun 2020 14:23:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
Message-ID: <CAHk-=wiLXXR1+o4VAuw5MM3V1D8h6C6te3y8VMvW8iAJw6noJg@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID LSM changes for v5.8
To:     Micah Morton <mortonm@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Finally emptied my normal pull request queue and starting to look at
things I wanted to look at more closely..

On Tue, Jun 9, 2020 at 11:26 AM Micah Morton <mortonm@chromium.org> wrote:
>
> This patch was sent to the security mailing list and there were no objections.

That patch as committed has both the wrong authorship, and the wrong
sign-off chain.

Not pulling.

                 Linus
