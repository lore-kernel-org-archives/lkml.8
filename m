Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05297C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8A55206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kvq6f8Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730571AbgFOO15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgFOO14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:27:56 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4B0C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:27:55 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 190so9430753vsr.9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NA5Q+C11L6DQ4pmHY7GREEaZ06+83jfyPKq24AeqNPE=;
        b=Kvq6f8PxWrOLDqX/SJOwK9g+pcqH+9kWsSu6grgwiFb4WtHOO5D00XIKe1Wnvn3NBA
         HMPqdnFmrQpg61LNuK0RqUpetBBnKIOwI3bjI9pi2wj0qg0YAoNOlv/KxbveXPseRgfn
         yM3Bc6sG93eX1oWcyF6oMsoPkx0PXJbB9enbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NA5Q+C11L6DQ4pmHY7GREEaZ06+83jfyPKq24AeqNPE=;
        b=Aupf5PaYrB7R+ziOqDEmiMSsgxhbGgvnGSXI1fVVeQ8+QWUhXy4AIgoZIMS5Fl0NA3
         R9T+dPf1mfTzOXtaKm5HThw4rdKzULxep0VA3Hw1N5qVDx6lxIbcoaQRxsE63nI/bfPd
         3BCS87H86b+h/wEy70k8Is3vqESpa6A8APBDEVL2St/csZz3/u/Hy6p2dlcDwwfe/YBE
         n9VgDbSl9K5ApJhyVTh9Itqf48HcCUcblRKYeZsATCgrzy1uW+BQzy/8y61XpIWx2Zrl
         OQbwcvVDcjOn5Ig/SnBFd+hH1mHI/1EewW+tr0tmfNkYudRs0zSjJQPkJo/Kl2t8sTzF
         3pXw==
X-Gm-Message-State: AOAM531k0VDS9WU29+JBwXzc45YKSAty9mNcOPCiEAkQ19sCLgviZlAL
        Jyga5FbF/+rz6ahEFDq6Uu/eRqbAPc0=
X-Google-Smtp-Source: ABdhPJzhgGV9+hNMS8kh+n00nReOh6piF14e0I1r3JZGe6eDu//JUWTxAcNxImKUaSyeXY+4MWxxNw==
X-Received: by 2002:a67:db88:: with SMTP id f8mr19186256vsk.165.1592231274568;
        Mon, 15 Jun 2020 07:27:54 -0700 (PDT)
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com. [209.85.222.51])
        by smtp.gmail.com with ESMTPSA id w8sm83180vsk.4.2020.06.15.07.27.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 07:27:53 -0700 (PDT)
Received: by mail-ua1-f51.google.com with SMTP id a10so5732215uan.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 07:27:52 -0700 (PDT)
X-Received: by 2002:ab0:29c1:: with SMTP id i1mr18876877uaq.120.1592231272347;
 Mon, 15 Jun 2020 07:27:52 -0700 (PDT)
MIME-Version: 1.0
References: <1591868882-16553-1-git-send-email-rbokka@codeaurora.org>
 <1591868882-16553-2-git-send-email-rbokka@codeaurora.org> <CAD=FV=WjvAWVmq3fTh=_f2p1Dv+sXg1RV-CqZr8KRgHe8_wT0w@mail.gmail.com>
 <0ee1d7fa-0520-a347-6a55-6ab646284b1a@linaro.org>
In-Reply-To: <0ee1d7fa-0520-a347-6a55-6ab646284b1a@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 15 Jun 2020 07:27:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WGCvQTRHWX4Dvx+pTf010NbEzQMgcV4WDKQ6M8KO-cRw@mail.gmail.com>
Message-ID: <CAD=FV=WGCvQTRHWX4Dvx+pTf010NbEzQMgcV4WDKQ6M8KO-cRw@mail.gmail.com>
Subject: Re: [RFC v2 1/3] dt-bindings: nvmem: Add devicetree bindings for qfprom-efuse
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Ravi Kumar Bokka <rbokka@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        dhavalp@codeaurora.org, mturney@codeaurora.org,
        sparate@codeaurora.org, c_rbokka@codeaurora.org,
        mkurumel@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jun 15, 2020 at 3:44 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> >> +properties:
> >> +  compatible:
> >> +    enum:
> >> +      - qcom,qfprom
> >
> > As per discussion in patch #1, I believe SoC compatible should be here
> > too in case it is ever needed.  This is standard practice for dts
> > files for IP blocks embedded in an SoC.  AKA, this should be:
> >
> >      items:
> >        - enum:
> >            - qcom,apq8064-qfprom
> >            - qcom,apq8084-qfprom
> >            - qcom,msm8974-qfprom
> >            - qcom,msm8916-qfprom
> >            - qcom,msm8996-qfprom
> >            - qcom,msm8998-qfprom
> >            - qcom,qcs404-qfprom
> >            - qcom,sc7180-qfprom
> >            - qcom,sdm845-qfprom
>
>
> Above is not required for now in this patchset, as we can attach data at
> runtime specific to version of the qfprom.
>
> This can be added when required!

I'm OK with leaving off for this patchset.  After we get everything
landed for blowing fuses then I can send out a separate patch where we
can debate the merits of adding the SoC-specific compatible strings.
:-)  Sound good?

-Doug
