Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F856C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F102F207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 12:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KkXHJTeU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387888AbgF3MpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387856AbgF3Mow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:44:52 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7771C08C5DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:44:51 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o5so20739694iow.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 05:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hhprUszVmOlah4/Ur36hFj2E6ek/4IJi+AwyXGta/Jg=;
        b=KkXHJTeUKg/muI7mgvHgvdw0wHDkMhda+sgSpItV1HTVh8YztFciCNhoOjQKWdxzUb
         RMVDJrke3LdwacR2ltk3mQ0OlSf/j1AqcB3jIlm6404ZT9Heg4oq4QeMghI0Y9JH1yFr
         X97j/i2ZuE3dGuSaz3Jyz3AQSmzNzdUFS2mtYDKcvP4jlThSZRMq1vOX+UHU+vUwyn/7
         /HSw5KsZL5AQUls3hoBL7q2dOeaTdPwEpqdmtnK8DCpDvwBPV96o8Hzz3/B9dFYd7o0G
         k1SBdVn17rh2y210NAK51W80Nmjdf0VA4aJjgdKYq+75o1r6JefIpzP5NwntSVNRWgag
         gytA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hhprUszVmOlah4/Ur36hFj2E6ek/4IJi+AwyXGta/Jg=;
        b=mPCaEU0/OXK+3jLfy3yQw/Sa/wlbjEsuAe8PSHVHhTWDZXGCjoiYfCPzpk0++HKegY
         ZO+8AV3YiJ6NZnoAuV26WsvvEUMFPE6093RhzDR0n56u6zEcZb/NYxEYLUfXA5nMpeVb
         wilPckx6eyn0MwoGdUdNR2lRfiksqkYotnT+hEEGrYqo7wbgAFbwtKlmry8tOelHlFTX
         RTj4y5vZ5ThDM80rcPjmLOQeXXz0F10UrXvKgolAAasU30oAHPr/06q2vt1J/QuX74/E
         Kmw9YbDWvz8974BQyT4cZ4xciV4yr80kdXccuxeIbeJWPK/kfHpm61/URueWYm+kYJWx
         Gumg==
X-Gm-Message-State: AOAM533+r694sbuinDIYR8taSArnj+gS38nfJ1IyMsYA1hrGvUH8Pc9T
        7iDui8uvOB6jO+6dXysCDQC3sg==
X-Google-Smtp-Source: ABdhPJx5QCzEAoSIXCAgs7Xjvdp9nA0ty9XkbxyGtHSAg4gn8mcdGAFfplB1eox2dAesFk+KXERksw==
X-Received: by 2002:a05:6602:2c8f:: with SMTP id i15mr21731390iow.45.1593521091047;
        Tue, 30 Jun 2020 05:44:51 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id t83sm1697536ilb.47.2020.06.30.05.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:44:50 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     evgreen@chromium.org, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net v2 3/3] net: ipa: introduce ipa_cmd_tag_process()
Date:   Tue, 30 Jun 2020 07:44:44 -0500
Message-Id: <20200630124444.1240107-4-elder@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630124444.1240107-1-elder@linaro.org>
References: <20200630124444.1240107-1-elder@linaro.org>
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
v2: No change from v1.

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

