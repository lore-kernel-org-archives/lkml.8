Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8892C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87E58208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ln3G7483"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391042AbgF2V0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731775AbgF2V03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:26:29 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABCC03E979
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:26:29 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id v6so5094753iob.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GEehQF5Dq7lIZlTVWZjKtKY7k4OY7nbzWNuwJEp3uCA=;
        b=ln3G7483aQUSMwb9MRnm/mfwRP3UHJuE105pebnyrPDCjv3wJ4pCVD26yDO9MGgq5k
         JjOHnqka6eTMXuxzgLdfJTsujakPMVePod6/HmfOJ61u+hS+IDwOaDZF9BGst5Aax8C/
         MfKpSn++e97BcIr5Fi/3kwaxO3cjW1Fj39y2DwgsifHxvtjIq7+Sg5Fb+QO54agRz9Ck
         FfN1QUpDzCD9MP+grFDi2NpElVVvO9WZMnXjTs9SOBJ9vrcBFicpqfxdtP9jSQxfgshY
         u7dQQHNmmdVfHy7EBpisqyh4qOF7S6cFAGIkVZQPezKT2j7GmC+f2Jj04WW8ALq6bFFh
         UjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GEehQF5Dq7lIZlTVWZjKtKY7k4OY7nbzWNuwJEp3uCA=;
        b=RDRRPRXpssIYs3ee+fMFTJRN5tldP47p+9ZFFlWe5CwgIB4yITgQWM792fRaWqws53
         qKLBzKhVfFhLaa6I9uU4tDX3qWhpirRZZr9ZNLtHR8K7pEcZM739xuTlGPXDKWVNQNbr
         tERP0t7gX64v8YZy4lJHxZ8zZuXqVRHWsWRt6ZnQFcmHPlkX6c388PqAbSrLZZwPB+g5
         AIjk+Rd5xWS35+fuqobj4exyzFeJTWvYqHUKQmjz8nZa6dIa3RJNzwm7vlfl6uLI1ubv
         u3lLK1kH7xBcAAdXkeAOFNQI0qvCtVWVIrQWY7wBk+DupEcl8dlcnj46VA2UkYOvi07C
         wG7w==
X-Gm-Message-State: AOAM533OvbSdm9OEoRK9N4hS+jYfZbzlBgUAQsZ5OD8VFMa6AeWAap/s
        OQqC/v8PRIIXDUX5ic/yxA4ACg==
X-Google-Smtp-Source: ABdhPJyqGlTk+siacmrLQja4dnmISvt+kPShXhh1/tbjp1nVBC+JbEMzt0kXUAxvx0gAMKiG4jlseQ==
X-Received: by 2002:a02:83c3:: with SMTP id j3mr19486288jah.81.1593465988443;
        Mon, 29 Jun 2020 14:26:28 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j17sm589053ilq.7.2020.06.29.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 14:26:27 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: ipa: introduce ipa_cmd_tag_process()
Date:   Mon, 29 Jun 2020 16:26:25 -0500
Message-Id: <20200629212625.1153600-1-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629212038.1153054-1-elder@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Create a new function ipa_cmd_tag_process() that simply allocates a
transaction, adds a tag process command to it to clear the hardware
pipeline, and commits the transaction.

Call it in from ipa_endpoint_suspend(), after suspending the modem
endpoints but before suspending the AP command TX and AP LAN RX
endpoints (which are used by the tag sequence).

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_cmd.c      | 15 +++++++++++++++
 drivers/net/ipa/ipa_cmd.h      |  8 ++++++++
 drivers/net/ipa/ipa_endpoint.c |  2 ++
 3 files changed, 25 insertions(+)

diff --git a/drivers/net/ipa/ipa_cmd.c b/drivers/net/ipa/ipa_cmd.c
index c9ab865e7290..d92dd3f09b73 100644
--- a/drivers/net/ipa/ipa_cmd.c
+++ b/drivers/net/ipa/ipa_cmd.c
@@ -586,6 +586,21 @@ u32 ipa_cmd_tag_process_count(void)
 	return 4;
 }
 
+void ipa_cmd_tag_process(struct ipa *ipa)
+{
+	u32 count = ipa_cmd_tag_process_count();
+	struct gsi_trans *trans;
+
+	trans = ipa_cmd_trans_alloc(ipa, count);
+	if (trans) {
+		ipa_cmd_tag_process_add(trans);
+		gsi_trans_commit_wait(trans);
+	} else {
+		dev_err(&ipa->pdev->dev,
+			"error allocating %u entry tag transaction\n", count);
+	}
+}
+
 static struct ipa_cmd_info *
 ipa_cmd_info_alloc(struct ipa_endpoint *endpoint, u32 tre_count)
 {
diff --git a/drivers/net/ipa/ipa_cmd.h b/drivers/net/ipa/ipa_cmd.h
index e440aa69c8b5..1a646e0264a0 100644
--- a/drivers/net/ipa/ipa_cmd.h
+++ b/drivers/net/ipa/ipa_cmd.h
@@ -171,6 +171,14 @@ void ipa_cmd_tag_process_add(struct gsi_trans *trans);
  */
 u32 ipa_cmd_tag_process_count(void);
 
+/**
+ * ipa_cmd_tag_process() - Perform a tag process
+ *
+ * @Return:	The number of elements to allocate in a transaction
+ *		to hold tag process commands
+ */
+void ipa_cmd_tag_process(struct ipa *ipa);
+
 /**
  * ipa_cmd_trans_alloc() - Allocate a transaction for the command TX endpoint
  * @ipa:	IPA pointer
diff --git a/drivers/net/ipa/ipa_endpoint.c b/drivers/net/ipa/ipa_endpoint.c
index 9f50d0d11704..9e58e495d373 100644
--- a/drivers/net/ipa/ipa_endpoint.c
+++ b/drivers/net/ipa/ipa_endpoint.c
@@ -1450,6 +1450,8 @@ void ipa_endpoint_suspend(struct ipa *ipa)
 	if (ipa->modem_netdev)
 		ipa_modem_suspend(ipa->modem_netdev);
 
+	ipa_cmd_tag_process(ipa);
+
 	ipa_endpoint_suspend_one(ipa->name_map[IPA_ENDPOINT_AP_LAN_RX]);
 	ipa_endpoint_suspend_one(ipa->name_map[IPA_ENDPOINT_AP_COMMAND_TX]);
 }
-- 
2.25.1

