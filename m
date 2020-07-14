Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA17C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B831F22AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594753462;
	bh=jZ/uBJLMnF7CksbNt0FsKVe0JN/CTahK8lmRklB3lGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=T/jNKwAjGWH1EMSxiB31oHUFk9uYaEKkLFLwvdbX5Kx1pTQPywFdQh3DjFa/n81F+
	 ZNdEnSWWVXsoIfGUKV6AoeuDp0lvC7SeRfT+EGIRCbol1QpVD9xn7kLPiX5Pem+RUe
	 qG7ocf5e8zO0ggd75kb+byINfQE2tnvPUjmtRRUk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgGNTEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:04:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730940AbgGNS4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 14:56:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5551D22B39;
        Tue, 14 Jul 2020 18:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594752964;
        bh=jZ/uBJLMnF7CksbNt0FsKVe0JN/CTahK8lmRklB3lGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JqxfbhNZ5cTalVk8W5+xXUozkR55RzR//v9bIUZ6AOpww6ZdxKGHD52n4bs0PxlVc
         kWhCJRzvtljTQ7dM8UAWWCaxu8r2VrwN2x3I+iL6LUXy334i29/UEaSjNFGmiUgbw2
         I/TxSiNoiGQHfGuX4B1qOIFx+FERuTMUQM0d/uiM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 068/166] net: dsa: microchip: set the correct number of ports
Date:   Tue, 14 Jul 2020 20:43:53 +0200
Message-Id: <20200714184119.121413478@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200714184115.844176932@linuxfoundation.org>
References: <20200714184115.844176932@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>

[ Upstream commit af199a1a9cb02ec0194804bd46c174b6db262075 ]

The number of ports is incorrectly set to the maximum available for a DSA
switch. Even if the extra ports are not used, this causes some functions
to be called later, like port_disable() and port_stp_state_set(). If the
driver doesn't check the port index, it will end up modifying unknown
registers.

Fixes: b987e98e50ab ("dsa: add DSA switch driver for Microchip KSZ9477")
Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz8795.c | 3 +++
 drivers/net/dsa/microchip/ksz9477.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 47d65b77caf77..7c17b0f705ec3 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -1268,6 +1268,9 @@ static int ksz8795_switch_init(struct ksz_device *dev)
 			return -ENOMEM;
 	}
 
+	/* set the real number of ports */
+	dev->ds->num_ports = dev->port_cnt;
+
 	return 0;
 }
 
diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 9a51b8a4de5d1..8d15c30160246 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -1588,6 +1588,9 @@ static int ksz9477_switch_init(struct ksz_device *dev)
 			return -ENOMEM;
 	}
 
+	/* set the real number of ports */
+	dev->ds->num_ports = dev->port_cnt;
+
 	return 0;
 }
 
-- 
2.25.1



