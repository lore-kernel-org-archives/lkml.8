Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F5C8C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 541F32080D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="RCPqZHOT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgFNDdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:33:54 -0400
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:44134 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbgFNDdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:33:53 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 49l0S10FCHz9vJs7
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:33:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nYz6heOXR9pF for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:33:52 -0500 (CDT)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 49l0S05j5Bz9vJrG
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:33:52 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p7.oit.umn.edu 49l0S05j5Bz9vJrG
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p7.oit.umn.edu 49l0S05j5Bz9vJrG
Received: by mail-il1-f199.google.com with SMTP id k63so6961342ilg.17
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=XJ6IMqjGiHhE6cmEbhidHkelmuGZ0N00fySDcl0BZ0Y=;
        b=RCPqZHOTlWV3l7+1oiYCxljpHmbk3Vk2FFESqIGIuZYEKlFcK7H5LrOb23XIzkcQeZ
         WhM1b5WXU6vzr/g+HtvHM472+dxGp6yLvE/3q58mlhvXk3Aflwnhf0aiKXqQEXszg+oW
         X1aKtOp9qoZD5YMEP+Ea47OrYOM/9X6v68pZfo3sNZyhxVKG2CQ2Klf2L5161j8c6fj4
         Qres46gtzoPMvxS/4lGvKcU53HeXhUSW9wZjtIZSNw/XLpkZOjhFuN4+eLFlnLgo68pj
         MoAsFtlisAtqLggUlmwL9fRYb2uBWUyV7froQVfnLzzFLNe2I6oAUj0YePngSworYW+O
         O7zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=XJ6IMqjGiHhE6cmEbhidHkelmuGZ0N00fySDcl0BZ0Y=;
        b=GG8bwEsKsiOO5DbnmvmMv2pSNi9xyk38FE0kYcSRQkASr18Jyhoj7GAGpc1g0veh/I
         X9pIyi/CVge78fwCbJi4Kp1GqB8Fh1ZacsWrfJVSGFopPCkErDQIb+Sjl+p+Ulv2giAh
         m3eYt6nc96z5JmQcSAN5y3ioHj6Smge7mD0jMOecFHcTbfoagTQmgq0kUFBT9Jpy4o7C
         2CcQX3EpNNLPW3WyfONDBagPRlgOC0P9YfuvaNuLnyXstfZ4c5/K72zNXBCx4JD8xsCL
         TIho8sB7ths8VZz8urmvVJa71ohGeispS0cSNzsQ6Shoj5ZsE4uiVQcEJCIrWeh1X1AD
         UzNw==
X-Gm-Message-State: AOAM530IQ6mUKCDCBpCTrgdzDAUpKeLjuPlip24qivg/Wl2DbEs7W3Hw
        VOJtYskdxQJnTHGOKOnlWz0I/1+0/lT02iKzmlB2XVjCznxibtPtZKmqR5m9d691bve/46E7gyJ
        WYTuaMoxhm3/E8hpj/lwPY4Ca7ZP5
X-Received: by 2002:a05:6602:2e05:: with SMTP id o5mr21472143iow.28.1592105632397;
        Sat, 13 Jun 2020 20:33:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyQxM25g4plSaC+vGKbkygobkILoafY5rQEhoKV/Z8/cZP1AgGP3MWxJz/Yj++R/EZwGS9KQ==
X-Received: by 2002:a05:6602:2e05:: with SMTP id o5mr21472135iow.28.1592105632167;
        Sat, 13 Jun 2020 20:33:52 -0700 (PDT)
Received: from qiushi.cs.umn.edu ([2607:ea00:101:3c74:4874:45:bcb4:df60])
        by smtp.gmail.com with ESMTPSA id 4sm5763940ilc.34.2020.06.13.20.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:33:51 -0700 (PDT)
From:   wu000273@umn.edu
To:     kjlu@umn.edu
Cc:     wu000273@umn.edu, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: img-parallel-out: Fix a reference count leak
Date:   Sat, 13 Jun 2020 22:33:43 -0500
Message-Id: <20200614033344.1814-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

pm_runtime_get_sync() increments the runtime PM usage counter even
when it returns an error code, causing incorrect ref count if
pm_runtime_put_noidle() is not called in error handling paths.
Thus call pm_runtime_put_noidle() if pm_runtime_get_sync() fails.

Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 sound/soc/img/img-parallel-out.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/img/img-parallel-out.c b/sound/soc/img/img-parallel-out.c
index 5ddbe3a31c2e..4da49a42e854 100644
--- a/sound/soc/img/img-parallel-out.c
+++ b/sound/soc/img/img-parallel-out.c
@@ -163,8 +163,10 @@ static int img_prl_out_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	}
 
 	ret = pm_runtime_get_sync(prl->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_noidle(prl->dev);
 		return ret;
+	}
 
 	reg = img_prl_out_readl(prl, IMG_PRL_OUT_CTL);
 	reg = (reg & ~IMG_PRL_OUT_CTL_EDGE_MASK) | control_set;
-- 
2.17.1

