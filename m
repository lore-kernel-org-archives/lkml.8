Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC88C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:42:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80B492070B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 17:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bGJue6eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgGDRmm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 13:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 13:42:41 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13AEAC061794;
        Sat,  4 Jul 2020 10:42:41 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id dm19so24361295edb.13;
        Sat, 04 Jul 2020 10:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s+WjqQhLnrBI9EZzuDqm8X/T4+BDu4Hvw8Pd6T2GP/0=;
        b=bGJue6eFu/VA4Z82viDrc/TOb1htLvh2SOgSDczNVO7YU7sdfkKY28+EU8afJih10q
         0N8YaAE/AmpRF6dp640fwh2aIEClOc56Zzav7IhwuCCIQMXGV6if3oeuYbKBWQu+ttlB
         QSXNrork0ZteL5K5kxxc7oaaLoWxaN+xARlgoWRL6Cuv64rfoHyjMh980DsyvOLaynjR
         K0UgWIugk+qbiApkZC9cKu2BfujP19Eu3jtymgrqJhYJR56xXgK8r/UgIHYnVhr8myrp
         bd3Bb7hC2Gjq8H1hERABJXPPmgiFQpOD12As09QpFCPPWdVI1psRm4k36AKXbOJ5vNxk
         EXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s+WjqQhLnrBI9EZzuDqm8X/T4+BDu4Hvw8Pd6T2GP/0=;
        b=tVbzpDiLNbvt02kkKtppX6qjFIYSRFmUFtBJnKUxuMD1zMKBwqGnbu2TIkjwgBxwNH
         BnLeA3CC0eS3ZWfzOtDdFTM6P+VeXfrFIXIZyiY1bQ91h84xA1A75pP6w5LwyZgId4n0
         SA+gg3QoRjPwi8g6Z1IS+ugq0mUOJEKZWWL2Jl3O6tWrcyB59vkYaTk69bTzkXOjEeO5
         J2c29jLYeWkQysSod38t7FofguD5nWO8IXwIuYRyqyDbfzAsSuNGM6KGbFroJjxpX3S0
         SW7ft20N+hzXBcC/VHFrtqKQ/9rnxX6fAzCh8IAy0n7atDWm7m1neqCFxGoRm9Pv9EP4
         04eA==
X-Gm-Message-State: AOAM5334wtRk4ecCH7SGmCpQhO4wY/q70Wr6mYyXzpHwL5QfXbLDlmDx
        HddsPAVAeoKIlNMkPxilB+4=
X-Google-Smtp-Source: ABdhPJy0vTlYXslUqGyC33YSMiLi8X29/Je6nWzHxrmFVdZsP3IEJRoSrq69lLr/vXKxSdAkeSt+Cg==
X-Received: by 2002:a05:6402:2c2:: with SMTP id b2mr46631661edx.184.1593884559571;
        Sat, 04 Jul 2020 10:42:39 -0700 (PDT)
Received: from localhost.localdomain (p200300f137244200428d5cfffeb99db8.dip0.t-ipconnect.de. [2003:f1:3724:4200:428d:5cff:feb9:9db8])
        by smtp.googlemail.com with ESMTPSA id f17sm17671650edj.32.2020.07.04.10.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 10:42:39 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     amelie.delaunay@st.com
Cc:     alexandre.torgue@st.com, balbi@kernel.org,
        devicetree@vger.kernel.org, fabrice.gasnier@st.com,
        gregkh@linuxfoundation.org, hminas@synopsys.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, mcoquelin.stm32@gmail.com,
        robh+dt@kernel.org
Subject: RE: [PATCH 1/3] usb: dwc2: override PHY input signals with usb role switch support
Date:   Sat,  4 Jul 2020 19:42:19 +0200
Message-Id: <20200704174219.612060-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616140717.28465-2-amelie.delaunay@st.com>
References: <20200616140717.28465-2-amelie.delaunay@st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Amelie,

