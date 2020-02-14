Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDADC3B1A2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6C5246AA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696820;
	bh=7QwKu48rTW7DyloprWO1AAPsyDknOf+fsoZ+N/79z+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mLTXAsYRx/frPxRWRP8avwtJqPOJgtDRPkqQE6G7wuh+nDViEKsl1ywy8CnWaNMQm
	 HXupm2RtZ3UGO2zQQ2eGzUpnGwm4cvHq5Zb97sxDYuawkWPMZbhPhkaNztJ9TPj0Vb
	 IbbH2oxZykFGhbHu9Ngjjazb7nkTmYcFUvn3OIGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392205AbgBNQNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:13:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:40766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403805AbgBNQMz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:55 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C7002469B;
        Fri, 14 Feb 2020 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696774;
        bh=7QwKu48rTW7DyloprWO1AAPsyDknOf+fsoZ+N/79z+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9zxyvD6cKdFvJbMy/fpwDt4hFDokAecVr9oKlq7/xoArQ1Rd3jQMU0/OcXioNhkt
         mnMUTnLGQeT9sFpD5M9cer8+7K7/fH5htm5V/DNiMePi5AQUd08qNPIzJnFJvDL724
         LuYSlAjuD7oQXKnlRDeUZ79B6sJY1U2VTqBfUuSk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 052/252] kconfig: fix broken dependency in randconfig-generated .config
Date:   Fri, 14 Feb 2020 11:08:27 -0500
Message-Id: <20200214161147.15842-52-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index 0dde19cf74865..2caf5fac102a2 100644
--- a/scripts/kconfig/confdata.c
+++ b/scripts/kconfig/confdata.c
@@ -1314,7 +1314,7 @@ bool conf_set_all_new_symbols(enum conf_def_mode mode)
 
 		sym_calc_value(csym);
 		if (mode == def_random)
-			has_changed = randomize_choice_values(csym);
+			has_changed |= randomize_choice_values(csym);
 		else {
 			set_all_choice_values(csym);
 			has_changed = true;
-- 
2.20.1

