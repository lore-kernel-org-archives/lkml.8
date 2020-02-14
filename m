Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055B0C3B1A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5742067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581699265;
	bh=Zmrtpa0LZihMZl3Ce8bNs5Bu/r1pFub2fc8hCI01eR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=epG13oIthKoB/OMNY3MtYY+MsifloECpE6jDp/vRUpTLMGMy89FrfuGiPi97Q67t6
	 qmy0v72osJfk/8mGSzRMJHGuj7y/j5ClsIhZdGAzl9+eq5uRwwF3OIjCmRymxq8k6E
	 I8XJ5wIoqW5dklEWfq/PUOHgSChs7dPNYhUiukvc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406814AbgBNQyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:54:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404803AbgBNQSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:18:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD1F9246F8;
        Fri, 14 Feb 2020 16:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697116;
        bh=Zmrtpa0LZihMZl3Ce8bNs5Bu/r1pFub2fc8hCI01eR4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EG2U3AxO4g4fW/vw4pVs0leHBRdXqSZT0olG1sbFR3eZ4E7kJctITQDaF1FHbYYPA
         vfc1AIH5EOBlD+qWFjlMnTzJCeu9ouw9RRkZOgKAQZa5MopCh+avhapi8ELL4yGylr
         Vwx9o4wwLcAU2H9zPpBVFCk8RAF90+UDn4zKSYn8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Qiang Zhao <qiang.zhao@nxp.com>, Timur Tabi <timur@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Li Yang <leoyang.li@nxp.com>, Sasha Levin <sashal@kernel.org>,
        netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH AUTOSEL 4.14 063/186] net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
Date:   Fri, 14 Feb 2020 11:15:12 -0500
Message-Id: <20200214161715.18113-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161715.18113-1-sashal@kernel.org>
References: <20200214161715.18113-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

[ Upstream commit 148587a59f6b85831695e0497d9dd1af5f0495af ]

Qiang Zhao points out that these offsets get written to 16-bit
registers, and there are some QE platforms with more than 64K
muram. So it is possible that qe_muram_alloc() gives us an allocation
that can't actually be used by the hardware, so detect and reject
that.

Reported-by: Qiang Zhao <qiang.zhao@nxp.com>
Reviewed-by: Timur Tabi <timur@kernel.org>
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wan/fsl_ucc_hdlc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 571a1ff8f81f2..6a26cef621935 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -240,6 +240,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
 		ret = -ENOMEM;
 		goto free_riptr;
 	}
+	if (riptr != (u16)riptr || tiptr != (u16)tiptr) {
+		dev_err(priv->dev, "MURAM allocation out of addressable range\n");
+		ret = -ENOMEM;
+		goto free_tiptr;
+	}
 
 	/* Set RIPTR, TIPTR */
 	iowrite16be(riptr, &priv->ucc_pram->riptr);
-- 
2.20.1

