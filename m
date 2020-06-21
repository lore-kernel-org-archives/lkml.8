Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339D4C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAF4251EB
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ErEO+RIp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgFUPdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 11:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729536AbgFUPdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 11:33:36 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10745C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 08:33:36 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g1so11560175edv.6
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 08:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PeMfzitkzdqhrYDeNronyrWoLbHeiStRwmrWd9l9Kxk=;
        b=ErEO+RIp0rdVJ0AYe3zK1smO5nhyZfJCYn1Y5scY7R1m6CQ11Riur06PHoeD/PwLjH
         SKT3oQWEjuSY9+bmoc8vOZqTyJiYm4iFS/0NjiNtK6/H0S6YBNA7Ow5bwNJcdZloqrei
         upz7Jh7EOJwsGQRgZI0dXKIAFOZniAPCi1HajsX+xF49MSqJHYRJXlxLX7SRuVcBmzKP
         RlY9hlbWs1u7Sn4qMrdBOeU7uiwFNZ8SUn4qGoZ9JsPfYWaUugOgWCRI+LPnapZPYaA8
         rn/x/RxnibBx6OmAOcyPaVj9Lfv8i6BgtX7fWIOjHbihSALfHBojCWOe/a3F6i4LUs/I
         Ybfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PeMfzitkzdqhrYDeNronyrWoLbHeiStRwmrWd9l9Kxk=;
        b=kwE3BNQHmFk+TvXIvjeHiCZPD68AmfSiY90FpQ+I9NJRMRw9YNYRUJWHQ8IDPoaQl9
         YfSW+FoNvzt9jSP+VzHtTUdnL1rm/UvRR27zwbyIiwIigKIZ5Zxa6BBjttBCXtuySZFE
         kt5oyFEtv5ECZ4CkHAvRfbWrH3dp63qq+z/7nCtvbGfHHKz9VYE01gbWOQ2KImXuWu9V
         E5K1CtsQOGAIGayOi/+l3SEBnHF2aCWSKdzOawvlKFUYkjDZd3ub46AnCXkUSD8xRA0Q
         0iAEY6MmU01RxgNtEkmz5XC/U4u2VvqfrVwWFU/zIVvC+60QNkRK9b38notZrJwFUvdG
         9oMQ==
X-Gm-Message-State: AOAM532QzHWl71FBF2osHIMjeAkFTKBgDf2I2c5dlB6+46+UwP/cxEpN
        rb8yXAD5NiefEMpAgZ/5hC4=
X-Google-Smtp-Source: ABdhPJwEWBm4Mwoyho5u1fAQQ0gotKzL52V1aBn95v5+w/BaXkt5Uovx0TkCzWoJ31D7WjTPj2Xt7g==
X-Received: by 2002:aa7:c756:: with SMTP id c22mr13090502eds.239.1592753614814;
        Sun, 21 Jun 2020 08:33:34 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:c981:717d:11f2:31a3])
        by smtp.gmail.com with ESMTPSA id d16sm1626031ejo.31.2020.06.21.08.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2020 08:33:34 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] doc: update URL for sparse's tarballs
Date:   Sun, 21 Jun 2020 17:33:30 +0200
Message-Id: <20200621153330.54480-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The URL given to get sparse's tarballs is sparse.wiki.kernel.org
but the wiki will is deprecated in favor of sparse.docs.kernel.org.

So, update this URL to the one where the tarballs can directly
be found.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 Documentation/dev-tools/sparse.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index 6f4870528226..8a7055593c31 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -73,8 +73,8 @@ sparse would otherwise report a context imbalance.
 Getting sparse
 --------------
 
-You can get latest released versions from the Sparse homepage at
-https://sparse.wiki.kernel.org/index.php/Main_Page
+You can get tarballs of the latest released versions from:
+https://www.kernel.org/pub/software/devel/sparse/dist/
 
 Alternatively, you can get snapshots of the latest development version
 of sparse using git to clone::
-- 
2.27.0

