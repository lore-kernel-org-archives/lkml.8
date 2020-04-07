Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25925C2BA1B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96572145D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyY8uJnQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDGBRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:17:07 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40327 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726803AbgDGBRE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:17:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586222224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TEc48I7L40swgY91SNpoqqlFJs2YDtsi09a3nE4rzt0=;
        b=EyY8uJnQsODxgtYdRHKrxT70DpOo7eT6vM80jlJwXpz/V4NU5aXH+WRtstnXxeJKYZ8m0e
        YaPb4kgUd/szLo+z992KKvVstqVmaYxPmeXcoQUcCq7fZJtpGeP9Auj4aigCihvYcA5yBz
        9myPIpkteKNafLJZb5vyeHwCSiP0AnY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-bKvtSIOuPCWVC_LTQTVm6A-1; Mon, 06 Apr 2020 21:17:02 -0400
X-MC-Unique: bKvtSIOuPCWVC_LTQTVm6A-1
Received: by mail-wr1-f71.google.com with SMTP id y6so846007wrq.21
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TEc48I7L40swgY91SNpoqqlFJs2YDtsi09a3nE4rzt0=;
        b=tozCUBDzFWJJ/8E7tJHkCFlxWBeYX01Vzu4eYKi05M0P9s7mvKcnEy7PtaUdfh2pXc
         I8HTtlwWgbaaBxwhQAHY62hGtDnfJRninHe6rIRRCmVLA3BogDnat9QL5F4CGF9Mbjrk
         gcJVroLEIvuZbe0vEmu84j2sDPGhxyvm0+c/EJEET5MS3dzXAf4EcZ3HDRlhz+FzGBjg
         3AP4sonqpv8VcOy+NdSTEAHIlVKsUTWWpsZH96YtzZl+VykKIitO27yUQlQs7vj1CTKR
         GYylYY0pHTI0ygNXleqGvMwR5IoE8F5SqclFIRZPM5VZgYB+LeHXwn9f+ApSmbGs8Ppv
         OBaQ==
X-Gm-Message-State: AGi0Pua2cdZHBdnju6aU25egt2ji/YHHfQSZ2zAd8tL+SPTwuLSBIifJ
        VAkxB01zkkz7FmDMmf2tuWIUVMOqWrINeZRRY7iskK84zfIBj+HLOYrgv6TK2wroo9bt1K4pver
        2s6ksmQzMCuPMxVCHtXd/DDL6
X-Received: by 2002:a1c:7f8e:: with SMTP id a136mr2117564wmd.33.1586222220757;
        Mon, 06 Apr 2020 18:17:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypKQ8ZFP7SqvR9SfME3wLzzSSain/ZwRIGeGpFsv0tcRpM9Qel1kekfQFVeNUkF4nqbNDouBCQ==
X-Received: by 2002:a1c:7f8e:: with SMTP id a136mr2117550wmd.33.1586222220535;
        Mon, 06 Apr 2020 18:17:00 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id u22sm94021wmu.43.2020.04.06.18.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:17:00 -0700 (PDT)
Date:   Mon, 6 Apr 2020 21:16:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v8 15/19] remoteproc: switch to virtio_legacy_init/size
Message-ID: <20200407011612.478226-16-mst@redhat.com>
References: <20200407011612.478226-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407011612.478226-1-mst@redhat.com>
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
 drivers/remoteproc/remoteproc_core.c   | 2 +-
 drivers/remoteproc/remoteproc_virtio.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

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
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index 8c07cb2ca8ba..35b02468197a 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -95,7 +95,7 @@ static struct virtqueue *rp_find_vq(struct virtio_device *vdev,
 	len = rvring->len;
 
 	/* zero vring */
-	size = vring_size(len, rvring->align);
+	size = vring_legacy_size(len, rvring->align);
 	memset(addr, 0, size);
 
 	dev_dbg(dev, "vring%d: va %pK qsz %d notifyid %d\n",
-- 
MST

