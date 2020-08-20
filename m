Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF65BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85B8020885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gEdI/Vor"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgHTR6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:58:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B02C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:58:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a14so2952414wra.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zFwgKY8M1YvMdF6A1MZQr5OX450yZVwCd9DoRqj8Oac=;
        b=gEdI/VorowmVYUmYIAgIJvT3GOEKZl+dMBWPHxFGafXrGNuusg1aHNcprr/9GpKUfb
         iAwi3wzEXEL5V+isGkdNfHkBwsZB87GNq52EY8vm1ICS84jMS+66QIttaB13wrHGyXTi
         vGPDVdiHXnESt3QYl3SQ3XOhoj7yd4EFtQkXSeUJmYlINRtnjSIWrnX4hiat3SbG6JYL
         V4TRAydcp5SQazAhY1kBahWw9dC3Y+QcW3cOlC/4iAr7w6rU2Pu51mgg6gRpHN8hdxJv
         7i3UVNDVp7tGOiXbW0lYqqqujYbpuwGLUyQ8dklG0mEfklFVpGjg7tDWzEcB0eWCtUYp
         MqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zFwgKY8M1YvMdF6A1MZQr5OX450yZVwCd9DoRqj8Oac=;
        b=pSDSbcoPfBg7XmFgRgN4JotjkwtsENmxHXcEq6lYEwYTUEK7zuYhYVVyAoODui9+h0
         iQiarqUBzwXSplEf+4xyc2GybWgZSZx4Vnfde0aJ3CzQZ4IfwwD4mrh/SkSkqhfR0GPd
         CKeI99vo9P+8VpoyvjjokN3xQ99H48RdYd9L2dbDnI8PiVSq4JJIcF15tQz4ZeLk1WuT
         txIX/3lJGw2OGR2dQd3mC5o1vcqihL80YjXIrCb+2hyytt62WJa/0j0a2XyrYF2G0Fev
         EX2K1dbP/4F9GbJmskfkuPKx8SSYXgklJdtbd1vGjFB6vaWen0JtqMyBH9S4rcMvG131
         gtgQ==
X-Gm-Message-State: AOAM530NZLXjs86wByaal5t8GgkV/a6COzHrsChfjIcTnAHbUgB3KsCI
        3jhkZdJ0LCdTEyRuJDPvX6c=
X-Google-Smtp-Source: ABdhPJyXW1lTfOHjnE0/ltL1g8SVD1FVRSMs7m5WVolWWiwAdcucLZtfJ4XvHtosDOlMEyjYgHbdQA==
X-Received: by 2002:a5d:4910:: with SMTP id x16mr4183128wrq.131.1597946325161;
        Thu, 20 Aug 2020 10:58:45 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id g8sm5513496wme.13.2020.08.20.10.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:58:44 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>,
        Nirmoy Das <nirmoy.das@amd.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: Remove unnecessary cast
Date:   Thu, 20 Aug 2020 18:58:06 +0100
Message-Id: <20200820175809.841479-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In init_powerplay_table_information() the value returned from kmalloc()
is cast unnecessarily. Remove cast.

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
index 195d8539fbb4..740e2fc7a034 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_processpptables.c
@@ -252,7 +252,7 @@ static int init_powerplay_table_information(
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_max, powerplay_table->PowerSavingClockMax, ATOM_VEGA12_PPCLOCK_COUNT);
 	phm_copy_clock_limits_array(hwmgr, &pptable_information->power_saving_clock_min, powerplay_table->PowerSavingClockMin, ATOM_VEGA12_PPCLOCK_COUNT);
 
-	pptable_information->smc_pptable = (PPTable_t *)kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-- 
2.28.0

