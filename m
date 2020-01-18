Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177E5C32771
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA9C62468B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 19:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwKVDQ8J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgARTzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 14:55:12 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55300 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgARTzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 14:55:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so10593248wmj.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jan 2020 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM0XrNuGjQFOSpo+CZClXSAP8gXCw6sp9uQ5zawRgtI=;
        b=IwKVDQ8JkIHm1b7AigJDfK4SmLviI6HnzRsLfL5aA2kxFduiJpmQgW0Jg5lImk5zVZ
         6hHF962TrC54WZNuTwgrzKvkOqtyYxptb7VBNouO/yMe0Lmja8L5F5Y8Ha0//mmGtsbN
         uOftkFPjGH+OVkhr0DUkwqxrKfrBCdZK19rPUVRXWjSHLoKrW3WKvbhwMAhLEv2oZz7I
         jeUw/0ZVdCX7HFcmCgpH+wzZEZqhVauYOBBlK6b8IbkTizoaX5Qtg6bOiO5BlD+NAO8E
         HLxgPLP1gsKpccJ1AjDhcAKFw//kcEvSD6zdrY99LCZrTnCpXJmi1GCcnc63YeIf7RRQ
         5u3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eM0XrNuGjQFOSpo+CZClXSAP8gXCw6sp9uQ5zawRgtI=;
        b=fqWFuBFAsBdRaAOU7eUr0PjdyUfw5q6MBGfqtqpVKwmDqm/alqKgQ9484vcYnbBy88
         L0E8PNDsESiG5cO5mEqMYxfBAGE+p43xQX9iuXeTEoPwG3YBbCrY7/m6jdRLbHx0iodX
         pKAl6Iej1GQk8IHVhqIMviz1gZTR84DcHxdSQrbQ8PSCddfGWwsHrztEEMoEtYxJqdol
         zg8UiJ1oBvdu84Q2LFiYjveCKDQGjVQDJxq4jG5aTfu+bfG+xDmjpPWiX2flvuc0RIRf
         EfXDL1jqPIeYqmqMUxshZuX1GFLPY1OaRQBUS6JkNCJBQP+AkNY8pZ1OHv6O2uIX8lES
         lkzQ==
X-Gm-Message-State: APjAAAWLqBILscBwVT81Yo4iGhEs6JW6Hs9jJbuhXYu6N0aIqe4GxBgX
        XG5ZZ+Sv5vqGIl/V5jIWYiQ=
X-Google-Smtp-Source: APXvYqwMBqLoaxtd7GUtIPi9YaNzM/dA1ehyBk5DdKCzfkfHtgLcs8qbzHDs6Qe396P9B4fJ1rm34g==
X-Received: by 2002:a1c:44d5:: with SMTP id r204mr10884223wma.122.1579377311339;
        Sat, 18 Jan 2020 11:55:11 -0800 (PST)
Received: from localhost.localdomain (dslb-002-204-143-199.002.204.pools.vodafone-ip.de. [2.204.143.199])
        by smtp.gmail.com with ESMTPSA id z3sm39877523wrs.94.2020.01.18.11.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 11:55:10 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: rtl8192e: simplify rtl92e_evm_db_to_percent()
Date:   Sat, 18 Jan 2020 20:53:03 +0100
Message-Id: <20200118195305.16685-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use clamp() to simplify function rtl92e_evm_db_to_percent() and reduce
object file size.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index dace81a7d1ba..caf36b6bf0dc 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -1973,18 +1973,11 @@ u8 rtl92e_rx_db_to_percent(s8 antpower)
 
 u8 rtl92e_evm_db_to_percent(s8 value)
 {
-	s8 ret_val;
+	s8 ret_val = clamp(-value, 0, 33) * 3;
 
-	ret_val = value;
-
-	if (ret_val >= 0)
-		ret_val = 0;
-	if (ret_val <= -33)
-		ret_val = -33;
-	ret_val = 0 - ret_val;
-	ret_val *= 3;
 	if (ret_val == 99)
 		ret_val = 100;
+
 	return ret_val;
 }
 
-- 
2.24.1

