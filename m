Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84694C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2FC20679
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 04:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lCJhFNpv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgFQEAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 00:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgFQEAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 00:00:41 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276ABC0613F0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 21:00:39 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e9so604028pgo.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 21:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yDywz5KHsZfDtJjHD0TS1I12nciGz5p5dKSUU+dChcc=;
        b=lCJhFNpvYxufbRcaNhjJjHftdOuPONUfQjBt1CQvwX0HZZZvQMm0uOaheKHnB7pm6O
         dWdbFCFmnMEi8YUYmcrOno7ku3vMDrRTdUXn/TykKlpW76kKwWAFyAp4qmGCtsBshJHX
         CVandVYErm+dOjXHip7tNRCsy7H41CfkpRS+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yDywz5KHsZfDtJjHD0TS1I12nciGz5p5dKSUU+dChcc=;
        b=AHwaXWaYjNvpsIV0MxI5gwqx8CCRlSeOJ5DGDwJZZBbvMrKheHQepwwqZl2/xUac97
         ZujtaqIpz6BREAlr1Oq9+6h+WIJqHJjiOdYk1oXw9PDfQMDPMFyPy4NCBzWtTfxUrFCy
         8UG+TIpw5SWO09z+L89nYm2CaJtReTpjnsce4B39ujw7GSpckr4f0+IgxFhbCG8MNJ3y
         PSowDI2IFameVsMb2OKztSXK+9xnWHl0W6EqIT3jmhjBEkfcFH7jSSaZXojMaayuFX/F
         yh4rCDihn8yuNG3E4JIIPq5AI2qhBOkKNWl4jsnZGM/TAaSCYy2zMq0/JqfJcFuqVbbQ
         gmxw==
X-Gm-Message-State: AOAM533ryGPlhX9/x8QJjHK+C/mx32y7ZAHb3MzQ8bXOsOnwgA+7Qbck
        7AiqTIVpT5PP3HF6JTHs21mKpg==
X-Google-Smtp-Source: ABdhPJw1QfW93JDC0AuJjA+rzSVERRMzEN/6yoLeE+3q6yy2JlVaSyGQAMme57mJrbSrN7khxu7K3A==
X-Received: by 2002:a62:1692:: with SMTP id 140mr5176705pfw.168.1592366438701;
        Tue, 16 Jun 2020 21:00:38 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id q1sm20013089pfk.132.2020.06.16.21.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 21:00:38 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     alainm@chromium.org, chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 3/4] Bluetooth: Replace wakeable in hci_conn_params
Date:   Tue, 16 Jun 2020 21:00:21 -0700
Message-Id: <20200616210008.3.I98a35b457f29a2c83e011519f44c529fea873ce8@changeid>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
In-Reply-To: <20200617040022.174448-1-abhishekpandit@chromium.org>
References: <20200617040022.174448-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the wakeable boolean with flags in hci_conn_params and all users
of this boolean. This will be used by the get/set device flags mgmt op.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Reviewed-by: Alain Michaud <alainm@chromium.org>
---

 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_request.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 0643c737ba8528..6f88e5d81bd24f 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -660,7 +660,7 @@ struct hci_conn_params {
 
 	struct hci_conn *conn;
 	bool explicit_connect;
-	bool wakeable;
+	u32 current_flags;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index a5b53d3ea50802..eee9c007a5fb40 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -710,7 +710,8 @@ static int add_to_white_list(struct hci_request *req,
 	}
 
 	/* During suspend, only wakeable devices can be in whitelist */
-	if (hdev->suspended && !params->wakeable)
+	if (hdev->suspended && !hci_conn_test_flag(HCI_CONN_FLAG_REMOTE_WAKEUP,
+						   params->current_flags))
 		return 0;
 
 	*num_entries += 1;
-- 
2.27.0.290.gba653c62da-goog

