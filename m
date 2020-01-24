Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6BDC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:19:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB8120838
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 08:19:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMHLT1B1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgAXITF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 03:19:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55353 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXITD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 03:19:03 -0500
Received: by mail-wm1-f68.google.com with SMTP id q9so781349wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 00:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EYXzH+H+dYYs2s9oEC15MO7DnSTfxVq0anYWtofAEvU=;
        b=WMHLT1B1V8VMJQ6+eutHfhQrXRLLPIUI6C+IdymyX7eJ4Qx5tz1e2M8ENmee0X3u/E
         yb5ThDSDWnvSZiumf+GgH1Ve9lAmr4kpytT1CZ59VcQ6LRNkxqxZfJwgV7FJSGaaMSSj
         p5xT4WRGbUvn/MdFYvgi4oEQf0XkE7gDX6a3p/pacn/Xmg5CEr3Du57KujzH1DfjzK08
         KGUcKsBzUHoc8NoAT+dC28wh7clo602Iv6TouEUpmkHoiTM2EVxkUA4zvgUh0ibYMOmv
         HmquZuPvrdGO6/JMGqYghY7ojm+wd79BX63iyNGyRSNturNb52n1fKYuEmHYxVecFC6p
         L9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EYXzH+H+dYYs2s9oEC15MO7DnSTfxVq0anYWtofAEvU=;
        b=lOIpJrl2NYEU/IZCSju8Xg7D65+zslIc8KW1G5izkTNZotnq7n4QmtLrzmIrUiKMDz
         o+mOPESzbaUxSepdSvxl1P0Wa3vHXxsHoTtS3jPDLcy1wUzMqpUFszVy05l2SJv6thTF
         yipWSoyjGW9xdSGQBRQSoe3wPuOKDc71qX8PsuyBcjsDXHPI76gCn8P3L+xNBsJ+RBvD
         5xXE2Irm8m59pMa8IgFyjFrWS3UnsGEHHE6skwx2olJiyN6pXc0OKp3t/VRXJfkXmTO1
         O1HB+8j/18gZLhqJDoZb0aPER/u/9aV9OvUAp25eRd9lvxXSC5OG+Ki/dV+xEA01iQNu
         oPEQ==
X-Gm-Message-State: APjAAAX8WnM+5PCOI1YWqfBNAxPIx5meUSed2vVShtgmhPmhi7Q3c2ov
        HH2vbMzxchtaoEXx1B9FBjm1SNoHyIKL6Q==
X-Google-Smtp-Source: APXvYqy42um/AC80iyve1O6j/ud6xSEH06OklOsJ1TvbT+3k8XTXmlgwtDixRIjUskyj8E2ZeDqCDw==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr2242778wmi.118.1579853941957;
        Fri, 24 Jan 2020 00:19:01 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id y15sm6046555wma.2.2020.01.24.00.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 00:19:00 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org
Subject: [PATCH] habanalabs: patched cb equals user cb in device memset
Date:   Fri, 24 Jan 2020 10:18:59 +0200
Message-Id: <20200124081859.23849-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During device memory memset, the driver allocates and use a CB (command
buffer). To reuse existing code, it keeps a pointer to the CB in two
variables, user_cb and patched_cb. Therefore, there is no need to "put"
both the user_cb and patched_cb, as it will cause an underflow of the
refcnt of the CB.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/goya/goya.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 382331cc00d3..74785ccd2cb1 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -4693,8 +4693,6 @@ static int goya_memset_device_memory(struct hl_device *hdev, u64 addr, u64 size,
 
 	rc = goya_send_job_on_qman0(hdev, job);
 
-	hl_cb_put(job->patched_cb);
-
 	hl_debugfs_remove_job(hdev, job);
 	kfree(job);
 	cb->cs_cnt--;
-- 
2.17.1

