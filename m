Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860FC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A967206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579200613;
	bh=Ohe283Voqpzg5Cv1z/zQlCanRENtJcAkqcgCz5p5Q0A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fMiZhnOhHuwqDChiOxYEHrwFfTNKDDYduyt589J/iN22BLWvIaxI1P+oMMom8lWB3
	 eOWsNl4kMbcLzZRaMgZDBioJ/XxhHhd3sg6D2Enfk4ziPo6/DHmqF28oqeKuEyCSnd
	 Cxd+9JkKQtgXGKmBYhnNB7ZI6NLo3JhgjTNRok6o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389390AbgAPSuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:50:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389629AbgAPRJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:09:13 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33A1D2467A;
        Thu, 16 Jan 2020 17:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194553;
        bh=Ohe283Voqpzg5Cv1z/zQlCanRENtJcAkqcgCz5p5Q0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LHM6rAyorKpVzQQxjrurv4Ks0hO9IEBx6/0meZgyUgf0vfzvTuo0ZpHKsSJm4X541
         ZGNlySHb4+4SOmTxgDPhubTH34dKGys8uzly/4JgVtifERLjD5ViPmlNATBcAp404w
         37/6HgXMUG3StWKBKtsQvdmPpX560RYKKs8K2mYo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 435/671] nvmem: imx-ocotp: Ensure WAIT bits are preserved when setting timing
Date:   Thu, 16 Jan 2020 12:01:13 -0500
Message-Id: <20200116170509.12787-172-sashal@kernel.org>
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

From: Bryan O'Donoghue <pure.logic@nexus-software.ie>

[ Upstream commit 0493c4792b4eb260441e57f52cc11a9ded48b5a7 ]

The i.MX6 and i.MX8 both have a bit-field spanning bits 27:22 called the
WAIT field.

The WAIT field according to the documentation for both parts "specifies
time interval between auto read and write access in one time program. It is
given in number of ipg_clk periods."

This patch ensures that the relevant field is read and written back to the
timing register.

Fixes: 0642bac7da42 ("nvmem: imx-ocotp: add write support")

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/imx-ocotp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index 926d9cc080cf..04421a73f74a 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -189,7 +189,8 @@ static void imx_ocotp_set_imx6_timing(struct ocotp_priv *priv)
 	strobe_prog = clk_rate / (1000000000 / 10000) + 2 * (DEF_RELAX + 1) - 1;
 	strobe_read = clk_rate / (1000000000 / 40) + 2 * (DEF_RELAX + 1) - 1;
 
-	timing = strobe_prog & 0x00000FFF;
+	timing = readl(priv->base + IMX_OCOTP_ADDR_TIMING) & 0x0FC00000;
+	timing |= strobe_prog & 0x00000FFF;
 	timing |= (relax       << 12) & 0x0000F000;
 	timing |= (strobe_read << 16) & 0x003F0000;
 
-- 
2.20.1

