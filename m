Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8393C2D0FA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 900DD20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 00:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YJ3SZjp/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731702AbgEMAef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 20:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgEMAef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 20:34:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF0BC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:34:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v5so8019407lfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 17:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3b7cXzUOwV7k5MdxilVeud6NPCnUSm8k2Dup6VE1hOo=;
        b=YJ3SZjp/PvbbbZvzZyzfmQsW9Y53kPUVFsP5VkvI0THSYWlfoRjUF59amVO5tKSmel
         Yv+MtcelqebcIlruvQeBFzA2HDinVU/4d79Ii8Is47Wv8anNXrGeDvWjMoplIQMSLy8C
         rt5P70fnQk378GfTjGjRsKDUu0Zzp7qBrovdjPwXsjY4Dog0hOkErTm9kPHY6/dx/01m
         0MTuMnFtygm8tX5Jb/oeAiRuSaG+R5kfUotEK17HQTxBnRU+cQrcjfXhPdLvkBnS5Wth
         Di0JX9Z08s7ufZcM3FPwn/dTJiYy/uqdiWDaPNWseSqHbhdFQdfC94W0p6Gejq8Z+v9G
         pPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3b7cXzUOwV7k5MdxilVeud6NPCnUSm8k2Dup6VE1hOo=;
        b=QwPyAA7v/xgFotpX/AH71ND4WBuEfnKM+zA+MRwcu4Utwzf5VFf9J84mKH82qXf4k3
         Enq95MEVp0Y1gt2wkhoCLNZtt8GC6OTM6qKG6sj66i9uVt4aeI9+OQHXupIVcb6p+UHu
         bZxzakGrc4lg0BREE/DMcAsVzxPi99dwEgyLeDOxGRJSgbMEojKgu0qgD8Wnb4dSndOp
         ofVapMG/Aeb0mw2z9+M7O2zOeL6NWodn4wqEnnr6UzHXkTFgqeSe0JknSFz7vQPTzqR8
         HbRwLfNn21+EDLdZ8eujWkU7KkseFyq6HnVFOH2CN4SKjZqYHrLozBUM6taFBmyXR4Gk
         6RXQ==
X-Gm-Message-State: AOAM5308tpqqbcnl8teYKxH4a7Vs7n/vj7oJh1SRszNE+Anos+bArquo
        NnLyKiYo+a8qYSOXHd4BcGmVQQWb
X-Google-Smtp-Source: ABdhPJx6fMH74TmzZ/dPug4lF0fyW5Ga7e+ziUlKnjEgcHjlByOwdCuwMKN4EiskW04000ogezEzmw==
X-Received: by 2002:ac2:5f73:: with SMTP id c19mr15949805lfc.135.1589330073465;
        Tue, 12 May 2020 17:34:33 -0700 (PDT)
Received: from EPUAKYIW2556.kyiv.epam.com (ll-74.141.223.85.sovam.net.ua. [85.223.141.74])
        by smtp.gmail.com with ESMTPSA id s7sm14236871ljm.58.2020.05.12.17.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 17:34:32 -0700 (PDT)
From:   Volodymyr Babchuk <vlad.babchuk@gmail.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Cc:     Volodymyr Babchuk <vlad.babchuk@gmail.com>,
        Volodymyr Babchuk <vlad.babcuk@gmail.com>
Subject: [PATCH] optee: don't fail on unsuccessful device enumeration
Date:   Wed, 13 May 2020 03:34:30 +0300
Message-Id: <20200513003430.651232-1-vlad.babchuk@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

optee_enumerate_devices() can fail for multiple of reasons. For
example, I encountered issue when Xen OP-TEE mediator NACKed
PTA_CMD_GET_DEVICES call. This should not result in driver
initialization error because this is an optional feature.

Thus, it is better to print warning, instead of termination driver
initialization.

Signed-off-by: Volodymyr Babchuk <vlad.babcuk@gmail.com>
---
 drivers/tee/optee/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
index 34409c916882..a053930032f2 100644
--- a/drivers/tee/optee/core.c
+++ b/drivers/tee/optee/core.c
@@ -728,10 +728,8 @@ static int __init optee_driver_init(void)
 		return PTR_ERR(optee);
 
 	rc = optee_enumerate_devices();
-	if (rc) {
-		optee_remove(optee);
-		return rc;
-	}
+	if (rc)
+		pr_warn("can't enumerate optee devices: %d\n", rc);
 
 	pr_info("initialized driver\n");
 
-- 
2.26.2

