Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30851C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09A0F2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200997;
	bh=N5ERwiDvrEhKjqvi4Vr6Ok+XCMKgXxIGwQY4H36gUX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Z+0572vVoPv5W35lrm+kj3YlQiyVMu6VNqcFPR03yHfMX6Qk6zHlG8QsstuwzElwP
	 WJ8nT+fimUfsjBD18MqLEEWFelrfReffpbdxxmbx4V3qOenKdUiYJGN8yUCxT9Obyv
	 0zhLCZEHSwxzJeKEfNgNve9sobEdpdkPTcnHoTAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389130AbgAPRHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:38604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389089AbgAPRHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:10 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E20A1217F4;
        Thu, 16 Jan 2020 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194430;
        bh=N5ERwiDvrEhKjqvi4Vr6Ok+XCMKgXxIGwQY4H36gUX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zU3b24f7I/qJ8SvqTqQtygrPDhdT0zsAD5YGYbh/W0GP0qJzI5xnsYUJKiLXII8yV
         UcVoHxLBhYP0Cnv+zhR264As5opZ9M+z7ej7Jh3F+gpctWR88MuzcXQ6tiS/mG0PfX
         MD+77eiWt8LPwTMMI5mWYlVVws8szT2bc7J8tvlQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Lad Prabhakar" <prabhakar.csengg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 346/671] media: davinci/vpbe: array underflow in vpbe_enum_outputs()
Date:   Thu, 16 Jan 2020 11:59:44 -0500
Message-Id: <20200116170509.12787-83-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b72845ee5577b227131b1fef23f9d9a296621d7b ]

In vpbe_enum_outputs() we check if (temp_index >= cfg->num_outputs) but
the problem is that "temp_index" can be negative.  This patch changes
the types to unsigned to address this array underflow bug.

Fixes: 66715cdc3224 ("[media] davinci vpbe: VPBE display driver")

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: "Lad Prabhakar" <prabhakar.csengg@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpbe.c | 2 +-
 include/media/davinci/vpbe.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/davinci/vpbe.c
index df1ae6b5c854..e45e062f4442 100644
--- a/drivers/media/platform/davinci/vpbe.c
+++ b/drivers/media/platform/davinci/vpbe.c
@@ -126,7 +126,7 @@ static int vpbe_enum_outputs(struct vpbe_device *vpbe_dev,
 			     struct v4l2_output *output)
 {
 	struct vpbe_config *cfg = vpbe_dev->cfg;
-	int temp_index = output->index;
+	unsigned int temp_index = output->index;
 
 	if (temp_index >= cfg->num_outputs)
 		return -EINVAL;
diff --git a/include/media/davinci/vpbe.h b/include/media/davinci/vpbe.h
index 79a566d7defd..180a05e91497 100644
--- a/include/media/davinci/vpbe.h
+++ b/include/media/davinci/vpbe.h
@@ -92,7 +92,7 @@ struct vpbe_config {
 	struct encoder_config_info *ext_encoders;
 	/* amplifier information goes here */
 	struct amp_config_info *amp;
-	int num_outputs;
+	unsigned int num_outputs;
 	/* Order is venc outputs followed by LCD and then external encoders */
 	struct vpbe_output *outputs;
 };
-- 
2.20.1

