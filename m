Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826BC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0F2206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:59:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcfdA6dC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgHOV7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728898AbgHOVvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:43 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E817C02B8E9;
        Sat, 15 Aug 2020 04:57:40 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id cq28so8738336edb.10;
        Sat, 15 Aug 2020 04:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=e5WFLhWdFvLwcJo4KJClLZEF3HzHgvxjJKIXosYGPF4=;
        b=PcfdA6dCXp/NZfoSZ2qnOycj1qJUi1htbO1eEEq90NaS1ZBNtqKKvp1yvvCT6cR1PI
         b1AyVQY7O8k4eEUHuydvkugG0tJUjhwA2fvz5I9l6Lx++TMWojg2bObnsk5CR0wP9FiX
         63gXciEy2Il0KmD4LFadcrKozWgYmQsQkEMWhWPX69t3mZKVxM33h3KAbNMYJEC4h5DC
         BYe+jTdevJIvd1kD+Pfq3i8+gV9w2fbrYIVGWU6HZy8uYn2OaJ1xhDfFMVENqtOO7KEx
         idE//vhd2D03izVfJla8QsRJsDuR0yb3IWaKmztSqs4ijrmlYeATzNHgbiQnXG8jlBLA
         gnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=e5WFLhWdFvLwcJo4KJClLZEF3HzHgvxjJKIXosYGPF4=;
        b=rgAADB7dVpXGFcMOJefsjrLybXJAT5hWJS/IFoPdxlRssp8Tmj1r+AC0raC+CecvG8
         3PcKHyytFz+5ofo436s+/O3hu3BnjMSGWXiudHvILQYJYVb6hLHNjJSXSAGUSjubJFmQ
         asshmJxyMfgPRdOs4Q3pmViwb0TwvzK/rD36+jnSyeeP8p2DvokRvoYlkI1tv0HsODst
         y0NOClcbLp88h5Cz/McLTzHkmC0GtYfR1ZQa4knGHyWxYs5y3WudF03RNf2eCJkVEvck
         g5pesB26P0Ge+w2ZV9PF+vR2WTJkla37V2wjDMiLEFlGV7eEXRDkIfv6HoJfWyEPxoaH
         7OlA==
X-Gm-Message-State: AOAM533lJA9TsxKOYGxgGxSTeemDabiC+aqs3XBJpnbqWfA3mBcA7Xw0
        fiU0zXUxz8rWm/ECopPb9ZY=
X-Google-Smtp-Source: ABdhPJx3wb69o+9Gns8Ea5rU+G4bqnaPXWRFFoT1SHfqA0FUCsdviXL44mSynODzetlPyjAiXO2OyQ==
X-Received: by 2002:a50:b701:: with SMTP id g1mr6878915ede.197.1597492657686;
        Sat, 15 Aug 2020 04:57:37 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2d69:b900:61e5:2d94:8d77:6e0f])
        by smtp.gmail.com with ESMTPSA id v13sm9184110ejq.59.2020.08.15.04.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 04:57:37 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] Documentation: add riscv entry in list of existing profiles
Date:   Sat, 15 Aug 2020 13:57:28 +0200
Message-Id: <20200815115728.15128-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As long as there are only a few maintainer entry profiles, i.e., three
in v5.8, continue to maintain a complete a list of entries in the
maintainer handbook.

Complete the list by adding the RISC-V ARCHITECTURE maintainer entry
profile found in MAINTAINERS.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on docs-next

Dan, please ack.
Jonathan, please pick this patch.

 Documentation/maintainer/maintainer-entry-profile.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/maintainer/maintainer-entry-profile.rst b/Documentation/maintainer/maintainer-entry-profile.rst
index 227f427118e8..b7a627d6c97d 100644
--- a/Documentation/maintainer/maintainer-entry-profile.rst
+++ b/Documentation/maintainer/maintainer-entry-profile.rst
@@ -101,3 +101,4 @@ to do something different in the near future.
 
    ../doc-guide/maintainer-profile
    ../nvdimm/maintainer-entry-profile
+   ../riscv/patch-acceptance
-- 
2.17.1

