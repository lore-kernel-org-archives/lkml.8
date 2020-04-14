Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160B2C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7C1D20656
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 20:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qtec.com header.i=@qtec.com header.b="Q6+3YSAc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505461AbgDNUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 16:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2505428AbgDNUCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:02:23 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E7FC03C1AA
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:02:19 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h25so1165020lja.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 13:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=qtec.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jTrRppTOaz3y0rG21oAUj12lqiSghZgqjFj/i9GzbU=;
        b=Q6+3YSAcQQYC6IVnZnn5zzNHgWEQgy/bJQE98XfovwEhiZ0p9v1qf4107b9YrFr01k
         SiuinysHtC70GNj0MbH/DbOckbdTY21/oxnqqTcZY8mdq60Y7kpP7SekNWScZpoBpVR2
         woTjZZLs6/aQiqF1V8SZqzfdKeEeTAqtY6+IM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jTrRppTOaz3y0rG21oAUj12lqiSghZgqjFj/i9GzbU=;
        b=GCOn0kDYlKIgsFHbyQAw99ANn8hz6TJ78dte6hgDk4DsmfOJ+XXhfVMXW0/AyzsYHX
         tS3ocvO5wFUWudOBaMlgZF1/oCqYBN6cfWXuBaSJrrN3rNAU0S5LKcXsfYDAF9prhDmJ
         JvVqMb9yYHq2/r65InNVPJ9HF4KFlpe1QySzNp2kM/h8p7sVzG+KIyyGUZtKhCSXUbmi
         nrZxjCeugjLQDrSxk4YiLgQbAz7agRkYMyuTGj06f5/Kmjz401k7KQEuk6LA8Nn5Mi5Y
         s2Ge9MeMFKP0nbjc94ZjwWrrMac0EZTnBE0DuouQEy0bukRImGMkQKLZh63xluJI7hR+
         spcw==
X-Gm-Message-State: AGi0PuaZaodcVFXYlgqfI2m2b09RE1Wu2gZ+x9qK+XH0MOTZ+WqyoYSr
        EbbRszkBiQvKP0HeEj6gYnCWcg==
X-Google-Smtp-Source: APiQypLsxzNxstX2zFH9KjS4H039xX6iBLo0m9zhRrNss2VZD7P/+LmYpYVjjBrQKy09tQ/8cbxaMQ==
X-Received: by 2002:a2e:868b:: with SMTP id l11mr1072144lji.247.1586894538253;
        Tue, 14 Apr 2020 13:02:18 -0700 (PDT)
Received: from localhost.localdomain (62-243-86-95-cable.dk.customer.tdc.net. [62.243.86.95])
        by smtp.gmail.com with ESMTPSA id v4sm3525254ljj.104.2020.04.14.13.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 13:02:17 -0700 (PDT)
From:   Daniel Gomez <daniel@qtec.com>
To:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Daniel Gomez <daniel@qtec.com>
Subject: [RFC PATCH 2/3] media: v4l2: Add v4l2 control IDs for temperature
Date:   Tue, 14 Apr 2020 22:01:50 +0200
Message-Id: <20200414200151.80089-3-daniel@qtec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414200151.80089-1-daniel@qtec.com>
References: <20200414200151.80089-1-daniel@qtec.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a v4l2 control ID to handle the temperature.

Signed-off-by: Daniel Gomez <daniel@qtec.com>
---
 drivers/media/v4l2-core/v4l2-ctrls.c | 5 +++++
 include/uapi/linux/v4l2-controls.h   | 4 +++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls.c b/drivers/media/v4l2-core/v4l2-ctrls.c
index 93d33d1db4e8..17b93111baa8 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls.c
@@ -783,6 +783,7 @@ const char *v4l2_ctrl_get_name(u32 id)
 	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:	return "Min Number of Output Buffers";
 	case V4L2_CID_ALPHA_COMPONENT:		return "Alpha Component";
 	case V4L2_CID_COLORFX_CBCR:		return "Color Effects, CbCr";
+	case V4L2_CID_TEMPERATURE:		return "Temperature";
 
 	/* Codec controls */
 	/* The MPEG controls are applicable to all codec controls
@@ -1344,6 +1345,10 @@ void v4l2_ctrl_fill(u32 id, const char **name, enum v4l2_ctrl_type *type,
 		*type = V4L2_CTRL_TYPE_INTEGER;
 		*flags |= V4L2_CTRL_FLAG_READ_ONLY;
 		break;
+	case V4L2_CID_TEMPERATURE:
+		*type = V4L2_CTRL_TYPE_INTEGER;
+		*flags |= V4L2_CTRL_FLAG_VOLATILE | V4L2_CTRL_FLAG_READ_ONLY;
+		break;
 	case V4L2_CID_MPEG_VIDEO_DEC_PTS:
 		*type = V4L2_CTRL_TYPE_INTEGER64;
 		*flags |= V4L2_CTRL_FLAG_VOLATILE | V4L2_CTRL_FLAG_READ_ONLY;
diff --git a/include/uapi/linux/v4l2-controls.h b/include/uapi/linux/v4l2-controls.h
index 1a58d7cc4ccc..76ec0a6da8d5 100644
--- a/include/uapi/linux/v4l2-controls.h
+++ b/include/uapi/linux/v4l2-controls.h
@@ -143,8 +143,10 @@ enum v4l2_colorfx {
 #define V4L2_CID_ALPHA_COMPONENT		(V4L2_CID_BASE+41)
 #define V4L2_CID_COLORFX_CBCR			(V4L2_CID_BASE+42)
 
+#define V4L2_CID_TEMPERATURE			(V4L2_CID_BASE+43)
+
 /* last CID + 1 */
-#define V4L2_CID_LASTP1                         (V4L2_CID_BASE+43)
+#define V4L2_CID_LASTP1                         (V4L2_CID_BASE+44)
 
 /* USER-class private control IDs */
 
-- 
2.25.1

