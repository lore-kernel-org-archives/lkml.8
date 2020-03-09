Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291F5C18E5A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AD320727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tZIvw3mN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCIIy4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:54:56 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51692 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:54:55 -0400
Received: by mail-pj1-f68.google.com with SMTP id y7so695148pjn.1;
        Mon, 09 Mar 2020 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdW15qiMY5illbr/+F1RmCKtuh5WFHYMhO0nRsSBBIo=;
        b=tZIvw3mNFXL79QSFw7+ZymIas3nsUXtEEIccyIBvM6Pib/XGlCLJiaQOs+2fkMdRyd
         f3KqoNrEKwY2sCzi4Brd8iyfNHHb6C0SoeCQWXqkPTmPfo2Hc1HrrIeCZD8AREs1CVcb
         /H5VYOkJRUl5zvTLaqAykGUmY9LfcJBDFxNRhhoDaPRkuGv92YtilCvonGM0I6wDIy6o
         EFbPxDIiVKhV/plKSESQ5NCkfkH3n+BmzjEq5q4WPwtxXHNSRayTEODR/A0+XnjRESCL
         H/mBsDQK6jwzwh3HwSQ2N0RDk+wL4IgH2do4+Y688oSCFpyraa57gDsmCqTVZXTuQG2w
         vLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QdW15qiMY5illbr/+F1RmCKtuh5WFHYMhO0nRsSBBIo=;
        b=TEAxVZ37GAQvndnYotM6JMCLD+0uXmWh4p/5n3wKh6+FML/4HhySkDEggJ+rDWdKmh
         7vDcCWu3SWT3rlEAIofYNKoiYVc75AnbTOa6rmX/2uMkECc/sVt/dP2OIw4KfqhZjH27
         8oDtzE/8HifpiBc4bFsNaA+9rz/8obo0eZufLFvSONNFiyHl2PBggcJokdqSQmkw5R68
         2cLkqrFGHOgY3wdEUxYe1mpE8eRvM8slhfkFQuJIyIfvKrkmLpuFzfTMOiJqFwu4RkyS
         VM6C7d1ny1y5tXsUj5Jy8z2GYnK/ffrsUURJ3+GLP0+PVsNlzlvz1MkoTfatgHtc8Te6
         i7CA==
X-Gm-Message-State: ANhLgQ39GlFkSZPIURWiYGnb9giqYUUrwZOJwJd3Gw8DmupxijuoeD1v
        pNUjb/p96TpeX+0mkWuIwBmgX3ym
X-Google-Smtp-Source: ADFU+vtrjulPtewCkmIgihEfwpXq679modQaiN0DAHC5TeX2O24LgoMurNh0i2sKHMSw2WsWtqXGoA==
X-Received: by 2002:a17:902:8bc3:: with SMTP id r3mr15094232plo.220.1583744094617;
        Mon, 09 Mar 2020 01:54:54 -0700 (PDT)
Received: from masabert (i118-21-156-233.s30.a048.ap.plala.or.jp. [118.21.156.233])
        by smtp.gmail.com with ESMTPSA id x2sm42133385pge.2.2020.03.09.01.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:54:53 -0700 (PDT)
Received: by masabert (Postfix, from userid 1000)
        id 13FC62360125; Mon,  9 Mar 2020 17:54:52 +0900 (JST)
From:   Masanari Iida <standby24x7@gmail.com>
To:     linux-kernel@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@linux.intel.com,
        platform-driver-x86@vger.kernel.org
Cc:     Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Fix a typo in error message
Date:   Mon,  9 Mar 2020 17:54:44 +0900
Message-Id: <20200309085444.53499-1-standby24x7@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fix a spelling typo in error message.

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 tools/power/x86/intel-speed-select/isst-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/power/x86/intel-speed-select/isst-config.c b/tools/power/x86/intel-speed-select/isst-config.c
index 2b2b8167c65b..f323dc9b770f 100644
--- a/tools/power/x86/intel-speed-select/isst-config.c
+++ b/tools/power/x86/intel-speed-select/isst-config.c
@@ -656,7 +656,7 @@ int isst_send_msr_command(unsigned int cpu, unsigned int msr, int write,
 		msr_cmds.msr_cmd[0].data = *req_resp;
 
 	if (ioctl(fd, ISST_IF_MSR_COMMAND, &msr_cmds) == -1) {
-		perror("ISST_IF_MSR_COMMAD");
+		perror("ISST_IF_MSR_COMMAND");
 		fprintf(outf, "Error: msr_cmd cpu:%d msr:%x read_write:%d\n",
 			cpu, msr, write);
 	} else {
-- 
2.26.0.rc0

