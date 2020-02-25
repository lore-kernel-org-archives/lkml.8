Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200A8C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EADC32084E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 12:06:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sAPoYCpP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730388AbgBYMGy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 07:06:54 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35693 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgBYMGy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 07:06:54 -0500
Received: by mail-lf1-f68.google.com with SMTP id z9so1367862lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 04:06:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qL37Y4QwC2H5BVQcBjGxnhk5Q0ixQAlzjLOKjSRSjzg=;
        b=sAPoYCpPeqNu1VtPX1gXiQd8dXC9Ud2kT4nsPsqkPjP3zT0K32Y/IeK8JfXh4BF3lr
         jkwYdlfWZcPTDjrbWeWEh40nPgt+T4+MmNrd5i4YpaaUuJbjXprQyie7WiLLWVLFI612
         vbcV8uCfmIUI7JIY0nhk7p2ChzdllK/kao+L+oCjBRyTGOTcX9bAcO4OVnYTeHRis5oB
         ELDgUbJn4tdo9imAGxWaOWsdEsvshYK0XFKDf36phutEiWJda7cdLhBXYMFC1WeE8PbK
         rCZH4JLpQY/MDgFCrCAY8ibiVOREbl4XByl7pwe4wXdFMsCecj5eoeq/tSHCk4PmtLSK
         q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL37Y4QwC2H5BVQcBjGxnhk5Q0ixQAlzjLOKjSRSjzg=;
        b=JwL7Jjfq/7aL1Qh2xYm/cEyQfMPf9Hc+JsUhLN5UYJ8cr/MRX5uiClfGRU/9USoh+8
         U+i2IGQLiC6vdWk7tTKuvKhd3nETfWD1BQnN0kEDlObJzucYaT8P7571wQwhEGgTKx4v
         u8F2Tp+m8BBZC3zPraJ/0fEyy5QHBJcrcmUUZpEcK8l/cjIvBaxH2pewArqZ7i+pS6iq
         saMoF8oplF8wm3p5z8Vms4FPf6ak9cBFALRS1V/idB93skyMMtbDZdtmHQw0maWuBwnm
         lMPwPyHSIKbG45up7u52skiYwwlaUlvXmawsCbx5bWRV4+dP4gCK3m/8hMjLwiwEeQJm
         wlcA==
X-Gm-Message-State: APjAAAU76Y+EiOJ/a3zmklzE7Wk2bF9N8MARjAukVO6y3egil8LjLAkQ
        wY3Xl/lPb9EKtD/ne9nle9L7GHrAwSe2cbkmBMM7NA==
X-Google-Smtp-Source: APXvYqx4hD9HaTlSuNdaASWszKdhnnTGw4UdpRdVSDuvLrBOJV88/DSZ6LkAIwOgsPHB/a0L3ZRa+lZx6hi8twr3z8I=
X-Received: by 2002:ac2:5a05:: with SMTP id q5mr6326196lfn.143.1582632411863;
 Tue, 25 Feb 2020 04:06:51 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582615616.git.amit.kucheria@linaro.org>
 <0f506cfdd8eb9d50b5eb43c9dca510284ac8ded1.1582615616.git.amit.kucheria@linaro.org>
 <20200225101614.GN2618@vkoul-mobl>
In-Reply-To: <20200225101614.GN2618@vkoul-mobl>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 25 Feb 2020 17:36:40 +0530
Message-ID: <CAP245DUh2zZA=pfhoYswuffdR1_p72QR73SdWJCH8w8XySFpvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] dt-bindings: thermal: tsens: Make dtbs_check pass
 for sc7180 tsens
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        sivaa@codeaurora.org, Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 3:46 PM Vinod Koul <vkoul@kernel.org> wrote:
>
> On 25-02-20, 13:01, Amit Kucheria wrote:
> > Fixes the following warnings:
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible: ['qcom,sc7180-tsens',
> > 'qcom,tsens-v2'] is not valid under any of the given schemas (Possible
> > causes of the failure):
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> > ['qcom,msm8916-tsens', 'qcom,msm8974-tsens']
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> > ['qcom,msm8976-tsens', 'qcom,qcs404-tsens']
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:0: 'qcom,sc7180-tsens' is not one of
> > ['qcom,msm8996-tsens', 'qcom,msm8998-tsens', 'qcom,sdm845-tsens']
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:1: 'qcom,tsens-v0_1' was expected
> > builds/arch/arm64/boot/dts/qcom/sc7180-idp.dt.yaml:
> > thermal-sensor@c263000: compatible:1: 'qcom,tsens-v1' was expected
>
> I think the patch title should be "add qcom,sc7180-tsens to  qcom-tsens.yaml"
>
> and it would be great to see explanation on how adding it fixes these
> warns.

Agreed. I'll send out a new version with the commit messages fixed.

> Relooking at series I think this applies to rest of the series too :)
>

Thanks for the review.
