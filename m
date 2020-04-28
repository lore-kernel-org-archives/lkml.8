Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A97C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F70A206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXun4602"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgD1HDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726253AbgD1HDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:03:30 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD74C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:03:30 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id d17so23303810wrg.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 00:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=d80p8k51RV8Ii31H8c+Iq6vujq3CggrPsTKCRimkvi4=;
        b=zXun4602okDGRYn8XiLEIHtsfd9v1rIwMMKeu+9hiWx2ZG/wJd3ht1CLbz/PPWSPzx
         Xs/SGjQnIpi+0oDrczAeaVSDJD57qpno8vVy/PCokt/MlwZ/B3y4NIDOoIlZZd1ES49Z
         SZR34DXDeT6Y1ajYv83ohSDh1wpyPD0aUWMJdHFb5hwV/mJlj9LIXKXU+uYfjkgirS6a
         lHsOEZCEcvEebukq22aTjSB7xg1QO2hTypVt5JWWvi92tMy5J+fnTeNPaiXcv5ltXVj/
         W+y4HIEce1zmyGtpa2sGAHF3x+Pp0HSBBzCvsR1cNLJVP94gnlyKz79YF7IjHUYNSL20
         wS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=d80p8k51RV8Ii31H8c+Iq6vujq3CggrPsTKCRimkvi4=;
        b=H3pbos0B41UglT7/x3nsvpsF52UqQATWo/Rp+MR6o06LNlq+aY1BcVILs8IbhcftiV
         9EQpm3wI27R3/7z+z0sBQTyAqgEAjmbPG7xTvgqcj94iLt73jMXJBZtwD3be9Yut44Ws
         cM3rnS8UYPLwdjzjIZCi8Ld41iVV6AznbdyGLCWaUN7RGLU/s3tvKzNex9asfIvIc8gl
         Au0yUsztEmhXEH93zPU6IPvWJ95D4NU6VilYSCwdkkul1JZqZF5zUjbQEasyD8vXE3Cw
         OvNBwMTVMvAJSRrgpDAA68iruDFTSgoR1988P1a3j2t1C3UG/He/dN4ymrS2ftY1U7gs
         YxGA==
X-Gm-Message-State: AGi0PuafIPoR7eIWb/bJc6MWKvxcuomnWO6s5tiDfS6OXjKzDB5BlQQ4
        6Cq1+5q4uotkj74GSzzhaZnLHg==
X-Google-Smtp-Source: APiQypJcL3tHBCbLlcc7UeQUAGJ2UgtgMo77ETUj1h5CMVB6neW1tCihGzh0jeWgP3NKFnYTOQn4wA==
X-Received: by 2002:adf:f98e:: with SMTP id f14mr31210015wrr.253.1588057409075;
        Tue, 28 Apr 2020 00:03:29 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id m8sm25497629wrx.54.2020.04.28.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 00:03:28 -0700 (PDT)
Date:   Tue, 28 Apr 2020 08:03:26 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Adrian Pop <pop.adrian61@gmail.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] arm: dt-bindings: mfd: stm32f-rcc: Add missing DSI
 clock
Message-ID: <20200428070326.GH3559@dell>
References: <20200424181642.32084-1-pop.adrian61@gmail.com>
 <20200427064910.GC3559@dell>
 <CAP-HsdQOyWrz+Y7gR9jrNjX09NCYB1EWK7swMQDZ-v-VJLGRMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-HsdQOyWrz+Y7gR9jrNjX09NCYB1EWK7swMQDZ-v-VJLGRMw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Apr 2020, Adrian Pop wrote:

> On Mon, Apr 27, 2020 at 9:49 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Fri, 24 Apr 2020, Adrian Pop wrote:
> >
> > > Add missing clock.
> > >
> > > Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> > > ---
> > >  include/dt-bindings/mfd/stm32f7-rcc.h | 1 +
> > >  1 file changed, 1 insertion(+)
> >
> > I assume patch 2 depends on this?
> 
> Yes, second patch depends on this.
> 
> >
> > If so, where is it?  Why isn't it in my inbox?
> >
> 
> Here it is:
> 
> STM32f769-disco features a 4" MIPI DSI display: add support for it.
> 
> Signed-off-by: Adrian Pop <pop.adrian61@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f746.dtsi      | 34 ++++++++++++++++++
>  arch/arm/boot/dts/stm32f769-disco.dts | 50 +++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+)

When you resubmit this, please add all recipients to all patches.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
