Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BFCFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ACF42070E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 02:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nfbn8UG/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGRCx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 22:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgGRCx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 22:53:58 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B0BC0619D2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=GzlPXFCdnE8qiAPV6yYy6TSoiVWy24FOzeQV4pJhAzk=; b=Nfbn8UG/+yGFEcWTzZlq4G3l87
        Dlen0lbw1ayjgxJYc7Kjq4pYF9eyBzg15fnD8Bo6N33e5F+1Gpr3Veg81gvdzjJhUFxePQyxu/d51
        mfPZ2nuyCHpCEffEfzI1Pmp2Fds2V+npxh2yXB2h0KvElfbNeztybqOJy/Pi6i8aV0Hlys9YQj0q6
        CdUfaQ2X8gsFg9aeZ18qbaoiB5z/PHANGrO/joZ7mzkGmg3CCum2XhRGvD6fdpeFo/ic3IiWReJoN
        PzmIwbs/h3P+oKrbBfyRDu4Co4KBphP8fweCd6u6SfSGMR1xHiD0wp0kyzg7c7+x3WILvWFJCxmGZ
        aESv+unA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jwcz1-0006mH-Ek; Sat, 18 Jul 2020 02:53:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] linux/async_tx.h: drop duplicated word in a comment
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Message-ID: <e85802f7-8f48-8b4c-29b3-ea237a2c7ae9@infradead.org>
Date:   Fri, 17 Jul 2020 19:53:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/async_tx.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/async_tx.h
+++ linux-next-20200714/include/linux/async_tx.h
@@ -36,7 +36,7 @@ struct dma_chan_ref {
 /**
  * async_tx_flags - modifiers for the async_* calls
  * @ASYNC_TX_XOR_ZERO_DST: this flag must be used for xor operations where the
- * the destination address is not a source.  The asynchronous case handles this
+ * destination address is not a source.  The asynchronous case handles this
  * implicitly, the synchronous case needs to zero the destination block.
  * @ASYNC_TX_XOR_DROP_DST: this flag must be used if the destination address is
  * also one of the source addresses.  In the synchronous case the destination

