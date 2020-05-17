Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C46C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692292065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589709076;
	bh=dKKNg/UoEYW8zaQvQRvSEhEsxJ/9p3LYATZuAIlc4x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SBVsepDieoCrBJZHjkwFSGMoPvnD9LAHRYuXpoaFqRafFkkzBvMopk+XesNHL/iqe
	 5mDjAVts88yIUiksWxm1jGGahHXGfaS63fP1yM5dUF1KtjWu3OF7IhgpjQKKNqvJTt
	 9xZudfGX1TIzlg6KNkYiSv4v4RftIyzf9h5Hi8RQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgEQJvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:51:15 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38294 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgEQJte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:34 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4LE018560;
        Sun, 17 May 2020 18:49:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4LE018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708955;
        bh=UB3CiF5sRofWAi/2dun1IIiUM+7xzM+drcQU+ii5U6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwJJtTm47bwT1+BuLbNe4ad1h1EV2WxDu8rH0Iq1kYU9femCouaqse7N9nh7B0fS3
         vsGGq9t81A6+0xeChNQWGEtO3txLi2I3HS1zcFfBOH2C2mPeb+qMPc6iQ+4r214Bgw
         ZfwusdeuB8qF98LHDp7Tny9SlpNkarAN0Ps+VDBIP695KmjfwvCDL7tPJPuRN8vQav
         K3BWqT9quAPN4MVr0Rcyf8ILQRCWa/XAwsBI/4v8t1/2DDH5kgcw4cCfxDX/2XkJt9
         qSqEUx+ZILrHY8bQhG3IePOQZbGs0SlhDf+nqu33WpD8yIYqAj52m17z+U9zib0sBi
         ncZRCkNqAWVrQ==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 17/29] modpost: re-add -e to set external_module flag
Date:   Sun, 17 May 2020 18:48:47 +0900
Message-Id: <20200517094859.2376211-18-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, the -i option had two functions; load a symbol dump file,
and set the external_module flag.

I want to assign a dedicate option for each of them.

Going forward, the -i is used to load a symbol dump file, and the -e
to set the external_module flag.

With this, we will be able to use -i for loading in-kernel symbols.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 1 +
 scripts/mod/modpost.c    | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index a316095c843c..d14143b30b7a 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -81,6 +81,7 @@ include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
 
 # modpost options for external modules
 MODPOST += \
+	-e \
 	-i Module.symvers \
 	$(addprefix -i ,$(KBUILD_EXTRA_SYMBOLS)) \
 	-o $(KBUILD_EXTMOD)/Module.symvers
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index a5bac158d344..b14ecfbfd640 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2556,10 +2556,12 @@ int main(int argc, char **argv)
 	struct dump_list *dump_read_start = NULL;
 	struct dump_list **dump_read_iter = &dump_read_start;
 
-	while ((opt = getopt(argc, argv, "i:mnsT:o:awENd:")) != -1) {
+	while ((opt = getopt(argc, argv, "ei:mnsT:o:awENd:")) != -1) {
 		switch (opt) {
-		case 'i':
+		case 'e':
 			external_module = 1;
+			break;
+		case 'i':
 			*dump_read_iter =
 				NOFAIL(calloc(1, sizeof(**dump_read_iter)));
 			(*dump_read_iter)->file = optarg;
-- 
2.25.1

