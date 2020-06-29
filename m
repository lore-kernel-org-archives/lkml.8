Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 420ED20857
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UerGcuAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbgF2VVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729768AbgF2Swn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:52:43 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DCEC02E2D8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:07 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z15so5408173wrl.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 07:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t94gU7LdZ9jhuE6Fuy5QcBW6wxTpYHr3wMA3J0Azebg=;
        b=UerGcuAlj7Z9MLnen9oULz1ZCNnOGBCp6prj5iOmxWAPp79uH10ApRql/esij74qU1
         TWwBUWUwXKybD7mLCIFuxnDkchZH4v0l7AhLDtvi1LP5qGhTW5sQI1CWSfJzFZ2r0vbq
         iNCHT11TSH8gowVpzmfcRa9Ybi5BKsZNrAdCaLmXiEmJdHZQ/WB4GD2FFJw0jldyNHWe
         1OOZfR50UhVxtQc3KBBvl3eGL4DEhf4K/Wvr3X/HV9mV+Jt0MY2ytHYcvMJwARnRZ6kJ
         Ug4lNp8IbJIuT+yzwH5HioKnq78YX5xRE4ZSMXGPflUPfa9qFJlKYMJqu8veJZDVafd/
         ORJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t94gU7LdZ9jhuE6Fuy5QcBW6wxTpYHr3wMA3J0Azebg=;
        b=gfBSeuDjnScxX4rCcQSyYVO3K+5YsmK7RFmdp3Zw8RM+UnzOQ8nvmxCVq4JYCD4d7u
         uHQ4mE74EuzbfrOskPuq6yF3CPTsZSTjZPG9f+Z6I2d6PLfyjaFkmxdLlh+aBNaWW0qK
         2f7LHMQyIWX0rs7SLSw3gwtNpJFInLLgUQJjuVxF/8Onr/DjHSYAJha2nS20mu4cXtOd
         f+RGtaBuvIk66vmo0XCWRUUZfjUc5ZWtmFwaZ7wk8R0QVJpz1UlM68GxQFGkUqbUHE/y
         UJ3skvvQS+yrjsoVf4HGe1AoQlPzCwwjwjywTSsUP0kyc/+tQ+dlPrisRpZfhrm2sPi3
         omWQ==
X-Gm-Message-State: AOAM53333NkT+mNx6dMUmCETUFC/RfoTy4G2RCBy13sZaR/cqZNwk0M8
        eE3Owzfu34v/GB/cNGwxCU/iKA==
X-Google-Smtp-Source: ABdhPJwmw6HtLwtc/BWKL7jvIFL/StauXcjQlFWHZqdNshQG+W/DhIyNUji82FIRqL0MnKMNZWFvkg==
X-Received: by 2002:a5d:6846:: with SMTP id o6mr17265668wrw.370.1593439505791;
        Mon, 29 Jun 2020 07:05:05 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p14sm15394928wrj.14.2020.06.29.07.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 07:05:05 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: [PATCH 16/20] misc: genwqe: card_base: Remove set but unused variable 'rc'
Date:   Mon, 29 Jun 2020 15:04:38 +0100
Message-Id: <20200629140442.1043957-17-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629140442.1043957-1-lee.jones@linaro.org>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'rc' hasn't been checked since the driver's inception
in 2013.  If it hasn't caused any issues since then, it's unlikely
to in the future.  Let's take it out for now.

Fixes the following W=1 kernel build warning(s):

 drivers/misc/genwqe/card_base.c: In function ‘genwqe_health_check_stop’:
 /home/lee/projects/linux/kernel/drivers/misc/genwqe/card_base.c:1046:6: warning: variable ‘rc’ set but not used [-Wunused-but-set-variable]
 1046 | int rc;
 | ^~

Cc: Michael Jung <mijung@gmx.net>
Cc: Michael Ruettger <michael@ibmra.de>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/misc/genwqe/card_base.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/misc/genwqe/card_base.c b/drivers/misc/genwqe/card_base.c
index 1dc6c7c5cbce9..bceebf49de2d5 100644
--- a/drivers/misc/genwqe/card_base.c
+++ b/drivers/misc/genwqe/card_base.c
@@ -1043,12 +1043,10 @@ static int genwqe_health_thread_running(struct genwqe_dev *cd)
 
 static int genwqe_health_check_stop(struct genwqe_dev *cd)
 {
-	int rc;
-
 	if (!genwqe_health_thread_running(cd))
 		return -EIO;
 
-	rc = kthread_stop(cd->health_thread);
+	kthread_stop(cd->health_thread);
 	cd->health_thread = NULL;
 	return 0;
 }
-- 
2.25.1

