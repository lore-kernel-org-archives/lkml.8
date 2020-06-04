Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0E2206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UJqmJXRM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgFDT53 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728991AbgFDT52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:57:28 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51542C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 12:57:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p21so3961181pgm.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 12:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17b2aaxx9AWik+/H6nkchZPzWER/WcSta2U6qBhKjfI=;
        b=UJqmJXRMu1MCMIknBTQnQbAcYFvoypy/3vBe+OATtsjD/2iSOyg5q2yQ/edgeCLPSd
         bn8wZpbzUnj4rYWdkqMW5g9R2NMAPbfWz9eCOAazkyIzP83AmLPbYiaOpAM/Y8hfr9l0
         zPslHOc7sqHKhoejCEYWz1TIpXbjQlC7UPrO8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=17b2aaxx9AWik+/H6nkchZPzWER/WcSta2U6qBhKjfI=;
        b=jH9/phfczWFOzxIYFtGoRU3qM99gyv7RkzXwGFkBpctqd1ResoM4mEpLTqgdkV4/hK
         YOD+L7ZstqTh9zYNLe+sZ6NVRNHY5Xq59OpJE0fBvfkk2WYgFI1lov6XZvcnkMIuLHZC
         TtI1Je0yOZMfRLVjTBW7X6pwvvGyaU1tzlas/BOo5SoOB0Ja931DIaMY+6YHH5hqBTi4
         VbFi2hX0ycVUKjnex643UglLMrg+LsuE0NwaXtQXOBYOif/aiAJ1eYGdPSD1jySu02MB
         /aTJAAYidjAJDDKdw18AZzg8qMsN455/0tUU7/rVQNb8tpWul95srqHx9bi6rJQSxGsz
         wYNw==
X-Gm-Message-State: AOAM531VEuMZgYSQd3u6ydF18Hf5pyKnyh8ZxToipN8CXJDzbge6atYh
        9tNYtXsBqeSGUPdggyjynR+y+JNRlrjSnQ==
X-Google-Smtp-Source: ABdhPJwN5n5f0TKfN423aURRb4ZD2T087OtrXyelKJTyJ/6QqMLlLTeoMVmKyvSJ1+0DhyBpwVEeEg==
X-Received: by 2002:aa7:9d01:: with SMTP id k1mr6059050pfp.6.1591300647119;
        Thu, 04 Jun 2020 12:57:27 -0700 (PDT)
Received: from mathewk1.lan ([161.97.192.125])
        by smtp.gmail.com with ESMTPSA id p19sm5324130pff.116.2020.06.04.12.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 12:57:26 -0700 (PDT)
From:   Mathew King <mathewk@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Mathew King <mathewk@chromium.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
Subject: [PATCH] acpi: battery: Always read fresh battery state on update
Date:   Thu,  4 Jun 2020 13:56:58 -0600
Message-Id: <20200604195658.66201-1-mathewk@chromium.org>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ACPI battery receives a notification event it should always
read the battery state fresh from the ACPI device and not use the cached
state. Currently the cached state stays valid and the new state may not
be read when a notification occurs. This can lead to a udev event
showing that the battery has changed but the sysfs state will still have
the cached state values. This change invalidates the update time forcing
the state to be updated before notifying the power_supply subsystem of
the change.

Signed-off-by: Mathew King <mathewk@chromium.org>
---
 drivers/acpi/battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 366c389175d8..ab7fa4879fbe 100644
--- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -981,6 +981,7 @@ static int acpi_battery_update(struct acpi_battery *battery, bool resume)
 		acpi_battery_init_alarm(battery);
 	}
 
+	battery->update_time = 0;
 	result = acpi_battery_get_state(battery);
 	if (result)
 		return result;
-- 
2.27.0.rc2.251.g90737beb825-goog

