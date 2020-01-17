Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE34AC33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B57C121582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 16:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579277911;
	bh=ocjmWtDqYdcdpUAejOH5VD2hJd8psDKhPo37YZ0fw4Q=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=iU4kmueQRD7eBd0bFQP0qLAb18vhZlDYcWw6LbSHaQMdAl0wveK00a1Dh7RDKB6gL
	 OuXdbWqDKQWk27k3/1uQKuKgATisXPSxBJRwThU5KRh6QZkCKCkz2tuaufCobUv1pR
	 InKNATWT5rZRLh0zab1P/RWp+xSrT4L9Lt+zkWzc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgAQQSb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 11:18:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:58102 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727043AbgAQQSa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 11:18:30 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E411B2073A;
        Fri, 17 Jan 2020 16:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579277910;
        bh=ocjmWtDqYdcdpUAejOH5VD2hJd8psDKhPo37YZ0fw4Q=;
        h=From:To:Cc:Subject:Date:From;
        b=I5q5gdX8mA2JqDHmCTtuKiwd5h99Y3mNgEzwqV2n2Fu/BiQIJCGNNQLFZWXeiENrk
         w/VTwzkRtKsKAI8FqhZRuTuQaHS1Njlt3SzOPliHHKdJh67CCewYkHBO19muK4O0eC
         jHvSmijUUfe2K51zVQfdLp7L9dfF7gBJZKCqUIRk=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v2] kconfig: fix documentation typos
Date:   Fri, 17 Jan 2020 10:18:22 -0600
Message-Id: <20200117161822.106635-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Fix a couple typos in kconfig-language documentation.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/kbuild/kconfig-language.rst | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/kbuild/kconfig-language.rst b/Documentation/kbuild/kconfig-language.rst
index 74bef19f69f0..0148ae82446e 100644
--- a/Documentation/kbuild/kconfig-language.rst
+++ b/Documentation/kbuild/kconfig-language.rst
@@ -594,7 +594,8 @@ The two different resolutions for b) can be tested in the sample Kconfig file
 Documentation/kbuild/Kconfig.recursion-issue-02.
 
 Below is a list of examples of prior fixes for these types of recursive issues;
-all errors appear to involve one or more select's and one or more "depends on".
+all errors appear to involve one or more "select" statements and one or more
+"depends on".
 
 ============    ===================================
 commit          fix
@@ -656,7 +657,7 @@ the use of the xconfig configurator [1]_. Work should be done to confirm if
 the deduced semantics matches our intended Kconfig design goals.
 
 Having well defined semantics can be useful for tools for practical
-evaluation of depenencies, for instance one such use known case was work to
+evaluation of dependencies, for instance one such case was work to
 express in boolean abstraction of the inferred semantics of Kconfig to
 translate Kconfig logic into boolean formulas and run a SAT solver on this to
 find dead code / features (always inactive), 114 dead features were found in
@@ -683,7 +684,7 @@ abstraction the inferred semantics of Kconfig to translate Kconfig logic into
 boolean formulas and run a SAT solver on it [5]_. Another known related project
 is CADOS [6]_ (former VAMOS [7]_) and the tools, mainly undertaker [8]_, which
 has been introduced first with [9]_.  The basic concept of undertaker is to
-exract variability models from Kconfig, and put them together with a
+extract variability models from Kconfig and put them together with a
 propositional formula extracted from CPP #ifdefs and build-rules into a SAT
 solver in order to find dead code, dead files, and dead symbols. If using a SAT
 solver is desirable on Kconfig one approach would be to evaluate repurposing
-- 
2.25.0.341.g760bfbb309-goog

