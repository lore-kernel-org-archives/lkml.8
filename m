Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B88BC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:38:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C6E3206F7
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 00:38:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hTNISxl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727077AbgHXAiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 20:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgHXAiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 20:38:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97542C061573;
        Sun, 23 Aug 2020 17:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=e4c87ctQhlZQXOpEqjOjyddKq7CyiWwdiKzpIL2sS/o=; b=hTNISxl/LEjiFoNBMo6kVNkVCW
        Oi/Gxu6c8Wyda7/8NY+9479motELpRBzQcPU7kuRvc167St3VJjRjBbVdhV2zkLGPXb7ITwATsEy3
        fwGXcGV0R6egcJQjcZ3Jlzwi0opY5bhDf2JIlqLX+UVDLtshNFGphiIX4qUplaoFWJLDyFsXMX+Jz
        N2V/BTYOJP/5c3XIGBsSp/sERGRENLwS3zMrJKuWmb2worpJgOMWKEJv2JHoLEv76RLz9uG0BxTNz
        ETSZCXLNZoQVCKwNXNAgp8hSXJylBFKTrzgd7BFV4w/6SVDRTQt8vq7YWl8y6I0hN1i5MGQPjCqG5
        fpJA2jWg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kA0V4-000412-Js; Mon, 24 Aug 2020 00:38:14 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: submit-checklist: add Documentation clean
 builds
Message-ID: <e38b108c-afec-fd0e-ad09-b4dd5da59fd1@infradead.org>
Date:   Sun, 23 Aug 2020 17:38:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Add to Documentation/process/submit-checklist.rst that patch
submitters should run "make htmldocs" and verify that any
Documentation/ changes (patches) are clean (no new warnings/errors).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 Documentation/process/submit-checklist.rst |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200821.orig/Documentation/process/submit-checklist.rst
+++ linux-next-20200821/Documentation/process/submit-checklist.rst
@@ -24,6 +24,10 @@ and elsewhere regarding submitting Linux
 
   c) Builds successfully when using ``O=builddir``
 
+  d) Any Documentation/ changes build successfully without warnings/errors.
+     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
+     fix any issues.
+
 3) Builds on multiple CPU architectures by using local cross-compile tools
    or some other build farm.
 

