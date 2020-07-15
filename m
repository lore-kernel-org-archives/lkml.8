Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02056C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88252074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tijZ3PQd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgGOC72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728400AbgGOC71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:59:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E903DC061755;
        Tue, 14 Jul 2020 19:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=mVHy83G7pEXwI9BgD2a/q+FOfNR4hZzrhDfASssAAeQ=; b=tijZ3PQdVjKLVP03vqgoLHjpPB
        angGynbx23svFmL1ClWPr0RmNC7UGFmLs3mn9tw4Dmu70pn0gsNzn8edyacwKQx2axo1QhwvEaBBb
        pzODTlXrDmC+dOCm+PSooM6W8snLmymtcLRE+u7oiNmzcShsU4v2OWcMdw0vYylGXpq2yz876sxR6
        /xFPhmB7kAZ+JfFoRf8Oql/mWQljvUN9D7hMHAYIEXuD/W+3dlnRh6Nl9slGgau5fCPUPIQj+4yL6
        0kzH8qVDFSazRwmMpdrP8aXUYK5nczNYTQGBrtOeGnyCWblFP6XBBaWirHhmzbOSVLXVW7eF5I1Xg
        0FOdQNxQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvXdk-0001FT-T3; Wed, 15 Jul 2020 02:59:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 04/13 net-next] net: skbuff.h: drop duplicate words in comments
Date:   Tue, 14 Jul 2020 19:59:05 -0700
Message-Id: <20200715025914.28091-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715025914.28091-1-rdunlap@infradead.org>
References: <20200715025914.28091-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop doubled words in several comments.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
---
 include/linux/skbuff.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200714.orig/include/linux/skbuff.h
+++ linux-next-20200714/include/linux/skbuff.h
@@ -1329,7 +1329,7 @@ void skb_flow_dissect_meta(const struct
 			   void *target_container);
 
 /* Gets a skb connection tracking info, ctinfo map should be a
- * a map of mapsize to translate enum ip_conntrack_info states
+ * map of mapsize to translate enum ip_conntrack_info states
  * to user states.
  */
 void
@@ -3813,7 +3813,7 @@ static inline bool skb_defer_rx_timestam
  * must call this function to return the skb back to the stack with a
  * timestamp.
  *
- * @skb: clone of the the original outgoing packet
+ * @skb: clone of the original outgoing packet
  * @hwtstamps: hardware time stamps
  *
  */
