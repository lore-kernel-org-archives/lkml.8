Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE47EC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E02206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 14:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FkwWdH4a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgHROPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:15:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44152 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726612AbgHRONr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 10:13:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597760025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=5mbAxZDicFpvBlanHGzWhCcTGWd2P55ViK8g3cXeULA=;
        b=FkwWdH4aSCWvowtfMT0QZPJ28EnbuWvr0+ixlqykVu5FXoc/NzPWWN8j8bEgcXB0Ty2Rv4
        VIw7AztZ4xA7vrxt/xqFTiGM3zmbxR649RRRYytRKCq4N4yGpLWcjDLlZXpC6pXF4u38Td
        ik9y6q8sg5c4BcrL9exCIl8UHpSNYfM=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-RoXA2-doPCeVZiEO-D16lg-1; Tue, 18 Aug 2020 10:13:43 -0400
X-MC-Unique: RoXA2-doPCeVZiEO-D16lg-1
Received: by mail-qk1-f199.google.com with SMTP id x18so13177851qkb.16
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 07:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=5mbAxZDicFpvBlanHGzWhCcTGWd2P55ViK8g3cXeULA=;
        b=gYVFmEQAOSu2/uk1UjMiALvlNfhptXEY+U2Y23q49g3Bx5N9tINTj8HgTSbF2bdJd2
         p42xxsXtlAABqAkYNqxhGeAHTS0004S4hUIcv/3tgsSots5sQrYP+NHlazaHEEtR3ig9
         8lL6RJqpOda6/xLziLzzRSbJpiJCcCy4dc/PtsZojyFICO88ZCqtZEaZ/qkyW227Vi1p
         S+PKFzSGCmbjyBEGCYPU4IinYiFXH/7+HhVU1vQsnqI/4auNbqKZtvD5GQiB6Nyx3Wa4
         4mAatIwzp2Vomp+2MS++IC4NdhbBbcx8msc9jq+EF7UrkBymvMqHU1NRqKH/zobTLFRq
         Mn+Q==
X-Gm-Message-State: AOAM532mI+9KxgtcFgEiZWUJCeP6yR6NY4b/nbNIgByOHcnK8nMTZiqs
        wFtjzaFXh9QpN+mh2pd0ohgRX7TIcsKZ8Uxk8JMoosZaXs3Xy3lKBomFy+nN6zXRnaAInT6ozrO
        gsuaSiFYrTs+GthNtJZyeXSSi
X-Received: by 2002:a37:654e:: with SMTP id z75mr17382723qkb.235.1597760022489;
        Tue, 18 Aug 2020 07:13:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxcNERkf07f873dxUZbjCVeW5+bdQ+AxXl1IqnadX9c2qONRAsyr32ogfC81RXvDcda3rufsA==
X-Received: by 2002:a37:654e:: with SMTP id z75mr17382672qkb.235.1597760021867;
        Tue, 18 Aug 2020 07:13:41 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 22sm20581510qkg.24.2020.08.18.07.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:13:41 -0700 (PDT)
From:   trix@redhat.com
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] writeback: clear auto_free in initializaiton
Date:   Tue, 18 Aug 2020 07:13:30 -0700
Message-Id: <20200818141330.29134-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Review fs/fs-writeback.c bdi_split_work_to_wbs
The CONFIG_CGROUP_WRITEBACK version contains this line
	base_work->auto_free = 0;
Which seems like a strange place to set auto_free as
it is not where the rest of base_work is initialized.

In the default version of bdi_split_work_to_wbs, if a
successful malloc happens, base_work is copied and
auto_free is set to 1, else the base_work is
copied to another local valarible and its auto_free
is set to 0.

So move the clearing of auto_free to the
initialization of the local base_work structures.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/fs-writeback.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a605c3dddabc..fa1106de2ab0 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -881,7 +881,6 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 		work = &fallback_work;
 		*work = *base_work;
 		work->nr_pages = nr_pages;
-		work->auto_free = 0;
 		work->done = &fallback_work_done;
 
 		wb_queue_work(wb, work);
@@ -1055,10 +1054,8 @@ static void bdi_split_work_to_wbs(struct backing_dev_info *bdi,
 {
 	might_sleep();
 
-	if (!skip_if_busy || !writeback_in_progress(&bdi->wb)) {
-		base_work->auto_free = 0;
+	if (!skip_if_busy || !writeback_in_progress(&bdi->wb))
 		wb_queue_work(&bdi->wb, base_work);
-	}
 }
 
 #endif	/* CONFIG_CGROUP_WRITEBACK */
@@ -2459,6 +2456,7 @@ static void __writeback_inodes_sb_nr(struct super_block *sb, unsigned long nr,
 		.done			= &done,
 		.nr_pages		= nr,
 		.reason			= reason,
+		.auto_free		= 0,
 	};
 
 	if (!bdi_has_dirty_io(bdi) || bdi == &noop_backing_dev_info)
@@ -2538,6 +2536,7 @@ void sync_inodes_sb(struct super_block *sb)
 		.done		= &done,
 		.reason		= WB_REASON_SYNC,
 		.for_sync	= 1,
+		.auto_free	= 0,
 	};
 
 	/*
-- 
2.18.1

