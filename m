Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3EBC8300A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C55B2072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 18:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FFYaTLS0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgD2Sfr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbgD2Sfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 14:35:46 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A02C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:35:45 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a31so1101117pje.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 11:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=08p5fj27gfIIM4xLE6VPLWHuk1iLyqebey0af2ogLu0=;
        b=FFYaTLS0A9F0ReP7zEIjXTXSPBAQlwGMHcaVMhSuhovYiugz+6a/Jt1nQiHzV9Qqju
         IIgYl82tPD6UusRRDbHgqmQ129i1tXYC2lP1T+7GXnCkUaOUYf1adDB6+eJ2xJgkNnQp
         VDMicnpzkiWiEiVs7ynjv4LAK4leb5+gcAJOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=08p5fj27gfIIM4xLE6VPLWHuk1iLyqebey0af2ogLu0=;
        b=aRoqSBCSVFrPhTuB1AjbV5B63+xhgpD1gwTv7PEavEd378L5oaFgkThdpAaGvRSGXn
         qZW1AdPP7eklBI8qPfbRBBu2AYcpix95CR9mnCfIHIRYpDQa6WzShn90lmdqWPfwFAPD
         Qst54g9BXcN8DPQtWzqS8bi9Ldrygo+rJdCR+q3ZT0R858GK50aQ/Gq9gZ7XiaZayQip
         Ly5u7uAsg0ygjOjzp4ys5d5Zs6eSDOFU+Dqmb9VQJ3vMLTUSvoGGS2nF01lswP6UoemC
         Ow8kcHMNShzbVQty6Xwg0Lg4CVzlnuEauxsRuFdBti9hbzr6E9dyZOTveYI1E+mJWmsd
         PVlg==
X-Gm-Message-State: AGi0PubxTu3rAHO094z/Oi4OeBCt4p+wf5cPS4+kFpALqSediTPphLfN
        MbPzonzpwlJDLw9M1ADLU/HeWQ==
X-Google-Smtp-Source: APiQypKTRutC1MlI4l1Qf7LKmUxg3tadHomjIMqKmf84o5IE8XamP56lmNdNZx1ZAkOHMQE0Jamzuw==
X-Received: by 2002:a17:90a:3450:: with SMTP id o74mr4681969pjb.159.1588185344615;
        Wed, 29 Apr 2020 11:35:44 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id o40sm16770pjb.18.2020.04.29.11.35.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 11:35:43 -0700 (PDT)
Date:   Wed, 29 Apr 2020 11:35:42 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Felipe Balbi <balbi@kernel.org>
Cc:     Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Subject: Re: [PATCH v7 0/4] ADD interconnect support for Qualcomm DWC3 driver
Message-ID: <20200429183542.GS4525@google.com>
References: <1585718145-29537-1-git-send-email-sanm@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1585718145-29537-1-git-send-email-sanm@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,

all patches of this series have been reviewed and there are no outstanding
comments, so I guess it should be ready to land?

Thanks

Matthias

On Wed, Apr 01, 2020 at 10:45:41AM +0530, Sandeep Maheswaram wrote:
> This path series aims to add interconnect support in
> dwc3-qcom driver on SDM845 and SC7180 SoCs.
> 
> Changes from v6 -> v7
>   > [PATCH 2/4] Fixed review comments from Matthias in DWC3 driver.
>   > Other patches remain unchanged.
> 
> Changes from v5 -> v6
>   > [PATCH 1/4] Addressed comments from Rob.
>   > [PATCH 2/4] Fixed review comments from Matthias in DWC3 driver.
>   > [PATCH 3/4] Ignoring 80 char limit in defining interconnect paths.
>   > Added [PATCH 4/4] in this series. Adding interconnect nodes for SC7180.
>     Depends on patch https://patchwork.kernel.org/patch/11417989/.	
> 
> Changes from v4 -> v5
>   > [PATCH 1/3] Added the interconnect properties in yaml. This patch depends
>     on series https://patchwork.kernel.org/cover/11372641/.
>   > [PATCH 2/3] Fixed review comments from Matthias in DWC3 driver.
>   > [PATCH 3/3] Modified as per the new interconnect nodes in sdm845. Depends
>     on series https://patchwork.kernel.org/cover/11372211/. 
> 
> 
> Changes from v3 -> v4
>   > Fixed review comments from Matthias
>   > [PATCH 1/3] and [PATCH 3/3] remains unchanged
> 
> Changes from v2 -> v3
>   > Fixed review comments from Matthias and Manu
>   > changed the functions prefix from usb_* to dwc3_qcom_*
> 
> Changes since V1:
>   > Comments by Georgi Djakov on "[PATCH 2/3]" addressed
>   > [PATCH 1/3] and [PATCH 3/3] remains unchanged
> 
> 
> Sandeep Maheswaram (4):
>   dt-bindings: usb: qcom,dwc3: Introduce interconnect properties for
>     Qualcomm DWC3 driver
>   usb: dwc3: qcom: Add interconnect support in dwc3 driver
>   arm64: dts: qcom: sdm845: Add interconnect properties for USB
>   arm64: dts: qcom: sc7180: Add interconnect properties for USB
> 
>  .../devicetree/bindings/usb/qcom,dwc3.yaml         |   8 ++
>  arch/arm64/boot/dts/qcom/sc7180.dtsi               |   4 +
>  arch/arm64/boot/dts/qcom/sdm845.dtsi               |   8 ++
>  drivers/usb/dwc3/dwc3-qcom.c                       | 128 ++++++++++++++++++++-
>  4 files changed, 146 insertions(+), 2 deletions(-)
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
> 
