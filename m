Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D723C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302542086A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 18:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="UQ/00/SC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392712AbgBNSVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 13:21:15 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:57820 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388359AbgBNSVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:21:11 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 48K1sf612Jz9vYVN
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 18:21:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 0gfURq2kH0Oz for <linux-kernel@vger.kernel.org>;
        Fri, 14 Feb 2020 12:21:10 -0600 (CST)
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com [209.85.219.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 48K1sf4jrkz9vYV0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 12:21:10 -0600 (CST)
Received: by mail-yb1-f198.google.com with SMTP id n1so8431690ybo.4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 10:21:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hbzcEFviquV03HD8A3Jng5TQLggAAO3vfpAktWqHk4=;
        b=UQ/00/SCkqgjUfiKLVsJj10tQyBTZkcsP3Jp3BFiFZjjBuGNq/PFqG87Qdw6m14cxg
         iNckCZnewLhSt1LyP4DDLVBza//GXKyqCT5ApqA+FxnZuTvAqLgq2jKrCZPj6pV8/aa5
         OjxI0IT9RUIFaKlBSEuTary5vQXjiQu31Yef/l4G3XWmd2sGrUIHWBWIurMbnYAJ7yXh
         0aBuzLEqzqqLWMB31aCTSLOeu4UTt1KkPQ6YHSbe6T7vinAOzzYxlnvlYpoQkspcPpDd
         ijSXr1sg2C6lViE0eXA7g/1xQXU91wW/uC6rPDqC6GB6EpWbthMKP5z9B/yQ+IPeWfu0
         dCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hbzcEFviquV03HD8A3Jng5TQLggAAO3vfpAktWqHk4=;
        b=sXDfAkwamCdtI8DyxPMGaJ08YrZ/TnkJsqqMUUCK4GMgbGUF5jX+wDvCIMpuCwW9xM
         Ip7UqdQ2tfiQ7nkNBk28oMmY++XucWgvrWz74U8yPRGOE0s6LidyGUDPBKCtH01FyGxr
         q8t2cYIzuu9CD/P6KAADUbjku2n4Y4BWvJEeGEwQjieKblgREirobRQxTzVwpG1Qx5PU
         2cbNoDcImszt5kZ9Jcpir1zLso2zNeWtIX2GvpNqw7FsU535By39bdwmaAlsjHwoDSPu
         bn8ZWY+C8uFiQErVA3VpnZwGTpfZZOeBcIvNiJkx2hRErkupOdszK6P7yEV123zh6qGg
         Xpyw==
X-Gm-Message-State: APjAAAX85KQcAZh9pffuNSXx5MPx0+Toa37yfFjN4NL/DOLpgz5WFWde
        IPj6ASNu6UnBPWJDzyOvx+78C6C6DCOh0YPEZi5js0YloVA+jXZOET6+bGLHCS+zaNXDSKRmiPz
        aljx1S57Z2+nwyxqEm9RG6NG+i2PW
X-Received: by 2002:a0d:d182:: with SMTP id t124mr3587142ywd.96.1581704470116;
        Fri, 14 Feb 2020 10:21:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwsaIdyfI2/Azn+euwzJt/+5+mOgjpGKlacFD20lZDWK0SsYmu2ahnOa2Omk/wbhrOD5GFE/g==
X-Received: by 2002:a0d:d182:: with SMTP id t124mr3587123ywd.96.1581704469910;
        Fri, 14 Feb 2020 10:21:09 -0800 (PST)
Received: from cs-u-syssec1.dtc.umn.edu (cs-u-syssec1.cs.umn.edu. [128.101.106.66])
        by smtp.gmail.com with ESMTPSA id i2sm2809753ywm.17.2020.02.14.10.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 10:21:09 -0800 (PST)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, Tyler Hicks <tyhicks@canonical.com>,
        Andrew Morton <akpm@osdl.org>,
        Michael Halcrow <mhalcrow@us.ibm.com>,
        Adrian Bunk <bunk@stusta.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Theodore Ts'o" <tytso@mit.edu>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] ecryptfs: replace BUG_ON with error handling code
Date:   Fri, 14 Feb 2020 12:21:01 -0600
Message-Id: <20200214182101.17165-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In crypt_scatterlist, if the crypt_stat argument is not set up
correctly, the kernel crashes. Instead, by returning an error code
upstream, the error is handled safely.

The issue is detected via a static analysis tool written by us.

Fixes: 237fead619984 (ecryptfs: fs/Makefile and fs/Kconfig)
Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
v1: Add missing fixes tag suggested by Markus and Tyler.
---
 fs/ecryptfs/crypto.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index db1ef144c63a..2c449aed1b92 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -311,8 +311,10 @@ static int crypt_scatterlist(struct ecryptfs_crypt_stat *crypt_stat,
 	struct extent_crypt_result ecr;
 	int rc = 0;
 
-	BUG_ON(!crypt_stat || !crypt_stat->tfm
-	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED));
+	if (!crypt_stat || !crypt_stat->tfm
+	       || !(crypt_stat->flags & ECRYPTFS_STRUCT_INITIALIZED))
+		return -EINVAL;
+
 	if (unlikely(ecryptfs_verbosity > 0)) {
 		ecryptfs_printk(KERN_DEBUG, "Key size [%zd]; key:\n",
 				crypt_stat->key_size);
-- 
2.20.1

