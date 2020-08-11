Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E809C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3649920781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgHKRYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:24:02 -0400
Received: from mga09.intel.com ([134.134.136.24]:62001 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729150AbgHKRYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:24:01 -0400
IronPort-SDR: lhL68nV8Ruyfvn6I28rgbv58gLw237Jn//b6/9vm0BvIPmzYurDIdjxxKBfvOFZH0gEPOVGYDd
 pKITMHZVz18g==
X-IronPort-AV: E=McAfee;i="6000,8403,9710"; a="154910056"
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="154910056"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 10:24:00 -0700
IronPort-SDR: hZEia4jOZt4s6s9oIl3KXGk5o3PWnjkpjhslTxVZbtDGOOdbxZPK4LNvXPdXJ3XuF7I9fSPA3G
 3KLTDJxFs+ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,301,1592895600"; 
   d="scan'208";a="317804399"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2020 10:24:00 -0700
Subject: [PATCH] Documentation: clarify driver licensing rules
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, h.peter.anvin@intel.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Tue, 11 Aug 2020 10:17:48 -0700
Message-Id: <20200811171748.F22CD85A@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Resend. Something appears to have eaten this on the way to LKML
(at least) the last time.

--

From: Dave Hansen <dave.hansen@linux.intel.com>

Greg has challenged some recent driver submitters on their license
choices. He was correct to do so, as the choices in these instances
did not always advance the aims of the submitters.

But, this left submitters (and the folks who help them pick licenses)
a bit confused. They have read things like
Documentation/process/license-rules.rst which says:

	individual source files can have a different license
	which is required to be compatible with the GPL-2.0

and Documentation/process/submitting-drivers.rst:

	We don't insist on any kind of exclusive GPL licensing,
	and if you wish ... you may well wish to release under
	multiple licenses.

As written, these appear a _bit_ more laissez faire than we've been in
practice lately. It sounds like we at least expect submitters to make
a well-reasoned license choice and to explain their rationale. It does
not appear that we blindly accept anything that is simply
GPLv2-compatible.

Drivers appear to be the most acute source of misunderstanding, so fix
the driver documentation first. Update it to clarify maintainer
expectations.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: H. Peter Anvin <h.peter.anvin@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-spdx@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---

 b/Documentation/process/submitting-drivers.rst |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff -puN Documentation/process/submitting-drivers.rst~clarify-dual-licensing Documentation/process/submitting-drivers.rst
--- a/Documentation/process/submitting-drivers.rst~clarify-dual-licensing	2020-08-11 09:35:55.493109636 -0700
+++ b/Documentation/process/submitting-drivers.rst	2020-08-11 09:35:55.496109636 -0700
@@ -59,11 +59,13 @@ What Criteria Determine Acceptance
 ----------------------------------
 
 Licensing:
-		The code must be released to us under the
-		GNU General Public License. We don't insist on any kind
-		of exclusive GPL licensing, and if you wish the driver
-		to be useful to other communities such as BSD you may well
-		wish to release under multiple licenses.
+		The code must be released to us under the GNU General Public
+		License. While there are no kernel-wide rules, some maintainers
+		may insist on exclusive GPL licensing by default. If you wish
+		the driver to be useful to other communities such as BSD you may
+		well wish to release under multiple licenses. If you choose to
+		release under multiple licenses, you should include your
+		rationale for your license choices in your cover letter.
 		See accepted licenses at include/linux/module.h
 
 Copyright:
_
