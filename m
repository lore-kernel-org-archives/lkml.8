Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46064C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20BDD22CBB
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 19:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="o/oSAcfU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgGST4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 15:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgGST4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 15:56:40 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1B10C0619D2;
        Sun, 19 Jul 2020 12:56:39 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so15997339eje.1;
        Sun, 19 Jul 2020 12:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UkvPwVZQWgoIN1YiUvn+3mkMTZrdb6lXgiYZt8Sccuk=;
        b=o/oSAcfUJWlBQjWyMztERWI8MDMmAtF1ufgmyl9EibnFkKRCLjLJ0YWUBr+t4lHrje
         3JuoxxSFyL8YQwtaRqSzR52OTcsv1DL09gIMcvt76YwFYmsjadCx7fUt6e3wvZhgA5Pj
         U2Q2AiwA8slQl0845vGlS/sZ6jaSWXyeqldkFj9kCN25aLH8J/zdE4AdTbhr1BqodAc3
         G5elYV5C5Vd1DFpHJwV5cUNIHYSBBZGiHC/9pzfpZNLGA7uYFv5o+drLvubkOnI3opdk
         9p9fK9Uf1sqv0qVc7GeDJEsVt1j9LUYa2Vt82kCV2/nWYP9WZz2CmoSq9e8xDw05RDT7
         Ogig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UkvPwVZQWgoIN1YiUvn+3mkMTZrdb6lXgiYZt8Sccuk=;
        b=r4ckjvSNf1ayYqE+E27FVwZ86LOjcPprVzXzTHiaUHLUK964XRAEZ7Pe7NnN4nCNDF
         Xui7d4+HogV3DKmCHBeMjo+HdSUBw1XiLFu9Hx1t+//YTfEoxOX4vx52rH7hjTM9ejIa
         /Dhbc+zTOCrSFjFxutV590LywcZ8X6oIaxTNI5su1kHt4RPHeIS82CqVac8VpJ8nDD2V
         YmsD/ShrgLdbKXaSyAhO1B2xEtI+D4DcZZOsVhE9fZsw2oVdExuLzHVwMBOdCENS1uIB
         C189hCuMun0P146pPEopKKpQELcG0A4tJOtN6bdBIy5w+I+49SEhOtxZr3/naOeuG4HM
         hCxA==
X-Gm-Message-State: AOAM5318LI/0blV5EqxaGslVT86EWQmXsJNfsupcgfQEzA2h5rQK8pbW
        WA9cIOF22Od4nmBa7MOtvBh2cVxedcFoEmaJCF4=
X-Google-Smtp-Source: ABdhPJyGNKE6IUTHOPmFmEyDoa7JuyZ+ziIL1QORMAJVC3zY1tBNeKPzbnMPk4bE3NtaqwOlMnSddTSskQ4hGBVYfpc=
X-Received: by 2002:a17:906:dbe5:: with SMTP id yd5mr18079240ejb.328.1595188598479;
 Sun, 19 Jul 2020 12:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200616140717.28465-2-amelie.delaunay@st.com>
 <20200704174219.612060-1-martin.blumenstingl@googlemail.com>
 <05a81997-5ddb-ea81-7a89-8078b8a2b610@st.com> <CAFBinCCVYJ=DuKbqhJJ8463Gs+GW0bgxyXSFiLXhUfvWV6AR0Q@mail.gmail.com>
 <ee4ee889-835e-2244-504c-2b1b605d78aa@st.com>
In-Reply-To: <ee4ee889-835e-2244-504c-2b1b605d78aa@st.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Sun, 19 Jul 2020 21:56:27 +0200
Message-ID: <CAFBinCDUxvovAyDywz3xVcu_1v4nai+ebR2D38U2B8oBGss=yg@mail.gmail.com>
Subject: Re: [PATCH 1/3] usb: dwc2: override PHY input signals with usb role
 switch support
To:     Amelie DELAUNAY <amelie.delaunay@st.com>
Cc:     Alexandre TORGUE <alexandre.torgue@st.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "hminas@synopsys.com" <hminas@synopsys.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Amelie,

sorry for the late reply

On Wed, Jul 8, 2020 at 6:00 PM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
[...]
> Could you please test with:
>
> static int dwc2_drd_role_sw_set(struct device *dev, enum usb_role role)
> {
>         struct dwc2_hsotg *hsotg = dev_get_drvdata(dev);
>         unsigned long flags;
>         int already = 0;
>
>         /* Skip session not in line with dr_mode */
>         if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
>             (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
>                 return -EINVAL;
>
>         /* Skip session if core is in test mode */
>         if (role == USB_ROLE_NONE && hsotg->test_mode) {
>                 dev_dbg(hsotg->dev, "Core is in test mode\n");
>                 return -EBUSY;
>         }
>
>         spin_lock_irqsave(&hsotg->lock, flags);
>
>         if (role == USB_ROLE_HOST) {
>                 already = dwc2_ovr_avalid(hsotg, true);
>         } else if (role == USB_ROLE_DEVICE) {
>                 already = dwc2_ovr_bvalid(hsotg, true);
>                 /* This clear DCTL.SFTDISCON bit */
>                 dwc2_hsotg_core_connect(hsotg);
>         } else {
>                 if (dwc2_is_device_mode(hsotg)) {
>                     if (!dwc2_ovr_bvalid(hsotg, false))
>                         /* This set DCTL.SFTDISCON bit */
>                         dwc2_hsotg_core_disconnect(hsotg);
>                 } else {
>                         dwc2_ovr_avalid(hsotg, false);
>                 }
>         }
>
>         spin_unlock_irqrestore(&hsotg->lock, flags);
>
>         if (!already &&
>             role != USB_ROLE_NONE && hsotg->dr_mode == USB_DR_MODE_OTG)
>                 /* This will raise a Connector ID Status Change Interrupt */
>                 dwc2_force_mode(hsotg, role == USB_ROLE_HOST);
>
>         dev_dbg(hsotg->dev, "%s-session valid\n",
>                 role == USB_ROLE_NONE ? "No" :
>                 role == USB_ROLE_HOST ? "A" : "B");
>
>         return 0;
> }
>
>
> dwc2_force_mode is called outside the spin_lock_irqsave so the kernel
> should not complain. I've tested on my setup and the behavior seems the
> same.
this one is looking good - the previous kernel warnings are now gone!
thank you very much


Best regards,
Martin
