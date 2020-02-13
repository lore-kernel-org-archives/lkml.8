Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9567C352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6674A2173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 04:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q+wbEs+4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgBMElB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 23:41:01 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729358AbgBMElA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 23:41:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=V4kNebw5qwSAs1Iv3VjcAGcXSIRN/Sh+t0JG0ujJMLA=; b=Q+wbEs+4SjiYlqx6+leCFn40Rb
        MFIheZuIKzBVVOtdCQU5SULXwDC1rDORCfMp0rjyuChrx8ChPH8vtSnVk8rqNMX1eq0wulpE9SKRA
        9WAhh3YSvV3u1ZD5we4JrdoPWE5fWnioChew1lXXVAhDw8jDEsXMdMMTiqw7Rrd6Nh7Brk0ZWZHXt
        kNz1Um7Nzai5WYjwCiIyw6V+jLuCqn7jHUfQO3W7SzOKLMldKoyiWvBcuCWBoZPFbOtjCgmT38eKQ
        GA4SOAiiwcJh0MfcVZkYdZnjtJPeO1wslVj5SYClhP2CkHqG9Ps4IfhY205UtOLWHTgQ+qnbIlgl8
        PQYhTn4A==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j26JA-0003vk-Hq; Thu, 13 Feb 2020 04:41:00 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] kbuild: add comment for V=2 mode
Message-ID: <a06194f0-3713-cc04-1673-c05b35c03242@infradead.org>
Date:   Wed, 12 Feb 2020 20:40:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Complete the comments for valid values of KBUILD_VERBOSE,
specifically for KBUILD_VERBOSE=2.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Makefile |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20200206.orig/Makefile
+++ linux-next-20200206/Makefile
@@ -68,6 +68,7 @@ unexport GREP_OPTIONS
 #
 # If KBUILD_VERBOSE equals 0 then the above command will be hidden.
 # If KBUILD_VERBOSE equals 1 then the above command is displayed.
+# If KBUILD_VERBOSE equals 2 then give the reason why each target is rebuilt.
 #
 # To put more focus on warnings, be less verbose as default
 # Use 'make V=1' to see the full commands

