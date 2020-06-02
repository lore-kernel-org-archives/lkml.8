Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F784C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:57:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51F562074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 11:57:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k+9cCuBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFBL5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 07:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgFBL5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 07:57:31 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C1DC061A0E
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 04:57:31 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id c194so6977858oig.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 04:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bnys2wOoEU1x/ikV5ijTNA/FpnweJ1oEqvvB7NUEA+A=;
        b=k+9cCuBX+07ki3h/U1eTOzlr6ODNPkXXcMKP6TfZD7xxmJxeBWW3n9KjD5Mg1xqfxl
         CqMnaNTwFk4x77rZ3i4IpXbcT3Lz0kMvuu5YL/MJ1IvMjZQqxUnWCDc5VhRoQRm9ETn/
         t9/MEFpNnEXCG0JRS0g0z25GDiOozWbkOTdxfYjCG5iAvZFoaBtC80XqC3qwp1Egq7Bj
         oXW7ASgx69H0zp0YNjuLPGrC0UFqf2u/Qphzr8zuZBi1hTWXjrU0MRk7pWYFRAyoxyV5
         MibIXAuxNYlXoDbaxIpKNnSPdw1PNSBNbD7I8rhM/2vJb17fdDmqsTVVpccOou9NM1ZX
         5zMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bnys2wOoEU1x/ikV5ijTNA/FpnweJ1oEqvvB7NUEA+A=;
        b=Bu8rVZKdXPniqryEJxNMuMIUo68BOTXEz8ve+SDbIP8NlfJrnftAK2Gtzutfvm0qvn
         rEM0gfWdq0R7hd96N3vir5wIXk+yWzay1UbJzm1k/g8F/DLPElxHcdjhobNi2WtMmePk
         zMof4hRjzkHlY9kw9Ff3fBnlvQGErFK8s6HvYgV5sqArmbiI8nCOxxIJvnSSOOm7sAIr
         JP2izbmVCgRyxoPMpcEsFQkffuTN3bYHiYU1qF+toFdeiRLv5eF7q5jj9j89oABKGhum
         +EmZ2SiTnqUBM1nBWVa8O8+UnaYncS3v5yz1O1nZ0Is6IWLW8ep5OCnSb1usYG0j8t5Y
         B3Fg==
X-Gm-Message-State: AOAM530hUxqrjSDI7am9KEYhiuZH/eHdT0YpulXUrqBlozyQMG9QC9rE
        nGVObqZwMk42C52UqwTULnrgwXzibYut8deUtxWWew==
X-Google-Smtp-Source: ABdhPJyF04o7i6kEvgUR2RRqw2rFPSQaTPQrgt/KTJQMMVnh2YChB0XvplTmPPHzK36jN1aEaoBMWgCgPKD1BB58jkU=
X-Received: by 2002:aca:50cf:: with SMTP id e198mr2811324oib.76.1591099050929;
 Tue, 02 Jun 2020 04:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200602100924.26256-1-sumit.semwal@linaro.org>
 <20200602100924.26256-2-sumit.semwal@linaro.org> <20200602112415.GD5684@sirena.org.uk>
In-Reply-To: <20200602112415.GD5684@sirena.org.uk>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Tue, 2 Jun 2020 17:27:19 +0530
Message-ID: <CAO_48GHdhafjgLH1-3upZPXhNjKSt_bPAnPpjA+nhR2wrLbcZw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] regulator: Allow regulators to verify enabled
 during enable()
To:     Mark Brown <broonie@kernel.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        lgirdwood@gmail.com, robh+dt@kernel.org,
        Nisha Kumari <nishakumari@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, kgunda@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Thanks for the review!

On Tue, 2 Jun 2020 at 16:54, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, Jun 02, 2020 at 03:39:20PM +0530, Sumit Semwal wrote:
>
> > +
> > +             if (time_remaining <= 0) {
> > +                     rdev_err(rdev, "Enabled check failed.\n");
> > +                     return -ETIMEDOUT;
>
> s/failed/timed out/
Ack
>
> > + * @poll_enabled_time: Maximum time (in uS) to poll if the regulator is
> > + *                          actually enabled, after enable() call
> > + *
>
> This comment needs updating to reflect the new implementation.
Yes, I will update.

Best,
Sumit.
