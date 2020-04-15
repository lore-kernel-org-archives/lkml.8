Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B57EAC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82DA52076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586962045;
	bh=a1eyqEdmzN0DfOJU1eSZCMjYbz9xksLR9xHit1mh8r8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UAsew7msPs0kzMwdv7pJft+xff9wLgfJL0Xe0UgJ+j+en1LleN8bk+/nUEuNXs4hR
	 ISl3oYSvSOjuZyoniix1kzqkr6DpwDwFQFjJ+POvi0LshwZJmcn+50r+PMN8qFE3+C
	 DUra3aI3D6mnlnLyFnz8R3VWYjIqqkVGE5iCy+Ek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370974AbgDOOrX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:47:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2634635AbgDOOp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:29 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F8A2137B;
        Wed, 15 Apr 2020 14:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=a1eyqEdmzN0DfOJU1eSZCMjYbz9xksLR9xHit1mh8r8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KlheR7OZFIOZpLzBn7hNLdU5/4QWs9zy1nGbgebiwZPxdc7gz9ORQLmmN2kqVAghY
         qnx7Plkm62MtehKP6H32vzSjXKortR29qSDIKrXpMnTyN0W2CMHGiyJlOGx7xePZFE
         oRh4oZyTVgDMkWMaN2mnYAFzbte9+bclBUI/Xkgg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZB-2c; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v3 01/12] docs: dt: add an index.rst file for devicetree
Date:   Wed, 15 Apr 2020 16:45:15 +0200
Message-Id: <ccce3ccc02f7b4cbb90558065de38858b9e37c3c.1586961793.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586961793.git.mchehab+huawei@kernel.org>
References: <cover.1586961793.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some device tree documentation under
Documentation/devicetree. Add a top index file for it and
add the already-existing ReST file on it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/index.rst | 10 ++++++++++
 Documentation/index.rst            |  3 +++
 2 files changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/index.rst

diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
new file mode 100644
index 000000000000..a11efe26f205
--- /dev/null
+++ b/Documentation/devicetree/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Open Firmware and Device Tree
+=============================
+
+.. toctree::
+   :maxdepth: 1
+
+   writing-schema
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 9599c0f3eea8..c7f89cb204d1 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 
 .. The Linux Kernel documentation master file, created by
    sphinx-quickstart on Fri Feb 12 13:51:46 2016.
@@ -46,6 +48,7 @@ platform firmwares.
    :maxdepth: 2
 
    firmware-guide/index
+   devicetree/index
 
 Application-developer documentation
 -----------------------------------
-- 
2.25.2

