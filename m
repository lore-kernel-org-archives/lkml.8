Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFC6C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C07220663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 13:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="WP2Bpp/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgD0NbR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 09:31:17 -0400
Received: from gateway24.websitewelcome.com ([192.185.51.209]:46113 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgD0NbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 09:31:16 -0400
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway24.websitewelcome.com (Postfix) with ESMTP id D6DB43E9D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 08:31:15 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id T3qtjnnR71s2xT3qtjP87c; Mon, 27 Apr 2020 08:31:15 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=u/AtXVQZQDeyOWLlSEt0iZP+7VfyY7UfSrB499GC3Eg=; b=WP2Bpp/HzMq4hpFAHgnEDTICqE
        UKzq/vJRHg36ikTS/tCxoJyGRcAf+tQxlpLzFdLDkCpuR35aocMXdQSI1mfqJQ/JOqM+hHxy2wDki
        wS/Z65a7Qr0UV/ApSMjk59yavNy31GMBGQr8uIXjnv4v0ozihrgtypBiHmo80+xsSx+cECSXwbnxD
        DVVhjCeZTRcY+ZALUkEU8kb2AiK8PlT2RJ26W07wcZJ5Teemv0TLagZArZRvdTcyxRs4AgzJLseTv
        vrA8gGgizXFoeIX7jucM3w5MBA7HM+9GHquhvkkSpKaPTpp5uIxxm+yqixedYJIRtI89MC8qcfBtz
        6nGB3S0A==;
Received: from [201.162.241.110] (port=6093 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1jT3qt-002BH9-I3; Mon, 27 Apr 2020 08:31:15 -0500
Date:   Mon, 27 Apr 2020 08:35:33 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] objtool: orc_gen: Fix memory leak in create_orc_entry
Message-ID: <20200427133533.GA20830@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.162.241.110
X-Source-L: No
X-Exim-ID: 1jT3qt-002BH9-I3
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [201.162.241.110]:6093
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for rela were allocated, release them before
return.

Addresses-Coverity-ID: 1462331 ("Resource leak")
Fixes: e81e07244325 ("objtool: Support Clang non-section symbols in ORC generation")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 tools/objtool/orc_gen.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/objtool/orc_gen.c b/tools/objtool/orc_gen.c
index 4c0dabd28000..07b67b1576d7 100644
--- a/tools/objtool/orc_gen.c
+++ b/tools/objtool/orc_gen.c
@@ -120,6 +120,7 @@ static int create_orc_entry(struct elf *elf, struct section *u_sec, struct secti
 		if (!rela->sym) {
 			WARN("missing symbol for insn at offset 0x%lx\n",
 			     insn_off);
+			free(rela);
 			return -1;
 		}
 
-- 
2.26.0

