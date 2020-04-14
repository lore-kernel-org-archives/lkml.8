Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E2FC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D177E206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 23:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uXq1gtTU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634458AbgDNXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 19:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2634436AbgDNXwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 19:52:43 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828BDC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:52:43 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x3so702773pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 16:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nsE/zPXLukbuT4tup7W97Wf9aeYqGS/dqAMllkUu/1M=;
        b=uXq1gtTUfkD0AFtaHQlj7XCYPYGPnOr2CgQvVRpjgEsqAySk6Bpqim74UBRthkvnGy
         kgHbDE6DCPM9mVLAH2viG7iS46J2yUYEd4mwoDiSnqR+rvcL741YKWoGcLJLLT75XA8Q
         f23PdawgWpb/bviXrYM8lWscOc55S8nCby/sRYKQnQv4Ylfkvl+kNacj06euID9IURhk
         U9JCyfik93Rz1UWqRbp538F2CpzNrMu/Wn0YJVsPIg9lXhd0crtf2ScJkcH9DdWEEcQc
         19c4yEXh0HQnkXlX6rny7Qv2+OUf8RJBb1tr7IhezNL/Lu0lNa9x2SrbUtl7ZkuF5g5z
         1KIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nsE/zPXLukbuT4tup7W97Wf9aeYqGS/dqAMllkUu/1M=;
        b=PSISFkd+OFEQw6mS5HzPXOxgC0ugVPzkqdoCoMJne1fU3zpw97mGQ7bR3aCBoCzkg/
         vTcmgHEt96ct34QOW+VZuZDkAbt9yTxXnEej/s5xC04w6WDtyx8zI9Usp7JHNM+3YMlP
         I41oFfzkUKmVXSw4VuL1R9A/G9Qx62cfve/ngw+Pi3O7QAbynccAcFWYs2hZFNsSdUdG
         IJufBUcsmgD6VCZEUVUYnQyc5JuPsYsjZ2yGciBFDzex7hKlxCvXvyaQ5uPYacrgWvID
         +l7NgP0IuxFjotawZ+qvL8M39Wo2W9XqLzCoKsPOD/dkvE+dzULI+XTZF/AgLOI/Z9Ve
         r8Yg==
X-Gm-Message-State: AGi0PuZADEXXbchy1OrC4d5+8xKOckts91t2YBDScZVt0dYelqJWft2R
        OUigch8b5waiacCHKUw4d+7/og==
X-Google-Smtp-Source: APiQypI4FTZH+v2mWi0AaGiBlFnDQl7dE0xr+3sTy7dgwpo0dC93JROHj3vczfWR9tFYefOxybVgjQ==
X-Received: by 2002:a62:5289:: with SMTP id g131mr24254719pfb.210.1586908362831;
        Tue, 14 Apr 2020 16:52:42 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id d18sm2476595pfq.177.2020.04.14.16.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 16:52:41 -0700 (PDT)
Date:   Tue, 14 Apr 2020 16:52:39 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Subject: Re: [RESEND][PATCH v2] phy: qcom-qusb2: Re add
 "qcom,sdm845-qusb2-phy" compat string
Message-ID: <20200414235239.GJ892431@yoga>
References: <20200414185744.84581-1-john.stultz@linaro.org>
 <CAD=FV=XT_icz04g4M+iZHZRzjM1jnuHgkPBsaVmzc1wyoUe=7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=XT_icz04g4M+iZHZRzjM1jnuHgkPBsaVmzc1wyoUe=7A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14 Apr 12:06 PDT 2020, Doug Anderson wrote:

> Hi,
> 
> On Tue, Apr 14, 2020 at 11:57 AM John Stultz <john.stultz@linaro.org> wrote:
> >
> > This patch fixes a regression in 5.7-rc1.
> >
> > In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
> > PHY support"), the change was made to add "qcom,qusb2-v2-phy"
> > as a generic compat string. However the change also removed
> > the "qcom,sdm845-qusb2-phy" compat string, which is documented
> > in the binding and already in use.
> >
> > This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
> > which allows the driver to continue to work with existing dts
> > entries such as found on the db845c.
> >
> > Cc: Andy Gross <agross@kernel.org>
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Doug Anderson <dianders@chromium.org>
> > Cc: Manu Gautam <mgautam@codeaurora.org>
> > Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > Cc: linux-arm-msm@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> > Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Fixes: 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2 PHY support")
> > Reported-by: YongQin Liu <yongqin.liu@linaro.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> 
> Re-adding reviews from:
> https://lore.kernel.org/r/158631458374.216820.17829557619378130779@swboyd.mtv.corp.google.com
> https://lore.kernel.org/r/CAD=FV=Wh9_4a-cDGPdpMrXUi_HmJvS-a2Ubeyo5WG3sgwVWKKQ@mail.gmail.com
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> 
> ...as of an hour ago Bjorn also picked up:
> 
> https://lore.kernel.org/r/1583747589-17267-8-git-send-email-sanm@codeaurora.org
> 
> ...and it's now in the Qualcomm for-next and ci-next.  It's still a
> bit of a pain that -rc1 will have the regression since many other
> maintainers will base their next branches on that, but not much to be
> done about it now.
> 

The regression is in the driver, so we want this patch landed in v5.7.
The dts change is heading for 5.8.

Regards,
Bjorn
