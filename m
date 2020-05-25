Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C9FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:36:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2370B2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 13:36:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BKJ+vT23"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403866AbgEYNgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 09:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403843AbgEYNgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 09:36:54 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A503C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:36:54 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id u73so5918175ybi.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 06:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcSOKq/rHuR2xKP/geses1NMEAx6OusfI/F+nRB6n20=;
        b=BKJ+vT23rQPh5/rXBGS0njdwZQY77KFgROhvzOdQQuGJnaH6eFK29yxLsfxm03OtAW
         mJmSCaKASE1ZekZXA/No4IFpT+nYZO2elldidGTfsy09faIl1kXz34zL0s7pai8BGtcs
         XrIVhkbHi3gC3fhX29bLkL7e4CHSKFR46KHC5RNtflO4SqsnHePgGohyxhfBEXBgcZ4U
         tpe+bz4UJL/TGvYsCvJeYfJpjS0r8Wru75WUMO7bLJ0l+CV1xGIQa3kdrKHN1mH6TX/u
         r8NVe4qpwKljXiDkLIr0VVGzfy+3SZHHau0TA4GeIYGQJPb7DYawu/X/pPkYOjMVfTbV
         khMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcSOKq/rHuR2xKP/geses1NMEAx6OusfI/F+nRB6n20=;
        b=dBrYOxw3VRJ0Fic6aC5c6/WXqH/HIr0zeSUrSnOlWQe58MP7slO2jSGeySFfX2/Mmc
         ESPf5S3mwFdpXfgFdg0D/+rO/GeZ1TieKwkF2bPRrZRBLEJt1SZCV+AhiBqQI/Xike8w
         J5nZPINk2F3Frn0v3cQYh/oPfoO0lL4jLFxY3U36sFHFcKO7387MLLUTwvyvBd8ENnAz
         KIlOQ9mKpP/+izLO6cC5wsP0+6SY+zmroLyKuS3hk34xroRpzk/I62Grfeh6DlCHPC1S
         FxlQEe1RsngbZJClWkUgF2ZUNT50xT8WCSp9ESrM0U4YVtbxzo4vaeqJdWS4nBFKycRr
         ObpA==
X-Gm-Message-State: AOAM53292C0ucyMsmNmC7IMp0YvhZUubHqviyQ/KCEZBr6OvGiZzxlxU
        1DU3YIro6mKoUL59WKU2SCAl8istGnNACBVFh/KBqQ==
X-Google-Smtp-Source: ABdhPJxHivkwWr92vIcWVAPmxdHI21UBD0f6kmFnhPInoYjQuzZMpD316VmCFypVA2DEq0sqTEZTIvRbnSo3Vys20vs=
X-Received: by 2002:a25:209:: with SMTP id 9mr31936236ybc.153.1590413813384;
 Mon, 25 May 2020 06:36:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200525115235.5405-1-maxim.uvarov@linaro.org>
 <20200525115235.5405-3-maxim.uvarov@linaro.org> <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
In-Reply-To: <7de3fea9-cd88-4dbf-aa27-3cb188fd6e85@forissier.org>
From:   Maxim Uvarov <maxim.uvarov@linaro.org>
Date:   Mon, 25 May 2020 16:36:42 +0300
Message-ID: <CAD8XO3amGVeyn9qsWE-AyGM=e36ubwxC4tiwGMVHYBL6E46ZhQ@mail.gmail.com>
Subject: Re: [Tee-dev] [PATCHv3 2/3] optee: use uuid for sysfs driver entry
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Arnd Bergmann <arnd@linaro.org>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 May 2020 at 15:10, Jerome Forissier <jerome@forissier.org> wrote:
>
>
>
> On 5/25/20 1:52 PM, Maxim Uvarov wrote:
> > Optee device names for sysfs needed to be unique
>
> s/Optee/OP-TEE/
> s/needed/need/
>
> > and it's better if they will mean something. UUID for name
> > looks like good solution:
> > /sys/bus/tee/devices/optee-clnt-<uuid>
>
> How about mentioning it is the UUID of the Trusted Application on the
> TEE side?
>

Jerome, do you think optee-ta-<uuid> is more suitable here?


> >
> > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > ---
> >  drivers/tee/optee/device.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
>
> Thanks,
> --
> Jerome
