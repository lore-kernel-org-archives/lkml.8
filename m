Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C6CC47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130A524957
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588340055;
	bh=9z4LahtgSkFQavSR0Kpqso99n4FDvhhsFpPIpUuuUlY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bOrWdPE/z8yAW/AJdtLmTuxOdKsdPWGG4z4xA0ADN2l7+xqQbRyXmNASJ4rtNTIzh
	 db1MzWgMa9jXHkC4oZjifrgvxcGI1ItVNw+YVTSCjpRewfnxFkprfY8bZW/2YwGMVX
	 e00puLu3hi1GHdZiy3RF38JpYHk1Gi4SgEfl64FE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730539AbgEANeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:34:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730531AbgEANeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:34:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFE5A208DB;
        Fri,  1 May 2020 13:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588340048;
        bh=9z4LahtgSkFQavSR0Kpqso99n4FDvhhsFpPIpUuuUlY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhUTTTi9AcJXEglbdG8b6vasgayZoJQgBRW4jXBL/vR2ttum+2xiLYb3DWNhmCaDA
         Ekc4cHSkpF+Y7SziyGoWUeVNufn75YJYdfrCC24c2ozYqQXyngydtXPUNo6ErBEV9C
         cH0ys6s4tEkUGd5Z8Y9WxU/Be6shImIqSARUDPaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Clement Leger <cleger@kalray.eu>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>
Subject: [PATCH 4.14 085/117] remoteproc: Fix wrong rvring index computation
Date:   Fri,  1 May 2020 15:22:01 +0200
Message-Id: <20200501131554.830677767@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200501131544.291247695@linuxfoundation.org>
References: <20200501131544.291247695@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clement Leger <cleger@kalray.eu>

commit 00a0eec59ddbb1ce966b19097d8a8d2f777e726a upstream.

Index of rvring is computed using pointer arithmetic. However, since
rvring->rvdev->vring is the base of the vring array, computation
of rvring idx should be reversed. It previously lead to writing at negative
indices in the resource table.

Signed-off-by: Clement Leger <cleger@kalray.eu>
Link: https://lore.kernel.org/r/20191004073736.8327-1-cleger@kalray.eu
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Doug Anderson <dianders@chromium.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/remoteproc/remoteproc_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -288,7 +288,7 @@ void rproc_free_vring(struct rproc_vring
 {
 	int size = PAGE_ALIGN(vring_size(rvring->len, rvring->align));
 	struct rproc *rproc = rvring->rvdev->rproc;
-	int idx = rvring->rvdev->vring - rvring;
+	int idx = rvring - rvring->rvdev->vring;
 	struct fw_rsc_vdev *rsc;
 
 	dma_free_coherent(rproc->dev.parent, size, rvring->va, rvring->dma);


