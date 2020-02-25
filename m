Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD1DC35E0D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75C0F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJIcjNpq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731355AbgBYRxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:53:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46937 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731345AbgBYRxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:53:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so76216pll.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BvrsPeqWN8PtkcsNQt8nmKsbCOyaPIU6nwAu5WHHWq8=;
        b=qJIcjNpq7sNoGonrSyBwsUENY6YaoKkRyUf20hxq8GnBbV3M27SCu0TVozV1KzZdlM
         8VBOe1y43XOXOxUEvDB+W7bWNdMDQgS3/Tstdgx/URb7qasOfRM4L+T6OTFEUKIksSZb
         Y8095fEto0/TFnclle7yDkOmHXwf+D7G95FlABoJfmhlv/oRE2KYDjFdLynf90Mu57c0
         /03xXJeFOzwv383EhjYytugA4QmBO9KJmPRVnVqEKk0jGojepBVvWUzwxQNBe5usWNUa
         HMterUg597cX+SsY3MY78kRiB7g6NRJUlVW0sEtn+8DRWhN1mni7MzBb95i+SVj8eOBV
         nxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BvrsPeqWN8PtkcsNQt8nmKsbCOyaPIU6nwAu5WHHWq8=;
        b=V1y5b0jSi74n3t+laCpwVm4qt4l9dFGDp/QjDREZDe1KiNV2QA4yRj/l3B0GZsvuHA
         Vyaov3Yf7/yI0GcFgu4R1x5EOT+Y5TdGJRCb5S4aCI0ogYHbeoi5VM4D4t7c/O+fR5Xk
         NpJYYzmds5jZuCyUxMFubtUoyjphPWxQ8mQhqTA9xUeUZ2aNgh0z0ge4PROPQ1MNfsPY
         iKAdERn3Drn/wFy0trOBsUsV75+xCuF4RATYLTVTX0e+SyEXJQHqJ1vTxHf3jXA6fY1v
         XByHPS9z+D6wdcqcEc2zd8ly1mIPHs2KQDXmIITrwIlS95sJZfOZH7tsr+ips/d9gyVw
         2LeA==
X-Gm-Message-State: APjAAAWISFPaoZ9Yhb61KhSn4Uq/wQAG8BnAdvYSLKOzyoNaLRugJE7n
        XGnnSrp/WNNg9wTKFDR2xwL5fIMEIYk=
X-Google-Smtp-Source: APXvYqyuKIgv1526C84JiSsSOclqQi0aMoZtQERj2XWo+5FnwHBWcbSGK4675peuZbzUFDL4AF5KFg==
X-Received: by 2002:a17:90a:9284:: with SMTP id n4mr123696pjo.69.1582653221195;
        Tue, 25 Feb 2020 09:53:41 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id v8sm18013291pgt.52.2020.02.25.09.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 09:53:40 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        ShuFan Lee <shufan_lee@richtek.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Yu Chen <chenyu56@huawei.com>, Felipe Balbi <balbi@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jun Li <lijun.kernel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Guillaume Gardet <Guillaume.Gardet@arm.com>,
        Jack Pham <jackp@codeaurora.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v8 2/6] dt-bindings: usb: generic: Add role-switch-default-mode binding
Date:   Tue, 25 Feb 2020 17:53:00 +0000
Message-Id: <20200225175304.36406-3-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225175304.36406-1-john.stultz@linaro.org>
References: <20200225175304.36406-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding to configure the default role the controller
assumes is host mode when the usb role is USB_ROLE_NONE.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
CC: ShuFan Lee <shufan_lee@richtek.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Yu Chen <chenyu56@huawei.com>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jun Li <lijun.kernel@gmail.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
Cc: Guillaume Gardet <Guillaume.Gardet@arm.com>
Cc: Jack Pham <jackp@codeaurora.org>
Cc: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
v5: Switch to string rather then a bool
---
 Documentation/devicetree/bindings/usb/generic.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/generic.txt b/Documentation/devicetree/bindings/usb/generic.txt
index e6790d2a4da9..67c51759a642 100644
--- a/Documentation/devicetree/bindings/usb/generic.txt
+++ b/Documentation/devicetree/bindings/usb/generic.txt
@@ -35,6 +35,12 @@ Optional properties:
 			the USB data role (USB host or USB device) for a given
 			USB connector, such as Type-C, Type-B(micro).
 			see connector/usb-connector.txt.
+ - role-switch-default-mode: indicating if usb-role-switch is enabled, the
+			device default operation mode of controller while usb
+			role is USB_ROLE_NONE. Valid arguments are "host" and
+			"peripheral". Defaults to "peripheral" if not
+			specified.
+
 
 This is an attribute to a USB controller such as:
 
-- 
2.17.1

