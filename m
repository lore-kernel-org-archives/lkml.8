Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECEFC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19665221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599842533;
	bh=aRm/nSH7/SoWVBtD3aaiB7zpszrW2lrJPlUGWAXYJNk=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fvKJEr5iVnBoj1giBQFnnEedY8Qw7w6xYRciZ8VONAw6SLvS5/0ICQfJntCc9QOkp
	 17q5o0OallEKGEhjk7Sz2efc7OS4OHXHqwDLl/Oxs1mFWdiH/Quo5JL33cJC3Jk77s
	 2zYI+9c3ekfo7eNxRMO9dZIV1RUnw+2JGqHMsbDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgIKQmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbgIKPKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:10:04 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6FB4222C3;
        Fri, 11 Sep 2020 14:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599834842;
        bh=aRm/nSH7/SoWVBtD3aaiB7zpszrW2lrJPlUGWAXYJNk=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=tFh2XMpZBBVQfnwhuAwKDsnDbp8gy95H9eEk9cih8VsCD+4pYXSnH1aClS2/5p6ng
         Yn2X9JpKS8DdRQJCUnyAG7Vwy+US66Q+BeExOoKoIPZrahCZM63lobVJYDuD6zfDNS
         IqN/EI2OKP/0AKav99/1eTM+wqljTi/r2d6TVWxY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 2/3] serial: s3c: Update path of Samsung S3C machine file
Date:   Fri, 11 Sep 2020 16:33:42 +0200
Message-Id: <20200911143343.498-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911143343.498-1-krzk@kernel.org>
References: <20200911143343.498-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the path to Samsung S3C24xx machine file, mentioned in
documentation.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 include/linux/serial_s3c.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/serial_s3c.h b/include/linux/serial_s3c.h
index 463ed28d2b27..ca2c5393dc6b 100644
--- a/include/linux/serial_s3c.h
+++ b/include/linux/serial_s3c.h
@@ -254,7 +254,7 @@
  * serial port
  *
  * the pointer is setup by the machine specific initialisation from the
- * arch/arm/mach-s3c2410/ directory.
+ * arch/arm/mach-s3c/ directory.
 */
 
 struct s3c2410_uartcfg {
-- 
2.17.1

