Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82862C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAFC22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9xpXhZg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731126AbgGTUOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgGTUOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:14:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E376C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:14:31 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id q71so522829pjc.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=krJhVfJ5+Ckuq9PCZ6ReNrT3nN79ynOsubIFQ9bjPFU=;
        b=K9xpXhZgErGQGsCNHv6NSz6X1tT6aaqTl6hgTIO7ArQ5XkeWCK1Tq9qvYhfR9aMNwQ
         Ohur63BSOsP2v959h/f/i92I9t7Xuie7QEeRND/fHpx+oe04OGV3Pda48NVTMU91UyQG
         EewLAbILea9HMnQN12vwnOIYsDVOThmiyK8r/frWwoNoMutju3f8dIehVHPL7iGvkQTT
         MRyCKur0KBpFKBdDTwRK15Wnw9Uqiitqfq446kVQkDMUVKcPuqPFLrBMQ7rllDawpRqr
         w+lC3UoclqAeWeFjA8TlGU7Yy2Sj4bOVtQl5msDP28UKMUAW9CgLdSWBP7qAU0HmVoqe
         GYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=krJhVfJ5+Ckuq9PCZ6ReNrT3nN79ynOsubIFQ9bjPFU=;
        b=Rl1OdoXF8O+i/tv4gBqbD7eovVgJ178hbdXOf94gv/lG5WRLq7y0kkUuFqNSgcv3fh
         BZ2EuEGTgeindZELw/pyj3pZazm8YB7fU1eDM6p55h5yLB3dyPLjfmXDeQoqD+7Y7Lx1
         cYp5rLavh/HbC6+YEkwf+rcILO7GFH8HYOlKt5H4lWmyTxk+bCSxmlrgESiQlivhuRlt
         qwjlzP5LaeHlvtAGYGWx6ruwBgqNsEgPGhO8fLCoHdZmNbXEuCn1vuOlAv09wJ8uSswx
         BatVaqp42N9W+QCekUUrIBW/Pf3O9ECuONV5TGBEnvnCotHLcxW/o5YtUZewIcizEjo3
         OyxA==
X-Gm-Message-State: AOAM533nPN6ZvPRXnla891JFF3BsO4AjJJayHcixVjZE8/QKKgZqJ8Ka
        L+ubFV6iJpOTOKRlJmYEF5IvgenHAdpaHv9R
X-Google-Smtp-Source: ABdhPJxV4Zlcsi10sNbbXvZBXPQi8LKWus38AJAlk4iveR3bz+izOrpeCicWeLkzHq6K1HCP6piJMXv+3ln7898j
X-Received: by 2002:a17:90a:3044:: with SMTP id q4mr589631pjl.81.1595276070672;
 Mon, 20 Jul 2020 13:14:30 -0700 (PDT)
Date:   Mon, 20 Jul 2020 20:14:22 +0000
Message-Id: <20200720201422.1869389-1-linchuyuan@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] dt-bindings: hwmon: adm1272: add analog-temperature1-enable
 binding
From:   Chu Lin <linchuyuan@google.com>
To:     linux@roeck-us.net, robh+dt@kernel.org, jdelvare@suse.com
Cc:     =belgaied@google.com, jasonling@google.com, linchuyuan@google.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongqil@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
	adm1272 and adm1278 supports temperature sampling. The
current way of enabling it requires the user manually unbind the device
from the driver, flip the temperature sampling control bit and then bind
the device back to the driver. It would be nice if we can control this in a
better way by reading the dt.

Solution:
	Introducing device tree binding analog-temperature1-enable. If the
flag is set, flip the temp1_en control bit on probing.

Testing:
make dt_binding_check

Signed-off-by: Chu Lin <linchuyuan@google.com>
---
ChangeLog v1->v2:
  - Rename adm1272-adm1278-temp1-en to analog-temperature1-enable

 Documentation/devicetree/bindings/hwmon/adm1275.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/adm1275.txt b/Documentation/devicetree/bindings/hwmon/adm1275.txt
index 1ecd03f3da4d..7a345c7794a2 100644
--- a/Documentation/devicetree/bindings/hwmon/adm1275.txt
+++ b/Documentation/devicetree/bindings/hwmon/adm1275.txt
@@ -15,6 +15,8 @@ Optional properties:
 
 - shunt-resistor-micro-ohms
 	Shunt resistor value in micro-Ohm
+- analog-temperature1-enable
+	Enable temperature sampling. This is supported on adm1272 and adm1278
 
 Example:
 
@@ -22,4 +24,5 @@ adm1272@10 {
 	compatible = "adi,adm1272";
 	reg = <0x10>;
 	shunt-resistor-micro-ohms = <500>;
+	analog-temperature1-enable;
 };
-- 
2.28.0.rc0.105.gf9edc3c819-goog

