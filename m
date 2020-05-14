Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7165DC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E99206DC
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589482520;
	bh=1d8ZgMWN6ZEhgoBrcrWBKRUBc0Ej2Pt8eXGGB4ddCbg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=Z6LMQh29TyoNteN1oZ3/Q+AARyMWkpnMEqwGawPkjqlFo7SadKE6nMAjSFpWl0lfL
	 nROjxB64WGKwxRp1MiXsSmKmYm/rBLtbTEE09F21D9dQZNAOjwmk6c7EheBkvHupVS
	 ej3w4TDuBUGSybgV8pIDzpeXX9QbTBt77r4vDKk0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgENSzT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:55:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729159AbgENSy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:54:58 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 638BE206F1;
        Thu, 14 May 2020 18:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589482498;
        bh=1d8ZgMWN6ZEhgoBrcrWBKRUBc0Ej2Pt8eXGGB4ddCbg=;
        h=From:To:Cc:Subject:Date:From;
        b=glZuu0oZo5xsuu6ZceIKbGA87WIz7Itx60PE5MMApzy3KgsB2PyrpV5ycihBkBzUk
         SvOkmnTAhfYBfx+wezRvNBMo3y7Aw5borXO4w9dYSADplyTCZjwt0iorDEKSDFxc1g
         hgbU6yciifXv1Aa+KWUvTqXl4OTtKEFchiu1nKao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Jiri Kosina <jkosina@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 01/39] Makefile: disallow data races on gcc-10 as well
Date:   Thu, 14 May 2020 14:54:18 -0400
Message-Id: <20200514185456.21060-1-sashal@kernel.org>
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
index 525565f44b171..35640d40a7845 100644
--- a/Makefile
+++ b/Makefile
@@ -670,6 +670,7 @@ KBUILD_CFLAGS += $(call cc-ifversion, -lt, 0409, \
 
 # Tell gcc to never replace conditional load with a non-conditional one
 KBUILD_CFLAGS	+= $(call cc-option,--param=allow-store-data-races=0)
+KBUILD_CFLAGS	+= $(call cc-option,-fno-allow-store-data-races)
 
 # check for 'asm goto'
 ifeq ($(shell $(CONFIG_SHELL) $(srctree)/scripts/gcc-goto.sh $(CC) $(KBUILD_CFLAGS)), y)
-- 
2.20.1

