Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3045C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5265E217F4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579195347;
	bh=2alawyexEup4tNEDc7koqZfVAReZTW5i3HMWygIn5VY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zoG4ZaMtwkWA1wwGOrzFCk2RJoKxmsJlHXbpW9zeSY8BqDoHxq9L4bIEO3R8cx9Bs
	 rQdQ/uKvXqHKeezwhB7egUrfcVHjEDY6azruj1umVx0Mu6msZ3zrW1q0p9rTq1c7Wl
	 FgUWHLQgs8h3VAJ+E/RN6KhD+u8AtvP2ouB7f+v0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391632AbgAPRW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:22:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390772AbgAPRNe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:13:34 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA2672469E;
        Thu, 16 Jan 2020 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579194813;
        bh=2alawyexEup4tNEDc7koqZfVAReZTW5i3HMWygIn5VY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0iElM7d5i2zJuT3+WJTPxs3zvtcLhMtR5znBf7fuCVFkQAYuWwhXP1mNlPX+z5t/N
         qyCx5GGlbTlz7vbP8A9qvZeMmN52lyL37jQ5VpwS5f7TCTLlq1GZcJ0n3YTBJ0Cv29
         AhoI/8TyFYz1pwbWAW4JQ0rtHojAv9/hqnJ2HGZk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 620/671] media: v4l: cadence: Fix how unsued lanes are handled in 'csi2rx_start()'
Date:   Thu, 16 Jan 2020 12:04:18 -0500
Message-Id: <20200116170509.12787-357-sashal@kernel.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 2eca8e4c1df4864b937752c3aa2f7925114f4806 ]

The 2nd parameter of 'find_first_zero_bit()' is a number of bits, not of
bytes. So use 'csi2rx->max_lanes' instead of 'sizeof(lanes_used)'.

Fixes: 1fc3b37f34f6 ("media: v4l: cadence: Add Cadence MIPI-CSI2 RX driver")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/cadence/cdns-csi2rx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/cadence/cdns-csi2rx.c b/drivers/media/platform/cadence/cdns-csi2rx.c
index 43e43c7b3e98..6f64703d2c7c 100644
--- a/drivers/media/platform/cadence/cdns-csi2rx.c
+++ b/drivers/media/platform/cadence/cdns-csi2rx.c
@@ -129,7 +129,7 @@ static int csi2rx_start(struct csi2rx_priv *csi2rx)
 	 */
 	for (i = csi2rx->num_lanes; i < csi2rx->max_lanes; i++) {
 		unsigned int idx = find_first_zero_bit(&lanes_used,
-						       sizeof(lanes_used));
+						       csi2rx->max_lanes);
 		set_bit(idx, &lanes_used);
 		reg |= CSI2RX_STATIC_CFG_DLANE_MAP(i, i + 1);
 	}
-- 
2.20.1

