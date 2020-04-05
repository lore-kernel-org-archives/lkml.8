Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA78C2D0F4
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2A10206F8
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726674AbgDENGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 09:06:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56298 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgDENGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 09:06:22 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jL4yh-0000vQ-Kc; Sun, 05 Apr 2020 13:06:19 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lourdes Pedrajas <lu@pplo.net>, devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: remove redundant assignment to pointer 'w'
Date:   Sun,  5 Apr 2020 14:06:19 +0100
Message-Id: <20200405130619.377043-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer 'w' is being initialized with a value that is never read
and it is being updated later with a new value. The initialization
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/gdm724x/gdm_lte.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/gdm724x/gdm_lte.c b/drivers/staging/gdm724x/gdm_lte.c
index 354727f0a1fc..eb309190f5be 100644
--- a/drivers/staging/gdm724x/gdm_lte.c
+++ b/drivers/staging/gdm724x/gdm_lte.c
@@ -172,7 +172,7 @@ static int gdm_lte_emulate_arp(struct sk_buff *skb_in, u32 nic_type)
 
 static __sum16 icmp6_checksum(struct ipv6hdr *ipv6, u16 *ptr, int len)
 {
-	unsigned short *w = ptr;
+	unsigned short *w;
 	__wsum sum = 0;
 	int i;
 	u16 pa;
-- 
2.25.1

