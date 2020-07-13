Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2763C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B082720702
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xG84ESEP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgGMIBW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729259AbgGMIAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:00:22 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A9AC08C5DB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id b6so14739054wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rdi1fn55oJRjGxXwkklTmogqfEUJsJsRerMOamXHaW8=;
        b=xG84ESEPY2lyGkY8G3VX2aiONMR/r/3yXXU8Ta21b0wA6zz3XMFtSIHNCjCs0bTBHK
         G5q8Swe5hq0HnP9h4kP5ZXzxYba7ujJNr+RVaBw7m602pCRSHAaMFx9ILu4FcFAdl3qe
         DH7MnrZ75VZbl6KERQaaM3uO7rDDH+bV0M7/mCu7Ef55H15L49S4qiZVr+w1SGeu4JTU
         W0KrMmD/easJVAmBZJyLN1N2htq7B+EZQJQ55+7jgKhsB5qbbX01rl6jjAYMbuxLsqVU
         JyCFL67oZFgOF8F1zONuNAh3H9BwR1H92HHMQEm3rWyGxBQPcjsiVeru8237+Djxq8sc
         xBlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rdi1fn55oJRjGxXwkklTmogqfEUJsJsRerMOamXHaW8=;
        b=Ql/F5tEt59S8vJn3wxVK9mgkJvqfb+7YTzFpqOo1cIU/nEbZWpK1OJlBHeOU0yxZmr
         fn4Yk7U+HBT4qeyJfkJhehYVGUTm2pxzntyvDr3j4OI5LBD5pnq05ufd3hBu7lFkW75q
         dKQz+27vbxevQzJ4HxsFYqW4KmBEvxQD0tIMblYyMzny9VWOA1ueR9oej43t1z4Ac044
         xWtgjRYMd1ckihGQCBree77/dJ3pgdc2q90V4oLIicLzikIHQjCuo+w1BR6yHx+vnvbW
         pJS2JaUt0ndIhiGM9B2RwtTdnoLI6yh2HvyC6mBC88GwMiOqvY5jxqNyMc9jelRCTpCa
         6olA==
X-Gm-Message-State: AOAM531IRxkHLs1qjWNUejiSZfuvkFK1kF/Z/jVggIYbJermJkSUS5Mm
        tBI3NV77Er5oHPCRevvDaVUdYg==
X-Google-Smtp-Source: ABdhPJyLmfDaLTHwczipJR7031zJ1+pDQDmw8+mAafd5uDPNU+5mEJrH3X1NKEW0ppTUl/z4FSnHSQ==
X-Received: by 2002:adf:eec2:: with SMTP id a2mr77055761wrp.127.1594627220806;
        Mon, 13 Jul 2020 01:00:20 -0700 (PDT)
Received: from localhost.localdomain ([2.31.163.6])
        by smtp.gmail.com with ESMTPSA id 33sm24383549wri.16.2020.07.13.01.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 01:00:20 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 12/24] scsi: virtio_scsi: Demote seemingly unintentional kerneldoc header
Date:   Mon, 13 Jul 2020 08:59:49 +0100
Message-Id: <20200713080001.128044-13-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200713080001.128044-1-lee.jones@linaro.org>
References: <20200713080001.128044-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the only use of kerneldoc in the sourcefile and no
descriptions are provided.

Fixes the following W=1 kernel build warning(s):

 drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'vscsi' not described in 'virtscsi_complete_cmd'
 drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'buf' not described in 'virtscsi_complete_cmd'

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 drivers/scsi/virtio_scsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 0e0910c5b9424..56875467e4984 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -100,7 +100,7 @@ static void virtscsi_compute_resid(struct scsi_cmnd *sc, u32 resid)
 		scsi_set_resid(sc, resid);
 }
 
-/**
+/*
  * virtscsi_complete_cmd - finish a scsi_cmd and invoke scsi_done
  *
  * Called with vq_lock held.
-- 
2.25.1

