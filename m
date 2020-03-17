Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92CB7C4CECE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CC3320658
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 04:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XULrSr+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgCQEH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 00:07:58 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35142 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgCQEH6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 00:07:58 -0400
Received: by mail-wm1-f67.google.com with SMTP id m3so20367322wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=33jKlqaYa25AsU3VntdMH3umyT6AHcOYuqn7A0K1VBU=;
        b=XULrSr+Wd/YnDJMybcFNeMh5Gg9yENwZPEIlhwbKwlq5vSDVqgNcTVtYq0bNvx3yBy
         pVODbjuuneMTk+XfxXjAJv6lp2w8hCBIk4m+O1KppoeGvDnSGsefYVfgc2O3bUYKVbZo
         S+fqFBkxEjoOniy7neehOXUGxd6n9fOb0Wodk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=33jKlqaYa25AsU3VntdMH3umyT6AHcOYuqn7A0K1VBU=;
        b=Ki2zctlh32O9UCM/1O/jKJwnmRXHIgdmQPch5pM0ha3VJPtzF1Qvf3XYR+xPpmjOmp
         MDXkrPL+SilBHIb8Ct8s7qydM6bfxMCvUrbX9lICRgXgVN8qq30joPGcIWlvMgotKIdO
         mb1BgqOse7C9Z91FnGiDdaMYlvfTe2JKVPYtkkoc75sso3ymZrft9akKrOo0dA3+w0wX
         TZ4z/SgZCxidC6/hZyrRF0DrYbWZpsHIQeSnp46QZd+2DqTC8cOcooHHtiyPdoX9gvhj
         9+WXhix/vzwVF4gTLbV/Gi6jwkBh258CUgFhoQYbVyZViyepvB1h6hQgFMullgUCfxhx
         qe0Q==
X-Gm-Message-State: ANhLgQ3AsI0yERrZvK+Gd7FSPHa4Q/sXRo5s7iLJHCf2tIKMwaElSWD8
        hWp9nLx4pn8XT2+w2iZMpHzOEA==
X-Google-Smtp-Source: ADFU+vvv6IHi1oLKWK4ZaJ7buqvEU1QsVEHlTLtwhB2/6w/qOCyZlOM6mC2HvWEVzlS0SrRovdZ1xA==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr2656158wma.122.1584418075697;
        Mon, 16 Mar 2020 21:07:55 -0700 (PDT)
Received: from rayagonda.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id z4sm2811766wrr.6.2020.03.16.21.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 21:07:54 -0700 (PDT)
From:   Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>
Cc:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH v1 1/1] firmware: tee_bnxt: remove unused variable init
Date:   Tue, 17 Mar 2020 09:37:42 +0530
Message-Id: <20200317040742.12143-1-rayagonda.kokatanur@broadcom.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable initialization.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
---
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

