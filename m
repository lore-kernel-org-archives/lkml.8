Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BCAC433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6AB22073A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595262403;
	bh=DfHZP/SU7kw+OELARZx5n+PpCHXGSkki4R6tGidCBPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DlLAFEJuYhns6wCtwxKG8RsMBdILfHUM6enH3VoNXk5/A4w65YLhNaGrrONx9FXW3
	 DH7+1c25fq/B82HRzZUISBP8tyOeCzmljSXLcJsr6o5vMk8lKIMIHaCqRhYGZ2Fvra
	 YcicTD0Qpk8cLfYhxtRlGTwK/SgW8r0I/BsZvem0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732324AbgGTP7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 11:59:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732263AbgGTP7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F20AD20773;
        Mon, 20 Jul 2020 15:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595260777;
        bh=DfHZP/SU7kw+OELARZx5n+PpCHXGSkki4R6tGidCBPk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y8WwaLQ0o1TWT/pWOpv+tBuO/ypRXkalnzpgIDOiBwRCVh7/nZESFNqR6A2nfG1WO
         fnXQFsy9AiJwiLix9BIbzS0dbd/xanm5657ofIq4Jb855Sqsq8meCfvC+rv86geocl
         icsQfibtmp6BP3tcx5cFdY7WOadG7nMMtdB9S6q4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 065/215] net: sfp: add some quirks for GPON modules
Date:   Mon, 20 Jul 2020 17:35:47 +0200
Message-Id: <20200720152823.301154853@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720152820.122442056@linuxfoundation.org>
References: <20200720152820.122442056@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit b0eae33b2583dceb36224619f9fd85e6140ae594 ]

Marc Micalizzi reports that Huawei MA5671A and Alcatel/Lucent G-010S-P
modules are capable of 2500base-X, but incorrectly report their
capabilities in the EEPROM.  It seems rather common that GPON modules
mis-report.

Let's fix these modules by adding some quirks.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/phy/sfp-bus.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/phy/sfp-bus.c b/drivers/net/phy/sfp-bus.c
index 35caf2eb2c275..816e59fe68f57 100644
--- a/drivers/net/phy/sfp-bus.c
+++ b/drivers/net/phy/sfp-bus.c
@@ -37,7 +37,32 @@ struct sfp_bus {
 	bool started;
 };
 
+static void sfp_quirk_2500basex(const struct sfp_eeprom_id *id,
+				unsigned long *modes)
+{
+	phylink_set(modes, 2500baseX_Full);
+}
+
 static const struct sfp_quirk sfp_quirks[] = {
+	{
+		// Alcatel Lucent G-010S-P can operate at 2500base-X, but
+		// incorrectly report 2500MBd NRZ in their EEPROM
+		.vendor = "ALCATELLUCENT",
+		.part = "G010SP",
+		.modes = sfp_quirk_2500basex,
+	}, {
+		// Alcatel Lucent G-010S-A can operate at 2500base-X, but
+		// report 3.2GBd NRZ in their EEPROM
+		.vendor = "ALCATELLUCENT",
+		.part = "3FE46541AA",
+		.modes = sfp_quirk_2500basex,
+	}, {
+		// Huawei MA5671A can operate at 2500base-X, but report 1.2GBd
+		// NRZ in their EEPROM
+		.vendor = "HUAWEI",
+		.part = "MA5671A",
+		.modes = sfp_quirk_2500basex,
+	},
 };
 
 static size_t sfp_strlen(const char *str, size_t maxlen)
-- 
2.25.1



