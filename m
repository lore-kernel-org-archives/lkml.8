Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7364C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:08:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9573220658
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnfiJQjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgCZTI3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:08:29 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37480 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgCZTI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:08:26 -0400
Received: by mail-ot1-f67.google.com with SMTP id g23so7131924otq.4;
        Thu, 26 Mar 2020 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dl6TS6QBvWF3TrGsODa6YxrD+hVpbT53C2smrTPgLT4=;
        b=HnfiJQjThJ5iKDAcy6e28H2bTWz3h+7ukb3iastcuVo6tsxFDsufGRswRjEd3/p4nP
         h4kgQ3p+8D5rEY0iX23Unfqyk9+3cMD0mA+4t3vM1tewL7yK0X3EZK3uWNR1QxefKqzR
         vmTnj89BtBQg70aZdXkIbtXiMJYNvXVwjmNPgI7kl3/vjCIbLsuKTZ+IvtAq3WnNPmbH
         aXu5KiyDX3u3R9PyInk/GsKGqRc154RaCR09iyqc+BMb/0v8jRvQEJppjcFkflXmBYPW
         NosMJNxZTKIHrYuJd2e68OCzTxmJxMeIQMCPayWVKvJfOhArgn8y2uFyRy9Jzxxq7h9L
         d6hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dl6TS6QBvWF3TrGsODa6YxrD+hVpbT53C2smrTPgLT4=;
        b=ZSEEdN+cMZPHeIgQ4rjYvF7f2HoN0Y4Z5v6xgKePF5/Wkx7d1wWftImSTMyRHfwfFG
         CUoiH94vU97lvBxCbqEdRUgXCTbcRIjVJdeC4DU4erVVcalt9D+eAP6w8qH6ePm5b4hR
         RmFAc6LvVdfCNwn+6cjvoGd5qZdKX0IBv8TO/s8lwknofBvX7hUFzl8JWkeyBpEI5T1x
         hQSvN1e3MluGZQq7v24X/LeY7QauLcIrCbAtJQHe6YwNm4sflIzsA88BgH8hY9LoaUup
         GSQpSrNeFeBJ+jeFVhhwFNzD06iwBCZK5Q21GNlxqHilMLBSgekB5TJVHur87zIOjJTO
         +v0A==
X-Gm-Message-State: ANhLgQ0AIOCoa1CPC/11HBJrE2RP9f6WD3dmq8k1eYoY7/brF2RBoVux
        s0JlCDAuYSKJV7Vh8ufQ+k0=
X-Google-Smtp-Source: ADFU+vtYZRmmt0In5RYpSvpVD083+w/cBX+H9dJu7UD4BodQKsSWRXJ0hd/9OtAdrf3Eq2lmTqUtHg==
X-Received: by 2002:a4a:3bd7:: with SMTP id s206mr6363529oos.89.1585249705771;
        Thu, 26 Mar 2020 12:08:25 -0700 (PDT)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 76sm823838otg.68.2020.03.26.12.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 12:08:25 -0700 (PDT)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Julian Wiedmann <jwi@linux.ibm.com>,
        Ursula Braun <ubraun@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH -next v2] s390/ism: Remove PM support
Date:   Thu, 26 Mar 2020 12:07:44 -0700
Message-Id: <20200326190741.24687-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200326190549.24565-1-natechancellor@gmail.com>
References: <20200326190549.24565-1-natechancellor@gmail.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

drivers/s390/net/ism_drv.c:570:12: warning: unused function
'ism_suspend' [-Wunused-function]
static int ism_suspend(struct device *dev)
           ^
drivers/s390/net/ism_drv.c:578:12: warning: unused function 'ism_resume'
[-Wunused-function]
static int ism_resume(struct device *dev)
           ^
2 warnings generated.

When CONFIG_PM is unset, SIMPLE_DEV_PM_OPS does not use the suspend or
resume functions. Power management was recently ripped out of s390 so
CONFIG_PM will never be set and these functions will always be unused.

Remove them so that there is no more warning.

Link: https://github.com/ClangBuiltLinux/linux/issues/950
Fixes: 394216275c7d ("s390: remove broken hibernate / power management support")
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

v1 -> v2:

* Fix issue link in commit message...

 drivers/s390/net/ism_drv.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index 4fc2056bd227..c75112ee7b97 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -567,31 +567,11 @@ static void ism_remove(struct pci_dev *pdev)
 	kfree(ism);
 }
 
-static int ism_suspend(struct device *dev)
-{
-	struct ism_dev *ism = dev_get_drvdata(dev);
-
-	ism_dev_exit(ism);
-	return 0;
-}
-
-static int ism_resume(struct device *dev)
-{
-	struct ism_dev *ism = dev_get_drvdata(dev);
-
-	return ism_dev_init(ism);
-}
-
-static SIMPLE_DEV_PM_OPS(ism_pm_ops, ism_suspend, ism_resume);
-
 static struct pci_driver ism_driver = {
 	.name	  = DRV_NAME,
 	.id_table = ism_device_table,
 	.probe	  = ism_probe,
 	.remove	  = ism_remove,
-	.driver	  = {
-		.pm = &ism_pm_ops,
-	},
 };
 
 static int __init ism_init(void)
-- 
2.26.0

