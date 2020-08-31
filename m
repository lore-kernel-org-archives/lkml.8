Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4026C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9413B2076D
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RZXZsQyf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726468AbgHaAoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHaAoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:44:03 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF7DC061573;
        Sun, 30 Aug 2020 17:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=HJcfCyclewk4FrZYLGIK+aioBTHV/K05rdspPHw3Ge4=; b=RZXZsQyfB9/hoiFpoWkf09T+fz
        X9kmK4HI/K5LktWoSnb7cJ6vVPjDFuKITv75mXVi4KpaHjYyUhqbvOoUn0ZJSdy1CHhRicH53x0Ry
        vRAo+cGyWQSUToJm7pWC90ZSyNMdw+Ol+UiVWlVGJx9q101utJVYTVNqsE5sB3wUo3X+bojLb3vee
        1IfLeyn530kzKdliw5aVtux4NI4pwENmBo9k0zCELpS6TWc2JJvO7FV1o4mXtnDGvkaQdwwgNJsy/
        sfQ66mhUk00SVYnf3ppnDXA0Zp9ERkvSR74LxLRbR1lHKChg8vn4Si5EsfWJAcu/EaM/rZ461+M/i
        9rJ/uiVg==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCXvR-000874-HN; Mon, 31 Aug 2020 00:43:57 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2] Documentation: submit-checklist: add clean builds for new
 Documentation
Message-ID: <cf5bbdf5-03ff-0606-a6d4-ca196d90aee9@infradead.org>
Date:   Sun, 30 Aug 2020 17:43:54 -0700
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
Cc: Mike Rapoport <rppt@kernel.org>
---
v2: insert "new" inside "without warnings/errors" (Mike)

 Documentation/process/submit-checklist.rst |    4 ++++
 1 file changed, 4 insertions(+)

--- linux-next-20200821.orig/Documentation/process/submit-checklist.rst
+++ linux-next-20200821/Documentation/process/submit-checklist.rst
@@ -24,6 +24,10 @@ and elsewhere regarding submitting Linux
 
   c) Builds successfully when using ``O=builddir``
 
+  d) Any Documentation/ changes build successfully without new warnings/errors.
+     Use ``make htmldocs`` or ``make pdfdocs`` to check the build and
+     fix any issues.
+
 3) Builds on multiple CPU architectures by using local cross-compile tools
    or some other build farm.
 

