Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A556BC2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7476220678
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586883204;
	bh=wsFZ0dq0htlamdDYAFNWLSa+EU5LvOOu2mo8l16eQAI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YIW4A7NZrDK2lSNpN/H8o3bCvpVReU7R9h8EyNhWYwhEtsThUzipiI0/KsQFzjvWS
	 66UTpoxLl9gyYReg3nNVyW7fLDuL+vJAPAaMid6uHdbEiw6pfMGk/VPYf0EnuNPmjD
	 h9cTaXv97wtxztdbDG3Cek7C2WqS/1Lspq0+6lcY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440743AbgDNQxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 12:53:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:55258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440353AbgDNQtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:49:17 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DF4F221F5;
        Tue, 14 Apr 2020 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586882943;
        bh=wsFZ0dq0htlamdDYAFNWLSa+EU5LvOOu2mo8l16eQAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=00QR/v378l2mpUnh0nK73LuCv/8q/0eesk/z3uzf0VgvoSwSqOOcDCwX8S2njiOs0
         3hy4iTymKnKAiS5/E+7U2OBC4ZcSvlXF28iVV76b0vfnEuK5hWEw7o2WQbVEBaXbYu
         XckvIBStzCWMNh7g4sks/dzawmUMNBPOteB9rSAY=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOOk9-0068n3-Dn; Tue, 14 Apr 2020 18:49:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 27/33] docs: Makefile: place final pdf docs on a separate dir
Date:   Tue, 14 Apr 2020 18:48:53 +0200
Message-Id: <832752cbc9678a6e8d3d634bc3356d655d44684f.1586881715.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586881715.git.mchehab+huawei@kernel.org>
References: <cover.1586881715.git.mchehab+huawei@kernel.org>
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