thank you for this patch - I am hoping that it will help us on Amlogic
Meson8, Meson8b, Meson8m2 and GXBB SoCs as well.
On these SoCs the ID detection is performed by the PHY IP and needs to
be polled.
I think usb_role_switch is the perfect framework for this on dwc2 side.
For the PHY driver I'm going to implement the cable state using the
extcon framework and then having a new usb-conn-extcon driver. This is
just to give you an overview why I'm interested in this.

[...]
> +static int dwc2_drd_role_sw_set(struct usb_role_switch *sw, enum usb_role role)
> +{
> +	struct dwc2_hsotg *hsotg = usb_role_switch_get_drvdata(sw);
> +	unsigned long flags;
> +
> +	/* Skip session not in line with dr_mode */
> +	if ((role == USB_ROLE_DEVICE && hsotg->dr_mode == USB_DR_MODE_HOST) ||
> +	    (role == USB_ROLE_HOST && hsotg->dr_mode == USB_DR_MODE_PERIPHERAL))
> +		return -EINVAL;
> +
> +	/* Skip session if core is in test mode */
> +	if (role == USB_ROLE_NONE && hsotg->test_mode) {
> +		dev_dbg(hsotg->dev, "Core is in test mode\n");
> +		return -EBUSY;
> +	}
> +
> +	spin_lock_irqsave(&hsotg->lock, flags);
due to this spin_lock_irqsave() ...

> +	if (role == USB_ROLE_HOST) {
> +		if (dwc2_ovr_avalid(hsotg, true))
> +			goto unlock;
> +
> +		if (hsotg->dr_mode == USB_DR_MODE_OTG)
> +			/*
> +			 * This will raise a Connector ID Status Change
> +			 * Interrupt - connID A
> +			 */
> +			dwc2_force_mode(hsotg, true);
... we cannot sleep in here. the call flow is:
dwc2_drd_role_sw_set
  spin_lock_irqsave
  dwc2_force_mode
    dwc2_wait_for_mode
      usleep_range

> +	} else if (role == USB_ROLE_DEVICE) {
> +		if (dwc2_ovr_bvalid(hsotg, true))
> +			goto unlock;
> +
> +		if (hsotg->dr_mode == USB_DR_MODE_OTG)
> +			/*
> +			 * This will raise a Connector ID Status Change
> +			 * Interrupt - connID B
> +			 */
> +			dwc2_force_mode(hsotg, false);
(same sleeping issue here)

[...]
+int dwc2_drd_init(struct dwc2_hsotg *hsotg)
+{
+	struct usb_role_switch_desc role_sw_desc = {0};
+	struct usb_role_switch *role_sw;
+	int ret;
+
+	if (!device_property_read_bool(hsotg->dev, "usb-role-switch"))
+		return 0;
should we also return early here if dr_mode != "otg"?

[...]
@@ -532,6 +534,13 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		dwc2_writel(hsotg, ggpio, GGPIO);
 	}
 
+	retval = dwc2_drd_init(hsotg);
+	if (retval) {
+		if (retval != -EPROBE_DEFER)
+			dev_err(hsotg->dev, "failed to initialize dual-role\n");
+		goto error_init;
+	}
+
 	if (hsotg->dr_mode != USB_DR_MODE_HOST) {
 		retval = dwc2_gadget_init(hsotg);
 		if (retval)
I think dwc2_driver_probe() needs a new label (for example named
error_drd) which then calls dwc2_drd_exit. See [0] which I have
submitted as a patch for Linux 5.8, so it's not in usb-next yet.

Also in general I think you need to submit a dt-bindings patch that
documents the usb-role-switch property. Personally I would use
Documentation/devicetree/bindings/usb/renesas,usb3-peri.yaml as
reference for that.

Can you please keep me Cc'ed on a v2 because I'm not subscribed to the
linux-usb mailing list?
I am going to test this on Amlogic SoCs - once I made "everything else"
work I can give my Tested-by as well.


Thank you!
Martin


[0] https://patchwork.kernel.org/patch/11642957/
