Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AF7C433E6
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2BC620757
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 15:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598799626;
	bh=5MuDOvLpN2j2GGFm+ogmqEiGuZETh0tPb0fLz8lHFtw=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=eysSytYYsq4etBuswQONVEsi0aP7HjgscFLJ9IzUoTHlo8/qqkijjpnKsIrN6fYMC
	 iHgpvy1OSZZ0zfNdSDnoZDcyFU4qYS0bgmYf19WX2zMP5gPQiRdfVCzos66y6kHLDt
	 M/UekIEBbDe8ofSRvJt4dFX69henWR6YNY6BoF04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgH3PAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 11:00:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33295 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726264AbgH3PAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 11:00:17 -0400
Received: by mail-ed1-f65.google.com with SMTP id w14so3236466eds.0;
        Sun, 30 Aug 2020 08:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8f10Pn0g1AkB3s/S4iP1tBrGAB+OycQ7IuFHYDJH2OI=;
        b=mAQr9ZNCXJhsxI1eg501IMDyK9GD3lKNsRU3ltIuwajAzKetInZ9glJHUh3FHly/Fw
         UksQLRqMp8+EmJURMaWBRaAktClvDqtKyEL7ukDhvSzQj6YooEmGAbfj8MpEXfLb810P
         QRkhuZYqF6p3DdLYD2NMT5xHEAKCbLtJ1RN6tINrNEIuZeb9nDsbbftcTa0s7NpqufCW
         7gAE25z2Z6lkU3H4HRpzVtZiMzytsnklxXyTv8p8vYjkPB+UuY7+tMye3oj6+aHc1Azb
         yq+3JTYN3Rvi05JcL5FMtSvLrj+RR1yswgDOhavKdCWS/WJPY9LVpduz1iHQ3lPFnn76
         1Taw==
X-Gm-Message-State: AOAM531EwCKMPirRxPcunAle46UkK2vYUGxtxxUDym53lnLN7ZJcUfv1
        nA8z8WFRZOVVzsgxhCKZ6Ag=
X-Google-Smtp-Source: ABdhPJwDIFgs7QFDh3dvTWrjd4AwOLqNbWFJ/ReTtIGnvRW8SBiMV+ERpeOi0oZ6qh6q2yyJtm2ATw==
X-Received: by 2002:a50:a6d1:: with SMTP id f17mr7753345edc.379.1598799614832;
        Sun, 30 Aug 2020 08:00:14 -0700 (PDT)
Received: from kozik-lap ([194.230.155.216])
        by smtp.googlemail.com with ESMTPSA id cf7sm2637445edb.78.2020.08.30.08.00.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 08:00:14 -0700 (PDT)
Date:   Sun, 30 Aug 2020 17:00:11 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Barry Song <baohua@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RESEND PATCH 5/5] ARM: dts: zx: Align L2 cache-controller
 nodename with dtschema
Message-ID: <20200830150011.GE31461@kozik-lap>
References: <20200819175853.21492-1-krzk@kernel.org>
 <20200819175853.21492-5-krzk@kernel.org>
 <20200820093010.GA15884@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820093010.GA15884@kozik-lap>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:30:10AM +0200, Krzysztof Kozlowski wrote:
> On Wed, Aug 19, 2020 at 07:58:53PM +0200, Krzysztof Kozlowski wrote:
> > Fix dtschema validator warnings like:
> >     l2-cache-controller@c00000: $nodename:0:
> >         'l2-cache-controller@c00000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> 
> I forgot to add the tag from Jun provided on previous submission:
> Reviewed-by: Jun Nie <jun.nie@linaro.org>
> 
> Best regards,
> Krzysztof
> 

Hi,

Ping, any comments here? Can anyone pick it up?

Best regards,
Krzysztof
