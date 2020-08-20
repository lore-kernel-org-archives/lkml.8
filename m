Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639D0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F27020658
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 13:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597930136;
	bh=S5pOME3zGx4IYjWpdF8CZDVdUnqXcSKVsKmBjXwEE0E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N6pmJsfke8nNANelGIiIyuHGFjv9+uY7KMpu6FKLMS1k6ai+rjlUtjvrtdHSY0dii
	 VrboB6uGHeHcXHyJnps7zfcHn/ftSVmAVgPPNZR7de0DGCz5reykQWkHDeHhf2RQNx
	 R+dHRcq1OYtE3/gHeYteN4bz1FmuahYDJMq3kt78=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgHTJdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:33:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:44130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727882AbgHTJb5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:31:57 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F28C22BED;
        Thu, 20 Aug 2020 09:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597915916;
        bh=S5pOME3zGx4IYjWpdF8CZDVdUnqXcSKVsKmBjXwEE0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4sQ+yoCZ5LLPKIv/gBvzkf23r9h8VAfNEhYwB5jEB/pey3NnZ5QdPiDWMCsGTCkc
         hBC71M5k75sjIALJ21l38SHOsd0gaHobxTTRXTnR3IKp4924y0vsYfB3HKEkF5TYcd
         aQTBOTsUgMiJY/lJV2H9ciyrIQO8jE1dKI59qYVE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jane Chu <jane.chu@oracle.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.8 179/232] libnvdimm/security: fix a typo
Date:   Thu, 20 Aug 2020 11:20:30 +0200
Message-Id: <20200820091621.481053528@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200820091612.692383444@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jane Chu <jane.chu@oracle.com>

[ Upstream commit dad42d17558f316e9e807698cd4207359b636084 ]

commit d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
introduced a typo, causing a 'nvdimm->sec.flags' update being overwritten
by the subsequent update meant for 'nvdimm->sec.ext_flags'.

Link: https://lore.kernel.org/r/1596494499-9852-1-git-send-email-jane.chu@oracle.com
Fixes: d78c620a2e82 ("libnvdimm/security: Introduce a 'frozen' attribute")
Cc: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvdimm/security.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/security.c b/drivers/nvdimm/security.c
index 4cef69bd3c1bd..8f3971cf16541 100644
--- a/drivers/nvdimm/security.c
+++ b/drivers/nvdimm/security.c
@@ -457,7 +457,7 @@ void __nvdimm_security_overwrite_query(struct nvdimm *nvdimm)
 	clear_bit(NDD_WORK_PENDING, &nvdimm->flags);
 	put_device(&nvdimm->dev);
 	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_USER);
-	nvdimm->sec.flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
+	nvdimm->sec.ext_flags = nvdimm_security_flags(nvdimm, NVDIMM_MASTER);
 }
 
 void nvdimm_security_overwrite_query(struct work_struct *work)
-- 
2.25.1



