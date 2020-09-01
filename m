Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E50C1C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF6442078B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 17:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X24yWagx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729865AbgIARCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbgIARCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:02:10 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D5DC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 10:02:10 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so2675796eje.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0W2yxpJArpylRLCAMIxUVDHEOE0Rtc8t8qbdRvvfyJY=;
        b=X24yWagx+1ZBxGqiyugUJ2eJGaAd8LrpJbAszSn32GfXleOf7l+Ypbk3seu9N8m9wr
         6rFo3aOLOdswBzxVz6unSED4HxB+bT3WIHtXET+LhFFSm4HHGO1rkE4I/Yu1Vdk3LYWf
         b7bEDunKc/ozpoOXKv0FSOLA+nXGTcEaKgmJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0W2yxpJArpylRLCAMIxUVDHEOE0Rtc8t8qbdRvvfyJY=;
        b=Mc0JjgEKLwQehccTK0NYxmIuDfvX8m9Q+HKuRcDaEDDKgViliT4Z5oWjHwofil4JMH
         pK1QVDI5UG/aZ3bRBH28KTQ9Azl1DwUNOFOijVUDFCfsIuq7Ez4GoL4skGby4cXv+6a7
         cGy4ywOJsT1lbBWNJH7AxslAM7qc9Zr5xbtSePpSpfPS4tN5NpWdvRH8+M1mQca9+vx7
         7xtYumrVBr5nGVe7G1lhb1eMexoihcaJLPqpRHqB5M+HwcpseiH0uSP/mwRdtDUFKKYP
         bpCRFPrRhI2F+ocxNGwrXPE72ySsD5Drcz9DxzbL86aOqAIXdqdsI09povCYfWXHCqoh
         n+6g==
X-Gm-Message-State: AOAM533LT9LLrg56bL22cSpMWZCyOVE+qv8vU/bM84jTIciNFczk6L8g
        /5/XnHa1hPFwum7knZua31OsjXqxAstUjg==
X-Google-Smtp-Source: ABdhPJza+mrVDRJouEfFPORTPlR9A3AFDDoUba/JrzYSheajun2Ff+Kouqenc52a18JfBkG/hRbcrg==
X-Received: by 2002:a17:906:a43:: with SMTP id x3mr2322752ejf.321.1598979728360;
        Tue, 01 Sep 2020 10:02:08 -0700 (PDT)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id q13sm1571206edr.27.2020.09.01.10.02.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:02:07 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id a65so1850829wme.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 10:02:06 -0700 (PDT)
X-Received: by 2002:a1c:b407:: with SMTP id d7mr2845879wmf.59.1598979726047;
 Tue, 01 Sep 2020 10:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200901081920.v2.1.Id02b2f451b3eed71ddd580f4b8b44b3e33e84970@changeid>
 <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
In-Reply-To: <159897502625.334488.7103007623601336114@swboyd.mtv.corp.google.com>
From:   Daniel Campello <campello@chromium.org>
Date:   Tue, 1 Sep 2020 11:01:29 -0600
X-Gmail-Original-Message-ID: <CAHcu+VarBz3m_zKfDB0osQsjZ0dMpvUk+q2Qt-yC5DbPjr0bRA@mail.gmail.com>
Message-ID: <CAHcu+VarBz3m_zKfDB0osQsjZ0dMpvUk+q2Qt-yC5DbPjr0bRA@mail.gmail.com>
Subject: Re: [PATCH v2] iio: sx9310: Prefer async probe
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 9:43 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Douglas Anderson (2020-09-01 08:19:43)
> > On one board I found that:
> >   probe of 5-0028 returned 1 after 259547 usecs
> >
> > While some of this time is attributable to the pile of i2c transfers
> > that we do at probe time, the lion's share (over 200 ms) is sitting
> > waiting in the polling loop in sx9310_init_compensation() waiting for
> > the hardware to indicate that it's done.
> >
> > There's no reason to block probe of all other devices on our probe.
> > Turn on async probe.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
>
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Reviewed-by: Daniel Campello <campello@chromium.org>
