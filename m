Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BAFC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20264205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 03:36:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw1UmYYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729769AbgCPDgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 23:36:13 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38313 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729750AbgCPDgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 23:36:13 -0400
Received: by mail-pl1-f196.google.com with SMTP id w3so7343930plz.5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 20:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RN5LEm2Ln6UJgsZb2Xcgn8JEfugZQTYW/WUCQ061ChE=;
        b=fw1UmYYU9/rm9lgm2cwI72orTS1NcCsphYzCKyo3sxJoTiOH4SnhSoa8Mn+2RhdhIU
         uzx3IV/AzdVuGGJDk9sYHYz9CDfHFFGDCfPJSPlQmaCMQM089fcoklutF2gS7ji5dExk
         rCOM7D5anxq8bEMPwHiXLz7rPW6ekh5zWN110w198ZgFE6iqGsgVE9eoI+lE51xgFnfB
         WN8kvNzbfBB/Fn7ujhXOo/2bOFp5fRywaRxqOgIVUQ8die8xy1uiWYho/R2Hu2VIN22B
         rjPPtlXoQj45IXB4eL6Ya97g3ywLIqlwhH61SDjnPbozbsVIZ1Dtnob+OQNsQCkFDEXM
         /Rqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RN5LEm2Ln6UJgsZb2Xcgn8JEfugZQTYW/WUCQ061ChE=;
        b=SmhScKKhyRmnpbXwbVuDjr2WYjf0cF9k69yZdVXNomlPt0CsP4aqweSdICqmt8u2p8
         wt16dwIZRNUJhL8Q5NoAYacsUbbPXv6WAdQ+CYYnavOQSagrIEXIgs9bXfGazLguzAqa
         UvFn6oiNq6KKt0hIOL7uNkTq2Tw8ULq2SM0HE40Qc82tyBfbkwOAlSzPhOcfhaXBGj/G
         wqc9pcmpqyx/YMimDTvzuA07rVFlTb5j+UjVP0/b6/nJyJ2WzWHBFsCmjKKpOpObgK63
         ZOEwCA2Jwhcp/0HqJuj6k5CpCSuyYprx0CAGIhb2oab9P6ZTvV+RA19vED2sjkvi/4QD
         7noA==
X-Gm-Message-State: ANhLgQ3AHkGOR0zM5F9hLJUfWyE3U3bqyyQam9wLvFkDwInu3Ml7+Mck
        +LCq/7pL4Z3z50fwSrMOZZBJbU0t
X-Google-Smtp-Source: ADFU+vsZ//NWLkkQzxFIYJQuFmwMBRXMmi6l8kqyMnAHHWqVpYMJACZhlO6eHteKivEnhtXDqyOX1w==
X-Received: by 2002:a17:90b:8f:: with SMTP id bb15mr21271182pjb.186.1584329772317;
        Sun, 15 Mar 2020 20:36:12 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id my6sm20167168pjb.10.2020.03.15.20.36.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2020 20:36:11 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH] drm/lease: fix WARNING in idr_destroy
Date:   Mon, 16 Mar 2020 11:36:08 +0800
Message-Id: <1584329768-16119-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

leases has been destroyed:
drm_master_put
    ->drm_master_destroy
            ->idr_destroy

so the "out_lessee" needn't to call idr_destroy again.

Reported-and-tested-by: syzbot+05835159fe322770fe3d@syzkaller.appspotmail.com
Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/gpu/drm/drm_lease.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_lease.c b/drivers/gpu/drm/drm_lease.c
index b481caf..54506c2 100644
--- a/drivers/gpu/drm/drm_lease.c
+++ b/drivers/gpu/drm/drm_lease.c
@@ -577,11 +577,14 @@ int drm_mode_create_lease_ioctl(struct drm_device *dev,
 
 out_lessee:
 	drm_master_put(&lessee);
+	goto err_exit;
 
 out_leases:
-	put_unused_fd(fd);
 	idr_destroy(&leases);
 
+err_exit:
+	put_unused_fd(fd);
+
 	DRM_DEBUG_LEASE("drm_mode_create_lease_ioctl failed: %d\n", ret);
 	return ret;
 }
-- 
1.8.3.1

