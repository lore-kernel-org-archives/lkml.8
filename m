Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE6E1C3F2D6
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A510220656
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 19:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="ZRTjGimW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFTSv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 14:18:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.50]:29864 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgCFTSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 14:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1583522329;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=5ViLUKR6NPVXPDD0tHLN/Wh2GAFU8Je9gBpC1tbyjlc=;
        b=ZRTjGimWHsAlA/l5DaGnSd2K4bUw32YOdY08Wbv3ywTqci78Ti+RCCcAkTcBWg51QJ
        sQxOd2/uKnGuzP7oVYWiD+SiY2QrpPEkyRPEPCTmA5LjtZxDLWHBuwCVdS6/NmDh4r0y
        B3g5Jcsy3MQtekAEx19e/eBvtRKcikOWEfR59tcNAP0e/mIa3zka8NYiXc2QObVb9lRR
        PjUX2wczaV7nr62ncMjUcy/lb6iPsq2t7yNgDZfBPsfCgPC/enbtUoddtF5ItSfhPuP6
        9Bu5prgfbtrCN2NDcr33C8XCtHbjU/c1UHc0FBoMBOEt4oGaz7HtQpXoZRPdQMGkgzrl
        x+oA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH6GQjzrz4="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.2.0 DYNA|AUTH)
        with ESMTPSA id y0a02cw26JHxa6z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 6 Mar 2020 20:17:59 +0100 (CET)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        kbuild test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, malat@debian.org,
        paul@crapouillou.net
Subject: [PATCH] nvmem: jz4780-efuse: fix build warnings on ARCH=x86_64 or riscv
Date:   Fri,  6 Mar 2020 20:17:58 +0100
Message-Id: <79e1dec195d287001515600b1dae0bcaa33fbf65.1583522277.git.hns@goldelico.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-robot did find a type error in the min(a, b)
function used by this driver if built for x86_64 or riscv.

Althought it is very unlikely that this driver is built
for those platforms it could be used as a template
for something else and therefore should be correct.

The problem is that we implicitly cast a size_t to
unsigned int inside the implementation of the min() function.

Since size_t may differ on different compilers and
plaforms there may be warnings or not.

So let's use only size_t variables on all platforms.

Reported-by: kbuild test robot <lkp@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: srinivas.kandagatla@linaro.org
Cc: prasannatsmkumar@gmail.com
Cc: malat@debian.org
Cc: paul@crapouillou.net
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 drivers/nvmem/jz4780-efuse.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/jz4780-efuse.c b/drivers/nvmem/jz4780-efuse.c
index 51d140980b1e..512e1872ba36 100644
--- a/drivers/nvmem/jz4780-efuse.c
+++ b/drivers/nvmem/jz4780-efuse.c
@@ -72,9 +72,9 @@ static int jz4780_efuse_read(void *context, unsigned int offset,
 	struct jz4780_efuse *efuse = context;
 
 	while (bytes > 0) {
-		unsigned int start = offset & ~(JZ_EFU_READ_SIZE - 1);
-		unsigned int chunk = min(bytes, (start + JZ_EFU_READ_SIZE)
-					 - offset);
+		size_t start = offset & ~(JZ_EFU_READ_SIZE - 1);
+		size_t chunk = min(bytes, (start + JZ_EFU_READ_SIZE)
+				    - offset);
 		char buf[JZ_EFU_READ_SIZE];
 		unsigned int tmp;
 		u32 ctrl;
-- 
2.23.0

