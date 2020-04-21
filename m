Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF09C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28DBD206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="giZgIw5h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDUViw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:38:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725850AbgDUViv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:38:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED670C0610D5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:38:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so11496wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 14:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WRpu/B/BcLywABR29mrWPu2uoAJ9/VJSM0fTjNe1z1w=;
        b=giZgIw5hopQlDgtKbM9riyJzJFH2CshUYM5a8ilw8GDfxO7fvnRIz35dV6c4S9ZTGP
         g5Zvu4KLohGXerp9aeGi+jbrrm+jCMZabZDXciO4MIoPWXYB1UIij6xYX5Lj6QFU6pmD
         Rly5Uhtv4nF4j/MrhREuxYLanN5W7OTxFyVpoYScAjoeBmjOi+txL/N61zFkYpGlt+BT
         Yv56xufsafyun7YT4Vw61HblXzta/YJsyleo8Zb2aFpaEieWkXXWkO7ESQ+Aw/8iwdr5
         b1e5VJyB6te6AFCfj3dk04MI43HP7HL6vUjIYthqeZrOn2N4Kxz0w5ZOfOYm1i2laqhV
         gd6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WRpu/B/BcLywABR29mrWPu2uoAJ9/VJSM0fTjNe1z1w=;
        b=ESBPiM8mPYJvHjFSSjXl9wYHyEXJMA1kWiWrmfVF93+i2IveqBwj4il7ESYV68Np7l
         ulW9w2iSWaIDSWDjrE+HrZPYxdlSe37zI6GH8007I+YWg1TCeVcAwOQ5YU5OsiP3aFyn
         ICE1SjQQihZ6nKFGkVVzji0z5wiAW0jbd5VpYDYtI4MX2sE0ewuECCy+zdPm6OS7XE3o
         orc9+d18fAM2SRnQO26EVbc4ilmBWwtR23+pRrGoV/HQLVWj5OnSZMrKbLXFJI3ab9VK
         5L3uc73jDgzsq9fxvf9ZpQDoS6hji2wEcbrQbzv9VGwYzfEty7GpuGkVFi4y6VMOYjKQ
         QsYA==
X-Gm-Message-State: AGi0PuZmSX9qpSuLSMNm/rofc7wqeXikELKbsmD9PSibflX+Bp7tsyUV
        4fNqVuCpYCzjyfXsGSvlKPU=
X-Google-Smtp-Source: APiQypI2yjL9CchUqrZhpUBsV1FmNVI/ikALh8gb1VWRhyjQJx8cXksbomADqp9p5yVUDPC1mcfphg==
X-Received: by 2002:adf:f30c:: with SMTP id i12mr27356377wro.426.1587505129723;
        Tue, 21 Apr 2020 14:38:49 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id t17sm5372085wro.2.2020.04.21.14.38.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 14:38:49 -0700 (PDT)
From:   Wei Yang <richard.weiyang@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        tim.c.chen@linux.intel.com, ying.huang@intel.com,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [Patch v2 2/3] mm/swapfile.c: tmp is always smaller than max
Date:   Tue, 21 Apr 2020 21:38:23 +0000
Message-Id: <20200421213824.8099-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200421213824.8099-1-richard.weiyang@gmail.com>
References: <20200421213824.8099-1-richard.weiyang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If tmp is bigger or equal to max, we would jump to new_cluster.

Return true directly.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
---
 mm/swapfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index d203cdc6750a..bc435c2eb916 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -647,7 +647,7 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
 	cluster->next = tmp + 1;
 	*offset = tmp;
 	*scan_base = tmp;
-	return tmp < max;
+	return true;
 }
 
 static void __del_from_avail_list(struct swap_info_struct *p)
-- 
2.23.0

