Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D12C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95A3C2088E
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590112832;
	bh=Y3P+dM0vde7SETgnVBpoe+YAhi4T5RpYnBP5lMtPM1w=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Gw54W46D7UJoKLvlOy3Mpd/njtZjV5mVDxveFJwOjz8mO20V6VAa387BcD+F3Pk0W
	 Z9mVL/VKi2Ub4PsUw/fk32OvdUxvp8wkB8BO5EMtA74AvgYlpho7SgwtlUeH6/wCCz
	 rU/8mU8OJ0xwOKaRJL8lifljyNorHOOdEQmOUHGk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgEVCA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:00:29 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:37241 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726940AbgEVCA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:00:27 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 04M205UX009585;
        Fri, 22 May 2020 11:00:05 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 04M205UX009585
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1590112808;
        bh=p68P5aztaSnVFKazuy1uvMsF2Jqe9k7v6DqDJgghFkw=;
        h=From:To:Cc:Subject:Date:From;
        b=xvfyE3QrXaukpL6qiDqUhwERD0uByfY7b4QEhBM0hOxuB3az0SVFKds9IEi+D3sYY
         nT3Tjt0F6eP3cK95/umJQye0pwczlNer+teeF2XGVLDDTIzeGeQQ5MJV4jCeEcdriA
         QXZOC8+l65LD5ocQVJzHRqZOK/LfxEAuySXwCZ+DyX4LxjV1WlUhRuuSZs3r0fU8OW
         3lZPybxoO1ntBETAyUW2b5aHaPL7WY2zslzQrJewiC4fuU66RJRJg1rf/dvgcgaUYf
         /5n7zUb4g9dJM007ifmz7uodeVX0XiDCElMmc28qAd7M+qsA6HgYKch0dXOlgdnq0R
         9fZ9lBjtAukMA==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] kbuild: remove ifdef builtin-target / lib-target
Date:   Fri, 22 May 2020 10:59:58 +0900
Message-Id: <20200522020002.504506-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I do not see a good reason to add ifdef here.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.build | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3665b1a0bc8e..9af88f4cacb8 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -384,16 +384,14 @@ $(obj)/%/built-in.a: $(obj)/% ;
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
 #
-ifdef builtin-target
 
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
 
-$(builtin-target): $(real-obj-y) FORCE
+$(obj)/built-in.a: $(real-obj-y) FORCE
 	$(call if_changed,ar_builtin)
 
 targets += $(builtin-target)
-endif # builtin-target
 
 #
 # Rule to create modules.order file
@@ -408,15 +406,11 @@ $(modorder-target): $(subdir-ym) FORCE
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
 #
-ifdef lib-target
-
-$(lib-target): $(lib-y) FORCE
+$(obj)/lib.a: $(lib-y) FORCE
 	$(call if_changed,ar)
 
 targets += $(lib-target)
 
-endif
-
 # NOTE:
 # Do not replace $(filter %.o,^) with $(real-prereqs). When a single object
 # module is turned into a multi object module, $^ will contain header file
-- 
2.25.1

