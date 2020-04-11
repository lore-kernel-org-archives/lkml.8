Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C748C2BBC7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC9C206F7
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586648839;
	bh=p38O/2mQNXuwn5pJCSLK7R5UGjaTsUKvp2Qd+A+zw3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=sAmFOIqot78CucKix7bqbMsK+UQV/xvSHP2MXUpXjoCe8Gyn+NN2RjmawGNHPjJAN
	 nG/dcGpI4jZfrN6pn/ndS/ueppDF77u2ULEKvhvZuiDahdhYmDduFUhlTr5Igy2/Nk
	 zNk8lBIU7g4IMtFgYi7fiBGoDQQsd3grvrF9G+Ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgDKXFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:05:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727547AbgDKXEw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:04:52 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22FDC215A4;
        Sat, 11 Apr 2020 23:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646292;
        bh=p38O/2mQNXuwn5pJCSLK7R5UGjaTsUKvp2Qd+A+zw3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=by6wYbzLhUmDBVcg6PdwzMBUMJRVpuFpl1U9tj8vaF3ff26YwU+pj1Gs880Pjrs5o
         C1bcjeZLYW+I4kWcy+Zz2enTRj64aSppFoaSMlrK7IeK4oFpTnhlvClRSshj4ZnRZ9
         iMIH2LrhAEz/q5nX2JCaKa+b364lvLokr9YfhSes=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 053/149] net: dsa: bcm_sf2: Also configure Port 5 for 2Gb/sec on 7278
Date:   Sat, 11 Apr 2020 19:02:10 -0400
Message-Id: <20200411230347.22371-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230347.22371-1-sashal@kernel.org>
References: <20200411230347.22371-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 7458bd540fa0a90220b9e8c349d910d9dde9caf8 ]

Either port 5 or port 8 can be used on a 7278 device, make sure that
port 5 also gets configured properly for 2Gb/sec in that case.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/bcm_sf2.c      | 3 +++
 drivers/net/dsa/bcm_sf2_regs.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/net/dsa/bcm_sf2.c b/drivers/net/dsa/bcm_sf2.c
index b0f5280a83cb6..d9b003432e71b 100644
--- a/drivers/net/dsa/bcm_sf2.c
+++ b/drivers/net/dsa/bcm_sf2.c
@@ -615,6 +615,9 @@ static void bcm_sf2_sw_mac_config(struct dsa_switch *ds, int port,
 	if (state->duplex == DUPLEX_FULL)
 		reg |= DUPLX_MODE;
 
+	if (priv->type == BCM7278_DEVICE_ID && dsa_is_cpu_port(ds, port))
+		reg |= GMIIP_SPEED_UP_2G;
+
 	core_writel(priv, reg, offset);
 }
 
diff --git a/drivers/net/dsa/bcm_sf2_regs.h b/drivers/net/dsa/bcm_sf2_regs.h
index d8a5e6269c0ef..7844781763359 100644
--- a/drivers/net/dsa/bcm_sf2_regs.h
+++ b/drivers/net/dsa/bcm_sf2_regs.h
@@ -178,6 +178,7 @@ enum bcm_sf2_reg_offs {
 #define  RXFLOW_CNTL			(1 << 4)
 #define  TXFLOW_CNTL			(1 << 5)
 #define  SW_OVERRIDE			(1 << 6)
+#define  GMIIP_SPEED_UP_2G		(1 << 7)
 
 #define CORE_WATCHDOG_CTRL		0x001e4
 #define  SOFTWARE_RESET			(1 << 7)
-- 
2.20.1

