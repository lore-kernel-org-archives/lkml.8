Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 450F7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD5D206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 01:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UfYb+ZYw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgE0BRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 21:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgE0BRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 21:17:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F96C061A0F;
        Tue, 26 May 2020 18:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=zpMNP4CRwq3qJJZms/7x8Uur/00YnZ5BGSuGvOyqx+o=; b=UfYb+ZYwQarNICF4sxHwDW63ZY
        NhMXs2vxOENFfckJiditFF5tZcB5tt7dL2oJmNk2/btFFC5kPL1U9pxtElpCyeAWvLwcAgLwEQu8O
        raI/MRoki4omR54gvrHokSrHXgZvXSbZHGaXLcUBNt7PwM7SR6rHQLcu4qS+iI9nKmmI4Gm16Il7M
        cF28v/eJZl5jUP+rrVnP9KDz/fKMeD27xqIX1BSWWjjBxsLu+OFrXpbbXD1n6q3qRLLFLzRiaSUgK
        WAPLk21kJxVHpNhvT3j5ha5YBPtXtO5ir27NwcwymyOsymoy5qrVs0uDHGBVTwu3Tls+EifncDS0D
        Uh5VGJPw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jdkh1-0002Fv-Dx; Wed, 27 May 2020 01:17:15 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] Documentation: fixes to the maintainer-entry-profile template
Message-ID: <fbaa9b67-e7b8-d5e8-ecbb-6ae068234880@infradead.org>
Date:   Tue, 26 May 2020 18:17:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Do some wordsmithing and copy editing on the maintainer-entry-profile
profile (template, guide):
- fix punctuation
- fix some wording
- use "-rc" consistently

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/maintainer/maintainer-entry-profile.rst |   12 +++++-----
 1 file changed, 6 insertions(+), 6 deletions(-)

--- linux-next-20200526.orig/Documentation/maintainer/maintainer-entry-profile.rst
+++ linux-next-20200526/Documentation/maintainer/maintainer-entry-profile.rst
@@ -7,7 +7,7 @@ The Maintainer Entry Profile supplements
 (submitting-patches, submitting drivers...) with
 subsystem/device-driver-local customs as well as details about the patch
 submission life-cycle. A contributor uses this document to level set
-their expectations and avoid common mistakes, maintainers may use these
+their expectations and avoid common mistakes; maintainers may use these
 profiles to look across subsystems for opportunities to converge on
 common practices.
 
@@ -26,7 +26,7 @@ Example questions to consider:
 - Does the subsystem have a patchwork instance? Are patchwork state
   changes notified?
 - Any bots or CI infrastructure that watches the list, or automated
-  testing feedback that the subsystem gates acceptance?
+  testing feedback that the subsystem uses to gate acceptance?
 - Git branches that are pulled into -next?
 - What branch should contributors submit against?
 - Links to any other Maintainer Entry Profiles? For example a
@@ -54,8 +54,8 @@ One of the common misunderstandings of s
 sent at any time before the merge window closes and can still be
 considered for the next -rc1. The reality is that most patches need to
 be settled in soaking in linux-next in advance of the merge window
-opening. Clarify for the submitter the key dates (in terms rc release
-week) that patches might considered for merging and when patches need to
+opening. Clarify for the submitter the key dates (in terms of -rc release
+week) that patches might be considered for merging and when patches need to
 wait for the next -rc. At a minimum:
 
 - Last -rc for new feature submissions:
@@ -70,8 +70,8 @@ wait for the next -rc. At a minimum:
 - Last -rc to merge features: Deadline for merge decisions
   Indicate to contributors the point at which an as yet un-applied patch
   set will need to wait for the NEXT+1 merge window. Of course there is no
-  obligation to ever except any given patchset, but if the review has not
-  concluded by this point the expectation the contributor should wait and
+  obligation to ever accept any given patchset, but if the review has not
+  concluded by this point the expectation is the contributor should wait and
   resubmit for the following merge window.
 
 Optional:

