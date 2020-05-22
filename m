Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA274C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FC7122CBE
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ulukai.org header.i=@ulukai.org header.b="jDcoSxwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbgEVO1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729868AbgEVO1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:27:02 -0400
Received: from ulukai.org (ulukai.org [IPv6:2a01:488:66:1000:b01c:1258:0:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59590C05BD43;
        Fri, 22 May 2020 07:27:02 -0700 (PDT)
Received: from arona (unknown [46.114.108.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by ulukai.org (Postfix) with ESMTPSA id 49T7gQ32QHz3SFk;
        Fri, 22 May 2020 16:10:42 +0200 (CEST)
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at ulukai.org
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=ulukai.org; s=ulukai;
        t=1590156642; bh=tw8TnTeS4qB/O5fLk0d0rRvpp5aVqL7Gv1uP8XO0ZhM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jDcoSxwnVWXIn/u04pLmYI17o93VYgm0dSecx5kLsejCp0q5h9GUbEh/y8SXAB+2h
         6BT9Dd7vRdqAie93TrTTBLg9Nfg8JSGSJBmhERn7oA9pcTnyR33nthvvPHWXDVWVzt
         F7/fqIm+gLXIhG3xYv5Z5e/ZT0uVAd1Zsg++9kUE=
From:   "C. Masloch" <pushbx@ulukai.org>
To:     linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dave Rodgman <dave.rodgman@arm.com>, Willy Tarreau <w@1wt.eu>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/2] docs: lzo: fix incorrect statement about distance zero for EOS
Date:   Fri, 22 May 2020 16:10:40 +0200
Message-Id: <20200522141040.1353769-2-pushbx@ulukai.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522141040.1353769-1-pushbx@ulukai.org>
References: <20200522141040.1353769-1-pushbx@ulukai.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The encoded distance bits are zero, but the distance that is
calculated from this is actually equal to 16384. So correct
this statement to read that the 0001HLLL instruction means
EOS when a distance of 16384 is seen. This matches with the
description of the instruction itself later on.

Signed-off-by: C. Masloch <pushbx@ulukai.org>
---
 Documentation/lzo.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/lzo.txt b/Documentation/lzo.txt
index f839d104d..dc9e876cb 100644
--- a/Documentation/lzo.txt
+++ b/Documentation/lzo.txt
@@ -65,9 +65,9 @@ Description
   generally encoded in the last two bits of the instruction but may also be
   taken from the last two bits of an extra operand (eg: distance).
 
-  End of stream is declared when a block copy of distance 0 is seen. Only one
-  instruction may encode this distance (0001HLLL), it takes one LE16 operand
-  for the distance, thus requiring 3 bytes.
+  End of stream is declared when a block copy of distance 16384 is seen,
+  encoded in a certain instruction (0001HLLL) with the H and D bits all zero.
+  It takes one LE16 operand for the distance, thus requiring 3 bytes.
 
   .. important::
 
-- 
2.26.2

