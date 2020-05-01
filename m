Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3076C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93B12054F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 13:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588341440;
	bh=nceTqLdVboUOGm/PsS40NdeWfzI7F31Pjt262b0fQus=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HBc+2/7/eCWnHxmlUtH5m7aLQXPodoTFEfpA8HzfA+PCLKkzY2xJe0MJMb1262Fyj
	 o3OZgiLQx0ovSvzHfiDgzCuvCN8Hb4h8hDKvhUsuNksOSVywEAdEcXrZoJHo9KOvlP
	 FcLFzw1PR4Z8yLCm8+RXStd4JnldhAFzlGGb1FzM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgEANb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 09:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:55994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbgEANbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 09:31:24 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DD4424967;
        Fri,  1 May 2020 13:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588339883;
        bh=nceTqLdVboUOGm/PsS40NdeWfzI7F31Pjt262b0fQus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0i4PKmNspxFiTbdNOon91keIPc0k45/hs27VP7tUpF4OkUlcwEl7ySYhiQMEf+5tB
         HHgOeMqflShiAH/760IAfPg4sObV6doxb6t4hWNCjjufPd2DRbsCSR5n08P0HXmdkM
         8XColAf8H+znLtXu6VnfCyRXskjh6VS5mc3kO36s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 005/117] drm/msm: Use the correct dma_sync calls harder
Date:   Fri,  1 May 2020 15:20:41 +0200
Message-Id: <20200501131545.973539612@linuxfoundation.org>
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

From: Rob Clark <robdclark@chromium.org>

commit 9f614197c744002f9968e82c649fdf7fe778e1e7 upstream.

Looks like the dma_sync calls don't do what we want on armv7 either.
Fixes:

  Unable to handle kernel paging request at virtual address 50001000
  pgd = (ptrval)
  [50001000] *pgd=00000000
  Internal error: Oops: 805 [#1] SMP ARM
  Modules linked in:
  CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.3.0-rc6-00271-g9f159ae07f07 #4
  Hardware name: Freescale i.MX53 (Device Tree Support)
  PC is at v7_dma_clean_range+0x20/0x38
  LR is at __dma_page_cpu_to_dev+0x28/0x90
  pc : [<c011c76c>]    lr : [<c01181c4>]    psr: 20000013
  sp : d80b5a88  ip : de96c000  fp : d840ce6c
  r10: 00000000  r9 : 00000001  r8 : d843e010
  r7 : 00000000  r6 : 00008000  r5 : ddb6c000  r4 : 00000000
  r3 : 0000003f  r2 : 00000040  r1 : 50008000  r0 : 50001000
  Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
  Control: 10c5387d  Table: 70004019  DAC: 00000051
  Process swapper/0 (pid: 1, stack limit = 0x(ptrval))

Signed-off-by: Rob Clark <robdclark@chromium.org>
Fixes: 3de433c5b38a ("drm/msm: Use the correct dma_sync calls in msm_gem")
Tested-by: Fabio Estevam <festevam@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/gpu/drm/msm/msm_gem.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -61,7 +61,7 @@ static void sync_for_device(struct msm_g
 {
 	struct device *dev = msm_obj->base.dev->dev;
 
-	if (get_dma_ops(dev)) {
+	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
 		dma_sync_sg_for_device(dev, msm_obj->sgt->sgl,
 			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
 	} else {
@@ -74,7 +74,7 @@ static void sync_for_cpu(struct msm_gem_
 {
 	struct device *dev = msm_obj->base.dev->dev;
 
-	if (get_dma_ops(dev)) {
+	if (get_dma_ops(dev) && IS_ENABLED(CONFIG_ARM64)) {
 		dma_sync_sg_for_cpu(dev, msm_obj->sgt->sgl,
 			msm_obj->sgt->nents, DMA_BIDIRECTIONAL);
 	} else {


