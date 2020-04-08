Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172DCC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB8CD206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360842;
	bh=wsFZ0dq0htlamdDYAFNWLSa+EU5LvOOu2mo8l16eQAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=N3/QH8ataEs3t5LN7zc8rkzszXjDreBqw8NDQoTNQwuq0/zybOvMpEA17SMIzpOdl
	 fr7nlTDjBidGeINoTc7Q/4eMWgi32JlJ9ITMV78HwgZsfZEBnGgmmC55PfT3JR9A4L
	 Xi5/Kl0c0KYdq+QjQ4mXsoaMehDPCBJS5oMfftwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729870AbgDHPrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:47:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:49612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729706AbgDHPqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2088F22204;
        Wed,  8 Apr 2020 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360792;
        bh=wsFZ0dq0htlamdDYAFNWLSa+EU5LvOOu2mo8l16eQAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qgf/T2zWW53ulxhSMkpAJKoE6cbLNYvi2ZXiHtCfeOl7GrizrQVWWO+WmUB4PX11X
         LDZEQymc+917N1Vc0OsPnyVl42H3/zmkfqL/1S3uO4WTqU+YdxjlndAPgwqaUjm0zV
         EXlnz0J91odctiZHwUzdQy3cYv86mark+HOMw6bw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuM-000cCz-AX; Wed, 08 Apr 2020 17:46:30 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 34/35] docs: Makefile: place final pdf docs on a separate dir
Date:   Wed,  8 Apr 2020 17:46:26 +0200
Message-Id: <0bd1eb674eb35e5f2823f66942fceef450b6c19c.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Sphinx build system for PDF is too complex and generate
lots of ancillary files, including one PDF file for each
image.

So, at the end, the main latex dir has 156 pdf files, instead
of the 71 ones that would match each generated book. That's
confusing and it makes harder to identify when something didn't
work.

So, instead, let's move the final PDF output(s) to a separate
dir. This way, the latex/ dir will have the temporary and the
final *.tex files, while the final pdf files that built ok
will be under the pdf/ directory.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index cc786d11a028..db1fc35ded50 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -98,7 +98,11 @@ else # HAVE_PDFLATEX
 
 pdfdocs: latexdocs
 	@$(srctree)/scripts/sphinx-pre-install --version-check
-	$(foreach var,$(SPHINXDIRS), $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" -C $(BUILDDIR)/$(var)/latex || exit;)
+	$(foreach var,$(SPHINXDIRS), \
+	   $(MAKE) PDFLATEX="$(PDFLATEX)" LATEXOPTS="$(LATEXOPTS)" -C $(BUILDDIR)/$(var)/latex || exit; \
+	   mkdir -p $(BUILDDIR)/$(var)/pdf; \
+	   mv $(subst .tex,.pdf,$(wildcard $(BUILDDIR)/$(var)/latex/*.tex)) $(BUILDDIR)/$(var)/pdf/; \
+	)
 
 endif # HAVE_PDFLATEX
 
-- 
2.25.2

