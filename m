Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF72C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F230217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 15:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581608424;
	bh=xtM+YC0fsXmRTgOGiXE3QIqZjxM4PwqTDLgPxouqRsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Bp+4oI1EEWy90z5TZ7o47nYHHDm1FaC8IGwulzVON9Q38uTlmOYCBT3Y/9oY8F5h4
	 WQ5p0YVD1E5eCTsSwmSKZ6YTyyyaFjOyW8zwNlYBzFrBGE/e53ZhApCy+sW2i50cLj
	 3b332keVaZoKY19UiSiMp0bZMfcLDybzI/14iWQs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgBMPkX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 10:40:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387782AbgBMP2p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 10:28:45 -0500
Received: from localhost (unknown [104.132.1.104])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5419824687;
        Thu, 13 Feb 2020 15:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581607725;
        bh=xtM+YC0fsXmRTgOGiXE3QIqZjxM4PwqTDLgPxouqRsc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dt9Eq1XKejM9cHaUPdNW1tbmnMhy0rb9WCccGROGBoMezb3MfTJavrI23myNKcqVU
         iLLYjVsMjKhvagbkL3hxBBGjWbObdvwIQKheUQ5A2Np87IqMkmLLXUbvuFPt0nc7x+
         F0ZSkm2PBzScniQZX0B2ZUQg8uoZbr8sJ8OffAtg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 5.5 054/120] platform/x86: intel_mid_powerbtn: Take a copy of ddata
Date:   Thu, 13 Feb 2020 07:20:50 -0800
Message-Id: <20200213151920.179682944@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200213151901.039700531@linuxfoundation.org>
References: <20200213151901.039700531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit 5e0c94d3aeeecc68c573033f08d9678fecf253bd upstream.

The driver gets driver_data from memory that is marked as const (which
is probably put to read-only memory) and it then modifies it. This
likely causes some sort of fault to happen.

Fix this by taking a copy of the structure.

Fixes: c94a8ff14de3 ("platform/x86: intel_mid_powerbtn: make mid_pb_ddata const")
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/platform/x86/intel_mid_powerbtn.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/platform/x86/intel_mid_powerbtn.c
+++ b/drivers/platform/x86/intel_mid_powerbtn.c
@@ -146,9 +146,10 @@ static int mid_pb_probe(struct platform_
 
 	input_set_capability(input, EV_KEY, KEY_POWER);
 
-	ddata = (struct mid_pb_ddata *)id->driver_data;
+	ddata = devm_kmemdup(&pdev->dev, (void *)id->driver_data,
+			     sizeof(*ddata), GFP_KERNEL);
 	if (!ddata)
-		return -ENODATA;
+		return -ENOMEM;
 
 	ddata->dev = &pdev->dev;
 	ddata->irq = irq;


