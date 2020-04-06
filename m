Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355A3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A93C206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 21:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hGDva9WH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgDFVfc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 17:35:32 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55612 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgDFVfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 17:35:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586208920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1aA96KgFgaIj2U2msrh3/QyeM1jNTu3MJRWpUI5kTTY=;
        b=hGDva9WHED6EhQFBoI647CpMwFENeeUkrHXOwCdzna1lHbsOrCC37eZN3dLLBCSqZFAGYe
        MaLWMb5eCtMhINRBtjM7Xc7HSuJ7U91NwwEIiY+D7v83E/sWshEsjifaD2kdPvN+qYLpK3
        8Odm5hXGT8wcwKYzmQOwjHXJEHb1x0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-70a91reLOT-6LIrl5OVNgw-1; Mon, 06 Apr 2020 17:35:19 -0400
X-MC-Unique: 70a91reLOT-6LIrl5OVNgw-1
Received: by mail-wm1-f69.google.com with SMTP id r8so154623wmn.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 14:35:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1aA96KgFgaIj2U2msrh3/QyeM1jNTu3MJRWpUI5kTTY=;
        b=WjzDZZwnkBiHTv2d3jIHOBb6HRAleM8gXrC8sReI+84k0wJrb3w5311oFsm5wE7UIx
         3K/Q+zeNvd7tOqJBok9+OmaLYbT3VLJFlVLkm2ZT8wTT5fracd0rJWwWSH7J6K15xiAj
         yRuc7HZ9Dq9QatcG583+15jYcPyRlaecrzwrRYhCGwBTTIkfXH1/TxxsU6a56Vu6qpyq
         /3mYh9O4chMVe4ZXY9yewldJeC3w2FsnMc7kZK+CZNnlGBWCKKApSLn+pB9zwO1ehNS9
         aLDTwIV6gvANNyG+3ODEKBBrELHLlXre9cEdxi8ekpq83VbXB0ufI1pwVfQJRxeUHyuG
         VTFw==
X-Gm-Message-State: AGi0PuYlSq/M3vqC5NJNwwtQPtrT5H8k2baq0zWAatPJ/B3gsBq60Dml
        ihX1jiY4RKSNx23hzCIOQ+K0qeff7y9jmWK2aSZbB9qpMnncSBat0ODngbblSzfMIdA1rZo/2Kb
        YVl2MapPZ9HSNbhKFpGLvVesq
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr1335910wmj.17.1586208917729;
        Mon, 06 Apr 2020 14:35:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypKHBE9kKX63pgbMP3pjCKoJHM/e8bwVo/gQ4w7SHS7x5DBizLjnjROi7qHhV5To0pZbVsHmIA==
X-Received: by 2002:a7b:cb45:: with SMTP id v5mr1335889wmj.17.1586208917509;
        Mon, 06 Apr 2020 14:35:17 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id m21sm1071211wmc.6.2020.04.06.14.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 14:35:17 -0700 (PDT)
Date:   Mon, 6 Apr 2020 17:35:15 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v5 11/12] remoteproc: switch to virtio_legacy_init/size
Message-ID: <20200406213314.248038-12-mst@redhat.com>
References: <20200406213314.248038-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406213314.248038-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are used for legacy ring format, switch to APIs that make this
explicit.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

maintainers, pls ack merging this through virtio tree due to dependency
on previous patches in the patchset.

 drivers/remoteproc/remoteproc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 097f33e4f1f3..c350a01e6c4e 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -322,7 +322,7 @@ int rproc_alloc_vring(struct rproc_vdev *rvdev, int i)
 	struct rproc_mem_entry *mem;
 
 	/* actual size of vring (in bytes) */
-	size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
+	size = PAGE_ALIGN(vring_legacy_size(rvring->len, rvring->align));
 
 	rsc = (void *)rproc->table_ptr + rvdev->rsc_offset;
 
-- 
MST

