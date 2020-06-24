Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A020CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72868206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTruSnbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389241AbgFXGmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388360AbgFXGmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:42:54 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA440C061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:42:54 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j1so714442pfe.4
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 23:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tj0+81OU8cxNaHayJ+mmXmO7Wvd4r9c8QxGXifG1n9Y=;
        b=UTruSnbrMSy7HPcjG2EqSPJ5bg9XDfYYee9/v77xhD9Fu66HCiLBkfJy63S+lBc99T
         54/cezpIKfy3s6gyjrJDYFaKrKnwlQQEzl/1TZz+JQjKsJyAngBK6l681EaVDerSExFt
         88c2BaKe5pRRfG1wcqldTriuqGqRYKVC10oS25CXVi46Q0ZcMJx/FtgsBPReiCWBAOZ2
         9DCu5vWuZT0vMQwDOHRRvCWu9FjgrzpXVl/9qC+hUex9JDm0xqsu6fzS+gw5ejrfMQN8
         0fiAKZJz8ytUOriMX+O48kLvFLHwc727rYM2QzuCRpSXeSlSObAFzwDU0+qM9oVe5NNa
         fTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tj0+81OU8cxNaHayJ+mmXmO7Wvd4r9c8QxGXifG1n9Y=;
        b=lWr6Ph1F3qHq+xtRQyfJUVb/Rp4C2NolE9gENJk6FPnWzGgJpV+2Gybtsq9yGvbhVF
         z6b0FQ8+lEk5alrMjbViCXTLO5L/SJBqppY3l1x7C1HnKWgarKNP367c/NrxRLIJ0ty4
         6U5LRenFISC0KRoXAfGMUrvs9jN8K7ET8he2c4HdQq7Y3Qd3DYY6Sc49pCyefkLk+SAT
         7cjTTlYpogbhzD66VKXRq3iO0PK0jdL1VPEh8QVDqKcLUzCiS61w0hZzJIIGL4Ta9Iny
         xuKmPqD8O2SIvI8OeBxfOmCT5dSF8dqB9wwb9jBVXDlV8JglnfF40kORLNGjt/79TMlX
         qqvg==
X-Gm-Message-State: AOAM531Ic3gs+cI/J8Ymqkihf6m102bSRZ0sv4FxyoVvfWl0+ogsoVf2
        FQ6xd9hGxLnvI8VqCi3cXKHXhw==
X-Google-Smtp-Source: ABdhPJyLAa86tYAyEj6sHwS099W3IjsyooK7AqBRLX7K4JauXP05JDgN7rvIqaPNaU/8hbO/PkifOg==
X-Received: by 2002:a05:6a00:2b4:: with SMTP id q20mr2225873pfs.74.1592980974097;
        Tue, 23 Jun 2020 23:42:54 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id o22sm18800222pfd.114.2020.06.23.23.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 23:42:53 -0700 (PDT)
Date:   Tue, 23 Jun 2020 23:40:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     skrzynka@konradybcio.pl, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/12] arm64: dts: qcom: msm8994: Add support for SMD
 RPM
Message-ID: <20200624064011.GS128451@builder.lan>
References: <20200623224813.297077-1-konradybcio@gmail.com>
 <20200623224813.297077-5-konradybcio@gmail.com>
 <20200623231541.GH128451@builder.lan>
 <CAMS8qEV9hwL1MpEHzVC+w2rkQhdZ1aH3Dy8Mn1X_2Eu7W2naWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMS8qEV9hwL1MpEHzVC+w2rkQhdZ1aH3Dy8Mn1X_2Eu7W2naWA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23 Jun 16:34 PDT 2020, Konrad Dybcio wrote:

> Thanks for your review.
> 
> I will send the regulators/rpm patch very soon.
> 
> Regarding the mbox, do you know whether it should include any clocks
> on 8992/4? What comes to my head is a53/57pll, but that's not there yet..
> So perhaps I should just add it with .clk_name = NULL?
> 

I don't remember how the clocks are controlled on this platform, so my
suggestion is that you just skip that for now.

Regards,
Bjorn
