Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A05C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E300820CC7
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BfQG+oTC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgA3SY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:24:59 -0500
Received: from mail-ua1-f67.google.com ([209.85.222.67]:33950 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729503AbgA3SY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:24:58 -0500
Received: by mail-ua1-f67.google.com with SMTP id 1so1552946uao.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CJPY+g/XzCm6UWO3D8mKRxGxfTcXSUIYOUXNI4GNTD8=;
        b=BfQG+oTCMVxlg4wY8DUnH37t9rAIzLS4W4kBKdZBWR+QzaPeVDDSBBXOCM5jcqS184
         7z/yo+l0hDOZzpC2ERgZFxmFpmjwHGcZ8UyGlvlgloFIb0V9DTOjRoWcGbjeL6/SP5o6
         5UvCzcjJvRoIprtS7ojhc5t5+b4RMuK+mt/xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CJPY+g/XzCm6UWO3D8mKRxGxfTcXSUIYOUXNI4GNTD8=;
        b=XHgM4W5Q30ZSXkPL8arO8X3epuCU/8ErOTZRQFJ1IzOD6yriD/Y/ESg0VNJ0gjYV9s
         naQz7dpLqTHpvfsjWZleOZxtxSIGIss61Juc5k9T1NoaWv13DduN+tKtpnREru6plQcz
         7t9s1jNlMMieLhm/HrJjMYonBi9VGczw+u/ZeP6GleKbCZ5bQAzulJMo4vvvSLsd5a6m
         2OWhvcULVPIFgNrjQURU+ADnIECQXcK3WOFTp16DiLifawvbbLrySR5mHoprzndg6LPD
         gQxaHdKTLRVMYH26ym0McZoBpTimo6oOKZokJBvIcPKZbamd4aU7Buai/U1xtt0AkKzo
         cYFA==
X-Gm-Message-State: APjAAAU2B5I2fiI1cxHhAKG4tcHp6N4tlJTGif65nT3u7oOCHrJLZqqa
        qsAOnNFZIAC4/rZfba5qTMNjPFUT7zs=
X-Google-Smtp-Source: APXvYqxu9P4udUCmXH1vnDv0k1vViEGZ/BkEGsD+j/Ikg55Io6SCThEZ1VrdXKXfREb4D2HRKbzQjA==
X-Received: by 2002:ab0:3742:: with SMTP id i2mr3353252uat.132.1580408697634;
        Thu, 30 Jan 2020 10:24:57 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id q189sm1766692vkh.44.2020.01.30.10.24.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jan 2020 10:24:57 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id h32so1538647uah.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 10:24:57 -0800 (PST)
X-Received: by 2002:ab0:254e:: with SMTP id l14mr3487338uan.91.1580408268842;
 Thu, 30 Jan 2020 10:17:48 -0800 (PST)
MIME-Version: 1.0
References: <20200129152458.v2.1.I4452dc951d7556ede422835268742b25a18b356b@changeid>
 <20200130180404.6771A2083E@mail.kernel.org>
In-Reply-To: <20200130180404.6771A2083E@mail.kernel.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 30 Jan 2020 10:17:37 -0800
X-Gmail-Original-Message-ID: <CAD=FV=Xvw+oA70+JG-5wMy+0v5M324idQRJsujVbNnBtEF2gvQ@mail.gmail.com>
Message-ID: <CAD=FV=Xvw+oA70+JG-5wMy+0v5M324idQRJsujVbNnBtEF2gvQ@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: clk: qcom: Fix self-validation, split,
 and clean cruft
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Taniya Das <tdas@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Abhishek Sahu <absahu@codeaurora.org>, sivaprak@codeaurora.org,
        anusharao@codeaurora.org, Sricharan <sricharan@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 30, 2020 at 10:04 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> > Misc cleanups as part of this patch:
> > - sm8150 was claimed to be same set of clocks as sc7180, but driver
> >   and dts appear to say that "bi_tcxo_ao" doesn't exist.  Fixed.
>
> Someone will probably want to change this at some point.

I have no insight into sm8150, but I guess I assumed that since it
wasn't in the driver that maybe sm8150 just doesnt have this hookup?
I'm happy to add it back in.


> > +description:
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains on APQ8064.
>
> It would be great if this could also point to the
> include/dt-bindings/clock/qcom,apq8064.h file here. If you don't resend
> this patch then I will try to remember to make this addition to the
> binding docs.

You're saying that the top-level description for all these should
point to the header file?  Seems line a sane idea.  I guess we'd need
to do that for all of them?  I could spin with that if you want, but
we could also do a follow-up patch?

-Doug
