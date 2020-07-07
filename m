Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CD6C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F291206CD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 18:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="MSqOBX8i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgGGSzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbgGGSzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:55:17 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD8BC061755;
        Tue,  7 Jul 2020 11:55:17 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id y10so47719109eje.1;
        Tue, 07 Jul 2020 11:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RMd8tTCfjNB1oolYgjCGnbvueA8plaMd/4ysVp4hew8=;
        b=MSqOBX8iZf3N6uIy8Wnm5L4m29/XEr8WCDGWKf500fbPsnl0xzYC6LVlONOf42h0CR
         I4Rd/idVHgRuoGFtY+arKp+gSn5l1NRpVZPWVHS7fUt71j1qB3v2jBGggVQKiUaXawDQ
         qNM+I9ABuRJwyg5qaqOAP2v7E/mgtgDyAf07ig2saLp6YrXGZCFFphghvpbv74afVMS8
         hgukBbVyPl5VtFibxfDALfdkB8feg3dsrXD3cpQ8FTKR3WiUU7+WwLET7Fw8fB0Y9Ntx
         fJHk1hgmFv1SXz42n9wzYn1nyBLlwu2BiOkVLXgOydApO9SPolevYiuOnuXVadp33hpE
         sucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RMd8tTCfjNB1oolYgjCGnbvueA8plaMd/4ysVp4hew8=;
        b=EI62LqfxVmuWGRR0riabauCOYQMb4pWuSeGO6Vwy3Sm/tF38c1j1InDDIDN2+uYtRb
         Bw2u14sPc85z2UnwPVqXcMP762pEF7XFlFRlDKRVmr43PcD5PHgtlas6Y9NY279IoKW8
         7CLVIkWIC+D0EOnUXhmYpR/yYk8oL68LecFc7BVlIelTbzuY0S0IulqE6+ow+7FhzXRz
         QnUD6FaaesDykqb84NymO7yoJDnvREnXIzp2GWoMtrfA986EyXqRZ8k4o/NcaC46Dmux
         haieheaV1l4GWN0m2TKarMJfHzEyKg5R7rhJw6CGsWSo3SWFNyM4SVdM+OEkZbyLGEJa
         083A==
X-Gm-Message-State: AOAM532e/2irmO3SuowHNQiiybJuDkAjP0mmHGxNzzZue2q4SzFcudtR
        rXr38tnsOduxVbKxFnVW+siAJuTZtjNgg4jdgtE=
X-Google-Smtp-Source: ABdhPJyGaJyOnxq0gk8ybfmAthcx/e6Mw+KIY+a9E8de0FSUviN2dLI02eWmz8T4W3gH7eX3EhiPg+3nhWg5mmVWaSQ=
X-Received: by 2002:a17:906:2287:: with SMTP id p7mr49705831eja.537.1594148115920;
 Tue, 07 Jul 2020 11:55:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200616140717.28465-2-amelie.delaunay@st.com>
 <20200704174219.612060-1-martin.blumenstingl@googlemail.com> <05a81997-5ddb-ea81-7a89-8078b8a2b610@st.com>
In-Reply-To: <05a81997-5ddb-ea81-7a89-8078b8a2b610@st.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 7 Jul 2020 20:55:05 +0200
Message-ID: <CAFBinCCVYJ=DuKbqhJJ8463Gs+GW0bgxyXSFiLXhUfvWV6AR0Q@mail.gmail.com>
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

Hi Amelie,

