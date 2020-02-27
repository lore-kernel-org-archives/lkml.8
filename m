Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD3B7C3567B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2B6246A0
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582814705;
	bh=6EtQis6mQeE6kHIL6mvjafifQGOLz1qYtzxe86M3JsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i1W59B6YcrWMBUZ1n9CjICscy325YUsZE+bHdQ3/7sZTBrWjItIEXvLYfnkWOr3F7
	 dhngnnwwF09Q8oqjBFk8iICHzBacP+U2TJeLqu3YxnOInOKW2I/rnQvzVkVvig+s7Z
	 Et2C9wiL2gDgC+/3BHM2X3vMvSAxGyUZLjpM1xR4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730644AbgB0NrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:47:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:43458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730633AbgB0NrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:47:05 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BEFA324688;
        Thu, 27 Feb 2020 13:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582811225;
        bh=6EtQis6mQeE6kHIL6mvjafifQGOLz1qYtzxe86M3JsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fZEANF7nHZIf4UpxF4eS9mFHDsCsXNxDc3r85GHvJNSu1VaKGm6d9FUhb5iltBbE2
         tWbVOBiViOhLvue4sXvsjtCd+iINnhcLy+rV6mZjkxY5e35aQZu6Ju6AXdyoO4hKyo
         5aPIOTnq2f2HS7qfXlOUXYBzBveAwraQqLpHtzRI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 043/165] kconfig: fix broken dependency in randconfig-generated .config
Date:   Thu, 27 Feb 2020 14:35:17 +0100
Message-Id: <20200227132237.501165368@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132230.840899170@linuxfoundation.org>
References: <20200227132230.840899170@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <masahiroy@kernel.org>

[ Upstream commit c8fb7d7e48d11520ad24808cfce7afb7b9c9f798 ]

Running randconfig on arm64 using KCONFIG_SEED=0x40C5E904 (e.g. on v5.5)
produces the .config with CONFIG_EFI=y and CONFIG_CPU_BIG_ENDIAN=y,
which does not meet the !CONFIG_CPU_BIG_ENDIAN dependency.

This is because the user choice for CONFIG_CPU_LITTLE_ENDIAN vs
CONFIG_CPU_BIG_ENDIAN is set by randomize_choice_values() after the
value of CONFIG_EFI is calculated.

When this happens, the has_changed flag should be set.

Currently, it takes the result from the last iteration. It should
accumulate all the results of the loop.

Fixes: 3b9a19e08960 ("kconfig: loop as long as we changed some symbols in randconfig")
Reported-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/kconfig/confdata.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
index 27aac273205ba..fa423fcd1a928 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -1238,7 +1238,7 @@ bool conf_set_all_new_symbols(enum conf_def_mode mode)
 
 		sym_calc_value(csym);
 		if (mode == def_random)
-			has_changed = randomize_choice_values(csym);
+			has_changed |= randomize_choice_values(csym);
 		else {
 			set_all_choice_values(csym);
 			has_changed = true;
-- 
2.20.1



