Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4891AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2897F20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 20:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592943850;
	bh=0ITsDM3fOKZh+tWWm63frmHczA2dJQnz3x74cD9OrLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SgR5Dx0XZeYinoKE3Ug2lZ32HhTeYLCKIW0jQmNhq5uwpY4ayIOuaifZcl3/rMMg2
	 qysBb/7DOqlAn3L5uF/wpZbzfW6N9KIBKZ362E+dJFVYUXqVtcVwrhaYJAaJSC8W+e
	 nb1XVBw0dFSHzU+Ke2wVngiL+OoX+6c9Ya178mjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390381AbgFWUYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387861AbgFWUYC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:24:02 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 222D220723;
        Tue, 23 Jun 2020 20:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943842;
        bh=0ITsDM3fOKZh+tWWm63frmHczA2dJQnz3x74cD9OrLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=agMsRkc2IjYkJWFN5UgqythwsBaeq7HIbKtJ3v9etxJpwEm3I9vscdrm+uReOAYUE
         1j90fdXTwm0ZEaT2dK3l8SJ1eHgt2enzANYkL8b4Ad5UrM0xACkPwyC4r44+jziX+3
         aid6Y+5q+5OJeCPhuZMNTmq4qoHnYl/+rF5uGDo8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ashimida <ashimida@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 073/314] mksysmap: Fix the mismatch of .L symbols in System.map
Date:   Tue, 23 Jun 2020 21:54:28 +0200
Message-Id: <20200623195342.328692157@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ashimida <ashimida@linux.alibaba.com>

[ Upstream commit 72d24accf02add25e08733f0ecc93cf10fcbd88c ]

When System.map was generated, the kernel used mksysmap to
filter the kernel symbols, but all the symbols with the
second letter 'L' in the kernel were filtered out, not just
the symbols starting with 'dot + L'.

For example:
ashimida@ubuntu:~/linux$ cat System.map |grep ' .L'
ashimida@ubuntu:~/linux$ nm -n vmlinux |grep ' .L'
ffff0000088028e0 t bLength_show
......
ffff0000092e0408 b PLLP_OUTC_lock
ffff0000092e0410 b PLLP_OUTA_lock

The original intent should be to filter out all local symbols
starting with '.L', so the dot should be escaped.

Fixes: 00902e984732 ("mksysmap: Add h8300 local symbol pattern")
Signed-off-by: ashimida <ashimida@linux.alibaba.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/mksysmap | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index a35acc0d0b827..9aa23d15862a0 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -41,4 +41,4 @@
 # so we just ignore them to let readprofile continue to work.
 # (At least sparc64 has __crc_ in the middle).
 
-$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( .L\)' > $2
+$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( \.L\)' > $2
-- 
2.25.1



