Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EFEC55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6896D2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 14:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="YX0s7fuF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgDXOCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 10:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728373AbgDXOCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 10:02:32 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CDFC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:31 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id v4so10087366wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 07:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GgwWsZ4vgrBdNIRZyns63cVZRVYxjzfpG44UZZ9qy6E=;
        b=YX0s7fuFCeROk9+L/v2tc9yPVKqpascgymijanpp09t/IXJcmPZJ2QYlDN5czz/cMS
         dr3TeEFVa9AYAmBnpEXym1QDalz4u/MSSCiVrE4pXZMaQip8cl58WfxEzYD+L9iMh9Ze
         f3hNHaaYlAuTvj4HmWnpz/ONiBYfWjaeABkjTLNuVSdZQReHcW/QtOXz6oTx4oo2lGIm
         mZwfkc3RtDw2Ob3vmgOz9ZuIZe+SYNgIlgcq5nOFc/IDwGkp+ybfMHpW8Pu67SdKSXgz
         LFkVhgNOLzSvWemLoYh+sgVKXwfWdoL7rm7bHmijjWDJ49OQFvLr2ORlF3PK0DLQoVmT
         dS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GgwWsZ4vgrBdNIRZyns63cVZRVYxjzfpG44UZZ9qy6E=;
        b=QPW6QBD8DygWVFkmp/yDBcYLuabe0z17EOSxv1F6muFdklB5kOxYpvq0O0KqTjqv+h
         mmaJwH1i5UoTlRToxlyav6tDoibZb3r6ZqwwL12wzyESNQy/S7gacWNooGhwHj84LHiS
         BGVCVmsGZSdAs6ycNSYCNBCeJfopWDBKkzqp5l2vDoAh+BV2SbU7GYcLdJClRwidXV9Z
         pV074MoeR+ikgVrPXTmNt7sfQxiBCOw1U3Yvq8MxHzxhie5RT+PpMKmh0mzX/pCYtYmi
         5FpMGEW5Ggfo3OYj5FM0NoU/kHkgfu55VRuMSSMZvh8EIw7HlrUP1JPO9K+qZ/Scd2N4
         2llA==
X-Gm-Message-State: AGi0PuZk90joL6DUYu+dZCn5hPbHonpHdZoCkZ2vy5JwryOgG1rHUba4
        ncP7cP+M3RffWLaUOMsvm3iZ4Q==
X-Google-Smtp-Source: APiQypKkF+NWOiJmhHGVefUk5gxkUhwlUoi+oxIfJGzQH5xF7sni+mtz2LtfdT125vB2yLUbciEcxA==
X-Received: by 2002:a1c:2846:: with SMTP id o67mr9817667wmo.23.1587736950447;
        Fri, 24 Apr 2020 07:02:30 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id v131sm3061051wmb.19.2020.04.24.07.02.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 07:02:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v2 04/14] crypto: sun8i-ss: fix a trivial typo
Date:   Fri, 24 Apr 2020 14:02:04 +0000
Message-Id: <1587736934-22801-5-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
References: <1587736934-22801-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a trivial typo.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
index 350a611b0b9e..056fcdd14201 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss.h
@@ -100,7 +100,7 @@ struct ss_clock {
  * @alg_hash:	list of supported hashes. for each SS_ID_ this will give the
  *              corresponding SS_ALG_XXX value
  * @op_mode:	list of supported block modes
- * @ss_clks!	list of clock needed by this variant
+ * @ss_clks:	list of clock needed by this variant
  */
 struct ss_variant {
 	char alg_cipher[SS_ID_CIPHER_MAX];
-- 
2.26.2

