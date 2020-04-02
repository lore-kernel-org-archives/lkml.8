Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB193C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9E3C206D3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 00:16:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cNdWW43g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbgDBAQp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 20:16:45 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42479 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732667AbgDBAQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 20:16:45 -0400
Received: by mail-pl1-f196.google.com with SMTP id e1so642579plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 17:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fXLQxqAp2zza6drCXmECdjz6fLl1/eIzwRmxB0qO54=;
        b=cNdWW43gQoOc9g32pUPJp+98yD9T36+a+P6z/BRS3x/U3AGgwdnQlAy70BjIwDkxJR
         lSw3g9U9t1NPMRjHz+b8dn47VA9QYS4JZ7Hs71mEiK0ZLinh/AouliC8KMRrzLsU/Hnb
         TtMeWrM//E2Y51SX6TQfVZGaW4DNx4avi7HCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fXLQxqAp2zza6drCXmECdjz6fLl1/eIzwRmxB0qO54=;
        b=bZnjagr2W9AhX0MZndGvugoK3HNzJASgLSp0fjgUBkS00Xwf8vxPKgGhHCHCEdVgxU
         6eZGG47ZLSby2iFYjz8ZqAjyeMpvUTRP5qpHEeZi6P+sbUzkSxB2CNS7lMJY/ma0WgGC
         tiKt0eZ8p83hz6E9tJZrKOg81vyZR5UaWh2NpCS3MMw78IMKD9gv5Acd5tuU36J1SOPA
         TtS1jD6KgQuPUv2uYVdikQgGaLNZTxphyJUXyt764VqJVOduhhOxh6rRGSL/msgynbx8
         nh5gFjihlROjtts/RtR9QfiYo34B2Pyg37yd9F3aaNicXE/3JnSIESj3gqpQyEoV1X5p
         6/Xw==
X-Gm-Message-State: AGi0PuZFakBic5Z2+Fp4AKky2J4wtmDg+naLVrZJVw24bp5BUfRqR2yu
        JZZYF7JL8BAkXjCd/nk5ANsAiA==
X-Google-Smtp-Source: APiQypLYxO69qNjCz9jmsAfOLPgOa+QPf4w4E6JMlN5q0sVKV1pck3Re9+BwSLgb1y3xynTqOwd6cg==
X-Received: by 2002:a17:902:b015:: with SMTP id o21mr415166plr.91.1585786603861;
        Wed, 01 Apr 2020 17:16:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:f454:d690:f45b:2a81])
        by smtp.gmail.com with ESMTPSA id p22sm2333001pgn.73.2020.04.01.17.16.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2020 17:16:43 -0700 (PDT)
From:   Sarthak Kukreti <sarthakkukreti@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com
Cc:     keescook@chromium.org, anton@enomsg.org,
        linux-kernel@vger.kernel.org, ccross@android.com,
        tony.luck@intel.com, gwendal@chromium.org,
        Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: [PATCH 1/1] platform/chrome: chromeos_pstore: set user space log size
Date:   Wed,  1 Apr 2020 17:15:48 -0700
Message-Id: <20200402001548.177025-1-sarthakkukreti@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On x86 ChromiumOS devices, the pmsg_size is set to 0 (check
/sys/module/ramoops/parameters/pmsg_size): this prevents use of
pstore-pmsg, even if CONFIG_PSTORE_PMSG is enabled. Set pmsg_size
to a value that is consistent with the size used on non-x86 ChromiumOS
devices.

Signed-off-by: Sarthak Kukreti <sarthakkukreti@chromium.org>
---
 drivers/platform/chrome/chromeos_pstore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/chrome/chromeos_pstore.c b/drivers/platform/chrome/chromeos_pstore.c
index d13770785fb5..82dea8cb5da1 100644
--- a/drivers/platform/chrome/chromeos_pstore.c
+++ b/drivers/platform/chrome/chromeos_pstore.c
@@ -57,6 +57,7 @@ static struct ramoops_platform_data chromeos_ramoops_data = {
 	.record_size	= 0x40000,
 	.console_size	= 0x20000,
 	.ftrace_size	= 0x20000,
+	.pmsg_size	= 0x20000,
 	.dump_oops	= 1,
 };
 
-- 
2.26.0.rc2.310.g2932bb562d-goog

