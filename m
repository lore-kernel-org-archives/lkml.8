Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42065C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F712080D
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 12:48:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vT5SNW2n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgGAMsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730623AbgGAMrL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 08:47:11 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670B9C03E97B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 05:47:11 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so12391049wrl.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 05:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9fX3YQmu/TyZUi/gCUeVKqHWnQBcFQjsTJlFycXl+A4=;
        b=vT5SNW2nj2xlct7B5oFAEKNrAmdAYt9aa/C2EsvoZj3iCmWBfwGimRErcQG+WPVnXv
         XzjOj6noAaG6pXKH01vGd/aIyT0vJVDNQdn3UV+QOSyKvOTW4tRTlsf9IOsX7r0p4hLZ
         lg5e3peRTHdOPdw9roQqCIQ2Lh9lnDDtNIoHGkQKydRIQy8bwrbNcyNH7J8t0iOBOpkk
         uZfR4cpYEi3tZXnNA4LyYnYNzRHQreXLLFSrepfwCP3BU6CXtF5CBaJPW2XRBTiteXFl
         X76nU0olPK0OHVw74/pUz7g2eurHSfAQt1GXqbLePth2UiMhlC+mJYBtY6/ztU6Gw2QG
         MaFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9fX3YQmu/TyZUi/gCUeVKqHWnQBcFQjsTJlFycXl+A4=;
        b=njyEDTJTYKDFLb0MeFz7TASF9NvLWK/s8TP5zmaumYYjK1EjKU2l1kaHqxn2gvpRLq
         gg25sydiRL7fpGwFp0sS6weER2yvbiqc39mXjEUNktTuzW02Lva+JZ7vWGbnB2qdeTPO
         B07V22JYqaRL0Oav+Ab3UI8lftu+rpNkjfaw4EuDHyBI+YbnGcTn8lv+W/FEH6jZ64uI
         4VA6zJ3r7P8elLfPCW4H/O8rsLcR7mHX8ZKgHnAGgQ8p5ZNX/iZX7RKL5Sgl6QYnUdtg
         GVlmNI4QixqKCg6vfT5kr++Rk+/qFAvL9HAmhoR/J+Cp+KtPN8nI2mgAHb7A3ZZdLOlt
         PV5Q==
X-Gm-Message-State: AOAM532GfitkTIPF7H7PtAzhCT8mLea5G2330XwSxBk/nQiIGxq96kaD
        64DYTzd5MspXOn8TUAnqf7GtZg==
X-Google-Smtp-Source: ABdhPJzZIumZWDrMmq5PludRvlVmmwImG5o9AgYWwJ5Q0weSLLiLqzjnRp1cub8VUmYgSnRRyLb3Og==
X-Received: by 2002:a5d:6a07:: with SMTP id m7mr27093821wru.324.1593607630155;
        Wed, 01 Jul 2020 05:47:10 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id o29sm7817862wra.5.2020.07.01.05.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 05:47:09 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     ulf.hansson@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 03/15] mmc: core: regulator: Add missing documetation for 'mmc' and 'ios'
Date:   Wed,  1 Jul 2020 13:46:50 +0100
Message-Id: <20200701124702.908713-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200701124702.908713-1-lee.jones@linaro.org>
References: <20200701124702.908713-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remainder of the kerneldoc descriptions look present and correct.

Fixes the following W=1 kernel build warnings:

 drivers/mmc/core/regulator.c:178: warning: Function parameter or member 'mmc' not described in 'mmc_regulator_set_vqmmc'
 drivers/mmc/core/regulator.c:178: warning: Function parameter or member 'ios' not described in 'mmc_regulator_set_vqmmc'

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mmc/core/regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 96b1d15045d60..609201a467ef9 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -159,6 +159,8 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
 
 /**
  * mmc_regulator_set_vqmmc - Set VQMMC as per the ios
+ * @mmc: the host to regulate
+ * @ios: io bus settings
  *
  * For 3.3V signaling, we try to match VQMMC to VMMC as closely as possible.
  * That will match the behavior of old boards where VQMMC and VMMC were supplied
-- 
2.25.1

