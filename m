Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B022C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5F420672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593498428;
	bh=xcriatRX5oAW76hSmZ8ro5YavRMjfjxoExGQJ1O33Ek=;
	h=From:Cc:Subject:Date:In-Reply-To:References:To:List-ID:From;
	b=gYJpxKl8ZuZPOoY5Lhas1/swdcAhfbI7GloiUK0CQ/WrgLLip8Vt0kEc/slwcw8Cs
	 5f68k3c92E8YcZJgvFUfBlChrzuXOk/92EGNDEf4frVHEyZgvsBwtTyBoWQnFry0v2
	 EAOhZ6jSLavKwM/uaNnWysFKxHGxj0xsVUlt85do=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgF3G1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:27:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:55722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730048AbgF3G0q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:26:46 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BADBC207FB;
        Tue, 30 Jun 2020 06:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593498405;
        bh=xcriatRX5oAW76hSmZ8ro5YavRMjfjxoExGQJ1O33Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OuZBULVpD4h2IFt14O/+GNMZfJxt0nP53Ofn+fMRawivCx22TtGrRwu5Z5r0ymo/Q
         UZ24hd1LiWvvN5FWxCurhXI3+mL5N0QvQO50f/d2T/H7zJpfVQ5DBelQHsOrfzGLvg
         x2ZVb+nUurAENaVgPxiPUH+yCp/wISaIa01M1690=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jq9j9-008WbB-Tc; Tue, 30 Jun 2020 08:26:43 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 6/7] kconfig: qconf: don't show goback button on splitMode
Date:   Tue, 30 Jun 2020 08:26:40 +0200
Message-Id: <d0a5ad7ddf090ff50aa486d874a8e5ab3840ea11.1593498345.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1593498345.git.mchehab+huawei@kernel.org>
References: <cover.1593498345.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the goback button does nothing on splitMode. So, why display
it?

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index e43fe4dcd4e7..6a327b69ff5f 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -437,9 +437,10 @@ void ConfigList::updateList(ConfigItem* item)
 	if (rootEntry != &rootmenu && (mode == singleMode ||
 	    (mode == symbolMode && rootEntry->parent != &rootmenu))) {
 		item = (ConfigItem *)topLevelItem(0);
-		if (!item)
+		if (!item && mode != symbolMode) {
 			item = new ConfigItem(this, 0, true);
-		last = item;
+			last = item;
+		}
 	}
 	if ((mode == singleMode || (mode == symbolMode && !(rootEntry->flags & MENU_ROOT))) &&
 	    rootEntry->sym && rootEntry->prompt) {
-- 
2.26.2

