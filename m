Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72DC2C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53B672065D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 15:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pv2fPxp7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGGPtQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728191AbgGGPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 11:49:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D550C08C5E2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 08:49:14 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d10so16906548pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5vsrk7vEHY5/cQx0UlucywmyaBj8fW6BqF1VBBdS+A=;
        b=Pv2fPxp7OIeEF3uKCol9thsCERjYulCcAkB8AUk4Gwl1bXaMqg3qeUpmuYbfoG9h9f
         R5P3I1Ko6Ww0MIpmSFkLAAtMlFxfdZNVyLLOkErJST905aoYkJitnFGHHJ6iFlOuBYlK
         CgPKunazaYPhxRQlwQCb+IDxN7kMA+6YmsRDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e5vsrk7vEHY5/cQx0UlucywmyaBj8fW6BqF1VBBdS+A=;
        b=S0ejZxIfjAS8UT0XaDuYuICx7hz00mxi62kJq+FTCqADDstxwBzYQ53rA0/H8VOjY5
         LVbnytL53+ig4pebq0If9tdXDy/1uogXxAr4nFRD8cSafkq6M1VKyOdmblz7Ni7aVglw
         OJjin/WBH6+HDZUZBFpB6RKY+tklLxyeIeh9DP+AlTIIyUsg/NAF3lTLO37qIVIO421f
         SaEWGzrGQQOk2zTn4W6ivU9qwBSS4HclKRTag6Io1f7fZ2ZiUYoqPWekGMLOmWF11YSO
         WoSHFXhmAbAdCQQ/9XN8pk3hTPUJJBUaL5qPpfzbC2X6jEkw3yKP8C3+Xrou4CJRzFnk
         0ChA==
X-Gm-Message-State: AOAM533quBkZZQm2H5Z/CWfZ0xpxSzDahV+g9SyrPrCvaFoyPc3tJMrF
        ut7+Dpw+hI7XPeQqgfxM6hL5ww==
X-Google-Smtp-Source: ABdhPJzLS/0a5ZIkTRnBJsarvJBHCyL5ykuVlth8AWwaID0VPkNo2x7wmAhQzmyPS9TNjQsw6QlLFA==
X-Received: by 2002:a17:90a:cd01:: with SMTP id d1mr5071431pju.212.1594136953766;
        Tue, 07 Jul 2020 08:49:13 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id t5sm1360194pgl.38.2020.07.07.08.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 08:49:13 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>
Subject: [PATCH v3 0/1] power: Emit change uevent when updating sysfs
Date:   Tue,  7 Jul 2020 08:49:04 -0700
Message-Id: <20200707154905.2763616-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi linux-pm,

ChromeOS has a udev rule to chown the `power/wakeup` attribute so that
the power manager can modify it during runtime.

(https://source.chromium.org/chromiumos/chromiumos/codesearch/+/master:src/platform2/power_manager/udev/99-powerd-permissions.rules)

In our automated tests, we found that the `power/wakeup` attributes
weren't being chown-ed for some boards. On investigating, I found that
when the drivers probe and call device_set_wakeup_capable, no uevent was
being emitted for the newly added power/wakeup attribute. This was
manifesting at boot on some boards (Marvell SDIO bluetooth and Broadcom
Serial bluetooth drivers) or during usb disconnects during resume
(Realtek btusb driver with reset resume quirk).

It seems reasonable to me that changes to the attributes of a device
should cause a changed uevent so I have added that here.

Here's an example of the kernel events after toggling the authorized
bit of /sys/bus/usb/devices/1-3/

$ echo 0 > /sys/bus/usb/devices/1-3/authorized
KERNEL[27.357994] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill1 (rfkill)
KERNEL[27.358049] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[27.358458] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[27.358486] remove   /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)
KERNEL[27.358529] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)

$ echo 1 > /sys/bus/usb/devices/1-3/authorized
KERNEL[36.415749] change   /devices/pci0000:00/0000:00:15.0/usb1/1-3 (usb)
KERNEL[36.415798] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0 (usb)
KERNEL[36.417414] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0 (bluetooth)
KERNEL[36.417447] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.0/bluetooth/hci0/rfkill2 (rfkill)
KERNEL[36.417481] add      /devices/pci0000:00/0000:00:15.0/usb1/1-3/1-3:1.1 (usb)

Thanks
Abhishek

Changes in v3:
- Simplified error handling

Changes in v2:
- Add newline at end of bt_dev_err

Abhishek Pandit-Subedi (1):
  power: Emit changed uevent on wakeup_sysfs_add/remove

 drivers/base/power/sysfs.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.27.0.212.ge8ba1cc988-goog

