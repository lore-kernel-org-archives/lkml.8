Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50825C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220E9206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586360922;
	bh=YrKwSCyyL6nlO0cCOhfxnQbvUXb9v0CXNYMRM9FudAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cUvAjmZl6SB2NWNhs9y1YCu5Bo5EZpUuRs43O0DZEN/XUJtRM7K2vX5zIE4KAXi56
	 R+wp44byjUPY5Hb76wtVmaPwoaSg5Y6JjKnh3jfICDQB+y1ICDOQ0x5nXXHbCvkg3p
	 7JPe/d9a6RrzLusu7zXzIQLslOTzO2vdMufJYEkA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729793AbgDHPsc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:48:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:49356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729663AbgDHPqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:46:32 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 720FD21744;
        Wed,  8 Apr 2020 15:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586360791;
        bh=YrKwSCyyL6nlO0cCOhfxnQbvUXb9v0CXNYMRM9FudAE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V2yl18RL6fQ8x84NU8RCm7vM++jqIRw3e3wNGTchAaAKSMi2CB5aLvyZKlZW/r+MJ
         w6tywCe8nxmFlztFY4P6rJUAGDTN6VbSHvpUJvgbvg79nSp3UBFIu9jxqd6NvrcoKU
         t7lL0pf/oAEuhBEdZerOagYAvXl3/8jjGtFq3EmM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jMCuL-000cBS-KZ; Wed, 08 Apr 2020 17:46:29 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org
Subject: [PATCH 15/35] docs: ras: get rid of some warnings
Date:   Wed,  8 Apr 2020 17:46:07 +0200
Message-Id: <d503dfb10c86f453de27511158c96a396a9f53de.1586359676.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <cover.1586359676.git.mchehab+huawei@kernel.org>
References: <cover.1586359676.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sphinx produce some warnings due to a bad table format:

    Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/admin-guide/ras.rst:358: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.
    Documentation/admin-guide/ras.rst:363: WARNING: Definition list ends without a blank line; unexpected unindent.

Rearrange the things there in order to supress the warnings
while being precise at the Sphinx output about how ranks are
mapped into csrows.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/admin-guide/ras.rst | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/ras.rst b/Documentation/admin-guide/ras.rst
index 0310db624964..22b31bc7e129 100644
--- a/Documentation/admin-guide/ras.rst
+++ b/Documentation/admin-guide/ras.rst
@@ -351,15 +351,17 @@ controllers. The following example will assume 2 channels:
 	+------------+-----------+-----------+
 	|            |  ``ch0``  |  ``ch1``  |
 	+============+===========+===========+
-	| ``csrow0`` |  DIMM_A0  |  DIMM_B0  |
-	|            |   rank0   |   rank0   |
-	+------------+     -     |     -     |
+	|            |**DIMM_A0**|**DIMM_B0**|
+	+------------+-----------+-----------+
+	| ``csrow0`` |   rank0   |   rank0   |
+	+------------+-----------+-----------+
 	| ``csrow1`` |   rank1   |   rank1   |
 	+------------+-----------+-----------+
-	| ``csrow2`` |  DIMM_A1  | DIMM_B1   |
-	|            |   rank0   |   rank0   |
-	+------------+     -     |     -     |
-	| ``csrow3`` |   rank1   |   rank1   |
+	|            |**DIMM_A1**|**DIMM_B1**|
+	+------------+-----------+-----------+
+	| ``csrow2`` |    rank0  |  rank0    |
+	+------------+-----------+-----------+
+	| ``csrow3`` |    rank1  |  rank1    |
 	+------------+-----------+-----------+
 
 In the above example, there are 4 physical slots on the motherboard
-- 
2.25.2

