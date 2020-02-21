Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4975C35641
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1CC5206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 07:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582271929;
	bh=Gb6zO3vrz52MEdvW1LhATnJkf+J9deNEM1D6WGHxNqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zPcbzpvsFvgQs8PkvTsJP7W5r19n9y6qrD6ScFX13Li8Zk3fWjofliabS+RQKusTD
	 0vOrnk3+LNZULS3g86f3Yv29IDNUbAIiF5bSc5km3bDsNVf2EYZO2sMrjIOlKCpENa
	 roxFX0krB3K6Ad6hh9dtcZo0SCba4AvWZyq0vMXA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbgBUH6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 02:58:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:58590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbgBUH6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 02:58:43 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E87272073A;
        Fri, 21 Feb 2020 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582271923;
        bh=Gb6zO3vrz52MEdvW1LhATnJkf+J9deNEM1D6WGHxNqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FHvhXW6eMGb/tVuveYTNcoK9z8jRQ+U5AMWfTdiK0XwaHin4WEE6tomHnFweVu9Lf
         h64IXtj50AKvfNXINK0DesgSHx7Be9kP5MU92MZYg2W/D0duvADF6fjTnMe9TEunFE
         ZcRYS5YYtpLHioa6QBVSpip1FlwB//whDhNRwwKY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Stanislaw Gruszka <stf_xl@wp.pl>,
        Kalle Valo <kvalo@codeaurora.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.5 348/399] iwlegacy: ensure loop counter addr does not wrap and cause an infinite loop
Date:   Fri, 21 Feb 2020 08:41:13 +0100
Message-Id: <20200221072434.988342628@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200221072402.315346745@linuxfoundation.org>
References: <20200221072402.315346745@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c2f9a4e4a5abfc84c01b738496b3fd2d471e0b18 ]

The loop counter addr is a u16 where as the upper limit of the loop
is an int. In the unlikely event that the il->cfg->eeprom_size is
greater than 64K then we end up with an infinite loop since addr will
wrap around an never reach upper loop limit. Fix this by making addr
an int.

Addresses-Coverity: ("Infinite loop")
Fixes: be663ab67077 ("iwlwifi: split the drivers for agn and legacy devices 3945/4965")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlegacy/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/common.c b/drivers/net/wireless/intel/iwlegacy/common.c
index d966b29b45ee7..348c17ce72f5c 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.c
+++ b/drivers/net/wireless/intel/iwlegacy/common.c
@@ -699,7 +699,7 @@ il_eeprom_init(struct il_priv *il)
 	u32 gp = _il_rd(il, CSR_EEPROM_GP);
 	int sz;
 	int ret;
-	u16 addr;
+	int addr;
 
 	/* allocate eeprom */
 	sz = il->cfg->eeprom_size;
-- 
2.20.1



