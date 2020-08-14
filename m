Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41464C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DAF820774
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 15:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHNPCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 11:02:50 -0400
Received: from mga17.intel.com ([192.55.52.151]:52475 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNPCt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 11:02:49 -0400
IronPort-SDR: yTc4oJMMs6T19H2dus9sE7/mtRCz+kIaVflaS11oa6I2WiskHHlVL20m4MQjEyUXZcJ61oSVSR
 sUh8LgCGaquA==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="134479554"
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="134479554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 08:02:48 -0700
IronPort-SDR: G1mapDLae7K3C4DCu34RXjDxFZBentlIK6vniD71UBaPUSrwbX5APZifwfzLDDuAgotNAWOHaA
 uLY73rPw+UJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,312,1592895600"; 
   d="scan'208";a="278414598"
Received: from viggo.jf.intel.com (HELO localhost.localdomain) ([10.54.77.144])
  by fmsmga008.fm.intel.com with ESMTP; 14 Aug 2020 08:02:48 -0700
Subject: [PATCH] [v2] Documentation: clarify driver licensing rules
To:     linux-kernel@vger.kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        dan.j.williams@intel.com, h.peter.anvin@intel.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org
From:   Dave Hansen <dave.hansen@linux.intel.com>
Date:   Fri, 14 Aug 2020 07:56:25 -0700
Message-Id: <20200814145625.8B708079@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


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
the driver documentation first. Update it to clarify expectations.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: H. Peter Anvin <h.peter.anvin@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-spdx@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

--

Changes from v1:
 * Remove mention of maintainers enforcing particular license
   choices.
 * Change the wording to ensure that folks understand that the
   trigger that requires an explanation is not multiple
   licenses per se, but non-GPL licenses.  You could argue that
   GPLv2-or-later is multiple liceses, for instance.
---

 b/Documentation/process/submitting-drivers.rst |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff -puN Documentation/process/submitting-drivers.rst~clarify-dual-licensing Documentation/process/submitting-drivers.rst
--- a/Documentation/process/submitting-drivers.rst~clarify-dual-licensing	2020-08-14 07:42:06.300480229 -0700
+++ b/Documentation/process/submitting-drivers.rst	2020-08-14 07:53:10.373478573 -0700
@@ -60,10 +60,11 @@ What Criteria Determine Acceptance
 
 Licensing:
 		The code must be released to us under the
-		GNU General Public License. We don't insist on any kind
-		of exclusive GPL licensing, and if you wish the driver
-		to be useful to other communities such as BSD you may well
-		wish to release under multiple licenses.
+		GNU General Public License. If you wish the driver to be
+		useful to other communities such as BSD you may release
+		under multiple licenses. If you choose to release under
+		licenses other than the GPL, you should include your
+		rationale for your license choices in your cover letter.
 		See accepted licenses at include/linux/module.h
 
 Copyright:
_
