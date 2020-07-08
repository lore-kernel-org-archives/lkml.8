Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A54C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:30:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33471206F6
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 18:30:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgGHSaq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 14:30:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:36375 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725953AbgGHSap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 14:30:45 -0400
IronPort-SDR: Adg8XFfNc9nW9yelGRnvqjWkBF0PStyhi7ggG7uE+9sdGSbOKfVUB1DvBe3cEktlo/gs0vlMV8
 M3EKRH4D6N5w==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="209411363"
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="209411363"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 11:30:44 -0700
IronPort-SDR: M68QhvymFMKrag4yBhuycjyu6hH2hf8RGYnkGb9dCguMfPLnnxtoUpQAsvkVpFOWazkcG6vkmi
 xq0HaLrt/aJg==
X-IronPort-AV: E=Sophos;i="5.75,328,1589266800"; 
   d="scan'208";a="388897428"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2020 11:30:43 -0700
Subject: [PATCH v3] CodingStyle: Inclusive Terminology
From:   Dan Williams <dan.j.williams@intel.com>
To:     corbet@lwn.net
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        SeongJae Park <sjpark@amazon.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Mark Brown <broonie@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        torvalds@linux-foundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Jul 2020 11:14:27 -0700
Message-ID: <159423201991.2466245.8461410729774664077.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux maintains a coding-style and its own idiomatic set of terminology.
Update the style guidelines to recommend replacements for the terms
master/slave and blacklist/whitelist.

Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Dave Airlie <airlied@redhat.com>
Acked-by: SeongJae Park <sjpark@amazon.de>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
Changes since v2 [1]:
- Pick up missed sign-offs and acks from Jon, Shuah, and Christian
  (sorry about missing those earlier).

- Reformat the replacement list to make it easier to read.

- Add 'controller' as a suggested replacement (Kees and Mark)

- Fix up the paired term for 'performer' to be 'director' (Kees)

- Collect some new acks, reviewed-by's, and sign-offs for v2.

- Fix up Chris's email

[1]: http://lore.kernel.org/r/159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com


 Documentation/process/coding-style.rst |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 2657a55c6f12..1bee6f8affdb 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -319,6 +319,26 @@ If you are afraid to mix up your local variable names, you have another
 problem, which is called the function-growth-hormone-imbalance syndrome.
 See chapter 6 (Functions).
 
+For symbol names and documentation, avoid introducing new usage of
+'master / slave' (or 'slave' independent of 'master') and 'blacklist /
+whitelist'.
+
+Recommended replacements for 'master / slave' are:
+    '{primary,main} / {secondary,replica,subordinate}'
+    '{initiator,requester} / {target,responder}'
+    '{controller,host} / {device,worker,proxy}'
+    'leader / follower'
+    'director / performer'
+
+Recommended replacements for 'blacklist/whitelist' are:
+    'denylist / allowlist'
+    'blocklist / passlist'
+
+Exceptions for introducing new usage is to maintain a userspace ABI/API,
+or when updating code for an existing (as of 2020) hardware or protocol
+specification that mandates those terms. For new specifications
+translate specification usage of the terminology to the kernel coding
+standard where possible.
 
 5) Typedefs
 -----------

