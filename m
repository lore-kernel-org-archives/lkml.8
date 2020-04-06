Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC7C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C08D221F7
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ug5cN9ID"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgDFMw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:52:57 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45924 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728077AbgDFMw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:52:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id r14so7454172pfl.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 05:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cHpVfF2u9C4oNMESIKL8KGjVklpXtV8TmmsyFDre/+I=;
        b=ug5cN9IDnfElN3u13WhUXXW8BuloW0AB9iJNPo4ymQymQVjipNKcrpcc2HsAe6aeSe
         0FrcA1SsnBub/9y7wMTz51oGViMOfUEAMWOmfxoRdb30arSAnaHHur4rAvTp0S4/2R9Q
         U43Fq7+HRywGlNsKbRJtsfxQtOZ8EBo5dbeX1yqHUnR2svEYke3RCk7Vevp5uEanN7iw
         5xsG+ON2vsHObuDmvIBjv3NS7hKPJL4jAlYiwf3pNwmXyhPVwu5IfAKLbEMsi8DHrv7Z
         7ycUAWRcQYEf226PKjx5bayCkNmWDZOeVCrBpiXEtqTtGAApTcpUQhsK+K0/Y0mQaly8
         u5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cHpVfF2u9C4oNMESIKL8KGjVklpXtV8TmmsyFDre/+I=;
        b=fad3E4oRoTBxYluCZYln2uThy445ot6Y9bqzdHsxmCFBi+rDrTkRTxSKnJD/of+qEh
         uBsctXxyFDOv6mXiza63nV54b7HZ4k4DUslct+n/2bg9qgX2RwFuw5aSg/Y0LiQTpcTb
         YXSylxcHATf7Z22cVjj3oG++9zLxv/1xaYnBtbq6BLB0hfia5RNPhE+NFg1nchWo9xdT
         2o9OsenYiMzsxFtuBsE367pmeEHYf/d1kZ8wiXL0if2xO/eqW9fB6P+oKOQMa9i4NBWq
         HsDK9LX9Ft90xxyveMdKLWlv36l3Bnr5ANpx/DMbG/c+Q0Eo90I5UYrIoNrudz2eFfNe
         TGPw==
X-Gm-Message-State: AGi0PubE4GHUaHtdMyn7FxZ18NZiLkB6PhQi/73+19I4uKmRCODvUELi
        HoUFJ2r1q44qgDFiPXDkENM=
X-Google-Smtp-Source: APiQypK4XlUOBbb1IowGUtnHmtknkxFlNbZmujatVvRj9b8DxMvxo7x8jihHA1AExMiKHbAsJ6HgKA==
X-Received: by 2002:a63:f252:: with SMTP id d18mr20843132pgk.228.1586177575607;
        Mon, 06 Apr 2020 05:52:55 -0700 (PDT)
Received: from localhost (n112120135125.netvigator.com. [112.120.135.125])
        by smtp.gmail.com with ESMTPSA id s65sm4954709pgs.30.2020.04.06.05.52.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Apr 2020 05:52:55 -0700 (PDT)
From:   Qiujun Huang <hqjagain@gmail.com>
To:     benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
        oohall@gmail.com
Cc:     tglx@linutronix.de, Markus.Elfring@web.de, christophe.leroy@c-s.fr,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Qiujun Huang <hqjagain@gmail.com>
Subject: [PATCH v5 1/2] powerpc/powernv: Remove redundant assignments to attr and name
Date:   Mon,  6 Apr 2020 20:52:41 +0800
Message-Id: <20200406125242.4973-2-hqjagain@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200406125242.4973-1-hqjagain@gmail.com>
References: <20200406125242.4973-1-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to go to the labal of out when of_property_read_u64_array
fails, as there is nothing to do. Just return.
And we can remove the redundant assignments to attr and name.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
---
 arch/powerpc/platforms/powernv/opal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
index 2b3dfd0b6cdd..71af1cbc6334 100644
--- a/arch/powerpc/platforms/powernv/opal.c
+++ b/arch/powerpc/platforms/powernv/opal.c
@@ -801,14 +801,14 @@ static ssize_t export_attr_read(struct file *fp, struct kobject *kobj,
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
 	name = kstrdup(export_name, GFP_KERNEL);
-- 
2.17.1

