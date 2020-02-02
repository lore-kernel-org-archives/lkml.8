Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F039C35240
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 05:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63B3205F4
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 05:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580620210;
	bh=zJUlgm6fmNJjWr3K8JXOgKCLNhmff7rt+0qwd5hayLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=IcyttKUizZXwesNI8aUGTK3uts/VuykSjMEM8+DsR2CRKGLPQTdjp+u4umBzpTfAO
	 B9mb9eE4+mbeTtf+4ucfb/OYS3LjtyNQJUenaN7q83Uxy/XvHD00QXyR6dwamdIlnG
	 LD/asHK5h4tYf7FVYfR4WWhsG4Co7132wt42QakM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgBBFKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 00:10:09 -0500
Received: from conuserg-11.nifty.com ([210.131.2.78]:58679 "EHLO
        conuserg-11.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgBBFKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 00:10:08 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 01259SCb026546;
        Sun, 2 Feb 2020 14:09:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 01259SCb026546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1580620170;
        bh=2v/7U9X2Qp7z2QLvT/nW2vuRmHa6cW+zJRprBKgnT/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WMhW0/CsotXG4ZcVQGOMx8A5baPUx6bkpXJ3dKGgnDmY3vO2+SsPevLkAQoFQx/Zh
         /vjbnpWVYI5ugvU3uo/GfH5EanX0PUErp0G4QKnC38jYRklLZ9/AKr64jOhBvgfGGf
         A6PuPtu4wf1FEY2qITNhnbe5c+xIMFwsTTHoxoKeomXsXZ0qRaSIO5PXNnDb47SKKi
         507rPjZ1SGQty1hweR4ZshgU4rv0zrb1dNy+Uu7LYUIR4AC80audAhsgOu+uE1O9Jm
         bNyY59vMSSnMABQ38pMs53B2UtAmagFB7tlN2CtLXWv4NYBjgn9CBuUJK5A4GujoDm
         6BNxlwQAusQwQ==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] kallsyms: fix type of kallsyms_token_table[]
Date:   Sun,  2 Feb 2020 14:09:22 +0900
Message-Id: <20200202050922.12402-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202050922.12402-1-masahiroy@kernel.org>
References: <20200202050922.12402-1-masahiroy@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kallsyms_token_table[] only contains ASCII characters. It should be
char instead of u8.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/kallsyms.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 136ce049c4ad..53f84f685841 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -44,7 +44,7 @@ __attribute__((weak, section(".rodata")));
 extern const unsigned long kallsyms_relative_base
 __attribute__((weak, section(".rodata")));
 
-extern const u8 kallsyms_token_table[] __weak;
+extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
@@ -58,7 +58,8 @@ static unsigned int kallsyms_expand_symbol(unsigned int off,
 					   char *result, size_t maxlen)
 {
 	int len, skipped_first = 0;
-	const u8 *tptr, *data;
+	const char *tptr;
+	const u8 *data;
 
 	/* Get the compressed symbol length from the first symbol byte. */
 	data = &kallsyms_names[off];
-- 
2.17.1

