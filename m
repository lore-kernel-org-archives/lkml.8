Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B06C2BAEE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0D272072F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 04:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjf4XFav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCMEHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 00:07:35 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55640 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgCMEHe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 00:07:34 -0400
Received: by mail-pj1-f68.google.com with SMTP id mj6so3331871pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 21:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=63YK6hAOTIgGcqoqnCHcaTtDcQcLBQolfysjdQtGDt8=;
        b=qjf4XFavgn6fObGXRj5cKFDrACpuaHIpml6H5EWPFMgbD5+kpCAYUXI+Zo3OHARgh7
         Lm6k3MniuI3m9EfMhEZ5EHtHxTElwGtvo7APyoNMWcl2iujXFt99R+CtKi0slb/QsT3E
         KfH+cJp7fEHPAMmTDSC2PzbaLtAhYk/zdAfW7ZXTA0u111iib3yPEUk3i9J2rxHCBupM
         rSUUPa9DukU3Tcqv1ha+8NMwMzgf89pAXSTzowWklIW5x9s6IbgmQaB/tu7293md0Zp0
         qvzfjAbgZyF84Ttgo6n+xVGhhbnn2MfKW/qXa6Afl50hCIbRtXd6jR4iQtLG8S4qmjrM
         Mu+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=63YK6hAOTIgGcqoqnCHcaTtDcQcLBQolfysjdQtGDt8=;
        b=JY42W3Y273GfJPMwhSOOpp9kny+LZdT4eCjPXg81DbndeT9qebp0d/5shcmnZE+HG4
         PTgYrpXPzyiZPSk+qMrjzXAFGikwI9IN1r5hmfd/9Qv0VDWwoNt5gltDpiT8Kjh4CtPk
         a+Tvo6a5aM87w8VYgmPZPPjwiqOkkrGw634dKOXQsfxpwt4j00H4TnAJme9dscAhVZkm
         2BqNTjiFhxCffFXZmtNA4SATmks9L5WWPOq/g080ThSWHHBqILXmgfmyQwglK2aZwsvk
         TjwiDf3cOmLzYhPg1OYD2PGQTgENeCTHAU9JTvZXnVFBSCyztIj/ejVeOt2MrGB899Gt
         1TAA==
X-Gm-Message-State: ANhLgQ3UsetNRIipHnXn/j5acRW/fhGvYHoJrpQORxKv0d3VstQVV4Le
        wdUv/Pkv5RYsKhBS8ITcrR61tLhT
X-Google-Smtp-Source: ADFU+vtztOyeiQM38jyuY6pDjal/590d9sAw7Gel8yMd+Me85a4G1sn6wEx1MVOaTquGB8VvcMPB3A==
X-Received: by 2002:a17:90b:14c:: with SMTP id em12mr8047583pjb.22.1584072448173;
        Thu, 12 Mar 2020 21:07:28 -0700 (PDT)
Received: from sh03840pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id 6sm15576661pfx.69.2020.03.12.21.07.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 12 Mar 2020 21:07:27 -0700 (PDT)
From:   Baolin Wang <baolin.wang7@gmail.com>
To:     srinivas.kandagatla@linaro.org
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, freeman.liu@unisoc.com,
        baolin.wang7@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] nvmem: sprd: Determine double data programming from device data
Date:   Fri, 13 Mar 2020 12:07:09 +0800
Message-Id: <51e9c7fbefae0f616e309ba9d20be2eb3e3e2e7d.1584072223.git.baolin.wang7@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <cover.1584072223.git.baolin.wang7@gmail.com>
References: <cover.1584072223.git.baolin.wang7@gmail.com>
In-Reply-To: <cover.1584072223.git.baolin.wang7@gmail.com>
References: <cover.1584072223.git.baolin.wang7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've saved the double data flag in the device data, so we should
use it when programming a block.

Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
---
 drivers/nvmem/sprd-efuse.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 43b3f6e..925feb2 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -324,6 +324,7 @@ static int sprd_efuse_read(void *context, u32 offset, void *val, size_t bytes)
 static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 {
 	struct sprd_efuse *efuse = context;
+	bool blk_double = efuse->data->blk_double;
 	bool lock;
 	int ret;
 
@@ -348,7 +349,7 @@ static int sprd_efuse_write(void *context, u32 offset, void *val, size_t bytes)
 	else
 		lock = true;
 
-	ret = sprd_efuse_raw_prog(efuse, offset, false, lock, val);
+	ret = sprd_efuse_raw_prog(efuse, offset, blk_double, lock, val);
 
 	clk_disable_unprepare(efuse->clk);
 
-- 
1.9.1

