Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3DBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56C602074A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482713;
	bh=D0AZR5j8vszCNk++qXJCfjnlBJ54iy8ybh+aaPcU4tg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=XQuXcnd57W5wwsg8YFyuT2CpqlR8OsBIpXPx5kTDLquprbzfudJ9YjT9aO+gfZOEv
	 c6Bemot6moB+0vL70o7BW+HnOPTYbypa6e8rfQC9EJ2QYjEID/hV2sUNl3QsNzokWg
	 sR2eC3QX+GW0nIvTyXiBovg8xW2NIqEXJls58beY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgENS6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:58:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:57408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729703AbgENS41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:56:27 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57742207DA;
        Thu, 14 May 2020 18:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482587;
        bh=D0AZR5j8vszCNk++qXJCfjnlBJ54iy8ybh+aaPcU4tg=;
        h=From:To:Cc:Subject:Date:From;
        b=h23Cmly7S8kVPtd3gqznBgwR/eDLiHZHQlh5rNgvikHYmRiARlzhodBGGLNMH3N4P
         kW8RQaqmj4fAGcpP4ST6v0UXkkIUDwhvoRwHFFd8ni7KUaYUBRjcn/kmJG3tvOsQkz
         I239SA87BbuWSucPD4BivA8tRKxvJs8I/vIyUpGI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 01/14] Makefile: disallow data races on gcc-10 as well
Date:   Thu, 14 May 2020 14:56:12 -0400
Message-Id: <20200514185625.21753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sergei Trofimovich <slyfox@gentoo.org>

[ Upstream commit b1112139a103b4b1101d0d2d72931f2d33d8c978 ]

gcc-10 will rename --param=allow-store-data-races=0
to -fno-allow-store-data-races.

The flag change happened at https://gcc.gnu.org/PR92046.

Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 6b88acb0b9b13..162a5e22abeaf 100644
--- a/Makefile
+++ b/Makefile
@@ -651,6 +651,7 @@ endif
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 # check for 'asm goto'
 ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
-- 
2.20.1

