Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C12C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 368CB207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l+dfGhmG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbgGPB3F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:29:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgGPB3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:29:04 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41380C061755;
        Wed, 15 Jul 2020 18:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=BnLpqLBrUJ9YujbTwMz5b++VGY+LIbK1WsoqS+zn56w=; b=l+dfGhmGQDEyBav8PyGRHYscR5
        CntsywkPpGl9cFbQ1/q4ptuHRBQsbKKOJpMMBayourqI7lSi8dZ9a/EgAZIO9nDYoZXRiawv0ITFw
        CfX7TwDDzvg+H0JdnBkgFOqPEh2VswDQYspGkwjsiGI+QaJoCZPfGdnZOgPDBkgwkcJJi0/2tFQ8e
        3zYBdNReT56NSIs6cRREYT49fl6Ec/D98Y84oJCVtc+18JoJaHlsngLSxi3fuWh2MfyxFEeRTDcCt
        Amj9THyHHm5TBgt0vnMH6m5uviCuaRetlUmypzUvu5qhXKZZ7V2z9XhiZAkfMpRrBuA5JF6Fgec9Q
        yyzRsupw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvshp-0000Om-Rt; Thu, 16 Jul 2020 01:29:02 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] bcm963xx_tag.h: fix duplicated word
To:     LKML <linux-kernel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org
Message-ID: <d30c09a3-fe30-ddf1-3f21-00fc48b16443@infradead.org>
Date:   Wed, 15 Jul 2020 18:28:58 -0700
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

Change doubled word "is" to "it is".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: linux-mips@vger.kernel.org
---
 include/linux/bcm963xx_tag.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/bcm963xx_tag.h
+++ linux-next-20200714/include/linux/bcm963xx_tag.h
@@ -84,7 +84,7 @@ struct bcm_tag {
 	char flash_layout_ver[FLASHLAYOUTVER_LEN];
 	/* 196-199: kernel+rootfs CRC32 */
 	__u32 fskernel_crc;
-	/* 200-215: Unused except on Alice Gate where is is information */
+	/* 200-215: Unused except on Alice Gate where it is information */
 	char information2[TAGINFO2_LEN];
 	/* 216-219: CRC32 of image less imagetag (kernel for Alice Gate) */
 	__u32 image_crc;

