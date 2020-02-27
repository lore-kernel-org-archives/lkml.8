Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E711C76594
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0144724688
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814150;
	bh=S0yGJG0Id9N1yY6MyKdC5gdWa6cxWpV1/yYUVgykXEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hB28rQiZ3T4J8+m3NkyZ1VNZcHrUCJbRlDByABgyES60gc3pdE7+MczL/emPgMDmx
	 ayntfBliFNf9IZOAtnZm0YdNGLsYCJIWkqLaCkKIaaLvqmgxNJ8tuFgJbvuhjmmfWR
	 duDN47PbrCAsf+cCryzoJlsH2Pgtxoa6tK7pAkPo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732641AbgB0N7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:59:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:32916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732633AbgB0N7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:59:42 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DB4B20578;
        Thu, 27 Feb 2020 13:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811982;
        bh=S0yGJG0Id9N1yY6MyKdC5gdWa6cxWpV1/yYUVgykXEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V0ydJYk59tHvBowLVopOmnkmiJbX/haxgz205dzK6dZZPJI2WJ0Ebqkk0RhuO4WXR
         cBxEyIMW+iPeC1HvoSIsbwWCMpcxjmFSxjabKTL7dBIiJRLQnWssaHil4rKDh/SBSo
         xqoRsgjdEfTZ6oIC7567Op7wh2MxvpGCWTHr2qHQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordy Zomer <jordy@simplyhacker.com>,
        Willy Tarreau <w@1wt.eu>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 176/237] floppy: check FDC index for errors before assigning it
Date:   Thu, 27 Feb 2020 14:36:30 +0100
Message-Id: <20200227132309.349166224@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132255.285644406@linuxfoundation.org>
References: <20200227132255.285644406@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

commit 2e90ca68b0d2f5548804f22f0dd61145516171e3 upstream.

Jordy Zomer reported a KASAN out-of-bounds read in the floppy driver in
wait_til_ready().

Which on the face of it can't happen, since as Willy Tarreau points out,
the function does no particular memory access.  Except through the FDCS
macro, which just indexes a static allocation through teh current fdc,
which is always checked against N_FDC.

Except the checking happens after we've already assigned the value.

The floppy driver is a disgrace (a lot of it going back to my original
horrd "design"), and has no real maintainer.  Nobody has the hardware,
and nobody really cares.  But it still gets used in virtual environment
because it's one of those things that everybody supports.

The whole thing should be re-written, or at least parts of it should be
seriously cleaned up.  The 'current fdc' index, which is used by the
FDCS macro, and which is often shadowed by a local 'fdc' variable, is a
prime example of how not to write code.

But because nobody has the hardware or the motivation, let's just fix up
the immediate problem with a nasty band-aid: test the fdc index before
actually assigning it to the static 'fdc' variable.

Reported-by: Jordy Zomer <jordy@simplyhacker.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/floppy.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -848,14 +848,17 @@ static void reset_fdc_info(int mode)
 /* selects the fdc and drive, and enables the fdc's input/dma. */
 static void set_fdc(int drive)
 {
+	unsigned int new_fdc = fdc;
+
 	if (drive >= 0 && drive < N_DRIVE) {
-		fdc = FDC(drive);
+		new_fdc = FDC(drive);
 		current_drive = drive;
 	}
-	if (fdc != 1 && fdc != 0) {
+	if (new_fdc >= N_FDC) {
 		pr_info("bad fdc value\n");
 		return;
 	}
+	fdc = new_fdc;
 	set_dor(fdc, ~0, 8);
 #if N_FDC > 1
 	set_dor(1 - fdc, ~8, 0);


