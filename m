Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01426C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC4582081A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 19:17:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J3t8Bw93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406670AbgFYTRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 15:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406492AbgFYTRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 15:17:18 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E338C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id q5so7024753wru.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 12:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4/CDB2l4JpZBpeXJ5F7ZtKgNEooXeOnUoj71PMW6rrU=;
        b=J3t8Bw937CgTO8lYSG+HhLvnS7lV0gd31rIQ4Lk/CXtSfXHWwrivgfL1x1f0otUOMT
         cjmuYjZ2VrkY2VEjcXRp/zOcAXeugJ8Nq3E5cD5WBUIAqm4EBEI6TQbGY+fq/aut1Dji
         hG7uosrCrRrCnDnjXAkcrzMD0IYZA8QTuym0FqwNLFLPYDnL1LXQCn3jqo+6cKL9FCxf
         iGTX9Nt0p3Zm+5RHOCBvVDFcW4tHJyOuCEj47k0cTWSrYfXP/gLDd0mpjYgboDIA0alY
         vjrcQr8f3ci5XKMOI9V5Y/lkf8+KSCyWe838LwaW8Ga/1JT7G3i3mjz8GGcwUoiUTV6X
         +E6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4/CDB2l4JpZBpeXJ5F7ZtKgNEooXeOnUoj71PMW6rrU=;
        b=mAoAR8TkYrKc17WkF43KH9qLmbRyrYzQz3gWYeEuPf5skTWnQu56VTjMkACgMEhd9P
         UA2UImzj/hiFCsOIamk5PuhpcxqdPn0uGPBHsmr6MdOQtpNOhdUQ/6k5ZRqn/rv3O73m
         h9aPEB6raGPn0WlRB7oM/zTeRhlgLTyYZysVzPOi+KINu6Xb/yaRDYa2uplCm001D/el
         A/HhXSTHlaubVlEQhX8x96PdB/I7bS6VL1/z/I5cZOKVT8KCLjcavIMU0GiuDYmmO9A1
         hwK/4w43m8hmi7TM9qAnQ9hLnxBFKlxRANxajlkdk3IOZ9pE39v7+hPvUHWygPHRD1jQ
         HaHA==
X-Gm-Message-State: AOAM532rH/sRNnG5xqvIwiw9P8a/VKJLf75Y+mqoli/vi5qvbLTsh0TJ
        m7IwNJxDGMJlS7uOreHeIB8Zfw==
X-Google-Smtp-Source: ABdhPJyIYQF86tVFqTQfAszSkBtYqZ9soigeoM9NELkd6pzeaRIJNybLyLmMNBTmcL1wQhj+AB+qGg==
X-Received: by 2002:a5d:6809:: with SMTP id w9mr40614001wru.182.1593112636948;
        Thu, 25 Jun 2020 12:17:16 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id p13sm22693983wrn.0.2020.06.25.12.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 12:17:16 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lgirdwood@gmail.com, broonie@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Rajendra Nayak <rnayak@ti.com>
Subject: [RESEND 03/10] regulator: of_regulator: Add missing colon for rdev kerneldoc argument
Date:   Thu, 25 Jun 2020 20:17:01 +0100
Message-Id: <20200625191708.4014533-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625191708.4014533-1-lee.jones@linaro.org>
References: <20200625191708.4014533-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc validation gets confused if syntax isn't "@.*: ".

Adding the missing colons squashes the following W=1 warnings:

Cc: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/of_regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 87637eb6bcbcb..06c0b15fe4c08 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -532,7 +532,7 @@ static bool of_coupling_find_node(struct device_node *src,
 /**
  * of_check_coupling_data - Parse rdev's coupling properties and check data
  *			    consistency
- * @rdev - pointer to regulator_dev whose data is checked
+ * @rdev: pointer to regulator_dev whose data is checked
  *
  * Function checks if all the following conditions are met:
  * - rdev's max_spread is greater than 0
-- 
2.25.1

