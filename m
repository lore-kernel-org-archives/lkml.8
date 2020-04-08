Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB37C2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:58:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69EB4206BE
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbgDHS6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 14:58:49 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:37099 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgDHS6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 14:58:49 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MGygv-1jZCCz0Nmt-00E1gj; Wed, 08 Apr 2020 20:58:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org, Roy Pledge <Roy.Pledge@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Roy Pledge <roy.pledge@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: fsl: dpio: avoid stack usage warning
Date:   Wed,  8 Apr 2020 20:58:16 +0200
Message-Id: <20200408185834.434784-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:OMkgMNWoYNK/PYjxHVjJrtynoXO5dAEnVqvJJrotBwWM8OSqNDq
 n4/wTu1RDdSuijIRMT/mKwLuNyQZl8Spgdi3psfPPgmqchFO/006ZOGM6IvvXihw0jMEQi1
 56J/m8kvXJHYcy8SPcnZjVa8G7StP/ndGlz4sf5dHsUPDnKJRVesO0rqywtdqf/bapOepvt
 OKslwjMqHRgGccZbrwpSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FCcX7YDJ1SE=:HKXDNdhc8sGxe1mtuppB6o
 mNmFSw1aHUeW3PHd0utVq7MbM9hZtK7P2kMs3wB2sMRmfTu/sR6BDCNGTHKA55YiFdHkcgSdk
 G4rrvwRO9Y7We+a/w1sUviQ2Upxly0ybzU1ScFiEWt20sBqo8HdsFSCLiTry+cDfDJuGdeeap
 Ra8FVq9WaPa/TLihjdGNIm2CZoNIrKPZwTrL5xUamTWFb6jeSEK8I7JdzwRYuSj5lXyCD8Oz+
 22/0yaF1jJpg/foiBFWY22N0BlLyAPmwWCV29dBaSuIehw7HYzdI57fShMwCahgGFtfxUQ3fg
 rmijtfbgc6/9CPp+QaowH7fqTzzkzs1UVOr8hfBp633edwVB6qSzwyxwu4JP0NU5QPhCPrrI2
 vknJvrsqOqRxVEVIVi78WAD/MMpi3WqU9H3yqG9X67NBrxwqJVZuIVJCtaiXdSIts11AU6FxE
 1u3MRAHSlkupxEJCouNKVFy5A/27Svui8cB7KORPGf7dtjZyMk2pm/prIoL6dDyajoqx4Q9jt
 nijZNRuQ3Euk0z0kzZPl/pDi90tyUEBfauhsg7de9/1qFisE9djOrhPS4n3fdLUVaiiCTrhXc
 y+ns+bzzl9rK5NZVudSB1S6zagkOt80k7LaDRsGsh/7A+LZet1d728v9O6oLlmLHzKRYqjU7X
 qKSS+UB5g8NRHKbLs8gw0BR0xDkSm3xRJs6LLZGpbSSa1xYtAi/E3DM1Zl+gYKmqrmDfe9kST
 71mI0JqqwZtL2U96/Q0xxshmDYju3wXhyVa9pU5rD4d/RFpf0iWcf/bOinHQ80kU0VOxA2fij
 +c1oqQ1Wz1S1s/QeXDjC94W/u7iM/Sl8ZFB85P88QApLfSF3Tg=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A 1024 byte variable on the stack will warn on any 32-bit architecture
during compile-testing, and is generally a bad idea anyway:

fsl/dpio/dpio-service.c: In function 'dpaa2_io_service_enqueue_multiple_desc_fq':
fsl/dpio/dpio-service.c:495:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

There are currently no callers of this function, so I cannot tell whether
dynamic memory allocation is allowed once callers are added. Change
it to kcalloc for now, if anyone gets a warning about calling this in
atomic context after they start using it, they can fix it later.

Fixes: 9d98809711ae ("soc: fsl: dpio: Adding QMAN multiple enqueue interface")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/fsl/dpio/dpio-service.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/fsl/dpio/dpio-service.c b/drivers/soc/fsl/dpio/dpio-service.c
index cd4f6410e8c2..ff0ef8cbdbff 100644
--- a/drivers/soc/fsl/dpio/dpio-service.c
+++ b/drivers/soc/fsl/dpio/dpio-service.c
@@ -478,12 +478,17 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 				const struct dpaa2_fd *fd,
 				int nb)
 {
-	int i;
-	struct qbman_eq_desc ed[32];
+	struct qbman_eq_desc *ed = kcalloc(sizeof(struct qbman_eq_desc), 32, GFP_KERNEL);
+	int i, ret;
+
+	if (!ed)
+		return -ENOMEM;
 
 	d = service_select(d);
-	if (!d)
-		return -ENODEV;
+	if (!d) {
+		ret = -ENODEV;
+		goto out;
+	}
 
 	for (i = 0; i < nb; i++) {
 		qbman_eq_desc_clear(&ed[i]);
@@ -491,7 +496,10 @@ int dpaa2_io_service_enqueue_multiple_desc_fq(struct dpaa2_io *d,
 		qbman_eq_desc_set_fq(&ed[i], fqid[i]);
 	}
 
-	return qbman_swp_enqueue_multiple_desc(d->swp, &ed[0], fd, nb);
+	ret = qbman_swp_enqueue_multiple_desc(d->swp, &ed[0], fd, nb);
+out:
+	kfree(ed);
+	return ret;
 }
 EXPORT_SYMBOL(dpaa2_io_service_enqueue_multiple_desc_fq);
 
-- 
2.26.0

