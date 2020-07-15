Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 825E6C433F1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52ED820773
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eFYy8368"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgGOC7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728487AbgGOC7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:59:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759D4C061755;
        Tue, 14 Jul 2020 19:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6lwWwAlEO1r2TqlY65WPd8CYnqdDTpT/FurFBVz8FjY=; b=eFYy8368wH5BhB/TGgki+74rsA
        dep1hjzoyuDe/DqJ4sYhrmzQL0oHwVnSJYnquI3S9H5WeUsX9eotT7F03kOQIXzwB+8//Da4sgia5
        LgQtNh7iM8d2JsEJKDeub2Dfv6hHcSr9JtqOIDlasFmYcBEvYet4GfFY1LRyoVtBZ5+KVt2iXUmMW
        Q6+3jBU/X6QmBw0j1GWVkwcU1seWZMY+QtMRH9TtE0nkVqwMGaLcqnVCxmYFXqdogHSh1pUyk/WlC
        j7fYv9e21tDQCO9C71GD5O78idefs8go7dCGVcZW0UHGHkaSfTReC/CBU7pUe8hG8Vwml+KHKZ/yx
        irFMznhg==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvXe4-0001FT-CL; Wed, 15 Jul 2020 02:59:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 13/13 net-next] net: sctp: drop duplicate words in comments
Date:   Tue, 14 Jul 2020 19:59:14 -0700
Message-Id: <20200715025914.28091-13-rdunlap@infradead.org>
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
 include/net/sctp/sctp.h    |    2 +-
 include/net/sctp/structs.h |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20200714.orig/include/net/sctp/sctp.h
+++ linux-next-20200714/include/net/sctp/sctp.h
@@ -291,7 +291,7 @@ atomic_dec(&sctp_dbg_objcnt_## name)
 #define SCTP_DBG_OBJCNT(name) \
 atomic_t sctp_dbg_objcnt_## name = ATOMIC_INIT(0)
 
-/* Macro to help create new entries in in the global array of
+/* Macro to help create new entries in the global array of
  * objcnt counters.
  */
 #define SCTP_DBG_OBJCNT_ENTRY(name) \
--- linux-next-20200714.orig/include/net/sctp/structs.h
+++ linux-next-20200714/include/net/sctp/structs.h
@@ -1398,7 +1398,7 @@ struct sctp_stream_priorities {
 	struct list_head prio_sched;
 	/* List of streams scheduled */
 	struct list_head active;
-	/* The next stream stream in line */
+	/* The next stream in line */
 	struct sctp_stream_out_ext *next;
 	__u16 prio;
 };
@@ -1460,7 +1460,7 @@ struct sctp_stream {
 		struct {
 			/* List of streams scheduled */
 			struct list_head rr_list;
-			/* The next stream stream in line */
+			/* The next stream in line */
 			struct sctp_stream_out_ext *rr_next;
 		};
 	};
@@ -1770,7 +1770,7 @@ struct sctp_association {
 	int max_burst;
 
 	/* This is the max_retrans value for the association.  This value will
-	 * be initialized initialized from system defaults, but can be
+	 * be initialized from system defaults, but can be
 	 * modified by the SCTP_ASSOCINFO socket option.
 	 */
 	int max_retrans;
