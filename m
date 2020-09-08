Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E827C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F24332087D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 22:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599603477;
	bh=KU6wrC5tJcOoOBOhcpJ3sxhERTP0+1qkEGo5UsY2E4Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=se/z4EXOZuEOHrfLGkEkcS4xJLc6Ltt0tamafPsoAc9ibvCdPXZI9KpQaV9GGx1x1
	 gR6T+lS+FtEEfpGyLQwYNN56bOh8I08S9R9bDWiEdl+VTznFaCGs0Ms/qS9ri1KOGn
	 8ey6XdoDXndW1v5500WbpONLSBtfgN4qQVthXYR0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729785AbgIHWRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:17:55 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:47314 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729037AbgIHWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:17:53 -0400
Received: from oscar.flets-west.jp (softbank126090211135.bbtec.net [126.90.211.135]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 088MGrFj012572;
        Wed, 9 Sep 2020 07:16:53 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 088MGrFj012572
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1599603414;
        bh=WB8vckX/90tGacfzSunXHhuYCkqvIfPGjxJ91cYrgWg=;
        h=From:To:Cc:Subject:Date:From;
        b=LQZcLC/NYCIDMT5bR6pKayYjGAcL9tY2C4kobxAIFaz4pPMvCqwRER/lyrdMOXY/V
         xgRGyRUnRybHzBwAs1sGuqipMGfIqKpsSmX1DA6hittc3CTpBGO6JnF60vRzfD6Efb
         jitCB3mvl6vOx6WQC6c9SkS7fTSPp5GaI0WKg8XMcMnDOZiEBcooHoUZhnDjNNX+YN
         VI+5PoSQcj1ix3gEcFE45EfqnSY548iuRowVly5EdV2/qVm4PYUyYJSpXnxl6uBiXI
         ZYikmehNOFClg96erdgi6vY+nrUjysSPx2+7A/dK1FSYBIbKTYR07eSenjB4iXcJn+
         StkYKww1a/zdQ==
X-Nifty-SrcIP: [126.90.211.135]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] kconfig: qconf: use delete[] instead of delete to free array (again)
Date:   Wed,  9 Sep 2020 07:16:37 +0900
Message-Id: <20200908221638.2782778-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c9b09a9249e6 ("kconfig: qconf: use delete[] instead of delete
to free array") fixed two lines, but there is one more.
(cppcheck does not report it for some reason...)

This was detected by Clang.

"make HOSTCXX=clang++ xconfig" reports the following:

scripts/kconfig/qconf.cc:1279:2: warning: 'delete' applied to a pointer that was allocated with 'new[]'; did you mean 'delete[]'? [-Wmismatched-new-delete]
        delete data;
        ^
              []
scripts/kconfig/qconf.cc:1239:15: note: allocated with 'new[]' here
        char *data = new char[count + 1];
                     ^

Fixes: c4f7398bee9c ("kconfig: qconf: make debug links work again")
Fixes: c9b09a9249e6 ("kconfig: qconf: use delete[] instead of delete to free array")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/qconf.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index 8638785328a7..c7216b9110fc 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1276,7 +1276,7 @@ void ConfigInfoView::clicked(const QUrl &url)
 	}
 
 	free(result);
-	delete data;
+	delete[] data;
 }
 
 void ConfigInfoView::contextMenuEvent(QContextMenuEvent *event)
-- 
2.25.1