On Tue, Jul 7, 2020 at 6:13 PM Amelie DELAUNAY <amelie.delaunay@st.com> wrote:
>
> Hi Martin,
>
> On 7/4/20 7:42 PM, Martin Blumenstingl wrote:
> > Hello Amelie,
> >
> > thank you for this patch - I am hoping that it will help us on Amlogic
> > Meson8, Meson8b, Meson8m2 and GXBB SoCs as well.
> > On these SoCs the ID detection is performed by the PHY IP and needs to
> > be polled.
> > I think usb_role_switch is the perfect framework for this on dwc2 side.
> > For the PHY driver I'm going to implement the cable state using the
> > extcon framework and then having a new usb-conn-extcon driver. This is
> > just to give you an overview why I'm interested in this.
> >
>
> I'm wondering, why use extcon framework and not the usb role switch API
> ? This patch on dwc2 is tested on STM32MP157C-DK2 board with STUSB160x
> Type-C controller driver recently pushed with usb role switch. You can
> have a look here https://lore.kernel.org/patchwork/patch/1256238/.
one of the boards that I'm working on is for example the Odroid-C1. It
has a Micro-USB port and there's no Type-C controller present.

in the next few days I'll try to send my idea as RFC, but this is the
.dts I've come up with so far:
&usb0 {
    dr_mode = "otg";
    usb-role-switch;

    connector {
        compatible = "extcon-usb-b-connector", "usb-b-connector";
        type = "micro";
        extcon = <&usb0_phy>;
        vbus-supply = <&usb_vbus>;
    };
};

I did this for two reasons:
1. I think the PHY is not a connector and thus it's driver shouldn't
implement any connector specific logic (managing VBUS)
2. without the connector there would be a circular dependency: the USB
controller needs the PHY to initialize but the PHY would need the USB
controller so it can manage the role switch

(or in other words: the connector replaces the Type-C controller in this case)

> > [...]
> >> +static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
> >> +{
> >> +     struct dwc2_hsotg *hsotg = usb_role_switch_get_drvdata(sw);
> >> +     unsigned long flags;
> >> +
> >> +     /* Skip session not in line with dr_mode */
> >> +     if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
> >> +         (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
> >> +             return -EINVAL;
> >> +
> >> +     /* Skip session if core is in test mode */
> >> +     if (role == USB_ROLE_NONE && hsotg->test_mode) {
> >> +             dev_dbg(hsotg->dev, "Core is in test mode\n");
> >> +             return -EBUSY;
> >> +     }
> >> +
> >> +     spin_lock_irqsave(&hsotg->lock, flags);
> > due to this spin_lock_irqsave() ...
> >
> >> +     if (role == USB_ROLE_HOST) {
> >> +             if (dwc2_ovr_avalid(hsotg, true))
> >> +                     goto unlock;
> >> +
> >> +             if (hsotg->dr_mode == USB_DR_MODE_OTG)
> >> +                     /*
> >> +                      * This will raise a Connector ID Status Change
> >> +                      * Interrupt - connID A
> >> +                      */
> >> +                     dwc2_force_mode(hsotg, true);
> > ... we cannot sleep in here. the call flow is:
> > dwc2_drd_role_sw_set
> >    spin_lock_irqsave
> >    dwc2_force_mode
> >      dwc2_wait_for_mode
> >        usleep_range
> >
>
> In fact, with the avalid or bvalid overriding + the debounce filter
> bypass, GINTSTS_CURMOD is already in the expected mode, so that we exit
> the loop directly, without running into usleep_range.
on my Amlogic SoC this is not the case:
The kernel complains because of that usleep_range from within the
spinlock context

Please let me know if/how I can help debug this.

[...]
> > +int dwc2_drd_init(struct dwc2_hsotg *hsotg)
> > +{
> > +       struct usb_role_switch_desc role_sw_desc = {0};
> > +       struct usb_role_switch *role_sw;
> > +       int ret;
> > +
> > +       if (!device_property_read_bool(hsotg->dev, "usb-role-switch"))
> > +               return 0;
> > should we also return early here if dr_mode != "otg"?
> >
>
> No, because when VBUS is not connected to the controller, you also need
> to get the usb_role_none from the usb-role-switch to catch the
> unattached state (also in Peripheral or Host only mode).
I see - thank you for the explanation!


Best regards,
Martin
