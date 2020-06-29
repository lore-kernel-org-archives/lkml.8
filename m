Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01BFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855F120663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593458786;
	bh=itDSavpW6L0JslBHNpPEo3qaGuz+WTvKFeGlIlSvPzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=TqEOhYXrevCvkHpM15iz9JgjAyDm4Aw1yHoseGwG5kun0mOB4gahFfQ8EVq21XMiu
	 TraKIqaUuiqXOoplX2EHYq3PHo/6HcGG54Nxr88e8pZ5ymH2QelDeO1k6Etj6OE9Zl
	 nvepz77JpNi7RD9SLwK3zyudarawAHLa9DSfoH4k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732704AbgF2T0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732623AbgF2TZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:25:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82A8725377;
        Mon, 29 Jun 2020 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593445240;
        bh=itDSavpW6L0JslBHNpPEo3qaGuz+WTvKFeGlIlSvPzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aiCPDnUVj7c9fxupRMxfqVKKbyAeAyT+sNle3L7LhmMB7bmPhwVS8JUDTpHAG0Wba
         pg2++CSIGsoMD44VquDuaBSgLWdF5oBLC+mZUOMFFxlbO36atdP3zQf8xIwSUO1bBg
         SbpRh//PHizGD8TH8F3N/jON3jgR/ezJBixOD1Es=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Simon Arlott <simon@octiron.net>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 024/191] scsi: sr: Fix sr_probe() missing deallocate of device minor
Date:   Mon, 29 Jun 2020 11:37:20 -0400
Message-Id: <20200629154007.2495120-25-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629154007.2495120-1-sashal@kernel.org>
References: <20200629154007.2495120-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.229-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.9.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.9.229-rc1
X-KernelTest-Deadline: 2020-07-01T15:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Arlott <simon@octiron.net>

[ Upstream commit 6555781b3fdec5e94e6914511496144241df7dee ]

If the cdrom fails to be registered then the device minor should be
deallocated.

Link: https://lore.kernel.org/r/072dac4b-8402-4de8-36bd-47e7588969cd@0882a8b5-c6c3-11e9-b005-00805fc181fe
Signed-off-by: Simon Arlott <simon@octiron.net>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/sr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index cc484cb287d24..67a73ea0a615e 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -745,7 +745,7 @@ static int sr_probe(struct device *dev)
 	cd->cdi.disk = disk;
 
 	if (register_cdrom(&cd->cdi))
-		goto fail_put;
+		goto fail_minor;
 
 	/*
 	 * Initialize block layer runtime PM stuffs before the
@@ -763,6 +763,10 @@ static int sr_probe(struct device *dev)
 
 	return 0;
 
+fail_minor:
+	spin_lock(&sr_index_lock);
+	clear_bit(minor, sr_index_bits);
+	spin_unlock(&sr_index_lock);
 fail_put:
 	put_disk(disk);
 fail_free:
-- 
2.25.1

