Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63A0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EE12084D
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 05:52:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T+HPx65f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731276AbgGaFwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 01:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730644AbgGaFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 01:52:38 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B43C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:52:38 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id e4so3119752pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 22:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Is9oz0WcdC4oayT0KXurF1vgNIwYI6FKERnV58px2yQ=;
        b=T+HPx65fgNudEBURjrQX4qo0u8tnu0dj3iDP1cV+BTCL8y/j4LUor93lChMKi1Jsk+
         vdg9mhmNbqrhL9/udDjUihbN5Bolx1RV8wDqTi5lomByyhQ8dJ4yBgxcielqGHS62Ea7
         rx9xxs5NmTukhbJaOzLTmx/OknOZlhE1tHBWwB0Bi45k68GIGqA7DH65mPwxMsc4OJIe
         GvZvqU28Mnpfeynbn4fyApxImnpsNCDKfN78nVugs8mWGW0rEHNnd0a/vN0NvkpDtyU4
         nrKtl3z8E6o8rnS8LVFBrZh2yKKD006qOH/vwY4THo3iltRqVVrYWuUafHyOnmLnzuIE
         xRyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Is9oz0WcdC4oayT0KXurF1vgNIwYI6FKERnV58px2yQ=;
        b=ddXpIb5X8EQPDEFeMw7UbbclpBvslCbrUjYmrbP2Fh/98a5ZStYeHTlwI5VRs+86DR
         VXszRjCSnE3MTo3onqXON9RsiY8jHa7gnPrWE357aYlqeaszwi9NzyKST9L0gU5z/GeB
         +tZtmCLTeDAaktmq5HZdLOjVBWkHk2I3iEGYUgOx6h+CeswVym7ipAm6vnlgdM/2zzvL
         E94hTwjiv+u9xMUeyz+Xq3+xQr48wqpahyjYPSrcz6Qi6C9rxtPF5gQS7Ms5kF/gXseA
         wo6D1W3j0PrK3+cShYiYLZq3GUtTullIBvPA7Q5XiNANctDTVO6FuUJo8sJEBuXtTD2U
         bXRw==
X-Gm-Message-State: AOAM531+q2+qhHMFxsgJf7YJ0cXPsngF7GhCABHJgwb5MfpQBZz/II56
        spFZdYfkj/NOiB8dPzhpmZaWpw==
X-Google-Smtp-Source: ABdhPJwx3vBThEbfSeGBoL9hNvNZyU1Q4RNIGLqBu9j0WBIoW6X1bMtfz0R1dAPxFdWb26AAhctwbQ==
X-Received: by 2002:a17:90a:fd82:: with SMTP id cx2mr2664842pjb.67.1596174757993;
        Thu, 30 Jul 2020 22:52:37 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id k6sm4360389pfp.87.2020.07.30.22.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 22:52:37 -0700 (PDT)
Date:   Thu, 30 Jul 2020 22:48:50 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     Will Deacon <will@kernel.org>, skrzynka@konradybcio.pl,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu: Implement qcom,skip-init
Message-ID: <20200731054850.GA20825@builder.lan>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
 <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
 <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
 <20200721235650.GN388985@builder.lan>
 <CAMS8qEVXGddTdbrPwK3NJMx71HH0hoVyqiJG6-g9tiBRMRYZ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMS8qEVXGddTdbrPwK3NJMx71HH0hoVyqiJG6-g9tiBRMRYZ8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jul 13:11 PDT 2020, Konrad Dybcio wrote:

> >Is the problem on SDM630 that when you write to SMR/S2CR the device
> >reboots? Or that when you start writing out the context bank
> >configuration that trips the display and the device reboots?
> 
> I added some debug prints and the phone hangs after reaching the
> seventh CB (with i=6) at
> 
> arm_smmu_cb_write(smmu, i, ARM_SMMU_CB_FSR, ARM_SMMU_FSR_FAULT);
> 
> line in arm_smmu_device_reset.
> 

Sounds like things are progressing nicely for a while there, presumably
until the next time the display is being refreshed.

Would you be willing to try out the following work in progress:
https://lore.kernel.org/linux-arm-msm/20200717001619.325317-1-bjorn.andersson@linaro.org/

You need to adjust drivers/iommu/arm-smmu-impl.c so that
arm_smmu_impl_init() will invoke qcom_smmu_impl_init() as it spots your
apps smmu.

Regards,
Bjorn
