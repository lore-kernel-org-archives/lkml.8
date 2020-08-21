Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D156C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:04:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29878207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 10:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ck0zWUoa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHUKEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 06:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgHUKEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 06:04:34 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F4DC061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:04:33 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id u24so1066262oic.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 03:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PzOnOH+BwzHErNBhtFUOMqnorNGKoQrz50xMPPMcSsw=;
        b=ck0zWUoaOlJkW8mZ2Nq4AFoSPwnGvCphFy8dxOWofUw+Pt7wV5qATxkMEP0DcAFOE2
         k/oUm/4pSgN5N6cQwX9FgA4H4gkLUB5bxXyCzZBYV9039vZfTWpItmp3dfP889zd5Xsn
         sA8rqjj89NCllixwZLkeEsYc/NVSuNzGpGgPf2+lB+AET0XsojtX9ZMUHFFG2VN3N6Mz
         GqNxYVzQoFOMEmDKOpB/C5Y4+rlCn+R83ftJ5J1rgYETqx82p/3H9DYK1Ndn4yGLsTWN
         SWzEVHYRxPjguJmL1XOGyhJRTT2CS7zkREqRnOllqxjDDR4WFaFoWph1hOY7SdnIB4Y7
         wCFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PzOnOH+BwzHErNBhtFUOMqnorNGKoQrz50xMPPMcSsw=;
        b=fjlCOZvscF72lActb4Q0LXmLaNqKQFAH844ei2msSH3XIHr1rmxF+LoHUWtu2d4TVf
         Q8zvAQK42ImdchE5nYFtIyV+FEz8VxMxt615znIt2PwN6M8/oxpil/Im5Yyxd0vbp5JG
         nU5VJfVLvcYQpvvC1l9iKaD3ICv4CIVtF8aw2XG5OzO2Dv7I5TuHVvmLuPjKOGrcU8KM
         Gd8nvuwXqKV44z9AKCJ2M+9MENLBzU5CaK3eiL1xMWoqJnKfv/O4mFTGTTfRGuVlIv1F
         1Kj1z81n3AAj23YNJQkJRzpbL63jRuVN16LtKDFUBaoVUGNOZsmkR/pIXUbUK4a6WVA3
         w9Mg==
X-Gm-Message-State: AOAM531vRK19m45mYibUZTLndWmNl+0Fq/oU1KKDkr43l2g1f/KfRdbD
        TgZ1Qbfp1jIYYpd94EJbpPPW5wHuFKoXgw8fKtgxxMXt5GE=
X-Google-Smtp-Source: ABdhPJy5HBasxRQV6tmNMPtVnLj9jZfqP/MsUp0/4w8q2hRzZa7YhoFvwvi2/AhPWOUoKXXX7oddsx3w9DVUiW7duXo=
X-Received: by 2002:aca:d8c5:: with SMTP id p188mr1166001oig.47.1598004273133;
 Fri, 21 Aug 2020 03:04:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200814111221.5813-1-jorge@foundries.io> <20200821062121.GA1020247@jade>
 <20200821063657.GA20356@trex>
In-Reply-To: <20200821063657.GA20356@trex>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Fri, 21 Aug 2020 12:04:22 +0200
Message-ID: <CAHUa44GCpVFGf0U=N0XghiZJWiNBHOrYW4P_JMp3uyoz_7PWzg@mail.gmail.com>
Subject: Re: [PATCHv9] drivers: optee: allow op-tee to access devices on the
 i2c bus
To:     "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>
Cc:     Sumit Garg <sumit.garg@linaro.org>, ricardo@foundries.io,
        Michael Scott <mike@foundries.io>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:37 AM Jorge Ramirez-Ortiz, Foundries
<jorge@foundries.io> wrote:
>
> On 21/08/20, Jens Wiklander wrote:
> > On Fri, Aug 14, 2020 at 01:12:21PM +0200, Jorge Ramirez-Ortiz wrote:
> > > Some secure elements like NXP's SE050 sit on I2C buses. For OP-TEE to
> > > control this type of cryptographic devices it needs coordinated access
> > > to the bus, so collisions and RUNTIME_PM dont get in the way.
> > >
> > > This trampoline driver allow OP-TEE to access them.
> > >
> > > Signed-off-by: Jorge Ramirez-Ortiz <jorge@foundries.io>
> > > ---
> > > v9: params return value must be written before optee_msg_to_param is called
> > > v8: review fixes:
> > >     fix types and add TEEC_ERROR_NOT_SUPPORTED to GP errors
> > > v7: add support for ten bit i2c slave addressing
> > > v6: compile out if CONFIG_I2C not enabled
> > > v5: alphabetic order of includes
> > > v4: remove unnecessary extra line in optee_msg.h
> > > v3: use from/to msg param to support all types of memory
> > >     modify OPTEE_MSG_RPC_CMD_I2C_TRANSFER message id
> > >
> > >  drivers/tee/optee/optee_msg.h     | 21 +++++++
> > >  drivers/tee/optee/optee_private.h |  1 +
> > >  drivers/tee/optee/rpc.c           | 95 +++++++++++++++++++++++++++++++
> > >  3 files changed, 117 insertions(+)
> >
> > Looks good. Did you test this with the recently merged
> > https://github.com/OP-TEE/optee_os/pull/4033 ?
> >
>
> yes, I did retest and it is good.

Good. I'm picking this up.

Thanks,
Jens
