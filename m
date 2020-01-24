Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76285C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42C942075D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579865272;
	bh=X6KHqZed0cZZ5GRpXrqxZDyc5oNFbNlmfzErILPwf6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=D1Bodmasnb2XoS4ruPMeF5MrB50ABbS1B6ADOjB2y8Q1Bg572G3fHhI+536dAVne7
	 0YVGOZJXot4Fz/JmdWuA99G8GmpNJtmixNw4ZiErNDPRIMXShrZcHva3++fz5+er4P
	 ghVkmhANok9RnRYWzpIIah6kSdk+JyCTyiU7L81U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391685AbgAXL1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:27:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:43582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391675AbgAXL1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:27:47 -0500
Received: from localhost (ip-213-127-102-57.ip.prioritytelecom.net [213.127.102.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B9D620718;
        Fri, 24 Jan 2020 11:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579865266;
        bh=X6KHqZed0cZZ5GRpXrqxZDyc5oNFbNlmfzErILPwf6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9Xw4eAVvfvw9seMbjNxymAnTB0SHrqj5Juv7mtKpW+Rns9bnHabgFAjXjTBMsrPm
         K474Ss4E4gpL4L06eduFFHCJhknxgwIbJBoLOFabscFEBZ3UtiVBnUfCLu039qyEFw
         qk0jZ1AXlKck4mttsjHwzkm01zogpiQYBkvplNMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 486/639] media: rcar-vin: Clean up correct notifier in error path
Date:   Fri, 24 Jan 2020 10:30:56 +0100
Message-Id: <20200124093149.593453726@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200124093047.008739095@linuxfoundation.org>
References: <20200124093047.008739095@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit 0bd465765f8d1300040de627f0a0971a8849d654 ]

The parallel input initialization error path cleans up the wrong
async notifier, fix this by cleaning up the correct notifier.

Fixes: 9863bc8695bc36e3 ("media: rcar-vin: Cleanup notifier in error path")
Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/rcar-vin/rcar-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-core.c b/drivers/media/platform/rcar-vin/rcar-core.c
index 485fa3fa8b49a..c389ba9ba74d2 100644
--- a/drivers/media/platform/rcar-vin/rcar-core.c
+++ b/drivers/media/platform/rcar-vin/rcar-core.c
@@ -631,7 +631,7 @@ static int rvin_parallel_init(struct rvin_dev *vin)
 	ret = v4l2_async_notifier_register(&vin->v4l2_dev, &vin->notifier);
 	if (ret < 0) {
 		vin_err(vin, "Notifier registration failed\n");
-		v4l2_async_notifier_cleanup(&vin->group->notifier);
+		v4l2_async_notifier_cleanup(&vin->notifier);
 		return ret;
 	}
 
-- 
2.20.1



