Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD664C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A233A20715
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823853;
	bh=YYMYHaJ7dIKiN0AUTmCmeYnbeYe4c0sF3JbTETkqaVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YbbBHe03kd7mVuiOAS3arlSeRDC15LKPhIwm0c8gRluPDkwSVcRLaurP/uFHnln+z
	 MpsbV78+/v4lyYtPQ780SDIDj3BzYa90EL/fp0OaaZm1jwo2jOsOFM3rpfTGQyl6Yb
	 0G9DStQZlI36OXLHvG1p81JvRpazRNMyzk9JLAu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgERRoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:44:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729684AbgERRoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:44:08 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 823AA20835;
        Mon, 18 May 2020 17:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823848;
        bh=YYMYHaJ7dIKiN0AUTmCmeYnbeYe4c0sF3JbTETkqaVg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YWy2l3EwZHlXdIVdDReVG29vV7To6AUKfMBRi0NywrmJ7ej3iCteBWrn+hACcu6w6
         9b4ecLJUeiT+vfTJZ2c+ygqKFv4CRNlZP3r7Cfw58wjUQAXTrnkA2qTvgX6dlxqZ/F
         0tjmaPYYB0HSjbakiw1azEaZaSSXvXNuGTcmpr6Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 59/90] gcc-10 warnings: fix low-hanging fruit
Date:   Mon, 18 May 2020 19:36:37 +0200
Message-Id: <20200518173503.116845220@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.930655662@linuxfoundation.org>
References: <20200518173450.930655662@linuxfoundation.org>
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
 2 files changed, 2 insertions(+), 2 deletions(-)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -931,7 +931,7 @@ struct file_handle {
 	__u32 handle_bytes;
 	int handle_type;
 	/* file identifier */
-	unsigned char f_handle[0];
+	unsigned char f_handle[];
 };
 
 static inline struct file *get_file(struct file *f)
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -64,7 +64,7 @@ struct tty_buffer {
 	int read;
 	int flags;
 	/* Data points here */
-	unsigned long data[0];
+	unsigned long data[];
 };
 
 /* Values for .flags field of tty_buffer */


