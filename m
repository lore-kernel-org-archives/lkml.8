Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B09C2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90F4120787
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OVTTLbqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390040AbgDBXSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:18:45 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37789 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBXSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:18:45 -0400
Received: by mail-pg1-f194.google.com with SMTP id r4so1109906pgg.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hRNopbGVH3Ptzrk/4MigR6ROi/adYHKfTDbekJj0Qcw=;
        b=OVTTLbqfhamXMqXPgwu6x5Mo38O93HBEbTvyjst4xdirc50oDR9GO3KFQQV+0NQVvN
         +nghNBkNzsB3y4VN5jq2ZOluhiZCr7VZUabHsiEeBGUofT7BrZPUsXupRGWCsa2D6P+d
         6xsC5oXEnkeA7ZUhceQ914ZtS3D4p9TatXJnbWhd+7A7VNOCMvfkH0qv0Tq5aoBXLk1h
         4a+lfPYyBy9IiXf9KiE6MQkpIFUrl1Sg3hkFxrnJOuyRh7/TUzJezaYAIMgG+MX6uk1I
         z39i6CS69q7Kpj9bGwYw2vCnnw4ZHKx1Tz21/NC+K6wmYN9Vnn8LQ7ayBTqAZm1rf+u/
         glkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hRNopbGVH3Ptzrk/4MigR6ROi/adYHKfTDbekJj0Qcw=;
        b=QcLrtrfqKOXS7dnmHrPuiQJ5TyzP6Blof+P01nhxfBJd5tn4TY49PlKTDOS0JHzGz0
         q8SzVg/114IklnBqgBgaISDcaPF3dISEGd19HWrC+Wu4hd9ZvSEZq3mfjxR24EjaNSKp
         6E1b1iEvVhQ/Ree1Eh76sC+hk7Hka9ttgmF3YE7HP33Kb0e6hKaSEB0XBtxw+HvIeL4B
         ylnahdX1vD+tT/HnqJQ/DOLu2g4Sst6+20LSqvDXer0WmTJDer2lTiOSeKAJx4hzviDQ
         YdsoFo0ceBCRJApUXn746JAj75guZg9gJ6iQT/jIPSFfG9SHIe0uQQP8sfabsG4DkvBr
         Bqvg==
X-Gm-Message-State: AGi0PuYa8U44uXYhlFH9rtfD/W//C/0mAwa/PQsBLusKP657kN73QvAQ
        gKmSR9tf4CXl5pTqppYqckPyfg==
X-Google-Smtp-Source: APiQypI7H+r1Eg5xc73T+t+fbfyInBtijzZTZim9htzlxz42ZqZLdPFt4zBC8Pp5SoJ45JlVVHugEg==
X-Received: by 2002:a63:e56:: with SMTP id 22mr5520736pgo.173.1585869523780;
        Thu, 02 Apr 2020 16:18:43 -0700 (PDT)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m9sm4436895pff.93.2020.04.02.16.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 16:18:43 -0700 (PDT)
Date:   Thu, 2 Apr 2020 16:18:40 -0700
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
Subject: Re: [PATCH] phy: qcom-qusb2: Re add "qcom,sdm845-qusb2-phy" compat
 string
Message-ID: <20200402231840.GA327102@minitux>
References: <CANcMJZCr646jav3h14K0xV=ANMxXg=U20wvSB546qrLX3TECBg@mail.gmail.com>
 <20200402223723.7150-1-john.stultz@linaro.org>
 <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD=FV=VGT75c4_ErQAJgNtcCd2Jzv0A2KpfEkS637GqOhamj9Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 02 Apr 15:56 PDT 2020, Doug Anderson wrote:

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
> 
> While we can land your patch if someone needs it for supporting an
> out-of-tree dts, it gives people supporting future SoCs the idea that
> they need to add themselves to this table too.  That's now discouraged
> unless there's a specific quirk that needs to be handled just for this
> SoC.
> 

Afaict the compatible has been in use in the upstream sdm845.dtsi since
v4.20 and we do have an outspoken rule that we don't break backwards
compatibility with existing DTBs.

There are cases where it makes sense to break this rule, e.g. to fix
something that's clearly broken, but I don't see that this is such a
case.

Regards,
Bjorn
