Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B93C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A33E72070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 05:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE9WJfjB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726156AbgDZFOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 01:14:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgDZFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 01:14:19 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51711C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 22:14:19 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h69so6930201pgc.8
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 22:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=12uxQMnj/xorOVraxIuxKqG0ikLSCSe0tDZ4Q3keD2Y=;
        b=dE9WJfjBPyyDWJb/hdWWXcl709aUr7YKYSL9exsJDNeZhfMyW63hnNZVUtokUEaScb
         4djzY4EXjwhz7PPxDU83fWj7zTCc8KVgsdtSJotqgH4fKo76uf2v+40MN7O2+7v0j7yo
         qIx4W2283eDCBMg1TQA4vp1n2f36NfuLdY3qSkur0bgukSEgB08/QEIcIiOlCu/a0Y2v
         yjb9k1lnLADrWG7wDHQKriywK9YYWuY5usr3rXCmxWeSn+0Xz1alvXXTonKjOksea3k4
         HcmXaMqnAbocB7kZtzBRf1nNhlJi4K6vNG6mIoVbI4KjGr5TgNQQuV9C/eEBzSCB0Yd0
         Qqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=12uxQMnj/xorOVraxIuxKqG0ikLSCSe0tDZ4Q3keD2Y=;
        b=RxjPbfIFXJuFLq6uTsABpSomjFf8o12DxZ7069nfJEUi5qf5H81vpKUiYtgpvH83L6
         EpauT/x8t/kJ3oBFghL4ffMfVmx3susHpwuV2fsj44YxgyQfYwVEcEqD+92ItB0MDXNf
         8uGOUpt0luTNj+i7YCoF5pqAA16YNylmggJGJfGNRtj5Zx4Q1jovplcxNcOGawORSv4K
         ZvpVX78EUV4LwOuwr4AsbbiBbwkL5c2GwrovFshX+ihAOsoKifI2hVwjwifZVl1VcZ6d
         IOyAsNbMH7WFKF40rJ1aPUOG+gAFOAPxEU5lA9/ejhPBgkKjh7wHQxYYkg7iD3Qa7CM9
         1PPA==
X-Gm-Message-State: AGi0PuZHtlvxaRFqBf/Fcijy+a/01D9D8t0Za/H58gYYnJF0+nJ2ZqRb
        pUxZcuDorCo7mDdgUnM6gwA=
X-Google-Smtp-Source: APiQypKUAzBp+I5Bsw7YDCJ9vG2flxRk50phihRGt65KIyG/PE5fUwWy54UAjJqZLWauP8Eu6VqMZw==
X-Received: by 2002:aa7:8429:: with SMTP id q9mr17324813pfn.205.1587878058873;
        Sat, 25 Apr 2020 22:14:18 -0700 (PDT)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id q7sm630417pgs.13.2020.04.25.22.14.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Apr 2020 22:14:18 -0700 (PDT)
From:   zhouchuangao <chuangaozhou@gmail.com>
X-Google-Original-From: zhouchuangao <zhouchuangao@xiaomi.com>
To:     gregkh@linuxfoundation.org
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        zhouchuangao <zhouchuangao@xiaomi.com>
Subject: [PATCH] driver/base/soc: Use kobj_to_dev() API
Date:   Sun, 26 Apr 2020 13:13:51 +0800
Message-Id: <1587878031-16591-1-git-send-email-zhouchuangao@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use kobj_to_dev() API instead of container_of().

Signed-off-by: zhouchuangao <zhouchuangao@xiaomi.com>
---
 drivers/base/soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 4af11a4..a5bae55 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -46,7 +46,7 @@ static umode_t soc_attribute_mode(struct kobject *kobj,
 				struct attribute *attr,
 				int index)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct soc_device *soc_dev = container_of(dev, struct soc_device, dev);
 
 	if ((attr == &dev_attr_machine.attr)
-- 
2.7.4

