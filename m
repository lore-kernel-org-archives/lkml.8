Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB72C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D24E2072E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:53:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="liwBAaC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390772AbgFYIxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:53:18 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:9901 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390330AbgFYIxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:53:18 -0400
X-Greylist: delayed 710 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2020 04:53:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1593075195;
        s=strato-dkim-0002; d=goldelico.com;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=SvsiqIbgk6cr+c3F2pDU3S39cYipI5EbMOg0nUe8u9k=;
        b=liwBAaC7AFzEq5wyZO0ubn1FEmlmt8d9QlhtbS+JbBNAsm2zMXYlKfDmFFT0cjDgfy
        vpo2fpzCdYEDr/L7qqTezkmCFUULCQ9mlLj0Ppccyr6P3sntfTBsujPCk4GFCRwmc7z8
        uDlBlfOD/CbRHOgZAjCvC1RwCPC9KPxX19vtDHS6kaDOjZvchx1bCl/ESl1iSsNbaLAk
        ilXpeTjDLAUm7OTZmrcI6Wk/sZ4b53ZeLVOXkhGB3gNtZuboK8oCMlnFM5eeOJ+tezEP
        K7pslX25g0bzWjvUBxUcEVASFhpJ7QtaA0ygAMW8wE3X7Qq80Lu8xDajadpP2RbS0rJg
        kl9Q==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9o1mfYzBGHXH7F/3/9Q=="
X-RZG-CLASS-ID: mo00
Received: from iMac.fritz.box
        by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
        with ESMTPSA id V07054w5P8fE5bH
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 25 Jun 2020 10:41:14 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH] modpost: remove use of non-standard strsep() in HOSTCC code
Date:   Thu, 25 Jun 2020 10:41:13 +0200
Message-Id: <11c1e65b393b4c3ca6118515c77bbf19524dab11.1593074472.git.hns@goldelico.com>
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

So let's add some lines of code separating the string at the
next newline character instead of using strsep(). It does not
hurt kernel size or speed since this code is run on the build host.

Fixes: ac5100f5432967 ("modpost: add read_text_file() and get_line() helpers")
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 scripts/mod/modpost.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 6aea65c65745..8fe63989c6e1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -138,11 +138,16 @@ char *read_text_file(const char *filename)
 
 char *get_line(char **stringp)
 {
+	char *p;
 	/* do not return the unwanted extra line at EOF */
 	if (*stringp && **stringp == '\0')
 		return NULL;
 
-	return strsep(stringp, "\n");
+	p = *stringp;
+	while (**stringp != '\n')
+		(*stringp)++;
+	*(*stringp)++ = '\0';
+	return p;
 }
 
 /* A list of all modules we processed */
-- 
2.26.2

