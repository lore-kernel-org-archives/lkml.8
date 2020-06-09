Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCD0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:16:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFE762072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591741005;
	bh=vFX26QVGoPRpKNO8oZhDXK/YKdFiLTzl+hiW/7IdibE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JEwvKzWG4le4xtyAJsLBB1nef/maQXV+leOqfvGq0CXc0PjkVoaisOuKuKwoSvzw9
	 iUbXU72JDsZ21S50KktTA6scg40TQ7RDXqLEaSE7CqUc0o9TS/WWqeeGPkgcmWMRPz
	 UFxk+Pn8KECXNy/V9zIiBcko7K1G5K43Ef8Df8Cw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgFIWQn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:16:43 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40304 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbgFIWQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:16:41 -0400
Received: by mail-il1-f195.google.com with SMTP id t8so12799ilm.7;
        Tue, 09 Jun 2020 15:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HruOJXNprQzgKhLXzCd93zpgfRNmQnSJjwBnz+BudI8=;
        b=JcyIYoLNknxBECIht+ienb5kknH4SC/SEqyfEUHyfJ2dcNyxbRHaWr20Gk88edI7tK
         efWlGhyKqoqEZ2tKgHKBo942Kj9R4D6E/qxOFelBEAVcxcI+EZvIQIaaZtkZ/DsW7TAr
         /94kswYeN7oIMEQy4jzZ1JHSRJP/4g9IcuSdjlFjl1t8gKL6plhin6dkWCo7kaQsHpWx
         pErlLAazut974ewKP7Wxd31I1F9T4BnGlp1iFJGsQ2Y6bcngD4DhoCDbZCBzbcTjGCtp
         lslfKEuIaO29c0ejvZLIWMP/8vJLdf3YVqjnSgRXZje95EOg8lY3VXJq4ewGehw4srzl
         OB0w==
X-Gm-Message-State: AOAM533n/qvPsrnd7A4CDFm/ekb8qr6vhhaKf0HnA07LjYm8y0yIMWyU
        J3BHsn8ml61dabVK3iOJ4A==
X-Google-Smtp-Source: ABdhPJxAnJrMYgVc+eAAIHETuMsUCbED7E10TEuuQQ8zQPSvDsolQeXHPFEBvjiP8mWeD6l+z3EBAA==
X-Received: by 2002:a92:5e4a:: with SMTP id s71mr162660ilb.119.1591740999484;
        Tue, 09 Jun 2020 15:16:39 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id q5sm9448097ile.37.2020.06.09.15.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 15:16:38 -0700 (PDT)
Received: (nullmailer pid 1595211 invoked by uid 1000);
        Tue, 09 Jun 2020 22:16:37 -0000
Date:   Tue, 9 Jun 2020 16:16:37 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 05/14] Documentation: Document msm8992 qcom_scm compatible
Message-ID: <20200609221637.GA1595180@bogus>
References: <20200531172804.256335-1-konradybcio@gmail.com>
 <20200531172804.256335-6-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531172804.256335-6-konradybcio@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 May 2020 19:27:55 +0200, Konrad Dybcio wrote:
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
