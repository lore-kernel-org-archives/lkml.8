Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96846C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7554320730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgD1VhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:37:19 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46569 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD1VhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:37:18 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MPXMa-1jqB8k2Rve-00MfDB; Tue, 28 Apr 2020 23:37:12 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Sanjay R Mehta <sanju.mehta@amd.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: spi-amd: remove unused variable
Date:   Tue, 28 Apr 2020 23:37:02 +0200
Message-Id: <20200428213711.3643464-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RUUlGlElSt8VH6YuqnzdRtPfaVA3sQMv/NlNARHgl21NMn/5LO8
 VyuPmscDcKLjnGixtTm/+Db0LL+SXiFq3g5Zwmb1lJq7KOLf/GNO7fEZV75YNjVewbIJzy0
 lIJcG6MbX7pZOoKjZZCBWBFDafemn6zR7UH5UMSeoJVZqGxUtCaX8vTVOYqnmzaxE85DgCO
 PcT+tS9OB9Kdcn+RaaSBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n9JyFrAgx6k=:qN1Gd//b2P8MBRloIfOtvt
 dUfzGjLDHeP6cPZhMow9nj3k7tk897P/06P5xGv9N6FWsvgz+0P1TqH9uaWEuavYXPdu6EN3d
 TdNKH5BZqDnm/qdQ3BEiEyaL6yaLau+4niqw/yLcYtChmH+QjLb7EAbj9cw2uON9+ruPzo+eD
 /+yiRfhrmXNprMYV/1Wo5bGjHXFucm4m0wI2oeYHpsfLjy44W2mLMNP/akSHF5QzGu7Gw9CGd
 8rEBSJdSc1dpYH/WASAOshm9L0JrEdMk30y3rlpubSUcrPtICZibMlCAxb4iBmm2L4JQAnoex
 HaZUZEP9sxvY5I3eypROot3BULvG+i3VTIRuLRJ0tmVJPScoTpU/TW2sXSqCc7XHFUq7h++RX
 TS6XvGpzj9YKTGmSgIRCrSw3Szm3QAqdErwlsU+cwafUAmHiv8GDjX50hrVILFVKRPcnL4uil
 08ZMIDmTi3pfRyp35u34ZUz/DQ7zu2ui4mDOoU9eqMYevb03I6OGrqb8HmTzrmdXcO2G5NqAS
 XRKmUt5h+T+Uu9VuXmIiy+K4qeUxqfcu9aOTpPxMRW1ej26TlmT6C99RSmBoy1z68P4oqENw2
 M6e813U0br8W14MLlLUrXvjPNK4BIba7xu+yRqr143XhD3S5sa8K//gU0NZ9C5bEPeq6urBg+
 0BwjUOcCIYtBZJrmZmLDxV8WydGzsdtABsMA3GXZdk11VgjpC7IEt2MSm3pVvFE+I+g9u3KDL
 TJofb3qQ6Vg0jSNUMTqFcztWhqxhKhMmy6PBhsioo6Jx1Z3+rSY3+ag6+ep1go2u9F9C2vUBC
 dAtS+imgoRoNZqxSP+LmwkuxXO+Xnir/AZDQv1n3SA5spEiR/w=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This variable was defined in the original version of this file but
never used, so remove it to avoid the warning:

drivers/spi/spi-amd.c: In function 'amd_spi_fifo_xfer':
drivers/spi/spi-amd.c:171:17: error: unused variable 'opcode' [-Werror=unused-variable]
  171 |  u8 cmd_opcode, opcode = 0;

Fixes: bbb336f39efc ("spi: spi-amd: Add AMD SPI controller driver support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-amd.c b/drivers/spi/spi-amd.c
index 0d9debe1386e..c5a16dd44fa3 100644
--- a/drivers/spi/spi-amd.c
+++ b/drivers/spi/spi-amd.c
@@ -168,7 +168,7 @@ static inline int amd_spi_fifo_xfer(struct amd_spi *amd_spi,
 {
 	struct spi_master *master = amd_spi->master;
 	struct spi_transfer *xfer = NULL;
-	u8 cmd_opcode, opcode = 0;
+	u8 cmd_opcode;
 	u8 *buf = NULL;
 	u32 m_cmd = 0;
 	u32 i = 0;
-- 
2.26.0

