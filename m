Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CC9C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6975D20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ADkPnr9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgDXNlH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727083AbgDXNk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:40:59 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D9C5C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:58 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id s10so10885756wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ndmpq96aa384Sl37ToPJaNdgDlf/x8LYEzQhHaZaot8=;
        b=ADkPnr9yiaJF6N83Qi1UawN9bUOTC2Lz/MtEbZn5OOZx/E5srl3KrUk2E27M/S2X4r
         U1eeGYQLhrcy++Mk8dVDU98gGWuwX0FrxKaeRuzRQYoexv3d2HB1sScZ3lMTK8k+uxR7
         SnkeUasvRakQ1tu2bREUrO8DV6761/6cnQYh5vTiQ+QrZ57zSXb+rwbzqS2tnRORzxI3
         EJGcPmAcEl/wDCAeDX+1PSnhr2yPh/U8tLNgst4aOKqOpfHU5fpuNOtFjZsSIIAuzVy7
         56vs+RbGY7D0CMMyXQmAJSoPpYhpNXhGPea3ipagCNecPElxA5TMVfb1f+7AzTn7m1GH
         ijaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ndmpq96aa384Sl37ToPJaNdgDlf/x8LYEzQhHaZaot8=;
        b=Hx5lXlGwJbjmjBvCjE0zTXkfQ0rmWQTNnNKkbjZJ50NeGp5nruYd1/NymlZ3HOQIOv
         C2Oh0VWL44EmvebSa6+H8eqmYChaf01T7YmQfYDI2NZit/yQS7j/z70QV1IQExXKRAkC
         NkWHVEhiU+s2ReFottIVYSTDKX/LzkOhOlw0eIFutYYacpGHbI8sn1kztwg1y7DX9xVv
         HRfJJDUj5MvWDxhKnHdr+UT98X2xJsLl1Jvg/H5ZrOKNCL3snl1bFf2izIEATjs/JSDE
         uItb/eLgXdpe9Kz1eP4cRWtvU/aZqS7X9sCggUuTqQME+wNmAQWQ4f+d3Hrz800iDFFY
         /dig==
X-Gm-Message-State: AGi0PuahfwR/YKtn15telNw38T0mNmnF5QjjWqvdvXi2v0oa7oHgEQS1
        agu2APIIr5WmBpFVIdoAGtpsgQ==
X-Google-Smtp-Source: APiQypIM3oR2zdqBn4FAYYq15nUy0OKbqAG2Qu+Xz4Qva4HgoEXlu8D3GkIfWKWMwxq1IUmnin2vMQ==
X-Received: by 2002:adf:83c2:: with SMTP id 60mr11023887wre.169.1587735657134;
        Fri, 24 Apr 2020 06:40:57 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 185sm3408958wmc.32.2020.04.24.06.40.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:40:56 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 2/3] crypto: CRYPTO_CTR no longer need CRYPTO_SEQIV
Date:   Fri, 24 Apr 2020 13:40:46 +0000
Message-Id: <1587735647-17718-3-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
References: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As comment of the v2, Herbert said: "The SEQIV select from CTR is historical
and no longer necessary."

So let's get rid of it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 crypto/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 6d27fc6a7bf5..a5936e967fe2 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -370,7 +370,6 @@ config CRYPTO_CFB
 config CRYPTO_CTR
 	tristate "CTR support"
 	select CRYPTO_SKCIPHER
-	select CRYPTO_SEQIV
 	select CRYPTO_MANAGER
 	help
 	  CTR: Counter mode
-- 
2.26.2

