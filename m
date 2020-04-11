Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B594CC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CA85206A1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 12:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586608085;
	bh=AcBFXy1P5pp0NYZzcNFogesBtVIyMuNSi9AXpvItTgA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lpCK2MrmotYlkWPawpVynH8sPLRuBlwIcqwO9YzCRba82CcawAEATWKoSwjpcAAPG
	 xrGTYzDRaqDqCdffHT20DIWJXFzixzIUy5gC16WNxaUu8oJWPJDR6q8obOMpcLkn76
	 Ap1e7AX1sFs5bsiqwv0YlrjSWfmitBD9rRsRIbPg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgDKM2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 08:28:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727716AbgDKMNR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 08:13:17 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E3B0215A4;
        Sat, 11 Apr 2020 12:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586607196;
        bh=AcBFXy1P5pp0NYZzcNFogesBtVIyMuNSi9AXpvItTgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8g8VGF/ENokwyNKSyqCSiQy1hicDECip9Hef4J1M9fpBdNSiSJVo1tPpHdn1GWjG
         kndGnBN+a4RdseCbEh3Xrgurve9bUCI+Y/46ceeFgv3rC8oYf6z7NW63HOCma9h77u
         RU+M2qs5W6kg+3YprjqTo/VF45ojyNY5ujfErMX0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Entropy Moe <3ntr0py1337@gmail.com>,
        syzbot+b055b1a6b2b958707a21@syzkaller.appspotmail.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 14/38] mm: mempolicy: require at least one nodeid for MPOL_PREFERRED
Date:   Sat, 11 Apr 2020 14:08:58 +0200
Message-Id: <20200411115439.404714511@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200411115437.795556138@linuxfoundation.org>
References: <20200411115437.795556138@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

commit aa9f7d5172fac9bf1f09e678c35e287a40a7b7dd upstream.

Using an empty (malformed) nodelist that is not caught during mount option
parsing leads to a stack-out-of-bounds access.

The option string that was used was: "mpol=prefer:,".  However,
MPOL_PREFERRED requires a single node number, which is not being provided
here.

Add a check that 'nodes' is not empty after parsing for MPOL_PREFERRED's
nodeid.

Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
Reported-by: Entropy Moe <3ntr0py1337@gmail.com>
Reported-by: syzbot+b055b1a6b2b958707a21@syzkaller.appspotmail.com
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: syzbot+b055b1a6b2b958707a21@syzkaller.appspotmail.com
Cc: Lee Schermerhorn <lee.schermerhorn@hp.com>
Link: http://lkml.kernel.org/r/89526377-7eb6-b662-e1d8-4430928abde9@infradead.org
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/mempolicy.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2748,7 +2748,9 @@ int mpol_parse_str(char *str, struct mem
 	switch (mode) {
 	case MPOL_PREFERRED:
 		/*
-		 * Insist on a nodelist of one node only
+		 * Insist on a nodelist of one node only, although later
+		 * we use first_node(nodes) to grab a single node, so here
+		 * nodelist (or nodes) cannot be empty.
 		 */
 		if (nodelist) {
 			char *rest = nodelist;
@@ -2756,6 +2758,8 @@ int mpol_parse_str(char *str, struct mem
 				rest++;
 			if (*rest)
 				goto out;
+			if (nodes_empty(nodes))
+				goto out;
 		}
 		break;
 	case MPOL_INTERLEAVE:


