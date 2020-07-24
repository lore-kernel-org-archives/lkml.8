Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D93C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF32B2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaYEtLFI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGXLfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 07:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbgGXLfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 07:35:46 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8338C0619D3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:35:45 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g37so6708499otb.9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jul 2020 04:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0okWF7m0mxKnIjxocen5tI8Jd/G7/Bk7ETNsmNpYOFA=;
        b=BaYEtLFIQLnHBtzZnOMivwOHKaNw21qCUdJOsfu86Ei5Eu/AOwAUeIS5K+s11lqhGi
         yi3jldrEmla9RW8pdzXD3wUfMlp1WFy5CbWPbs8g5Is5lLdW/Dy0WjQUHqc9XADYYpuk
         vViqlfhEZRrnADqugOPCz+3AsC2bwewAnDHr+AquPGwfJ1EpzAV9DLo5XCSOeaNCXpl7
         /ky9hyaoJri3tfntaZiFvDykYXLfr2n+mzaja5IRUoqDuqezMFgQRovF9hqdbtU/pVbs
         5J37MNaMF2lR3asJ5sH/Aoxf8uFnvPSlwoe0YxCXxVjz8jx3gkIvG3fwiLRIn9/d5buh
         hrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0okWF7m0mxKnIjxocen5tI8Jd/G7/Bk7ETNsmNpYOFA=;
        b=bfRjNtOGMblEKwcrATugmdDsDh2rnNyFQxDWL6+3EJeqsPi5XKnb5D9LclzcZGVdxY
         Iq4W6mDu/GJuQzyVxdl8otT/fbuJM/+2JWzbe7Wri4ouuaCNy1gRyqbdiPAeNgsR/pBM
         cdOewXl/kFo0Hwz8ZhxN7S1MQDMq84/6QuF38kgY0dNiIx1EWPOCUlGbJO2UByL0gt4h
         qvqbzxMbcS4PEmkI0kz3od0HAfEykhjToYIkcegK6n6sCbUmw7y3X7cjm4tN+4LF1vOZ
         vOFBhB4Hy+5y1rYRZo16hwTG2c0DCzh+J3v3saNeX+5YX3HkyAv41hcXQOecmXd+6A6V
         RCcQ==
X-Gm-Message-State: AOAM530IsUgcTcAvtLjl8fN1PytUcsgnmfC9X+V4pVc/fRvgJkCNwtOV
        TyVy9tUCq7++fx4htit3yr6hOsfNlBlk644wDOrrW7fU
X-Google-Smtp-Source: ABdhPJzNmPb/Pb0fSf86yJwe0oZTFd8E1Iyrwq4Eu5yXiZiTxpZ0eqpb19Hem0ncB91v4QJ3fw7E/5v9+GCbNX/v3FA=
X-Received: by 2002:a05:6830:42:: with SMTP id d2mr8760888otp.339.1595590545204;
 Fri, 24 Jul 2020 04:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200723191525.GA24516@ogabbay-VM> <20200724093259.GB4116407@kroah.com>
In-Reply-To: <20200724093259.GB4116407@kroah.com>
From:   Oded Gabbay <oded.gabbay@gmail.com>
Date:   Fri, 24 Jul 2020 14:35:17 +0300
Message-ID: <CAFCwf10r4eqO=6B=C_iKt17XcY7oVuRDEJs5_x9Anw_5Djig6Q@mail.gmail.com>
Subject: Re: [git pull] habanalabs pull request for kernel 5.9-rc1 (resend)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 24, 2020 at 12:32 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 23, 2020 at 10:15:25PM +0300, Oded Gabbay wrote:
> > Hello Greg,
> >
> > (Re-sending this pull request)
> >
> > This is habanalabs pull request for the merge window of kernel 5.9. It
> > contains many small improvements to common and GAUDI code. Details are in
> > the tag.
> >
> > Thanks,
> > Oded
> >
> > The following changes since commit 7a4462a96777b64b22412f782de226c90290bf75:
> >
> >   misc: rtsx: Use standard PCI definitions (2020-07-22 13:39:31 +0200)
> >
> > are available in the Git repository at:
> >
> >   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-next-2020-07-23
>
> {sigh}
>
> Commit: 961a7325e670 ("habanalabs: Fix memory leak in error flow of context init")
>         Fixes tag: Fixes: 786c94810698 ("habanalabs: Use pending cs amount per asic")
>         Has these problem(s):
>                 - Subject does not match target commit subject
>                   Just use
>                                 git log -1 --format='Fixes: %h ("%s")'
>
> The scripts I use to check this are here:
>         https://github.com/gregkh/gregkh-linux/blob/master/work/verify_fixes.sh
>         https://github.com/gregkh/gregkh-linux/blob/master/work/verify_signedoff.sh
>
> And note, if I ignore these errors, you will just get the same response
> from Stephen when it hits linux-next :(
>
> thanks,
>
> greg k-h

I'm sorry for all the trouble Greg, but I wanted to ask before I send
it again, won't the fixed sha-id be wrong once you merge this pull
request to your tree ?
Because this patch fixes a previous patch in this pull-request.
Maybe I should just squash them ?

Thanks,
Oded
