Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A344ACA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76B54206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 08:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DqDcp8eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732401AbgEMIpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 04:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732279AbgEMIpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 04:45:47 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D77AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:45:47 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z25so12782689otq.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 01:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjRThKWwLHjSiY1+NCteWSC3vDWu7uuGh+ybOg02DgQ=;
        b=DqDcp8eblVzW84Y89wVM5eFfNc+e3LPUmHKrNtJTBr7lWHzpVeG+BGsxBfoqWBOgK3
         rTQ7hxo5ReTTWmWkAdZx0vfvV1DSsZIawZCJy5KSHHx1qcUMK+ph9C1yZLxqndjzLwzj
         ddmEW26LZ1SkLlxLogiDijnAz5bXLloY+Ok4TvexHkFqpPkkvp1obqCWgHD3rrhyXnDf
         uSIxWXAc1gXMKISJD0C2PGFQ5Qg7WPjT+Mc37rx7uTDGZodmgiNeWAtjbhIYamqUa1MU
         2OIy/TzkfDtYIRTj5o8AL6fBtMOancIFBue9KkAZiq5/PLaiA35PVsuJhfziUnFEygEA
         DMAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rjRThKWwLHjSiY1+NCteWSC3vDWu7uuGh+ybOg02DgQ=;
        b=edNLafcPIW/6Q14yeNXfDjoDO02lbVQcBeLZcj1Kq6+aCM9Fwn7V8sKML8aAXFXNw9
         +oLC0UAMmQ3Wis1NUGJTVBOIH+cXAF6jOBzXZh3N3V+vJbf2CCTvhwLtkQgoIAUbralu
         4QIkG+tpsnjjQna0KCsCalsQPvU+Pb9LMdwkoZFYTObeFxqXWYakD5D8BBhOUzhwkh/5
         hKVKXDKdLNFG8cFaXufyHzEjbV2U2b7WmfkPXPSDdFovptDjR6cvAxhEeBPg6SYkLitX
         T9GdNmg/S5379RTRPFDyszDoYhNqsDPuOFPQ1wx9jRzI7hRlS3x61U6bOwNoINaCbanB
         /uHA==
X-Gm-Message-State: AGi0PuZ1r7GgQxFsjZkVXV8tdMSKzKKtFzuRNU2ptYl9M8SWh3orjZhf
        ryL5grAeROmNO+WYwkUjW2g=
X-Google-Smtp-Source: APiQypLanVlEHVKOR3y8IzYoz9O3q9YbxujP4Q41Y5F0JBoksXfgRXBaD+JzplS7hWUmFXTASnlq3g==
X-Received: by 2002:a9d:69c9:: with SMTP id v9mr20565203oto.267.1589359546632;
        Wed, 13 May 2020 01:45:46 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b19sm6004494oii.1.2020.05.13.01.45.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 01:45:46 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@redhat.com>
Cc:     dm-devel@redhat.com, Hannes Reinecke <hare@suse.de>,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] dm zoned: Avoid 64-bit division error in dmz_fixup_devices
Date:   Wed, 13 May 2020 01:45:22 -0700
Message-Id: <20200513084521.461116-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building arm32 allyesconfig:

ld.lld: error: undefined symbol: __aeabi_uldivmod
>>> referenced by dm-zoned-target.c
>>>               md/dm-zoned-target.o:(dmz_ctr) in archive drivers/built-in.a

dmz_fixup_devices uses DIV_ROUND_UP with variables of type sector_t. As
such, it should be using DIV_ROUND_UP_SECTOR_T, which handles this
automatically.

Fixes: 70978208ec91 ("dm zoned: metadata version 2")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/md/dm-zoned-target.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
index ea43f6892ced..9c4fd4b04878 100644
--- a/drivers/md/dm-zoned-target.c
+++ b/drivers/md/dm-zoned-target.c
@@ -803,8 +803,9 @@ static int dmz_fixup_devices(struct dm_target *ti)
 
 	if (reg_dev) {
 		reg_dev->zone_nr_sectors = zoned_dev->zone_nr_sectors;
-		reg_dev->nr_zones = DIV_ROUND_UP(reg_dev->capacity,
-						 reg_dev->zone_nr_sectors);
+		reg_dev->nr_zones =
+			DIV_ROUND_UP_SECTOR_T(reg_dev->capacity,
+					      reg_dev->zone_nr_sectors);
 		zoned_dev->zone_offset = reg_dev->nr_zones;
 	}
 	return 0;

base-commit: e098d7762d602be640c53565ceca342f81e55ad2
-- 
2.26.2

