Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C05C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 03:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368E020735
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 03:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="T47xmdIs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387547AbgEWDQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 23:16:21 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:41128 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbgEWDQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 23:16:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49TT5w15nFz9vfWN
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 03:16:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id M8LllSdV3WHl for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 22:16:20 -0500 (CDT)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49TT5v6WwHz9vfW1
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:16:19 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49TT5v6WwHz9vfW1
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49TT5v6WwHz9vfW1
Received: by mail-il1-f200.google.com with SMTP id g19so10280276ila.12
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 20:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9+5ZbDGAf206FjfB/Y4KtRjTHhCj+Zv9K8sI80lDtk=;
        b=T47xmdIsnMA3yh760O6PAYrHanqjkCLCvEn2/BlkxEytWqwVaoyV6+EXGBT/kpnx1n
         Y7sBtT4Cz/jUOjjT/R5+xq3Eb781dRVxN4nzLxP99C2UnVwKPSoleE2+BcJ/7KrGn1N4
         3zZr+PFavfWN5Kf1i4MpIdEwMgita5rsjT10hcry+NEBRvGrOXLlkud3fWdmBcP7bcbA
         0QlQGQdz+NYlIr0iz1fl7dP6c2pJA44wCZLqxFEMDeUtfQbRgLJetqQb0qY9FQFNZqZu
         lLf/SUj+aHPouPhjMlfF0AtDj+XUqL/b+F5tG3luVaNCW7BOU//Vx0UGF4fkkva2yTpn
         PQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/9+5ZbDGAf206FjfB/Y4KtRjTHhCj+Zv9K8sI80lDtk=;
        b=e3A2GMQfvnZ0MmMYCeW9v+I9OBZShxXweNPBknrLZvGgngsNBOCFhYmBrAHO6PD3Sl
         hByJ87JM0kkrEwp+2VOPVA0ZMQqYpN4odHbvtjNbnV3FchGCqRWkSP7ebwftPEZxZtHE
         8BY+fhBiNVERlqYmtRCcpgX2Zw2q0ehHBCbtexImKwJMPXR7N6DSe3H1L0F0O0yc6QRE
         zrV1/K/aYyS7qXRBe5ltKV+VWZusxAH54DQZ6e0VoWA3Vrv4Jj8Xu5o+ylR6b9gmDjlV
         /Kn0K//gSaXTWPmmuIGLBKaCw0rLS8SEJD2jD2WRDXEkzujc0Ekf0V7QLXkOEuWpRm0j
         u2hg==
X-Gm-Message-State: AOAM533PfgXQS7ykq8N3GDA8miVYzIg/1FfNip7wjCLCC3paNRhxOYTC
        a1qJE3CBingRHkjpmI1S/9uLRhqz2PqsDyp61J/L3osufgmoYLonkMtLsjBK7/ARVUSQToTeg4Z
        LZTqmOCbR7WG+F+Tge9LaTo5LSJ01
X-Received: by 2002:a6b:7515:: with SMTP id l21mr5574911ioh.82.1590203779360;
        Fri, 22 May 2020 20:16:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxVw0qOOCzSdfRC1iQj2JMEBteYw0RaJJdsRxe31UT8PO1YV1RbIdpUHrDVX29bG9bIzV6xTw==
X-Received: by 2002:a6b:7515:: with SMTP id l21mr5574900ioh.82.1590203779051;
        Fri, 22 May 2020 20:16:19 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id w88sm5777247ilk.83.2020.05.22.20.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 20:16:18 -0700 (PDT)
From:   wu000273@umn.edu
To:     bleung@chromium.org
Cc:     enric.balletbo@collabora.com, groeck@chromium.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] platform/chrome: fix a double-unlock issue
Date:   Fri, 22 May 2020 22:16:08 -0500
Message-Id: <20200523031608.17918-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In function cros_ec_ishtp_probe(), "up_write" is already called
before function "cros_ec_dev_init". But "up_write" will be called
again after the calling of the function "cros_ec_dev_init" failed.
Thus add a call of the function “down_write” in this if branch
for the completion of the exception handling.

Fixes: 26a14267aff2 ("platform/chrome: Add ChromeOS EC ISHTP driver")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/platform/chrome/cros_ec_ishtp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_ishtp.c b/drivers/platform/chrome/cros_ec_ishtp.c
index 93a71e93a2f1..41d60af618c9 100644
--- a/drivers/platform/chrome/cros_ec_ishtp.c
+++ b/drivers/platform/chrome/cros_ec_ishtp.c
@@ -660,8 +660,10 @@ static int cros_ec_ishtp_probe(struct ishtp_cl_device *cl_device)
 
 	/* Register croc_ec_dev mfd */
 	rv = cros_ec_dev_init(client_data);
-	if (rv)
+	if (rv) {
+		down_write(&init_lock);
 		goto end_cros_ec_dev_init_error;
+	}
 
 	return 0;
 
-- 
2.17.1

