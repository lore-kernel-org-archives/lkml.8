Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7352EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51FD12078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 03:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jeW3Ii+9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728203AbgFODd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 23:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbgFODdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 23:33:25 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C2EC061A0E;
        Sun, 14 Jun 2020 20:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=2U5QdFRj4DPmdl+MraqrEoo5xxIBuPrFBQfLoN94gZc=; b=jeW3Ii+97a1mmigSrPcWGIIxSW
        /6PVmb/Y+Cl1BHMp90iQ1NIo7IbnME3CP+xsB71xfqx9RjFrFx8Sogdc22XSXnJ+QhjR/M8s7tkzw
        7WUPf9xJy5j8yObJhfbYM6lX1P9P78QkVo5oGDLD6nZHOHVSaeHBqCP2LMRbgLr7JwGPcMK6xQOrZ
        V8K1yCYqz6ongRIU4oPvjRN+sEUtG4Y5H7RD6Kddf+ovZDeMGl6EtXpXeP86aPHcaGoSfSCvmhx1m
        rNDnNSYfKYj/XQ6pf+8w2c7B2masU2uJNuvPIFakJhrOmO90QKTNTUoyhA0iDsFF7iemTDWMww6vh
        HncbLeTA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkfsC-00062y-7q; Mon, 15 Jun 2020 03:33:24 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Daniel Kiss <daniel.kiss@arm.com>, Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fix malformed table in filesystems/proc.rst
Message-ID: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
Date:   Sun, 14 Jun 2020 20:33:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix malformed table in "proc.rst" by dropping a needless hyphen ('-').

Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
Text in column margin in table line 29.

Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Kiss <daniel.kiss@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
---
 Documentation/filesystems/proc.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- lnx-58-rc1.orig/Documentation/filesystems/proc.rst
+++ lnx-58-rc1/Documentation/filesystems/proc.rst
@@ -545,7 +545,7 @@ encoded manner. The codes are the follow
     hg    huge page advise flag
     nh    no huge page advise flag
     mg    mergable advise flag
-    bt  - arm64 BTI guarded page
+    bt    arm64 BTI guarded page
     ==    =======================================
 
 Note that there is no guarantee that every flag and associated mnemonic will

