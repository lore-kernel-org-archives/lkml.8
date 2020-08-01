Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B38C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38467206E9
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 17:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKiWM1z0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgHAR5p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgHAR5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 13:57:44 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C2FC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 10:57:44 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i10so823860ljn.2
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 10:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVROroz657/I/Ih2063QqkFa0hHlRqGYHGpAlZxIDIU=;
        b=PKiWM1z0wSCVv5xEm41YfLhadbzphe6Czf6TvIm1dVHi8am+D8SmoENHmOuFvTb6Ks
         2/3JCblBdYCIrzLfhImazWRAG8BMXLnhSJUF9aXJb7Uzn/1veAyCoSG260mRuGfuP4dW
         mhT9NozcmAB6SZ8zU0OGUpXbQF8ZTIRwhyMJ0d2gm8/CXx6+itzzUXF0xOcPv0XsloYs
         eRBxIFJmMADC49RR06UN0eBrG4wwgI3Q3NdGc5wRc8o1xiaFI/nKO7RhcdKXMu7trk7O
         FVN9qIXybwH3eD4I0u5JxxXy5cTirMGObNMBPG6Kudw64AtfBqipU53KTAzmW+lG6ckY
         Hp9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MVROroz657/I/Ih2063QqkFa0hHlRqGYHGpAlZxIDIU=;
        b=ec6Sg4ggMUQaNoZ4W7fM92bTcsH9qiNyGRC30hhrwG2jEL30oeoeArgsEOeUoFW3Kr
         u8Wk98CmAv80k1tTDwZFx9FBnGbhFh4/46HIL++mvuaJwhTw3caneF4fHrKwlLAJDu9i
         4K+HdrF4KcNfDaqYLGWO758+81vzufEvuypnl4zqdat+j8NIlb1Zzt8b9PZ/4sB+Z7vH
         OX9gbLWgprhJCzJxgBAMmYQ0KYzoWaqhTxb8BQDxAD+ZWOxyPf3/raNC/IeM8RlSqFHD
         rRObdGccikzoiSXa+aqSOUHcfqTBKv0VTQvHXy+PKxhV4kBtc1NILpxtgmRW11IAJblN
         R+BA==
X-Gm-Message-State: AOAM531zTbDUmjX0u/ZOzWn7+CtF/OqsbGi7n1TXF3AxcuL9FTasJZxE
        c/9XMzNjaNqEK1xy4IWeKD4=
X-Google-Smtp-Source: ABdhPJzEQqKL7E5Po5xXjYbD3pkXhwpZpVFJAQc1NLxWnKtXEi969IU4Unxd6/EEZyeXAAXvYQnZVg==
X-Received: by 2002:a2e:b008:: with SMTP id y8mr3759143ljk.421.1596304661274;
        Sat, 01 Aug 2020 10:57:41 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id d6sm2480920ljc.23.2020.08.01.10.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 10:57:40 -0700 (PDT)
Received: (nullmailer pid 34162 invoked by uid 1000);
        Sat, 01 Aug 2020 18:02:52 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        Michael Straube <straube.linux@gmail.com>,
        Joe Perches <joe@perches.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH v3] staging: r8188eu: replace rtw_netdev_priv define with inline function
Date:   Sat,  1 Aug 2020 21:02:35 +0300
Message-Id: <20200801180235.34116-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function guarantees type checking of arguments and return value.

Result of rtw_netdev_priv macro can be assigned to pointer
with incompatible type without warning. The function allow compiler
to perform this check.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
Changes in v2:
  - add blank line after function definition;
  - improve commit message.

Changes in v3:
  - use proper argument name;
  - remove unnecessary parentheses.
---
 drivers/staging/rtl8188eu/include/osdep_service.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
index 31d897f1d21f..b44d602e954a 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -71,8 +71,11 @@ struct rtw_netdev_priv_indicator {
 };
 struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv);
 
-#define rtw_netdev_priv(netdev)					\
-	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
+static inline struct adapter *rtw_netdev_priv(struct net_device *netdev)
+{
+	return ((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv;
+}
+
 void rtw_free_netdev(struct net_device *netdev);
 
 #define FUNC_NDEV_FMT "%s(%s)"
-- 
2.26.2

