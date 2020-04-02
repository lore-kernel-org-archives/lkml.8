Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6733C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 735E52077D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJH8mUDy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390061AbgDBXIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:08:34 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:46918 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732600AbgDBXIe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:08:34 -0400
Received: by mail-ot1-f68.google.com with SMTP id 111so5322839oth.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQeb3TySrXKWjqdpdystZzrLdZhobbR4wczMyxU9daE=;
        b=NJH8mUDyS4vydKm8ozgwIwBIN0a+isHGLQhu1Xa7KlLuolkz3lTRHWLGbQWqH3DraZ
         GVKcNeq10kJshsCpCmD1ur2WOCalb70yJRRqscOw6we52/btmA03mOpNDeepRwaZoCKx
         dJnRiSXTU6iVG2WpqT5DIUkzfttiDahvRrN9Ewboh/gzEwIivf1ZemL3a2CfwUbgyEk+
         2hChBjqqFqpMhYxoe+FEq53Gsdh4f2ziNfFkSadQSpgWvqL+EBX+bXP8uMgyvWFIYFUI
         90w2wzB44wDQeY7nCWytwHwPOT1gRiQLyRCC3DnFQq2w4RQ2VwXqZVzPKsRGfmhCuw6R
         MIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQeb3TySrXKWjqdpdystZzrLdZhobbR4wczMyxU9daE=;
        b=IcGriauBpKKLCrdwnh/wUt3kVKgaxB7r3YYDKkw35QZbDaQEEZ5aBkFrIqRGbypu3g
         Ng4RSCR2TBgK1rzBL6C2nRf+o6r8Aj0gJQq5qPAaSIBRWarSijoZjFxzfpZ5IC2Y20/Y
         PZq76LX0wyUzuEF6LxHfNWLsQLlmVePia1UzKuzG/x0LpO1BdeWgA3V3AcTbZIqqDmHv
         jOilQQ09/CkbIzRPhg+l5LG9g7tFOjmhvJoRi2sE3eHrlimTCE34CUKQRsEi9JweU0ny
         xObvFDWsVxmgr6aafAKw8hrvDXNDLULB2rgZPqic2eBEHQvEDp8bPezRnt0ZBnLOmopv
         BmPQ==
X-Gm-Message-State: AGi0PubwAAcIo7BcTuMAdH21BAwNER3nmVMQox3yL8ZFx140u91f0mLO
        /frESRgQ7GyuQc96XZMzrCpNahurOmsOqIthQq6NSQ==
X-Google-Smtp-Source: APiQypLZA26Q+M0Ymf7b40RsmQRLEnKqmqg5on5PqLiHU2wifOGb73iVFhOLTaxXIGxQBRFM25QTMqgRbY3IyGi8mMM=
X-Received: by 2002:a9d:344:: with SMTP id 62mr4591686otv.102.1585868913011;
 Thu, 02 Apr 2020 16:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <CANcMJZCr646jav3h14K0xV=ANMxXg=U20wvSB546qrLX3TECBg@mail.gmail.com>
 <20200402223723.7150-1-john.stultz@linaro.org> <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
In-Reply-To: <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 2 Apr 2020 16:08:21 -0700
Message-ID: <CALAqxLXfd+7Wc79_XWRv8cKLFu+MpM1w9e3byx9z5bXSdTemLg@mail.gmail.com>
Subject: Re: [PATCH] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat string
To:     Doug Anderson <dianders@chromium.org>
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

On Thu, Apr 2, 2020 at 3:56 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Thu, Apr 2, 2020 at 3:37 PM John Stultz <john.stultz@linaro.org> wrote:
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
> > Fixes: 8fe75cd4cddf ("phy: qcom-qusb2: Add generic QUSB2 V2 PHY support")
> > Reported-by: YongQin Liu <yongqin.liu@linaro.org>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  drivers/phy/qualcomm/phy-qcom-qusb2.c | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Do you have an out-of-tree dts file?  If not, I'd prefer that the fix
> was for this patch to land instead:
>
> https://lore.kernel.org/r/1583747589-17267-9-git-send-email-sanm@codeaurora.org

No, no out of tree dts.  The usage is already in tree:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/qcom/sdm845.dtsi#n2389


> While we can land your patch if someone needs it for supporting an
> out-of-tree dts, it gives people supporting future SoCs the idea that
> they need to add themselves to this table too.  That's now discouraged
> unless there's a specific quirk that needs to be handled just for this
> SoC.

My understanding with dts bindings is that they are effectively an
ABI. While maybe it makes sense to deprecate the
"qcom,sdm845-qusb2-phy" string in the Documentation to avoid new
users, I'd think we'd want to keep the support in the driver as we
aren't supposed to have tight coupling between the DTB and kernel (at
least for official bindings).

Granted, I've not gotten much experience with boards that were fully
upstream and thus didn't have an eternally evolving dts file that had
to be kept in sync with the kernel, so in practice either solution
does work for me, but in theory it seems like we should at least
pretend these things are stable. :)

thanks
-john
