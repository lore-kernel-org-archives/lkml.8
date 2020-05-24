Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33DCC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 925AE207CB
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590335049;
	bh=DPJ+RPTL6CowKiuRa4PDNG+cr4MOpKMP15thv2yqG3A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iWWiA+oIzDK1z6t73TKdnsbBtG0mF4vO5Sm4AvFJUC4cE/NJe8IAYDgPdewgnUX/o
	 IdW455v+YHeXhTu/xumH4RaQ3OyHjR/5RfUDFhB3eCd6o+kaJK3zqNNyf+uDqg0It+
	 /t+aX+OZFQ3ZSH4B7NcUVfQHdAO90A/sVlpSFI88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387839AbgEXPoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 11:44:09 -0400
Received: from conuserg-09.nifty.com ([210.131.2.76]:19705 "EHLO
        conuserg-09.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728456AbgEXPnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 11:43:23 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 04OFgcUp017561;
        Mon, 25 May 2020 00:42:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 04OFgcUp017561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590334962;
        bh=+CowkGnQ/Rdim6TIEWDJgN0QV5Xtqiz0AC0ieOpsCus=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mUKEMAW/Rs6ztHCeOIedoqh9aqgeZN2YWL8mYHc6P+nge2rQ5CQIm93KwNhOV6mZv
         T6cOhhFt4hVB1TYxY7MWVLULEiIatNe9zfRaWYjAsFM8UPG3QnJCAMBZ7A0AImIzEh
         uv+2duTxGAu80WV8ev4V092GysX4uQ/F57Gaxhn243zXL630jlUvV2pfDGNDCDl/ws
         mGncoJLDHm9bNWOaDli9/MEhQG6aowP8okfIN9CPNGLKKHO0SKmqvRhJWSXzX1ujOl
         wwcWa+Tudhv1tLTFra09pWkhx+PDzejfVM3FoslrC0mYFotJ6GY3q+8X2HN89UOdxf
         K8gzZmd2Y/Zjw==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/29] modpost: avoid false-positive file open error
Date:   Mon, 25 May 2020 00:42:12 +0900
Message-Id: <20200524154235.380482-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200524154235.380482-1-masahiroy@kernel.org>
References: <20200524154235.380482-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One problem of grab_file() is that it cannot distinguish the following
two cases:

 - I cannot read the file (the file does not exist, or read permission
   is not set)

 - It can read the file, but the file size is zero

This is because grab_file() calls mmap(), which requires the mapped
length is greater than 0. Hence, grab_file() fails for both cases.

If an empty header file were included from a module that requires checksum
calculation, the following warning would be printed:

  WARNING: modpost: could not open ...: Invalid argument

An empty file is a valid source file, so it should not fail.

Use read_text_file() instead. It can read a zero-length file.
Then, parse_file() will succeed with doing nothing.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2: None

 scripts/mod/sumversion.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index f9df0b1863f1..a1c7b0f4cd5a 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -258,10 +258,12 @@ static int parse_file(const char *fname, struct md4_ctx *md)
 	char *file;
 	unsigned long i, len;
 
-	file = grab_file(fname, &len);
+	file = read_text_file(fname);
 	if (!file)
 		return 0;
 
+	len = strlen(file);
+
 	for (i = 0; i < len; i++) {
 		/* Collapse and ignore \ and CR. */
 		if (file[i] == '\\' && (i+1 < len) && file[i+1] == '\n') {
@@ -287,7 +289,7 @@ static int parse_file(const char *fname, struct md4_ctx *md)
 
 		add_char(file[i], md);
 	}
-	release_file(file, len);
+	free(file);
 	return 1;
 }
 /* Check whether the file is a static library or not */
-- 
2.25.1

