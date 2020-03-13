Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8479EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FCD206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQ6RGERd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726692AbgCMRTQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:19:16 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40178 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbgCMRTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:19:15 -0400
Received: by mail-pl1-f193.google.com with SMTP id h11so4551991plk.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 10:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbvuozHk8y+q351yVVn9ofgID8rZuIssOUzCjloZS0A=;
        b=EQ6RGERdLF5OZVju2pIkk4ygbpP/d73Uu4SPD0qS/ccY5sI64yybbPTkCIxSSfIHSG
         UWWUwmAVCWMzS4Wsyutj115Ox1cKDU9ZSfOP8ST1IseYcANIYIj9omxYml6vNEi21zoE
         LVT3OncX94RqmGTIBOdAUaAEoELUQ1FTC/y09nj4cO2jNOXhPw8gBUoNZPCNggQgUeAv
         RI30IRlXy/zC3ZAmFdzBgT28uvRWnm30MaXm+ugkSr2o95BeGHXjlf8fqeiQW54uTavQ
         aU8GDrqtnRGa87ERPtf0SA18VIslNEvK6rwnpkmafMFt4Q/BtXzJM5O3GbDE/BFJNoa+
         S22w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jbvuozHk8y+q351yVVn9ofgID8rZuIssOUzCjloZS0A=;
        b=ju4e9A7LhbaWoFmv016x1nsp3oIfOIvgWCXCcok/JvK5Dah7sZUz2NcBzjUwvNP6Qp
         ScKi8o1A6CpIb5s1zVzffYJxmlRguSCm2n82ECsyllPDVvmMIKRYro41EHUaBoo+dhS/
         hgLZO2aDEWFtwajX8iC9HLdrKqIP+mAyKti7GITUZtwAIU7IHZb4p3GJXa0oKBlr6y2o
         D0feFW9hAv/+5KLetMaA5xIWjngbKZcE9wG7Yil/B6SIvx7JyYFzFYwadduIes8Cs66g
         u4cFuyDCFAxagv22BYqCDZHykxsAwYAIpfZVWxsTt2w8Xa9zY1fRJny6B6cNThXi4e3v
         GPdg==
X-Gm-Message-State: ANhLgQ2/QntYSbd+4AoWHtTZRaEu8yQB4zaaq5WlR1siycglNtmVpTZD
        rlnVQKBuTy2IfanZ0AYQkYE=
X-Google-Smtp-Source: ADFU+vsmkG9qXVwn38qeUW8n7zOocOM6ctyp+7tOtFbtqPtmPKI0vdolNwFBU//RmuRw/ey6pw7oWA==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr11049937pjc.41.1584119954866;
        Fri, 13 Mar 2020 10:19:14 -0700 (PDT)
Received: from localhost ([216.24.188.11])
        by smtp.gmail.com with ESMTPSA id g6sm9196327pjv.13.2020.03.13.10.19.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Mar 2020 10:19:14 -0700 (PDT)
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Dejin Zheng <zhengdejin5@gmail.com>
Subject: [PATCH] drivers: provide devm_platform_ioremap_and_get_resource()
Date:   Sat, 14 Mar 2020 01:19:02 +0800
Message-Id: <20200313171902.31836-1-zhengdejin5@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit "drivers: provide devm_platform_ioremap_resource()",
It was wrap platform_get_resource() and devm_ioremap_resource() as
single helper devm_platform_ioremap_resource(). but now, many drivers
still used platform_get_resource() and devm_ioremap_resource()
together in the kernel tree. The reason can not be replaced is they
still need use the resource variables obtained by platform_get_resource().
so provide this helper.

Signed-off-by: Dejin Zheng <zhengdejin5@gmail.com>
---
 drivers/base/platform.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 7fa654f1288b..b3e2409effae 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -62,6 +62,24 @@ struct resource *platform_get_resource(struct platform_device *dev,
 EXPORT_SYMBOL_GPL(platform_get_resource);
 
 #ifdef CONFIG_HAS_IOMEM
+/**
+ * devm_platform_ioremap_and_get_resource - call devm_ioremap_resource() for a
+ *					    platform device and get resource
+ *
+ * @pdev: platform device to use both for memory resource lookup as well as
+ *        resource management
+ * @index: resource index
+ * @res: get the resource
+ */
+void __iomem *
+devm_platform_ioremap_and_get_resource(struct platform_device *pdev,
+				unsigned int index, struct resource **res)
+{
+	*res = platform_get_resource(pdev, IORESOURCE_MEM, index);
+	return devm_ioremap_resource(&pdev->dev, *res);
+}
+EXPORT_SYMBOL_GPL(devm_platform_ioremap_and_get_resource);
+
 /**
  * devm_platform_ioremap_resource - call devm_ioremap_resource() for a platform
  *				    device
-- 
2.25.0

