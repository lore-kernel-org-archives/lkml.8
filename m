Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B72FBC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF5F2076B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 10:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587550636;
	bh=p6iHLfGWc6lzRT6HBHDXgJQLfD0vPoGKTYfNKtnRPmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H9eDWb/lmjY//4fA9FtMRrthj1Jq3ZQWxJ4ktvRF8auPkYR/m6YnCS6y0YfUnuriR
	 qPACzsmiYyJdLpCULuopDjkGbtqIDjai4pJgNKLD47jQw5QMzN1mx60paTZVo57IC9
	 TiU26xcOMLihwFHfy5hJFXHnSMsOiNUBBd38EfkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgDVKRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:17:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729735AbgDVKQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 06:16:21 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7F6632076E;
        Wed, 22 Apr 2020 10:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587550581;
        bh=p6iHLfGWc6lzRT6HBHDXgJQLfD0vPoGKTYfNKtnRPmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i4gsz8VFbmgOiE/j5Ry21wFoRf0qQYt4WTOYugTktvjYELni/yIy3r53BZu4Nlro/
         uXNBTedNFzOyiccKfT5COHSB6/h7yIhY/ayEAaqm43+1GgAuscmFrtfdeocFWwYoZ2
         fQhEEQz2adrs3OWC668U5kYGrC9C21eMNFfBvx/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        Liu Yiding <liuyd.fnst@cn.fujitsu.com>,
        Slava Bacherikov <slava@bacher09.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kees Cook <keescook@chromium.org>,
        KP Singh <kpsingh@google.com>, Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 5.4 010/118] kbuild, btf: Fix dependencies for DEBUG_INFO_BTF
Date:   Wed, 22 Apr 2020 11:56:11 +0200
Message-Id: <20200422095033.225297353@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200422095031.522502705@linuxfoundation.org>
References: <20200422095031.522502705@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Slava Bacherikov <slava@bacher09.org>

commit 7d32e69310d67e6b04af04f26193f79dfc2f05c7 upstream.

Currently turning on DEBUG_INFO_SPLIT when DEBUG_INFO_BTF is also
enabled will produce invalid btf file, since gen_btf function in
link-vmlinux.sh script doesn't handle *.dwo files.

Enabling DEBUG_INFO_REDUCED will also produce invalid btf file,
and using GCC_PLUGIN_RANDSTRUCT with BTF makes no sense.

Fixes: e83b9f55448a ("kbuild: add ability to generate BTF type info for vmlinux")
Reported-by: Jann Horn <jannh@google.com>
Reported-by: Liu Yiding <liuyd.fnst@cn.fujitsu.com>
Signed-off-by: Slava Bacherikov <slava@bacher09.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: KP Singh <kpsingh@google.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Link: https://lore.kernel.org/bpf/20200402204138.408021-1-slava@bacher09.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 lib/Kconfig.debug |    2 ++
 1 file changed, 2 insertions(+)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -223,6 +223,8 @@ config DEBUG_INFO_DWARF4
 config DEBUG_INFO_BTF
 	bool "Generate BTF typeinfo"
 	depends on DEBUG_INFO
+	depends on !DEBUG_INFO_SPLIT && !DEBUG_INFO_REDUCED
+	depends on !GCC_PLUGIN_RANDSTRUCT || COMPILE_TEST
 	help
 	  Generate deduplicated BTF type information from DWARF debug info.
 	  Turning this on expects presence of pahole tool, which will convert


