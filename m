Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1E9C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355BF2146E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583258492;
	bh=yU2kZtFS3ltY6Jna+OJ5Utgiexm9WIBhlzlLm8dooSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=DjSyGW5thVmaS8tEGB1kVeMpPcj2egd7tr2BR35JZ8LMDym6ZhECi0hoYluZzVSMa
	 qKLxFwQ1wdWmYLqw5mtCgGzhARlr79D2zsyu93JYayBuCfxL4SXOYqKr/Qp0Osg32a
	 PSMKCKN941V3ApFvxvHzqIekzae/pVnxDUeYeT7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388002AbgCCSBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 13:01:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:45598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387993AbgCCSB3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 13:01:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36CB22072D;
        Tue,  3 Mar 2020 18:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583258488;
        bh=yU2kZtFS3ltY6Jna+OJ5Utgiexm9WIBhlzlLm8dooSA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MriTJ+1PAbs7GuoXBc8LcVk9MoAW4cAUOqphxHmo+QxtwYsEENsXnCX3Gj74dI5LF
         PFqi9Y9yvPwgt1qwIJqfTStO5OSsf1eKNJXcUaUy3I36BeiWacPELhYmKfXBELaq53
         zqE/mMMxMX2/PI0YyEN7imn0xBQx77AmdD3cx9x8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sameeh Jubran <sameehj@amazon.com>,
        Saeed Bshara <saeedb@amazon.com>,
        Arthur Kiyanovski <akiyano@amazon.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 66/87] net: ena: make ena rxfh support ETH_RSS_HASH_NO_CHANGE
Date:   Tue,  3 Mar 2020 18:43:57 +0100
Message-Id: <20200303174356.248325484@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200303174349.075101355@linuxfoundation.org>
References: <20200303174349.075101355@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Kiyanovski <akiyano@amazon.com>

commit 470793a78ce344bd53d31e0c2d537f71ba957547 upstream.

As the name suggests ETH_RSS_HASH_NO_CHANGE is received upon changing
the key or indirection table using ethtool while keeping the same hash
function.

Also add a function for retrieving the current hash function from
the ena-com layer.

Fixes: 1738cd3ed342 ("net: ena: Add a driver for Amazon Elastic Network Adapters (ENA)")
Signed-off-by: Sameeh Jubran <sameehj@amazon.com>
Signed-off-by: Saeed Bshara <saeedb@amazon.com>
Signed-off-by: Arthur Kiyanovski <akiyano@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/amazon/ena/ena_com.c     |    5 +++++
 drivers/net/ethernet/amazon/ena/ena_com.h     |    8 ++++++++
 drivers/net/ethernet/amazon/ena/ena_ethtool.c |    3 +++
 3 files changed, 16 insertions(+)

--- a/drivers/net/ethernet/amazon/ena/ena_com.c
+++ b/drivers/net/ethernet/amazon/ena/ena_com.c
@@ -860,6 +860,11 @@ static void ena_com_hash_key_fill_defaul
 	hash_key->keys_num = sizeof(hash_key->key) / sizeof(u32);
 }
 
+int ena_com_get_current_hash_function(struct ena_com_dev *ena_dev)
+{
+	return ena_dev->rss.hash_func;
+}
+
 static int ena_com_hash_key_allocate(struct ena_com_dev *ena_dev)
 {
 	struct ena_rss *rss = &ena_dev->rss;
--- a/drivers/net/ethernet/amazon/ena/ena_com.h
+++ b/drivers/net/ethernet/amazon/ena/ena_com.h
@@ -632,6 +632,14 @@ int ena_com_rss_init(struct ena_com_dev
  */
 void ena_com_rss_destroy(struct ena_com_dev *ena_dev);
 
+/* ena_com_get_current_hash_function - Get RSS hash function
+ * @ena_dev: ENA communication layer struct
+ *
+ * Return the current hash function.
+ * @return: 0 or one of the ena_admin_hash_functions values.
+ */
+int ena_com_get_current_hash_function(struct ena_com_dev *ena_dev);
+
 /* ena_com_fill_hash_function - Fill RSS hash function
  * @ena_dev: ENA communication layer struct
  * @func: The hash function (Toeplitz or crc)
--- a/drivers/net/ethernet/amazon/ena/ena_ethtool.c
+++ b/drivers/net/ethernet/amazon/ena/ena_ethtool.c
@@ -749,6 +749,9 @@ static int ena_set_rxfh(struct net_devic
 	}
 
 	switch (hfunc) {
+	case ETH_RSS_HASH_NO_CHANGE:
+		func = ena_com_get_current_hash_function(ena_dev);
+		break;
 	case ETH_RSS_HASH_TOP:
 		func = ENA_ADMIN_TOEPLITZ;
 		break;


