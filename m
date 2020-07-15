Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A8C3C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744372074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gkIvlsdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgGOC70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728363AbgGOC7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:59:25 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADE0C061755;
        Tue, 14 Jul 2020 19:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BD3P332ZfKrZs8zwKB/XgZ+seNKO8OuAJMlYgtufFKo=; b=gkIvlsdwrVWdWJQqjtH7gXW2i3
        nhDPAdTS3G9HkpW5+/fQb5jSW0VxR7nkJff4RoewzbuGPuRoLQ7W1/+qjuXt2mg9OOx4fVT3FfIXM
        s6B2lUyy++x5Qt50vXIvOEHi0/2E/LT2daMnHYsZQkKL0PI9CopbCIi08RjyW1zSLin3GlY7sYx/4
        +MHYgTNrqec1EfgKrB0dQdwJaHdw1bD4gEINvNART8PNoz+Fuc+3No1qRfbyK06JghAxkySNGyeyD
        YL7B+49RSSTtiWQI41L0puqLt7OY9UI65nksEfjeKcdbW6cWAyck9QZkUV8JCI5Cty4cWq5ceurW3
        UvXyJDjA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvXdi-0001FT-MP; Wed, 15 Jul 2020 02:59:23 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 03/13 net-next] net: qed: drop duplicate words in comments
Date:   Tue, 14 Jul 2020 19:59:04 -0700
Message-Id: <20200715025914.28091-3-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715025914.28091-1-rdunlap@infradead.org>
References: <20200715025914.28091-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled word "the" in two comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 include/linux/qed/qed_chain.h |    2 +-
 include/linux/qed/qed_if.h    |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/qed/qed_chain.h
+++ linux-next-20200714/include/linux/qed/qed_chain.h
@@ -130,7 +130,7 @@ struct qed_chain {
 	} pbl_sp;
 
 	/* Address of first page of the chain - the address is required
-	 * for fastpath operation [consume/produce] but only for the the SINGLE
+	 * for fastpath operation [consume/produce] but only for the SINGLE
 	 * flavour which isn't considered fastpath [== SPQ].
 	 */
 	void *p_virt_addr;
--- linux-next-20200714.orig/include/linux/qed/qed_if.h
+++ linux-next-20200714/include/linux/qed/qed_if.h
@@ -498,7 +498,7 @@ struct qed_fcoe_pf_params {
 	u8 bdq_pbl_num_entries[2];
 };
 
-/* Most of the the parameters below are described in the FW iSCSI / TCP HSI */
+/* Most of the parameters below are described in the FW iSCSI / TCP HSI */
 struct qed_iscsi_pf_params {
 	u64 glbl_q_params_addr;
 	u64 bdq_pbl_base_addr[3];
