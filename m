Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B0AC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1562074D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sK/MjBLn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388427AbgF3Nvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbgF3NvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:51:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2F0C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so7223000wmi.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 06:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HQs0EX6y4pWd4N+iRFQEBAE/mvgYPFVjycd+tHmjaQ=;
        b=sK/MjBLnUjG8NYp5Oa/pEOupOcPm/ZEJfX5LnNv64UNaye7QtI6qhMXXu5yhPadFKO
         slhHIIMGRHslLQUhQw0nGrvcB2csGQrLajPzJws3XAbX+dSqe+64BeuOrd2V4sa1KDlM
         qwewlAHNNakuxpilJrs56Kd+6HnPc/0FW/QpbIcrX0HsO/Js14vmF7Tl508WyfN4TGfC
         j+bx/2GEUtQGnpfOLnqKFS45PXFGGEaf4H79E8BMcD6o0gmc+cw89fIaEX2oR/pmOtxm
         DpCvADMUFGfO24Z8Ib1xpuo/06RZGIX45/BRDt8vBw0P2IXU+DfVDDcX5IqjHPTf/hmg
         75FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HQs0EX6y4pWd4N+iRFQEBAE/mvgYPFVjycd+tHmjaQ=;
        b=Y79I0FssVPVrvUnjYpciq99zrcSSaomPFBycS3TDzVN1+byguawRkfyaVTCIk3YVUy
         T5NG5lrAnQRWYPghTmZmS7KzA8jw2jerpUM66nKkysdBz/0hYinpJcBXHroK8vJFvi1f
         tLcv7Huz5bSpKRY0C5wvTYv9LUJmnTjrIcwxdighAL/ERzrlWcliA1gtC7RBPtBQsTF1
         7iFamYPFLdo3DIUNa+z/GoTxM9ICbIVBqeChyGbI2OyerW8LCuuIbZbICl0fCFA05jg3
         f2oyMKWmUuLqy4aNLorqZdJ4MlYhlY17axSecq4dKdHZMm7xfbMDTYE8llJ+vuBmSpZ1
         cDkg==
X-Gm-Message-State: AOAM53012UH51kI5UB5zcJkejCJXQV+KxZoGuyCx6ytXHlkpzph1h9Nm
        WKLSwbRMyHTRh0HbHrIX1t3Kpw==
X-Google-Smtp-Source: ABdhPJw0TifXBK9AOZnXWLaDXMh1MZL4Xz0zESP5aT8WW2ZN59Rj/jcbvhPgWlb4zVF2mMhmDW6lag==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr21845849wmg.93.1593525082614;
        Tue, 30 Jun 2020 06:51:22 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id t4sm3876746wmf.4.2020.06.30.06.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 06:51:22 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Max=20Asb=C3=B6ck?= <amax@us.ibm.com>
Subject: [PATCH 08/30] misc: ibmasm: r_heartbeat: Demote function headers from kerneldoc
Date:   Tue, 30 Jun 2020 14:50:48 +0100
Message-Id: <20200630135110.2236389-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200630135110.2236389-1-lee.jones@linaro.org>
References: <20200630135110.2236389-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The correct format is not used and no attempt has been made
to document the function arguments.  Makes sense to just demote
the header back down to a simple comment.

Fixes the following W=1 warnings:

 drivers/misc/ibmasm/r_heartbeat.c:49: warning: Function parameter or member 'sp' not described in 'ibmasm_start_reverse_heartbeat'
 drivers/misc/ibmasm/r_heartbeat.c:49: warning: Function parameter or member 'rhb' not described in 'ibmasm_start_reverse_heartbeat'

Cc: "Max Asböck" <amax@us.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/ibmasm/r_heartbeat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmasm/r_heartbeat.c b/drivers/misc/ibmasm/r_heartbeat.c
index 6567df638ea93..21c9b6a6f2c36 100644
--- a/drivers/misc/ibmasm/r_heartbeat.c
+++ b/drivers/misc/ibmasm/r_heartbeat.c
@@ -39,7 +39,7 @@ void ibmasm_init_reverse_heartbeat(struct service_processor *sp, struct reverse_
 	rhb->stopped = 0;
 }
 
-/**
+/*
  * start_reverse_heartbeat
  * Loop forever, sending a reverse heartbeat dot command to the service
  * processor, then sleeping. The loop comes to an end if the service
-- 
2.25.1

