Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90149C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A149206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 12:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=anisinha-ca.20150623.gappssmtp.com header.i=@anisinha-ca.20150623.gappssmtp.com header.b="daZG3iGd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728497AbgDTMwU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728009AbgDTMwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 08:52:17 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16736C061A0F
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:52:17 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g6so4986372pgs.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 05:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anisinha-ca.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=MAn7hGAHod1EC34/XC7X7Tj9BVqJ/NY2c4VQxrVpxx4=;
        b=daZG3iGdMhlZvCUWmVEiIQPAN6UZg2Qus2SFPnwoIfmc+BBFV+I59x3aN+XR7ZiuyC
         uVXuH2J9d+6o0kUUSx8a9Fdfu9mELZ1pGfqiIvWfctQ+k5DHIayt/Hd80VX4oncWf0bi
         7OaYA5rsFeBrcH6cYzSoDQ6FF/+spn5pBNcl4jIiNGjKfg7m3Ff0uD+C5jJ6OLan+EOz
         B2SqolzEi0REFw2DdkMkTWW5ehMOY7IrcX6L4V0TUI4K0EWQsB0RST5N65TFiGKS709h
         /5e05xO/i659emkH97AbLRoYSf2/P9AjtfM8ZgTzmVMmgE4nyasT6XiPHuz/nQ9rml6k
         cWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MAn7hGAHod1EC34/XC7X7Tj9BVqJ/NY2c4VQxrVpxx4=;
        b=LfI0QAJ+z7jlHUp6f1yEmgqJkUYhnbJ4cqGRwYheUIEwpHnaRCvsMPmfvhpNDSpmqP
         FXG2I2HRPbQzNChQ9aMgv+z/yX0BcfaziOsiSuWlXseReyQh5oz1Vnni1ad0FDWSf15A
         nTP8/COy+ewvcsVAUVJmjqi1gM0tw1suDHRFkagZXubTdX43MemkQmXIQoAivp8ki4U2
         KqucSY0Brmusdq3zXhbNE8+f+JSPyH8bTygR1Q7NIrbXsGPHyS2tv26YqM7NHAgnpp1x
         kWjazNJXx7BiKT+OaYkcTAh5+xlql8Tsc2jzdffyJNhyc3k8doNlcF4HQomd7D4hgZ+p
         kWvw==
X-Gm-Message-State: AGi0PuZH+Pr6soOtFHQ+F+eHpoKumhXFBDyvVhH5+9+dOxxYw/BdDM0W
        SikMqxFbzDA/f7o18jCHdJ54FtpU+bzVYA==
X-Google-Smtp-Source: APiQypKjGYhisQKGfpwiryIzO08I2KAUmHs+YFxoaLHHjdOFdkb5X2HMDeQGuuuJMPwGpaWq1ouRpA==
X-Received: by 2002:a62:83c3:: with SMTP id h186mr5992058pfe.192.1587387136218;
        Mon, 20 Apr 2020 05:52:16 -0700 (PDT)
Received: from localhost.localdomain ([203.163.233.7])
        by smtp.gmail.com with ESMTPSA id z7sm1052038pff.47.2020.04.20.05.52.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 05:52:15 -0700 (PDT)
From:   Ani Sinha <ani@anisinha.ca>
To:     linux-kernel@vger.kernel.org
Cc:     ani@anirban.org, Ani Sinha <ani@anisinha.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Denis Efremov <efremov@linux.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org
Subject: [PATCH] PCI: pciehp: remove unused EMI() macro
Date:   Mon, 20 Apr 2020 18:21:41 +0530
Message-Id: <1587387114-38475-1-git-send-email-ani@anisinha.ca>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMI() macro seems to be unused. So removing it. Thanks
Mika Westerberg <mika.westerberg@linux.intel.com> for
pointing it out.

Signed-off-by: Ani Sinha <ani@anisinha.ca>
---
 drivers/pci/hotplug/pciehp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 5747967..4fd200d 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -148,7 +148,6 @@ struct controller {
 #define MRL_SENS(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_MRLSP)
 #define ATTN_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_AIP)
 #define PWR_LED(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_PIP)
-#define EMI(ctrl)		((ctrl)->slot_cap & PCI_EXP_SLTCAP_EIP)
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
-- 
2.7.4

