Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB7020890
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591661630;
	bh=y9zSkmYavV66nnxayzuBc+0Uy2uqrPOcA5zKy48njpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ra4S92u8RrX2i2K8D/gAyzRHcg6jK4Ty+iYWjlXoAihMnICD/6bqV7Zh/E2NFyyxz
	 SpOqmwKe/kguPIsXSdFFHQFfuWWMxp8LN6nLQpkhc41ty4WobBkImBQO/8TUcGAbmN
	 S43v9avxWvf/BWVSkoULxSO6TehJ/KWq8WHPd6yA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730592AbgFIANt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:13:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:42176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730774AbgFHXTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:19:23 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC5462083E;
        Mon,  8 Jun 2020 23:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658363;
        bh=y9zSkmYavV66nnxayzuBc+0Uy2uqrPOcA5zKy48njpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1jffN2WUfaAqgsEqOU356/OOmXVK3vUBFbc0ctFvZMy5j5KIRqnFGUiTqg17GVi84
         HgwbURCBJX8Y0ITlcBcVowP6iBAwkfhdHVsbEr8+0mb+CRZOsQWpSuhcMUyeHBrG+v
         GU+4DbyD7troqem7ULR6QGFdsGoPNcOfDHGX71z8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Borislav Petkov <bp@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 028/175] x86/cpu/amd: Make erratum #1054 a legacy erratum
Date:   Mon,  8 Jun 2020 19:16:21 -0400
Message-Id: <20200608231848.3366970-28-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231848.3366970-1-sashal@kernel.org>
References: <20200608231848.3366970-1-sashal@kernel.org>
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
index c3f4dd4ae155..c553cafd0736 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1117,8 +1117,7 @@ static const int amd_erratum_383[] =
 
 /* #1054: Instructions Retired Performance Counter May Be Inaccurate */
 static const int amd_erratum_1054[] =
-	AMD_OSVW_ERRATUM(0, AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
-
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
 {
-- 
2.25.1

