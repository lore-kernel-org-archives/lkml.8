Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0560EC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6A3C2469F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 00:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JT0Br7NK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbgB1AWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 19:22:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43071 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730028AbgB1AWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:22:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id p11so481495plq.10
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 16:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ez79u0H95d7ehsU8Q6LXSGZw/ZiYxtURwwXuqb7McBM=;
        b=JT0Br7NKTOUA+nKOUR3kxByruQX68VKIehHVXqVVhKCbfrDUGawo16Sa3Z6WcHnQZE
         y1biceMyRdxWDQk+6EXypwYNBPqlrWDKMmnCqpMw9cnF2nSNIF6WOmlDvRjSHvtm0AYe
         cUNtMHvTvp1pA6un7KPrhVESojEL+IC+Da808=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ez79u0H95d7ehsU8Q6LXSGZw/ZiYxtURwwXuqb7McBM=;
        b=pPKK9X245n9Fzt1z3lM9BxCr0Hn8LsTb/PBGwBGmgIY716uQMHzC3UkD0/X6YTK0ZW
         EzgJqNIA5Tz2C92U8xTVWao1Coy+BLkmI7V0HaDwujE4vXp0NKfPZtGOwcnfFuLaF0o8
         lz2m2ikJOJL01TWjywKwmMAcy9tvGj51OBebKoE2As5h3F4ee9laZqdzSrmtLIAulP5n
         xPTjIIPK57t+/PK/y0FGW4viZSQN5OaKNRvyHw25Yre2N0F/r7Pq7qjmEGVxxYFXzTGc
         LHFNMrqGpxb0GrzJBMopRM6Mf4LLDkfkJiSF3v2Q+7rgzv/TPYhHBV72b48av3VXdM/H
         uKOg==
X-Gm-Message-State: APjAAAWrQFTPXVdiei/oV3DVBu9eZbWQVNfJD4iP+bDoYBP3V36K7/Fe
        j8dT+VX01nVKRbcJqvaDIJUzPg==
X-Google-Smtp-Source: APXvYqzYAj+CjU1Xxuv+xsBd/M7yvFwmBBzsC7seqTL50y8NxU4tBl30dNubdcD9vIp3lpLiWut6dg==
X-Received: by 2002:a17:90a:be03:: with SMTP id a3mr1544230pjs.99.1582849369865;
        Thu, 27 Feb 2020 16:22:49 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 196sm8572448pfy.86.2020.02.27.16.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 16:22:48 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@suse.de>
Cc:     Kees Cook <keescook@chromium.org>, "H.J. Lu" <hjl.tools@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] scripts/link-vmlinux.sh: Delay orphan handling warnings until final link
Date:   Thu, 27 Feb 2020 16:22:36 -0800
Message-Id: <20200228002244.15240-2-keescook@chromium.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200228002244.15240-1-keescook@chromium.org>
References: <20200228002244.15240-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, powerpc adds "--orphan-handling=warn" to LD_FLAGS_vmlinux
to detect when there are unexpected sections getting added to the kernel
image. There is no need to report these warnings more than once, so it
can be removed until the final link stage.

This helps pave the way for other architectures to enable this, with the
end goal of enabling this warning by default for vmlinux for all
architectures.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 scripts/link-vmlinux.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 1919c311c149..416968fea685 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -255,6 +255,11 @@ info GEN modules.builtin
 tr '\0' '\n' < modules.builtin.modinfo | sed -n 's/^[[:alnum:]:_]*\.file=//p' |
 	tr ' ' '\n' | uniq | sed -e 's:^:kernel/:' -e 's/$/.ko/' > modules.builtin
 
+
+# Do not warn about orphan sections until the final link stage.
+saved_LDFLAGS_vmlinux="${LDFLAGS_vmlinux}"
+LDFLAGS_vmlinux="$(echo "${LDFLAGS_vmlinux}" | sed -E 's/ --orphan-handling=warn( |$)/ /g')"
+
 btf_vmlinux_bin_o=""
 if [ -n "${CONFIG_DEBUG_INFO_BTF}" ]; then
 	if gen_btf .tmp_vmlinux.btf .btf.vmlinux.bin.o ; then
@@ -306,6 +311,7 @@ if [ -n "${CONFIG_KALLSYMS}" ]; then
 	fi
 fi
 
+LDFLAGS_vmlinux="${saved_LDFLAGS_vmlinux}"
 vmlinux_link vmlinux "${kallsymso}" ${btf_vmlinux_bin_o}
 
 if [ -n "${CONFIG_BUILDTIME_TABLE_SORT}" ]; then
-- 
2.20.1

