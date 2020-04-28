Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D417DC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABD5F206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Of8nBJdk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgD1Mup (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1Mup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:50:45 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B8AC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:50:44 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id v8so2302359wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ivk8pUd5yw65/sV/AvpRxYKjBbQZM0SLzoY/9d09xk4=;
        b=Of8nBJdkQzrZsQ93VmweFQ2f0VW0tkBt7Arl73GPj7BJQBd1pGk3DpmZi+VE6ZKCHX
         mlvXb5C9ntOqyF7vCz8Kc9H+FPam1W15Q+oJeHHfeWouz6oG5S6UayP8QY2GQdPUI0My
         hCPus1kjcwzWMS6LHSUO8Wog5xotwmZfF1Rk01Vh41vN9/i9ZUSamwG/DgN4RGiguFnJ
         CL8/TmhN+X02+qkqcOoIiXhiT7DosmretDlc6iCO+pUDDyq8V7kpnzS97PK51gjcfusD
         ErWaiqPmUu5q3PfIhGwF/jg7w8G5VKmMGWvjKaRiugDR4+f7SzGsiWgqBo6832Lb49Tz
         cGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ivk8pUd5yw65/sV/AvpRxYKjBbQZM0SLzoY/9d09xk4=;
        b=JBK2yx0/kD3Tl0IxlWhY9nVuxJCdYNUt6Mi85Xdbf0wHfwhDnh4cz0Wgw2iWHsfKJD
         6jN8aJg60AsYFwEiNMhNFnJ5ElpF/762xvA0DIRUhQKUURDmm2CnAAaLXKBbeuwO1VnZ
         yzz/zQOKoOb/FMh26WsFGPSF352wGlR0y7FtBTshlDqMOt+r3UFhCnhFve958kZcyDfm
         8zr47CBKH06JQFWBuYEC6DGqBINCTTnCeCx3q/DjjFw/DHDlmgm3XxR07D3aAwigfKtg
         PZhPiWmVk9DllrI/1bkaOxA0q51DbD/eGS5RWlZ8ad8zoqEzcMaJf1mR0/E+DtnEh/xW
         tNcA==
X-Gm-Message-State: AGi0PuZnIMOe94MfEIFSyUdxmZwvYrv1jVe7duow7V6lRZbUXCHK3tpR
        I8w9+8ZkyqcGCQThrRYfCGE5pA==
X-Google-Smtp-Source: APiQypJD/8l1OOW0+VgnggdRlxU6EJlqkaxBVKVmSTJRZwFIqdX2QpB1vmlCqT7Ad90mXIEuv/apuA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr4652138wme.126.1588078243182;
        Tue, 28 Apr 2020 05:50:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id q184sm3246115wma.25.2020.04.28.05.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:50:42 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 0/3] meson: vdec: vp9 & MAINTAINERS fixes
Date:   Tue, 28 Apr 2020 14:50:33 +0200
Message-Id: <20200428125036.9401-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This serie fixes VP9 decoding :
- enables the motion compensation reference cache controller
- fixes buffer shortage on VP9 decoding

And update the MAINTAINERS entry to add myself ad co-maintainer and
add the missing yaml DT bindings.

Maxime Jourdan (2):
  media: meson: vdec: enable mcrcc for VP9
  media: meson: vdec: fix another case of VP9 buffer shortage

Neil Armstrong (1):
  MAINTAINERS: update the Amlogic VDEC driver maintainer entry

 MAINTAINERS                                  |  2 +
 drivers/staging/media/meson/vdec/codec_vp9.c | 72 ++++++++++++++++----
 drivers/staging/media/meson/vdec/esparser.c  | 24 +++----
 3 files changed, 71 insertions(+), 27 deletions(-)

-- 
2.22.0

