Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC12C4724C
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 03:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96D3020643
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 03:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RxJsTXbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgEBDLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 23:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbgEBDLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 23:11:52 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAD46C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 20:11:50 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z17so4182006oto.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 20:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRgN7dqYpnfJ32iv0mEp+A1meuKHRpjuIr6fo6bZQDI=;
        b=RxJsTXbup9QlEvWS3tzliDOKUX4V8Ve9nGRFJT1tPzsN41ZaP28hHRRjaQmVMXYH4X
         jxts4KMj4xPuN0zLE+MUuwbxdM6n4rfUiJea6QlzNwcT5eJJQJclqPnYZbAM/QvpGcsR
         GxXMEB+FoAwX7zEcUWqYGmcYoGW10XFa9/FwFp7y9pF7D/Q5qN362YPRXDPgtyLgisqZ
         kzGuKyegQx5QjgazWys8w7f6+/aSLhn5Bp01HY+CiRPNiKZ2vp6+JaBOyJ3OVjRY39PW
         SGq2AzacvGQsBFLshM9JVauz2hcankfK0kJmBIJcB6CgNRNYP6pEqmmtpSr/XZ+jvudK
         Cv+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TRgN7dqYpnfJ32iv0mEp+A1meuKHRpjuIr6fo6bZQDI=;
        b=bDhqMDghk0b1ioflLvZmykYgx3IgZa6Ydi8RhTsRtdch4Hn47zigElhdMDO0Z9ggc5
         ep7WRlNe5pfIeQx0G9AN09T0Qb6Sk1oliHbpMQyIO2ovbaQ2Ed73F7xihxTwBiXPo0pe
         QeN3kY/cn+BOaCthRc8Su+uGCqBC5myfqed6ce9h9/uBz9TMIY+Ids8czh3ZQdihFIdD
         F9q7lMt0ocDvf7olGJo4ojdLACrOS7IOEAdHN2tUZW1Anz/4mnzXxIVsVh7EoOyvKF2Y
         2xl3Paqry2xPk2mhFxQHpS3+ZD+RwqmNg1uVU93GF4WMdJuy2rmzXa49d0wNSGwU834r
         XAMA==
X-Gm-Message-State: AGi0Puayaq5Cobpih5HAmtfiq+tvIsn14PGnthLFIe/TYrH66h+3b0B7
        /DIuhKS4kK10LoQE0wtDDts=
X-Google-Smtp-Source: APiQypKZcYdkpeLuzk63sx5uVK3c25pfnOfguhe3seCLZhWjtHD4C6Zuh/aw67LW6ih2Vhcg2sVuWw==
X-Received: by 2002:a9d:57cb:: with SMTP id q11mr6060158oti.11.1588389110029;
        Fri, 01 May 2020 20:11:50 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id l6sm1317704otq.48.2020.05.01.20.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 20:11:49 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdgpu: Avoid integer overflow in amdgpu_device_suspend_display_audio
Date:   Fri,  1 May 2020 20:11:41 -0700
Message-Id: <20200502031141.2732221-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang:

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4160:53: warning: overflow in
expression; result is -294967296 with type 'long' [-Winteger-overflow]
                expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
                                                                  ^
1 warning generated.

Multiplication happens first due to order of operations and both
NSEC_PER_SEC and 4 are long literals so the expression overflows. To
avoid this, make 4 an unsigned long long literal, which matches the
type of expires (u64).

Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state before gpu reset V3")
Link: https://github.com/ClangBuiltLinux/linux/issues/1017
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 6f93af972b0a..caa38e7d502e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4157,7 +4157,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 		 * the audio controller default autosuspend delay setting.
 		 * 4S used here is guaranteed to cover that.
 		 */
-		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
+		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4ULL;
 
 	while (!pm_runtime_status_suspended(&(p->dev))) {
 		if (!pm_runtime_suspend(&(p->dev)))

base-commit: fb9d670f57e3f6478602328bbbf71138be06ca4f
-- 
2.26.2

