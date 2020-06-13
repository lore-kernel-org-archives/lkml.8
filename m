Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28F6CC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 028782074D
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 19:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="khPav+o8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgFMTYe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 15:24:34 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:57230 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbgFMTYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 15:24:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49knbN16F4z9vJyy
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 19:24:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OM6-y1YVAYAq for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 14:24:32 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49knbM6Wmfz9vJyx
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 14:24:31 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49knbM6Wmfz9vJyx
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49knbM6Wmfz9vJyx
Received: by mail-io1-f70.google.com with SMTP id d197so8540250iog.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 12:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/QxHRbaXGeIVngJ41hbUByfwFxoFxOD2CW9N/HO02Lc=;
        b=khPav+o8NHhf8XdxYX1IEKp44SQIDD1wBCQ/9IJ1h1N9Xxi5JbAjsvXIS8yL2KP8EY
         i2FAt9HhbL6ShjvyetOaTehRdxVd31NnyrWbehv+wse/3JDSUnkhYFOKbyEsiyWBH6Ib
         1JV7wgXFMvOWLxVez/VpkvgoBHjqvJ5l5ZfJOAd4QnilO4pj5CUn2j3NNrCBs0bTX3e/
         p+ND8xxoRV1IU+BaJRevK3zl3KTfUjSNEX/AtUuunF4fXuePnVyr9J384MyRLARJHhRC
         mK1qRzdSFisYX8aBFqJsynudL+srr5rIblEAcUlQsjWQm+qDyUNeIP1O+jO1UJbAFNV0
         Dw5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/QxHRbaXGeIVngJ41hbUByfwFxoFxOD2CW9N/HO02Lc=;
        b=B4cazxfS5mtNpmwUzjSju8htJdRE2lVZp9LVfJFmJOMI7vfCix6pjDUOEsR85E9PLR
         poWLAyHCP0ga9OKie5Q0oyuasvz6AjssVslmI7ku5YA89sqwOBS/CzufXRcefKL+SXkE
         iEckRU/PI8ZUA4MBOBId6RYBIF8C7SvB82Vb5DrmTQW/rqg8dTeuc6LtBS67W2kK4kkf
         uUNGaeyXqeJyd0du5p5rbQjJMrvya5vM7CQGGsodOfhY7VBi6aUT/Hon4zFWvRAeqSYZ
         4BK+L4nCjIqp9vdZ86DhULBQRtXX9Sy1XzIre6Hv57HjcFPERAcL5GZcKuiYAbeb8CDu
         MRag==
X-Gm-Message-State: AOAM532cw5RyDeINbdI607AJiWKaU1rpY+diZFUcON51j+O1rX8zbSx1
        J1rAmt7Yx6VMqLJUZba4g6AMWPB9bn9JpkEwpbpssmlUNKnw7OPIPbjaaWxbYJcH8zcZO8mUCEc
        4Sl61YSoi3qcz7v/wkM2yxYR5f2qt
X-Received: by 2002:a02:770b:: with SMTP id g11mr14417081jac.69.1592076271488;
        Sat, 13 Jun 2020 12:24:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwg/ppuR6OiRtAZoudDotM4ChWEshjcTUZS3FzJmclW3HxnZ1bLh1GiluZbmBpql7vTiOlECg==
X-Received: by 2002:a02:770b:: with SMTP id g11mr14417059jac.69.1592076271255;
        Sat, 13 Jun 2020 12:24:31 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id y2sm5074584ilg.69.2020.06.13.12.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 12:24:30 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: dmi: Fix reference count leaks.
Date:   Sat, 13 Jun 2020 14:24:23 -0500
Message-Id: <20200613192424.19884-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object.
Callback function dmi_sysfs_entry_release() in kobject_put()
can handle the pointer "entry" properly.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/firmware/dmi-sysfs.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index b6180023eba7..9889e5ed2064 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -457,8 +457,10 @@ static int dmi_system_event_log(struct dmi_sysfs_entry *entry)
 				   &dmi_system_event_log_ktype,
 				   &entry->kobj,
 				   "system_event_log");
-	if (ret)
-		goto out_free;
+	if (ret) {
+		kobject_put(entry->child);
+		return ret;
+	}
 
 	ret = sysfs_create_bin_file(entry->child, &dmi_sel_raw_attr);
 	if (ret)
@@ -468,7 +470,6 @@ static int dmi_system_event_log(struct dmi_sysfs_entry *entry)
 
 out_del:
 	kobject_del(entry->child);
-out_free:
 	kfree(entry->child);
 	return ret;
 }
@@ -603,7 +604,7 @@ static void __init dmi_sysfs_register_handle(const struct dmi_header *dh,
 				    "%d-%d", dh->type, entry->instance);
 
 	if (*ret) {
-		kfree(entry);
+		kobject_put(&entry->kobj);
 		return;
 	}
 
-- 
2.17.1

