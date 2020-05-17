Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA0DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:51:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEB662065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589709069;
	bh=tk/fwOURHRn164tNk1hs4Cayy/xACe3yQIyzTiOvCC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YTnWWU7/+ldn1Z/WXdKGOppndlXTQC8uNi9scuI3698KYTaInAZT/GHt5wUors2ma
	 1iIFGQ91BYql6g5ADM5DbJ30lxWR/rfFlmqfk62JsxOqsljsuTIE6EnukWz8WLKds/
	 W3xPG47Ss8AW95qeovcjBsOLZVtM8TNWpOwtWTQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgEQJvI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:51:08 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38303 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgEQJtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:35 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4L2018560;
        Sun, 17 May 2020 18:49:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4L2018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708948;
        bh=8KRAehNYEbD8P1SFsb4sUZSCAiUKonw/xvsoBMy6pYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zdzkC2hYifs4g9KJvQEX5U8dgYdzH4gpmuFFlmKr1vIF2dGnfoqy+bocgP5t1oUmV
         O92dYh1+H8lfuO2TmHLJQBu8qpMpVg6T3NjEiK5OaYyyagoKwi+LeIntk/oV5KtLI/
         R56RixOEehto6Cb2cOX1ofDH6dlzF3U8nzXZEgl4emHxdDS0wN7YISkbklyH05lG66
         UHfwvzxgbu5ebRZtyIsK1KoHuyRrD4P+SER39sEEj0dloVkAtoHn+fFsm6cude5ZBC
         +Rc+oBVX2U+wAwj12zgMGKwU6nvLIy8elpjOZVKTl/2M7CRiP+bB4LmtZ2a6k9Wt9u
         LPbs0dfUZ23Ig==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/29] modpost: re-add warning about missing *.mod file
Date:   Sun, 17 May 2020 18:48:35 +0900
Message-Id: <20200517094859.2376211-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts 4be40e22233c ("kbuild: do not emit src version warning for
non-modules").

I do not fully understand what that commit addressed, but commit
91341d4b2c19 ("kbuild: introduce new option to enhance section mismatch
analysis") introduced partial section checks by using modpost. built-in.o
was parsed by modpost. Even modules had a problem because *.mod files
were created after the modpost check.

Commit b7dca6dd1e59 ("kbuild: create *.mod with full directory path and
remove MODVERDIR") stopped doing that. Now that modpost is only invoked
after the directory descend, *.mod files should always exist at the
modpost stage. If not, something went wrong, which should be warned.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/sumversion.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/sumversion.c b/scripts/mod/sumversion.c
index f9aa532d93cf..f9df0b1863f1 100644
--- a/scripts/mod/sumversion.c
+++ b/scripts/mod/sumversion.c
@@ -402,9 +402,11 @@ void get_src_version(const char *modname, char sum[], unsigned sumlen)
 		 (int)strlen(modname) - 1, modname);
 
 	buf = read_text_file(filelist);
-	if (!buf)
-		/* not a module or .mod file missing - ignore */
+	if (!buf) {
+		warn("failed to open %s. cannot calculate checksum\n",
+		     filelist);
 		return;
+	}
 
 	pos = buf;
 	firstline = get_line(&pos);
-- 
2.25.1

