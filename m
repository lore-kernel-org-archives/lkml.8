Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D462CC2D0F2
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8000F21974
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585758634;
	bh=NAZtYmCrKrUZmtKsMs7hekbghArZfgx6xTus4UqzlRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ftGhQyQGUILmMgFsTlmQQnzBjjGHDRph0GWvC8Vj9/NREKgtBdcBFv4VfOZamwssS
	 6WV+wmjf1UpqQENpgNL2rXP5Y7r7pfY3BoVqhKOmsp6GL2RJhmyDd8N41Ueu4RZJGY
	 +Px05StJtq8nWSNOnRqvkHGtbeEps4rxmabuXhUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733266AbgDAQaa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:30:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733156AbgDAQa2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:30:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F8F72137B;
        Wed,  1 Apr 2020 16:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585758627;
        bh=NAZtYmCrKrUZmtKsMs7hekbghArZfgx6xTus4UqzlRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e9LiBT9nSdkfUQAbf5ObQHcYqYud9xbL2nr6DJYrCPjeh3yERqbXUJeTR/yWhfTt9
         V5J9bs02j1wOvl1xHTfXoKnvCWBMq3ukFGyvwwVXF29SKyQSXwnRKMx1SSnidlXamM
         ASCYo6v8PGCC4DT0Lwnro+PJ5WVf9g+0WUyYUWyI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 28/91] kbuild: Disable -Wpointer-to-enum-cast
Date:   Wed,  1 Apr 2020 18:17:24 +0200
Message-Id: <20200401161523.154654139@linuxfoundation.org>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200401161512.917494101@linuxfoundation.org>
References: <20200401161512.917494101@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

commit 82f2bc2fcc0160d6f82dd1ac64518ae0a4dd183f upstream.

Clang's -Wpointer-to-int-cast deviates from GCC in that it warns when
casting to enums. The kernel does this in certain places, such as device
tree matches to set the version of the device being used, which allows
the kernel to avoid using a gigantic union.

https://elixir.bootlin.com/linux/v5.5.8/source/drivers/ata/ahci_brcm.c#L428
https://elixir.bootlin.com/linux/v5.5.8/source/drivers/ata/ahci_brcm.c#L402
https://elixir.bootlin.com/linux/v5.5.8/source/include/linux/mod_devicetable.h#L264

To avoid a ton of false positive warnings, disable this particular part
of the warning, which has been split off into a separate diagnostic so
that the entire warning does not need to be turned off for clang. It
will be visible under W=1 in case people want to go about fixing these
easily and enabling the warning treewide.

Cc: stable@vger.kernel.org
Link: https://github.com/ClangBuiltLinux/linux/issues/887
Link: https://github.com/llvm/llvm-project/commit/2a41b31fcdfcb67ab7038fc2ffb606fd50b83a84
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.extrawarn | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 93e23a73b232f..11096b2fa5cb2 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -67,5 +67,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, format)
 KBUILD_CFLAGS += $(call cc-disable-warning, sign-compare)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-zero-length)
 KBUILD_CFLAGS += $(call cc-disable-warning, uninitialized)
+KBUILD_CFLAGS += $(call cc-disable-warning, pointer-to-enum-cast)
 endif
 endif
-- 
2.20.1



