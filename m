Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0A3206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 16:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcythmom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406189AbgFYQbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 12:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406106AbgFYQbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 12:31:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04979C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:36 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id o11so6488482wrv.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bq/btLCNVpDq7WQbqNzbqWHRqAbD1Rvrp24T5PkKMvQ=;
        b=jcythmom0hvII4A/DrE6Hw1TYrCtaWr2Amn8NRqD8zdJGovBnTWIOHoKr5nGTkR//D
         yIgFHe9mEKMvghz25c8EaBymoqXspHL2jfwB25I/P+6rsvpNhL11WuzprjBFm2qzRe15
         x4v4AvpxQHxSYrMjJ3Gz67k4zD3LuuGQGakGZyAvmqPXYzPEN7NVzq4HjxzICD98RPKN
         m2jklcV5OwvPSj4aPw2U4TYpPy4eGg06Tb+Zz3eeHic1lxRkBska2yn6hmTdMYt/goSm
         Yvk7V3gfIUX0/n0TCEP6H/g254ynuP/uqqJqdCtlnDryKn+HEKPQb/2z2zMjWcNC+stk
         m44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bq/btLCNVpDq7WQbqNzbqWHRqAbD1Rvrp24T5PkKMvQ=;
        b=acjfAB1kt20+fgHzonx6yWVaAor2HvmEMUymd3x7nX4JV0G1ydw5yYI1uc5Vq3UMp7
         BHBQLbWJCabXNjMqZVVgMSlbMdA+kHgg7WggQGqlevfE0AiP5HgVuhNVYfZGwEOOV6Wp
         QWwSxCUlhcf51TEiNGcaP1k82O5Eog1PiKGg5M0StvxbQOqFZQNgBTzEulbqz+CnGkGR
         Q3EOty66AWCdI2fcWB0C8+ENLjR2AjlDLfnQcexlZqVHHya3Cvk31ApEY/uHgUfJep4K
         FRAEf/GA7//3cBIUZmfi/IRpDBYMN2iKnHgxhEdnClo5oJNsJA7wvzleRh57RZCyVWDc
         z5Yg==
X-Gm-Message-State: AOAM531IgVDdKMKdskhyPEpaTMgyZmY4WD3Lir6dO1UyoSLttcapPF1Q
        GKHnVYXP9pQ6GwOy8H3pSQVCGQ==
X-Google-Smtp-Source: ABdhPJyK5azuDtfQu+j+mtbkTuNEoVInNEMuX+9qoIDVs73VZrHnCclPv1nUkDUC3iM2iD6b6Pe1kw==
X-Received: by 2002:adf:bc41:: with SMTP id a1mr35910174wrh.186.1593102694696;
        Thu, 25 Jun 2020 09:31:34 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id l8sm32090847wrq.15.2020.06.25.09.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 09:31:34 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Bill Richardson <wfrichar@chromium.org>
Subject: [PATCH 01/10] mfd: cros_ec_dev: Fix cros_feature_to_{name,cells} struct descriptions
Date:   Thu, 25 Jun 2020 17:31:18 +0100
Message-Id: <20200625163127.4000462-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200625163127.4000462-1-lee.jones@linaro.org>
References: <20200625163127.4000462-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects kernel structures to be prefixed with 'struct'.

Fixes the following W=1 level warnings:

 drivers/mfd/cros_ec_dev.c:32: warning: cannot understand function prototype: 'struct cros_feature_to_name '
 drivers/mfd/cros_ec_dev.c:44: warning: cannot understand function prototype: 'struct cros_feature_to_cells '

Cc: Benson Leung <bleung@chromium.org>
Cc: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Guenter Roeck <groeck@chromium.org>
Cc: Bill Richardson <wfrichar@chromium.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/cros_ec_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 32c2b912b58b2..d07b43d7c761a 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -24,7 +24,7 @@ static struct class cros_class = {
 };
 
 /**
- * cros_feature_to_name - CrOS feature id to name/short description.
+ * struct cros_feature_to_name - CrOS feature id to name/short description.
  * @id: The feature identifier.
  * @name: Device name associated with the feature id.
  * @desc: Short name that will be displayed.
@@ -36,7 +36,7 @@ struct cros_feature_to_name {
 };
 
 /**
- * cros_feature_to_cells - CrOS feature id to mfd cells association.
+ * struct cros_feature_to_cells - CrOS feature id to mfd cells association.
  * @id: The feature identifier.
  * @mfd_cells: Pointer to the array of mfd cells that needs to be added.
  * @num_cells: Number of mfd cells into the array.
-- 
2.25.1

