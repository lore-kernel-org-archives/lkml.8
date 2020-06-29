Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F4DC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D0C0206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 22:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593468059;
	bh=S8p+DGgvOOOsA+E7IIqUppfQHZLEXI6OwgrDNm95NDI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qI0GroNDA4OZEuduaZBRZsUvVqm3lh0UesbR7Vp+ivfTAC7+GV2DxDRMf67w5eJqB
	 cC5OV4WTSPNMVIU7n+a/tKFRa+bxeKUqnD6DAoq4rbkA2P6/8KNbjuXlxGHULHPM/j
	 QCwBjQsI5pK5ze9kJICMekEX/P5M0k66g7Abc4vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391771AbgF2WA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 18:00:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:56794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726305AbgF2SfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:35:24 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6617A24171;
        Mon, 29 Jun 2020 15:19:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593443945;
        bh=S8p+DGgvOOOsA+E7IIqUppfQHZLEXI6OwgrDNm95NDI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C0xtmd3lF6xo2SGnyAaBkUGloby9p1zy2PsQuK+wp9lRW0hTEaLK3c5hes3lbmiqu
         eBTsCYXFdhdZcIlKbYKnh9vkBOHQok0DWNTL30xqcau0Z28rjP4IPBpIEXTqpvcFL/
         R1hcA1ccWlAoO02Fk9KIoyVxmAQH0p4T4BLK4Qp0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 5.7 046/265] of: of_mdio: Correct loop scanning logic
Date:   Mon, 29 Jun 2020 11:14:39 -0400
Message-Id: <20200629151818.2493727-47-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629151818.2493727-1-sashal@kernel.org>
References: <20200629151818.2493727-1-sashal@kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.7.7-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.7.7-rc1
X-KernelTest-Deadline: 2020-07-01T15:14+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>

[ Upstream commit 5a8d7f126c97d04d893f5e5be2b286437a0d01b0 ]

Commit 209c65b61d94 ("drivers/of/of_mdio.c:fix of_mdiobus_register()")
introduced a break of the loop on the premise that a successful
registration should exit the loop. The premise is correct but not to
code, because rc && rc != -ENODEV is just a special error condition,
that means we would exit the loop even with rc == -ENODEV which is
absolutely not correct since this is the error code to indicate to the
MDIO bus layer that scanning should continue.

Fix this by explicitly checking for rc = 0 as the only valid condition
to break out of the loop.

Fixes: 209c65b61d94 ("drivers/of/of_mdio.c:fix of_mdiobus_register()")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/of/of_mdio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 9f982c0627a0d..95a3bb2e5eabf 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -303,10 +303,15 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 				 child, addr);
 
 			if (of_mdiobus_child_is_phy(child)) {
+				/* -ENODEV is the return code that PHYLIB has
+				 * standardized on to indicate that bus
+				 * scanning should continue.
+				 */
 				rc = of_mdiobus_register_phy(mdio, child, addr);
-				if (rc && rc != -ENODEV)
+				if (!rc)
+					break;
+				if (rc != -ENODEV)
 					goto unregister;
-				break;
 			}
 		}
 	}
-- 
2.25.1

