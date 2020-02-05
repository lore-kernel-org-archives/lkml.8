Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83A2C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CE4C214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QALoKS78"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgBETFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:05:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:37642 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBETFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:05:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id z12so1418810pgl.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kUhe/K0/9x0fsd6OKD8kfBY5OuIzmdvoJ/dyGgBHb8o=;
        b=QALoKS78qLC14BG79yLHIABZSre+wtSJ8SL0MJKSVhu0DwenWjSL9GY9gVd2hBUEiX
         v0GIJOyQuHpd/TyPPAsXzv5NEGtPr1U951QGEs9n3p7+JbGk5/ak/ZIFovWhCAP0T2oQ
         U76zezI2zJOHo4WIYPgDRXZ+nCUJK1fw8ljeM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kUhe/K0/9x0fsd6OKD8kfBY5OuIzmdvoJ/dyGgBHb8o=;
        b=WndBIKodTVnnlObSsIF+iljTkxkYj2v8ZYLAmNQhDMkT7XHb8Tm6c/j1UmbZkRkGrm
         4SOcc4yI0VF/BW+1omoBzAhUuJUuAEU/6NAwTZWEqjH4I/dROCKQMYgXmsuSfBnPKH3r
         hiwjrejyrR2AqFZDXLjFZPBBGSJ9GPV4u8mlZtoARLcd/DarNvUIbR1OoKZHiN58Io7O
         A7kb30UD+ZJCq5mTEQxjUDoDggw9pBgBLzwulCNRmGI5Uq+/KUsYbZq+R1ArB4+AVT6T
         a93PpiHJo3o5LHAL7oTA5lC5tXZ3itH5ViGGRQuRdx34v7/QiASWPfYER0rdEfsczDeV
         kkOg==
X-Gm-Message-State: APjAAAWQNz+qbr7zfYpo9cNgytPEWG8WQnZq6JSU3b6CCOuom5qxUQba
        6dghj/8H0G7nFo6A59BVC4su0QdgeyU=
X-Google-Smtp-Source: APXvYqzJkjH6E9bz4JwlNYArL8v/Cx5iOiZ96j3UsgzgOvjCms7MEvbZ0wh38CYXOFMSjYUv7qcqbQ==
X-Received: by 2002:a63:7a0f:: with SMTP id v15mr11652478pgc.139.1580929517138;
        Wed, 05 Feb 2020 11:05:17 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:05:16 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 03/17] platform/chrome: proto: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 10:59:59 -0800
Message-Id: <20200205190028.183069-4-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the use of cros_ec_cmd_xfer_status() with the new function
cros_ec_cmd().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/platform/chrome/cros_ec_proto.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index b3d5368f596813..aa7ae1f394cc91 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -811,31 +811,20 @@ EXPORT_SYMBOL(cros_ec_get_host_event);
  */
 int cros_ec_check_features(struct cros_ec_dev *ec, int feature)
 {
-	struct cros_ec_command *msg;
 	int ret;
 
 	if (ec->features[0] == -1U && ec->features[1] == -1U) {
 		/* features bitmap not read yet */
-		msg = kzalloc(sizeof(*msg) + sizeof(ec->features), GFP_KERNEL);
-		if (!msg)
-			return -ENOMEM;
-
-		msg->command = EC_CMD_GET_FEATURES + ec->cmd_offset;
-		msg->insize = sizeof(ec->features);
-
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		ret = cros_ec_cmd(ec->ec_dev, 0,
+				  ec->cmd_offset + EC_CMD_GET_FEATURES, NULL, 0,
+				  ec->features, sizeof(ec->features), NULL);
 		if (ret < 0) {
-			dev_warn(ec->dev, "cannot get EC features: %d/%d\n",
-				 ret, msg->result);
+			dev_warn(ec->dev, "cannot get EC features: %d\n", ret);
 			memset(ec->features, 0, sizeof(ec->features));
-		} else {
-			memcpy(ec->features, msg->data, sizeof(ec->features));
 		}
 
 		dev_dbg(ec->dev, "EC features %08x %08x\n",
 			ec->features[0], ec->features[1]);
-
-		kfree(msg);
 	}
 
 	return ec->features[feature / 32] & EC_FEATURE_MASK_0(feature);
-- 
2.25.0.341.g760bfbb309-goog

