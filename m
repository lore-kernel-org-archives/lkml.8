Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C77C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F04720768
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 02:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9NsVDnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbgHXCFl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 22:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbgHXCFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 22:05:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DCCC061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:05:40 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id h5so988737plt.6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WogHqAqohDBHZ8SUM7HEIVaDNX8B2UknmY2OcVCsXPE=;
        b=o9NsVDnZyYih3aUpV2+sdu1OBb4z5PNnzSEDumKLwQwCcv6LBTju/dLmzHGF7fQjbn
         uBOlztxu3XhGZRLwTmK7ujQglCUpIBEslwjYyD19exZLl55IFOk7fmTite4bh4hIhYA1
         N84Yr6yy+PvNyAvX5eNh5JI+ZcgaC3isPhn+XtDL5Ege27AbhcJgCFlcFpG5qNIt1wkP
         CKhAQmBbrRR4d5GQ9isIcDTAovrkd8uf4Cx1g2xlEtnFfaKzlxquLhdvfZA68U2dHcZW
         ejPW3N1LItW6EajHqVweQEqQjSqdc3pPM5YkdykZ8ezaycfhcNENvRmp0vbxk+sWk+02
         yGqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WogHqAqohDBHZ8SUM7HEIVaDNX8B2UknmY2OcVCsXPE=;
        b=EW6F8Sg+tlhEVaNRtEXevh6miy6Rv625D2g92fz6z3Z3qUz5eET5pD8idTv0OYuDsw
         YkKMrkCpfD7rCi5qnVq7xFkvS4z1pu1rJKmJGNJOt97FnEcsUDvRjwrp3+C7Lj0Ndn2s
         zA+UyHVuWapZp+tkpydR9GNJboiVHoTIePI2zXvuRD8QmU1VdAJAvgwTJPOC/CWaoajt
         pGv2lqtSLImdHeYsj0h/dRX/Us/ZMqjSxTs8BpbyeAX4aFQwks6Is5k6Ab5dsE7aDOf9
         3CPjemvID5xBI2r6RNDgyVU+lnzSM+2N8K9/cpdrQzaOfaI3lVrt7xp/z/g09sGHKb6y
         Ut8g==
X-Gm-Message-State: AOAM530iKC5NQ+wvGqMuTckyuY5CodXhuq2VHy8GbFytcsm45jK6I1p3
        +QfvZOPofd7ir5vGQNMqm6Q=
X-Google-Smtp-Source: ABdhPJzZgzY6R3x2cwUI4pX/w0pWVj0snEF3TYtFBvqQrRj/8pzlkrNuSBm4bVElg6O310tiiGHl+A==
X-Received: by 2002:a17:90b:1216:: with SMTP id gl22mr2772437pjb.98.1598234740105;
        Sun, 23 Aug 2020 19:05:40 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:578:1a23:7d27:569f:8e65:12c9])
        by smtp.gmail.com with ESMTPSA id p5sm3580854pgm.66.2020.08.23.19.05.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Aug 2020 19:05:39 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     cy_huang@richtek.com, gene_chen@richtek.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: rt4801: Fix W=1 build warning when CONFIG_OF=n
Date:   Mon, 24 Aug 2020 10:05:13 +0800
Message-Id: <1598234713-8532-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Fix below warning when CONFIG_OF=n:

drivers/regulator/rt4801-regulator.c:206:34: warning: unused variable 'rt4801_of_id' [-Wunused-const-variable]
  206 | static const struct of_device_id rt4801_of_id[] = {
      |                                  ^~~~~~~~~~~~

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/regulator/rt4801-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/rt4801-regulator.c b/drivers/regulator/rt4801-regulator.c
index 0ddc670..2055a9c 100644
--- a/drivers/regulator/rt4801-regulator.c
+++ b/drivers/regulator/rt4801-regulator.c
@@ -203,7 +203,7 @@ static int rt4801_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-static const struct of_device_id rt4801_of_id[] = {
+static const struct of_device_id __maybe_unused rt4801_of_id[] = {
 	{ .compatible = "richtek,rt4801", },
 	{ },
 };
-- 
2.7.4

