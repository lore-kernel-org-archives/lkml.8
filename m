Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F05CCC2BA19
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B862720675
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 10:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYDVOzYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgDEKbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 06:31:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35750 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgDEKbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 06:31:08 -0400
Received: by mail-pg1-f195.google.com with SMTP id k5so6076595pga.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 03:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qinCPIMlZEhPNHm7wWCE1/v5NXvmFAaiCevaQ476mMU=;
        b=pYDVOzYSqSqQqWF1YQl0SGrQi7oysyqgKEqFg1L80NxFZL0EVvc5cwWXsXK1ZzGPHZ
         75j7uXZHwIb17izPRUR4eoRyK13qJz7Ez+YU6p3ovEO1zGlOAIj4KSaKpjupSGczJ6hJ
         J+RCILQRTNOYyjshk0yrBh8hhup+3xTEuPjxV/wnv5c/z35c3hrD0sHpfBfAUB5L8CoH
         /X07g7Q+vmCoZWxXM/UiKZ+TMFLdZNnjwg2OoBjpb8BkxvRao7+XhdO++wYJ+RqeFLNu
         7cmTLemLnhnCdxemUvSRerr7NrAN6pUy4ljN1TBjq/hYjh5hqilsig6bdjwdhJqJLr0t
         tSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qinCPIMlZEhPNHm7wWCE1/v5NXvmFAaiCevaQ476mMU=;
        b=oBXMtlTjWUtBXGUXwIE/rNryer35SWN/Jcp103ipesrR1EfyK0BC1PrXDWDkZGSDVF
         odxYV7ks/5GGjKtENxbJU2CX1MxWQYeBgaLTF+NmNhO0WOrJ7SlIIcl5WnUgHvE6TRzM
         khl2PTSEev0yRTNoXEvgFyWx1Y1CQaK/dta4iBbHwl0BFH4jf1lvFPocUoX0vTC18CMe
         DQfopSAp7angCFUAsqnzd0kWkivF2+o+tqJWXHfb879HiA4tasurmIFG8m7Ac0HU5SG7
         7oEeE68R4s4RTcbKeBICOoftpZ7lH/MWvJ9D3zrTHXdH5Zb77f7MNb8IuaV5T3WdCiTP
         xFBA==
X-Gm-Message-State: AGi0PuYuRCj3MSJbYSVrReRAQJ+Dja9FZ4w1hLUu2JoyhvLvlNLQGp87
        MPVjnptpD3JfuV+oIMLtlmk=
X-Google-Smtp-Source: APiQypLIbRwWdRFOaNEcVTmtQWuyzBmj0AA6Li8NoxPIsCXuoBUhm/ylTX47OvW1ZhIuYGJnZaSqAQ==
X-Received: by 2002:a63:ee4f:: with SMTP id n15mr654418pgk.149.1586082666760;
        Sun, 05 Apr 2020 03:31:06 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id b2sm9357482pjc.6.2020.04.05.03.31.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 03:31:06 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tglx@linutronix.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v2] powerpc/powernv: add NULL check after kzalloc in opal_add_one_export
Date:   Sun,  5 Apr 2020 18:30:59 +0800
Message-Id: <20200405103059.30769-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here needs a NULL check.

Issue found by coccinelle.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd..5b98c98817aa 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -808,9 +808,12 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
 
 	rc = of_property_read_u64_array(np, prop_name, &vals[0], 2);
 	if (rc)
-		goto out;
+		return rc;
 
 	attr = kzalloc(sizeof(*attr), GFP_KERNEL);
+	if (!attr)
+		return -ENOMEM;
+
 	name = kstrdup(export_name, GFP_KERNEL);
 	if (!name) {
 		rc = -ENOMEM;
-- 
2.17.1

