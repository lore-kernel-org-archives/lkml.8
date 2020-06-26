Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FB3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DEB20857
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 06:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cU3REmEx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgFZG5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 02:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFZG5q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 02:57:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A98C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h15so8352997wrq.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 23:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EQdtlCq0FayiIxw9Rs+gOrZ/5VZqnIsgjAQgaobsp4s=;
        b=cU3REmExdXZnTF1HXY2PtQ30RmVx7lx6+g3J32TSut/xk7G7p7XuOcEJLmRCbZ1oAr
         yxV9KPJUZZxSbh1LCZe2jrxDJ+MPWPlh0BioUJLmX/EUALUyyccsVlG1MH1dkpOLRMbg
         F1qIyO8QOKmF/5DVafM5L6c29Kmb/zbFn7/mZAHvQwjiHO04zXvrQrvjofjw6jUuyN1n
         mP/+VZDB0onc+Z+oo783ZaFEVi8BQHwkpLhTxi8/2m/2B8ctw2r2H/OwnpQMJBAjCEAO
         SGmQdBYITEgfwziCb87ej+7xh0NjA/L6OCgXbTy+b95YSxVc84h4L5vpK1eAZH5R/Qp9
         gajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EQdtlCq0FayiIxw9Rs+gOrZ/5VZqnIsgjAQgaobsp4s=;
        b=FNqahfmTJx18gJLOLan95qEOwn4mKyIgOeqBfetRpAoRiZRyZ7bgKspGgScvxevge+
         uFg45bLi3ejzg5VY7QGtRToPBLfNbMsEdZ7aG1GevVExMTOvLURxuwC+1spNR9PzY3pK
         9pBGP+2E8+CyAk80MiHRlKKxOZQG9oICdvzahAF2FJ26LLAtiL6P1f4mOKiepfJebq4V
         BS3rmV+IZO8NpnuOEWTINLy1reRsaKJUxTcW17122NDNcJwDnF485eJYpZMDw59urgpr
         XZvKyNKB5DCqKcAkOiZwEpZxf9I8iJj8be1UCyei6v6Ko8xCZKeIrR/VNE6seiC521Pt
         ydKw==
X-Gm-Message-State: AOAM533ZvUXHSs6ogYofv/LiMl0C2xSz0CmuiEEH68DM67VNO+j7dqDN
        hmfZAv3Oki7Pe4uNqxZTR0uRYg==
X-Google-Smtp-Source: ABdhPJwZ+URFbBBN0AhuwE/y6WRRpqaFyX55X7XIOPgwaR11LJdWPX+JuV9C2QRf7yGvIuLUOuZ4Yg==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr2187942wrr.288.1593154664379;
        Thu, 25 Jun 2020 23:57:44 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id x18sm15355269wmi.35.2020.06.25.23.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 23:57:43 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 2/9] regulator: qcom-rpmh-regulator: Repair dodgy kerneldoc header formatting
Date:   Fri, 26 Jun 2020 07:57:31 +0100
Message-Id: <20200626065738.93412-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200626065738.93412-1-lee.jones@linaro.org>
References: <20200626065738.93412-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W=1 kernel builds report a lack of descriptions for various
enum properties and function arguments.  In reality they are
documented, but the formatting was not as expected '@.*:'.
Instead, some weird arg identifiers were used or none at all.

This change fixes the following warnings:

 drivers/regulator/qcom-rpmh-regulator.c:33: warning: Enum value 'VRM' not described in enum 'rpmh_regulator_type'
 drivers/regulator/qcom-rpmh-regulator.c:33: warning: Enum value 'XOB' not described in enum 'rpmh_regulator_type'
 drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'vreg' not described in 'rpmh_regulator_init_vreg'
 drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'dev' not described in 'rpmh_regulator_init_vreg'
 drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'node' not described in 'rpmh_regulator_init_vreg'
 drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'pmic_id' not described in 'rpmh_regulator_init_vreg'
 drivers/regulator/qcom-rpmh-regulator.c:416: warning: Function parameter or member 'pmic_rpmh_data' not described in 'rpmh_regulator_init_vreg'

Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/regulator/qcom-rpmh-regulator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/qcom-rpmh-regulator.c b/drivers/regulator/qcom-rpmh-regulator.c
index 79bdc129cb504..08dcc614efa7f 100644
--- a/drivers/regulator/qcom-rpmh-regulator.c
+++ b/drivers/regulator/qcom-rpmh-regulator.c
@@ -22,9 +22,9 @@
 
 /**
  * enum rpmh_regulator_type - supported RPMh accelerator types
- * %VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
+ * @VRM:	RPMh VRM accelerator which supports voting on enable, voltage,
  *		and mode of LDO, SMPS, and BOB type PMIC regulators.
- * %XOB:	RPMh XOB accelerator which supports voting on the enable state
+ * @XOB:	RPMh XOB accelerator which supports voting on the enable state
  *		of PMIC regulators.
  */
 enum rpmh_regulator_type {
@@ -399,13 +399,13 @@ static const struct regulator_ops rpmh_regulator_xob_ops = {
 
 /**
  * rpmh_regulator_init_vreg() - initialize all attributes of an rpmh-regulator
- * vreg:		Pointer to the individual rpmh-regulator resource
- * dev:			Pointer to the top level rpmh-regulator PMIC device
- * node:		Pointer to the individual rpmh-regulator resource
+ * @vreg:		Pointer to the individual rpmh-regulator resource
+ * @dev:			Pointer to the top level rpmh-regulator PMIC device
+ * @node:		Pointer to the individual rpmh-regulator resource
  *			device node
- * pmic_id:		String used to identify the top level rpmh-regulator
+ * @pmic_id:		String used to identify the top level rpmh-regulator
  *			PMIC device on the board
- * pmic_rpmh_data:	Pointer to a null-terminated array of rpmh-regulator
+ * @pmic_rpmh_data:	Pointer to a null-terminated array of rpmh-regulator
  *			resources defined for the top level PMIC device
  *
  * Return: 0 on success, errno on failure
-- 
2.25.1

