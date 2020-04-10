Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE66C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 21:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F032078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jdcox-net.20150623.gappssmtp.com header.i=@jdcox-net.20150623.gappssmtp.com header.b="SX2J+Ttv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgDJVYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 17:24:32 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38090 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJVYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 17:24:31 -0400
Received: by mail-pf1-f195.google.com with SMTP id c21so1543967pfo.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 14:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jdcox-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6euz7U5YmKmQz+Yak4JttZC+1uZLCYust3fRq/4fkpg=;
        b=SX2J+TtvzD270OPTYyuhQ2jU2CbOtdPyRV5PGnOSRxdTBYQtdlUuDOkrYm5V7Y2JZd
         EIjHTgxJvBvuiVikzjw9i0yjZetMJTTQfuU9lCVFwTTjGpBuBYW83pgVWtdMIelyRlJK
         jc8cqoKYSuuqFsLIQp39Ge688T8MYg9+YNdicnd/YMmZa+Diwm7+9NTO4nIVnmaiC5FZ
         mDoiMrHo+fQcAoiXR6MNHgJCSYQyQIzRzPaUN7Osh6I5phEDnSqVhQKqL4+JcVY0uJQj
         UY2i1Fz5mhXCkpGkIxBdHrflV+dfHPIK2jwarn/uKvTmrv6KTZ2OBkD/nr96dlWJ6kVh
         cohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6euz7U5YmKmQz+Yak4JttZC+1uZLCYust3fRq/4fkpg=;
        b=pSHEyOR3lKO5U9heEU8ANi+0JkpNU/DlJ0I5G2PtqD4xc9+C3Nppnrjg2DDVQxwE5g
         LIFLqRPpgH0RT3X7XvUgo9H3SbYNAM07Wcr0Ek7Bq+xhDpeOq40U4tZZ8iKPfNnLS/nK
         xFSCeofRxOncGrdDEsFyCflkTzPNBzWxnkx5romE78swu9HrPqRGJk1ZYT9nVgd08ecG
         wXKu9/PDDbe9Iqt0ei566fHi0uYFah1LUhi2xpOCTwy7o9JicOJxsKpe/xJ1FpFGxrrQ
         MsYcdKZ2njVyG1P+Sv/kCX9emU5QjBBguyA32EbNHGIUxwP6i6pmAiNU1fdNqeVdn5JE
         lWeA==
X-Gm-Message-State: AGi0PuZ2Ca59kzDcylavkfVBOOVnitvFtdlgn40wYgGZ0cfv2Jzcawsh
        JVbdRwLhudiUamrt7fpN0uduN3Gk4U4N9g==
X-Google-Smtp-Source: APiQypLZyOFacadxGHhWqNzCFh/+JR8Ig7PHf8QWbtHrovZ7A84jUsb1d5U1qKmvuXYyvQa9t9sE2A==
X-Received: by 2002:a63:5050:: with SMTP id q16mr6191693pgl.118.1586553871316;
        Fri, 10 Apr 2020 14:24:31 -0700 (PDT)
Received: from jonathan-desk.jdc.local ([2605:e000:100d:4c16:feaa:14ff:fe96:2161])
        by smtp.gmail.com with ESMTPSA id y123sm2512075pfb.13.2020.04.10.14.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 14:24:30 -0700 (PDT)
From:   Jonathan Cox <jonathan@jdcox.net>
To:     gregkh@suse.de
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cox <jonathan@jdcox.net>
Subject: [PATCH] USB: Add USB_QUIRK_DELAY_CTRL_MSG and USB_QUIRK_DELAY_INIT for Corsair K70 RGB RAPIDFIRE
Date:   Fri, 10 Apr 2020 14:24:27 -0700
Message-Id: <20200410212427.2886-1-jonathan@jdcox.net>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Corsair K70 RGB RAPIDFIRE needs the USB_QUIRK_DELAY_INIT and 
USB_QUIRK_DELAY_CTRL_MSG to function or it will randomly not 
respond on boot, just like other Corsair keyboards

Signed-off-by: Jonathan Cox <jonathan@jdcox.net>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/core/quirks.c b/drivers/usb/core/quirks.c
index da30b5664ff3..4ed60e110a99 100644
--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -430,6 +430,10 @@ static const struct usb_device_id usb_quirk_list[] = {
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Corsair K70 RGB RAPDIFIRE */
+	{ USB_DEVICE(0x1b1c, 0x1b38), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
+
 	/* MIDI keyboard WORLDE MINI */
 	{ USB_DEVICE(0x1c75, 0x0204), .driver_info =
 			USB_QUIRK_CONFIG_INTF_STRINGS },
-- 
2.26.0

