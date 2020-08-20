Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC15C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B11F122B3F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 23:31:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgrTuR+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgHTXb2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 19:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgHTXbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 19:31:24 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BABC061385;
        Thu, 20 Aug 2020 16:31:24 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so22642plk.13;
        Thu, 20 Aug 2020 16:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=a01gZFrrhASVB9tqjIfzMvLjyL0nIzhC/aFyYzXQbCA=;
        b=kgrTuR+JKFYitMZQ1XluiCdLpkdKqQPQdqR0xyH6B2zpRN9wJmd1dSDXDm+K9xQY6I
         Fb+wXh8wAA+rKyO6EjjJ/kXe1SjtPB9R/q6F0oFKz6RhVL1TB6kzdJhgHoOE7JlrICrg
         rEQBPgEdtOzm1+F55P0AO+dpRl1G382iEoEG6MjJCw89Cw2ZF2AHj5gU6G43CsJKWoht
         aU59gMN+ZuBoKPtSBjYolZJwgukCYXx5QN0gUGzcy028O2HJ5nHSk87+YLuWc1QA0zUK
         xmb8n6JNXFyOB9ver1LkksOzrr8Eg8cHAMXbsZaTViJF7c2jcLGtkdmLzPWD8ZNsMIkY
         dxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=a01gZFrrhASVB9tqjIfzMvLjyL0nIzhC/aFyYzXQbCA=;
        b=W27eAxSfQe1rx4pPmwaqkGvnltrKGQWkTFl5fIcygAwVqFFSYDdUQpA5ZWJ4YDI8Cq
         jr7FfqvexjHff60oja06/oZSqNp9RKKgdJnYZHzNIcj2eJ+/aC2Ngz9zoy+kepaNdOMU
         aFNNl/r3TeFW45o7b5v2AB4CzY4usiETWW9VwyLb5jd1w0LfOaFNlBO+pVFOxuxvsSCs
         8PwAtRexKQMiG8X9FDUImdmJhq9KOPWTcAthne5Sey/3tM5Qg77Y0Sg8DECfDDh7QFKd
         o7cTbGeBmlheEgzWlsZ+Ily1MG5kVTfgR2MbQa/ElKaKASO3UoaFa+Edbv0+x9CMiYy8
         fEsg==
X-Gm-Message-State: AOAM530KISe9cFFqxv2LwTmG/8kkupXivRlw7SaKRpCkwMxtzAUKMm0A
        raxPtMLBCffKriTXnDbnAR4UO7eaHT0=
X-Google-Smtp-Source: ABdhPJzwNJMsL/Pz3OaZ+PwEpSsgST4M5xXPP+d+HfMcIXE5U62U4TqFh7FYAwI6UnI04ijWk4/sXQ==
X-Received: by 2002:a17:90a:6881:: with SMTP id a1mr213133pjd.208.1597966283255;
        Thu, 20 Aug 2020 16:31:23 -0700 (PDT)
Received: from stbirv-lnx-3.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q207sm122399pgq.71.2020.08.20.16.31.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 16:31:22 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Pantelis Antoniou <panto@antoniou-consulting.com>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE)
Subject: [PATCH] of: Export of_node_ktype for modular use of of_init_node
Date:   Thu, 20 Aug 2020 16:31:06 -0700
Message-Id: <1597966267-33614-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To permit the use of of_init_node() by kernel modules, we must export
of_node_ktype which is directly referenced by kobject_init() called from
of_init_node() otherwise modules would be getting linking failures.

Fixes: 0829f6d1f69e ("of: device_node kobject lifecycle fixes")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/kobj.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/kobj.c b/drivers/of/kobj.c
index a32e60b024b8..d7bbd156a671 100644
--- a/drivers/of/kobj.c
+++ b/drivers/of/kobj.c
@@ -27,6 +27,7 @@ static void of_node_release(struct kobject *kobj)
 struct kobj_type of_node_ktype = {
 	.release = of_node_release,
 };
+EXPORT_SYMBOL_GPL(of_node_ktype);
 
 static ssize_t of_node_property_read(struct file *filp, struct kobject *kobj,
 				struct bin_attribute *bin_attr, char *buf,
-- 
2.7.4

