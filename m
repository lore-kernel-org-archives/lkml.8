Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0120FC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C097C20866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=maquefel.me header.i=@maquefel.me header.b="HVFWZPWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729636AbgCDOZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:25:22 -0500
Received: from forward103p.mail.yandex.net ([77.88.28.106]:44763 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgCDOZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:25:22 -0500
Received: from forward102q.mail.yandex.net (forward102q.mail.yandex.net [IPv6:2a02:6b8:c0e:1ba:0:640:516:4e7d])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 25E9718C3845;
        Wed,  4 Mar 2020 17:25:19 +0300 (MSK)
Received: from mxback8q.mail.yandex.net (mxback8q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:b38f:32ec])
        by forward102q.mail.yandex.net (Yandex) with ESMTP id 205C27F20018;
        Wed,  4 Mar 2020 17:25:19 +0300 (MSK)
Received: from vla5-47b3f4751bc4.qloud-c.yandex.net (vla5-47b3f4751bc4.qloud-c.yandex.net [2a02:6b8:c18:3508:0:640:47b3:f475])
        by mxback8q.mail.yandex.net (mxback/Yandex) with ESMTP id I0SvveKpM4-PINeEPFT;
        Wed, 04 Mar 2020 17:25:19 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maquefel.me; s=mail; t=1583331919;
        bh=r83eXkzCEdXbDAwniYRybWaeq5RaZBLGnoqVnnIBAUg=;
        h=Subject:To:From:Cc:Date:Message-Id;
        b=HVFWZPWPclF02CLbSzuHlL9bRIjJ8R4BhCaVEQFXbvAlKKCKFaDzEijV7uji3BY8t
         TZ2jGlQSgYvUPxMJoBPjCJExH/T7WYF8IhcGGtjjmAdtx4N1D3p/FWFB+BOzB1nI87
         zkYBOwqgqqVqCi9UK/y3MB7bKa8IcqSqvbWmvvvo=
Authentication-Results: mxback8q.mail.yandex.net; dkim=pass header.i=@maquefel.me
Received: by vla5-47b3f4751bc4.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id OSNMAAdVGo-PH3OtHoN;
        Wed, 04 Mar 2020 17:25:17 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   Nikita Shubin <NShubin@topcon.com>
Cc:     Nikita Shubin <NShubin@topcon.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] remoteproc: imx_rproc: dummy kick method
Date:   Wed,  4 Mar 2020 17:26:27 +0300
Message-Id: <20200304142628.8471-1-NShubin@topcon.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add kick method that does nothing, to avoid errors in rproc_virtio_notify.

Signed-off-by: Nikita Shubin <NShubin@topcon.com>
---
 drivers/remoteproc/imx_rproc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/imx_rproc.c b/drivers/remoteproc/imx_rproc.c
index 3e72b6f38d4b..796b6b86550a 100644
--- a/drivers/remoteproc/imx_rproc.c
+++ b/drivers/remoteproc/imx_rproc.c
@@ -240,9 +240,15 @@ static void *imx_rproc_da_to_va(struct rproc *rproc, u64 da, int len)
 	return va;
 }
 
+static void imx_rproc_kick(struct rproc *rproc, int vqid)
+{
+
+}
+
 static const struct rproc_ops imx_rproc_ops = {
 	.start		= imx_rproc_start,
 	.stop		= imx_rproc_stop,
+	.kick		= imx_rproc_kick,
 	.da_to_va       = imx_rproc_da_to_va,
 };
 
-- 
2.24.1

