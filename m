Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F43FC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC2D20720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HaAgyktY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbgGUX6r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726938AbgGUX6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:58:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC0C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:58:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k1so207596pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GuyDVxBXJ2eH/fhFLNQsFiugfMp6zgAf3tWvMyaED+s=;
        b=HaAgyktYnJOdjm5FRHn5a2ME+0Fd9HVyv0m5tug3+N2yvslrpy2kUqaZrnPLE5PP5J
         +W1u5brVAx92kBbDzk+6zrBBUcNNPgkh7Yuhwl07N9CJU25tAyyf427zq3s7OMTudGMH
         9xd4r4hn/FAIex3VFg1YQUnS+tpDa1SDcwP/OMueE0jBmmByQTwFY6ovbcf5bg9gidev
         6tycNK/hXF7XZ6Ddhqc/Rwdh7puaq/3P2q6jMZKBN4udkoMsKVizjO6WN9H7+6SAv1Hh
         Xjtolx88vxG70K2suFvarVbFLW2TVF2dHuDRl2yX2whEBF6VUdpLrQ3QucfhyNdamySF
         qf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GuyDVxBXJ2eH/fhFLNQsFiugfMp6zgAf3tWvMyaED+s=;
        b=frJzwEL5WGS1Qj2Ul9FLW75jweRw2RcybrKfbabZIEKnn+2weuLJwnJKPIEttZg0v4
         GwH51xhIN6y4C4xdTxfdC0ahPYrzP4pLrdObe/aMjOHHv2GUKIQWX6HL80+JByHt2z+i
         58YGIXy8OJnXLusNKqOU2f/m6MLP8DF6wdarHyoYcolhPoXhx6XtdC5jT02gX4zoK7Lf
         2KNaSLNBzdfkAUwzW4xtP500VKRU3nBHfwvgR2AmPZNge70/Lkq6zgIOSCapWgRM7cfP
         +T+vTd0eHu1SCkULGIhWQyvK5FwVEcE8tCnXZzPjXeDeeXW+5bJlWjC9j4SZ4IwuRj3j
         C2Sg==
X-Gm-Message-State: AOAM533EeQaY8kG+jR6rHmzRmIqCKOdUsYy/xXoF+WiBgsKprw63w9E/
        S3nClWbprLmqzSxtmvIAcL4FCcA1Dno=
X-Google-Smtp-Source: ABdhPJyNuk7PzxMd8B56wIzfsRBCUaRfXZEp3SIsJsCTjayO+IwYE5wac4ySM2zGZNDAQTp1F3brfA==
X-Received: by 2002:a17:902:8ecb:: with SMTP id x11mr18820708plo.123.1595375925125;
        Tue, 21 Jul 2020 16:58:45 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id a2sm21698033pfg.120.2020.07.21.16.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 16:58:44 -0700 (PDT)
Date:   Tue, 21 Jul 2020 16:56:50 -0700
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
Message-ID: <20200721235650.GN388985@builder.lan>
References: <20200704122809.73794-1-konradybcio@gmail.com>
 <20200704130922.GB21333@willie-the-truck>
 <20200705033511.GR388985@builder.lan>
 <CAMS8qEWO-1mNd12Zs-2WogCrgNF5=6RkF=Z1pTeOZxSuKjx+qg@mail.gmail.com>
 <20200721154415.GA5758@jcrouse1-lnx.qualcomm.com>
 <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMS8qEXNh6n9SpMkPAr8cPneasPvJPELD2TZ4gxUf0byxNePbg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 21 Jul 09:20 PDT 2020, Konrad Dybcio wrote:

> >The current
> >focus has been on moving more of the SMMU specific bits into the arm-smmu-qcom
> >implementation [1] and I think that is the right way to go.
> 
> Pardon if I overlooked something obvious, but I can't seem to find a
> clean way for implementing qcom,skip-init in arm-smmu-qcom, as neither
> the arm_smmu_test_smr_masks nor the probe function seem to be
> alterable with arm_smmu_impl. I'm open to your ideas guys.
> 

Is the problem on SDM630 that when you write to SMR/S2CR the device
reboots? Or that when you start writing out the context bank
configuration that trips the display and the device reboots?

Regards,
Bjorn
