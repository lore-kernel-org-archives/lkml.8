Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5206C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:02:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADD69207FB
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eKvpq7Vc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbgGQJCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgGQJCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:02:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2E1C061755
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:02:16 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id o8so13867512wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DQl00yYXYwsbpEtRwxsV9i6tqBPWGw0OYdTItL8Npos=;
        b=eKvpq7Vc+pWXLiZBlozFZ+/crmGW074XhcYNp3r4fmPCGI8tcs9WINywIQKdsPseE2
         8ANxuaBJTN/gfFuBoIKiKMD6t/RoizLQC/C5FpqaQuNzoK80pqOr/gkmFMoH6nt0lItv
         fwm7+63jhaXuoSSeEEcHzQQuQqzfAfoV62LvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DQl00yYXYwsbpEtRwxsV9i6tqBPWGw0OYdTItL8Npos=;
        b=WSIMGop1u+zpj6N8+lolU1NxitlGaozJwZu9RaQra3FsHDYzDr+sJKcJiWIX83d7iZ
         G6RLh9YIyaDaXZP6bhNJVplpBKV1hj0KGwRuM2ZaN8fWiDWrBaGwRuYxKekoPCxH7x2x
         isS/3ma6KzrOjee4dLVZOvUySk6J6SWCYKFxgMGGEEJcuVSBFpJBFTrc9i5W4TvmBRrp
         aake4NXJ3PfUwxhi4CDPy6quVB792OoJpH1ZKmyc3gHI3x2CMyg5umu5iHCJ1NwlJgTz
         C76FDyCT6xtOIg9hDf9HqxXCtJUXXJKsyiQ1p/FpDhsXvJtmQwelz7pOd2rd96QDmcOv
         qpLQ==
X-Gm-Message-State: AOAM533hEICbRFbpPPR6oxcTKGMpSZi2+kdzwEySQiR8jeuYSAlagcJ2
        xbaqwXswjUU5uh51x99/174GNA==
X-Google-Smtp-Source: ABdhPJxkxy6FlQOiuxDgHDw4Xc4tE6UUCy+720USQNgwde4/nwbXPW0bbDuGrlGPXgKWc23kFw+LHw==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr8559807wme.102.1594976535435;
        Fri, 17 Jul 2020 02:02:15 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id w7sm12360705wmc.32.2020.07.17.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 02:02:14 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Lori Hikichi <lori.hikichi@broadcom.com>,
        Robert Richter <rrichter@marvell.com>,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/2] i2c: add PEC error event
Date:   Fri, 17 Jul 2020 14:31:54 +0530
Message-Id: <20200717090155.10383-2-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200717090155.10383-1-rayagonda.kokatanur@broadcom.com>
References: <20200717090155.10383-1-rayagonda.kokatanur@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new event I2C_SLAVE_PEC_ERR to list of slave events.
This event will be used by slave bus driver to indicate
PEC error to slave client or backend driver.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
 include/linux/i2c.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index b8b8963f8bb9..e04acd04eb48 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -370,6 +370,7 @@ enum i2c_slave_event {
 	I2C_SLAVE_READ_PROCESSED,
 	I2C_SLAVE_WRITE_RECEIVED,
 	I2C_SLAVE_STOP,
+	I2C_SLAVE_PEC_ERR,
 };
 
 int i2c_slave_register(struct i2c_client *client, i2c_slave_cb_t slave_cb);
-- 
2.17.1

