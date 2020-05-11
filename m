Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AFFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CDA82075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 16:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I7Mts3+r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730706AbgEKQdm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 12:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgEKQdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 12:33:42 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C60C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:33:42 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id t12so9142782ile.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 09:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=et/ZymkirD1QygJLFDSmGkpZxp/V++5w/bxpZ0mAkxQ=;
        b=I7Mts3+ro62o7Ti94rrIyD0lIdQVdgJ6KCyjJLJF3I88OtJG7X+c0hKXo5Y8u0ec5N
         Po04BrhoAo0ZTA4qZlgwMoqipj8V44G3+ulzNGjpr3bHiZWsJGdm6AexFaeS/x4ZRwEM
         d0nm0LO5zZUDisAAmTkrRf3TRR9aC+PtGTxP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=et/ZymkirD1QygJLFDSmGkpZxp/V++5w/bxpZ0mAkxQ=;
        b=Hr4k4SY2JUoy9WhEsZNQlda6J0s4fiGjBd5oAYTABevJ3ndf4SR8UDZte5KFD3BMAi
         ZDIyxCwvUvBbHJL4/PDJ2qH1mggYdg2qR4tduHW/RBgOP5FqXLLqI0NGBx4iVt3KXbh2
         6fo7B6VM4lOlWFmpRSwZ/GkbgpkCH2RfOHGdO7q7OVIH3B3/DMehLhOlV73Q5BsSPeJ4
         v7rwU/A2aIDeKSb19ROiC6AC8SsJbHvvIksjTPsG2/E9Xd1t1BmbIWkyBRtmvOo5++Tj
         rJVvLpDyPGjYd9G3bU6spApWP9PvfhmwxijAep1ckEJdpJXu7GfInjgr+rAQJXji2EAL
         6hDg==
X-Gm-Message-State: AGi0PubRq9ylHDbLkKbU+j/PS9pmN3vh3QGBx5Vhkuci8OkLU1+Nb3UM
        EJY6oXdwafFWkodasPId4gLrYQ==
X-Google-Smtp-Source: APiQypJf+O/nDuyRo72ouM16+AEuR7MSnpTCFjwQ5vLlX2G0HUePUY7lEyQcCHD/5B6ubI5Ionwh3Q==
X-Received: by 2002:a92:d186:: with SMTP id z6mr16579261ilz.119.1589214821511;
        Mon, 11 May 2020 09:33:41 -0700 (PDT)
Received: from rrangel920.bld.corp.google.com (h184-60-195-141.arvdco.broadband.dynamic.tds.net. [184.60.195.141])
        by smtp.gmail.com with ESMTPSA id z86sm5312142ilk.79.2020.05.11.09.33.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 09:33:40 -0700 (PDT)
From:   Raul E Rangel <rrangel@chromium.org>
To:     Joerg Roedel <jroedel@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org
Cc:     evgreen@chromium.org, dianders@chromium.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] iommu/amd: Fix get_acpihid_device_id()
Date:   Mon, 11 May 2020 10:33:36 -0600
Message-Id: <20200511103229.v2.1.I6f1b6f973ee6c8af1348611370c73a0ec0ea53f1@changeid>
X-Mailer: git-send-email 2.26.2.645.ge9eca65c58-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acpi_dev_hid_uid_match() expects a null pointer for UID if it doesn't
exist. The acpihid_map_entry contains a char buffer for holding the
UID. If no UID was provided in the IVRS table, this buffer will be
zeroed. If we pass in a null string, acpi_dev_hid_uid_match() will
return false because it will try and match an empty string to the ACPI
UID of the device.

Fixes: ae5e6c6439c3 ("iommu/amd: Switch to use acpi_dev_hid_uid_match()")
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raul E Rangel <rrangel@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---

Changes in v2:
- Added Suggested by
- Fixed commit description
- Decided to keep `p->uid[0]` instead of `*p->uid` since the data member is an array instead of a pointer.
- Used clang-format

 drivers/iommu/amd_iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 20cce366e951..06f603366cb1 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -125,7 +125,8 @@ static inline int get_acpihid_device_id(struct device *dev,
 		return -ENODEV;
 
 	list_for_each_entry(p, &acpihid_map, list) {
-		if (acpi_dev_hid_uid_match(adev, p->hid, p->uid)) {
+		if (acpi_dev_hid_uid_match(adev, p->hid,
+					   p->uid[0] ? p->uid : NULL)) {
 			if (entry)
 				*entry = p;
 			return p->devid;
-- 
2.26.2.645.ge9eca65c58-goog

