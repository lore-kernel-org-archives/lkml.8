Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA451C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895052192A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592444311;
	bh=1KICtU+7Ipxdndkbsv962r1msAcOgKW2WYbRsAws1IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Zul3i/blfqUy1J5m7syMtkXLBvw6diXNQE5JQK/5anxd6BXevd6/b+ek8xJVaM9i9
	 5X63yNMbaPjSovqTfropOcB5+iCUR+MrLU+Pne/PZFUNTRBVpPPDw+4vmaKq+HLjRG
	 HuRCyI9vv+IeclbGp8Qe439UHbEP9Qg7Tyoosfoc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbgFRBi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:38:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:40566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732549AbgFRBac (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:30:32 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D7777221EF;
        Thu, 18 Jun 2020 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443831;
        bh=1KICtU+7Ipxdndkbsv962r1msAcOgKW2WYbRsAws1IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sPNWLuRoH30EDljlI3SjhM+T/vB+UpqFutuH7H4L6q9noJkzsGyAyAIUf6x1QDslA
         1/tokVYK+BqHh7BysQtElonpO1oyXTBmvSwG5dOM5kVuCsxa6vkbHuLmTAowWs9Rzn
         TiIVK5XMjWJW5qNnzV/uEDCAQ2VXQzLvzItlfwCA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     ashimida <ashimida@linux.alibaba.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 19/60] mksysmap: Fix the mismatch of '.L' symbols in System.map
Date:   Wed, 17 Jun 2020 21:29:23 -0400
Message-Id: <20200618013004.610532-19-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618013004.610532-1-sashal@kernel.org>
References: <20200618013004.610532-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
index a35acc0d0b82..9aa23d15862a 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -41,4 +41,4 @@
 # so we just ignore them to let readprofile continue to work.
 # (At least sparc64 has __crc_ in the middle).
 
-$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( .L\)' > $2
+$NM -n $1 | grep -v '\( [aNUw] \)\|\(__crc_\)\|\( \$[adt]\)\|\( \.L\)' > $2
-- 
2.25.1

