Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F17AC433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F168A20691
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pc3OXUSR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgGRAGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbgGRAGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:06:48 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7201CC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:48 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m81so13320228ybf.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 17:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9lliIP397BkHUMIYOIiz1lmKlM09rTtKqti3dJZq5NI=;
        b=Pc3OXUSRMtC51Xe5/XMfqVgGHTzqEztWThvDswR20yBvK4q20Xw3ZNE+8dkR19OmDD
         gDksFj5HOd268anWSSimT3Gn9d+v7SfcYJjjCEJY6k3KED8/Qg0cUFL25Q3MLk3u6WzP
         6SQOsdECq3m8nfn4B/G+qcw93FKsucGX6KBj42CnWiZKaOz2sMFI1iIBqIg8B/YnRj6U
         VozP0QbaLKiXIdIxryY+7xaJJEGEd8+z9ZmQZXSjBMWae0vTANsynMnqxGRMmmAY2Nz7
         y01D9HdzUEov/4to4JpMNjFHQb5ZWpIPNEGfCjmvUCtCL/gSUXe19cgBOBtkE/HRrupU
         dKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9lliIP397BkHUMIYOIiz1lmKlM09rTtKqti3dJZq5NI=;
        b=FEuTXODZhIzUSknPHKnof2JxAMlMyfWBKV8tFiBkDLo8PdSVP8nyeWiJch5YKJgvtt
         KPAUD886at+abnIMw0rDJKv77Hmf374EothyutDsDCvhe3ZxwRc5pL5HvIvCSIkQ++EO
         ap5sIgu+xkGxq5vU2lqosAuVwrRoLK0PQjZWntkiNMBxA9dZpb3q36in/zmB0gXMwwN8
         YSLNi//UMlO8Cb94EPaW5JOeuT4OdDmad22xjXsJbd0FVDvf5bhB3u1+vyY7I6KzzSH2
         85ogCbKdEXgBIqtU2y465UNr67TH9DgbB3y8uX9yWGC/tvupCCG1/9HeDMGknsijy+UY
         UvBA==
X-Gm-Message-State: AOAM531nR4kmi0BaayLJD2q52zWEAomhiGYyYzWqG5clxNo59gDo/Lxy
        XuHH1t7VF+b4sRm0mkyeTDLBHtYaLunNvLc=
X-Google-Smtp-Source: ABdhPJzaoGGT2QOhK85hcWY30M8zasDny3EJDQN0UI4RBnyRl5EEGtO+6Y9IPCYksqge9OpTXg7V9ykOWjui2KA=
X-Received: by 2002:a25:abc5:: with SMTP id v63mr17904281ybi.148.1595030807668;
 Fri, 17 Jul 2020 17:06:47 -0700 (PDT)
Date:   Fri, 17 Jul 2020 17:06:36 -0700
In-Reply-To: <20200718000637.3632841-1-saravanak@google.com>
Message-Id: <20200718000637.3632841-4-saravanak@google.com>
Mime-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 3/4] irqchip/mtk-sysirq: Convert to a platform driver
From:   Saravana Kannan <saravanak@google.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver can work as a platform driver. So covert it to a platform
driver.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/irqchip/irq-mtk-sysirq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mtk-sysirq.c b/drivers/irqchip/irq-mtk-sysirq.c
index 6ff98b87e5c0..7299c5ab4d10 100644
--- a/drivers/irqchip/irq-mtk-sysirq.c
+++ b/drivers/irqchip/irq-mtk-sysirq.c
@@ -231,4 +231,6 @@ static int __init mtk_sysirq_of_init(struct device_node *node,
 	kfree(chip_data);
 	return ret;
 }
-IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", mtk_sysirq_of_init);
+IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
+IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
+IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
-- 
2.28.0.rc0.105.gf9edc3c819-goog

