Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21A6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5C22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQfOrITB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgHXVPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbgHXVPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:15:51 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755FFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:15:51 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so233384wmk.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 14:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFw4WfZ8EhsNfys63tZhqlDitg+wRfgOs5oV//XPrUM=;
        b=FQfOrITBr/YQmprdbDs9K0Z2Kq+p9iialWri9yWFnpOyReVYm0eyFFSpkA9dfanxkT
         IRTWbqHsmXT0FApdWrAoXwRvynXtd8rU9PnFu+pA5DosfghqjjJh7DNvOQMdDSgds0nn
         IEaM1xEuJ984gyfGYP+5f6UgTFNYZwk1pE0PqTO4bdsdvkN86oTTeRTXPwTP/8h4PdA7
         T+pgYyrjH2SmkmEthb8p1oMkGmgL1ciUfEVPII0CaDvTpBznT+OaqZMBTxsFKxIDNgru
         yghkD6ZRfTmeQTIKGkA5pDwbHaqO+afu1s/cvLzrnct4VkTCwR6lC1Kaj88tktIUkaBr
         ccDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFw4WfZ8EhsNfys63tZhqlDitg+wRfgOs5oV//XPrUM=;
        b=uY46YN3tdUAI0qrrDFm4SQkpnWMyzyrhk4Tn3wksJG6Xi6JCCt9QD0lSgUaAvM9yZ0
         eqic98xdzSg3h1criZ9uvl/V2Za9nqzhQ+ncAs4XtITV9A2BUKeN5PQVCDopuPHeksmc
         YjIkt6JFtlf+m4erhMYRN3xSu0alYb2GtSGxCiGsn2ibE1JGLAvuhvNFwCno436/FRTc
         PFOKSrWJ1cM2MDG15vUJfidEQoqzazHXiZkJqvVfN3WIQtENMLDzpCBJvCuLXqqsjCsN
         JvaIFokx2fWbIejdJN/dn81L0WoMG9VcpvVRw5tPg9bZ9RTh8ipq8+z6ayHzvoAi1Jb9
         i8LA==
X-Gm-Message-State: AOAM533cts4dBgvEICxesRUNO3sQL/Y8UJK2Voaetwlk7ENBU2bi4Qq9
        L27sCQZ6/u2yq1gr1mcMYw6xoKN2fpTESZuB
X-Google-Smtp-Source: ABdhPJz0baJ8O+INbMWboBj35pDbefXGIzNS8GiFPjrN5PieYka8Z4czgAFx6rk+IT2Y7nTgcfBJNg==
X-Received: by 2002:a1c:7915:: with SMTP id l21mr1146892wme.50.1598303750143;
        Mon, 24 Aug 2020 14:15:50 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id c9sm1638261wmf.3.2020.08.24.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2020 14:15:49 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Li Heng <liheng40@huawei.com>, Evan Quan <evan.quan@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pm: use kmemdup() rather than kmalloc+memcpy
Date:   Mon, 24 Aug 2020 22:15:25 +0100
Message-Id: <20200824211530.592909-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Issue identified with Coccinelle.

Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c   | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
index f56a3cbdfa3b..1f9082539457 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_processpptables.c
@@ -890,14 +890,12 @@ static int init_powerplay_table_information(
 				power_saving_clock_count);
 	}
 
-	pptable_information->smc_pptable = kmalloc(sizeof(PPTable_t), GFP_KERNEL);
+	pptable_information->smc_pptable = kmemdup(&(powerplay_table->smcPPTable),
+						   sizeof(PPTable_t),
+						   GFP_KERNEL);
 	if (pptable_information->smc_pptable == NULL)
 		return -ENOMEM;
 
-	memcpy(pptable_information->smc_pptable,
-			&(powerplay_table->smcPPTable),
-			sizeof(PPTable_t));
-
 
 	result = append_vbios_pptable(hwmgr, (pptable_information->smc_pptable));
 	if (result)
-- 
2.28.0

