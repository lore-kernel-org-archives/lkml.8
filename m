Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D1DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8505520857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UWquwQhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406605AbgFXUdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406580AbgFXUdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:33:33 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC940C061796
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:31 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id v20so2488804qvt.15
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tPGFlpm4UBb0TochKjxo1pWDKJKPOqpdcyA67hsa/L0=;
        b=UWquwQhXAU0FVu4xLvS68q0H5KMxmC2ClvghZJMO4mnRx07EpAl76zEcZBzo4oeEr0
         7QXs8i2/+8O4w4SxtWsY3wN7GwxBdmr8ei0LaPar71G/kQf7fHaujWILvZ2kj0I3OQnr
         XU2/mlOZsNQvQSHPQNf0o+Qm3V8oiEUyLdtK1wUmyBN7hxR5xoSfaX9vD6ylX1d8MUtg
         8oc06ZHQnmcIQFLeYAyeQNfJHs0QNV6Vk/mbPBcPZcsZ2TSgTBf3waXZc3e781NAKP/5
         u74kiQ+ly65wZm433U8lBfaxNpuvW2v+K3io3UW/wCh82HySe+7ylz3czOz1zaRbngJk
         H88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tPGFlpm4UBb0TochKjxo1pWDKJKPOqpdcyA67hsa/L0=;
        b=WxKYNDpFB36JKgHlOw35ijGnmO19SPj+OOUbrHNoW+iPub0mvEhNLXe0lPZSYc9Pja
         +SzDzVNMAWgl5w4KIm4V25IF9WUuCQXzbGyUvIL7u9345VpYqnFC1LcwFQYdTVSw+dIi
         F2oWQriWJBGJ2QHie4eUMBKYqGQQZV0CO781eztzdJc/vv5lCbS9UVEOUCavUoLzWvI5
         /ckBDMFdqyW/ADWLq12d1wHmmhHN7lreN9b9OHlKErj0cJiVlced/fYIw1BlDyICfzCp
         MqJnGMowFNn7herh4/GAnxAHMTjkZE0kMvQt3WZ48TaJcz6cDXyXnQXiibaA2O3DEB+x
         7cNQ==
X-Gm-Message-State: AOAM533HA0ZywugOnqc7E4/9RgPEzuaub+sWvUtwi02xOmP8RPUtx5uc
        5E5NXycIODkjSLk/+tRypAU56bv8XyfK22iydK4=
X-Google-Smtp-Source: ABdhPJwOmVj5AVipomAFkeyuweymmty039I+YIpShmyF/4KLduyGozlOwEpdaQAyz+L93rzFTlrhSA4YsbqHyVAyM6Y=
X-Received: by 2002:a0c:8482:: with SMTP id m2mr33607693qva.65.1593030810891;
 Wed, 24 Jun 2020 13:33:30 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:31:56 -0700
In-Reply-To: <20200624203200.78870-1-samitolvanen@google.com>
Message-Id: <20200624203200.78870-19-samitolvanen@google.com>
Mime-Version: 1.0
References: <20200624203200.78870-1-samitolvanen@google.com>
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH 18/22] arm64: allow LTO_CLANG and THINLTO to be selected
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Will Deacon <will@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-hardening@lists.openwall.com, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow CONFIG_LTO_CLANG and CONFIG_THINLTO to be enabled.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 arch/arm64/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a4a094bedcb2..e1961653964d 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -72,6 +72,8 @@ config ARM64
 	select ARCH_USE_SYM_ANNOTATIONS
 	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if CC_HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_LTO_CLANG
+	select ARCH_SUPPORTS_THINLTO
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && (GCC_VERSION >= 50000 || CC_IS_CLANG)
 	select ARCH_SUPPORTS_NUMA_BALANCING
-- 
2.27.0.212.ge8ba1cc988-goog

