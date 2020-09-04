Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF59C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E9812074D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 15:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyiAzQ07"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbgIDPWz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 11:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730905AbgIDPWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 11:22:39 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DCDC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 08:22:39 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u13so4511075pgh.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 08:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhGWIlrqRL4A3CYEW/fZul+9qsq53dkEaLWmo2XlaaQ=;
        b=RyiAzQ07v2ZooHsYtRWflXJTUKc5GglOSMnseNFDk7HyM4Y4xHP+CEcdHh2CwFF+De
         VxrgwHqhuxFS/oz9XfcOgU5I32yoTrGO/Biei4UPKBs0cVtFcpJH8+iAyeXXHLzXFQFU
         91r5ugOd3/eiInmw5MrLJRhqBAyejuRxspCCps4szq6QS97m6tn939CFn9PVy9IBQanv
         OH3EPTtZ+Qna3AYVObx1X8oOe1Jr9F5lHhSiFMQNSQc92TAFBSK3I2jYsvu/YW3vDXmk
         VmNjxUrZipHBzXeudIhIleEOHEBvTkGfw6BUvtIUOBfmN/y58TGg44I7F06EGFvyAjOJ
         vSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nhGWIlrqRL4A3CYEW/fZul+9qsq53dkEaLWmo2XlaaQ=;
        b=fVp9UEOMdZdj18wbkFBdIEfeXuNNjh3t2vdrcYrY84NJ41h9sjHcgQHoQzYbima2NX
         +cVIzBwdPmf9kaV5dNzpyjbo3TKfJM2v+ygs7P/aTuO47G9Q3CNUPXx5UCRZZnDTzK1i
         kP622YweLAni8SUTyRHwgbbt9UhekhN3hV6oqCTby3Hu09iuTFauH9xwc7NVVoDhry1J
         suQGUxg3UFu43vhk54ArPj6NToKFtoul1xeLm3eu9uAjBtI1iswdhU3P6upxu/YYcwl6
         ldRBW0ZUQDT1RpNly+uGiyjaupUQ08AeucViWjr9KBEPzrgi54iGhjAYjHYBLKiE1Gvw
         ufsQ==
X-Gm-Message-State: AOAM532PhbWGW0iz00wf43/1XhOOqK3l6/E/SeVzm7h6Oykt5I9Oh/ZT
        B4I4Q6Cu0t2US1uHIx4LEeA7UGyBc7M=
X-Google-Smtp-Source: ABdhPJwCiPrd6Fdtq27v3WGV3yLwtty7P1Mq7wXxq2vnhBUJR06DFaQidzG+5jw3NYbjeNvNPnXRcQ==
X-Received: by 2002:a63:b202:: with SMTP id x2mr7408241pge.432.1599232958557;
        Fri, 04 Sep 2020 08:22:38 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id q190sm7141779pfc.176.2020.09.04.08.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 08:22:37 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Randy Dunlap <rd.dunlap@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] kcsan: kconfig: Move to menu 'Generic Kernel Debugging Instruments'
Date:   Fri,  4 Sep 2020 23:22:24 +0800
Message-Id: <20200904152224.5570-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This moves the KCSAN kconfig items under menu 'Generic Kernel Debugging
Instruments' where UBSAN resides.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 lib/Kconfig.debug | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index e068c3c7189a..0c781f912f9f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -520,8 +520,8 @@ config DEBUG_FS_ALLOW_NONE
 endchoice
 
 source "lib/Kconfig.kgdb"
-
 source "lib/Kconfig.ubsan"
+source "lib/Kconfig.kcsan"
 
 endmenu
 
@@ -1620,8 +1620,6 @@ config PROVIDE_OHCI1394_DMA_INIT
 
 source "samples/Kconfig"
 
-source "lib/Kconfig.kcsan"
-
 config ARCH_HAS_DEVMEM_IS_ALLOWED
 	bool
 
-- 
2.25.1

