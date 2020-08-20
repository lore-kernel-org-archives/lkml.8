Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB67C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70447207DE
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 06:25:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xoWcFp02";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8KqvayEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHTGZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 02:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgHTGZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 02:25:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776E2C061757;
        Wed, 19 Aug 2020 23:25:14 -0700 (PDT)
Date:   Thu, 20 Aug 2020 06:25:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597904712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yWX5ssX1k5opQq0Q0AOc6iPkThMUuzgITW4vyDf02GI=;
        b=xoWcFp02RSUs9NIGDLQ8LaKQL0u+7WXVEN4HIaHDrUsl5s0hcIZb3Fmw5yQaVEXjFjpOp5
        LflPuW+vE8soi7hp58lJnIUuNTxn1+FUqO2Bkj77xN3nDcs2wecROQLuqPvsemssbexhk6
        1MF7d0Vv5txg3uFVNogLFAe1ID8qxCXrVQYWCplfN5mIvlD0A2blGQMYCPs30YUDCuvX+R
        n9W2TvMpIrDhjhvmqVxoXmn27+izEQSAE6Nstg/UFzyFx4BTdAHCHr2hYOtpWEIShCiKPD
        hvOxmpdDaHz+pX7oXwREmKq6HPt3z97kBUo6MOrqZZGliq3EwH4i1PvKfqpBgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597904712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=yWX5ssX1k5opQq0Q0AOc6iPkThMUuzgITW4vyDf02GI=;
        b=8KqvayEHDJQ8yL2aypNLDR5/1oNxkDoJSn4D3ULvO8+geRgIqrP5Xdy/bab7hXpk3xsMDw
        pwxNBwe1tAeYYrBQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Declutter the build output
Cc:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        x86@kernel.org
MIME-Version: 1.0
Message-ID: <159790471143.3192.7295132555252528512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     642d94cf336fe57675e63a91d11f53d74b9a3f9f
Gitweb:        https://git.kernel.org/tip/642d94cf336fe57675e63a91d11f53d74b9a3f9f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 20 Aug 2020 08:17:40 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 20 Aug 2020 08:17:40 +02:00

x86/build: Declutter the build output

We have some really ancient debug printouts in the x86 boot image build code:

  Setup is 14108 bytes (padded to 14336 bytes).
  System is 8802 kB
  CRC 27e909d4

None of these ever helped debug any sort of breakage that I know of, and they
clutter the build output.

Remove them - if anyone needs the see the various interim stages of this to
debug an obscure bug, they can add these printfs and more.

We still keep this one:

  Kernel: arch/x86/boot/bzImage is ready  (#19)

As a sentimental leftover, plus the '#19' build count tag is mildly useful.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
 arch/x86/boot/tools/build.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/boot/tools/build.c b/arch/x86/boot/tools/build.c
index c8b8c1a..a3725ad 100644
--- a/arch/x86/boot/tools/build.c
+++ b/arch/x86/boot/tools/build.c
@@ -416,8 +416,6 @@ int main(int argc, char ** argv)
 	/* Set the default root device */
 	put_unaligned_le16(DEFAULT_ROOT_DEV, &buf[508]);
 
-	printf("Setup is %d bytes (padded to %d bytes).\n", c, i);
-
 	/* Open and stat the kernel file */
 	fd = open(argv[2], O_RDONLY);
 	if (fd < 0)
@@ -425,7 +423,6 @@ int main(int argc, char ** argv)
 	if (fstat(fd, &sb))
 		die("Unable to stat `%s': %m", argv[2]);
 	sz = sb.st_size;
-	printf("System is %d kB\n", (sz+1023)/1024);
 	kernel = mmap(NULL, sz, PROT_READ, MAP_SHARED, fd, 0);
 	if (kernel == MAP_FAILED)
 		die("Unable to mmap '%s': %m", argv[2]);
@@ -488,7 +485,6 @@ int main(int argc, char ** argv)
 	}
 
 	/* Write the CRC */
-	printf("CRC %x\n", crc);
 	put_unaligned_le32(crc, buf);
 	if (fwrite(buf, 1, 4, dest) != 4)
 		die("Writing CRC failed");
