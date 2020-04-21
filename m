Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BBFC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:28:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89C92084D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 03:28:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="y3NyXrgp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgDUD2N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 23:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728430AbgDUD2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 23:28:09 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68BC061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 20:28:09 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a22so768661pjk.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 20:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=UvuF2obS/vz7r5RB7yYAYMg8ibynstpwr3rLEw1flsc=;
        b=y3NyXrgpMV0LtSEwCxBH1cIXrKNb1rgvPCI4mPP4YqbBHnLpEEhYotoKHRbsQbhEYw
         GPxZy5OTbxg748olxqu8muf+44T8hwQqR7j/HfRBSb+3cg8H/LEgsaCmOIdSrj1gsZ0H
         IymVjfA4IM4KEuec6mKqKUw6lc6I79Y8fFXn6uL5iUWpr8cteat2LuOdbrvlv5pLO91U
         fJZINDQk5dmwusjgZqiX3VAJpGFd+5Wwjc8HyIFniFvaPex0NgXGUr3WSXWgbda9RagF
         Zib682h8M7u4cIJiTCCGy7PBxh1Veg1o15Y4xNuBmk3wRPSsJdfyxRPKPTKgnYkFelDf
         ZZXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UvuF2obS/vz7r5RB7yYAYMg8ibynstpwr3rLEw1flsc=;
        b=rDHu17pSRLr9aW1BL7OaK/nfN0W6WP/GGlChhVWmc7TLTYNHm1iCeSFqFLTFLLP1Kf
         fc4gbEVfECiuo3ysVaqMiJhiKSqkpDD90dIfuQOYJ+yIHE7DF+esq5wq63ZNp7MjMvzi
         PlzXjLVRFGYKfM+ZZqJ3lkPfw+eGfTIsIIihT04XkdrcDEB0kCXx2cpnFKZbvTSZQwfl
         NBbL4bB/w5BDwDILhfZsGO0Kk5BgwhnA2TtmZfedgG0fGZ8Kif2FQyQmWF4MwhriOi29
         DI9A92o/Lcjx9yo1Hu7HlY/63RnuRDbNVGBBpWTdRCar1ITD6ufCuTpoe56axxviDkoo
         p4/g==
X-Gm-Message-State: AGi0PuZf2AA9xLv8NZ6TpiaZg606kSvTDpdQPxZVTHcDi1Q1US1RHoJp
        AhYgAi2orbs+H0xivh98n88bDGfFOncpWQ==
X-Google-Smtp-Source: APiQypI5WOqfV+BNdwG2elZiOjsNXt4z0SamM3dBgTM8llKL4HUvMwa58yu1y9cgwLhbQ9rAJkP5PQ==
X-Received: by 2002:a17:902:6949:: with SMTP id k9mr7266625plt.211.1587439688499;
        Mon, 20 Apr 2020 20:28:08 -0700 (PDT)
Received: from localhost.localdomain ([115.96.129.58])
        by smtp.gmail.com with ESMTPSA id i9sm944868pfk.199.2020.04.20.20.28.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 20:28:07 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     Ani Sinha <ani@anisinha.ca>, Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pciehp: Cleanup unused EMI() and HP_SUPR_RM() macros
Date:   Tue, 21 Apr 2020 08:57:50 +0530
Message-Id: <1587439673-39652-1-git-send-email-ani@anisinha.ca>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We do not use PCIE hotplug surprise (PCI_EXP_SLTCAP_HPS) bit anymore.
Consequently HP_SUPR_RM() macro is no longer used. Let's clean it up.
EMI() macro also seems to be unused. So removing it as well. Thanks
Mika Westerberg <mika.westerberg@linux.intel.com> for
pointing it out.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/pciehp.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index ae44f46..4fd200d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -148,8 +148,6 @@ struct controller {
 #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define HP_SUPR_RM(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_HPS)
-#define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
-- 
2.7.4

