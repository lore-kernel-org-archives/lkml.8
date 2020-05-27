Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A7E6C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D682207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 19:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iSjjF+W7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgE0Tzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 15:55:48 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:50154 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728398AbgE0Tzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 15:55:46 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49XM5G0R5kz9vYy6
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 19:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fq-L_IA2FQS0 for <linux-kernel@vger.kernel.org>;
        Wed, 27 May 2020 14:55:45 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49XM5F5xp4z9vLH1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 14:55:45 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49XM5F5xp4z9vLH1
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49XM5F5xp4z9vLH1
Received: by mail-il1-f198.google.com with SMTP id q24so3572031ili.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=q3TLvJ9CIfB/1wbg5oIw6CZmCCpeVyOuikrOuGzN8wA=;
        b=iSjjF+W7C++RnXuhE6xA97IPJEc37+fmpoEckipRxMbfZd7b7rJ9U99XRoYCjMOUoE
         9bpsnGsBCPwrMuKtiyBQSdQXD06vFEj5R+v6qA7VyuLOexIruIZMnGDZx2UBWVzz2FHq
         OdxtczifndOGVGRZBd5gQowMpBEvPV/IPyPhEnn1a9ytoddnkZkuKjGQqXFV6aSbgIm7
         N/bfr9r0Pb/AekpiJKA5DvtWn2bFbBdTuzJPKEtTbqp23V/ASN47pwvt1grw3GxnWonL
         vfciYVl69sKcy7ew1k8B3dKcmHjMePfW9LqGwIfVcjgzyFQwGdjEZHUfCgT4q0pBLTfU
         YLPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q3TLvJ9CIfB/1wbg5oIw6CZmCCpeVyOuikrOuGzN8wA=;
        b=XFxrXqz4Xq8GI0OAUXhaTvOaw/yHtjgBLTS9TC+XcmJJVdm+MHjsGxWqo5mK04vqIf
         B3IvZgj9tzXGn0bECxAbFJdt2ClPiqps55Hl3z3QUFykTDvxX9bOuWl4sUHe8Sj2/y0B
         lejIcKpbvdW42Ii/XoPiR48iBExdlCK/hD8qvPU9NL8GADkn72qv8+pFVQRy+lUmn0cJ
         tjBp7Tx4LuJz4Ft2RrUH2ikRo60oOqnQNJcv1eZg+yY04/g1FzVlnv93C1uvAerzbUYz
         ljOh3fZqCrWiOe5iaxD3Gm3Cdjd/mdCu0SxjjTz7YWuEpVbhgfhoRZvSfmM51GWvZJew
         aPsw==
X-Gm-Message-State: AOAM532mVne3MX+BqKf3kSquOyTZ8zcr+J++TVKuE+Y3Hz/z0Shbr3tp
        TjQgrI26vXGb+JsB5ozru7GbSW7xYl6GkUpSuWakSSNFfgaOUjQYtepF3J5Lnpk7X0zOUeR528E
        Cx39KDgJiCELmX+uuu2K8huct/Ns7
X-Received: by 2002:a92:850c:: with SMTP id f12mr5148865ilh.86.1590609345275;
        Wed, 27 May 2020 12:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9CP+QzV9HstUrQjfwizvsa+8CrWyaTwz5Sh4uFEJsn3bJC2Whv3hZELa9M3ae1hc9u9LgnQ==
X-Received: by 2002:a92:850c:: with SMTP id f12mr5148837ilh.86.1590609344875;
        Wed, 27 May 2020 12:55:44 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id u1sm1596638iol.42.2020.05.27.12.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 12:55:43 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vyacheslav Dubeyko <Vyacheslav.Dubeyko@hgst.com>,
        linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nilfs2: Fix reference count leak in nilfs_sysfs_create_snapshot_group.
Date:   Wed, 27 May 2020 14:55:32 -0500
Message-Id: <20200527195532.28077-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

kobject_init_and_add() takes reference even when it fails.
If this function returns an error, kobject_put() must be called to
properly clean up the memory associated with the object. Previous
commit "b8eb718348b8" fixed a similar problem.

Fixes: a5a7332a291b ("nilfs2: add /sys/fs/nilfs2/<device>/mounted_snapshots/<snapshot>group")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 fs/nilfs2/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index e60be7bb55b0..b2517c5e773a 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -209,8 +209,10 @@ int nilfs_sysfs_create_snapshot_group(struct nilfs_root *root)
 					    "%llu", root->cno);
 	}
 
-	if (err)
+	if (err) {
+		kobject_put(&root->snapshot_kobj);
 		return err;
+	}
 
 	return 0;
 }
-- 
2.17.1

