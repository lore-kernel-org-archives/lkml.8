Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7062CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41A2822CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ulukai.org header.i=@ulukai.org header.b="joORiURJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730211AbgEVO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728947AbgEVO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:27:02 -0400
X-Greylist: delayed 977 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 May 2020 07:27:02 PDT
Received: from ulukai.org (ulukai.org [IPv6:2a01:488:66:1000:b01c:1258:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCA7C061A0E;
        Fri, 22 May 2020 07:27:02 -0700 (PDT)
Received: from arona (unknown [46.114.108.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by ulukai.org (Postfix) with ESMTPSA id 49T7gP4fXhz3GvB;
        Fri, 22 May 2020 16:10:41 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at ulukai.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ulukai.org; s=ulukai;
        t=1590156641; bh=sWdSGL53EfDwJLVKZKFLd7/vKcGqH4BG8g+uuzQqTLA=;
        h=From:To:Cc:Subject:Date:From;
        b=joORiURJ/QVNi7zV97rNXb2YTaVXn/+sjlSISaOdyaNYQRtBT3/3pLwB1W2FrVcVR
         PBPVPrhoVAbw6hDi9pvdn53lCLzm856ZGNfgscfF8ClZTkmMvXgalSqgl4HC/TBhRV
         cuPP9sQivpF7aIB15MF9q6FY/VClGcD4P+b68X4E=
From:   "C. Masloch" <pushbx@ulukai.org>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dave Rodgman <dave.rodgman@arm.com>, Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] docs: lzo: fix first byte interpretation off-by-one
Date:   Fri, 22 May 2020 16:10:39 +0200
Message-Id: <20200522141040.1353769-1-pushbx@ulukai.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There was an error in the description of the initial byte's
interpretation. While "18..21" was listed as  "copy 0..3 literals",
it should actually be interpreted as "copy 1..4 literals".

The "byte - 17" part is correct. 17 would encode copying "zero"
literals, but does not occur. 18 encodes copying 1 literal,
19 then 2 literals, 20 for 3 literals, 21 for 4 literals.
The description should read "18..21" as "copy 1..4 literals".
Likewise, 22 indicates "copying 5 literals", not "4 literals".
However, the state is indeed always set to "byte - 17" (which
for 21 results in 4 too).

Signed-off-by: C. Masloch <pushbx@ulukai.org>
---
 Documentation/lzo.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
index ca9833289..f839d104d 100644
--- a/Documentation/lzo.txt
+++ b/Documentation/lzo.txt
@@ -108,12 +108,12 @@ Byte sequences
                 (version 1 only).
                 Otherwise, the bitstream version is 0.
 
-      18..21  : copy 0..3 literals
-                state = (byte - 17) = 0..3  [ copy <state> literals ]
+      18..21  : copy 1..4 literals
+                state = (byte - 17) = 1..4  [ copy <state> literals ]
                 skip byte
 
       22..255 : copy literal string
-                length = (byte - 17) = 4..238
+                length = (byte - 17) = 5..238
                 state = 4 [ don't copy extra literals ]
                 skip byte
 
-- 
2.26.2

