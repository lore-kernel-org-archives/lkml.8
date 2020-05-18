Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C664C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 545922087D
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589825116;
	bh=YejrB3xnXuLpOQRytvCx3Nvljyswk4AfYXxt6KjMsK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=in+5o6f+XVe1TFDYkFTXEsHSYBAjHp8nFxWgiXRuxl+zsBx0DQn9XLApsagG7BlGR
	 LaPLI8Ws7OBp3hb5IZHbVJ9GJY/0QyKdh2mBdYDiviY+75V3X+FAcorygGugI6cGR2
	 z4xi/Y3lnDxxCHt43FEIHKrcxwJvt2PJBHP2Nk9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732914AbgERSFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:05:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732880AbgERSFD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:05:03 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E0DC207F5;
        Mon, 18 May 2020 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589825102;
        bh=YejrB3xnXuLpOQRytvCx3Nvljyswk4AfYXxt6KjMsK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlBSQbuF6aSO3VaPewjYpfTl0R1mKZS1vxNT2FQZNv87Dw1ZpBoUhKEujURbcB6Kq
         BWYh18Y7KNh+VQ9XAl/jPQZ4yrhV/ZWTHofMWLOCuWaQ+KTT37OOQctm2/QZCvLOO+
         OIgmbw1Qk9mfzR/801zOBGAlrEtbNCkSaBSQwMMM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.6 131/194] gcc-10 warnings: fix low-hanging fruit
Date:   Mon, 18 May 2020 19:37:01 +0200
Message-Id: <20200518173542.369782651@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173531.455604187@linuxfoundation.org>
References: <20200518173531.455604187@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 9d82973e032e246ff5663c9805fbb5407ae932e3 upstream.

Due to a bug-report that was compiler-dependent, I updated one of my
machines to gcc-10.  That shows a lot of new warnings.  Happily they
seem to be mostly the valid kind, but it's going to cause a round of
churn for getting rid of them..

This is the really low-hanging fruit of removing a couple of zero-sized
arrays in some core code.  We have had a round of these patches before,
and we'll have many more coming, and there is nothing special about
these except that they were particularly trivial, and triggered more
warnings than most.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/fs.h  |    2 +-
 include/linux/tty.h |    2 +-
 scripts/kallsyms.c  |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -978,7 +978,7 @@ struct file_handle {
 	__u32 handle_bytes;
 	int handle_type;
 	/* file identifier */
-	unsigned char f_handle[0];
+	unsigned char f_handle[];
 };
 
 static inline struct file *get_file(struct file *f)
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -66,7 +66,7 @@ struct tty_buffer {
 	int read;
 	int flags;
 	/* Data points here */
-	unsigned long data[0];
+	unsigned long data[];
 };
 
 /* Values for .flags field of tty_buffer */
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -34,7 +34,7 @@ struct sym_entry {
 	unsigned int len;
 	unsigned int start_pos;
 	unsigned int percpu_absolute;
-	unsigned char sym[0];
+	unsigned char sym[];
 };
 
 struct addr_range {


