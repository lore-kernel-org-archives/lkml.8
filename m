Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0570420A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 13:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZiAh19re"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbgFPNCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 09:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgFPNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:02:44 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C94EC061755
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:02:43 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id d4so1443856otk.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NzTqWXpX+jIvy6nNJlsuFOKnjF4HL8dCMVxHFmjhNpc=;
        b=ZiAh19reRpuQMNnULfDrvDsIF/sHi3PNBI2av/6tLQoIpHlpsGZyVyf5/f9zfAkXsT
         RvqRMv27tjZWKFR9Snu8Rk1bKEaoZyL/3MRnmiJD2SYG7VpqMcAfTK6UqN88hIEJj+VT
         ZZoCkxccGShzokCjF5GTZ+PUN11Lr1oNW1HT862bUqaAOlMVCxgyKCPIV1P3uEkrqLi1
         kxFv1PNr65IJYwIvN8H7k/8AJzUyeVk39JEE9mCjY/8kT+oymEOkTRGIvQYJsIyQkvwl
         VTRqUzdDBZjs9D9mgj+yTLxxaJOBRalDP+g3Ki0j/9PsO5oPKeJHujNesCv6z51OEUI/
         s7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NzTqWXpX+jIvy6nNJlsuFOKnjF4HL8dCMVxHFmjhNpc=;
        b=lc7pU2neC6wVhNxuAYtlyJ0YXxdTnu0voHYMboj65cxn41KptblMm2TmUK4mC/xml9
         ItWntJHhoOzCwB5GPaA4PKA2+FH/oDJGID5zZ8UfJrL7N/cFAR48KcBjMuUEua2Np/qK
         nVKRFre96ZgCCHqbEiKXgPLrsxyp5u3ISNSrLWnMtNQ9ByfdhrffqTY2ki2Auv8AW5Hs
         eC/y9eZqTHMyRq5TDMP3zYn4ERI4mLCB6P8okvJGxPwD5mhGlS3HqKtLtMQujBTE4I+b
         G1tHCmy+/yweYRdbyj8w0O6xYr3qy3hFR3/dYTuUU6eX4s7uN7XSiCbkudLoDp8xRLHK
         o+Pw==
X-Gm-Message-State: AOAM5304PhthogV2KcT2Rao5MF47a7cV1UMXvQFnYgvgy15Bx9i0s04E
        BUjGcBznPnWsMEN4GfU8Sl0aL8ya2OT8wLfNOgPIow==
X-Google-Smtp-Source: ABdhPJxsO1eVEcTPZvlTMUrXhz7ujf5MbjRiGA+lB51S5epUV5ph0XXmivVwvq7RJRM5fxua8F5YwdkG3RxhSDPGT/s=
X-Received: by 2002:a05:6830:242e:: with SMTP id k14mr2249753ots.36.1592312562394;
 Tue, 16 Jun 2020 06:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200611114418.19852-1-sumit.semwal@linaro.org>
 <CAO_48GFVYOv8Km7fEh8iBPp7d5ziySBV0vB9nu_+oset6hBO8w@mail.gmail.com> <159231181752.18853.1290700688849491922@build.alporthouse.com>
In-Reply-To: <159231181752.18853.1290700688849491922@build.alporthouse.com>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 16 Jun 2020 18:32:31 +0530
Message-ID: <CAO_48GE8K_nDXs_LDU9caRdP-aK9DWV3vXcD4EuVCxyShCBbmg@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf: Move dma_buf_release() from fops to dentry_ops
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chenbo Feng <fengc@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linaro MM SIG <linaro-mm-sig@lists.linaro.org>,
        Charan Teja Reddy <charante@codeaurora.org>,
        syzbot+3643a18836bce555bff6@syzkaller.appspotmail.com,
        "# 3.4.x" <stable@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, 16 Jun 2020 at 18:20, Chris Wilson <chris@chris-wilson.co.uk> wrote:
>
> Quoting Sumit Semwal (2020-06-16 13:42:13)
> > Hello,
> >
> > If there are no objections to this, I will plan to merge it soon.
>
> I was going to suggest running it against our CI, but that's unavailable
> at the moment.
>
> There's a particularly nasty BUG_ON() in dma_buf_release that we hit
> irregularly, that this might help with.
Thanks for your reply; if the CI is going to be available in a couple
of days, we could wait - it'd be definitely good to see a bug being
splattered out!

> -Chris

Best,
Sumit.
