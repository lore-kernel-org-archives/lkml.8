Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB418C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:16:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F09246CC
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583136986;
	bh=jEdBvHitSUMnzfR+CW7WCZW5wZJypIGRLWq2T1IjxN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RIPa7EtfWor2k/S3uPO/sOcVQiRwjQA5HT2uL/POLFGK8U/9I/W2ObcJYZ3ve7mLC
	 lleJ8M/0IndpRpt36xnYTWJNlruAWK6w0M3iMglQWov1/MORReWw+Ws1N8KMeG4vyg
	 kq1Eaihz/pgvPsK9T7i0heuNmD3DbudzbXUwp5jI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgCBIQZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:16:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:57084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgCBIQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:23 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A8D63246F8;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=jEdBvHitSUMnzfR+CW7WCZW5wZJypIGRLWq2T1IjxN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n0qZE6YjdHS+ar4ZNEvf7MUFK/nX0OJvuX0TI466McslLs0m7lbxyxcW5eamodHVi
         a6XrmhpXOINDmaMfwnP52q8Byg6PscZxpCkviTCIpxHOMhLNdkU6/vAPvGhbEaybVr
         V24E7hxLFBMdc+DvlIYu87vxyMfUDWZqyOwqmkc0=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003z8-Rz; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 32/42] docs: scsi: convert scsi-parameters.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:05 +0100
Message-Id: <f00a5f6f2bf9a2562e0856ee8f45bcf9521d181f.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/index.rst                         |  1 +
 .../{scsi-parameters.txt => scsi-parameters.rst}     | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)
 rename Documentation/scsi/{scsi-parameters.txt => scsi-parameters.rst} (91%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 48337be1c3f1..4bf0bb26f3d5 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -36,5 +36,6 @@ Linux SCSI Subsystem
    scsi_fc_transport
    scsi-generic
    scsi_mid_low_api
+   scsi-parameters
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/scsi-parameters.txt b/Documentation/scsi/scsi-parameters.rst
similarity index 91%
rename from Documentation/scsi/scsi-parameters.txt
rename to Documentation/scsi/scsi-parameters.rst
index 864bbf7f737b..0c4bbb1aee94 100644
--- a/Documentation/scsi/scsi-parameters.txt
+++ b/Documentation/scsi/scsi-parameters.rst
@@ -1,16 +1,20 @@
-                          SCSI Kernel Parameters
-                          ~~~~~~~~~~~~~~~~~~~~~~
+.. SPDX-License-Identifier: GPL-2.0
+
+======================
+SCSI Kernel Parameters
+======================
 
 See Documentation/admin-guide/kernel-parameters.rst for general information on
 specifying module parameters.
 
 This document may not be entirely up to date and comprehensive. The command
-"modinfo -p ${modulename}" shows a current list of all parameters of a loadable
+``modinfo -p ${modulename}`` shows a current list of all parameters of a loadable
 module. Loadable modules, after being loaded into the running kernel, also
 reveal their parameters in /sys/module/${modulename}/parameters/. Some of these
 parameters may be changed at runtime by the command
-"echo -n ${value} > /sys/module/${modulename}/parameters/${parm}".
+``echo -n ${value} > /sys/module/${modulename}/parameters/${parm}``.
 
+::
 
 	advansys=	[HW,SCSI]
 			See header of drivers/scsi/advansys.c.
-- 
2.21.1

