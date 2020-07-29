Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8C3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:19:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64E812070B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595992740;
	bh=Ohpr+GqDnJEOLdgLCpq4Gz/ax0rPukQmUk2OhLp6S8E=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=PxqP49L1fGAzvZmyz8GGlqaJaQ4O7/uSuiUfUSRDO8UpKcLaWC2yOPbGMPCoEoHEl
	 FC/wmnGZgIrl8IFwXq5N02njsbvjdSfo3x6ox7wSaDRkcD56rx/uv/ORfHYJuZV2fY
	 JaOltiegL+0KhASZfumk8F1RhmYEAA5CnmkOWmII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgG2DS7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:18:59 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:54949 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgG2DS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:18:59 -0400
Received: from oscar.flets-west.jp (softbank126025067101.bbtec.net [126.25.67.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 06T3Idoj022954;
        Wed, 29 Jul 2020 12:18:40 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 06T3Idoj022954
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1595992720;
        bh=R9y5zPXSYlxpJC3uaZU9/XIf/pq603Add2HzPoAewpI=;
        h=From:To:Cc:Subject:Date:From;
        b=i14gl6ihxmctLPcBS4tyt+p7/WdzTb7gdQqoN4CjRKEYy99nijfWflLwkrfcRD2X1
         G+4j3pu55azA3t8ph7wLBywO2Dcd/pvzLC/irFfQiYNAjJoSpoXuAsA/1/znT+EggF
         SsHJlTseZxGrnRfsRyVFA4JFJuwtKhZKjr8i7cl+02FSh5Kg6ztLyiSk7if7oiFHmt
         ZcpFm8PCyIrC+Yl3W0Ez7oO4/mZ5dYqC1nI/a7oL5Sutn73HLRGTIJf6dEioLKzJ0W
         zg5qNBqEvagB3zmpiiP/6cLTHwdaHDzhOQDDnGpUDvyRhvdwtFD8tPfF9fdyOkt2Q1
         h8qG/yBCGD29Q==
X-Nifty-SrcIP: [126.25.67.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: add 'static' to some file-local data
Date:   Wed, 29 Jul 2020 12:18:37 +0900
Message-Id: <20200729031838.38238-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some warnings from sparce like follows:

  warning: symbol '...' was not declared. Should it be static?

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/lexer.l  |  2 +-
 scripts/kconfig/symbol.c | 14 ++++++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/scripts/kconfig/lexer.l b/scripts/kconfig/lexer.l
index 6354c905b006..98daac3bc829 100644
--- a/scripts/kconfig/lexer.l
+++ b/scripts/kconfig/lexer.l
@@ -36,7 +36,7 @@ struct buffer {
 	YY_BUFFER_STATE state;
 };
 
-struct buffer *current_buf;
+static struct buffer *current_buf;
 
 static int last_ts, first_ts;
 
diff --git a/scripts/kconfig/symbol.c b/scripts/kconfig/symbol.c
index 9363e37b8870..ffa3ec65cc90 100644
--- a/scripts/kconfig/symbol.c
+++ b/scripts/kconfig/symbol.c
@@ -15,15 +15,21 @@ struct symbol symbol_yes = {
 	.name = "y",
 	.curr = { "y", yes },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
-}, symbol_mod = {
+};
+
+struct symbol symbol_mod = {
 	.name = "m",
 	.curr = { "m", mod },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
-}, symbol_no = {
+};
+
+struct symbol symbol_no = {
 	.name = "n",
 	.curr = { "n", no },
 	.flags = SYMBOL_CONST|SYMBOL_VALID,
-}, symbol_empty = {
+};
+
+static struct symbol symbol_empty = {
 	.name = "",
 	.curr = { "", no },
 	.flags = SYMBOL_VALID,
@@ -31,7 +37,7 @@ struct symbol symbol_yes = {
 
 struct symbol *sym_defconfig_list;
 struct symbol *modules_sym;
-tristate modules_val;
+static tristate modules_val;
 
 enum symbol_type sym_get_type(struct symbol *sym)
 {
-- 
2.25.1

