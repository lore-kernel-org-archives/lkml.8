Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AAF6C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:46:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F8462086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 17:46:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H1WcuDnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgBCRqX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 12:46:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45143 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728310AbgBCRqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 12:46:23 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so6125491pls.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 09:46:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xENcotWf0NIW1ly2//BU4P4ZFK4hDNi75Zy2BQOmcDU=;
        b=H1WcuDnh+JN8HHlm3GZBB9NyejUPzOQ1/TvcmuXgj/JcGwFc3n0+yHArce8tQkQzLz
         8mlStXBr2dkSKj6iHjDgZ/V3Ow5ARicfKHILxRlQgRt7384zxbNbWvXA10AUX9ort3qj
         lz1YHTPPl8Vf3byIJL7rxyjz4PSW09hUNChEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xENcotWf0NIW1ly2//BU4P4ZFK4hDNi75Zy2BQOmcDU=;
        b=pjEpphtXnkItfu4dezMemf9/53t7YLpnPgQDxTnHgDvkqFu+fzpe7KNLzPDKsgd7LT
         V3W7O4sEyZCW2Su7v9DuXA9opmaDFkZl8iUjRCQgYvOy8ZOxB6fVseQEiBsPY0TvYshx
         XyFM6dMR7JuhejCwQHQIRv6BiJyQWe2cVC8QkjimW5DnA3DAcLALDWuruKLGuPWWYt5s
         4fqSzK859//g2r788ZcpHFY3IwAM9xotqM1fsAhMvEB3Swns+V3ZTjsfxHwmVWWVpEwR
         nFM6Ccecnm3DN4UFPJMkePv37VvpfXZkDFOcJxshTKat1r0EiDsS1hl1CYTSlMpyJuyg
         cobA==
X-Gm-Message-State: APjAAAUqYz9kLBN/Ltg7fxDbywX5IJCABhhQyBaAAg+7d5sfOmo6FBhP
        LI2Tfd6DR1qRevtXMtaJmje12A==
X-Google-Smtp-Source: APXvYqw2Wq0SGlVzuhOU2cE4lO7aTCrXLevbnSn+qxouCnfjef8iLErVB6ZxfoyF9iGgsBEfuYp7/w==
X-Received: by 2002:a17:902:9a82:: with SMTP id w2mr13643600plp.117.1580751981240;
        Mon, 03 Feb 2020 09:46:21 -0800 (PST)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f127sm21420404pfa.112.2020.02.03.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 09:46:20 -0800 (PST)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Nick Crews <ncrews@chromium.org>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH] platform/chrome: wilco_ec: Include asm/unaligned instead of linux/ path
Date:   Mon,  3 Feb 2020 09:46:19 -0800
Message-Id: <20200203174619.68861-1-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that we shouldn't try to include the include/linux/ path to
unaligned functions. Just include asm/unaligned.h instead so that we
don't run into compilation warnings like below.

   In file included from drivers/platform/chrome/wilco_ec/properties.c:8:0:
   include/linux/unaligned/le_memmove.h:7:19: error: redefinition of 'get_unaligned_le16'
    static inline u16 get_unaligned_le16(const void *p)
                      ^~~~~~~~~~~~~~~~~~
   In file included from arch/ia64/include/asm/unaligned.h:5:0,
                    from arch/ia64/include/asm/io.h:23,
                    from arch/ia64/include/asm/smp.h:21,
                    from include/linux/smp.h:68,
                    from include/linux/percpu.h:7,
                    from include/linux/arch_topology.h:9,
                    from include/linux/topology.h:30,
                    from include/linux/gfp.h:9,
                    from include/linux/xarray.h:14,
                    from include/linux/radix-tree.h:18,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/device.h:16,
                    from include/linux/platform_data/wilco-ec.h:11,
                    from drivers/platform/chrome/wilco_ec/properties.c:6:
   include/linux/unaligned/le_struct.h:7:19: note: previous definition of 'get_unaligned_le16' was here
    static inline u16 get_unaligned_le16(const void *p)
                      ^~~~~~~~~~~~~~~~~~
Reported-by: kbuild test robot <lkp@intel.com>
Fixes: 60fb8a8e93ca ("platform/chrome: wilco_ec: Allow wilco to be compiled in COMPILE_TEST")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/platform/chrome/wilco_ec/properties.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/wilco_ec/properties.c b/drivers/platform/chrome/wilco_ec/properties.c
index e69682c95ea2..62f27610dd33 100644
--- a/drivers/platform/chrome/wilco_ec/properties.c
+++ b/drivers/platform/chrome/wilco_ec/properties.c
@@ -5,7 +5,7 @@
 
 #include <linux/platform_data/wilco-ec.h>
 #include <linux/string.h>
-#include <linux/unaligned/le_memmove.h>
+#include <asm/unaligned.h>
 
 /* Operation code; what the EC should do with the property */
 enum ec_property_op {
-- 
Sent by a computer, using git, on the internet

