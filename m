Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914C0C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6209B20671
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589709054;
	bh=KhEIX8yo/Mpu1QHpQ6AVouKAtv3z6yXhaq7UlU5G1Ak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qHP9yH0niS0PIqhESzLJNDHxgrt2BOrYb1+SjYa2mOsZH8HUAjtJriLpUdCImf/m+
	 rScj5iGGIfD8/wSaLY/i0gZ+sh71lqEfvK1+AFv7Y/Bf2a4clvg6s+ZbPqHDtHz09G
	 AYeRvpVqgfi/5xHkIWdeYsupQVW8lQNtcF41PIIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEQJux (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:50:53 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38322 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727799AbgEQJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4LK018560;
        Sun, 17 May 2020 18:49:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4LK018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708959;
        bh=M97z8EcrdRWGYlP6dTlx82Y9X0OH6scYxk7pz69nOrM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJcW81vEXOOnLryakoDsuVCa0q78F8OW3PGQFKQ04956iTKgXWDNrAA6FhyOOTZyI
         H+BfsiKZfF/zImS7gQngDcosK26FYB010BV2cqRoTlTXFKe59YjvawlOHSy1jK9ELl
         tegCdnv2/9PSP3zsWOZpcxX2bRBIabkkxV+7VfCICqdnYZRDGJgJFWV55c7q/eyhZY
         0r5H57iUQxPiLsGbRTvnPX/QOOxIRZaqjLII/EDI0dCQGPaVfppxfTz7p+uEC64fC7
         Zldi8Gxwye7ELYjvUaioIlAVEr9/GVCdkPehHUSbjnLTYobyWk6QdcN2qTFv9BlzW4
         tMbIXBsP0OhDQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 23/29] modpost: remove is_vmlinux() call in check_for_{gpl_usage,unused}()
Date:   Sun, 17 May 2020 18:48:53 +0900
Message-Id: <20200517094859.2376211-24-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

check_exports() is never called for vmlinux because mod->skip is set
for vmlinux.

Hence, check_for_gpl_usage() and check_for_unused() are not called
for vmlinux, either. is_vmlinux() is always false here.

Remove the is_vmlinux() calls, and hard-code the ".ko" suffix.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7136bfc8f46a..4155669a92bd 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2134,20 +2134,18 @@ void buf_write(struct buffer *buf, const char *s, int len)
 
 static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 {
-	const char *e = is_vmlinux(m) ?"":".ko";
-
 	switch (exp) {
 	case export_gpl:
-		fatal("GPL-incompatible module %s%s "
-		      "uses GPL-only symbol '%s'\n", m, e, s);
+		fatal("GPL-incompatible module %s.ko uses GPL-only symbol '%s'\n",
+		      m, s);
 		break;
 	case export_unused_gpl:
-		fatal("GPL-incompatible module %s%s "
-		      "uses GPL-only symbol marked UNUSED '%s'\n", m, e, s);
+		fatal("GPL-incompatible module %s.ko uses GPL-only symbol marked UNUSED '%s'\n",
+		      m, s);
 		break;
 	case export_gpl_future:
-		warn("GPL-incompatible module %s%s "
-		      "uses future GPL-only symbol '%s'\n", m, e, s);
+		warn("GPL-incompatible module %s.ko uses future GPL-only symbol '%s'\n",
+		     m, s);
 		break;
 	case export_plain:
 	case export_unused:
@@ -2159,13 +2157,11 @@ static void check_for_gpl_usage(enum export exp, const char *m, const char *s)
 
 static void check_for_unused(enum export exp, const char *m, const char *s)
 {
-	const char *e = is_vmlinux(m) ?"":".ko";
-
 	switch (exp) {
 	case export_unused:
 	case export_unused_gpl:
-		warn("module %s%s "
-		      "uses symbol '%s' marked UNUSED\n", m, e, s);
+		warn("module %s.ko uses symbol '%s' marked UNUSED\n",
+		     m, s);
 		break;
 	default:
 		/* ignore */
-- 
2.25.1

