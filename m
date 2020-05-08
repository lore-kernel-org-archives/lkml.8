Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE20C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56CA8218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588942379;
	bh=RihZBV2HIqeSd4Zs1oz0PgSiSUHUetLAYV3q+QRh/Go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EusTf2ZJMJ5XeTrd80eswRPAuGVdBP+RnLLRw9DltWsG178Mgy+zAoxB9cm7XXFrx
	 CdgG9aczscA4heRKrK1z9wmWxm8Ae4+uiaBkwAqt9Qew8nqifc2SSWBfJYY8y86JG7
	 Q4sDa0Og34wyS/dO2uT1J0Fq5OAR6/O2WHoTBTuY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgEHMw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:52:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:34212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730005AbgEHMww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:52:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4CE24958;
        Fri,  8 May 2020 12:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588942371;
        bh=RihZBV2HIqeSd4Zs1oz0PgSiSUHUetLAYV3q+QRh/Go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZzLeKJ9shHtZeoV1OWSuICxNd7eRm33RthBNixuBRu/7s2XiayMqrsuKkmWuWxvwy
         2GZ7x8BqF6BHG0wP9hdWUG2+Zr1cDNwCG2vZUZxMKUmcuicSohKEioVuO156McCw8c
         lOOBwRT4t3eqOaedM9MiJx+mpCbGkLITy0HY1gwA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Beraud <julien.beraud@orolia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 19/50] net: stmmac: Fix sub-second increment
Date:   Fri,  8 May 2020 14:35:25 +0200
Message-Id: <20200508123046.070300764@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200508123043.085296641@linuxfoundation.org>
References: <20200508123043.085296641@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Beraud <julien.beraud@orolia.com>

[ Upstream commit 91a2559c1dc5b0f7e1256d42b1508935e8eabfbf ]

In fine adjustement mode, which is the current default, the sub-second
    increment register is the number of nanoseconds that will be added to
    the clock when the accumulator overflows. At each clock cycle, the
    value of the addend register is added to the accumulator.
    Currently, we use 20ns = 1e09ns / 50MHz as this value whatever the
    frequency of the ptp clock actually is.
    The adjustment is then done on the addend register, only incrementing
    every X clock cycles X being the ratio between 50MHz and ptp_clock_rate
    (addend = 2^32 * 50MHz/ptp_clock_rate).
    This causes the following issues :
    - In case the frequency of the ptp clock is inferior or equal to 50MHz,
      the addend value calculation will overflow and the default
      addend value will be set to 0, causing the clock to not work at
      all. (For instance, for ptp_clock_rate = 50MHz, addend = 2^32).
    - The resolution of the timestamping clock is limited to 20ns while it
      is not needed, thus limiting the accuracy of the timestamping to
      20ns.

    Fix this by setting sub-second increment to 2e09ns / ptp_clock_rate.
    It will allow to reach the minimum possible frequency for
    ptp_clk_ref, which is 5MHz for GMII 1000Mps Full-Duplex by setting the
    sub-second-increment to a higher value. For instance, for 25MHz, it
    gives ssinc = 80ns and default_addend = 2^31.
    It will also allow to use a lower value for sub-second-increment, thus
    improving the timestamping accuracy with frequencies higher than
    100MHz, for instance, for 200MHz, ssinc = 10ns and default_addend =
    2^31.

v1->v2:
 - Remove modifications to the calculation of default addend, which broke
 compatibility with clock frequencies for which 2000000000 / ptp_clk_freq
 is not an integer.
 - Modify description according to discussions.

Signed-off-by: Julien Beraud <julien.beraud@orolia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c    | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 0201596225592..e5d9007c8090b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -26,12 +26,16 @@ static void config_sub_second_increment(void __iomem *ioaddr,
 	unsigned long data;
 	u32 reg_value;
 
-	/* For GMAC3.x, 4.x versions, convert the ptp_clock to nano second
-	 *	formula = (1/ptp_clock) * 1000000000
-	 * where ptp_clock is 50MHz if fine method is used to update system
+	/* For GMAC3.x, 4.x versions, in "fine adjustement mode" set sub-second
+	 * increment to twice the number of nanoseconds of a clock cycle.
+	 * The calculation of the default_addend value by the caller will set it
+	 * to mid-range = 2^31 when the remainder of this division is zero,
+	 * which will make the accumulator overflow once every 2 ptp_clock
+	 * cycles, adding twice the number of nanoseconds of a clock cycle :
+	 * 2000000000ULL / ptp_clock.
 	 */
 	if (value & PTP_TCR_TSCFUPDT)
-		data = (1000000000ULL / 50000000);
+		data = (2000000000ULL / ptp_clock);
 	else
 		data = (1000000000ULL / ptp_clock);
 
-- 
2.20.1



