Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81C0C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A2022073D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 07:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578900625;
	bh=WEQrdcKx1CNrqHWRXChe+UeFvChdCVfWbC9/ei2D6T8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=TdmPfrw89+01y8zODVku4bruCxzq8I8cMUh1enS0FbVDxXaAXynHZ/zGUf3ID/0E3
	 T762ICBuiJllmg866BuaNUmmzu6YFn4owZ9kWIrYe5ysln0ui3mtluB/pdVPKty9jM
	 cmgXQeFdckeCimfGYsDxdn/Esgw+VhPpKomr+KWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbgAMHaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 02:30:24 -0500
Received: from conuserg-08.nifty.com ([210.131.2.75]:36298 "EHLO
        conuserg-08.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbgAMHaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 02:30:24 -0500
Received: from grover.flets-west.jp (softbank126093102113.bbtec.net [126.93.102.113]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 00D7UIrF011922;
        Mon, 13 Jan 2020 16:30:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 00D7UIrF011922
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1578900619;
        bh=tFE14xlK6YNOdWG4RU9WTdn48228b5KwDklZaVE2ovU=;
        h=From:To:Cc:Subject:Date:From;
        b=EmrggIiUGUczEKqpi+vWFJDCOTUO88zPAr+xzZtIEO+kee9YIs0fChHXxbngU4oYO
         w8FoQafRjFp5xXcGK6O9OVEQ7S9SdU9sV+n4WWP+OTGyZSH5Na0ZVaRZzJadFV3cyi
         ByOC+BqUZ3bPj1CRHAmO4vLUUkaLdO8esAfFZiyYvYgkESnElDQ0qRty3pOfxldnhn
         uIo7WKMLyb37X4KCox80SsCvhFao52CQ6oVrO+8vfb9QMnbgSQsnQ6w8pIjg9KdQLc
         AEiCjg2CfghaTa/ZvFNDQfB50QyUw+gL5r/7X3hlO0DeheQ+F7CdwPz2k646rZW/1f
         8kEC7g4B4YGRA==
X-Nifty-SrcIP: [126.93.102.113]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: remove 'Building modules, stage 2.' log
Date:   Mon, 13 Jan 2020 16:30:17 +0900
Message-Id: <20200113073017.6910-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This log is displayed every time modules are built, but it is not
so important.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.modpost | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.modpost b/scripts/Makefile.modpost
index 69897d5d3a70..b4d3f2d122ac 100644
--- a/scripts/Makefile.modpost
+++ b/scripts/Makefile.modpost
@@ -90,7 +90,6 @@ quiet_cmd_modpost = MODPOST $(words $(modules)) modules
       cmd_modpost = sed 's/ko$$/o/' $(MODORDER) | $(MODPOST)
 
 __modpost:
-	@$(kecho) '  Building modules, stage 2.'
 	$(call cmd,modpost)
 ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
-- 
2.17.1

