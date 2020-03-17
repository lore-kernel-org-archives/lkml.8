Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950DC3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E154920719
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 09:50:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bKLGfSM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgCQJuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:50:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51366 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgCQJuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 05:50:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id a132so20668134wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 02:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=CfiAQpd8uQoL3iwwwAGqh6gxvyBaIrgMF1i3mX+btOA=;
        b=bKLGfSM9UWMVgvxw9K4+lnLcWmqVr8N9nWD3shrd/QZtInCP8z5IrA4LsnnWcpQTDU
         qP6buHmWIrzh9IVIxla3zk48G3q9HrTis+C/wMKr6qKELE/Bbq3x9M89bEuSBDjvdEyd
         aD2U7OjDYVAA/VdnvZ5FSMaedfaNU+8nWtoS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CfiAQpd8uQoL3iwwwAGqh6gxvyBaIrgMF1i3mX+btOA=;
        b=k0Xmaw6u2i6oePYPkW9VookrNgsXZapPjPPl14m0XgdAbdoQAFb+9gwIjgKRSAhnrc
         hdHQNZr3bOFj4oGca+VQBbxrZ2OYwn9ZwzeSHD5OJmVeyWVQxZAQVefSbShE9o2Os5MQ
         yLDW36Uy+iMpi0uyshBYGCZ3aidcWTfVny5McjvwpqT3LnR8ujDrgDVQttvSzUKeIuTw
         BcSxhI8Z4odgsrsCrN61lPXlH8zWQPvAKMtGalx5t5UPvL9Sb79knr2dtlSFNAyGfcFT
         kXOKBP+FbA0WLGNIALLuzqV9pfz8yjIzwTNQx/awWn7iVLRgRo4V048e1+fjKZJ1F43c
         3tBA==
X-Gm-Message-State: ANhLgQ3uOy2B1cr6Jdj/cQQkjpMyoo9QoiabRdJ8UoOox5Mu3OylfNDk
        7ehLjKY4k4TPAXbnnpd2YEd1Xw==
X-Google-Smtp-Source: ADFU+vsvnEQ2euzuGI9HkfkPRYnzpyOc7RRTEavFnN573nqDk6l9mVYBfp2n1KUH8274z5uKVcgfZw==
X-Received: by 2002:a7b:c950:: with SMTP id i16mr4335733wml.97.1584438648582;
        Tue, 17 Mar 2020 02:50:48 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id l18sm3845033wrr.17.2020.03.17.02.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 02:50:47 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v2 1/1] firmware: tee_bnxt: remove unused variable assignment
Date:   Tue, 17 Mar 2020 15:20:37 +0530
Message-Id: <20200317095037.22313-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable assignment.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
Changes from v1:
- Address code review comment from Sergei Shtylyov,
  Correct the commit message.

 drivers/firmware/broadcom/tee_bnxt_fw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/firmware/broadcom/tee_bnxt_fw.c b/drivers/firmware/broadcom/tee_bnxt_fw.c
index ed10da5313e8..6fd62657e35f 100644
--- a/drivers/firmware/broadcom/tee_bnxt_fw.c
+++ b/drivers/firmware/broadcom/tee_bnxt_fw.c
@@ -143,8 +143,6 @@ int tee_bnxt_copy_coredump(void *buf, u32 offset, u32 size)
 	prepare_args(TA_CMD_BNXT_COPY_COREDUMP, &arg, param);
 
 	while (rbytes)  {
-		nbytes = rbytes;
-
 		nbytes = min_t(u32, rbytes, param[0].u.memref.size);
 
 		/* Fill additional invoke cmd params */
-- 
2.17.1

