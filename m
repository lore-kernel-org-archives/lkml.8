Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF4DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0D9D2065F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589709049;
	bh=l6CBkLFF6/kMKoFrTlrzrNMFt5yhaNjkUGM5isr/TU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bxXMdiigoCak+Svv54+65cj7cMOM5j+x7hFlnnAJBTUTeDg9BABPsnalwVRHU0qD2
	 b/pQvxpK3fMiJ/WMY/xVvmMXfn2OVvLePqnDy/jKnu4aRkwOAizM1pyJT9v9Plsrew
	 2yzeUA49PpSCLcxvWKt4dvpv5PZA/VBfpvFaa+o4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728212AbgEQJus (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 05:50:48 -0400
Received: from conuserg-08.nifty.com ([210.131.2.75]:38317 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgEQJtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 05:49:36 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 04H9n4Kx018560;
        Sun, 17 May 2020 18:49:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 04H9n4Kx018560
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1589708946;
        bh=XgxxbTZCB+kMszGei0tHNQqHRoGHaow3OTqbzc12Rcs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTCUDpUrXnxHd4p0HCZUZFvsP5EybE7hP1+t1botpzwdDiJcVHNKMN8JuxhDO/sdR
         AW22JZ5CVIrPuIJs5AV0bQpS51ovAmqhtOJnTLvZ1l/1HxYkCZM/LHq2NQVhdMLJfS
         yRu9nc87J90nKe4totW238w/cAwBxX7shgkeW0MakTmDh86Cpk2749ViN8SImMOgMS
         yhDZZjzd+nlLh8CVlU9qB8ZCqZHeb4A1lTCYNIwSbumOEaJYtrplN8zNolOArSvnlP
         O2VmJhYfPtM5GPhrvMV22WbSdNFZDWx8UWpZoA5FEDcMCgrPr0hjZt4nX181TlZCw9
         Pv/IAIL637y3A==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 02/29] modpost: do not call get_modinfo() for vmlinux
Date:   Sun, 17 May 2020 18:48:32 +0900
Message-Id: <20200517094859.2376211-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200517094859.2376211-1-masahiroy@kernel.org>
References: <20200517094859.2376211-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The three calls of get_modinfo() ("license", "import_ns", "version")
always return NULL for vmlinux because the built-in module info is
prefixed with __MODULE_INFO_PREFIX.

It is harmless to call get_modinfo(), but there is no point to search
for what apparently does not exist.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 45 +++++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 77e5425759e2..af098d7efc22 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2014,25 +2014,26 @@ static void read_symbols(const char *modname)
 		mod->skip = 1;
 	}
 
-	license = get_modinfo(&info, "license");
-	if (!license && !is_vmlinux(modname))
-		warn("missing MODULE_LICENSE() in %s\n"
-		     "see include/linux/module.h for "
-		     "more information\n", modname);
-	while (license) {
-		if (license_is_gpl_compatible(license))
-			mod->gpl_compatible = 1;
-		else {
-			mod->gpl_compatible = 0;
-			break;
+	if (!is_vmlinux(modname)) {
+		license = get_modinfo(&info, "license");
+		if (!license)
+			warn("missing MODULE_LICENSE() in %s\n", modname);
+		while (license) {
+			if (license_is_gpl_compatible(license))
+				mod->gpl_compatible = 1;
+			else {
+				mod->gpl_compatible = 0;
+				break;
+			}
+			license = get_next_modinfo(&info, "license", license);
 		}
-		license = get_next_modinfo(&info, "license", license);
-	}
 
-	namespace = get_modinfo(&info, "import_ns");
-	while (namespace) {
-		add_namespace(&mod->imported_namespaces, namespace);
-		namespace = get_next_modinfo(&info, "import_ns", namespace);
+		namespace = get_modinfo(&info, "import_ns");
+		while (namespace) {
+			add_namespace(&mod->imported_namespaces, namespace);
+			namespace = get_next_modinfo(&info, "import_ns",
+						     namespace);
+		}
 	}
 
 	for (sym = info.symtab_start; sym < info.symtab_stop; sym++) {
@@ -2073,10 +2074,12 @@ static void read_symbols(const char *modname)
 	if (!is_vmlinux(modname) || vmlinux_section_warnings)
 		check_sec_ref(mod, modname, &info);
 
-	version = get_modinfo(&info, "version");
-	if (version || (all_versions && !is_vmlinux(modname)))
-		get_src_version(modname, mod->srcversion,
-				sizeof(mod->srcversion)-1);
+	if (!is_vmlinux(modname)) {
+		version = get_modinfo(&info, "version");
+		if (version || all_versions)
+			get_src_version(modname, mod->srcversion,
+					sizeof(mod->srcversion) - 1);
+	}
 
 	parse_elf_finish(&info);
 
-- 
2.25.1

