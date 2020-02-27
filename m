Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FD1C3F35A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CABCA21D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582811322;
	bh=UO55tRwkGBNUjjrj++FD29xVqIkGuWGsESnDe4rEb70=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=1OiHCxG6Nj78Z7BwECUstVE1AJHpaOjfhnh2uqyv9uzsLfBM+yTB9KdEw+l7lZf1Z
	 uLcGIiLPuuWXvNka+cZzs0RzMMhO5iwejHUCu+jt4k+7UsmRhv1Ek8f6HOi790ba5T
	 4vKZarpH8bo3vvH8wOaJ+cBTV3IQcJnp/kDI2Piw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgB0Nsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:48:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:45496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730865AbgB0Nsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:48:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4DE224688;
        Thu, 27 Feb 2020 13:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811318;
        bh=UO55tRwkGBNUjjrj++FD29xVqIkGuWGsESnDe4rEb70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IglicqJmCDf0rJgutXNubwD2kfjyluIk9fZkKf785Ev4MS5+gRjW11urr91CfW795
         HRv2XluVWhjeFkWrdmXAVnCUAlns0uzfUQl9rL8/gsxhJABO79N3YRTQUwCRU2iGsm
         EX3Gbp33iabOQeubw+RV07fQTvwzNu7WJA70B32g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Timur Tabi <timur@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "David S. Miller" <davem@davemloft.net>,
        Li Yang <leoyang.li@nxp.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 047/165] net/wan/fsl_ucc_hdlc: reject muram offsets above 64K
Date:   Thu, 27 Feb 2020 14:35:21 +0100
Message-Id: <20200227132238.056381768@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index af85a1b3135e2..87bf05a81db50 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -209,6 +209,11 @@ static int uhdlc_init(struct ucc_hdlc_private *priv)
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



