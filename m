Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774D6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:08:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55EE92088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 08:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vSYtPY90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbgE1IIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgE1IIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 04:08:31 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C098BC08C5C3
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:08:29 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id n123so2516730ybf.11
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 01:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sgr4FWL5XcxGztFSaEzO/2WTVUopl2JavBDY6LgOg2c=;
        b=vSYtPY90mTL/I0S2v5moz9urniRI1jiWbplaYPKse/12CdTp7n9h/BAactoqWym/R2
         TAR/suxU51W2PpSq3nzn1NwmiUS52W81E6jvYS5g7NHqV7D/DB5mimpPgyN7AQR7AXE4
         NTgHcDfMfBOq8hggnjVP6x1CMFUPQ+vKo5JU1BkVCDMG4TqpYfjZxUwJpb2F3soXZp4N
         F70gHvzSE7Q5XpQeRIDU2IeCnsCh9PvSsr2dkP4vB9/JFuVnk2HyGBPMx6Kk6025kalj
         0OGlxjG9yTCk4b7qZIcaypK+/C0W4VRNxgI7zY/F+O7P8zL2gZQWtK+KtHUE/AdJAeCC
         x8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sgr4FWL5XcxGztFSaEzO/2WTVUopl2JavBDY6LgOg2c=;
        b=CW/o/NCLyJdPhoLgggsM7hNeDF5wLmaM+U3vMhPKcPxf/GM6SDuEGxPFbYUgFn/nku
         CIz54QChB7PYZNeUfBOqj8PVGxIFgFv/dOUq1q4KWVMZcHTe0BL20DHewV66bhHzbfjz
         TdtbalJpnbmnRek84aPJVj32tDymIvHSAhkQP5eIxr/ITorvE73wqlvgcE14aP/1pyRr
         /TfyMfpX6Ia2Wao7MHEDPwlqTtkPAUGboV3Aq1vFLs61XZwsh+Nirv1uBaBSFVj44wHu
         MiAeZt1jk0sH4QlW6wGh0j1A4L53eyj3ibyFk83vRZZ5CHVVoEewTjoeKp6/8J4+ySmz
         diig==
X-Gm-Message-State: AOAM531XRRAYGzHO87/FGgFvCXHcDam1cPPpI0EVj3POLHb8+Hqkzdga
        90tmqhiz5Anm422BA5/TayL5WsRSy0+F2iG51tgQiw==
X-Google-Smtp-Source: ABdhPJzEIkU4sEoMsH6HbMA0rKdN14Pnda9RFsx12btvyCWWyy9/uQxg3/VavyE9M24Lx8vJHM15P22rZn3xUwzdfFw=
X-Received: by 2002:a25:8202:: with SMTP id q2mr3238918ybk.243.1590653308906;
 Thu, 28 May 2020 01:08:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com>
 <20200522200346.GB150221@linux.intel.com> <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
 <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
In-Reply-To: <81c59da1dc2a255c58e7e338f30285e68b4664d6.camel@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Thu, 28 May 2020 11:08:18 +0300
Message-ID: <CAD8XO3a5Xqw3oDAn=VH25Fb0j-_GSripEgQjwurhqGQRW_mq5g@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
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

On Wed, 27 May 2020 at 22:42, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Mon, 2020-05-25 at 09:50 +0300, Maxim Uvarov wrote:
> > Jakko,
> > tee-supplicant application provides state machine over callbacks with
> > RPC messages.
> > https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
> > It also allocates shm. Without running tee-supplicant
> > tee_client_open_session() will fail.
> > optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
> > Optee team wanted to remove some dependencies from tee-supplicant with
> > moving code
> > to the kernel. But for now I think that should be out of the scope of
> > current patches due to
> > they fix driver initialization on tee bus without breaking current
> > functionality.
>
> So what is the role in high-level for tee-supplicant? Why does it
> exist? No time to dive into code unfortunately.
>

Original implementation for tee-supplicant does several things:
1. allocate shm
2. load ta from user space (fs file)
3. emulate rpmb
4. also there are some ftrace and socket functions which I did not use.

As I I understand, current implementation uses tee-supplicant and it's
library as
API from user land to Trusted OS.

Some docs can be found here:
https://optee.readthedocs.io/en/latest/architecture/index.html



> These kernel commits do not explain in simple terms enough how all
> of these entities connect with each other, if you don't have that
> understanding beforehand.
>

Yes, that is true. But I think it's something new and good docs will
be some time later.

> /Jarkko
>

Regards,
Maxim.
