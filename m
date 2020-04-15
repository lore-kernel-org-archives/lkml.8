Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568C6C38A29
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303532076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 14:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586961988;
	bh=ygdLxe7J62lfuyTfl7GYvfFKZVzkmZyuH6fwVFe7bTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Dk5sOchCoSqN19+k3wJwhSBYLyGpeKmEkWL4OnKRnLMLLcB1dSLMng2LEGzhHY7HO
	 iDlSf6L6HgNkrwaIbmwSDuCCFMgnBBe42qDd6MoLkKpSi5DX6kjqISZL1uC5jmgd2e
	 FhePHBtAaLXMl8xhnJQY3BfGn0d2XXHJjeAfn54I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636836AbgDOOq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 10:46:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:40252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636794AbgDOOpd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:45:33 -0400
Received: from mail.kernel.org (ip5f5ad4d8.dynamic.kabel-deutschland.de [95.90.212.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F1EC21841;
        Wed, 15 Apr 2020 14:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586961929;
        bh=ygdLxe7J62lfuyTfl7GYvfFKZVzkmZyuH6fwVFe7bTA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ad/xTao9wbvey6I7S429/jl7sCbbJcL2DXT6bIxDQVzSw0ZXhGkVKnwz5xFlq7jEK
         G/hxdauQyDp40xJbrr9DK0tm69g5W5ENN1CCEv6Ea5V3u95q/vWFf8UkCdK25uapgc
         7w6tJgkC0CXoQSwasdCOEJwxXF2Ae2XN+gIdiYCg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jOjI7-006kZz-Ga; Wed, 15 Apr 2020 16:45:27 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 11/12] docs: dt: convert submitting-patches.txt to ReST format
Date:   Wed, 15 Apr 2020 16:45:25 +0200
Message-Id: <887f9e25944831d8c285a80e4deeea5b1cf38803.1586961793.git.mchehab+huawei@kernel.org>
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
- Adjust document and section titles;
- Mark literal blocks as such;
- Add it to bindings/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/index.rst          |  1 +
 ...submitting-patches.txt => submitting-patches.rst} | 12 +++++++++---
 .../devicetree/bindings/writing-bindings.txt         |  2 +-
 Documentation/process/submitting-patches.rst         |  2 +-
 .../it_IT/process/submitting-patches.rst             |  2 +-
 scripts/checkpatch.pl                                |  2 +-
 6 files changed, 14 insertions(+), 7 deletions(-)
 rename Documentation/devicetree/bindings/{submitting-patches.txt => submitting-patches.rst} (92%)

diff --git a/Documentation/devicetree/bindings/index.rst b/Documentation/devicetree/bindings/index.rst
index 98ebdab24b51..6b87875a049c 100644
--- a/Documentation/devicetree/bindings/index.rst
+++ b/Documentation/devicetree/bindings/index.rst
@@ -8,3 +8,4 @@ Device Tree
    :maxdepth: 1
 
    ABI
+   submitting-patches
diff --git a/Documentation/devicetree/bindings/submitting-patches.txt b/Documentation/devicetree/bindings/submitting-patches.rst
similarity index 92%
rename from Documentation/devicetree/bindings/submitting-patches.txt
rename to Documentation/devicetree/bindings/submitting-patches.rst
index 98bee6240b65..0aab2b3f16d0 100644
--- a/Documentation/devicetree/bindings/submitting-patches.txt
+++ b/Documentation/devicetree/bindings/submitting-patches.rst
@@ -1,13 +1,17 @@
+.. SPDX-License-Identifier: GPL-2.0
 
-  Submitting devicetree (DT) binding patches
+==========================================
+Submitting devicetree (DT) binding patches
+==========================================
 
 I. For patch submitters
+=======================
 
   0) Normal patch submission rules from Documentation/process/submitting-patches.rst
      applies.
 
   1) The Documentation/ and include/dt-bindings/ portion of the patch should
-     be a separate patch. The preferred subject prefix for binding patches is:
+     be a separate patch. The preferred subject prefix for binding patches is::
 
        "dt-bindings: <binding dir>: ..."
 
@@ -17,7 +21,7 @@ I. For patch submitters
 
   2) DT binding files are written in DT schema format using json-schema
      vocabulary and YAML file format. The DT binding files must pass validation
-     by running:
+     by running::
 
        make dt_binding_check
 
@@ -60,6 +64,7 @@ I. For patch submitters
 
 
 II. For kernel maintainers
+==========================
 
   1) If you aren't comfortable reviewing a given binding, reply to it and ask
      the devicetree maintainers for guidance.  This will help them prioritize
@@ -76,6 +81,7 @@ II. For kernel maintainers
      kept with the driver using the binding.
 
 III. Notes
+==========
 
   0) Please see ...bindings/ABI.txt for details regarding devicetree ABI.
 
diff --git a/Documentation/devicetree/bindings/writing-bindings.txt b/Documentation/devicetree/bindings/writing-bindings.txt
index 27dfd2d8016e..ca024b9c7433 100644
--- a/Documentation/devicetree/bindings/writing-bindings.txt
+++ b/Documentation/devicetree/bindings/writing-bindings.txt
@@ -4,7 +4,7 @@ This is a list of common review feedback items focused on binding design. With
 every rule, there are exceptions and bindings have many gray areas.
 
 For guidelines related to patches, see
-Documentation/devicetree/bindings/submitting-patches.txt
+Documentation/devicetree/bindings/submitting-patches.rst
 
 
 Overall design
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index ba5e944c7a63..1699b7f8e63a 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -16,7 +16,7 @@ for a list of items to check before
 submitting code.  If you are submitting a driver, also read
 :ref:`Documentation/process/submitting-drivers.rst <submittingdrivers>`;
 for device tree binding patches, read
-Documentation/devicetree/bindings/submitting-patches.txt.
+Documentation/devicetree/bindings/submitting-patches.rst.
 
 Many of these steps describe the default behavior of the ``git`` version
 control system; if you use ``git`` to prepare your patches, you'll find much
diff --git a/Documentation/translations/it_IT/process/submitting-patches.rst b/Documentation/translations/it_IT/process/submitting-patches.rst
index cba1f8cb61ed..7c23c08e4401 100644
--- a/Documentation/translations/it_IT/process/submitting-patches.rst
+++ b/Documentation/translations/it_IT/process/submitting-patches.rst
@@ -21,7 +21,7 @@ Leggete anche :ref:`Documentation/translations/it_IT/process/submit-checklist.rs
 per una lista di punti da verificare prima di inviare del codice.  Se state
 inviando un driver, allora leggete anche :ref:`Documentation/translations/it_IT/process/submitting-drivers.rst <it_submittingdrivers>`;
 per delle patch relative alle associazioni per Device Tree leggete
-Documentation/devicetree/bindings/submitting-patches.txt.
+Documentation/devicetree/bindings/submitting-patches.rst.
 
 Molti di questi passi descrivono il comportamento di base del sistema di
 controllo di versione ``git``; se utilizzate ``git`` per preparare le vostre
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index d64c67b67e3c..7d237a4598ae 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -2594,7 +2594,7 @@ sub process {
 				if (($last_binding_patch != -1) &&
 				    ($last_binding_patch ^ $is_binding_patch)) {
 					WARN("DT_SPLIT_BINDING_PATCH",
-					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.txt\n");
+					     "DT binding docs and includes should be a separate patch. See: Documentation/devicetree/bindings/submitting-patches.rst\n");
 				}
 			}
 
-- 
2.25.2

