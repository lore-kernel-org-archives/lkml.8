Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C6BC433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D9E62072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 16:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uqiEiQcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHBQUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 12:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgHBQUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 12:20:06 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEB3C06174A;
        Sun,  2 Aug 2020 09:20:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so31977402wrj.13;
        Sun, 02 Aug 2020 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4OQ/PelrCaLecz+CfF4+bB2gb2hH8VFrvo4a03w3HA8=;
        b=uqiEiQcpXcLwPW3xlaLHFgSEZThuQViLLC3MwUBw3F8xtV2m+vIdHRe0/EsHVJjuDI
         TxJrtjY42u9GL8wL05UVCzSrEwttevPdBZuJsNW1GZ3oPo1e8cNjRmNxTSeQjs8k+UGT
         RUKUUHhQNg5+U5adjsdeae/2KvGg+1rcRWT1axd5qgv+NhiCPUOApKIdpNl/+D1jpnMy
         eTR3He5YAkW5vfBFM81+xGc606Lttz435RhAC6sVdSFIlyPUu5X98GZsX+PHreAfET7K
         DUlq+A67syD5LgOmZSoH/s4mUaNyjqYnEkcWrG+ln+AfWm+GnndHNYWmf9ZGvBr1TU0l
         W4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4OQ/PelrCaLecz+CfF4+bB2gb2hH8VFrvo4a03w3HA8=;
        b=ChjyWTONU+NzXMnNMhBkszgWi/rCXTZXEVE7r+q4PeBPbX8Al13GC49x2Re60qlU/P
         bU19B+x2ug/HBe0wN6poVa5J7KP60mTnXtTVJNZYaMHWU8p+emxiTPtFoKPHWDoLLjQO
         qeA6rvFLpV9oGt6ZX1vXqx4hlsWy0qeKeqTgGJ7LBKKUhsNKWnJsKFhuxKMuUOMwkY1a
         iU3kHKeKJx2OQWYH/DnIl7uJlU3L7xt1KBD4UC7+eWBje0OnvrOy3/eZo6y9b9VsXvTx
         Vs23k+debXqXw2pPwnQdmji40mRcAc/GAdxroHOlG2JbqVfCsZqxaiyXZAvAS2dfBdPu
         ucaA==
X-Gm-Message-State: AOAM5306tGl6FIJ5afhDYdxz6Qo4UMiGoDRg7wLwtbmvVZ9XEXLzUxbq
        SLFyNoTzFYc2QY8noo8B0ew=
X-Google-Smtp-Source: ABdhPJx6nOiOkR1PATijfL1SWXhD/Pp8EJDXAX4J28P0BCrqBzjgJxA9FiyuEpAOzmy3IlFGBYzAZA==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr11006779wru.22.1596385205261;
        Sun, 02 Aug 2020 09:20:05 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2dd3:b900:5cb6:49ea:83a1:88c])
        by smtp.gmail.com with ESMTPSA id j11sm19417868wrq.69.2020.08.02.09.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 09:20:04 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Cc:     Harry Wei <harryxiyou@gmail.com>, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] doc/zh_CN: resolve undefined label warning in admin-guide index
Date:   Sun,  2 Aug 2020 18:19:56 +0200
Message-Id: <20200802161956.18268-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation generation warns:

  Documentation/translations/zh_CN/admin-guide/index.rst:3:
  WARNING: undefined label: documentation/admin-guide/index.rst

Use doc reference for .rst files to resolve the warning.

Fixes: 37a607cf2318 ("doc/zh_CN: add admin-guide index")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Alex, please ack.

Jonathan, please pick this quick minor warning fix.

applies on your docs-next and next-20200731

 Documentation/translations/zh_CN/admin-guide/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index 7d502fa5da64..ed5ab7e37f38 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -1,6 +1,6 @@
 .. include:: ../disclaimer-zh_CN.rst
 
-:Original: :ref:`Documentation/admin-guide/index.rst`
+:Original: :doc:`../../../admin-guide/index`
 :Translator: Alex Shi <alex.shi@linux.alibaba.com>
 
 
-- 
2.17.1

