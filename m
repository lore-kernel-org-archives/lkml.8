Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB4FC4CEC0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E1F920746
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rO+x2ooT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730588AbgCKRVj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:21:39 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38927 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730534AbgCKRV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:26 -0400
Received: by mail-pj1-f65.google.com with SMTP id d8so1348824pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jz3XZ9gPuD/g+1P6LY7Aq8wTOFKwQIrTyqi7Mx3AGIU=;
        b=rO+x2ooTJs6RHFaCLJeavaPqt1U0ldl4u5LGBhrS3ghIhNbtJ/WxxbmpLS6TJs3w01
         kD2a2IMWmNi21t80CVUXRc13YMG7cAtzmsqnbBK6MBcGf5iSpF5uYvpizqQb2zgC1gNW
         YWgvnFoGWncG1yk9vgnbuJ5eRbLorjb5fCobeqTv3+krW82txy+FBsVQuIEAY8RmI5mT
         VC/QJyG/46z1Nn2Lfza1LbC59YDkh63IKsk09Z91z2HfEI5+wSK3/vqazrRF/ywOUIEj
         IG+/KOEXs9LFceA10o3rwGyBgwqJH8XjJ+ifdsPbFGBv2e1zJij43YC+bPbbTVEogRnv
         zGwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jz3XZ9gPuD/g+1P6LY7Aq8wTOFKwQIrTyqi7Mx3AGIU=;
        b=E7bGKEQETjDtgL8H8CF6xDZyhbCsEdbgAsvUSYbbgM4WkKlSYwE2lUrTchhOhzKmOP
         J7gV8dWjyAP/xVqu+x4WAAl3yFn2Dthoury77sU9x8pB9f6GVvyaf8378mELFULzgMlU
         s7IbRAqiz5oRD/DaCvlqD7+lU4mjn/d/zC9rUMbrjSOTh5gSndUkZqqIvybnjfw7oMNv
         lEI+ZBJyjhOzBWTBZ3R1zHBTDv2dXv95PuOM9vKXEaDCZtLI/U/hXs3ftwKlheui57he
         Q2z7mtUP+DPYDvBOttZt5WCBtkx7wes1wuhnOx4QTaH42p7qMIImLaHsKDGT/pb/P02i
         Qwfg==
X-Gm-Message-State: ANhLgQ1lW9YKJ51x1eoR7jtvz2fs6RZld/WEE2mtQJ4JXZvFGbmK7zdW
        aA9Xi4Fw8b3G8399b5UrPL2AliXLo2w=
X-Google-Smtp-Source: ADFU+vu2RYb/ys4TWWZMX1MZdw6Mdk95kbzQ9iGo2QeQeW5PGe1fsCKa7TEStuItFnNw2Np1vUjKiw==
X-Received: by 2002:a17:902:61:: with SMTP id 88mr3962846pla.313.1583947284955;
        Wed, 11 Mar 2020 10:21:24 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id b24sm14914053pfi.52.2020.03.11.10.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:21:24 -0700 (PDT)
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
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [RESEND][PATCH v8 4/6] dt-bindings: usb: dwc3: Allow clock list & resets to be more flexible
Date:   Wed, 11 Mar 2020 17:21:07 +0000
Message-Id: <20200311172109.45134-5-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311172109.45134-1-john.stultz@linaro.org>
References: <20200311172109.45134-1-john.stultz@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rather then adding another device specific binding to support
hikey960, Rob Herring suggested we expand the current dwc3
binding to allow for variable numbers of clocks and resets.

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
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Suggested-by: Rob Herring <robh@kernel.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: John Stultz <john.stultz@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a47ad85..29768b0ca923 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -7,7 +7,8 @@ Required properties:
  - compatible: must be "snps,dwc3"
  - reg : Address and length of the register set for the device
  - interrupts: Interrupts used by the dwc3 controller.
- - clock-names: should contain "ref", "bus_early", "suspend"
+ - clock-names: list of clock names. Ideally should be "ref",
+                "bus_early", "suspend" but may be less or more.
  - clocks: list of phandle and clock specifier pairs corresponding to
            entries in the clock-names property.
 
@@ -36,7 +37,7 @@ Optional properties:
  - phys: from the *Generic PHY* bindings
  - phy-names: from the *Generic PHY* bindings; supported names are "usb2-phy"
 	or "usb3-phy".
- - resets: a single pair of phandle and reset specifier
+ - resets: set of phandle and reset specifier pairs
  - snps,usb2-lpm-disable: indicate if we don't want to enable USB2 HW LPM
  - snps,usb3_lpm_capable: determines if platform is USB3 LPM capable
  - snps,dis-start-transfer-quirk: when set, disable isoc START TRANSFER command
-- 
2.17.1

