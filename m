Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9098FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6652320659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591659636;
	bh=/YRsKm+UuUQSjVNhO4o+amEOfE2Aw0EN2Skl2Q46c+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AcsM42NOQP5+RWkkVvCAyel6qnch0bG7d1P/4X/aVz9rK1HwzmDXZycWhXMhE4/bR
	 xVeRo99lhyGEhWa7+mfxh0o1WK5HPqiJ9odv2aZ+5Yqz7ospCDIReeGEJ0rwiA1NSR
	 d6uJF+wxjBqa/ay/ioXe9bqZpkPkct+WNUBPUimU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731298AbgFHXkf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 19:40:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387652AbgFHX15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:27:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3BBC2078D;
        Mon,  8 Jun 2020 23:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658876;
        bh=/YRsKm+UuUQSjVNhO4o+amEOfE2Aw0EN2Skl2Q46c+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XlzgRtEvqdwatrhZbXTo49dsYknthHFdIzfw1gw79pARgJDd+4fG/z5aIt/9Kmy1y
         4v83bhWLQEkG9QAZry8VFT/ksuxbWVUCTSog6ub7nr6CpnTooYp5mbV+OYlCUOroZW
         yZ40m3IeQaOPmmD2Y/blKCRd0MaBDZEuus5FKvPM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.4 05/37] kgdb: Prevent infinite recursive entries to the debugger
Date:   Mon,  8 Jun 2020 19:27:17 -0400
Message-Id: <20200608232750.3370747-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608232750.3370747-1-sashal@kernel.org>
References: <20200608232750.3370747-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 3ca676e4ca60d1834bb77535dafe24169cadacef ]

If we detect that we recursively entered the debugger we should hack
our I/O ops to NULL so that the panic() in the next line won't
actually cause another recursion into the debugger.  The first line of
kgdb_panic() will check this and return.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
Link: https://lore.kernel.org/r/20200507130644.v4.6.I89de39f68736c9de610e6f241e68d8dbc44bc266@changeid
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/debug_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 79517e5549f1..9c939c6bf21c 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -443,6 +443,7 @@ static int kgdb_reenter_check(struct kgdb_state *ks)
 
 	if (exception_level > 1) {
 		dump_stack();
+		kgdb_io_module_registered = false;
 		panic("Recursive entry to debugger");
 	}
 
-- 
2.25.1

