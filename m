Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F1CC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DCDE2467E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 08:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qlfk6Cg8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbgAVIEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 03:04:05 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38326 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgAVIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 03:04:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id l9so5276309oii.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 00:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XifBJGa0DN4NJ3rFnW6cBAX9U4Fomg6iECE6EawbVuc=;
        b=qlfk6Cg85x3FfnZH3rrJzAYuty17g/Agu4Te7iNqg1EtXvQl/RaCTw9yD+vmguFqeF
         7bsJScU0k8fzEvsiXs0PH6byeKN0+DHLkN1XsJ9vdRtaufTvRA05595FdhoRMqarovaW
         f13ga3XtvH4YoJEq3qZDR3cYf66DQKV4Ebgi2QMmsy+1FkJTHqAbYsZ1Gx/Q25I5WVqp
         P3k1+UiE7Xu8j2bVQEfc0HikZOpAxJ/JrRZqnlJe00dYN9KCQOlDXOoLG3fUCPa+kn4V
         iejVe2azgmwHsNxBrbEfK3+O4zqhQ3apiRuOo2ctLshLNR0SEmLWOFI8kFQDYw5J0NX2
         SJlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XifBJGa0DN4NJ3rFnW6cBAX9U4Fomg6iECE6EawbVuc=;
        b=S0Rkv32BCQyNn9Cy7Jk6WwJrbjc8vg5KtDQNZ2W/pMmvUgxBN+FNU1Kc780FM6FRd8
         m6LI3/vno5JnS2CHMq2aiJwIz+q4UbTaIHXAP2AFuRHQYnbIKmslOKFiPtdhGL7zVo65
         oQeRt/CMZzkN8/YsArFndNo8DGilMcr5Lk2IDRtHBVZqoEyn5xwPaJHcyKE7lv0gp+sZ
         C3nCPf9p4xEofoSWjRH4SzxSKv9PEyAkcdUr4W4lL0ETAzBDSo8xXublyj2iaNqK3GpR
         bpWR/ToQg88I2dsboICaqF3kBBs0ZsS425c4XvxsNoGgBxB3OBBTtV1WruyYtUvPZxet
         Dz0w==
X-Gm-Message-State: APjAAAXWQ8P6EcXhsB4qbg+GHFUOIWll5yJBvnIpUEAaCi8ej37j2E6+
        chqBHaomsHD2M6rhhDlOMyLmaQup1VUfxnQRX5Q2/g==
X-Google-Smtp-Source: APXvYqwE0Wlw0SYqPyeRLdKBkujnJVIpyqyBtPTa2Ai1wTLUkvsjaLCi8LuHwZW1KG95uKgfZmRCCN4aReE3LN3xpI4=
X-Received: by 2002:aca:1e11:: with SMTP id m17mr6011716oic.5.1579680242453;
 Wed, 22 Jan 2020 00:04:02 -0800 (PST)
MIME-Version: 1.0
References: <20200110122807.49617-1-vincenzo.frascino@arm.com>
 <8fa0e5b3-6e88-3fa2-9e16-046350cc752b@arm.com> <20200121152031.GA572414@kroah.com>
 <f4134c26-231f-968a-7fc3-0427af9a886e@arm.com> <20200121171836.GA674326@kroah.com>
In-Reply-To: <20200121171836.GA674326@kroah.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 22 Jan 2020 09:03:51 +0100
Message-ID: <CAHUa44F1FU6iPqjkk_9ALS0YHc5AVtSzweEt-0RX919cUbU2eA@mail.gmail.com>
Subject: Re: [PATCH] drivers: optee: Fix compilation issue.
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

On Tue, Jan 21, 2020 at 6:18 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 21, 2020 at 03:27:47PM +0000, Vincenzo Frascino wrote:
> > Hi Greg,
> >
> > On 21/01/2020 15:20, Greg Kroah-Hartman wrote:
> > > On Tue, Jan 21, 2020 at 02:23:02PM +0000, Vincenzo Frascino wrote:
> > >> Hi Greg,
> > >>
> > >> I sent the fix below few days ago to the optee maintaners but I did not get any
> > >> answer. Could you please pick it up?
> > >
> > >      $ ./scripts/get_maintainer.pl --file drivers/tee/optee/Kconfig
> > >     Jens Wiklander <jens.wiklander@linaro.org> (maintainer:OP-TEE DRIVER)
> > >     tee-dev@lists.linaro.org (open list:OP-TEE DRIVER)
> > >     linux-kernel@vger.kernel.org (open list)
> > >
> > > This should go through Jens, why me?
> > >
> >
> > I added Jens and tee-dev list in copy already but as I was mentioning in my
> > previous email I did not get any answer. I thought that since it is a small fix
> > you could help. Sorry if I made a mistake.
>
> Give people time to catch up on email, especially for obscure issues
> like this.
>
> thanks,
>
> greg k-h

I'll pick up this patch.

Thanks,
Jens
