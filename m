Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D1BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829A720791
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="J5XjavqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgGPB33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728033AbgGPB32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:29:28 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C956FC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 18:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QgotKbpZhsh+I6y5LuRfxy2LNV6XtIWfzNerVr87aUU=; b=J5XjavqT9dvj/jCIA89DFjG2Jc
        aGAttPg95t7VpGLF9pLVay3ObhosbzBzviCjDJEz3zseKDVmpUs5SskWEQPzJ5rI97HupMUQGqMsS
        AZcYyrRQWKnxGZ47XEym6NxPplEa33tLOXDVCJ4h7+EEvyXp9YDcGdu536/lfSYAIMQRfIebvgGbj
        sADR3h4ROB0hwrlCyKmPcitVupDPszu/JH7jAzaaxNga4Qe5UKMa49ty/uzwzXhXX1ExG9DeEbjl0
        4MQkK9a0+7BxwO9nlD4MejnnbKoFAGpGuKV9shVaCfx0ZKPeMYYwZcpoj90Xo7Y4UFWc7z5PZMWhW
        3jnm08NQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvsiA-0000QX-63; Thu, 16 Jul 2020 01:29:22 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] genwqe: fix duplicated words for clarity
To:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Haverkamp <haver@linux.ibm.com>
Message-ID: <f902ae2f-0df9-500a-17d1-f2c4100ddd41@infradead.org>
Date:   Wed, 15 Jul 2020 18:29:19 -0700
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

Add a hyphen between duplicated word "Window" for clarity.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Frank Haverkamp <haver@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/uapi/linux/genwqe/genwqe_card.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/linux/genwqe/genwqe_card.h
+++ linux-next-20200714/include/uapi/linux/genwqe/genwqe_card.h
@@ -86,7 +86,7 @@
  * The Physical Function's Access is from offset 0x00050000
  * Single Shared Registers exists only at offset 0x00060000
  *
- * SLC: Queue Virtual Window Window for accessing into a specific VF
+ * SLC: Queue Virtual Window - Window for accessing into a specific VF
  * queue. When accessing the 0x10000 space using the 0x50000 address
  * segment, the value indicated here is used to specify which VF
  * register is decoded. This register, and the 0x50000 register space

