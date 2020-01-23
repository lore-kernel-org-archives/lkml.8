Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2145BC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E756B2468A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 12:03:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YzZBMWft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgAWMDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:03:30 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54455 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbgAWMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 07:03:30 -0500
Received: by mail-pj1-f68.google.com with SMTP id kx11so1111836pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 04:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZiMFGAL4MYwPDWT3nQ+OXP6Uxt21dHwm6mYmXom6vtc=;
        b=YzZBMWftyxZgk91oENZXRNJBB7oUI03xAWUTP9zQUVJ+GlYR6YWqzjtZIGZc79dYGo
         uUfFe9YWcvqqXP2PKXNLFHoulA5t9nV3xLUNJ8YZ69cHSJDJif0DEC7egWKoISXd8/9a
         oaX+CWk7VbQQpk4NYy4QEZSaOPkkqQW2fyDYoZn4R86YjtI3HUkep7H0iIETXsSez8vL
         rI8fUzFx95K8x7/2NIgtarxj8xiLl7GTxw+6v4hHRG+GvEdiDNW19xOVzFIQ+WsE53is
         RmiB617j7AF7tm60joSF70xyfcc+LDG6ljO+lk9hUpHlWNJjBJVJBj6VyHlTlARUrZS4
         uO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZiMFGAL4MYwPDWT3nQ+OXP6Uxt21dHwm6mYmXom6vtc=;
        b=XIStvjdaHHV3mkkMwsdrd/WkfLL+CGLVSCKiC9rmX4r9ggVGDRPbY6nFH3VkkpoMxw
         BTQuHU+3TMSfNUKxH4VE+RzrvS/kycm7+xTHsJGjxHFbxysAe+EJjkoYaw2z1ZA24Eb/
         Gz9ll9O2KaT7rUQ/Qeiy+THtlQwHQH9RuAqEjAbSFVZWpTCTsKZmKKDvJu9p0ZrG4qRV
         NlOEDJjooffyEPLCEZfCFzhW6Yw5ssAdlS3XMorqI1v43HI4OY/NumI1hy0LFx8EjZ8T
         dRYDjrDp9hInPxkjwVkmYe9T3jRiixi8aZZXV1sick7eno1TwNAtD0ktC2F7YTS2tTNE
         TLfA==
X-Gm-Message-State: APjAAAVPFkKt4nq9HiVt/Bc5qmJ+i80io2ncftF/5jRq4F8m92K4ef+8
        26jO/nPsy8o8jcxVSow9WHHm
X-Google-Smtp-Source: APXvYqyrUb3y7qFM2xtn82CkDZBo8IX75BHTTHG7tYasTeQVdVUUEDLn4tshSoPfvr6qo7FeYAEOxg==
X-Received: by 2002:a17:90a:1ae9:: with SMTP id p96mr4305509pjp.8.1579781009682;
        Thu, 23 Jan 2020 04:03:29 -0800 (PST)
Received: from mani ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id q11sm2398245pff.111.2020.01.23.04.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jan 2020 04:03:29 -0800 (PST)
Date:   Thu, 23 Jan 2020 17:33:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     gregkh <gregkh@linuxfoundation.org>, smohanad@codeaurora.org,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        hemantk@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 16/16] soc: qcom: Do not depend on ARCH_QCOM for QMI
 helpers
Message-ID: <20200123120321.GC8937@mani>
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-17-manivannan.sadhasivam@linaro.org>
 <CAK8P3a3PKukf4K48T89v5R_eUAMuYhoULsF1noK2gzSDpi1qVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3PKukf4K48T89v5R_eUAMuYhoULsF1noK2gzSDpi1qVg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Thu, Jan 23, 2020 at 12:45:32PM +0100, Arnd Bergmann wrote:
> On Thu, Jan 23, 2020 at 12:19 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > QMI helpers are not always used by Qualcomm platforms. One of the
> > exceptions is the external modems available in near future. As a
> > side effect of removing the dependency, it is also going to loose
> > COMPILE_TEST build coverage.
> >
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: linux-arm-msm@vger.kernel.org
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/soc/qcom/Kconfig | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index 79d826553ac8..ca057bc9aae6 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -88,7 +88,6 @@ config QCOM_PM
> >
> >  config QCOM_QMI_HELPERS
> >         tristate
> > -       depends on ARCH_QCOM || COMPILE_TEST
> >         depends on NET
> 
> Should this be moved out of drivers/soc/ then?
> 

Good question. I thought this change will trigger the question anyway ;)
Will need to hear from Bjorn on this. I agree that it should be moved out
of drivers/soc!

Thanks,
Mani
>         Arnd
