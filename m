Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DBB620890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 20:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgGDUTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 16:19:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:15840 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726669AbgGDUTH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:19:07 -0400
IronPort-SDR: IjjGeK167Cm0BWzGttjY1Bd6KDkqpPoamjlRoSRNfLvgIO7NulMbb8B93g4omuVCEgctBZpiqM
 s/t5JUl0By+A==
X-IronPort-AV: E=McAfee;i="6000,8403,9672"; a="165336737"
X-IronPort-AV: E=Sophos;i="5.75,313,1589266800"; 
   d="scan'208";a="165336737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 13:19:06 -0700
IronPort-SDR: GocUcw1hSkjIGRDLYgw8AAE0rfjmEieMsxujPZtT187+2EbYFPreNT+IVhFNkgs7MoXShrMWvT
 ADsRSyXY3wPQ==
X-IronPort-AV: E=Sophos;i="5.75,313,1589266800"; 
   d="scan'208";a="426664763"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2020 13:19:06 -0700
Subject: [PATCH] CodingStyle: Inclusive Terminology
From:   Dan Williams <dan.j.williams@intel.com>
To:     torvalds@linux-foundation.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ksummit-discuss@lists.linuxfoundation.org,
        tech-board-discuss@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 04 Jul 2020 13:02:51 -0700
Message-ID: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent events have prompted a Linux position statement on inclusive
terminology. Given that Linux maintains a coding-style and its own
idiomatic set of terminology here is a proposal to answer the call to
replace non-inclusive terminology.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Chris Mason <clm@fb.clm>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/process/coding-style.rst          |   12 ++++
 Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
 Documentation/process/index.rst                 |    1 
 3 files changed, 77 insertions(+)
 create mode 100644 Documentation/process/inclusive-terminology.rst

diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
index 2657a55c6f12..4b15ab671089 100644
--- a/Documentation/process/coding-style.rst
+++ b/Documentation/process/coding-style.rst
@@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
 problem, which is called the function-growth-hormone-imbalance syndrome.
 See chapter 6 (Functions).
 
+For symbol names, avoid introducing new usage of the words 'slave' and
+'blacklist'. Recommended replacements for 'slave' are: 'secondary',
+'subordinate', 'replica', 'responder', 'follower', 'proxy', or
+'performer'.  Recommended replacements for blacklist are: 'blocklist' or
+'denylist'.
+
+Exceptions for introducing new usage is to maintain a userspace ABI, or
+when updating code for an existing (as of 2020) hardware or protocol
+specification that mandates those terms. For new specifications consider
+translating specification usage of the terminology to the kernel coding
+standard where possible. See :ref:`process/inclusive-terminology.rst
+<inclusiveterminology>` for details.
 
 5) Typedefs
 -----------
diff --git a/Documentation/process/inclusive-terminology.rst b/Documentation/process/inclusive-terminology.rst
new file mode 100644
index 000000000000..a8eb26690eb4
--- /dev/null
+++ b/Documentation/process/inclusive-terminology.rst
@@ -0,0 +1,64 @@
+.. _inclusiveterminology:
+
+Linux kernel inclusive terminology
+==================================
+
+The Linux kernel is a global software project, and in 2020 there was a
+global reckoning on race relations that caused many organizations to
+re-evaluate their policies and practices relative to the inclusion of
+people of African descent. This document describes why the 'Naming'
+section in :ref:`process/coding-style.rst <codingstyle>` recommends
+avoiding usage of 'slave' and 'blacklist' in new additions to the Linux
+kernel.
+
+On the triviality of replacing words
+====================================
+
+The African slave trade was a brutal system of human misery deployed at
+global scale. Some word choice decisions in a modern software project
+does next to nothing to compensate for that legacy. So why put any
+effort into something so trivial in comparison? Because the goal is not
+to repair, or erase the past. The goal is to maximize availability and
+efficiency of the global developer community to participate in the Linux
+kernel development process.
+
+Word choice and developer efficiency
+====================================
+
+Why does any software project go through the trouble of developing a
+document like :ref:`process/coding-style.rst <codingstyle>`? It does so
+because a common coding style maximizes the efficiency of both
+maintainers and developers. Developers learn common design patterns and
+idiomatic expressions while maintainers can spot deviations from those
+norms. Even non-compliant whitespace is considered a leading indicator
+to deeper problems in a patchset. Coding style violations are known to
+take a maintainer "out of the zone" of reviewing code. Maintainers are
+also sensitive to word choice across specifications and often choose to
+deploy Linux terminology to replace non-idiomatic word-choice in a
+specification.
+
+Non-inclusive terminology has that same distracting effect which is why
+it is a style issue for Linux, it injures developer efficiency.
+
+Of course it is around this point someone jumps in with an etymological
+argument about why people should not be offended. Etymological arguments
+do not scale. The scope and pace of Linux to reach new developers
+exceeds the ability of historical terminology defenders to describe "no,
+not that connotation". The revelation of 2020 was that black voices were
+heard on a global scale and the Linux kernel project has done its small
+part to answer that call as it wants black voices, among all voices, in
+its developer community.
+
+Really, 'blacklist' too?
+========================
+
+While 'slave' has a direct connection to human suffering the etymology
+of 'blacklist' is devoid of a historical racial connection. However, one
+thought exercise is to consider replacing 'blacklist/whitelist' with
+'redlist/greenlist'. Realize that the replacement only makes sense if
+you have been socialized with the concepts that 'red/green' implies
+'stop/go'. Colors to represent a policy requires an indirection. The
+socialization of 'black/white' to have the connotation of
+'impermissible/permissible' does not support inclusion.
+
+Inclusion == global developer community efficiency.
diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index f07c9250c3ac..ed861f6f8d25 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -27,6 +27,7 @@ Below are the essential guides that every developer should read.
    submitting-patches
    programming-language
    coding-style
+   inclusive-terminology
    maintainer-pgp-guide
    email-clients
    kernel-enforcement-statement

