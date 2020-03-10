Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A46C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48FC7208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 13:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583845906;
	bh=D1KMiHMo8Ls72ihrKfQhp1my5vwtKsTTszaB8nmbRHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Quh3sacuPWhEEBtTLKPvnU3pzr7SBuVJtAWOd7IgNh9+ugtsPczcQIymuom+l5R3U
	 cixkUQr7PTVyiydNh5XXR3SPvMPbS+qELKnyCT22RfHSBfMntY0IQTnFIHFiZHjL3s
	 8B6XijC8ZgujNHzRTF7Nwr0NKFizSQXmW62Dw0Qw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730453AbgCJNLo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 09:11:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731061AbgCJNLl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 09:11:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 273A6246A3;
        Tue, 10 Mar 2020 13:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583845900;
        bh=D1KMiHMo8Ls72ihrKfQhp1my5vwtKsTTszaB8nmbRHY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oXzSLJJ/YnPjy0VhB42aI/XR1BdjBbZoX5Gw2i4IO8Rg9j+AcAtpAO1mgQz3MxsvL
         3tXhZjU1g/Am09qZnioEw4AkHOVsDTqs2j5cOvmr5IllPwpxfNViFxKT0LiYzZZTwH
         hp7ZRhX11+Xl3/xBtJ+fhwWUVP5nCVpYDFCoDjYE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Henzl <thenzl@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Lee Duncan <lduncan@suse.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 15/86] scsi: megaraid_sas: silence a warning
Date:   Tue, 10 Mar 2020 13:44:39 +0100
Message-Id: <20200310124531.614177697@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200310124530.808338541@linuxfoundation.org>
References: <20200310124530.808338541@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Henzl <thenzl@redhat.com>

[ Upstream commit 0e99b2c625da181aebf1a3d13493e3f7a5057a9c ]

Add a flag to DMA memory allocation to silence a warning.

This driver allocates DMA memory for IO frames. This allocation may exceed
MAX_ORDER pages for few megaraid_sas controllers (controllers with very
high queue depth). Consequently, the driver has logic to keep reducing the
controller queue depth until the DMA memory allocation succeeds.

On impacted megaraid_sas controllers there would be multiple DMA allocation
failures until driver settled on an allocation that fit. These failed DMA
allocation requests caused stack traces in system logs. These were not
harmful and this patch silences those warnings/stack traces.

[mkp: clarified commit desc]

Link: https://lore.kernel.org/r/20200204152413.7107-1-thenzl@redhat.com
Signed-off-by: Tomas Henzl <thenzl@redhat.com>
Acked-by: Sumit Saxena <sumit.saxena@broadcom.com>
Reviewed-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/megaraid/megaraid_sas_fusion.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/megaraid/megaraid_sas_fusion.c b/drivers/scsi/megaraid/megaraid_sas_fusion.c
index b094a4e55c32f..81bd824bb9d99 100644
--- a/drivers/scsi/megaraid/megaraid_sas_fusion.c
+++ b/drivers/scsi/megaraid/megaraid_sas_fusion.c
@@ -530,7 +530,8 @@ megasas_alloc_request_fusion(struct megasas_instance *instance)
 
 	fusion->io_request_frames =
 			dma_pool_alloc(fusion->io_request_frames_pool,
-				GFP_KERNEL, &fusion->io_request_frames_phys);
+				GFP_KERNEL | __GFP_NOWARN,
+				&fusion->io_request_frames_phys);
 	if (!fusion->io_request_frames) {
 		if (instance->max_fw_cmds >= (MEGASAS_REDUCE_QD_COUNT * 2)) {
 			instance->max_fw_cmds -= MEGASAS_REDUCE_QD_COUNT;
@@ -568,7 +569,7 @@ megasas_alloc_request_fusion(struct megasas_instance *instance)
 
 		fusion->io_request_frames =
 			dma_pool_alloc(fusion->io_request_frames_pool,
-				       GFP_KERNEL,
+				       GFP_KERNEL | __GFP_NOWARN,
 				       &fusion->io_request_frames_phys);
 
 		if (!fusion->io_request_frames) {
-- 
2.20.1



