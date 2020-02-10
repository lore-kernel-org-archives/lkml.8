Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3045C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D2720863
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341659;
	bh=em3B7Tl7IisO493LGQ7IANsJ83TnEhBRMsSBK4W7NjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WbXtROxI8xr5zaB+SmZ8ig1ELhJXyOHK/9ZRlZe2KVegjcNW/rkQxgzxzN+uTgJ6R
	 iipMiCV51XMY2zRyont0y+5Up2oGBj+TPPMXbyMSxSeD10KcshQ7lhaWesdTOZvZF3
	 8+IhmDOSEOG2zmgSCs82p2qYd5vNvplWZ0w28CYc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbgBJNeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 08:34:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727960AbgBJMfa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:30 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B054F24682;
        Mon, 10 Feb 2020 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338129;
        bh=em3B7Tl7IisO493LGQ7IANsJ83TnEhBRMsSBK4W7NjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Amsizz0slPVOUkdb22s2wiAZzOYko/iUlhZ73lowWRb3pv8ZRrOPWhkDnVEwIlCUv
         F89EsOxTVH3xjRaQtP/NlwCJxJmj0vllK65n8J5Y9s/hCu2ZW1Umb30WT5swb3LS5b
         P85wCDRKn16ZkXFzNCTIjf2gou1RuLJDJ67oJkOg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
        Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 4.19 072/195] mfd: axp20x: Mark AXP20X_VBUS_IPSOUT_MGMT as volatile
Date:   Mon, 10 Feb 2020 04:32:10 -0800
Message-Id: <20200210122312.863270583@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

commit dc91c3b6fe66a13ac76f6cb3b2100c0779cd3350 upstream.

On AXP288 and newer PMICs, bit 7 of AXP20X_VBUS_IPSOUT_MGMT can be set
to prevent using the VBUS input. However, when the VBUS unplugged and
plugged back in, the bit automatically resets to zero.

We need to set the register as volatile to prevent regmap from caching
that bit. Otherwise, regcache will think the bit is already set and not
write the register.

Fixes: cd53216625a0 ("mfd: axp20x: Fix axp288 volatile ranges")
Cc: stable@vger.kernel.org
Signed-off-by: Samuel Holland <samuel@sholland.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/mfd/axp20x.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -128,7 +128,7 @@ static const struct regmap_range axp288_
 static const struct regmap_range axp288_volatile_ranges[] = {
 	regmap_reg_range(AXP20X_PWR_INPUT_STATUS, AXP288_POWER_REASON),
 	regmap_reg_range(AXP288_BC_GLOBAL, AXP288_BC_GLOBAL),
-	regmap_reg_range(AXP288_BC_DET_STAT, AXP288_BC_DET_STAT),
+	regmap_reg_range(AXP288_BC_DET_STAT, AXP20X_VBUS_IPSOUT_MGMT),
 	regmap_reg_range(AXP20X_CHRG_BAK_CTRL, AXP20X_CHRG_BAK_CTRL),
 	regmap_reg_range(AXP20X_IRQ1_EN, AXP20X_IPSOUT_V_HIGH_L),
 	regmap_reg_range(AXP20X_TIMER_CTRL, AXP20X_TIMER_CTRL),


