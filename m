Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90030C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7208321744
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Et0ffPIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHDSg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgHDSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:36:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A99B7C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:36:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id c16so23298280ils.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=NximXCR+X9ioznzMmPae/3L/NXwCllFU33x91drOXbw=;
        b=Et0ffPIuGjJMb9ycXDU7UY4Tr2Kz4fe7myjbq1jxyFcY5nkzlWMKpW+4l7j+SBpEqJ
         T1iKQrocmnYV6AZkyNLOV+nZXXkbxk/ykxj7/aOB4rq+XtbBID3YXLMKa/Buq9QvSIyf
         6JOpaF7c34Qb4LYC0/JPv4CEmTzNxyca0ohWjm8M01AfNm15uP6gLUloUvzDavHRRC5x
         7Dk6LbR5O4Hyu4PtBQyYsP4RtcM27GECiu5sVXFJiPfTLf8V36lAKj78hJ5vXLj8KKrV
         DH1/EDRxw1nzeBdEm0pwfiqiE7/VQU4Eq18DCNzt84Me1SuaUPU67+XSbFaMa72XaHoZ
         5sBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=NximXCR+X9ioznzMmPae/3L/NXwCllFU33x91drOXbw=;
        b=oUwcgO1FwKa4dwOJmI68CMnbdCUtD4mzSd8WnVZlf3jxKxjil0OLCmdlK2ULj07vp+
         CDqXbZO43JqSw7MAEu72SWoz7UFipjmttY4wtZ8PdUli37ol0Wgane8X9PeT9z6+Hk1Z
         Ord/d95mdhucGvMZsec2pB3tk8wtJkYB6aO5JVGD5lWnuNCPKB30D3K8Lhf0OICTluVZ
         PESRutxdSQMFuw6Z4NpBwhf31r/ASRSMpjRc1AH/OiXQuOpU/UkL/aX5Lls8IHwpLpvm
         LKC4RkcKpWSyCr+Bdu1xOakQ14iLD2vLgQA34Ee0HgadLOJ5pJhVsBar4tHQON1RKcm0
         /hHQ==
X-Gm-Message-State: AOAM532UDCOFuQmDN54s/7lhPZq8MA0kjQOdetGVVUuDysnsvY1RG2gQ
        bSpzHOjfLIO+t7ms/mrir88=
X-Google-Smtp-Source: ABdhPJzdbhSiu5ZeIf2UgfewtIQxiZCZD3i7G0Lsd/r/94iYLOoASlpHWCdroDravDL7F9WNrmgqQg==
X-Received: by 2002:a92:6c0b:: with SMTP id h11mr6143276ilc.66.1596566217029;
        Tue, 04 Aug 2020 11:36:57 -0700 (PDT)
Received: from localhost.localdomain (x-128-101-215-112.reshalls.umn.edu. [128.101.215.112])
        by smtp.gmail.com with ESMTPSA id o2sm13156346ili.83.2020.08.04.11.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 11:36:56 -0700 (PDT)
From:   James Bond <jameslouisebond@gmail.com>
To:     jameslouisebond@gmail.com
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@suse.de>,
        Mike Waychison <mikew@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] firmware: dmi-sysfs: Add clean-up operations to fix refcount leak
Date:   Tue,  4 Aug 2020 13:36:49 -0500
Message-Id: <20200804183650.4024-1-jameslouisebond@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the documentation of function kobject_init_and_add(),
when this function returns an error, kobject_put() must be called
to properly clean up the memory associated with the object.

Fixes: 925a1da7477f ("firmware: Break out system_event_log in dmi-sysfs")
Signed-off-by: James Bond <jameslouisebond@gmail.com>
---
 drivers/firmware/dmi-sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/dmi-sysfs.c b/drivers/firmware/dmi-sysfs.c
index 8b8127fa8955..848b6a0f94eb 100644
--- a/drivers/firmware/dmi-sysfs.c
+++ b/drivers/firmware/dmi-sysfs.c
@@ -457,8 +457,10 @@ static int dmi_system_event_log(struct dmi_sysfs_entry *entry)
 				   &dmi_system_event_log_ktype,
 				   &entry->kobj,
 				   "system_event_log");
-	if (ret)
+	if (ret) {
+		kobject_put(entry->child);
 		goto out_free;
+	}
 
 	ret = sysfs_create_bin_file(entry->child, &dmi_sel_raw_attr);
 	if (ret)
-- 
2.17.1

