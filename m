Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F51C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87542077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AWWeCU4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbgDBXCg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:02:36 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37964 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389944AbgDBXCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:02:36 -0400
Received: by mail-qt1-f195.google.com with SMTP id z12so4997614qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ok4wGTvzCTXydODevfiQEyG5yYpGPlaZ9o6pHHlLTpk=;
        b=AWWeCU4hDYBU+OF5Y1ceaY6RIGtjixFYMB6CHk1om2doQr/qKmzNCgXSJraZDzZfSR
         Q3KjibosDCnp2LuIKlLoDoqs0C+fmtZlLp/2UoNaSRGfDjVSvofs9p+Yl6XJbvxIbkoT
         blGSyQI2wo3Vm9+IiP6WpSEAODiHqUPilerQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ok4wGTvzCTXydODevfiQEyG5yYpGPlaZ9o6pHHlLTpk=;
        b=G2WE3/dg3ylWzSHDqoICMkOo3hjd6L+OeuN3pNMHRvOQyYigf+Ra9GPd8qWXVRhTMD
         48/skFSV2cFipT16xN75pNcFAq9+gwJXktgABJ6/y3aYG0uw/ss3plv8OVOV3t3QgCP1
         zQKVFJ+JyORlt3EV1NSG7RGQGA7TBfvITQZ2+pC4hUhIb4VXDrQs/NxmFofvoCb8oBgy
         EEGWNcUSmDCuVwpNOlQua4H/7lSqrglY3OZM6NF8vAGy7khIbS9gXjKkZNZmodGsYiXI
         NqXuYUTL3RpYJiFu1EgkhIAQ5tPduGyzeqMEvsZw9gselMJjWOYoibov/Byxfw63qlxJ
         krPw==
X-Gm-Message-State: AGi0PuZoT+Q4GbYIhXMgQhhReHlNygY5/3gbSAFC4stvPHKmpvhZhDWa
        67ojeVD9R9Xa1Mh2G9sv9qLydOTm/6E=
X-Google-Smtp-Source: APiQypIpiB/k0e0QV1rBnlnkamwjL0Blo69DJVRgleQGLtOnfbUj+DDsAO+12R6Bm+uGI7+zMcqtUA==
X-Received: by 2002:ac8:7448:: with SMTP id h8mr5426504qtr.51.1585868554578;
        Thu, 02 Apr 2020 16:02:34 -0700 (PDT)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id x14sm4629443qkj.66.2020.04.02.16.02.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 16:02:34 -0700 (PDT)
Received: by mail-qv1-f54.google.com with SMTP id ef12so2681478qvb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:02:34 -0700 (PDT)
X-Received: by 2002:a67:1e46:: with SMTP id e67mr4469905vse.106.1585868185329;
 Thu, 02 Apr 2020 15:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANcMJZCr646jav3h14K0xV=ANMxXg=U20wvSB546qrLX3TECBg@mail.gmail.com>
 <20200402223723.7150-1-john.stultz@linaro.org>
In-Reply-To: <20200402223723.7150-1-john.stultz@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 2 Apr 2020 15:56:14 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
Message-ID: <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
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

On Thu, Apr 2, 2020 at 3:37 PM John Stultz <john.stultz@linaro.org> wrote:
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
> Fixes: 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2 PHY support")
> Reported-by: YongQin Liu <yongqin.liu@linaro.org>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
>  1 file changed, 3 insertions(+)

Do you have an out-of-tree dts file?  If not, I'd prefer that the fix
was for this patch to land instead:

https://lore.kernel.org/r/1583747589-17267-9-git-send-email-sanm@codeaurora.org

While we can land your patch if someone needs it for supporting an
out-of-tree dts, it gives people supporting future SoCs the idea that
they need to add themselves to this table too.  That's now discouraged
unless there's a specific quirk that needs to be handled just for this
SoC.

-Doug
