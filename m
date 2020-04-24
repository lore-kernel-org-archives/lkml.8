Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51273C55191
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:16:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DE62206D4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 11:16:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgDXLQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 07:16:04 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47613 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDXLQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 07:16:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jRwJM-0005Gj-JK; Fri, 24 Apr 2020 11:16:00 +0000
From:   Colin King <colin.king@canonical.com>
To:     Yasunari Takiguchi <Yasunari.Takiguchi@sony.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: dvb: remove redundant assignment to variable bw
Date:   Fri, 24 Apr 2020 12:16:00 +0100
Message-Id: <20200424111600.11991-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable bw is being initialized with a value that is
never read and it is being updated later with a new value.  The
initialization is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/dvb-frontends/cxd2880/cxd2880_top.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
index f87e27481ea7..d5b1b3788e39 100644
--- a/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
+++ b/drivers/media/dvb-frontends/cxd2880/cxd2880_top.c
@@ -685,7 +685,7 @@ static int cxd2880_set_ber_per_period_t(struct dvb_frontend *fe)
 	int ret;
 	struct cxd2880_priv *priv;
 	struct cxd2880_dvbt_tpsinfo info;
-	enum cxd2880_dtv_bandwidth bw = CXD2880_DTV_BW_1_7_MHZ;
+	enum cxd2880_dtv_bandwidth bw;
 	u32 pre_ber_rate = 0;
 	u32 post_ber_rate = 0;
 	u32 ucblock_rate = 0;
-- 
2.25.1

