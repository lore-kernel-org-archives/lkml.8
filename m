Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF30C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:31:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B869B208B3
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 00:31:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MSNQl4tX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbgGSAbx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 20:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgGSAbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 20:31:53 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B71C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 17:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=IEIFGEJUz4nV4iYKrpXYIjqezeRPWTZDKz15XILzjgk=; b=MSNQl4tXS6qA+JcjkEIV0z91ya
        0nghPAyg0g6P2HklukzoD5vbRfvcQG2uAoDXG2JiUPm/TiAhJQp3QOI6mfYXBodfhNRjikGTFrGIW
        GcagQYlKPLXbDu5pYjtO+CVCiEMJYwV1NYtolSERSg+gWiQi3SduzqrQKNPYnN0OWyqFfMDpHZ+nx
        YCW1l15qO2tXA90lYEE8xp+Cwcfgi72v7cFtjPzeA4Fp5LSxujwSMHX8cSgyfltlYhTB+wRjXr6lu
        J0ohWo99HEZmKHbTuXHjet0MQQFWVyhfmszEE8Ik3xzofz88UcI3yhzqtYcavUISSfRNCS8TPAATV
        9RL7ZpHw==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwxF8-0002xA-9X; Sun, 19 Jul 2020 00:31:50 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Nishanth Menon <nm@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] soc: ti/ti_sci_protocol.h: drop a duplicated word + clarify
Date:   Sat, 18 Jul 2020 17:31:45 -0700
Message-Id: <20200719003145.21100-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "an" in a comment.
Insert "and" between "source" and "destination" as is done a few
lines earlier.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nishanth Menon <nm@ti.com>
Cc: Tero Kristo <t-kristo@ti.com>
Cc: Santosh Shilimkar <ssantosh@kernel.org>
Cc: Lokesh Vutla <lokeshvutla@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org
---
 include/linux/soc/ti/ti_sci_protocol.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200717.orig/include/linux/soc/ti/ti_sci_protocol.h
+++ linux-next-20200717/include/linux/soc/ti/ti_sci_protocol.h
@@ -226,8 +226,8 @@ struct ti_sci_rm_core_ops {
  *			and destination
  * @set_event_map:	Set an Event based peripheral irq to Interrupt
  *			Aggregator.
- * @free_irq:		Free an an IRQ route between the requested source
- *			destination.
+ * @free_irq:		Free an IRQ route between the requested source
+ *			and destination.
  * @free_event_map:	Free an event based peripheral irq to Interrupt
  *			Aggregator.
  */
