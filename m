Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8955FC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C9721655
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBClKuiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbgEINsa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgEINs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:48:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FFC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 06:48:28 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id u6so4619025ljl.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 06:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97riR7h5mctZpNCGSCsUzKUdKKhONjRhdoAsaVf8nyw=;
        b=aBClKuiBIJWNgNo6gaPKpc6o8Bx2D2tB1J4jkUiu91comKnJCm77qMPje6ENn0inC7
         6q/P3ambDpvAHWkzRBxKtcy79WwPgS5TRjDdfsMoAfXlKRR7hPwn8M78VW2yg+FdwZSo
         7wn9gyzcJN/ewxvhBC9cq/JwxQSeLTAbLCpWJRm6Dw50kqa39v/wjQkqT38YW8Zv2Q3R
         CpvIV4tJEGnGc50ZCCTEfVJ+g8LVtNF4TbzWBsv1P8848fFZsPBp2RSsCuoOomZ42NgY
         7jrHoG6JbxAgk0QiB+kFGs0XNvQB9AgMDbIfNr7PGv34g2nncRK1e5kYDyfGr6Cx/7mj
         3P4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=97riR7h5mctZpNCGSCsUzKUdKKhONjRhdoAsaVf8nyw=;
        b=YtDWCEi+0lgfqQMsdJM1QYWc27zswprDuqup89crNapYXial9hulJfAwU2l7+HaAaF
         SEpHehLxLYBfSSFlhZs6Xi+j2SThVkTApZRiVhjLXKGNASrcyJkbMYnPg+3xhLWeT9v7
         yzW3TiqYIGFI/7rY2PiEi/1aG7eA5sQEwjh5gUChukLLDJ5YxyEUIGXhyLwTeTeQC39F
         2GrN8/sw3p1QTAxcB73os55gG8p3iyEW1mOOm0pjeTPAgdkXeGg++my61dqvI7JLiRpR
         ewjJ1MT4DIIYGNuwY4RgZZXz8MqQb6qqsnh1s7oUTwOJSvK6VkMNhCZPWrx3L1EQs4Cl
         AV8A==
X-Gm-Message-State: AOAM5334qaIH6YuXsRIfA+J6HIkBxp6o59GEflWNp4e+NMkz16DOwxfQ
        UBiy6t4Qt+T4ZBV/xm/Bs+g=
X-Google-Smtp-Source: ABdhPJxpQ/5qZk8wrc4rdW4hRVVzSjbl+JycdDYBicx5ny4EL+DgCn8XoLsyjaFo973ka6XmUYd3Rw==
X-Received: by 2002:a2e:2a82:: with SMTP id q124mr4991852ljq.155.1589032106552;
        Sat, 09 May 2020 06:48:26 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-22.NA.cust.bahnhof.se. [158.174.22.22])
        by smtp.gmail.com with ESMTPSA id a24sm3928093ljk.10.2020.05.09.06.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 06:48:25 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     boris.ostrovsky@oracle.com, jgross@suse.com, sstabellini@kernel.org
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] xen-platform: Constify dev_pm_ops
Date:   Sat,  9 May 2020 15:47:55 +0200
Message-Id: <20200509134755.15038-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_ops is never modified, so mark it const to allow the compiler to
put it in read-only memory.

Before:
   text    data     bss     dec     hex filename
   2457    1668     256    4381    111d drivers/xen/platform-pci.o

After:
   text    data     bss     dec     hex filename
   2681    1444     256    4381    111d drivers/xen/platform-pci.o

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/xen/platform-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/platform-pci.c b/drivers/xen/platform-pci.c
index 59e85e408c23..dd911e1ff782 100644
--- a/drivers/xen/platform-pci.c
+++ b/drivers/xen/platform-pci.c
@@ -168,7 +168,7 @@ static const struct pci_device_id platform_pci_tbl[] = {
 	{0,}
 };
 
-static struct dev_pm_ops platform_pm_ops = {
+static const struct dev_pm_ops platform_pm_ops = {
 	.resume_noirq =   platform_pci_resume,
 };
 
-- 
2.26.2

