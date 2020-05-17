Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B6DC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:35:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E572067D
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 17:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="udThLv95"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgEQRfB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 13:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgEQRfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 13:35:01 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD561C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:35:00 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id a7so8328450qvl.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 10:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=E8Lan1lVGAalxV7aOXnLLVOZi8STuKzmmVorzW8cW60=;
        b=udThLv95c17xKOqq6Zbqqup8Iy2Zn4zVnlkF5N/EO4EdHHP00zuQJluxG6SX+4Ogly
         +eFzVKZVeXH7NsWhIpO7nPw7nXkGo6K0WcK4yzb2iAt7COWkUiPdu0bhJ/TTh/03vxj3
         k+jEcEPXD1l3RMmhcTZwpX7wtkEmvD27BIij6KWs5q2BlhP0h6a6UPbwC563DvmaW0zJ
         0/Iaw4i03t1tOg6dtQR97ju9rAyf62r03MkuVfnUv+MNI/jz7VcnZwU2NxXa0UhVF46x
         ChB3jMwMyY45itBA8UZOPIS9jnIkfo+2qfIghmAnnjavsLO80LNKduL3mKeeIxQCe7jU
         BXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=E8Lan1lVGAalxV7aOXnLLVOZi8STuKzmmVorzW8cW60=;
        b=hmvlBRJJWgOjr9nO1yiQdzblJLOkZkoI9rz47Lz/Y8kpDLu8E5wIORR7y/sPVDtS+Z
         vbSv2cNgtoIzQWh/F/TpgOMbyLiy7VckLHf3JmNGW3DraGfCK6dUy3se7kfaqmdr/a/R
         j7kjrR9g8lBtzgGIDOqriHGT2RbBYjDePpqFTg/xN0n7yLxdlwV5PaTOR3HQbQ++AUf4
         kQS6ebscRO1uESuFaCdWFBYaLBke5V2gyHWt3z9uqf8rawEQr0r6z4MKDRU4Y5ZkBg03
         2g7DdnhuJ3CVzcJJL9NEdIfX0f0Nn9ugTqA4kJJp11tWY8+wtLe2uVXxBWX5HciWls1i
         fF8w==
X-Gm-Message-State: AOAM5302sCS1I5daDl1pUyfb7eBrrlALtLe8xMjYd6SnNEv0FzENPEtt
        gSxjc3z49UqJtOoy6CTgxhOP/1ndgwSBJS8=
X-Google-Smtp-Source: ABdhPJwnmolA1XadUuuUbj345XqWMgXquDlzfPY7m22VBISCtbWdMKRqFVEdYArb2FuSeTHCR/NYCpL4DVhmn7s=
X-Received: by 2002:a0c:99d3:: with SMTP id y19mr12392810qve.72.1589736899372;
 Sun, 17 May 2020 10:34:59 -0700 (PDT)
Date:   Sun, 17 May 2020 10:34:53 -0700
Message-Id: <20200517173453.157703-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v1] driver core: Remove check in driver_deferred_probe_force_trigger()
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The whole point behind adding driver_deferred_probe_force_trigger() in
commit 716a7a259690 ("driver core: fw_devlink: Add support for batching
fwnode parsing") was to skip the check for driver_deferred_probe_enable.
Otherwise, it's identical to driver_deferred_probe_trigger().

Delete the check in driver_deferred_probe_force_trigger() so that
fw_devlink_pause() and fw_devlink_resume() can kick off deferred probe
as intended. Without doing this forced deferred probe trigger, some
platforms seem to be crashing during boot because they assume probe
order of devices.

Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/dd.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 63991d97adcc..9a1d940342ac 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -169,9 +169,6 @@ static void driver_deferred_probe_trigger(void)
 
 void driver_deferred_probe_force_trigger(void)
 {
-	if (!driver_deferred_probe_enable)
-		return;
-
 	/*
 	 * A successful probe means that all the devices in the pending list
 	 * should be triggered to be reprobed.  Move all the deferred devices
-- 
2.26.2.761.g0e0b3e54be-goog

