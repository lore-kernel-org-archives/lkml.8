Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847E5C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61312206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 12:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="UsN7wtHW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgD1Mu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 08:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726620AbgD1Muu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 08:50:50 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE35C03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:50:49 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id h4so2614362wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 05:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8anzHF+dcSSxDMelqgrQkASv+bLpdKTF9+EFoyjXFfw=;
        b=UsN7wtHWwKfyL1O8DH1Sq3V3gztXpybUf4qG/ArSdLZDTdOJnV/OSfcBsiV7uoWAf9
         GGQAMrwsmsFiBOvUwHCbgHFSIbRaHRb0TJfq7IBYy/Fdd1pP1fvOlEaboSAqZ5Yu2m6l
         mTUQ9BwbHNFEvkVOenRDXWZmrBNeFLH0EI1h0isQbYqHuDi+llKondq+RcHPmur9IbrN
         SbS1dvkN2rJNgd2G1amWbvc8w0s+EEsjgAL+jAlHjROjuXALLTBlu15anIrLEFTTYKBQ
         ldQbNJnXQN1tjE8avdQ7tvbBoeF7W+j5O59HrEkFmFlAB34VLGVkPJFk49s8O7kjuU8w
         ZFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8anzHF+dcSSxDMelqgrQkASv+bLpdKTF9+EFoyjXFfw=;
        b=OfAHM8nNlzpt8BbJdY7sLHpcjgTECiM9IdGO6Um/oVNyRb0RBFxa9KD5lcdizharmb
         orWlzCkNcl8VfQcxTXhBHcgOIVnpamGQIjSoi4o4xn1EUqBcFdgRbyqJtTyuiiM3ynrg
         t6of/3AePYpfn/RNFLp2IctKGet3bIly83OpAItZBR5Bm/prak1g6J5nUiLQ38s1faPP
         1E4m7xCRcUjNRlVkvITkl6+PcccvLWaqo4U1wLXv9zq/dgYv/u03+ncl9qF8hOuikpQN
         Gr7mAi+WYcn3B859tPQnh07AObdN005dvlhdPURUbVPGlFmJ9cbCqns92m06E/bZ3o88
         QaiA==
X-Gm-Message-State: AGi0PuZ2i/Imk3O6uCU9bMvuVpWslZapfjQYAimicc+2cU6T4bghUHTU
        AWOA8pW9ngADDWlDW+IcKJnbkA==
X-Google-Smtp-Source: APiQypL2YZ2MBbSoNvS5Iov1MdtpqzDWil3z2ABheuAvBMkWKWYpV0eo2905q8DEJG+ftCWJ8Pd7+A==
X-Received: by 2002:a7b:c4c9:: with SMTP id g9mr4367301wmk.171.1588078248287;
        Tue, 28 Apr 2020 05:50:48 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e35:2ec0:82b0:4460:3fd3:382:4a71])
        by smtp.gmail.com with ESMTPSA id q184sm3246115wma.25.2020.04.28.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2020 05:50:47 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 3/3] MAINTAINERS: update the Amlogic VDEC driver maintainer entry
Date:   Tue, 28 Apr 2020 14:50:36 +0200
Message-Id: <20200428125036.9401-4-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200428125036.9401-1-narmstrong@baylibre.com>
References: <20200428125036.9401-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as co-maintainer of the Amlogic VDEC driver, and add the
missing vdec DT yaml bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d633a131dcd7..0c183f02d7fa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11009,10 +11009,12 @@ F:	drivers/mtd/nand/raw/meson_*
 
 MESON VIDEO DECODER DRIVER FOR AMLOGIC SOCS
 M:	Maxime Jourdan <mjourdan@baylibre.com>
+M:	Neil Armstrong <narmstrong@baylibre.com>
 L:	linux-media@vger.kernel.org
 L:	linux-amlogic@lists.infradead.org
 S:	Supported
 T:	git git://linuxtv.org/media_tree.git
+F:	Documentation/devicetree/bindings/media/amlogic,gx-vdec.yaml
 F:	drivers/staging/media/meson/vdec/
 
 METHODE UDPU SUPPORT
-- 
2.22.0

