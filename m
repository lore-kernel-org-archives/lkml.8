Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739F7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 460A52177B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 00:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Bd8OgdDm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgGTAPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 20:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgGTAPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 20:15:01 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D61C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 17:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=ZzC3bDxExMRw5At5PKSW5xY2DfFG27TV8AUMY/YxGmc=; b=Bd8OgdDmhUqCqAnF8hF3D5mN+e
        S0iCg41hdh7iIzuvzVEKi+0Ac8dF0Z9LWgVYiLIPH7INesSYkVhQft2dInvQem9gEgiGBEuL3bNCD
        rWKx0MVNxBEaEXmU1ZuqHJ1RxGZ/P/xnhPgz3zMlfjl/E1WPK7Q1VTOQ8cY3cU6R4alldVTUGW1id
        fudmHfAPlzv15+kG7txxXbvRxAK4aYYQkNPROS3MAPgh6NKQK1Uj0xz9QESghg0cE8/VwSks2jDpL
        p6ypAXk2bUpaHSKA+T9tSm/BUkIij7p0Mn8QijRy+RrJuJEIwzrvCjAUzqARdp0THaLRaV9VTebhf
        ZRcKoDJA==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxJSN-000420-1X; Mon, 20 Jul 2020 00:14:59 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jan Kara <jack@suse.com>
Subject: [PATCH] udf: osta_udf.h: delete a duplicated word
Date:   Sun, 19 Jul 2020 17:14:55 -0700
Message-Id: <20200720001455.31882-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the repeated word "struct" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jan Kara <jack@suse.com>
---
 fs/udf/osta_udf.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200717.orig/fs/udf/osta_udf.h
+++ linux-next-20200717/fs/udf/osta_udf.h
@@ -226,7 +226,7 @@ struct sparingTable {
 #define ICBTAG_FILE_TYPE_MIRROR		0xFB
 #define ICBTAG_FILE_TYPE_BITMAP		0xFC
 
-/* struct struct long_ad ICB - ADImpUse (UDF 2.60 2.2.4.3) */
+/* struct long_ad ICB - ADImpUse (UDF 2.60 2.2.4.3) */
 struct allocDescImpUse {
 	__le16		flags;
 	uint8_t		impUse[4];
