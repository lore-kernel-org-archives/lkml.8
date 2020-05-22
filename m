Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAA1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D19AC206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 05:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="UnH3VewC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgEVFj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 01:39:26 -0400
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:44324 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgEVFjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 01:39:25 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id 49SwKS5RDNz9vC7f
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:39:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8NZbD8yBYiNW for <linux-kernel@vger.kernel.org>;
        Fri, 22 May 2020 00:39:24 -0500 (CDT)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id 49SwKS3cdJz9vC7g
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 00:39:24 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p8.oit.umn.edu 49SwKS3cdJz9vC7g
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p8.oit.umn.edu 49SwKS3cdJz9vC7g
Received: by mail-il1-f198.google.com with SMTP id g19so7707539ila.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 22:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Nw9ZxxfgndhoF58jExuvZik3iLvi7tAKiUrrdvolleA=;
        b=UnH3VewChlMvg2xKTTmIodKw8qF1KMxSBGoH2brX02x5XysZ5FhO+P7KeziSWrrtkz
         1D9bGytuYgzWBVKhNkxpXQ/CdDyC/RVE7Gft0iCBhh05QZ45wOuJiicsLIoJ3X3EWakT
         xScFIQj+SNf9pFicKlgLoD4VBzz75syLFh31Uj4S6ve6gHzlqGLO1HKXAULCvba3S0oW
         P0zyDhpQcEoEK5WUUhIF1cOVJ1jORTJa82/Khk5wFpBJjNzly8ll8EEY0nfANdIzrNsZ
         YeZQsaoHnCTB6uPgXGCYUn8gey9NClMiaoV/DRtoSry1MlAWcBiSp4d9N8XSW9BJmPLD
         f4HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Nw9ZxxfgndhoF58jExuvZik3iLvi7tAKiUrrdvolleA=;
        b=OF03Txz16ivHYh2GqJuarsU6XwEv6VidnUCcl1iDtjEblZGB7ei1wXCIwhhXJzfW4e
         2YRBcBByKYRhmkqLMZhsbQfjX3dSMvFJWOSgszSuZpRzTmm7S9EAXtXw2LDRAzAsRYEQ
         1VN2gKjZw/s79jXdFRX1OnnVqckjJ0iGv8nE3HlrOrvKq22rLdSTSLkdBwtcIQ4d5H9g
         ZDAeU7F+GbUw5vp0hl7zXoAL/AF0hQQHbqv2OxP/T99d8VoX0/oGwx6fv95luuy0Z5Ka
         Qqrhyran57CYauZ3k6CMp+aV2lSHonWdnVWtOBh+qjLSrgOMn+Bh/AJWfHFe0vuV71wK
         LxSw==
X-Gm-Message-State: AOAM532sce0wFmKj21a+bOozSBJPt7vGq/iiR5Spc5iL/CDFNxMcajWy
        /WI9xkTLsoCvbTRRf6gLpzTP/s53qSadTO7SmoEN9YffTubQ5mHeDzICwK1EH8vU7spYOr7sdFR
        mzFOxkoqY4DKgDvlkFAbjDVFKPuYB
X-Received: by 2002:a92:de09:: with SMTP id x9mr12663499ilm.176.1590125964007;
        Thu, 21 May 2020 22:39:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxQMy4MduQr+NXToFujOmG/SJ/YGsdUXXK9jJWv6bkQlgo6y5TFFzd4HAvxkOSuo0Is7SLp8w==
X-Received: by 2002:a92:de09:: with SMTP id x9mr12663483ilm.176.1590125963717;
        Thu, 21 May 2020 22:39:23 -0700 (PDT)
Received: from qiushi.dtc.umn.edu (cs-kh5248-02-umh.cs.umn.edu. [128.101.106.4])
        by smtp.gmail.com with ESMTPSA id q4sm4243428ilk.12.2020.05.21.22.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 22:39:23 -0700 (PDT)
From:   wu000273@umn.edu
To:     airlied@linux.ie
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, kjlu@umn.edu, wu000273@umn.edu
Subject: [PATCH] drm/i915: fix a memory leak bug.
Date:   Fri, 22 May 2020 00:39:15 -0500
Message-Id: <20200522053915.4396-1-wu000273@umn.edu>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qiushi Wu <wu000273@umn.edu>

In intel_gtt_setup_scratch_page(), pointer "page" is not released if
pci_dma_mapping_error() return an error, leading to a memory leak bug.
Fix this issue by freeing "page" before return.

Fixes: 0e87d2b06cb46 ("intel-gtt: initialize our own scratch page")
Signed-off-by: Qiushi Wu <wu000273@umn.edu>
---
 drivers/char/agp/intel-gtt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/agp/intel-gtt.c b/drivers/char/agp/intel-gtt.c
index 66a62d17a3f5..a56a50f2740f 100644
--- a/drivers/char/agp/intel-gtt.c
+++ b/drivers/char/agp/intel-gtt.c
@@ -304,8 +304,10 @@ static int intel_gtt_setup_scratch_page(void)
 	if (intel_private.needs_dmar) {
 		dma_addr = pci_map_page(intel_private.pcidev, page, 0,
 				    PAGE_SIZE, PCI_DMA_BIDIRECTIONAL);
-		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr))
+		if (pci_dma_mapping_error(intel_private.pcidev, dma_addr)) {
+			__free_page(page);
 			return -EINVAL;
+		}
 
 		intel_private.scratch_page_dma = dma_addr;
 	} else
-- 
2.17.1

