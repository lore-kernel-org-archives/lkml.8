Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBF9C55192
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F9972073A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ISQ55rpH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgDXEPB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgDXEPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:15:01 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CAC09B047
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:14:59 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m18so10192764otq.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNeKWP0wVVfHdvI2+GMr4lo7jLpNJp6SXOmf25ATHxg=;
        b=ISQ55rpHtbLZWNBGVYOXEiLHbR5pvj+D+zK8Y3PA2yQf4kJxoU6V2GjCj1e1UqHgIJ
         3962XuymntrbY9qOPUILjH6Dx/DkugOIU5QJNu85Krl0702HsDkr2HSlcIemnmF01jHJ
         WGTrcdZW3AwCbIuoO0eu9W+vrKY3pddkXjIlqN6RzcxDM7NhtFjjg7xgOzQe4aW6Ui9Q
         FRp3mttrtVpagGThU/dfrsG6mstBUrvmaWAM2Q95tgFnchoggwMBIL0DyE7vWkzPItKE
         9CXZF6Qo7jlgzgvMU8I8hRnh76itJeU/QF4mMvWKLWeVpKRqmVKYwVvmfW4k2KEOA8Z4
         g/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNeKWP0wVVfHdvI2+GMr4lo7jLpNJp6SXOmf25ATHxg=;
        b=ZMlbFEr4tpeL7B4Rk5DlIR1+jvVGz7XinxFWV97/AxUYANhDY/BMAHAAITgjYvUnJP
         JPpvMjVYmiAHhwi52P+Vd6trFAVzP6wwJJJbslmzfNCxj0oa3cVb6TdZ12snpUPxLDze
         Yo5uDQyusnFK6/0/Dq4gUMbGyawxgIb8FDqc+/rhov/vNEAY7mP6O7/sygV5niXqT3q6
         EEJttX5JsG2eZYKHOOynvllMLvkEF3B1SXY5I3Xmt5m2Gh55IuZy23J5eJXExtcidu1e
         vaOt/u8A/PQ3FmuJjrQattsuYQIM3mhC+FM5BTGJjS/0HLsP+uutZo1u0sQJvmekejnF
         URVg==
X-Gm-Message-State: AGi0Pub+dur7HP+79MrP1ugPUVFsnKe4s+S1+LKm02oDn5FNbXyqHUrg
        yQZLY65wRbFoiS/SxGbgsRTuT4y5KOD+BswH0siIFw==
X-Google-Smtp-Source: APiQypJnPanMwbARQX4Hfircqy0s3DCPTIopnJmsul/liN7lTudNu6VrdEx/D3Q3Iw+xpQYXZpHdyV5PmViGWlGfRw0=
X-Received: by 2002:a54:4f02:: with SMTP id e2mr5867574oiy.10.1587701698779;
 Thu, 23 Apr 2020 21:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200421041815.1808-1-john.stultz@linaro.org> <CALAqxLUHLqoYAZRvF1HjHhOJPdztYh9oz=L0kEuYun7y6fBzGA@mail.gmail.com>
 <62be69b1-8349-aa16-b5d6-dcacbc4eb05c@ti.com>
In-Reply-To: <62be69b1-8349-aa16-b5d6-dcacbc4eb05c@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 21:14:48 -0700
Message-ID: <CALAqxLX4_gi6mo_HRhRUQvC0stXf4ya3aa1VOPqDdpV8_37iww@mail.gmail.com>
Subject: Re: [RESEND x2][PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy"
 compat string
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Doug Anderson <dianders@chromium.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 9:07 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On 4/24/2020 9:35 AM, John Stultz wrote:
> > On Mon, Apr 20, 2020 at 9:18 PM John Stultz <john.stultz@linaro.org> wrote:
> >>
> >> This patch fixes a regression in 5.7-rc1+
> >>
> >> In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
> >> PHY support"), the change was made to add "qcom,qusb2-v2-phy"
> >> as a generic compat string. However the change also removed
> >> the "qcom,sdm845-qusb2-phy" compat string, which is documented
> >> in the binding and already in use.
> >>
> >> This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
> >> which allows the driver to continue to work with existing dts
> >> entries such as found on the db845c.
> >
> > I hate to be a bother on this, but I'd really like to see this
> > regression resolved.  This fix missed rc1 and rc2, and it would be a
> > shame to miss rc3 too.
> >
> > Do I have the right folks on the cc for this?
>
> Yes, I'll be merging this. Sorry for the delay.

Thanks so much, sorry to be a nag! I was just worried it was slipping through.

thanks again!
-john
