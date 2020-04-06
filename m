Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41A5C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8C542078A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 22:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A926z24a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgDFW1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 18:27:00 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34803 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726582AbgDFW05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 18:26:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586212015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sGNQNkbNwJWickjlRxXK9zH9MXSx5qKtnPAyeHR3Xys=;
        b=A926z24a7Mg6Dt0k8vFyYXivW2auc3RLOnO6HCS/cat3hfRi4kMFCfvds+stFD7h0WS1ca
        UMfUxMY1nPsbGvK1HJfoR2hrVwXyKKNbmHR8P2mlGxpKr6W3nizpFS5dKh7uNsBxkU4bns
        3bFhtkdA4++k0cD/zy18NciGA8No2S0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454--eyh7rNsNd6hkqPX7eWlqg-1; Mon, 06 Apr 2020 18:26:54 -0400
X-MC-Unique: -eyh7rNsNd6hkqPX7eWlqg-1
Received: by mail-wr1-f69.google.com with SMTP id t13so661044wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 15:26:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sGNQNkbNwJWickjlRxXK9zH9MXSx5qKtnPAyeHR3Xys=;
        b=KC0jo/N3DWYUcKO204hWMzoCsdAD0fgHhQVA4UDyPCpIB530mz0Kw058VDndUFANHJ
         PmxxXi/dCevxbCPMScKP1ZojYKoPqF5F9bvtuPQH9O+G8FrfmKVhyNlpC6d6Ba6gbg4h
         YJTY9SNDu1pNxmfKpxMURlryeYtKgIrbKboL88TG+CK1aDSmHLarnLrTkpiPxPIB4LV+
         ADbv3CJjhGGioncT64BhtWAd9+MFcEzJlevi1YazEEoqosy+Ff3RsTjiaj19VrRtkI2H
         3dCsz8GFaH3sm0Ys1aHBmJlPO6VgaXw0rhBXQDxLkE+PXhChT2EZTIvS8vC2puqko72+
         hqqQ==
X-Gm-Message-State: AGi0PuYS3yyExywplrC3LVvnkFtP9jJRyp4as3yByX700MDgwZo4cRYW
        1DPS7YBuE23euvY5phPFPQgvYGGgpXqwT3AQkQMs6DE6K2rkydP8FQ6X+/flO4yzuL253FpbHSd
        mr25m4r44XUcVnjNpxlleZiHc
X-Received: by 2002:a5d:688e:: with SMTP id h14mr1589675wru.372.1586212012786;
        Mon, 06 Apr 2020 15:26:52 -0700 (PDT)
X-Google-Smtp-Source: APiQypKugF2uUocJlMIxJYAVtDr6RsGartXONR6Ws52dqmZjr+1kpYMbnATkUFh4PIrqGiUfbeyzvA==
X-Received: by 2002:a5d:688e:: with SMTP id h14mr1589659wru.372.1586212012581;
        Mon, 06 Apr 2020 15:26:52 -0700 (PDT)
Received: from redhat.com (bzq-79-176-51-222.red.bezeqint.net. [79.176.51.222])
        by smtp.gmail.com with ESMTPSA id b15sm27488656wru.70.2020.04.06.15.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 15:26:52 -0700 (PDT)
Date:   Mon, 6 Apr 2020 18:26:50 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org
Subject: [PATCH v6 11/12] remoteproc: switch to virtio_legacy_init/size
Message-ID: <20200406222507.281867-12-mst@redhat.com>
References: <20200406222507.281867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406222507.281867-1-mst@redhat.com>
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

