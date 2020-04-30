Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45496C47247
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25375208CA
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgzh7czc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgD3QTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728360AbgD3QTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:19:24 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3E5C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:19:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id n11so2954796pgl.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 09:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Bd0ayqDMLRPuvdluOrNP0SAnf99YHwhV63n8Qm6Evr0=;
        b=Fgzh7czcWgcRnFx83H2M0ciY+zcYmlZjgOaa/jX0pueO8zT/VXnQcYKFXymMIW+NYk
         wvpmT2rEtn3eIDt+TDbkiByRU3ApYZWSMeEzzQwbL0v2FKgIgFmhiTgB8DOcW0hZVeH6
         +F76m7aRqb1Dl3CvOFye96AshPssh/Uxga3SKkBAUvkDlrml68jtvBow05X1YKw3h0Hc
         UrbxFNEIpB3Wtcy403d6EPU1O6bp2X3Hwr80xEypABKG+6hDC/T07I4K56VpJcrP2gTo
         /kkyNBaNOYq9+AJtQj1JNe3EktdIsWvAMm4RuObBgRhiyrMG6SptZAvBFW7TYLGxfyNj
         jG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Bd0ayqDMLRPuvdluOrNP0SAnf99YHwhV63n8Qm6Evr0=;
        b=gXD6qcZdo6rfsVs7V1Ej3SON0G4v5Fc3TtURSdUIUk8D/qzK316iwiXL4dUQAO7M5t
         zFUxLHrQyxCz8BD4w5RbYgLG259+YluTzHnDpDs9YLrEnfF/uHc9q8kBqUKsi0m3x8wJ
         eZ71VyYrE4ISE6t+cxFC0PORk66BgZPQww+D5zSke7gUq/y66weT09Mzmp+Sb/LD5vfw
         L2dA7Du4OxYc/4+o+6p6P7CLrSYsIWPgd4wYBZprMaj2ELmJZOCkCpn+WGUPT4Vj/EHF
         N/cOJ380YNanbSnC2EUDSiZ7X49E8yrYOzjYpAXAQEyMFFuWMty6xBMvT4jEbOj3wdRW
         pSlg==
X-Gm-Message-State: AGi0PuahlW5RX8VB5b0N0XOjY+Yz1dudNJumLdaR/eR/gq1TgXWr8VxK
        jh8LETbRsGVvkg/MwpMy15E=
X-Google-Smtp-Source: APiQypLb8VOAJ6P7mOQi3+hTbQ5C4u0mf4dY18qk3+afjrMk7rIhrwPGInAU6SxK7+e70O0J3rHVlQ==
X-Received: by 2002:a63:756:: with SMTP id 83mr3994025pgh.293.1588263563657;
        Thu, 30 Apr 2020 09:19:23 -0700 (PDT)
Received: from ubuntu.localdomain ([117.136.40.215])
        by smtp.gmail.com with ESMTPSA id w12sm223727pfq.133.2020.04.30.09.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 09:19:23 -0700 (PDT)
From:   Guixiong Wei <guixiongwei@gmail.com>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     nsaenzjulienne@suse.de, steve.capper@arm.com,
        akpm@linux-foundation.org, guro@fb.com, tglx@linutronix.de,
        rppt@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guixiong Wei <guixiongwei@gmail.com>
Subject: [PATCH v2] arm: mm: use __pfn_to_section() to get mem_section
Date:   Fri,  1 May 2020 06:18:58 +1400
Message-Id: <20200430161858.11379-1-guixiongwei@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__pfn_to_section() helper which already wraps around
__nr_to_section(pfn_to_section_nr(pfn)), should be used
directly instead.

Signed-off-by: Guixiong Wei <guixiongwei@gmail.com>
---

v1 -> v2
- reword the commit message.

---
 arch/arm64/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index e42727e3568e..d2df416b840e 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -272,7 +272,7 @@ int pfn_valid(unsigned long pfn)
 	if (pfn_to_section_nr(pfn) >= NR_MEM_SECTIONS)
 		return 0;
 
-	if (!valid_section(__nr_to_section(pfn_to_section_nr(pfn))))
+	if (!valid_section(__pfn_to_section(pfn)))
 		return 0;
 #endif
 	return memblock_is_map_memory(addr);
-- 
2.17.1

