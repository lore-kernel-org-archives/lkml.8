Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED82C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83F7E22B42
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 19:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hRQTBt28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgGaTiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 15:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729325AbgGaTiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 15:38:20 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DE3C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 12:38:19 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id v13so11066588oiv.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cp3GygB7F0b136lUhJrRkyNW4lR2kBcOJ00svd2oGS0=;
        b=hRQTBt285hvDUY6CCaz910g2/xt+HvaTmkAFVvlGGkdmkHiPE1mWrZ6J9b98CS3oFF
         4rerhbQBqnGLLScHR+8hvSGAJGGP7HVCGfBf5URhTql94iKw/HXcIx853Ij74GkbeYQu
         z72JXvTJ0rU8caEPLxCkBL4MRokdEX1NcN2rLbiWAK6JWMBWavJM9B38gI1PeAnyws1H
         gt651BF1uJrsSvrDpQlZU+1dw83n7w3F0xuRWk1v5cWG4C7mhK2LPwtt5jkz94BhBR3d
         L5Rbx5xMULzWXTOBpbK36qGb/u4/6bb7abBJrfUfRNub9BusEMQLIXoFn0BNqa57XgUE
         OCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cp3GygB7F0b136lUhJrRkyNW4lR2kBcOJ00svd2oGS0=;
        b=KKKTNtXRZS9gM1eW9J5ervG6Wj5FpqCWse/mZ0OfL2ka7/b6JzvWgkh0y6FkU2KCzg
         R6r4OfqhYYeKGykcUW2Q7mYqId57ZrfpKLg+Fc+Z26hab2IfFK8V5sY33qOWjKkTjz61
         6tc25VfvG7I+6RaVsHA4q2Pfjzl5ntDkbVAthxxiNd8kWYCoBpPedIAgPvovSsCnG+Eh
         Evglz/nFN8d77WEUBZPcXUCFSKon9hOhkjt6/qMrWeaA+qClhkwqVNyCtd87bMKVcsm0
         CUnExmq8yv9bqPXJv7ctlmUcV+t4XtPqJDx1k79qLLm2lQa5LCL8IO1OXrQ7EvgUG5SZ
         MSTg==
X-Gm-Message-State: AOAM533BMg0KHv0BajCU4sJPfTaP148RT0FdLor9gdUFTHlJBI91IPq0
        t3CA7TZXP4sf5yKh5HRVD/UHB9xUAB4wrt/xeFdoBQ==
X-Google-Smtp-Source: ABdhPJxRdmWM2JVXS+XJYjkXLwgmye2vV//B6mH9jWnOac/U12I6qldoTC6vypuWGHyySsNeb29bO+jhRX9xVpW97f0=
X-Received: by 2002:aca:b5c3:: with SMTP id e186mr4344099oif.10.1596224299067;
 Fri, 31 Jul 2020 12:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <1594948208-4739-1-git-send-email-hayashi.kunihiko@socionext.com>
 <CALAqxLXuJQOCXcpyWwyBFZGFK_dEgG0edEEf2=vOpAw6Ng8mBQ@mail.gmail.com> <eacfc713-e98a-78fa-b316-3943600813d0@socionext.com>
In-Reply-To: <eacfc713-e98a-78fa-b316-3943600813d0@socionext.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 31 Jul 2020 12:38:07 -0700
Message-ID: <CALAqxLVzUnc5CH_pA7h3ygXFPRz05KtNZx+_M3eAXXrm7hhGBQ@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: heaps: Introduce dma_heap_add_cma() for
 non-default CMA heap
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        Christian Koenig <christian.koenig@amd.com>,
        linux-media@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 2:32 AM Kunihiko Hayashi
<hayashi.kunihiko@socionext.com> wrote:
> On 2020/07/29 4:17, John Stultz wrote:
> > Do you have a upstream driver that you plan to make use this new call?
>
> Unfortunately I don't have an upstream driver using this call.
>
> This call is called from dma-buf heaps "importer" or "customer",
> and I only made an example (do nothing) importer driver
> to test the call.
>
> > We want to have in-tree users of code added.
>
> I think this is a generic way to use non-default CMA heaps, however,
> we need in-tree "importer" drivers to want to use non-default CMA heaps.
> I don't find it from now.
>

Yea, I and again, I do agree this is functionality that will be
needed. But we'll need to wait for a user (camera driver, etc which
would utilize the reserved cma region) before we can merge it
upstream. :(  Do let me know if you have an out of tree driver that
would make use of it, and we can see what can be done to help upstream
things.

thanks
-john
