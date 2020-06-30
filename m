Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DBCC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5357520672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 14:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388912AbgF3O1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 10:27:16 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:34743 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732700AbgF3O1O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:27:14 -0400
Received: from localhost.localdomain (ip5f5af2cb.dynamic.kabel-deutschland.de [95.90.242.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 401EE20646092;
        Tue, 30 Jun 2020 16:27:12 +0200 (CEST)
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH] .gitignore: Do not track `defconfig` from `make savedefconfig`
Date:   Tue, 30 Jun 2020 16:26:53 +0200
Message-Id: <20200630142653.10375-1-pmenzel@molgen.mpg.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 87b9dd8a163b..5c1a5349852b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -142,6 +142,7 @@ x509.genkey
 /allno.config
 /allrandom.config
 /allyes.config
+/defconfig
 
 # Kdevelop4
 *.kdev4
-- 
2.27.0

