Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769D5C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 524B221744
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859038;
	bh=XHA81FS07KlpOQaz+1Q2JY0Vb4pS95BjEb+hC8iEUVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xbBYGdRaIAe6+AtQz7HP0QKSyp7XYf4qGkbQHsHfE3XQQHs3OCJjsMP3D1wIlSfd2
	 Zh6ioLCaJ3ANRTjFNfwVl34AP/copDKVdxjnsODWMay/D0r7xdC3wqRkgFTWbzvNaP
	 2NjvSA6Qo7xoHKkU8rSmerB7/XrXcQkkxNiTYYHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgG0OKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:10:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729866AbgG0OKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:10:35 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DBD322B45;
        Mon, 27 Jul 2020 14:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859034;
        bh=XHA81FS07KlpOQaz+1Q2JY0Vb4pS95BjEb+hC8iEUVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kv99ToyeAqoAy0ze1PM7nrpp7T1S8D2TUxbYfeoS5t0VI+SURhBrYCyZQCstXTzzj
         RvB2GOf+cDQjSipylkNC4ji5kZg1a7rfivGkDuZIKCTuckI7EOaLPigLZI3mDzgho7
         LQoPQObE6qjgGeQdqaLVDyXPkZ+T+pdKFLKpsBsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 42/86] scripts/gdb: fix lx-symbols gdb.error while loading modules
Date:   Mon, 27 Jul 2020 16:04:16 +0200
Message-Id: <20200727134916.556617777@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 7359608a271ce81803de148befefd309baf88c76 ]

Commit ed66f991bb19 ("module: Refactor section attr into bin attribute")
removed the 'name' field from 'struct module_sect_attr' triggering the
following error when invoking lx-symbols:

  (gdb) lx-symbols
  loading vmlinux
  scanning for modules in linux/build
  loading @0xffffffffc014f000: linux/build/drivers/net/tun.ko
  Python Exception <class 'gdb.error'> There is no member named name.:
  Error occurred in Python: There is no member named name.

This patch fixes the issue taking the module name from the 'struct
attribute'.

Fixes: ed66f991bb19 ("module: Refactor section attr into bin attribute")
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>
Reviewed-by: Kieran Bingham <kbingham@kernel.org>
Link: http://lkml.kernel.org/r/20200722102239.313231-1-sgarzare@redhat.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/gdb/linux/symbols.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
index 4644f1a83b578..aa4f87e3ddb12 100644
--- a/scripts/gdb/linux/symbols.py
+++ b/scripts/gdb/linux/symbols.py
@@ -96,7 +96,7 @@ lx-symbols command."""
             return ""
         attrs = sect_attrs['attrs']
         section_name_to_address = {
-            attrs[n]['name'].string(): attrs[n]['address']
+            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
             for n in range(int(sect_attrs['nsections']))}
         args = []
         for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
-- 
2.25.1



