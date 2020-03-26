Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35837C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDBA20719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 06:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S2Ut1a4F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCZGRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 02:17:04 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:41782 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgCZGRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 02:17:03 -0400
Received: by mail-pg1-f202.google.com with SMTP id m25so3934612pgl.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=+SxjJva0YWqxT42y0+cCD4roUNRLjOULUql4d4jTyTI=;
        b=S2Ut1a4FemVD9Zoec3UCctFsUiTAvIJKEHmJLdisnxkdN1QAmnv7kUCCGObqlXGywG
         y11PUqJTLCd2pzRTATD1VEWCVRT+whbEo8ULNoJHo/iiZ+HR/ytJpFnw//IdN6ehY2bc
         cF1Ir8+jaJUqJWqQse+nBtttB6IVOU0NI+f594KuonTEodvlE6sOXKy8B/MlIdL22X+A
         TLPLFio2kcOT5Xh1chrb/ZZzqp7+5ZpJ6G8tgY3/oqf2T3w2XkY038nFERVrfEod3K2e
         QZemx+O3sr4+ZAA79fr/cEHqIX85qwabSve279SYHkLZC7Yf2iU3Qilch59sfklhcdwf
         LvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=+SxjJva0YWqxT42y0+cCD4roUNRLjOULUql4d4jTyTI=;
        b=klx75BseazJAEL7C0qPLGXSr1IXVgvE+yH3JjkvlJaU3xzHaP+CnQw35WWwM1KBTYc
         yhE9isVHLKL5q5PlKqAR33GRaKmE3/CmB5aUHR34fQnKpkCWRE+t3aKTuEEDnPb2C7g1
         YRr81JpnIqeNTKQEJ6bw3V0Ab+rGPtnJOTONSAJ607oX7j3yUmxqT9ANCTz9Cz+b0tLU
         8/78xn+aUnA9M2i/DDi5T+VxqNDhodo4qvnocs1axKBe/iUfq6clGrOpP5KIKVcLt6gv
         MoSOQdZ3zWyhYJxxW1UTa7i8Ysm30acs9Ag+y7lEsMUdaOgtMya8Ki04ZrSkB79Xe7Tx
         fs8A==
X-Gm-Message-State: ANhLgQ0qv+tzB5d6VLIa60ze42B35VRckuU3+xBYSC0NewlRH6l2nzf/
        O/76whstMUNSV3fxF35Vw/ph/0mKsj/yBLQ=
X-Google-Smtp-Source: ADFU+vtQ+Z2Scs+XMv1fSFAZCfEtCAWRrDtOmcSf1EJHJYN3e2K+DylCjXC8A/4njqK7vcMXHIqrBg82Yw5Lzog=
X-Received: by 2002:a17:90b:3752:: with SMTP id ne18mr1415515pjb.143.1585203422125;
 Wed, 25 Mar 2020 23:17:02 -0700 (PDT)
Date:   Wed, 25 Mar 2020 23:16:48 -0700
Message-Id: <20200326061648.78914-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v1] slimbus: core: Set fwnode for a device when setting of_node
From:   Saravana Kannan <saravanak@google.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When setting the of_node for a newly created device, also set the
fwnode. This allows fw_devlink to work for slimbus devices.

Signed-off-by: Saravana Kannan <saravanak@google.com>
Change-Id: I5505213f8ecca908860a1ad6bbc275ec0f78e4a6
---
 drivers/slimbus/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/core.c b/drivers/slimbus/core.c
index 526e3215d8fe..44228a5b246d 100644
--- a/drivers/slimbus/core.c
+++ b/drivers/slimbus/core.c
@@ -163,8 +163,10 @@ static int slim_add_device(struct slim_controller *ctrl,
 	INIT_LIST_HEAD(&sbdev->stream_list);
 	spin_lock_init(&sbdev->stream_list_lock);
 
-	if (node)
+	if (node) {
 		sbdev->dev.of_node = of_node_get(node);
+		sbdev->dev.fwnode = of_fwnode_handle(node);
+	}
 
 	dev_set_name(&sbdev->dev, "%x:%x:%x:%x",
 				  sbdev->e_addr.manf_id,
-- 
2.25.1.696.g5e7596f4ac-goog

