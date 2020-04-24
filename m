Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF93C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B93B2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ig9+whEU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbgDXRN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgDXRN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:13:57 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B80E8C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:13:57 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id z16so10203364uae.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fxS652cqlL44u1UH5KSxRWk/OvdukEdGbh2h9p3RK4=;
        b=Ig9+whEUMwHChz8p/X08upiaW9GKdVy6o5IC9vys1ebQ/L87dAQbtvFgG8WqUVPKoC
         +TPIvpMlHiE2/tqQyDR1aXhoyIMG8byeN7QImjq4W2o7pSgUrzJV9xFVDOIWtnfrpw93
         eiJpM8tLNPAvkSF9uJtyfzcDbLvX4Jh7ZrPpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fxS652cqlL44u1UH5KSxRWk/OvdukEdGbh2h9p3RK4=;
        b=pLFiNBBWlrkfHc5ptfHFS7DMIGXmRk0IPOObqswS9g0+KhXObHVUuTMyGddfsEZ6Xb
         A4rBwWfvW+5chyYOp8A4EXfw8zyB3Uy8pPPUxNIpCUssPh1XmafLSdX/7NwjOPVkjz/9
         QvrS2KRjSCudxkIJVtd1DyZBW5d33p/TZLgYJ7SJ84H9jU0fUduLfRzi8fXd9Huj00xN
         x2OffskONbyhqvagKmCBLD4WXhPFhIn/0LdvGVcEsdsDXSkM2CkhJJzcQzAxD8HjAq2+
         qVWNf1roMoWIQjIi5HV0pFAYFlMcFK3P8qK57RxtwngwFS+n5CJvnCaP9An/AwhjtwZ3
         urlw==
X-Gm-Message-State: AGi0Pubv3N441amfuVBM/YdC32dVkhtkUjSGTZ4W65HQqUaxisOQHEBQ
        yhgLTXR/LZPSwINeQiyYOiV4MHpRvmo=
X-Google-Smtp-Source: APiQypJIQJMUM8i4KB1ina2lKSVb1NqNp6VHraFae4BLgpPIhjb9X14uaCOKyuglCzP9slrVUCYr0Q==
X-Received: by 2002:a67:f685:: with SMTP id n5mr8852781vso.238.1587748436467;
        Fri, 24 Apr 2020 10:13:56 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id f16sm1511907uaq.3.2020.04.24.10.13.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 10:13:55 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id c24so10196504uap.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:13:55 -0700 (PDT)
X-Received: by 2002:a67:bc4:: with SMTP id 187mr8858641vsl.205.1587748434683;
 Fri, 24 Apr 2020 10:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-3-swboyd@chromium.org>
 <CAD=FV=U6YiD=ORDuuRsYVRJriv+jJie3=HoF7MokWbj5Wx0rew@mail.gmail.com>
In-Reply-To: <CAD=FV=U6YiD=ORDuuRsYVRJriv+jJie3=HoF7MokWbj5Wx0rew@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 10:13:43 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V7KfjEpdQdkXdnGK86cEkpO_SxcDgFiXqAr8oj25P_zw@mail.gmail.com>
Message-ID: <CAD=FV=V7KfjEpdQdkXdnGK86cEkpO_SxcDgFiXqAr8oj25P_zw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh-rsc: Loop over less bits in irq handler
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 24, 2020 at 10:11 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 23, 2020 at 9:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > readl returns a u32, and BITS_PER_LONG is different on 32-bit vs. 64-bit
> > architectures. Let's make the type we stash the readl into a u32 and
> > then loop over the bits set in that type instead of potentially looping
> > over more bits than we will ever need to.
> >
> > Cc: Maulik Shah <mkshah@codeaurora.org>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  drivers/soc/qcom/rpmh-rsc.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Oh, I suppose one nit is s/less/fewer/ in the subject.  "bits" are
discrete / countable, not continuous / uncountable.

-Doug
