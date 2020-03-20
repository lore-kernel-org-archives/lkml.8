Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77DDFC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6162072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 15:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584717079;
	bh=wudnCbbJkjczxJlVMnm2x1ea/nxbRMb1+tCH6Lys7I0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ycwo0/zYe6pzrcCUb46Pf7VTpeqiKbJuG8MsaXeUqtjfMQvrvOQ40J4cpxRamRWrm
	 5t1sNGZziNZ0L0VpgKir+vcJ/TtDcPaV2Tmii1CizYaYikVj7Vvtv+GDHyX/3kTJtq
	 07F38xk5b4Qkq8xRM59WB9BmERKYVm1TokC+Yljg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgCTPLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 11:11:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:56046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726913AbgCTPLH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 11:11:07 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A31032072C;
        Fri, 20 Mar 2020 15:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584717066;
        bh=wudnCbbJkjczxJlVMnm2x1ea/nxbRMb1+tCH6Lys7I0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Nd3IfO1Jz3ojOLpMXR8IcWgatHz1bSFvGmD3lf26kmG0hyvaeI27BhRWgoKQvJ02n
         aKePetfzIEYKee/x3WlS4K37C6KIsgCULzuH+UIzjPRFjTNuv0S0bX4BWb/zeaNa6U
         LNcpnFxFqBQtDet+MgrYxPVjzTP8r8afTfGpnf+w=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jFJIe-000ukj-Kb; Fri, 20 Mar 2020 16:11:04 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 2/2] docs: conf.py: avoid thousands of duplicate label warning on Sphinx
Date:   Fri, 20 Mar 2020 16:11:03 +0100
Message-Id: <74f4d8d91c648d7101c45b4b99cc93532f4dadc6.1584716446.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584716446.git.mchehab+huawei@kernel.org>
References: <cover.1584716446.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The autosectionlabel extension is nice, as it allows to refer to
a section by its name without requiring any extra tag to create
a reference name.

However, on its default, it has two serious problems:

1) the namespace is global. So, two files with different
   "introduction" section would create a label with the
   same name. This is easily solvable by forcing the extension
   to prepend the file name with:

	autosectionlabel_prefix_document = True

2) It doesn't work hierarchically. So, if there are two level 1
   sessions (let's say, one labeled "open" and another one "ioctl")
   and both have a level 2 "synopsis" label, both section 2 will
   have the same identical name.

   Currently, there's no way to tell Sphinx to create an
   hierarchical reference like:

		open / synopsis
		ioctl / synopsis

  This causes around 800 warnings. So, the fix should be to
  not let autosectionlabel to produce references for anything
  that it is not at a chapter level within any doc, with:

	autosectionlabel_maxdepth = 2

Fixes: 58ad30cf91f0 ("docs: fix reference to core-api/namespaces.rst")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index fa2bfcd6df1d..9ae8e9abf846 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -40,6 +40,10 @@ extensions = ['kerneldoc', 'rstFlatTable', 'kernel_include', 'cdomain',
               'kfigure', 'sphinx.ext.ifconfig', 'automarkup',
               'maintainers_include', 'sphinx.ext.autosectionlabel' ]
 
+# Ensure that autosectionlabel will produce unique names
+autosectionlabel_prefix_document = True
+autosectionlabel_maxdepth = 2
+
 # The name of the math extension changed on Sphinx 1.4
 if (major == 1 and minor > 3) or (major > 1):
     extensions.append("sphinx.ext.imgmath")
-- 
2.24.1

