Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE171C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D3392053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200989;
	bh=TSISONchIBp+xUE//FmsdxZpc75nor4ucgWf7/wmpMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ih6f2HfjnffZSm12p5L57B0pXmgZ58ug0Zo1YRiTKYxH7OYZcTeIcfp6L8J7X8OTc
	 9gxR4UZk6RZy90LF/qaXauXhql9whkc4f5GcLmYMGBqQtfV9C1HLe48A3s3SkP+lGl
	 sLsAA1b8kVS2F1EXNYnORV7R+5dbZPrPqoSBr45E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437198AbgAPS42 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:56:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:39078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389154AbgAPRHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:07:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 034C221582;
        Thu, 16 Jan 2020 17:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194441;
        bh=TSISONchIBp+xUE//FmsdxZpc75nor4ucgWf7/wmpMc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=clTf8MrixZ5TXXMHP0UqKd99eoONUgE/FGhvnj/O9WdrlMtHw/XQnZKDfMLCV1s/A
         oCqebzgvPu265XEcVdmIzDikwACm4iYZ49JsQEYW1fAwRswy7TcE7YeBHIJ6Tx5XfG
         VrloP2s4vGeMg0heKB1LZ8IJEqQM9F7R+LH2mM+w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Sasha Levin <sashal@kernel.org>,
        kgdb-bugreport@lists.sourceforge.net
Subject: [PATCH AUTOSEL 4.19 354/671] kdb: do a sanity check on the cpu in kdb_per_cpu()
Date:   Thu, 16 Jan 2020 11:59:52 -0500
Message-Id: <20200116170509.12787-91-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116170509.12787-1-sashal@kernel.org>
References: <20200116170509.12787-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit b586627e10f57ee3aa8f0cfab0d6f7dc4ae63760 ]

The "whichcpu" comes from argv[3].  The cpu_online() macro looks up the
cpu in a bitmap of online cpus, but if the value is too high then it
could read beyond the end of the bitmap and possibly Oops.

Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/debug/kdb/kdb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
index f338d23b112b..dc6bf35e7884 100644
--- a/kernel/debug/kdb/kdb_main.c
+++ b/kernel/debug/kdb/kdb_main.c
@@ -2604,7 +2604,7 @@ static int kdb_per_cpu(int argc, const char **argv)
 		diag = kdbgetularg(argv[3], &whichcpu);
 		if (diag)
 			return diag;
-		if (!cpu_online(whichcpu)) {
+		if (whichcpu >= nr_cpu_ids || !cpu_online(whichcpu)) {
 			kdb_printf("cpu %ld is not online\n", whichcpu);
 			return KDB_BADCPUNUM;
 		}
-- 
2.20.1

