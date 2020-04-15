Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0977C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F0D6208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586962013;
	bh=zjaZ+FY9k5t0F298mGBFOd6P5KCDBR9N1LMntsYEq9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vHBdWLPnxxSM7/bx8qWzTKiFGACd6+wfpIV2jYgTNOvZNmGWMNarrVjkX2zNZ3v1o
	 OB7FQo8fWpYlr8hqVoES611Ra1FdFlTbVDjQvhRtAVK/kn7efaR8qGAwdks0Li93XP
	 iLz3B6qaMkJul/PRRSDrbT2KajVb9jXnYm8LUqlw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370968AbgDOOqn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:46:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636790AbgDOOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1608121556;
        Wed, 15 Apr 2020 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=zjaZ+FY9k5t0F298mGBFOd6P5KCDBR9N1LMntsYEq9Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RjiW4sfNN3VQYHu759vgsitq4kOPElObnihHUZu0byStwRHmUBWi0zfWdN2uUINFt
         9jN7vHmsnAWqYnrf+9ZYqazIgsPvlwkcOG6rXl1h4TKxQ0675MUPTjw5cRx3Hz4W0R
         in8opOwOp7lzOD4pk1CrosXFd6nV1GLpT2PoWcJ4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZa-9O; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 06/12] docs: dt: convert dynamic-resolution-notes.txt to ReST
Date:   Wed, 15 Apr 2020 16:45:20 +0200
Message-Id: <aa9be5085f574d924b74b1e58d07ebee39ad8dad.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Adjust document title;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 ...mic-resolution-notes.txt => dynamic-resolution-notes.rst} | 5 ++++-
 Documentation/devicetree/index.rst                           | 1 +
 Documentation/devicetree/overlay-notes.txt                   | 2 +-
 MAINTAINERS                                                  | 2 +-
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/{dynamic-resolution-notes.txt => dynamic-resolution-notes.rst} (90%)

diff --git a/Documentation/devicetree/dynamic-resolution-notes.txt b/Documentation/devicetree/dynamic-resolution-notes.rst
similarity index 90%
rename from Documentation/devicetree/dynamic-resolution-notes.txt
rename to Documentation/devicetree/dynamic-resolution-notes.rst
index c24ec366c5dc..570b7e1f39eb 100644
--- a/Documentation/devicetree/dynamic-resolution-notes.txt
+++ b/Documentation/devicetree/dynamic-resolution-notes.rst
@@ -1,5 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
 Device Tree Dynamic Resolver Notes
-----------------------------------
+==================================
 
 This document describes the implementation of the in-kernel
 Device Tree resolver, residing in drivers/of/resolver.c
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 64c78c3ffea6..308cac9d7021 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -11,3 +11,4 @@ Open Firmware and Device Tree
    writing-schema
    booting-without-of
    changesets
+   dynamic-resolution-notes
diff --git a/Documentation/devicetree/overlay-notes.txt b/Documentation/devicetree/overlay-notes.txt
index 725fb8d255c1..3f20a39e4bc2 100644
--- a/Documentation/devicetree/overlay-notes.txt
+++ b/Documentation/devicetree/overlay-notes.txt
@@ -3,7 +3,7 @@ Device Tree Overlay Notes
 
 This document describes the implementation of the in-kernel
 device tree overlay functionality residing in drivers/of/overlay.c and is a
-companion document to Documentation/devicetree/dynamic-resolution-notes.txt[1]
+companion document to Documentation/devicetree/dynamic-resolution-notes.rst[1]
 
 How overlays work
 -----------------
diff --git a/MAINTAINERS b/MAINTAINERS
index 58725773cec4..12fb85313e1b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12553,7 +12553,7 @@ M:	Pantelis Antoniou <pantelis.antoniou@konsulko.com>
 M:	Frank Rowand <frowand.list@gmail.com>
 L:	devicetree@vger.kernel.org
 S:	Maintained
-F:	Documentation/devicetree/dynamic-resolution-notes.txt
+F:	Documentation/devicetree/dynamic-resolution-notes.rst
 F:	Documentation/devicetree/overlay-notes.txt
 F:	drivers/of/overlay.c
 F:	drivers/of/resolver.c
-- 
2.25.2

