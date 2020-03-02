Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1455BC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E050A246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137147;
	bh=Vu4drSBZdJ6r65+/VIWN4lBc7AM9+f6OSc5S/+zCBBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=a3TOumqtfRVl7jx+OYvxv4vMzHETCFiqhSAfzICTa15dwKiEGE7FlS3BJiB0e7FV3
	 GUOHMif63np7tCG2T5U8QFb6iW6ql1JBwHibUVBXok1fkqcz7nN3/dPqusBGiy05+c
	 Qe7aOr4O6Hjq4L7HWRiUDTEn6mxHR3kj1ZH+vQqY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgCBITC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:19:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:57148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbgCBIQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:20 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 54CD7246DD;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=Vu4drSBZdJ6r65+/VIWN4lBc7AM9+f6OSc5S/+zCBBo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdNSbkpwRLfbaB+SWyiEcSivpHFnSpfgHOey/uObQvn+5c+opil/E7Wy772vrNOQX
         gWan4TC/NXqgvbnIxmfp+XJLDQHWa0gMkLLDVF7yPMLIOXYtWuF860hNS6EHJKzEZZ
         4nRDirKgdNBg44a0MvU5gOtKNub7Uw+GPIkdGgco=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003y8-Hb; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 20/42] docs: scsi: convert link_power_management_policy.txt to ReST
Date:   Mon,  2 Mar 2020 09:15:53 +0100
Message-Id: <c56177fdf046d80e0dec6031c4139cb4e8c39d31.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/index.rst                         |  1 +
 ...t_policy.txt => link_power_management_policy.rst} | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)
 rename Documentation/scsi/{link_power_management_policy.txt => link_power_management_policy.rst} (65%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index e6850c0a1378..c40050ac3b32 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -24,5 +24,6 @@ Linux SCSI Subsystem
    hpsa
    hptiop
    libsas
+   link_power_management_policy
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/link_power_management_policy.txt b/Documentation/scsi/link_power_management_policy.rst
similarity index 65%
rename from Documentation/scsi/link_power_management_policy.txt
rename to Documentation/scsi/link_power_management_policy.rst
index d18993d01884..64288dcf10f6 100644
--- a/Documentation/scsi/link_power_management_policy.txt
+++ b/Documentation/scsi/link_power_management_policy.rst
@@ -1,8 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========================
+Link Power Managent Policy
+==========================
+
 This parameter allows the user to set the link (interface) power management.
 There are 3 possible options:
 
+=====================   =====================================================
 Value			Effect
-----------------------------------------------------------------------------
+=====================   =====================================================
 min_power		Tell the controller to try to make the link use the
 			least possible power when possible.  This may
 			sacrifice some performance due to increased latency
@@ -15,5 +22,4 @@ max_performance		Generally, this means no power management.  Tell
 medium_power		Tell the controller to enter a lower power state
 			when possible, but do not enter the lowest power
 			state, thus improving latency over min_power setting.
-
-
+=====================   =====================================================
-- 
2.21.1

