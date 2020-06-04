Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B98BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32FB42077D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591295993;
	bh=qaluXIZXPAvRaq//b7S/hUDzNw3X7usyojLTw448jZU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=FaLSr3J0qppzAxvgwKZfM3dr7Rikf+1lr/mmCvxMX+LQk1o7HHiJRiNG0rVRblSbK
	 Xkhk32qPM/ZrMpTb/KUaYwS585su0skT9qQSt1VVFaxhT9d2xdDS/U4Afbyj7ob2bL
	 A4hFExlXG4mGYOGWdI5Ae3CoS/eNDDYEv6fa+w+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgFDSjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:39:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726456AbgFDSjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:39:51 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 214E5206E6;
        Thu,  4 Jun 2020 18:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591295991;
        bh=qaluXIZXPAvRaq//b7S/hUDzNw3X7usyojLTw448jZU=;
        h=Date:From:To:Cc:Subject:From;
        b=GklncIDzM4RrYneoLUzcfm3Lg64th3J406rijG30mvBIII61ZrZ6i21x9OoUZIZJ9
         qXEwupvBqGKhyfmfSVoVPkggNWyU/y8r90ElBBC0SkiAGt1wtJjos1XvJY/2ojo5Da
         nKcTnoFRkNoira4uI1rghfkgHhpKYVgZC1GbuhVU=
Date:   Thu, 4 Jun 2020 13:44:56 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>, Kees Cook <keescook@chromium.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2] docs: deprecated.rst: Add note to the use of
 struct_size() helper
Message-ID: <20200604184456.GA24758@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a note to educate people about the proper use of struct_size() when
the trailing array in the enclosing structure is a one-element array.

Zero-length and one-element arrays will soon be removed from the kernel,
but in the meantime, it's worth letting people know how to correctly
use struct_size() together with such constructs.

Note: this documentation will be updated once all zero-length and
one-element arrays have been completely removed from the kernel.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Suggest stop using one-element arrays and switch to flexible arrays.
 - Update changelog text.

 Documentation/process/deprecated.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 652e2aa02a66c..1af3a021f4b33 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -85,6 +85,18 @@ Instead, use the helper::
 
 	header = kzalloc(struct_size(header, item, count), GFP_KERNEL);
 
+NOTE: You might want to use the following form in case the trailing array
+is a one-element array, as unlike zero-length arrays and flexible-array
+members, `one-element arrays occupy at least as much space as a single
+object of the type <https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html>`_,
+hence they contribute to the size of the enclosing structure::
+
+	header = kzalloc(struct_size(header, item, count - 1), GFP_KERNEL);
+
+It's also worth noting that one-element arrays --together with zero-length
+arrays-- will soon be completely removed from the codebase and deprecated.
+So, you better STOP using them and switch to flexible arrays instead.
+
 See array_size(), array3_size(), and struct_size(),
 for more details as well as the related check_add_overflow() and
 check_mul_overflow() family of functions.
-- 
2.27.0

