Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B98C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D29C20882
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592323157;
	bh=jPK7r6XngKm+9s3k8RkKbP+GQdmiG3cPPA1jpmH2QwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=X7lru0m8d+zwAFW5tRPhx0BpRvCEge/riAmPMvoxtlgUV5vDhqkMbEz3eSt0+H0EB
	 WjXLxpdgVQZUVQnsKWY6Zg0cDy7Uz8YhthkgP+MmQv6kKNBMqLlBqMtRA7n5NBtsUV
	 htkYXNZwoiYk7fKpSBJGKC2j5DVrv/WdpsXLFw34=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbgFPP7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 11:59:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:52378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbgFPPxs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 11:53:48 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10008208D5;
        Tue, 16 Jun 2020 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592322828;
        bh=jPK7r6XngKm+9s3k8RkKbP+GQdmiG3cPPA1jpmH2QwM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ReFib/ryGVGrpzGnwdecTVP4vx0ei3P/IUAfywBFw6/QGknwHq8WwtR4HOOgkpjtV
         sitXxewYR0TM8sqAp/vEZ7+fFZhvOQSjj99Qqpcg3hvbcCyMc57q6tdyuM0kYfd4l8
         qxdZOXaBH123ZN88yZ/vq2GsiPYVTemaCtg/sUQ4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Suman Anna <s-anna@ti.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [PATCH 5.6 119/161] remoteproc: Fix and restore the parenting hierarchy for vdev
Date:   Tue, 16 Jun 2020 17:35:09 +0200
Message-Id: <20200616153112.025804793@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200616153106.402291280@linuxfoundation.org>
References: <20200616153106.402291280@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suman Anna <s-anna@ti.com>

commit c774ad010873bb89dcc0cdcb1e96aef6664d8caf upstream.

The commit 086d08725d34 ("remoteproc: create vdev subdevice with specific
dma memory pool") has introduced a new vdev subdevice for each vdev
declared in the firmware resource table and made it as the parent for the
created virtio rpmsg devices instead of the previous remoteproc device.
This changed the overall parenting hierarchy for the rpmsg devices, which
were children of virtio devices, and does not allow the corresponding
rpmsg drivers to retrieve the parent rproc device through the
rproc_get_by_child() API.

Fix this by restoring the remoteproc device as the parent. The new vdev
subdevice can continue to inherit the DMA attributes from the remoteproc's
parent device (actual platform device).

Cc: stable@vger.kernel.org
Fixes: 086d08725d34 ("remoteproc: create vdev subdevice with specific dma memory pool")
Signed-off-by: Suman Anna <s-anna@ti.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Link: https://lore.kernel.org/r/20200420160600.10467-3-s-anna@ti.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/remoteproc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -510,7 +510,7 @@ static int rproc_handle_vdev(struct rpro
 
 	/* Initialise vdev subdevice */
 	snprintf(name, sizeof(name), "vdev%dbuffer", rvdev->index);
-	rvdev->dev.parent = rproc->dev.parent;
+	rvdev->dev.parent = &rproc->dev;
 	rvdev->dev.dma_pfn_offset = rproc->dev.parent->dma_pfn_offset;
 	rvdev->dev.release = rproc_rvdev_release;
 	dev_set_name(&rvdev->dev, "%s#%s", dev_name(rvdev->dev.parent), name);


