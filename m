Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A353C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3184620760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 06:18:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="rahh8Lpd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGAGSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 02:18:35 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:22158 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgGAGSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 02:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1593584309;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=hHTbDji59HWIcDpa9W1crvIzeARl8Lnnp4s9a21WTBM=;
        b=rahh8LpdFzDGbdJ/Nau2ZNJdK16CIKberBw9fh2SXL9/QMC03tZ00ROsvD4xoXz5b6
        ugxena53zdidjB0/sP5ywmbbLQ0SHkjWTLIy1ovZ7jelZX9Tu9WcksvGR74RIRJXguCe
        S0O7NGf5GyqnO2lqVCQerM9Jjhf+fGlO1sLTa70ZvWLyuUMnVTKn+CoHtWOZ649BxxTS
        OjechFyEdyMWTaNvj7K0KXfD3SEBYKWOZEoAcjVJCT/13d6uHE1ho9ITneDeQfoSQAbE
        5XOktCIsFyqoYakaBGuqQGq2XwGu4hu00ZjnR3B+0R1BM59/wXJIdRXJSiAx2pz5uWx3
        qPJg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH5H6cGHkA="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id V07054w616ISUXc
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 1 Jul 2020 08:18:28 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2] modpost: remove use of non-standard strsep() in HOSTCC code
Date:   Wed,  1 Jul 2020 08:18:27 +0200
Message-Id: <60381408622ebbb7d205b2cf6edcf8c6acecf1d7.1593584306.git.hns@goldelico.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

strsep() is neither standard C nor POSIX and used outside
the kernel code here. Using it here requires that the
build host supports it out of the box which is e.g.
not true for a Darwin build host and using a cross-compiler.
This leads to:

scripts/mod/modpost.c:145:2: warning: implicit declaration of function 'strsep' [-Wimplicit-function-declaration]
  return strsep(stringp, "\n");
  ^

and a segfault when running MODPOST.

See also: https://stackoverflow.com/a/7219504

So let's replace this by strchr() instead of using strsep().
It does not hurt kernel size or speed since this code is run
on the build host.

Fixes: ac5100f5432967 ("modpost: add read_text_file() and get_line() helpers")
Co-developed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 scripts/mod/modpost.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6aea65c657454..45f2ab2ec2d46 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -138,11 +138,19 @@ char *read_text_file(const char *filename)
 
 char *get_line(char **stringp)
 {
+	char *orig = *stringp, *next;
+
 	/* do not return the unwanted extra line at EOF */
-	if (*stringp && **stringp == '\0')
+	if (!orig || *orig == '\0')
 		return NULL;
 
-	return strsep(stringp, "\n");
+	next = strchr(orig, '\n');
+	if (next)
+		*next++ = '\0';
+
+	*stringp = next;
+
+	return orig;
 }
 
 /* A list of all modules we processed */
-- 
2.26.2

