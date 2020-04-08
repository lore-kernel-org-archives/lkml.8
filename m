Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 138B1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEA0A2075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360814;
	bh=eBOZxoYZIMRnDM3jqbg57vKJcreJqVFOz+37SNmuNs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQh07Xle5xZSv7EafZnOLSDo2iHrXH2Ysyrw5hnKuiunQj8AGzoQgDSHLQ7cebI/U
	 G8VBsCYd4xqKv5+vn5TQsRoFdXwpN9rPI0pudQgTEoJ8lbn0iR7cEOdGH+lvTQcmUK
	 9+IuDY922y/UJp1eJA/ywy88N+Q86aOKGHbk8dRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgDHPqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:46:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbgDHPqb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:31 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15F992076D;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=eBOZxoYZIMRnDM3jqbg57vKJcreJqVFOz+37SNmuNs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3ew244OM/fx4Cu3h9fPyfLf7dGPK1IEjnzkaAzjeJ2pyU6ExxesMqoeXxReWfjUa
         rxrbcrR0NGhGZQbGRLKGMKe7Uqx562qkP1V9lqdNJEfL633G8HdHKuUkhtyLOOXUZS
         3NUC+M8hmFEKiw5lHbohoYAWA7LUdlKXdg+4XZv8=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cAh-9J; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 06/35] docs: amu: supress some Sphinx warnings
Date:   Wed,  8 Apr 2020 17:45:58 +0200
Message-Id: <0063550dd4dd03ec746c056d4d5db447f825a1a8.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add extra blank lines on some places, in order to avoid those
warnings when building the docs:

    Documentation/arm64/amu.rst:26: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:60: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:81: WARNING: Unexpected indentation.
    Documentation/arm64/amu.rst:108: WARNING: Unexpected indentation.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/arm64/amu.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/arm64/amu.rst b/Documentation/arm64/amu.rst
index 5057b11100ed..452ec8b115c2 100644
--- a/Documentation/arm64/amu.rst
+++ b/Documentation/arm64/amu.rst
@@ -23,6 +23,7 @@ optional external memory-mapped interface.
 
 Version 1 of the Activity Monitors architecture implements a counter group
 of four fixed and architecturally defined 64-bit event counters.
+
   - CPU cycle counter: increments at the frequency of the CPU.
   - Constant counter: increments at the fixed frequency of the system
     clock.
@@ -57,6 +58,7 @@ counters, only the presence of the extension.
 
 Firmware (code running at higher exception levels, e.g. arm-tf) support is
 needed to:
+
  - Enable access for lower exception levels (EL2 and EL1) to the AMU
    registers.
  - Enable the counters. If not enabled these will read as 0.
@@ -78,6 +80,7 @@ are not trapped in EL2/EL3.
 
 The fixed counters of AMUv1 are accessible though the following system
 register definitions:
+
  - SYS_AMEVCNTR0_CORE_EL0
  - SYS_AMEVCNTR0_CONST_EL0
  - SYS_AMEVCNTR0_INST_RET_EL0
@@ -93,6 +96,7 @@ Userspace access
 ----------------
 
 Currently, access from userspace to the AMU registers is disabled due to:
+
  - Security reasons: they might expose information about code executed in
    secure mode.
  - Purpose: AMU counters are intended for system management use.
@@ -105,6 +109,7 @@ Virtualization
 
 Currently, access from userspace (EL0) and kernelspace (EL1) on the KVM
 guest side is disabled due to:
+
  - Security reasons: they might expose information about code executed
    by other guests or the host.
 
-- 
2.25.2

