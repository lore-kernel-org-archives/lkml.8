Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33FFCC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07842207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MyQFx3Uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgGPB25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726776AbgGPB2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:28:55 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340F4C061755;
        Wed, 15 Jul 2020 18:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:To:Subject:From:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Ivt/S2E26MMmfuGaOWJ4/5vbxsd/UYTBZ3TQCIqNLng=; b=MyQFx3UcYSKlzISyFpi1oast9v
        AXcaUvG75KxTI6/bxqStU3uCRyw56lDwAEgtNFQGuGbd34h91cli8lIGkL+k9scQcgH/lyN8NLei8
        l4qf3ULUQTTX4jFWPEcg4h0x4jzGYg/A462dAqNLQn+6IkwooqAUWGPmrKMAmje0jCmWlbGY5cnwj
        ARoe6h4HOVVGFCcWKQ+PWdVTQ4bd7HGjYkc/50oaxFmPGUqGmXzgslTkFEKcsGz7RBxywoCICrRjX
        +prYNKXS/7T0W1GNKlS63+yTm87gWJLoB+YGxSc/FR725efAA29o0ullXUf33URuf/EPrPbndOqNB
        PfLut/xQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvshe-0000Ny-RU; Thu, 16 Jul 2020 01:28:51 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] autofs: fix doubled word
To:     LKML <linux-kernel@vger.kernel.org>,
        autofs mailing list <autofs@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        Andrew Morton <akpm@linux-foundation.org>
Message-ID: <5a82befd-40f8-8dc0-3498-cbc0436cad9b@infradead.org>
Date:   Wed, 15 Jul 2020 18:28:47 -0700
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
Cc: Ian Kent <raven@themaw.net>
Cc: autofs@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/uapi/linux/auto_dev-ioctl.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/uapi/linux/auto_dev-ioctl.h
+++ linux-next-20200714/include/uapi/linux/auto_dev-ioctl.h
@@ -82,7 +82,7 @@ struct args_ismountpoint {
 /*
  * All the ioctls use this structure.
  * When sending a path size must account for the total length
- * of the chunk of memory otherwise is is the size of the
+ * of the chunk of memory otherwise it is the size of the
  * structure.
  */
 

