Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5113AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 290422071E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 14:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580221223;
	bh=Tub63oqi66lFA0AvcS+l6T0/NfRFI42oADpT38jkzjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BVjjQJTc7WqbhPoe7JkxcDjX0ANWOzH1xMXjvKb+dvYujD1XlKgiuF5WGF9gsbzOU
	 BMVcn2zODNbs9RTFLwXXcIncqiQjwuJxmCdxU4TjCN2vgff/vNlofhkC1am+f1Ev72
	 WygrSNSjxg6SKxspRUE/y9m/lEGMXepHvEqPqI6E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729866AbgA1OUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 09:20:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgA1OUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 09:20:19 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E02824698;
        Tue, 28 Jan 2020 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580221218;
        bh=Tub63oqi66lFA0AvcS+l6T0/NfRFI42oADpT38jkzjI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8zTkiZCb+sQJK+rYSMO94pv/nMcbRuBCjFIF04JGp8l44NGDdb45KhkVYhclbhgH
         l7BIZIo5mc1YfAElmip4ljMYM+/0ojA5KSp1Y4D7Gbf/fVz0w3eTamjgExG1jb1UJ4
         QcWYobe7CMMx90vuvyvkcC4q0UU6aRgDwxxlm1VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 136/271] media: davinci/vpbe: array underflow in vpbe_enum_outputs()
Date:   Tue, 28 Jan 2020 15:04:45 +0100
Message-Id: <20200128135902.714562916@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200128135852.449088278@linuxfoundation.org>
References: <20200128135852.449088278@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/davinci/vpbe.c | 2 +-
 include/media/davinci/vpbe.h          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/davinci/vpbe.c b/drivers/media/platform/davinci/vpbe.c
index abce9c4a1a8ec..59518c08528b8 100644
--- a/drivers/media/platform/davinci/vpbe.c
+++ b/drivers/media/platform/davinci/vpbe.c
@@ -130,7 +130,7 @@ static int vpbe_enum_outputs(struct vpbe_device *vpbe_dev,
 			     struct v4l2_output *output)
 {
 	struct vpbe_config *cfg = vpbe_dev->cfg;
-	int temp_index = output->index;
+	unsigned int temp_index = output->index;
 
 	if (temp_index >= cfg->num_outputs)
 		return -EINVAL;
diff --git a/include/media/davinci/vpbe.h b/include/media/davinci/vpbe.h
index 4376beeb28c2c..5d8ceeddc7973 100644
--- a/include/media/davinci/vpbe.h
+++ b/include/media/davinci/vpbe.h
@@ -96,7 +96,7 @@ struct vpbe_config {
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



