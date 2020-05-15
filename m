Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E995FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C54022065F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 03:57:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZGcHekf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEOD5R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 23:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726665AbgEOD5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 23:57:16 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEB1C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 20:57:16 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id 79so1224464iou.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 20:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOIJwK9iadOQS8VS9oX0d0eobJTm/S5dRf232DfhV2Q=;
        b=jZGcHekf36InUx+/RT41yJ39LwB4eBQd7vT66ue0xAbo5xTuZa/i0CJGeuQo7uasFj
         KWR4W7zbDPi+yq6TlwQ/zf00VGEQsa9I4hgKLRy95YYxTa/7/vLLZ4zckSK3fiLThmnp
         7APyzonChcoUD6QuyiXT4zmroeoUonhrx7iX00yfVl9XCl3PDxXPwMf1n6VJgz6HgOY+
         A99tLzeweiB5AaZ9lVTuw1dif9/03YSktMiID+xWBMBqbu3KL5JcKrJE0YqaeoLj+OtY
         31xcKDIp1GOlgt95Lo/67hHz6ooA4vlcpH+Xi4ndyRh2QHgKM65UGQ6Ra684eiFjo8Jq
         6sig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOIJwK9iadOQS8VS9oX0d0eobJTm/S5dRf232DfhV2Q=;
        b=ITVTdth8inqw7ESbDb4KWW3unb6Xh6GDJzkk1EEUWPromFe6SzI77C3nejEaxt270B
         oLamgCkIn+d4Zq7+10GvgX+6qYMiC/GIeQi+/fJ8sJAMoaFQ3ZQzsYo5jBbPbxw93R7+
         jZBad8hP/F+miMwB4Z8rM4GzbhEkftfvfzYXRP1TJuiME6NQPdKGdMURoMpZa/FRTnPs
         Pbq3ar7Ga2xhbi/gNmNVVpeVddEObdGBtG1oXOuR5Apl1TkLvS1ZDhukJ1wEutZIYjOF
         jwzCBCGqOx5gXlrb9R7hTxekPVtN3iuzWfbGoCKl2WtKqF7WrGJSVPS4TUYFZwsKbn0U
         j97w==
X-Gm-Message-State: AOAM531eecPC6xl8ePc0pNr8o7+8rWmSkF94pHDlmCRtDxOT/fBNHlAT
        GTXHXO+SRBMovQ6E4wJosiTsd6D4E1zA2JZI361Jpw==
X-Google-Smtp-Source: ABdhPJz4yECgbKlvcTa70WHzfNcxbCgYqFO0xfvcC6KgNtx0n8f7dausExrVZi/vmEvOALHEs8Dq89VdSz06od9lItk=
X-Received: by 2002:a6b:e60b:: with SMTP id g11mr1143301ioh.96.1589515035477;
 Thu, 14 May 2020 20:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <1585718145-29537-1-git-send-email-sanm@codeaurora.org>
 <1585718145-29537-3-git-send-email-sanm@codeaurora.org> <878shu4uwk.fsf@kernel.org>
 <875zcy4uuj.fsf@kernel.org> <20200514171352.GP4525@google.com> <abbc3f8c-c8c9-c189-735e-f8058dab3e40@linaro.org>
In-Reply-To: <abbc3f8c-c8c9-c189-735e-f8058dab3e40@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 15 May 2020 09:27:03 +0530
Message-ID: <CAKohpon+JBpV3fC7j=rhc1R4gi_mVG6teBDrE8Yryd4QXfw9bw@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] usb: dwc3: qcom: Add interconnect support in dwc3 driver
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>,
        Felipe Balbi <balbi@kernel.org>,
        Sandeep Maheswaram <sanm@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        Chandana Kishori Chiluveru <cchiluve@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 02:33, Georgi Djakov <georgi.djakov@linaro.org> wrote:

> ---8<---
> diff --git a/drivers/usb/dwc3/Kconfig b/drivers/usb/dwc3/Kconfig
> index 206caa0ea1c6..6661788b1a76 100644
> --- a/drivers/usb/dwc3/Kconfig
> +++ b/drivers/usb/dwc3/Kconfig
> @@ -129,6 +129,7 @@ config USB_DWC3_QCOM
>         tristate "Qualcomm Platform"
>         depends on ARCH_QCOM || COMPILE_TEST
>         depends on EXTCON || !EXTCON
> +       depends on INTERCONNECT || !INTERCONNECT

Again, as I said yesterday. This looks incorrect and may not fix the problem..

With this we will be able to select USB_DWC3_QCOM even when INTERCONNECT=m.

What we perhaps need here is:
depends on INTERCONNECT != m

--
viresh
