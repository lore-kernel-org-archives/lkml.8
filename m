Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A72D8206B6
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wOotrqX2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388940AbgEYGvA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388487AbgEYGu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:50:59 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F87C05BD43
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:50:58 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id s21so2189980ybe.5
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 23:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NLMRtJrXxF/KIRzWVXOQPJWRHqdMyNwc6DMD7m4ZeeQ=;
        b=wOotrqX2ldR8fNeNoc1dIZNlAxcy18iSOAwS6u2D9eXMPH37ZAuhxXV2tTOg5IFD4Q
         qwuJamEkdNglQRvP3aSxwpCQTgTtrua0T59Sd+eAKqooq0VD2DAQuQVA6Ty4osplIkMA
         FtXb1sIUrxczDyWkP04izFLZtDouDF2K/V5xuRpF7p9GsiZXPLzvDRQR8lBTCJrgAam4
         Zojqid9RoiGr3iVMLBghA6fGKqHc/YF2Kys4IHLNMVmxM9HJuDruSO702XgvAtiLxrZG
         ullbczLDSH3cgnxrHjcp93f64zeAZpXnlXAVbWARUSF/UowJ2wbZ3HpuluuQ5RVOy+X+
         UZtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NLMRtJrXxF/KIRzWVXOQPJWRHqdMyNwc6DMD7m4ZeeQ=;
        b=Ax62gSEt/g6htTXqaZYp7623A4Gzkbzetn2ZCavWmt6xCxomw/8BZc8oWPxDgGRQZd
         TYhHkisat4Sd/EeUhhuGEp7hvAxI2GF9uqNALS1CCsg3xd/BlnkXW4LmwV+6si9yCqi9
         N0ybH8M/IXlrKs6bGoqbivEarpjlPLYEdBy8ZMwtxn+H4pIrLps69+kkR9nDZ6y9QpSN
         KDRsnBcQafvDKubkgeunSedrXyyM9wR3oBSgCcRe5PVuCON/uK0wG6X62GQs+BvkJdyP
         PMUvT43yl63jg+WSKgfa1qeUPplmVOePffaoCJKCwM2euoH6vatk0+79efIVM30IvGZd
         cHhA==
X-Gm-Message-State: AOAM533Evb87pgG2iKp+By6nn1pFVXgWsbPvh2pKPP+Bw/X3HoUjZcH9
        B+rGvfs1ORQuxvJ1YHQ4cYmdcy7ODdUyTtbYGCtlTg==
X-Google-Smtp-Source: ABdhPJziehBSD54NDEg4MSbVVy3e03fQg4Toq3RQagDdfqXUV6sEi4K6OcxRE+R0+V7W4gOsR2y9ZTeCLDEntZFpMaA=
X-Received: by 2002:a25:209:: with SMTP id 9mr29888792ybc.153.1590389457134;
 Sun, 24 May 2020 23:50:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200521064743.4769-1-maxim.uvarov@linaro.org>
 <20200521064743.4769-4-maxim.uvarov@linaro.org> <20200522171451.GD10319@linux.intel.com>
 <CAD8XO3bA0oTqwQOU9byb-Vk73S4uP7dTUaOZyEmUJmj6rk3UuQ@mail.gmail.com> <20200522200346.GB150221@linux.intel.com>
In-Reply-To: <20200522200346.GB150221@linux.intel.com>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 25 May 2020 09:50:46 +0300
Message-ID: <CAD8XO3bmorhde9YaEUrd07U__01NC9wAE1O6ALijASbbJudHPQ@mail.gmail.com>
Subject: Re: [PATCHv2 2/2] tpm_ftpm_tee: register driver on TEE bus
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, jgg@ziepe.ca,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 at 23:03, Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Fri, May 22, 2020 at 10:29:44PM +0300, Maxim Uvarov wrote:
> > On Fri, 22 May 2020 at 20:15, Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Thu, May 21, 2020 at 09:47:43AM +0300, Maxim Uvarov wrote:
> > > > Register driver on TEE bus. module tee registers bus,
> > >
> > > "on the TEE bus"
> > >
> > > "The module tee"
> > >
> > > > and module optee calls optee_enumerate_devices() to scan
> > > > all devices on the bus. Trusted Application for this driver
> > >
> > > Looking at drivers/tee, it shows that tee and optee are in fact the same
> > > module as opposed to what your commit message says.
> > >
> >
> > In the current kernel it's 2 different modules.
> >
> > > > can be Early TA's (can be compiled into optee-os). In that
> > > > case it will be on OPTEE bus before linux booting. Also
> > > > optee-suplicant application is needed to be loaded between
> > > > OPTEE module and ftpm module to maintain functionality
> > > > for fTPM driver.
> > >
> > > Why is this needed and why things worked before having this?
> > >
> >
> > Before these changes user space has to drive boot sequence. I.e.  tee
> > and optee modules loads, then application tee-supplicant has to start
> > and only then module ftpm can be loaded. The reason for that is
> > storage services are implemented in userspace and driver needs them.
>
> Is the TPM implementation uploaded to TEE from user space and or what
> storage are we talking about? Not sure how these storage services
> connect to the TPM.
>
> /Jarkko

Jakko,
tee-supplicant application provides state machine over callbacks with
RPC messages.
https://github.com/OP-TEE/optee_client/blob/master/tee-supplicant/src/tee_supplicant.c#L614
It also allocates shm. Without running tee-supplicant
tee_client_open_session() will fail.
optee_open_session()->get_msg_arg()->tee_shm_alloc()->...
Optee team wanted to remove some dependencies from tee-supplicant with
moving code
to the kernel. But for now I think that should be out of the scope of
current patches due to
they fix driver initialization on tee bus without breaking current
functionality.

Maxim.
