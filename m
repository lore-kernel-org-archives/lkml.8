Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F08AC28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D16A20731
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UEWj44wa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbgEIKHl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727838AbgEIKHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:07:40 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7168C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 03:07:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t7so1832593plr.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=yGdNVJVc2hx+VBlbsbRaJylSj1Gy2Co11S5g9FSchK8=;
        b=UEWj44wa3MNkFiazKpfDxErjqe7CiPUCjKlCcrUnVcLAASIpzww064vSl5EHG8jvD9
         bbgh6Cf6GdqJS69eNG1n63MeQw8EURn15OhbotG14zc1y7FrtKraUnqG14RrcvkU/pUR
         ZKycFLY+SXGlZeTdeXwpDiHjK/v3bbraw2xihC/eGlKLZMve5H/bJ3NnjLbQypo9pqfF
         su1Qw3eHcQ0NLeNJBOYZqjENhJOnj2XxbLHGjDW0CnZULsNLh3+zrxuDgxuodHl6wINf
         NVgiSwc3VF4XjPPyvh3KGCpDt5fC16bzCil2g3zJ/4YJoE1u3fj5MwE5S+4LEpWyeOqO
         M13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yGdNVJVc2hx+VBlbsbRaJylSj1Gy2Co11S5g9FSchK8=;
        b=mYsyI4wKWQ2BLAx4GwM4xJui2GgCtCAejdvqiIJ26mXv3k08eX4lJ0SU68kuJetgjp
         +Sp6W8vQiUYHtTq9rXTdVTJ/3Uh73uJ34QhRI6pOlbC5pJpiyAZwUwzTv0UX/u413MJI
         HhqL6TK4Fgcbk+TXN4v2n47L+GCf+rIx5g60Z0cbyVLA7Uv88gGHmp5/yfSJuE5cSLaf
         /MrhVEYBysuiRqDuNfody0p8G70LreBj8JqYRtlucflTExUfASbBaKKdiFnHspzk1WKR
         u92xjCkKEkginFuODZz37lxcW3DyADOoqaFg/YXdenlaBLMoT+xAMHk3LZknreasonZw
         aVeQ==
X-Gm-Message-State: AGi0Puat7i06b80lNQianudPY2uXt3uWocjnn+Dvg4vq+FRJlBUAETIj
        h3uAtPZUluNI5zOnC1jgZj8=
X-Google-Smtp-Source: APiQypKncBOHCP9M1qDYMuIz0gWMUBZ9E9kKuIqJHgfxSWuOka2tJKW+iMGPcgL5MLTjEB2xW2XJqw==
X-Received: by 2002:a17:902:cb91:: with SMTP id d17mr6470059ply.129.1589018858189;
        Sat, 09 May 2020 03:07:38 -0700 (PDT)
Received: from localhost.localdomain ([103.240.195.135])
        by smtp.googlemail.com with ESMTPSA id h12sm3321116pgi.5.2020.05.09.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2020 03:07:37 -0700 (PDT)
From:   Harshal Chaudhari <harshalchau04@gmail.com>
To:     derek.kiernan@xilinx.com, dragan.cvetic@xilinx.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, michal.simek@xilinx.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        harshalchau04@gmail.com
Subject: [PATCH] Driver: Adding helper macro for platform_driver boilerplate.
Date:   Sat,  9 May 2020 15:37:16 +0530
Message-Id: <20200509100716.11044-1-harshalchau04@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harshal <harshalchau04@gmail.com>

For simple module that contain a single platform_driver without any additional setup code then ends up being a block
of duplicated boilerplate.

This patch add a new micro, module_platform_driver(), which replace the module_init()/module_exit() registrations
with template functions.

Signed-off-by: harshal chaudhari <harshalchau04@gmail.com>
---
 drivers/misc/xilinx_sdfec.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 71bbaa56bdb5..db16a42c66f4 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1484,25 +1484,7 @@ static struct platform_driver xsdfec_driver = {
 	.remove =  xsdfec_remove,
 };
 
-static int __init xsdfec_init(void)
-{
-	int err;
-
-	err = platform_driver_register(&xsdfec_driver);
-	if (err < 0) {
-		pr_err("%s Unabled to register SDFEC driver", __func__);
-		return err;
-	}
-	return 0;
-}
-
-static void __exit xsdfec_exit(void)
-{
-	platform_driver_unregister(&xsdfec_driver);
-}
-
-module_init(xsdfec_init);
-module_exit(xsdfec_exit);
+module_platform_driver(xsdfec_driver);
 
 MODULE_AUTHOR("Xilinx, Inc");
 MODULE_DESCRIPTION("Xilinx SD-FEC16 Driver");
-- 
2.17.1

