Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10418C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13A5206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591663142;
	bh=tTxSMJjSKwUpSWdVe0PFf9Jn4K5iUxQRrxzPPBLucjM=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=hbPeeZrgKM88Y9aSB6dNmsQH5XkX+naq1xwU/DNzLxjNsidtdl3apVaYpGofL7Opr
	 +2tOIkHEKyJnNzgVvK1I6RBsGdVbMg57n7Q0SJxkXndt8oQQvD3SfcZJklkjM8bjl1
	 Ec5J6AL1K8TDJeM6W5p9B2An/9kaB7+IKPTF50IA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbgFIAjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:39:00 -0400
Received: from conuserg-12.nifty.com ([210.131.2.79]:43625 "EHLO
        conuserg-12.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731026AbgFIAip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 20:38:45 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 0590bt3n014953;
        Tue, 9 Jun 2020 09:37:55 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 0590bt3n014953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1591663076;
        bh=es92rbvBvwsGCQZx+NtzHSCTWeSTG28c6gpO7Y/gfDo=;
        h=From:To:Cc:Subject:Date:From;
        b=wuqnzO70qMLXDauU1Xpg6OXmPp2rtl0BfVr1rKTSmG+VSveRsXm5+QQc3R5iyIxeH
         gnnNDlFrATKNVd7wbX3dLxR9XgOUb2PIZVj2eVQBpo8C/9HIWx9+C95NFssfeyRRCc
         GxLky0c3f2m+7TrrD6vpWYkff2ZlqePr/nult3EzmrTIzJBVPPs+/u/HGI/xIQt3La
         LYBvQz86a+qTtVfvKxEFV933RlsDBebPRCHzIxlr0GgaYaEfddx5kIDOj4bx/9G8u0
         FEEoc1cQ1gjYRVhsTlXfZ/MmBM6m3URO/QV2IyGyYhCefaejYb2NOslhr5wJQL9ZCY
         3LHENzgJKJ/zQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: make module name conflict a warning again
Date:   Tue,  9 Jun 2020 09:37:52 +0900
Message-Id: <20200609003752.428817-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The module name conflict is still remaining.

  error: the following would cause module name conflict:
    drivers/char/adi.ko
    drivers/input/joystick/adi.ko

Make it a warning again to build sparc64 allmodconfig successfully.

Fixes: 8451791d1ff0 ("kbuild: make module name conflict fatal error")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/modules-check.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/modules-check.sh b/scripts/modules-check.sh
index 43de226071ae..8b1785863c64 100755
--- a/scripts/modules-check.sh
+++ b/scripts/modules-check.sh
@@ -15,9 +15,10 @@ check_same_name_modules()
 {
 	for m in $(sed 's:.*/::' $1 | sort | uniq -d)
 	do
-		echo "error: the following would cause module name conflict:" >&2
+		echo "warning: the following would cause module name conflict:" >&2
 		sed -n "/\/$m/s:^:  :p" modules.order >&2
-		exit_code=1
+		# TODO: turn this into an error after fixing all warnings
+		#exit_code=1
 	done
 }
 
-- 
2.25.1

