Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F49C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A55FD20757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 20:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HpHutjuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgDIU2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 16:28:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43320 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726291AbgDIU2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 16:28:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586464134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=bMeEAF8ikRSF8tzmPg03tQqSmmh0LSA2vooaQUzRW3Q=;
        b=HpHutjuLsSf8d6yUCwro5yMmEXTIYbS4+jinVF53BixOGTeBNiq1SdIfxvTcC7kE6cAwwp
        LET1F/1Atd/Bksodk+CkAf61JJfWOQP1av5qh1qZayc83YnHIfY8wyuuPjbWqJf5b2mDcw
        InLZAkWJc5ov+YlZ3SMkMiDeNv8dgQM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-mOC_oU0-M8WCcjJY-inooA-1; Thu, 09 Apr 2020 16:28:53 -0400
X-MC-Unique: mOC_oU0-M8WCcjJY-inooA-1
Received: by mail-wr1-f72.google.com with SMTP id j22so4083035wrb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 13:28:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bMeEAF8ikRSF8tzmPg03tQqSmmh0LSA2vooaQUzRW3Q=;
        b=rQsKA7pdrc0hhjvkUtOS81B9Nh43SU/wzQNgMLJYr3y0GvkbReGlfyOSrd+MMZkSwT
         Wu5DU0hQYNhvGRaGTa6NhaCz1IsQ6kbHiFBpDgxSk+NaKmWVwjyuJiyB2Bbh+n0iDAyP
         Op+xdHGQL520RNajiJZc0FUsfzIihs0j6dtvTEbDPuTVMruHkDEhiItLtUuBTW3F0dTC
         UNzdLUgbXjChJ6CR2py44UHU+MdzNLfqsSlbSMAuS0Pm2EA4GyF6r20mhjtKXBi9q2dG
         NCHaFgWviXs0y/S8D/L8y+0BeZDQOI7gxLVYBBVL8evNTTiholfkV/g9iTTGqkOB5dPT
         RkjQ==
X-Gm-Message-State: AGi0PuYrBgMt+uJgEbWWABDuq7tk5UPSLlIwSfMtsUCDgKH56HvTNwXw
        lrH2FBtR5VeXcLwoCLXeq4x2Z/tgRsHvtfmrq4Qayg31CJAff5w/Fz8Ca9w71PlRD0svanyglM1
        9JgyAxYdSRUl+AvYVGjzKnUrn
X-Received: by 2002:adf:eed1:: with SMTP id a17mr879994wrp.287.1586464131938;
        Thu, 09 Apr 2020 13:28:51 -0700 (PDT)
X-Google-Smtp-Source: APiQypJNn3RyOEcDrD6y8m+kaEcsbwziqz3QQkLPQ+QKzSv0QJhgUW1mk0pmUaP+kkcnSLyMEA1ftw==
X-Received: by 2002:adf:eed1:: with SMTP id a17mr879972wrp.287.1586464131731;
        Thu, 09 Apr 2020 13:28:51 -0700 (PDT)
Received: from redhat.com (bzq-109-67-97-76.red.bezeqint.net. [109.67.97.76])
        by smtp.gmail.com with ESMTPSA id t67sm5404037wmg.40.2020.04.09.13.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 13:28:51 -0700 (PDT)
Date:   Thu, 9 Apr 2020 16:28:49 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] vdpa: allow a 32 bit vq alignment
Message-ID: <20200409202825.10115-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_vq_align returns u16 now, but that's not enough for
systems/devices with 64K pages. All callers assign it to
a u32 variable anyway, so let's just change the return
value type to u32.

Cc: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 drivers/vdpa/ifcvf/ifcvf_main.c  | 2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 2 +-
 include/linux/vdpa.h             | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vdpa/ifcvf/ifcvf_main.c b/drivers/vdpa/ifcvf/ifcvf_main.c
index 28d9e5de5675..abf6a061cab6 100644
--- a/drivers/vdpa/ifcvf/ifcvf_main.c
+++ b/drivers/vdpa/ifcvf/ifcvf_main.c
@@ -226,7 +226,7 @@ static u32 ifcvf_vdpa_get_vendor_id(struct vdpa_device *vdpa_dev)
 	return IFCVF_SUBSYS_VENDOR_ID;
 }
 
-static u16 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
+static u32 ifcvf_vdpa_get_vq_align(struct vdpa_device *vdpa_dev)
 {
 	return IFCVF_QUEUE_ALIGNMENT;
 }
diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 72863d01a12a..7957d2d41fc4 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -435,7 +435,7 @@ static u64 vdpasim_get_vq_state(struct vdpa_device *vdpa, u16 idx)
 	return vrh->last_avail_idx;
 }
 
-static u16 vdpasim_get_vq_align(struct vdpa_device *vdpa)
+static u32 vdpasim_get_vq_align(struct vdpa_device *vdpa)
 {
 	return VDPASIM_QUEUE_ALIGN;
 }
diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 733acfb7ef84..5453af87a33e 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -164,7 +164,7 @@ struct vdpa_config_ops {
 	u64 (*get_vq_state)(struct vdpa_device *vdev, u16 idx);
 
 	/* Device ops */
-	u16 (*get_vq_align)(struct vdpa_device *vdev);
+	u32 (*get_vq_align)(struct vdpa_device *vdev);
 	u64 (*get_features)(struct vdpa_device *vdev);
 	int (*set_features)(struct vdpa_device *vdev, u64 features);
 	void (*set_config_cb)(struct vdpa_device *vdev,
-- 
MST

