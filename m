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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162E6C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690E20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 12:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJ1ZlYHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgDEM0B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 08:26:01 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41884 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgDEM0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 08:26:01 -0400
Received: by mail-pf1-f194.google.com with SMTP id a24so6137253pfc.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 05:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mblZgCC2Cl9506DCpo/VF03PoaE1EG2NCS/yPRhOyVc=;
        b=fJ1ZlYHpiC1YETL+MpOGOhen2lYkAFpSNfdQwn56F/eqWl78ShJ75UG0vPwAkNPc7s
         mc9AJlqmcXOZBeizj1v96RTUf6bBBK7mNOGdrbqJZvLxW5SH6xknxnCA1FANunKiaz36
         bnzCsHHXBoiFUEt/ZyJTf6IOqhGfimvXGwnpCyyLvNVarMYxAbKAaeev+qlmPsCRrRRL
         2zo7VwFeulBDRK4v4iealA/UEJIjAWsrBcXWUhQcOyFQQdOaFNVaTe0l/7MC8sqdbO8E
         QDMtTY7/lXbszNk16igin42MJeruNb2M0xsvix8XEZZpbjpt3e6ENpGtc7g8y09f1KxM
         0Pqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mblZgCC2Cl9506DCpo/VF03PoaE1EG2NCS/yPRhOyVc=;
        b=CgG74dumKqMyP6x7L/suNT9HaUsKZaP4eRixBxnfIAb0D1oPRNYVigahpeyde6Darh
         D0QIT1yL8lXQ4gx6P2gHhGNSimcc867nGntr9zU2MvYsTIjJp1FsB4Mm1BsWtU1WinPm
         +NATIuZzwOe9nWpMwpxCxDrxuYJ/cPB3wFhclBZLJvHerXJkgpwKJXZAMnBPT+koFQ9s
         rTS7/7Jcalb+Bog/N/gs+8wjPLRCTrj//kajkQ9+oB8x6SDvR95gB0t+Xd6YIt8zJWD3
         CblrLH0P1rLa34U82fk9C7fwXiAcSbLzT3aBoqVMAJhe8jVRjUHRxAe430bnbLbPY/FU
         TdFQ==
X-Gm-Message-State: AGi0PuafzjjEK9SJSK4W1pVLlUsWkfb1NG9QOPkioEaKUzlVR/RVnU+E
        limjpbtuKerrBeRO5uTOUk0aA7OV
X-Google-Smtp-Source: APiQypJQUqDjf/IeYoPYu4U+unuDH9yiglYxc4QpmhiuOWuRnx9jcIZm24TtJmxIW1p4es3hQcSQxA==
X-Received: by 2002:a63:7a49:: with SMTP id j9mr16094104pgn.183.1586089560133;
        Sun, 05 Apr 2020 05:26:00 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id n100sm9561716pjc.38.2020.04.05.05.25.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Apr 2020 05:25:59 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        tglx@linutronix.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        christophe.leroy@c-s.fr, Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v3] powerpc/powernv: add NULL check after kzalloc in opal_add_one_export
Date:   Sun,  5 Apr 2020 20:25:54 +0800
Message-Id: <20200405122554.357-1-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here needs a NULL check.

Issue found by coccinelle.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd..908d749bcef5 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -801,16 +801,19 @@ static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
 static int opal_add_one_export(struct kobject *parent, const char *export_name,
 			       struct device_node *np, const char *prop_name)
 {
-	struct bin_attribute *attr = NULL;
-	const char *name = NULL;
+	struct bin_attribute *attr;
+	const char *name;
 	u64 vals[2];
 	int rc;
 
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

