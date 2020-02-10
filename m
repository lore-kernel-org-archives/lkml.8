Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A74C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97D6420708
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338858;
	bh=u/M2mGQ5ENRc2DkqYk6wNRO550Bdvbsv9lmk+t4/hCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fcruNXSiJecIn4LvuE2mJutBzCgRPTzI6HLfkx884e4vfTmEZllPKj9GdXxB62WSy
	 l7xaoXwj0fZyk5+eHUDjc9O19+1a2X+2DOYwuqclQpzItdwEwnEsXTqv06e8kHdcNX
	 +HPCdmbQYHOry1WgJ+8bYNWPp9ZuSLFIqDYm7ozw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgBJMrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:47:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbgBJMmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:42:17 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39A852051A;
        Mon, 10 Feb 2020 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338537;
        bh=u/M2mGQ5ENRc2DkqYk6wNRO550Bdvbsv9lmk+t4/hCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UDVo9l2d7rFDEshpOMRsWGNpz0pr5+k9zxF3xlSwdmCGwfsajduz6s6XrJAoaXrdh
         ILLaj74LQ/eYf8XVuoeXnlRuEYNfDvgw23AzIH6cKLIflKnSJ3xkempDR730uu06As
         U60f0bej8TSxuqz3PHyBybkXHuEUpHUTSmdyI3Jw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
        Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 366/367] regulator fix for "regulator: core: Add regulator_is_equal() helper"
Date:   Mon, 10 Feb 2020 04:34:39 -0800
Message-Id: <20200210122456.093876740@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stephen Rothwell <sfr@canb.auug.org.au>

[ Upstream commit 0468e667a5bead9c1b7ded92861b5a98d8d78745 ]

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/r/20200115120258.0e535fcb@canb.auug.org.au
Acked-by: Marek Vasut <marex@denx.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/regulator/consumer.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 2c89d886595cb..6a92fd3105a31 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -596,7 +596,7 @@ regulator_bulk_set_supply_names(struct regulator_bulk_data *consumers,
 }
 
 static inline bool
-regulator_is_equal(struct regulator *reg1, struct regulator *reg2);
+regulator_is_equal(struct regulator *reg1, struct regulator *reg2)
 {
 	return false;
 }
-- 
2.20.1



