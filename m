Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BB2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD2F20775
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 06:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593499745;
	bh=VG7zYc0y4AM4p4doVmFNEQyDSCOCDupyKMyfvabfOyI=;
	h=From:Cc:Subject:Date:To:List-ID:From;
	b=QY22/WUc5ZHDRWb1aEFkXq5MAEtTXDKL2xo8qUBUmc6+IaRv4pJqBP2kdij7ijqNF
	 1cInUE0J9DpRpNQTyt1FgJ6JvmKusfICa5eT80R8ebDYLZz9tT3tB3U6oESeZPOGOG
	 zRZqrbDetlHhh8FDeVaDz8omi8XzDxlBBH8R4614=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgF3GtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 02:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:34520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730386AbgF3GtD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 02:49:03 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 23E2820775;
        Tue, 30 Jun 2020 06:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593499743;
        bh=VG7zYc0y4AM4p4doVmFNEQyDSCOCDupyKMyfvabfOyI=;
        h=From:To:Cc:Subject:Date:From;
        b=ltgsi2ifJ4ccWWM08nl3ptUuGQlScZA7xzwjPDEWh8a6I3t/o4XSKgCHj5pkq9Cxu
         RmKcJrQnrBbz++Olj5mX6qyM+/NiNwZLr5ZYw4VfoKuC3KjEbpxDq1Y0qzxhVLyE8+
         recTwsCF+XAqQgC8O3wvU+fyOSDjITDaED2EeCEg=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jqA4e-008Yuv-5L; Tue, 30 Jun 2020 08:48:56 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kconfig: qconf: parse newer types at debug info
Date:   Tue, 30 Jun 2020 08:48:53 +0200
Message-Id: <3f61abe3ae457bb5b61fb217394bbb9590ca17ef.1593499731.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are 3 types that are not parsed by the debug info logic.
Add support for them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/kconfig/qconf.cc | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/kconfig/qconf.cc b/scripts/kconfig/qconf.cc
index fd721c6c4c94..4a616128a154 100644
--- a/scripts/kconfig/qconf.cc
+++ b/scripts/kconfig/qconf.cc
@@ -1154,6 +1154,9 @@ QString ConfigInfoView::debug_info(struct symbol *sym)
 		case P_DEFAULT:
 		case P_SELECT:
 		case P_RANGE:
+		case P_COMMENT:
+		case P_IMPLY:
+		case P_SYMBOL:
 			debug += prop_get_type_name(prop->type);
 			debug += ": ";
 			expr_print(prop->expr, expr_print_help, &debug, E_NONE);
-- 
2.26.2

