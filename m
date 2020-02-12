Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A68C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB2C720714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=monstr-eu.20150623.gappssmtp.com header.i=@monstr-eu.20150623.gappssmtp.com header.b="0YLaUSPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbgBLI6m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:58:42 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36169 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgBLI6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:58:17 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so1225880wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 00:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BTHaz5A4SC+OE/B+HYkWcFMMrrKRsAAfwl9I0dHXQig=;
        b=0YLaUSPEev7kaxHsythr6FiLAS95ainxwjb0zEqEk7WFYfBIy45dlNcbLPjk8ISI84
         5Mn5rShSknxIeDyAEQk4eBWlPx/OJDTAsDy4sR2A+IQDyICSXXBS57oFNm4oKhv1ea7Y
         xQiFsk2fJE1LwowkzpkmlSUWphUrBG//YQvChPKLrr5+7cqk1E6dj3ErS90ANm5Ag6QP
         kBF0wJgqzEN8C5z1Apku0m+2B+8rYT33ujkm68DifEq67dpmt+8eMUrMViSdu3gOYGKB
         iRkrtfQJclO/S7RUXpT07FlJoGwb4XyqnnOlojfnGiMFRBm1fmS5+Wdn+62VYsZV30pR
         xHug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=BTHaz5A4SC+OE/B+HYkWcFMMrrKRsAAfwl9I0dHXQig=;
        b=JsfduT+ctn2Hh7K1qpHnywD6A9MQN9E/HqZQ1I4BRC73OAZyXsdLczaIDiZBJIcNY8
         ETCt2j3qQ6AUm0Z+9/1N+KniE0f62vS9pv3S7wsBg9K4rqQsQ3vy2lil060OVSo/kXzf
         Z+VEcUy5Ahl0GCmtdt6At1XjnI3Lhe1O34ib+QDphkbcAavkrOdP5lesbZ001rx31dPV
         TX1vsgkLYqFSMGPbKigmLOaS/h02PD43BosQrE3du8kkc3wYjO3OH4aQFmkU8ev+6Qic
         SIX0rjMdKACxFbvKs9Ch8YFAvDDyYNGV7mjjBAUdPrrINBbaw6s3zyB7D6785ZYMkk8D
         v7zg==
X-Gm-Message-State: APjAAAXoCeLEHVnk3Bk6URu0KcpCxjGQ1cDhduKUT9HvM6MnE+k9ZF4Y
        QdmuNe2Xqvcbu9RXBXWNs3fFF3DJo/hEdw==
X-Google-Smtp-Source: APXvYqwP033Pm/oULStN0JuRd5+bgJdBfmjtr1fO9ZnhNDC5V9wvDdn1xk9WGKVppIQ4ZkL4YXtczg==
X-Received: by 2002:a1c:9d08:: with SMTP id g8mr10969356wme.141.1581497894599;
        Wed, 12 Feb 2020 00:58:14 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id t131sm7929579wmb.13.2020.02.12.00.58.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Feb 2020 00:58:14 -0800 (PST)
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, arnd@arndb.de
Cc:     Stefan Asserhall <stefan.asserhall@xilinx.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH 03/10] microblaze: Remove early printk setup
Date:   Wed, 12 Feb 2020 09:58:00 +0100
Message-Id: <af15f3f69b877bb547ffbf5df8454f749692939f.1581497860.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <cover.1581497860.git.michal.simek@xilinx.com>
References: <cover.1581497860.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Early printk has been removed already that's why this setting doesn't make
any sense. Also change printk level from pr_info to pr_err.

Fixes: 96f0e6fcc9ad ("microblaze: remove redundant early_printk support")
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
---

 arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c b/arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c
index a32daec96c12..c7ee51b0900e 100644
--- a/arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c
+++ b/arch/microblaze/kernel/cpu/cpuinfo-pvr-full.c
@@ -22,13 +22,8 @@
 
 #define CI(c, p) { ci->c = PVR_##p(pvr); }
 
-#if defined(CONFIG_EARLY_PRINTK) && defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 #define err_printk(x) \
-	early_printk("ERROR: Microblaze " x "-different for PVR and DTS\n");
-#else
-#define err_printk(x) \
-	pr_info("ERROR: Microblaze " x "-different for PVR and DTS\n");
-#endif
+	pr_err("ERROR: Microblaze " x "-different for PVR and DTS\n");
 
 void set_cpuinfo_pvr_full(struct cpuinfo *ci, struct device_node *cpu)
 {
-- 
2.25.0

