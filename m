Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 213FEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF69A206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pUlRLM/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbgGIO2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgGIO2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:28:53 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BED1C08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 07:28:53 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so897189plm.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 07:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HWC78hpJQQDCeHA6IuilFEneJMSNBCuYQgG09IJpy9s=;
        b=pUlRLM/GeGFm+ciW2dDWqMTNeSAi+EfSiV9WiHR0x0tV4bi54L9WkTBO6dlp+YfGAM
         kbp3sjr986yeTK91dFmwiESmK5roKf3zaySaS6xAcxrs4xnZfgqRZTKcD03Iz6AWv1TR
         OrcmG09LtnRRAO0BSTfqwA8VUmPeoFsSCb7i7VlY9Xc2HQE8ho6s3sgEIW5CRUK9Ijca
         5srPrm++J4nSrkaPgy32pJsX+F1ND+DPR76o5JQVvEegUhRh/KNvCe03Rll6HaUm2b6N
         sDxYW1fd0fXkNtex6LG55EjJtiYmN+G9YEdA0+/0vSd1vhrTgqAeD4/g2HlyHJdjsCFV
         GNog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HWC78hpJQQDCeHA6IuilFEneJMSNBCuYQgG09IJpy9s=;
        b=Kxz57yuTCSIPH6Z/RsFoDwQ7BuwMsfqINsLX//whmYZJYDmj0lC1wSKNePlYKqLfRx
         qIuD+XE8c3d21LmlvGUdxYkHe6jiYjDhiecmOghSDB8N5dZXu2PvEAOWLRlB9RJ2GtTO
         s124AsEqTyeqbXC8K6Rbtky1Jr5d5GAe0Mt7Mp5O8VqDav7qkQAFma7zZqfACmEGYXBV
         Tr5Oi32OgQMTT/uW0OAaxIhce96Vx93QRMJn3VgugnD3NhxMtj6ii+hT6gqd87LI6lG6
         sCS84VNcBGIDXtf1j3xMQfnt8Cm2M7FICyhzcYDHuW/SgAcvFpZj1VKouga+Ym85+wE6
         RozA==
X-Gm-Message-State: AOAM530hL3+0iIf+xktautk4BYJOt6xrrz+/aAMDQqvjiqmkj2ivqxy0
        zRQIIyf/w4Usz+DJ/kVv8FGmSQ==
X-Google-Smtp-Source: ABdhPJx97HWjYNHwiwwN3GUeiKldr7LAIlxI7ISxb8HW+KyBLZ+xDyPE49kRA2Vi7Iz0sTwD1sKmwQ==
X-Received: by 2002:a17:90a:9d84:: with SMTP id k4mr246096pjp.227.1594304932578;
        Thu, 09 Jul 2020 07:28:52 -0700 (PDT)
Received: from ripper (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id x10sm2898644pgp.47.2020.07.09.07.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 07:28:51 -0700 (PDT)
Date:   Thu, 9 Jul 2020 07:29:18 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, georgi.djakov@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        saravanak@google.com, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        robdclark@chromium.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add cpu OPP tables
Message-ID: <20200709142918.GA3521288@ripper>
References: <20200702204643.25785-1-sibis@codeaurora.org>
 <a61c5656-e21f-f071-1149-a3357fe2684e@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a61c5656-e21f-f071-1149-a3357fe2684e@kali.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08 Jul 19:22 PDT 2020, Steev Klimaszewski wrote:

> 
> On 7/2/20 3:46 PM, Sibi Sankar wrote:
> > Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 SoCs.
> >
> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > ---
> 
> 
> Hi Sibi,
> 
> 
> Bjorn asked me to give this patch a whirl, and I have to say, I like it
> but I'm not sure if I'm missing a dependency somewhere...
> 
> 
> In 5.8.0-rc4, I'm seeing a couple probe defers
> 
> [    0.131341] cpu cpu0: _allocate_opp_table: Error finding interconnect
> paths: -517
> 
> [    0.132694] cpu cpu4: _allocate_opp_table: Error finding interconnect
> paths: -517
> 
> And then a bit later on,
> 
> [    0.625837] cpu cpu0: failed to get clock: -2
> 
> 
> If these aren't anything to worry about, you can throw my Tested-by on
> 
> Tested-by: Steev Klimaszewski <steev@kali.org>
> 

You need to enable:
CONFIG_INTERCONNECT=y
CONFIG_INTERCONNECT_QCOM=y
CONFIG_INTERCONNECT_QCOM_OSM_L3=m
CONFIG_INTERCONNECT_QCOM_SDM845=m

With this I can see the interconnect_summary in debugfs change with the
CPU frequency.

Regards,
Bjorn
