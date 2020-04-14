Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A306C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBD4A20771
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kepiQP1o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504687AbgDNT0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504654AbgDNTY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:24:56 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC98C03C1A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:06:59 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id u11so677506vsu.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f7KrnRzyyOUemPRVsSUSW7supihjD0aQaPjITXcbeLk=;
        b=kepiQP1oWmWQkilPnEBSKatdjUR3EE60+QwIJjoai4XqsbJg4+7PZQWRyq2meKTDqq
         U1NTYx+3Wr89EDUCIm9olKYp1EoY+W4BHV9q7VO8idCaiTP6Lm4E5VmXUoJ2AGRFhriY
         Da+cFwBBH7Nv7E5bfANSfnNH0J8nmp6cQAwVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f7KrnRzyyOUemPRVsSUSW7supihjD0aQaPjITXcbeLk=;
        b=XNIWwHRqgimE8ExuQRpjOtVvm/9wg1bEeVM09J/M1M4qVoYqSj5eauKm7bedOPs9HB
         3CZVoRHipVT/74skRV8jzoLvVeMkoK/9CN67TQ0XTbw5UOfNj9PdypFuXZjSKgDFG2hE
         enjbdK6drGlzub+yCgmGr0QGCZhWYQfCK6cLf10hsuf2KsXN2n+lXDzZMEclnn6ExUrs
         xvWtxSpTwaUtG4666RmdlhPkM7jFVudB6YtBgTVNo8M6XOcqn1FjQRhoS/87gvb+cC9c
         vVzjxmIVfrbshTexaSXGI2o5Bi1cuZbireqnAr32qAAmGz3FGLSwTYlQ4xLELcjdcpgf
         AnPw==
X-Gm-Message-State: AGi0PubPuWFjWfH+ZTrM+qgzzaepYpRmUKM2j6xK2v/HNOZcBcau6SBW
        VAjjOsLbyxlFKQ0lcFJucLx/3dOGFcM=
X-Google-Smtp-Source: APiQypJrUhyYA6eIUGGgJcjrqq1cwsp/c/5N3NCgUojyXGkteJmlTHd/jobI+4R52CMh5aoP0a31hg==
X-Received: by 2002:a67:eb92:: with SMTP id e18mr1570404vso.67.1586891218191;
        Tue, 14 Apr 2020 12:06:58 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id t67sm3101675vkc.39.2020.04.14.12.06.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Apr 2020 12:06:57 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id u11so677459vsu.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:06:57 -0700 (PDT)
X-Received: by 2002:a67:8dc8:: with SMTP id p191mr1616800vsd.198.1586891216585;
 Tue, 14 Apr 2020 12:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200414185744.84581-1-john.stultz@linaro.org>
In-Reply-To: <20200414185744.84581-1-john.stultz@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 14 Apr 2020 12:06:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XT_icz04g4M+iZHZRzjM1jnuHgkPBsaVmzc1wyoUe=7A@mail.gmail.com>
Message-ID: <CAD=FV=XT_icz04g4M+iZHZRzjM1jnuHgkPBsaVmzc1wyoUe=7A@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy"
 compat string
To:     John Stultz <john.stultz@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 14, 2020 at 11:57 AM John Stultz <john.stultz@linaro.org> wrote:
>
> This patch fixes a regression in 5.7-rc1.
>
> In commit 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2
> PHY support"), the change was made to add "qcom,qusb2-v2-phy"
> as a generic compat string. However the change also removed
> the "qcom,sdm845-qusb2-phy" compat string, which is documented
> in the binding and already in use.
>
> This patch re-adds the "qcom,sdm845-qusb2-phy" compat string
> which allows the driver to continue to work with existing dts
> entries such as found on the db845c.
>
> Cc: Andy Gross <agross@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Manu Gautam <mgautam@codeaurora.org>
> Cc: Sandeep Maheswaram <sanm@codeaurora.org>
> Cc: Matthias Kaehlcke <mka@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: linux-arm-msm@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Fixes: 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2 PHY support")
> Reported-by: YongQin Liu <yongqin.liu@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Re-adding reviews from:
https://lore.kernel.org/r/158631458374.216820.17829557619378130779@swboyd.mtv.corp.google.com
https://lore.kernel.org/r/CAD=FV=Wh9_4a-cDGPdpMrXUi_HmJvS-a2Ubeyo5WG3sgwVWKKQ@mail.gmail.com

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>

...as of an hour ago Bjorn also picked up:

https://lore.kernel.org/r/1583747589-17267-8-git-send-email-sanm@codeaurora.org

...and it's now in the Qualcomm for-next and ci-next.  It's still a
bit of a pain that -rc1 will have the regression since many other
maintainers will base their next branches on that, but not much to be
done about it now.

-Doug
