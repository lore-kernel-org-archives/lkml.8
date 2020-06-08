Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60AEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FFC12076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664864;
	bh=rBWiZvWqsDNBGLOZcEsUl4b/4HinwzVnrDOhaM190ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MJJttjBkeVDhdxwYJ9NBZE0SNhT2pxe+gwCMegUkih4aCJ6FSMiyYJ3AIfVT/MT+q
	 MorhpcBEMuWmADvZQH32Hft4a5wQBYc0hwCLgaDYlqUsD6JvdCe4hP/LmWRA2WWYfe
	 PBKuppA3OH/ouR1/hSm156xSInyipNll/kWmzRYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbgFIBHn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:07:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:50410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727094AbgFHXGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2655F2083E;
        Mon,  8 Jun 2020 23:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657614;
        bh=rBWiZvWqsDNBGLOZcEsUl4b/4HinwzVnrDOhaM190ko=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D9JHUwC0UPtNPPNiMfx7OYY6ulqaJh6pTPAUPDIBg/l9HCXJQFy1f12Z2XB20qOBp
         aLhRU/BAILIuRCIudhgBAQvgnWE03wzPtuvzQU2lk970LoExNuYkeIyN5Wrzkv1pML
         u9g3zMX0D0AbA6ctY2opmswA6qULR8pOCqCIeeDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.7 037/274] x86/cpu/amd: Make erratum #1054 a legacy erratum
Date:   Mon,  8 Jun 2020 19:02:10 -0400
Message-Id: <20200608230607.3361041-37-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608230607.3361041-1-sashal@kernel.org>
References: <20200608230607.3361041-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kim Phillips <kim.phillips@amd.com>

[ Upstream commit e2abfc0448a46d8a137505aa180caf14070ec535 ]

Commit

  21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired
		 counter IRPERF")

mistakenly added erratum #1054 as an OS Visible Workaround (OSVW) ID 0.
Erratum #1054 is not OSVW ID 0 [1], so make it a legacy erratum.

There would never have been a false positive on older hardware that
has OSVW bit 0 set, since the IRPERF feature was not available.

However, save a couple of RDMSR executions per thread, on modern
system configurations that correctly set non-zero values in their
OSVW_ID_Length MSRs.

[1] Revision Guide for AMD Family 17h Models 00h-0Fh Processors. The
revision guide is available from the bugzilla link below.

Fixes: 21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired counter IRPERF")
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200417143356.26054-1-kim.phillips@amd.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/amd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 547ad7bbf0e0..8a1bdda895a4 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1142,8 +1142,7 @@ static const int amd_erratum_383[] =
 
 /* #1054: Instructions Retired Performance Counter May Be Inaccurate */
 static const int amd_erratum_1054[] =
-	AMD_OSVW_ERRATUM(0, AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
-
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
-- 
2.25.1

