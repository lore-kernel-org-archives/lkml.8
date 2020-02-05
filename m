Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3115C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7A3D217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:55:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KovrFgSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbgBEPz3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:55:29 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:54830 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727621AbgBEPz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:55:28 -0500
Received: by mail-pj1-f68.google.com with SMTP id dw13so1142226pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:55:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=5hu692SP05XeWg1iEg/5pM4NUOKOgYoW5YB1MBMx/Sg=;
        b=KovrFgSN1RLFU0dQ1e+ni3RbNTkHoele04g9B9yqWpkGxhwpa+MIvzsc70MhuYWfIb
         5OZMzZu1QuQ0ImizQeHSC6jvN03hnUp6VrVzKP6ABRtAbJ7LBCdoLc8nGzhQRsBxFgr6
         d5Lqg1JwEvxYO0CZYpwJ+ftb2y+R/d9WMtVMAPTIDX1aMBly5mRXwV3/OjgtvCyxjAqp
         PebTJ0hHB9oL/ZBRf/r2KVndMZxPcI+6h9K+yy6jJBVfj8di3mUbEHRG2kZzVQDI05Px
         F/CC0b5GROUQ8rvTgk9bi6+UzPGjduq7ppX3Ku1p3noUC6vEUwC+02CkNpCajql3ZM6w
         gdyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:in-reply-to:references;
        bh=5hu692SP05XeWg1iEg/5pM4NUOKOgYoW5YB1MBMx/Sg=;
        b=DwWXQnW0Iz3MEvBkh/FUK/WmcUlVc2pjqz5dayNA6Laj8KCwyn0mKnNko5mzs0Vl4j
         6gylI9Q/g7mc6WQUnG3udkcTg+96aCxaaRipDBlfu6Yq+1JOxa9wspTCe2+/SCQv9TjH
         B+fqzKdVLlEMcwtq2iwKbg68gxi4ZDV9sJ5aritvWE9zywh/IQ+u/amXPd2iCWavaWc/
         pFjMmQUHW//pkQJAc9lOLTZT2PA/kvEGTHHYglYVzsadgFr2Gz9Do91WcNTHIIQ41/lW
         +wnjsfyyF/u27cIe+jr8O0P3aHmiaBx/32LEhCwbY5PkghnfEgGOCru/16qmHkS7H135
         uPWw==
X-Gm-Message-State: APjAAAVAnVtMbnnONdkw0EpSUMUtfE91WOyYa967mljWY9+nhdSH6TiP
        y6Ig+DdYNVIfUC7+2Pc009I=
X-Google-Smtp-Source: APXvYqzZwEViSPE5ZfA+cXcMvtDKHCvBVdWuL88Qs3lIt/N6pOQxrazKXlio0KSgrfmFFwDvr1c4ow==
X-Received: by 2002:a17:902:b612:: with SMTP id b18mr33947745pls.318.1580918127370;
        Wed, 05 Feb 2020 07:55:27 -0800 (PST)
Received: from emb-wallaby.amd.com ([165.204.156.251])
        by smtp.gmail.com with ESMTPSA id z10sm195678pgz.88.2020.02.05.07.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:55:26 -0800 (PST)
From:   Arindam Nath <arindam.nath@amd.com>
To:     Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Jiasen Lin <linjiasen@hygon.cn>,
        Sanjay R Mehta <sanju.mehta@amd.com>
Cc:     linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org,
        Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 13/15] NTB: remove redundant setting of DB valid mask
Date:   Wed,  5 Feb 2020 21:24:30 +0530
Message-Id: <77ab9d5b86cbf404cd254d50d26e276472014293.1580914232.git.arindam.nath@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

db_valid_mask is set at two places, once within
amd_init_ntb(), and again within amd_init_dev().
Since amd_init_ntb() is actually called from
amd_init_dev(), setting db_valid_mask from
former does not really make sense. So remove it.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 8a9852343de6..04be1482037b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1056,8 +1056,6 @@ static int amd_init_ntb(struct amd_ntb_dev *ndev)
 		return -EINVAL;
 	}
 
-	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
-
 	/* Mask event interrupts */
 	writel(ndev->int_mask, mmio + AMD_INTMASK_OFFSET);
 
-- 
2.17.1

