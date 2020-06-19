Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AA3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26FD521556
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:34:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="vuebaxuo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389426AbgFSTeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389031AbgFSTeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:34:09 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9C4CC0613EE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:34:09 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0FA791500CE7;
        Fri, 19 Jun 2020 21:34:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592595248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHc+pGW8shXxcarX1TsCeYezPRHohCHyoK0T39n5Ho4=;
        b=vuebaxuoSaC/HrLhPawDJsC9AGScwHght/qqUPR3txRjwikyw6YvmQz8y3gNzBueBbxBvt
        lM2oONcNjbVY4nUin5Rjn4AwKB1tADluwEE7pvo5NuG6REEmlyX+XkcPTm4Wl6m3r2jNhY
        Gqptv9Wc9jZVe2OlWtCAcZP+3RLRh7+CinBCwgNnAMFHUjQwjqTWDOfsRB0PJ7c5/N5SXg
        39awDtpUfV0JFBfZvBpEZ17PVr8Y9u5XMFizafeImme306wiABc1UmTj+7gsccQiZDcvkV
        DjW2FZaHNpM1YlSQqV5KwM0QnhWRnZP5s0FvwzG7df5It4yZhb/CWvj5CwvYyQ==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        Joe Perches <joe@perches.com>
Subject: [PATCH 5/9] drivers: cdrom: swap sides of comparison
Date:   Fri, 19 Jun 2020 21:33:37 +0200
Message-Id: <20200619193341.51209-5-devel@superboring.dev>
In-Reply-To: <20200619193341.51209-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
 <20200619193341.51209-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These were reported by scripts/checkpatch.pl

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/cdrom/cdrom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index 49073b1c7919..53e592423adb 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -749,7 +749,7 @@ static int cdrom_is_random_writable(struct cdrom_device_info *cdi, int *write)
 	if (ret)
 		return ret;
 
-	if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
+	if (be16_to_cpu(rfd.feature_code) == CDF_RWRT)
 		*write = 1;
 
 	return 0;
@@ -863,7 +863,7 @@ static int cdrom_ram_open_write(struct cdrom_device_info *cdi)
 	ret = cdrom_get_random_writable(cdi, &rfd);
 	if (ret)
 		return ret;
-	else if (CDF_RWRT == be16_to_cpu(rfd.feature_code))
+	else if (be16_to_cpu(rfd.feature_code) == CDF_RWRT)
 		ret = !rfd.curr;
 
 	cd_dbg(CD_OPEN, "can open for random write\n");
-- 
2.27.0

