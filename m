Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE98C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4274720658
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 17:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vb7hJxbw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727688AbgCWRD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 13:03:28 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:51375 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCWRD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 13:03:27 -0400
Received: by mail-pj1-f67.google.com with SMTP id hg10so111662pjb.1;
        Mon, 23 Mar 2020 10:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r44Yp9/fYImLy99hsOf6+RWpCmYIpfxp429+aFH1H4A=;
        b=vb7hJxbw4mlMzCJAwOKjdYjz+0OjfSGZPZRHTTkhj9ot5JSGvJ6s6qFhsb9HUsdWPp
         Cx8y+0L/GwYe9bMNfVP3RmCAf4u57XY42Sh4UzhPR4sMRqzIFowPyNtgiBn0ITUmw9i1
         8o0XNz3ARd5TJdbXfj81ynKOTLb1vR+NJ+jAvlG16lndyo63NAOBA6TLkYj+i5xvCLMA
         KtS6G7NnXIhNRpS7YE7TUVFULJPZ4xKe+oAGhVkQb4b5x27qHJA1drXX8XzLa0fd9OnK
         NR3mkGMAnuYtJRN3b2HMD9IcOSw0gxP85rxFRqxhKsvU9WcxZtlob4aJ8ZVjNQ8B/3hj
         d9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r44Yp9/fYImLy99hsOf6+RWpCmYIpfxp429+aFH1H4A=;
        b=AhgQgqxKOIfaAx7AiLD0GyyKq4SwESlLYeZOUiLIFwzKb/Zgm0YRxA/Eca71GxoCAh
         rODAeBaqv1kftD5g7PN/WFtE0BFX7eIi87R8LJiF/3uAeHSvfOcgTGYbuyqV90PHX5cr
         lgysdjsaAkRvCEZy+k2oidsJWeMOxsUA5iHUMBx6JztHF3VCxny/0AewtTIkeUDHtOai
         X8x3zIlQ5Shs7jPOb5O4tLFL3il7gPh1mLaI8mM2kCzPjGOX9O3m/MQGoCoCwwL3V35c
         Huw7OXNq2fFjUaR6wYtkWQbwBlkslblTEW89L7fvtTjfZIMTCStP/uCegjIMlvE9oMCp
         Lflw==
X-Gm-Message-State: ANhLgQ1LwGoRzZS+ngt20k/PT3k3n/yrGxrTn3GmOzFMfHe7lHRE7dV0
        XstgvqejJ4hGJUu7tNoPAdeh+wGL26Q=
X-Google-Smtp-Source: ADFU+vtaZLPu8EuPuVwIfwduBGMWSxG6ryhdS9R7LgDLAg8ZldY1Kx+vIc3HdobmpSjWqQEbDQVu/A==
X-Received: by 2002:a17:90a:252b:: with SMTP id j40mr266848pje.189.1584983006597;
        Mon, 23 Mar 2020 10:03:26 -0700 (PDT)
Received: from VM_0_35_centos.localdomain ([150.109.62.251])
        by smtp.gmail.com with ESMTPSA id o65sm7386680pfg.187.2020.03.23.10.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Mar 2020 10:03:26 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH RESEND -next] rtc: remove set but not used variable 'np'
Date:   Tue, 24 Mar 2020 01:03:18 +0800
Message-Id: <1584982998-1341-1-git-send-email-hqjagain@gmail.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/rtc/rtc-fsl-ftm-alarm.c: In function ‘ftm_rtc_probe’:
drivers/rtc/rtc-fsl-ftm-alarm.c:246:22: warning: unused variable ‘np’ [-Wunused-variable]
	struct device_node *np = pdev->dev.of_node;

commit cd49b579e705 ("rtc: fsl-ftm-alarm: enable acpi support")
involved this unused variable, remove it.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 drivers/rtc/rtc-fsl-ftm-alarm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/rtc/rtc-fsl-ftm-alarm.c b/drivers/rtc/rtc-fsl-ftm-alarm.c
index c572044..0f4142b 100644
--- a/drivers/rtc/rtc-fsl-ftm-alarm.c
+++ b/drivers/rtc/rtc-fsl-ftm-alarm.c
@@ -243,7 +243,6 @@ static int ftm_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alm)
 
 static int ftm_rtc_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	int irq;
 	int ret;
 	struct ftm_rtc *rtc;
-- 
1.8.3.1

