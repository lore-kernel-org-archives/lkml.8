Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E252BC433EB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0A020672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 08:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="KKqLZ5nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgG0ICF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 04:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG0ICE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 04:02:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F53BC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 01:02:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id p1so7595553pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 01:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aKrJE9Py1tsJLs5WZM0aY5vQOQN0nZ3c2moryg/s6o=;
        b=KKqLZ5nwx7nxpoPwMu9qwSR1JM5EddcoP1pbxCt7v3rbmO55ujS/kCvtb6LFy0pXOt
         1N8ISZQ8RPBeYIS6BLNxRucrOVz1Ixy4va6HxddeXzoN3OLxLmR5Z2iStw5nPR9k+8by
         F8aWzDLSdvNQ0YT56u3WCrMZ5MkwhiXTAyDxMfKpSsFlD+lyrfSKIxHGTyVXSPnryIaN
         nf/SSw0LsQNMMSMed5JIr/m/0CDjrRn5LGOvBbOo5DwMVPSIp3+Mz9O8mdp0hOhnbKOp
         u/EMI8h5+BJmBut7v4UQFg544FzC1RpmJtOKdhU762u5NMuOlLLEhvtW7RKParzmyP3x
         AtxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0aKrJE9Py1tsJLs5WZM0aY5vQOQN0nZ3c2moryg/s6o=;
        b=nPx1jPVtoLufkSgJ49lsmNK99L6/ysIokLqxEprbFT4G54O5lyBIIByU44k44956ky
         Uu2zCjutMaF/6Vj1nZal1/a6hHOh6dbzQkKXkhcknI+Q6X/WmhQuZi7Uv7sO4K7A6f5h
         fI5tQc0ndpFuO3+y1Lmavtu1snrcamklQQpB2hj4GdVaV73f/IAxbEQLpNkkN5ZCpCf1
         g1uQmSNE+ztCStWEEnyialvtcSCwyfEFVPXMf2bmPdtWueFIAOmAqQsBizx/eE7BM69Q
         7FbdEc2053ZFlq84ScIuo9mSJWTZe+yfQwpMzHuwDEdwWzwT1vkQZJvwu2S37FRYLdru
         KqjA==
X-Gm-Message-State: AOAM53271IWLM/rVKYOTsi8GQ64E4X93uUl9diC+QWy6tEhO+JS16Z5b
        hjdikhb43CHts7OZdJNcIKURfg==
X-Google-Smtp-Source: ABdhPJxziIblCT8HYAbJj1Tahx3ppMGS4qWuh83g0+lwwyyTBn4XTjVDzrY+1PhUQvEXSnOUioUrLw==
X-Received: by 2002:a17:90a:1109:: with SMTP id d9mr17853767pja.201.1595836923781;
        Mon, 27 Jul 2020 01:02:03 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id bv17sm1164494pjb.0.2020.07.27.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 01:02:03 -0700 (PDT)
From:   Ankit <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH] Staging : media : atomisp : pci : fixed a brace coding sytle issue
Date:   Mon, 27 Jul 2020 13:31:50 +0530
Message-Id: <20200727080150.10659-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankit Baluni<b18007@students.iitmandi.ac.in>

Fixed a coding style issue.

Signed-off-by: Ankit Baluni<b18007@students.iitmandi.ac.in>

---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 8ea65bef35d2..28b96b66f4f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4981,9 +4981,8 @@ enum mipi_port_id __get_mipi_port(struct atomisp_device *isp,
 	case ATOMISP_CAMERA_PORT_SECONDARY:
 		return MIPI_PORT1_ID;
 	case ATOMISP_CAMERA_PORT_TERTIARY:
-		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID) {
+		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID)
 			return MIPI_PORT1_ID + 1;
-		}
 	/* fall through */
 	default:
 		dev_err(isp->dev, "unsupported port: %d\n", port);
-- 
2.25.1

