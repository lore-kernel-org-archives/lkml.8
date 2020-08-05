Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D33C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA6A722CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkdRodHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbgHEX1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEX1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:27:03 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D9FC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 16:27:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g6so36995291ljn.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 16:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqROdRA/TNkD5HX+lHDz1Fxcp/ANC0RzYHkC2yHp+Lo=;
        b=XkdRodHJ3ZPMhStQhUC8Ple1OeZZ//RVilrG1zO4nFwXQ/gVB3eB+3epkYHI/flITy
         oJxaHqaXRvT3QSZFXjXoFg4US6KehhPW8G5y7ZLdcv8rRDB32t3zCSOd3d50v/NCRzdJ
         nQlLsasthuVQqOFMndx9hIQLL5iLR6jZxYSXjEue7OX9nmCLLnIyjxO4yFlWlHkpW3L9
         IhvN8JoPiwUT0T9mbZRrJ0wkNYpx45IhDg65u9xyg5eU+xBQEpCRvy9cEiN6slS42zOQ
         AqHdXZfnlLcutcISbIXOUtZcyK1iFanE/5J40FqVaKPDstT+HIPvlD3UUy6AtPjLHid6
         yp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqROdRA/TNkD5HX+lHDz1Fxcp/ANC0RzYHkC2yHp+Lo=;
        b=Oe0/zczbWFrH6icQ2UHm1/azaCCSXtru8j0lB6ORtm8h53UKTOOaywp6xwmTbY+FtU
         ZeYtFo/gnCN7p5rKI1oXy/C6FliIf7BdT+lHkVPspHJeQPGQnuFCNvCuJlhqVpdE/6TK
         0iafWq+luvHshzGvIzhPtZ8Fadh2pdQWoDJiyYdVarL1pu7vzcIh0bg/BBhqT/s6Eejr
         ol36peHbeg6Vu7FoR3pSarGAro6ExDnjuJ316FikwlS7SecgY2/XXaEhwoBViwTHCUG1
         GBLY7OUPvozmf5AgfET+586JNvOEVc40qT3rP2JVcCAPU69DCY5nPlxGsjMlDy2zuXU/
         iihQ==
X-Gm-Message-State: AOAM531CHnmwxvxICQg4457h3ZPSFoPt8yHDBcx70cTyhRfl2iZjxQv4
        90AWWWaFK6lKg9nQ6VuK4Gk=
X-Google-Smtp-Source: ABdhPJyXFGXf566iyYgt7mOg8zVRgzKFYX7nzNmAnoPfW8yUCn8FiIw6lXJ14EY+wIHgB16tC7qohQ==
X-Received: by 2002:a2e:9bc8:: with SMTP id w8mr2341829ljj.351.1596670020547;
        Wed, 05 Aug 2020 16:27:00 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id r16sm1485603ljd.71.2020.08.05.16.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 16:26:59 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, jk@ozlabs.org, joel@jms.id.au,
        alistair@popple.id.au, eajames@linux.ibm.com,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 1/3] fsi: master: Constify hub_master_ids
Date:   Thu,  6 Aug 2020 01:26:22 +0200
Message-Id: <20200805232624.6938-2-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
References: <20200805232624.6938-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage of hub_master_ids is to assign its address to the
id_table field in the fsi_driver struct, which is a const pointer, so
make it const to allow the compiler to put it in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/fsi/fsi-master-hub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index 3caa2da7838c..01f0a796111e 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -276,7 +276,7 @@ static int hub_master_remove(struct device *dev)
 	return 0;
 }
 
-static struct fsi_device_id hub_master_ids[] = {
+static const struct fsi_device_id hub_master_ids[] = {
 	{
 		.engine_type = FSI_ENGID_HUB_MASTER,
 		.version = FSI_VERSION_ANY,
-- 
2.28.0

