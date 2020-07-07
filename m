Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC5FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFBC20578
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQyANoeX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728210AbgGGMlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgGGMlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:41:37 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592BAC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:41:37 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id j11so962758ljo.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ypETbYDmBUU+3F9o/BjesSvCn4v+una8ZbjJDtRTCVk=;
        b=nQyANoeXOviqCRwhNlHHF4L93TF7B5Jk8/+7jVP0zkRn0KT1KLYMYdPwlpPYWDzOVp
         40Bb0RHbTiFM4B2sdEhda5RK47VgYLc2hqCj7AJ1ZUT8oz7UHgu5BJEI5Gb5443VWL5h
         ys8r/C6XWesEiKuDylcnJCrow7hFumAUfIhpPneS3Za1zxiSQEAENkK531xKMlexu4k2
         XOX+19DjyjfbkG1srUQZZQriNLXxrCHvTSHg1VzoiiPkVQHjBq1BimEYm0n2XD7STkMq
         HDvv4P1Z5H2J3IJLBjyW1EHytVghu4N8/uhN5XHiRbXMS23sd3kMj6dCWgmVQJP1q/Ql
         /yeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ypETbYDmBUU+3F9o/BjesSvCn4v+una8ZbjJDtRTCVk=;
        b=CK0XErpXlKF6Pal+Vxl69Sy/auTMoUrnhoD+w8Rhu6YuAuuxfmBnMKxBD73e8c0Lr5
         W7M0weZA7Ej85WEP78YQb7rMgnfRRyMQ70gW6ognC4wMmoFkPJ8uI5lTAYxsLWma0n9n
         dTnrPEhemKF4x2JOlfMnAHgEOfos4KsAlmTrrI4HzLk1+n7hDG2xgsC7MjFaao7Envlh
         Qbf+0GAfcLJFQ3u/HOtOB7og04Sk/Ut4BKJb/2TiX7g9gM2Y3xPxu9+HKadm8qH6azaM
         MeNYUyvW4G6JtXOB0GNq2bKvs+eqbAlFWMpvzY3GIgOynHKvlKQWwo+OdLJeC1t8ydcC
         MWCg==
X-Gm-Message-State: AOAM531NmQH5pRPiVv+Ri1A45gZ1FJyzy5mqSztZOCIYevAp1fVxj90l
        RD+10RpIYJm1aNVhkp1T/dITINYckPt+ep2h0Gcfq0kXhZM=
X-Google-Smtp-Source: ABdhPJxpOK1i7BDud/fkrVXbDocIMD5x9danptsvKnwSh+im+EKSOqbAVhMD7vbAoRt9U4AF6LlCeqrg0J3p2+8XTLI=
X-Received: by 2002:a2e:810a:: with SMTP id d10mr24442069ljg.144.1594125695862;
 Tue, 07 Jul 2020 05:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200625191708.4014533-1-lee.jones@linaro.org> <20200625191708.4014533-5-lee.jones@linaro.org>
In-Reply-To: <20200625191708.4014533-5-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:41:25 +0200
Message-ID: <CACRpkda4tphGY1UvMtR6k1vDNaKpsgyQLcVLQL9h964pDz=O3g@mail.gmail.com>
Subject: Re: [RESEND 04/10] regulator: dbx500-prcmu: Remove unused function dbx500_regulator_testcase()
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 9:17 PM Lee Jones <lee.jones@linaro.org> wrote:

> There isn't any code present within the current kernel to
> override this 'weak' function.  Besides returning '0', which
> is never checked anyway, the whole function appears to be
> superfluous.
>
> Consequently fixes W=3D1 warning:
>
>  drivers/regulator/dbx500-prcmu.c:113:27: warning: no previous prototype =
for =E2=80=98dbx500_regulator_testcase=E2=80=99 [-Wmissing-prototypes]
>  113 | int __attribute__((weak)) dbx500_regulator_testcase(
>  | ^~~~~~~~~~~~~~~~~~~~~~~~~
>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
