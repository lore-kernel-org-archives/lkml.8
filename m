Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D43C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C703620707
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 09:00:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="rbveVXt7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgAaJAE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:00:04 -0500
Received: from dvalin.narfation.org ([213.160.73.56]:52532 "EHLO
        dvalin.narfation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728151AbgAaJAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 04:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
        s=20121; t=1580461202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=15/OI/xJJYxtK7XOfs9IFESyt4OHQIbNCxIjdFy0prI=;
        b=rbveVXt7C49gWZDLjvt01gct5Pj2y2uyalqgiCa1xFfVbccW1ebMy/OztQLArr19x2bAVg
        0k6nrPu4xPKD9bHoDLyy0GhdNSn+FdJRHgfdLMfeAcYME7VzNF18uw4wFDVF+BfH2N3uLS
        OtbNlaEEBqaB7ge2ZMAXCQMaLBM8Yh0=
From:   Sven Eckelmann <sven@narfation.org>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, info@alten.se,
        Sven Eckelmann <sven@narfation.org>
Subject: [PATCH] MAINTAINERS: Orphan HSR network protocol
Date:   Fri, 31 Jan 2020 09:59:19 +0100
Message-Id: <20200131085919.18023-1-sven@narfation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current maintainer Arvid Brodin <arvid.brodin@alten.se> hasn't
contributed to the kernel since 2015-02-27. His company mail address is
also bouncing and the company confirmed (2020-01-31) that no Arvid Brodin
is working for them:

> Vi har dessvärre ingen  Arvid Brodin som arbetar på ALTEN.

A MIA person cannot be the maintainer. It is better to mark is as orphaned
until some other person can jump in and take over the responsibility for
HSR.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b32153bed5a..79ddd9d8592f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7666,9 +7666,8 @@ S:	Orphan
 F:	drivers/net/usb/hso.c
 
 HSR NETWORK PROTOCOL
-M:	Arvid Brodin <arvid.brodin@alten.se>
 L:	netdev@vger.kernel.org
-S:	Maintained
+S:	Orphan
 F:	net/hsr/
 
 HT16K33 LED CONTROLLER DRIVER
-- 
2.20.1

