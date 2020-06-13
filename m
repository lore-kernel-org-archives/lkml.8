Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22ABCC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F33232078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="H+zVnOxp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgFMTMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:12:19 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:50414 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgFMTMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:12:19 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49knKF6cp4z9vC9d
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:12:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P77DojhKMJa5 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 14:12:17 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49knKF4y1pz9vC9L
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:12:17 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49knKF4y1pz9vC9L
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49knKF4y1pz9vC9L
Received: by mail-il1-f199.google.com with SMTP id t69so5561336ilk.13
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=7Y813RYwwOmmJkghTui2SQXtpRd6JSwcveUdZ5xBrjA=;
        b=H+zVnOxpTd3c+HvoY9vSdECasdC3gd5/YMwDA6WMmolf8LpoOLgMDUw2pENL+mkikS
         RH2M1AwUq+6zzqsyQZN8fdjWs3BLeJD9LhekB+z8jrTSrhavyEg5EqDN0z2C/xZ7USg7
         JbcHdPSg4WiFhfDW3RzmbQ3AaNyDKCy3A/5l8wx0VmpMomx1lt4nDcB+7zabedbHcFvU
         sC7BzDoepUioE4QiuwUWLM26nqill51nddXkif6/y0o4B18zRrdYvO1Avxk/YeNBdzCh
         TyCyF69tyYi+9Nynw4UPTBXDq6codHG509j2HariqBvYG3SLMTXeiKkjyf2gspE7XVjF
         xm7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7Y813RYwwOmmJkghTui2SQXtpRd6JSwcveUdZ5xBrjA=;
        b=WtUQl+xHkTmGDL5r1GIMs479tahKqsD81/i6tbFFXDdTsowj6OQP9BJME9BUASCqa1
         mY9AOX39jLu/be8IULdeJ/0FIuA/Wp433Z/cHjF741Mv1LncOvnnWWGj45J1R+AGMqVK
         h06FQ9uBqELvGGF9mnjaRJ0Kn3lUGzCAUWRsyDqbNIFQJuZRNVfr2bqnc/MjwOCxJI6z
         2GSUefKkanKKi8G5L4erWltArSIX5Tpa0RhjEGyLL1pBqUXKQsSZpZCEsjtWU5XL3CBG
         9nQXcH1FCiFKqHN79YjhS5k4qAPlv8KxSyT4rXAGz90nwzievTYxs4tGVeXja1d++Fjz
         AQ6g==
X-Gm-Message-State: AOAM531biQc1EInY8xaX+ra4yRjlZPOAQ1AWPJhYUfyivbE7qWMt6d8G
        dLBK1z3/IsFPut1AGiQ0rGavir2jB8ltlh88VvqTexCdA0FIcHlK4ynEEc/gfhAwehBeX1IkIBb
        J54/tI+Anfjibi6r3u0x9NRAb8X/M
X-Received: by 2002:a5d:81d7:: with SMTP id t23mr20389784iol.142.1592075537263;
        Sat, 13 Jun 2020 12:12:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx+/rxm8FPOXE3DMK7ZgH7u5mt39dCTxUsJ1COUdSD3G4P4elphErpI/6dxxTTzODdZM35cYA==
X-Received: by 2002:a5d:81d7:: with SMTP id t23mr20389770iol.142.1592075537010;
        Sat, 13 Jun 2020 12:12:17 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id y2sm5060001ilg.69.2020.06.13.12.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 12:12:16 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Takashi Iwai <tiwai@suse.de>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] edd: Fix a reference count leak.
Date:   Sat, 13 Jun 2020 14:12:07 -0500
Message-Id: <20200613191208.17633-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.

Fixes: dd002e807486 ("Kobject: change drivers/firmware/edd.c to use kobject_init_and_add")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/edd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/edd.c b/drivers/firmware/edd.c
index 14d0970a7198..c8bb58824a76 100644
--- a/drivers/firmware/edd.c
+++ b/drivers/firmware/edd.c
@@ -718,6 +718,8 @@ edd_device_register(struct edd_device *edev, int i)
 	if (!error) {
 		edd_populate_dir(edev);
 		kobject_uevent(&edev->kobj, KOBJ_ADD);
+	} else {
+		kobject_put(&edev->kobj);
 	}
 	return error;
 }
-- 
2.17.1

