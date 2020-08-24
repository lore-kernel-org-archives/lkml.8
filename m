Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEAFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D33206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:25:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfTGk3Fy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgHXXZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHXXZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:25:33 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2461AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 16:25:31 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id c10so9594458edk.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 16:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6fyUi7UpuGuaaGv222CmWf0CmSV4DfN3hMK/FUDMnE=;
        b=TfTGk3Fyl1leaExjHKc5dMhxnOZ5q7clsynXlpAU7WxodTYB4T3VAMvTom1LXgnurF
         9EkGP4MmxcX4uRFgOdOmEtnkldcljulGuwETEFKDw5IzaFvStmpx4M0KHlLrihorGPLd
         1S1eE8kvSHJwf/fWUUzd0vPQYmIxZl03C6rRP2O5vfFbAuUzbpLgdjI8hDhJrzdLO8ib
         RM33KTTW56gEqLYJWO/k+idupSmRwk1HOAFoPTlH9AW/jK2D7lrhfvvZ6cXwVEE32ZWr
         4/sDnd/ttfjxyaeJpbGlAcMRo+5TkhmaHcWkPrYerTxSVrpHJKMCvFow23DnBs7k359s
         n2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D6fyUi7UpuGuaaGv222CmWf0CmSV4DfN3hMK/FUDMnE=;
        b=eTyyHvliUdmcAz/tE6jXuQOb3eOr35//aZ1nRI8ko85REiKa9msbB2aK+LjF4AG3fh
         mq4JoSXHmiIv7ObPz09GwnDo3JOtibRsj5FmOEQiP/PdMnM1ErvbMf8on0djHBkhS5p7
         NOXuMmftJzyIeyqTMKVGCUM5YqbMFgSe8LaUikwtoyUncgfxh3ck5aHtkOL3pZyTfDrh
         ppqGbx64lqnLOJkGwACxiDMfk4ao0ns5p9FXN6jIZu3kZ4lsSYffAx+ZJ4pnhnW9BJRa
         kq+yeMPhxR9NrNiJSQLs6S9RaHcjA2K7zs6YIPkgYnTZOpE9+GKKrAKObXr+Ly2SwRJq
         Ug0Q==
X-Gm-Message-State: AOAM532G+NluNICNDjgKbuyWcF/jS90HAQMyZbxx0kttSiQTmdadu4Co
        FEcQlkReT78Dt/bee/JG5WU=
X-Google-Smtp-Source: ABdhPJwlwTtjsaag34bDwZ8YholYlrv9kL4SAq3KPCZh8lrrDfc1/K3oycgviSXv+WvUyII2DmhgHg==
X-Received: by 2002:a50:9e4c:: with SMTP id z70mr7482896ede.384.1598311529889;
        Mon, 24 Aug 2020 16:25:29 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:a7fb:e200:cc20:f2c0:9426:e440])
        by smtp.gmail.com with ESMTPSA id w22sm11262634edx.80.2020.08.24.16.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 16:25:29 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] fix comment concerning GCC 4.6
Date:   Tue, 25 Aug 2020 01:25:26 +0200
Message-Id: <20200824232526.16534-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 4.6 is not supported anymore, so remove a reference to it,
leaving just the part about version prior GCC 5.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 include/linux/compiler_attributes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index af7a58c19e20..ea7b756b1c8f 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -22,7 +22,7 @@
 
 /*
  * __has_attribute is supported on gcc >= 5, clang >= 2.9 and icc >= 17.
- * In the meantime, to support 4.6 <= gcc < 5, we implement __has_attribute
+ * In the meantime, to support gcc < 5, we implement __has_attribute
  * by hand.
  */
 #ifndef __has_attribute
-- 
2.28.0

