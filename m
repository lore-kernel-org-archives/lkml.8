Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6540CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2E0206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 07:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTuxgSGi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgHIHZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 03:25:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgHIHZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 03:25:39 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F1AC061756;
        Sun,  9 Aug 2020 00:25:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 17so3474498pfw.9;
        Sun, 09 Aug 2020 00:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXRSiIIsdnywtiWIezzvW9bD/x7NcWCcTqyfL9gD3uA=;
        b=jTuxgSGiRxcq2P0c4zCzQVGkKUXnW72njViEDu2UqsELULaRrrvefVtmdzbqhX1w1i
         n+dDIuOuMuQ6fYCWbBBjY1IRqDaiIK9bbf5R4xoVzK3L+YRtayZyRMPqee9Xa3ECWum3
         UhDUewKiPcz+d+z3nKGOxtRH966wCewfCtOkWXyXf7TdHvTXRGDDeUCxBdrMzx6hv8aZ
         jQezRA1C6bspfmHJwhj4VASRBPZCDzpIM+jGXjUxH8dsH/roWiS9sI2grqe+X7FBD+60
         OD7xNcemiev6I9jy/0cgA8tU5rDsCZvY1nW243cPIZpBcNGmDzJd1kOLAPPdlimCwNLP
         QKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXRSiIIsdnywtiWIezzvW9bD/x7NcWCcTqyfL9gD3uA=;
        b=ICc9+khSAXoIuFU1ALI0ABjm5RuSn/+cqXlFcO5WvHNB/GHNYx+QF461q6elH5lcNV
         Vi0j+aO/c2A2ggNNLZn+nj4h8a3STfwvE/E1QGzHl3YtmoUArhPcvtfBhPWl8eniPlJr
         hhqhz2v6GHhTHWF34jIrKXmdM9q6Ad+pXoBPbSM8MHJzE4kbNizJx99fnXWtevcprrk9
         nqFAp/7IlXQky8e4Y1KS4HPcJEnbw1ljR/N7WvKbQrPB7Qlf0KrUDJRSK3bOm0pS87AM
         03psy05XGIfd0pUmx7VjTzfXYlARXT4N3/kGSU+/OOJ+WX9PJgkT2vUbdqgs4W9LdQB8
         66dA==
X-Gm-Message-State: AOAM5328rIaf661TKl8jxziEq+7iTTMl7H6gTexV9ZlDy6HpPveV2S3m
        JtHOTJKulCtJYEZJ/zKULe0=
X-Google-Smtp-Source: ABdhPJw58c9cbbVQ4EeDel38Sb8HMMdoskAIBG4iV5s2tEWaCOtmA5+GVFN7EqxkwXKPTcEwCcQ9mg==
X-Received: by 2002:a62:5284:: with SMTP id g126mr19969971pfb.139.1596957938246;
        Sun, 09 Aug 2020 00:25:38 -0700 (PDT)
Received: from localhost.localdomain (c-24-16-167-223.hsd1.wa.comcast.net. [24.16.167.223])
        by smtp.gmail.com with ESMTPSA id z4sm17935792pfb.55.2020.08.09.00.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 00:25:37 -0700 (PDT)
From:   YourName <argoz1701@gmail.com>
To:     marcel@holtmann.org
Cc:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, argoz1701 <argoz1701@gmail.com>
Subject: [PATCH] drivers: bluetooth: btintel.c: fixed format issue.
Date:   Sun,  9 Aug 2020 00:25:32 -0700
Message-Id: <20200809072532.14919-1-argoz1701@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: argoz1701 <argoz1701@gmail.com>

Fixed a coding style issue.

Signed-off-by: Daniel West <argoz1701@gmail.com>
---
 drivers/bluetooth/btintel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 5fa5be3c5598..d0512506fa05 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -29,7 +29,7 @@ int btintel_check_bdaddr(struct hci_dev *hdev)
 			     HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		int err = PTR_ERR(skb);
-		bt_dev_err(hdev, "Reading Intel device address failed (%d)",
+			bt_dev_err(hdev, "Reading Intel device address failed (%d)",
 			   err);
 		return err;
 	}
-- 
2.25.1

