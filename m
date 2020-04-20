Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B7C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:52:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E27A206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 13:52:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nsbDnE56"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgDTNwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 09:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728013AbgDTNw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 09:52:29 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A98C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:52:29 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id k9so8773530oia.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 06:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BQUgbiyZb+jYVEi0SfDLJ2/mIN7+gST/mtLReyFlCSA=;
        b=nsbDnE56mnEJVgaGdrD0DXRmBn3Pm8c3aGT+FDy23L6wLjnSLVSIz6hAoNu1qM5/gX
         L+AFbEss+yOs5l7+2RnX1cBT4oa+hFfo8eCr6GMs6WY+gneaArGDdOzUrO8Mjaf5d1qj
         BSOiyWaoa+yqN5oKDGRLbRSKCc7ntOf464elO2pfXu+9RiNOzqeWTbZ7SCv6FKynzrsL
         rSMuOH5Elogkj8MSPblHvaXGU6k16D6FOnCnijh8lWXr1T/JRiVbiYVgmGeqeAwsrMSB
         GHsalLsfHBezM6NBfGVXdoLGhlTgllMEhD2DL4ekPb9zBY2kc6lP3IvKPFhaZSj/+tZv
         eFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BQUgbiyZb+jYVEi0SfDLJ2/mIN7+gST/mtLReyFlCSA=;
        b=JbfGaPdJG5Ez3Jt9A+a6OZbnPDJZ60yvzCivAX7cf2HQmg4XpJE9fB8mi7Xxqza5e2
         BkfVgDICj1tA7BxLlrazhR1dQkCmsVEz1T+bSn/GWXyZ6fVv/eZNQOqTNOq80cDSvLuZ
         8aeVilHvPV7ZkUSpugmbytKv9r1jA3qBclvrZtn5Cqa7WH9fS40IMx9k3VkrBTvwjAwW
         UVTFPyAVUxbnt2VivLCR3+cvlfA5qNXcBy8pble8g8ImM8cNucRZKtiKkWlQb4n1qI+g
         5xeQCQr/fGJcktkUP5yxuYTDnWCA0kvTzDAUupoQXlGbgRtyOq+/U1LPN1GBEn0VCE31
         MuYA==
X-Gm-Message-State: AGi0PuajGuQTuPuwcV1AajnGbRqOiHcnUvpolphrD0E5cDnXWX0D1BON
        W96Mal1LiKpBUjB5PiPx4urWHsgrcITRbXzbB4Xmig==
X-Google-Smtp-Source: APiQypJGCg29rkWLWR5Nr55pighT0ZM7gIcGM52C97e5ZhoAJ6psZg8e0l7rCD72PjWqQt2iYSOKOJZSvTSzN6yp+7s=
X-Received: by 2002:a54:4398:: with SMTP id u24mr10852970oiv.5.1587390748665;
 Mon, 20 Apr 2020 06:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org> <CAFA6WYOqB2BwrZhgm1=btEmPwxYVpKKFAgOE2mYOUrUykgmiLw@mail.gmail.com>
In-Reply-To: <CAFA6WYOqB2BwrZhgm1=btEmPwxYVpKKFAgOE2mYOUrUykgmiLw@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 20 Apr 2020 15:52:17 +0200
Message-ID: <CAHUa44GF1i6V_tNKqeYdcyxNmdBG=Zoir6Yx2UCMn5kkj1FimA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Enhance TEE kernel client interface
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jerome Forissier <jerome@forissier.org>,
        Stuart Yoder <stuart.yoder@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sumit,

On Fri, Apr 17, 2020 at 12:45 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> Hi Jens,
>
> On Fri, 27 Mar 2020 at 11:00, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Earlier this patch-set was part of TEE Trusted keys patch-set [1]. But
> > since these are completely independent enhancements for TEE kernel
> > client interface which can be merged separately while TEE Trusted keys
> > discussions are ongoing.
> >
> > Patch #1 enables support for registered kernel shared memory with TEE.
> >
> > Patch #2 enables support for private kernel login method required for
> > cases like trusted keys where we don't wan't user-space to directly
> > access TEE service.
> >
> > [1] https://lkml.org/lkml/2019/10/31/430
> >
> > Changes in v6:
> > - Reserve only half of GP implementation defined range for kernel space.
> >
> > Changes in v5:
> > - Misc. renaming of variables.
> >
> > Sumit Garg (2):
> >   tee: enable support to register kernel memory
> >   tee: add private login method for kernel clients
> >
>
> In case we don't have any further comments, would you like to pick up these?

Thanks for the reminder. I'm picking this up.

Jerome, it's not too late to provide a tag if you like.

Cheers,
Jens
