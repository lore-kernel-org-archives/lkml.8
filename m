Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 391F4C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1599220736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DclZqP1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbgDXNk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726791AbgDXNk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:40:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37BC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v8so10048773wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 06:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=GPoYxjPQJeip0JY6dC/Z+tdRqn3HmDM6rWV8IieyY+A=;
        b=DclZqP1nBgwnwaWujytr+grZrUIRe1mOlxB7bxdQuubvIYL9uj6LNMftM09hxisS65
         hFu1gsG6DL3SeFlaKDZc3be7IcXXdsADqZGV5cqkXf6BPP4H5mCKyYLQbYnCCYXdo6eh
         qsE0zy2fkvDpLg06f+gUK6LrI7gj8rjwMS88AMucf3pUVooq9COi+f6yJvNuyr7dpIkD
         EeN8VLV4VJzrlf0dfkosm8NIZaAElUazGC2l+T8DO6zAkocafmqQ19LXqrAPzGRrCsST
         rSDPCiMxCf8ugITbprguwm5eo8Yp6dGPYQnpK4BJzey33Zi7RZaGaypM6w32DKdjUOut
         tGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=GPoYxjPQJeip0JY6dC/Z+tdRqn3HmDM6rWV8IieyY+A=;
        b=aZ/P0ZAkW1DwPlpjjuU+b8nu036pBSCHKrnpZJSbYAYSfTLOXIOrrVcmU7b1/Bd07M
         RtTXrJ83Eq9wkKy/mycAtXWpAD2yhnGBty7enJShRG6qgeH+0EYm620m73GCcMgBtrzD
         flE/+eg1LS5S3gaeWjWegKPm4QovXCoK79Rcz/uNdkusdwqUkt1NIlI09bPp3VqJWcYg
         yjuLsJeJ5K673jL6AHukl3WKlqaJOM1QYa3aMx95GG5YMKG75C94zmoK/8LdmpYK6iRD
         NJxBwo3C9eHo/QlSC5jUtgBhXbvAwCPLN9HQr5bYh5oIdGRUov6gCVnjDT0/hP5aIG1f
         yf7g==
X-Gm-Message-State: AGi0PuZvMXWizIg0xO2wZ4skNhCKwdi2YKv5No8GO92p0fEfcmCmwLZu
        KvBhxjr0JXK96YnajJlnvo22nw==
X-Google-Smtp-Source: APiQypIdm0KpOWeemwS8yb3q6Yc3Dh4OeIMPcVa87g+33lJmUYbB5UGec6DQTmNZeXFdNicMsMprLQ==
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr9765293wmd.164.1587735654829;
        Fri, 24 Apr 2020 06:40:54 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id 185sm3408958wmc.32.2020.04.24.06.40.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Apr 2020 06:40:54 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 0/3] crypto: fix some DRBG Kconfig deps
Date:   Fri, 24 Apr 2020 13:40:44 +0000
Message-Id: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

Fix serie try to fix some DRBG depencies in Kconfig

Change since v2:
- added patch #2

Changes since v1:
- Updated commit message with recursive dependency

Corentin Labbe (3):
  crypto: drbg: DRBG should select SHA512
  crypto: CRYPTO_CTR no longer need CRYPTO_SEQIV
  crypto: drbg: DRBG_CTR should select CTR

 crypto/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.26.2

