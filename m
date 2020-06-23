Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDC0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F69207D0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 17:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592933760;
	bh=GuBg9zawM+COZU4inY++LihMQDzGpzNZf7fiaUiOm7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JkddtAcfsTY+tcfcQInUjkCXsucupqrCfKpZjKUC/YYeijXGIB9K1xydCdOaq5Fa4
	 sF8RX1gPM7e2i09ysAPV3S62iMfcJotHCvRdj/I1uvvtAzAAXZDTG9b+W0W4NCIbtF
	 GXViOyMAgDciT0uYuXMwFndIdSQem7gijKy4LN8s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387436AbgFWRf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 13:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733300AbgFWRfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CED6E207E8;
        Tue, 23 Jun 2020 17:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592933749;
        bh=GuBg9zawM+COZU4inY++LihMQDzGpzNZf7fiaUiOm7A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nx41VsEaLYo64VWS1bXXLkdDMumjb6Npedsm5e3ESaujfrwNlq6iWxtPNsxteE1ST
         lYUt06iwYEVbRUkDlJCbxJEY9v8+kVuMltQFENWxVSXhFzlIFMIsJQcrQIP5wC+bET
         n6XklMx0S1doVvVKIyViL9R/xPRfTkZID0zHDJzQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Will Deacon <will@kernel.org>, Dave Martin <Dave.Martin@arm.com>,
        Qian Cai <cai@lca.pw>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 21/28] arm64: sve: Fix build failure when ARM64_SVE=y and SYSCTL=n
Date:   Tue, 23 Jun 2020 13:35:16 -0400
Message-Id: <20200623173523.1355411-21-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200623173523.1355411-1-sashal@kernel.org>
References: <20200623173523.1355411-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Will Deacon <will@kernel.org>

[ Upstream commit e575fb9e76c8e33440fb859572a8b7d430f053d6 ]

When I squashed the 'allnoconfig' compiler warning about the
set_sve_default_vl() function being defined but not used in commit
1e570f512cbd ("arm64/sve: Eliminate data races on sve_default_vl"), I
accidentally broke the build for configs where ARM64_SVE is enabled, but
SYSCTL is not.

Fix this by only compiling the SVE sysctl support if both CONFIG_SVE=y
and CONFIG_SYSCTL=y.

Cc: Dave Martin <Dave.Martin@arm.com>
Reported-by: Qian Cai <cai@lca.pw>
Link: https://lore.kernel.org/r/20200616131808.GA1040@lca.pw
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kernel/fpsimd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kernel/fpsimd.c b/arch/arm64/kernel/fpsimd.c
index 4a77263c183b3..befc5a715dc4e 100644
--- a/arch/arm64/kernel/fpsimd.c
+++ b/arch/arm64/kernel/fpsimd.c
@@ -349,7 +349,7 @@ static unsigned int find_supported_vector_length(unsigned int vl)
 	return sve_vl_from_vq(__bit_to_vq(bit));
 }
 
-#ifdef CONFIG_SYSCTL
+#if defined(CONFIG_ARM64_SVE) && defined(CONFIG_SYSCTL)
 
 static int sve_proc_do_default_vl(struct ctl_table *table, int write,
 				  void __user *buffer, size_t *lenp,
@@ -395,9 +395,9 @@ static int __init sve_sysctl_init(void)
 	return 0;
 }
 
-#else /* ! CONFIG_SYSCTL */
+#else /* ! (CONFIG_ARM64_SVE && CONFIG_SYSCTL) */
 static int __init sve_sysctl_init(void) { return 0; }
-#endif /* ! CONFIG_SYSCTL */
+#endif /* ! (CONFIG_ARM64_SVE && CONFIG_SYSCTL) */
 
 #define ZREG(sve_state, vq, n) ((char *)(sve_state) +		\
 	(SVE_SIG_ZREG_OFFSET(vq, n) - SVE_SIG_REGS_OFFSET))
-- 
2.25.1

