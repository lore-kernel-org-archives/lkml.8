Return-Path: <SRS0=HPGY=7U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B98C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F612065C
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Jun 2020 07:39:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5mqbMOP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgFGHjL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 03:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgFGHjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 03:39:10 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900B6C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 00:39:10 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id x16so1194979qvr.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 00:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSpBecVXHoHo81ui2nx77HvyTD777vyTeJNcxTijEW4=;
        b=Z5mqbMOP/KIJJ4PWY8seWya4xiLQ6GgMPFmI5YbB2P/dpWRgurcb9Ht9q9z4Leemhn
         WdIJf4FNrNiln1szTr/uNMr9DXpsL3d6vXfOX4dOwLwwJ2kKAoYuZ2Yc2K4eyRgrN433
         ucsdBGYXamgmdrFd9z28R7r//6+DF94swpDuy0BZOaE3sOAXwduHZfKH0QZmXS8Do6US
         NN22Q64GZH6t5YDIWrGgN+14Hck52kudWyb08PUnUi2JhGX64xU/jRclLZeJJZLFbJ9f
         2qZd8JkkiIWmANszwwBSVDEvAFl4CZyw94JUNmDmHstW0PNfkrZnlV6TOhGF9VRRciSW
         wadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bSpBecVXHoHo81ui2nx77HvyTD777vyTeJNcxTijEW4=;
        b=rj+DnCHim/SM1Vmsy/IhFRcfJucKQdtbC2fVcx5bs0E34Lrxnj8njMpAbfN+DQT8v9
         dICPcSrqRhz8mOiLf2KeBC1pnsAAr6LAb2lLk7UDawccz46FlvWuZiNpFAxnu4oklcWl
         auFFIIzYqmb93tu3kahoCXY8HGCbvGK3QvXw9f3k3Z5gJNGzBphxKoQpQvTqi+teH8+q
         VS9gakBIH/dBv1zRnWUA5eD5RsRxfhew116rR56wHFb2xmGWLVGg101SxmFsfkAbSfm+
         SfWiw+bhGVXvei3lfjVS4vPXrW3S/rcKTKrGVJq2U2Y2w2j+/Dz3Z6csFLF6I1yP0YjA
         k/1g==
X-Gm-Message-State: AOAM5319uYKnocNh7lPhkeZLVGzLBDp8IO816et7bx0dT/JaVVSJWDiT
        ElSQ7KH/mfve+Sfo96OL6w==
X-Google-Smtp-Source: ABdhPJznulEYT66l023PUNItnTis9A9C6pTcaOUB+T7ICX43Kus1BcyuyetylJ+iu/Px+wk+Ru3YeQ==
X-Received: by 2002:a0c:f78b:: with SMTP id s11mr17373003qvn.33.1591515549644;
        Sun, 07 Jun 2020 00:39:09 -0700 (PDT)
Received: from localhost.localdomain ([142.119.96.191])
        by smtp.googlemail.com with ESMTPSA id q207sm4056656qke.55.2020.06.07.00.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 00:39:09 -0700 (PDT)
From:   Keyur Patel <iamkeyur96@gmail.com>
Cc:     iamkeyur96@gmail.com, Luis de Bethencourt <luisbg@kernel.org>,
        Salah Triki <salah.triki@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] befs: fix typos in btree.c
Date:   Sun,  7 Jun 2020 03:39:02 -0400
Message-Id: <20200607073903.97743-1-iamkeyur96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"countain" -> "contain"

Signed-off-by: Keyur Patel <iamkeyur96@gmail.com>
---
 fs/befs/btree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index 1b7e0f7128d6..53ad89bba448 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -322,7 +322,7 @@ befs_btree_find(struct super_block *sb, const befs_data_stream *ds,
  * Finds exact match if one exists, and returns BEFS_BT_MATCH.
  * If there is no match and node's value array is too small for key, return
  * BEFS_BT_OVERFLOW.
- * If no match and node should countain this key, return BEFS_BT_NOT_FOUND.
+ * If no match and node should contain this key, return BEFS_BT_NOT_FOUND.
  *
  * Uses binary search instead of a linear.
  */
-- 
2.26.2

