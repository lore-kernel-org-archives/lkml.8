Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BE8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0822076C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 01:08:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591664904;
	bh=PG0qiH2KEanMcWHB5FHf6WHtqvnKB05Xm9dmC6kGVQA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DBrulnMvSL+aJheVEJJpm+RQ34o9HaSralouF1Uq33eGawrjOxxqmG1oqZWUpjeZb
	 36/3y+0abFaANwmCLwXa6MZDQ+VmIDVPTf7EBa5lJ9mapnAX+cbqxAkyBun/A7Q1QQ
	 IGZnWFmWjQ63eYvEPXrhfrwP7ON575gkg14kfBsk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388223AbgFIBIX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 21:08:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:50044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727076AbgFHXGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:06:48 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B8EB20775;
        Mon,  8 Jun 2020 23:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591657607;
        bh=PG0qiH2KEanMcWHB5FHf6WHtqvnKB05Xm9dmC6kGVQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmJfWDAQ3hLW+8uWpVXf4bpBV29BISzh1lslYqykuhQPSPR1kB3AnR0e19Nhdepal
         mT07F/I5CIlT40wvpGUUmYvRb+fOidbqg5de6ySkdCyIyxeYIHr/1ixQvFpW1lo3ht
         2/y8/4bB0ai8/0RgBriVwBpYNVGirgPaVirJ7+EY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.7 032/274] arm64: cacheflush: Fix KGDB trap detection
Date:   Mon,  8 Jun 2020 19:02:05 -0400
Message-Id: <20200608230607.3361041-32-sashal@kernel.org>
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

From: Daniel Thompson <daniel.thompson@linaro.org>

[ Upstream commit ab8ad279ceac4fc78ae4dcf1a26326e05695e537 ]

flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
trap handler is running because issuing IPIs is unsafe (and not needed)
in this execution context. However the current test, based on
kgdb_connected is flawed: it both over-matches and under-matches.

The over match occurs because kgdb_connected is set when gdb attaches
to the stub and remains set during normal running. This is relatively
harmelss because in almost all cases irq_disabled() will be false.

The under match is more serious. When kdb is used instead of kgdb to access
the debugger then kgdb_connected is not set in all the places that the
debug core updates sw breakpoints (and hence flushes the icache). This
can lead to deadlock.

Fix by replacing the ad-hoc check with the proper kgdb macro. This also
allows us to drop the #ifdef wrapper.

Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20200504170518.2959478-1-daniel.thompson@linaro.org
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/cacheflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
index e6cca3d4acf7..ce50c1f1f1ea 100644
--- a/arch/arm64/include/asm/cacheflush.h
+++ b/arch/arm64/include/asm/cacheflush.h
@@ -79,7 +79,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 	 * IPI all online CPUs so that they undergo a context synchronization
 	 * event and are forced to refetch the new instructions.
 	 */
-#ifdef CONFIG_KGDB
+
 	/*
 	 * KGDB performs cache maintenance with interrupts disabled, so we
 	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
@@ -89,9 +89,9 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
 	 * the patching operation, so we don't need extra IPIs here anyway.
 	 * In which case, add a KGDB-specific bodge and return early.
 	 */
-	if (kgdb_connected && irqs_disabled())
+	if (in_dbg_master())
 		return;
-#endif
+
 	kick_all_cpus_sync();
 }
 
-- 
2.25.1

