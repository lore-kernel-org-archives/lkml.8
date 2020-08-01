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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77783C433E1
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 572D62076B
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 16:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/tnSkc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbgHAQra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgHAQr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:47:29 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE0C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 09:47:27 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id w25so13691ljo.12
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 09:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DYnTPT4/sYGcNhT4ZL721tJCBoXUCz3sR7pfzy1uU0=;
        b=c/tnSkc0+P8PGPhCHlwixhH5M9Che6g4W8HnOizbI6Bpixtff5DuH18eT/ljOHzTZ/
         t+eDhWKmmPKLNMad9VH+bRBcXXeA8swopsk3kr3VSmj3SuOAAQSGWuCdLNIuVTqVGMIl
         oPyohLjcoZsQBIAYmyRHnDwPn7bXnAAy7duzbgP0hHiXTYLyj9QFz9VPv+u1cbl13ob+
         18CEdaJvjCpt2JU8yAmexPZA4+Oc9B9foDs0lo/X2XwhlftUZj+kHWQ3zLp1cnlbpU1n
         NJsrS5Uk2Y9BkyK/mQMkW9zjZaTFm2yw++QbEKwAKQ6NKJZ+1HqH9F6/VI07Y4w4p9oT
         wjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3DYnTPT4/sYGcNhT4ZL721tJCBoXUCz3sR7pfzy1uU0=;
        b=XMF3dNLpNL/538FMSnTBMgaYSi69ZNNJVsJQbmm83XStEk7dIycQNxddgvmS7K8nea
         aILwwuwX+uouJuj4R5nKWwZI7JN2joM6J4U6EPcDxyMjWYR6fU95sBeli4c3/ZfE6NpF
         aQQ9eQW13VJEHDwccVLD/Vd1thq0tTjOkNZ+yn5qfwTcGicqha17YB5d2Gl1aBleRvM0
         o8m/Uv1Ko3GnasLvDoZh6O3xM/V1BZrBB6QLBnVDsl5lQKxr398DyuwDhu13MGozfyJC
         goNPIJPxTfrr3r4C1Rhw5Tsa8SrhJzPYcLRUWiDGft3PgSmPf1V7poNGpjVRu86Ib6Kb
         PgQg==
X-Gm-Message-State: AOAM531Z/XZgAsmOMimBtimymRukjc931e+pNEeX/phcq1t1oI3ykyYC
        JpP99R0UzjfU8XzNaZWSMj9evLM9
X-Google-Smtp-Source: ABdhPJzLHuK/EGTjnr1mOGNp3uIYy6X9Kb7gQhzwVs1jqCpxMaVoelez70TMWpA2JnrgK9HfLqbhcg==
X-Received: by 2002:a2e:9f10:: with SMTP id u16mr4362676ljk.130.1596300446230;
        Sat, 01 Aug 2020 09:47:26 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id e12sm2452360ljk.74.2020.08.01.09.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 09:47:25 -0700 (PDT)
Received: (nullmailer pid 29254 invoked by uid 1000);
        Sat, 01 Aug 2020 16:52:33 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        B K Karthik <bkkarthik@pesu.pes.edu>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH v2] staging: r8188eu: replace rtw_netdev_priv define with inline function
Date:   Sat,  1 Aug 2020 19:52:20 +0300
Message-Id: <20200801165220.29208-1-insafonov@gmail.com>
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
---
 drivers/staging/rtl8188eu/include/osdep_service.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/staging/rtl8188eu/include/osdep_service.h
index 31d897f1d21f..6ca79b5fb638 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -71,8 +71,11 @@ struct rtw_netdev_priv_indicator {
 };
 struct net_device *rtw_alloc_etherdev_with_old_priv(void *old_priv);
 
-#define rtw_netdev_priv(netdev)					\
-	(((struct rtw_netdev_priv_indicator *)netdev_priv(netdev))->priv)
+static inline struct adapter *rtw_netdev_priv(struct net_device *dev)
+{
+	return (((struct rtw_netdev_priv_indicator *)netdev_priv(dev))->priv);
+}
+
 void rtw_free_netdev(struct net_device *netdev);
 
 #define FUNC_NDEV_FMT "%s(%s)"
-- 
2.26.2

