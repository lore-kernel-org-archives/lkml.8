Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F87DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C3C22465A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:52:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oE18UWg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgCCIw2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:52:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38718 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgCCIw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:52:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id w1so2594647ljh.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 00:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qP4l3miEhOsGvhCQGfIOAAIiSzN77+8PwgJ0ybST1SE=;
        b=oE18UWg7uB5RWxPJuwXndW24hkOzqPIoL99H1Qv9tUnv8DHc3rMf1f0zZcReU+suxK
         MR3AxZ4g8LYDpIwSSwwuNXt2h/5wYtIXq/9ywWs48ntVpfmob3K2z9XKR1NyTe1DcdLJ
         rWIBVGOFRVEFBss2E+R8lG/26kUA5GJeIvCB//3pCq1aUo5U4cTt2ro7DlsZfdmSYnyp
         GwWVvc3Q+29uTT6yUq/mZIPEa9uNGTtxNw53PeUQ/X8+EwfZ18BFtQXOXqXl7p56vxsd
         3NfHITA92j/M9QzGVcq03JDG80DEYjMdRSOBePH0vVPAT06WR+Rv3flSq7igtB5TlvQD
         BIPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qP4l3miEhOsGvhCQGfIOAAIiSzN77+8PwgJ0ybST1SE=;
        b=Uy4virVhbxhdzt4CJPVmf8PdyYS5rjYg1uyYXg9Yz3OHIZXui6o1QNtJJWvl+ZEWTA
         lHlAlQTTtak78DoqQkYvThLHu50bFN99ILMxb62vREFCf1Gudayn1K4vBLkiukDyXy9j
         HK6cAy+cGyNvJXH2UaTnDfKpXuFq6nSpa0EJWHvDArw8yTFJ/8cvFLaucReLO1HSGlZy
         4zZLy7VIx8AJS2/+YOMJ8g+8asicpqKcY5LHfZiGOUw+6zzwUsRbT2BpebI1VNKtrd4g
         sHW7h2ZcWp7mHslA97UW4pZ/C2UP7Juu0CqjmvnP2OY3zffIii1XV5v2typdewrIyxHs
         Psww==
X-Gm-Message-State: ANhLgQ1zN7RxSP3lGFuQZBzyP4M27hPpGZeOSO4onByy6SbCZ73WQm9w
        P8EDdQ+rdq9UqUT5GvRUrvMrPyR5HeFQCf+9Jdjzdw==
X-Google-Smtp-Source: ADFU+vs8vnVGsuXNBfltlkRNIaMr26/HznbXiZTa8hZpumUN/ioJsPKL3uAefOfYGMsXkzIw0k0q1oJs8IuresWlrLc=
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr1754799ljk.13.1583225545328;
 Tue, 03 Mar 2020 00:52:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1582871139.git.amit.kucheria@linaro.org>
 <8309e39737c480b0835454cbc6db345c5a27ecd4.1582871139.git.amit.kucheria@linaro.org>
 <a3903db0-302d-a0f3-0515-b248e24e19cd@linaro.org>
In-Reply-To: <a3903db0-302d-a0f3-0515-b248e24e19cd@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Tue, 3 Mar 2020 14:22:14 +0530
Message-ID: <CAP245DWhzOHBrQNhqMjVC2+8i-P8bkuM3w8bCSqGfjWemR5WvQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: thermal: tsens: Add entry for sc7180
 tsens to binding
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
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

On Tue, Mar 3, 2020 at 1:35 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/02/2020 07:32, Amit Kucheria wrote:
>
> [ ... ]
>
> > diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > index eef13b9446a8..13e294328932 100644
> > --- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > +++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
> > @@ -39,6 +39,7 @@ properties:
> >                - qcom,msm8996-tsens
> >                - qcom,msm8998-tsens
> >                - qcom,sdm845-tsens
> > +              - qcom,sc7180-tsens
>
> This change is already done by
>
> https://patchwork.kernel.org/patch/11319259/
>
> I've applied it.

Good catch! I'd forgotten I'd even reviewed it when I saw all these
warnings with dtbs_check :-)
