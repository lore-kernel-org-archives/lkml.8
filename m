Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15351C4332B
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D874C20722
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 22:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lWH71JTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbgCUWVW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 18:21:22 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:36336 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbgCUWVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 18:21:21 -0400
Received: by mail-pj1-f66.google.com with SMTP id nu11so4179364pjb.1
        for <linux-kernel@vger.kernel.org>; Sat, 21 Mar 2020 15:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YDt1O5yGZ6i7riNKjtcBfBSe+BjizbdVsG1m7rWg6PY=;
        b=lWH71JTFjmKdK1+WU7n32xi2rrAA3ia70j/TFYjfkM7i3bGTNvL5LQDvKn7kGc/Loj
         raS1GoaViYA5+yZFdhoeL5mpeVH/8Td6a+JiKqg98w8eESkAwGxlij3Bd2CXFcKRvKH/
         D5f4f3J5N9c4bC8Qf6H7y68oLs/tBUxblHULQWksmeWcX55QexQs4TNYOJKXDhZS19Fz
         4N5/ZnPOEyoeGsq+oDXw058zvqlyIde0mJpkWnPa+1JyFIZcvzxa7SZWW3f7csjlWdQh
         s2K+EtHEsdQEkicgWCRb/HkssUG7tGtuUf7pGl+PkrPoDHBdrKCzVMMRGXn5aV0p9uAX
         8v+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YDt1O5yGZ6i7riNKjtcBfBSe+BjizbdVsG1m7rWg6PY=;
        b=UYz6hfaBfCExlOMG0pSfX2ym1v+wf22rPpKssz/9Nmju8wT4TTt0ERhRG/lHJ5lkuS
         QKXX31I/RIxpOzKs8eOHYHeJhdVwjOO3K5KvMdpHztcDmnautmODsQIMRCzYLeW5NVvQ
         JCLQpRJP8Xbddis05FkRBNuclGUKe9RBJyR4aUuzDKDOGL46no472/Q7o7OaMQPN+HFW
         VCVwfS4tNe6NhHiHX5s3obXYEMb1EYv9SyHltfq3zR7KonfvN2PD4AgF7KgE6jVlnK3+
         HcR46BHXJDG+CiH5P66AE6ZvecoPX/3C8OBZEk8CpZ05s4u3L9PotL95YOG3gEAdtSO7
         +6cw==
X-Gm-Message-State: ANhLgQ1Fjz6UaK/gX89d8taDDB2L0RXEIUOn42qg837TWyV+qIaqTJu5
        5/GHXZDAuoBBI4V58deG71Y=
X-Google-Smtp-Source: ADFU+vsiHNFTV1nG+Qdz3weTi93Li0qmFI2E0dyrDWwMvRhKrMBUoS4V0ZTKtgFPYQx3s8zVJgi1hA==
X-Received: by 2002:a17:90a:21ac:: with SMTP id q41mr17311989pjc.41.1584829280895;
        Sat, 21 Mar 2020 15:21:20 -0700 (PDT)
Received: from localhost.localdomain ([113.193.33.115])
        by smtp.gmail.com with ESMTPSA id w19sm8744669pgm.27.2020.03.21.15.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2020 15:21:20 -0700 (PDT)
From:   Shreeya Patel <shreeya.patel23498@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Cc:     Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [Outreachy kernel] [PATCH 01/11] Staging: rtl8188eu: hal_com: Add space around operators
Date:   Sun, 22 Mar 2020 03:51:13 +0530
Message-Id: <19950c71482b3be0dd9518398af85e964f3b66b1.1584826154.git.shreeya.patel23498@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1584826154.git.shreeya.patel23498@gmail.com>
References: <cover.1584826154.git.shreeya.patel23498@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add space around operators for improving the code
readability.
Reported by checkpatch.pl

git diff -w shows no difference.
diff of the .o files before and after the changes shows no difference.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---

shreeya@Shreeya-Patel:~git/kernels/staging$ git diff -w drivers/staging/rtl8188eu/hal/hal_com.c
shreeya@Shreeya-Patel:~git/kernels/staging$

shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$ diff hal_com_old.o hal_com.o
shreeya@Shreeya-Patel:~git/kernels/staging/drivers/staging/rtl8188eu/hal$


 drivers/staging/rtl8188eu/hal/hal_com.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/hal_com.c b/drivers/staging/rtl8188eu/hal/hal_com.c
index 95f1b1431373..ebe19e076ff2 100644
--- a/drivers/staging/rtl8188eu/hal/hal_com.c
+++ b/drivers/staging/rtl8188eu/hal/hal_com.c
@@ -18,26 +18,26 @@ void dump_chip_info(struct HAL_VERSION	chip_vers)
 	uint cnt = 0;
 	char buf[128];
 
-	cnt += sprintf((buf+cnt), "Chip Version Info: CHIP_8188E_");
-	cnt += sprintf((buf+cnt), "%s_", chip_vers.ChipType == NORMAL_CHIP ?
+	cnt += sprintf((buf + cnt), "Chip Version Info: CHIP_8188E_");
+	cnt += sprintf((buf + cnt), "%s_", chip_vers.ChipType == NORMAL_CHIP ?
 		       "Normal_Chip" : "Test_Chip");
-	cnt += sprintf((buf+cnt), "%s_", chip_vers.VendorType == CHIP_VENDOR_TSMC ?
+	cnt += sprintf((buf + cnt), "%s_", chip_vers.VendorType == CHIP_VENDOR_TSMC ?
 		       "TSMC" : "UMC");
 	if (chip_vers.CUTVersion == A_CUT_VERSION)
-		cnt += sprintf((buf+cnt), "A_CUT_");
+		cnt += sprintf((buf + cnt), "A_CUT_");
 	else if (chip_vers.CUTVersion == B_CUT_VERSION)
-		cnt += sprintf((buf+cnt), "B_CUT_");
+		cnt += sprintf((buf + cnt), "B_CUT_");
 	else if (chip_vers.CUTVersion == C_CUT_VERSION)
-		cnt += sprintf((buf+cnt), "C_CUT_");
+		cnt += sprintf((buf + cnt), "C_CUT_");
 	else if (chip_vers.CUTVersion == D_CUT_VERSION)
-		cnt += sprintf((buf+cnt), "D_CUT_");
+		cnt += sprintf((buf + cnt), "D_CUT_");
 	else if (chip_vers.CUTVersion == E_CUT_VERSION)
-		cnt += sprintf((buf+cnt), "E_CUT_");
+		cnt += sprintf((buf + cnt), "E_CUT_");
 	else
-		cnt += sprintf((buf+cnt), "UNKNOWN_CUT(%d)_",
+		cnt += sprintf((buf + cnt), "UNKNOWN_CUT(%d)_",
 			       chip_vers.CUTVersion);
-	cnt += sprintf((buf+cnt), "1T1R_");
-	cnt += sprintf((buf+cnt), "RomVer(0)\n");
+	cnt += sprintf((buf + cnt), "1T1R_");
+	cnt += sprintf((buf + cnt), "RomVer(0)\n");
 
 	pr_info("%s", buf);
 }
-- 
2.17.1

