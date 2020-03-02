Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05194C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1778246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137169;
	bh=9oTFchzvih9EYK+ui6JQ9pAeZY8ayia5Jsa/aZ6qwIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dLkVaz+Vk3YR5UMBcPclC7Ak3eitFhdrZ6xsKjkdw6cmDzhMXoIMEAEnqeD5YTPJ1
	 CehXDvyzahvrgCh/7rxU/EGLdDiMBjlApA/uRWZ2cXyJ+bLXWAe3BAT6ha3gsjJE4j
	 H/Z5oiUODKPfVt1POEGjckwz470yKeK/rILnCPvs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgCBIT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:19:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:56592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgCBIQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:19 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C78DA222C4;
        Mon,  2 Mar 2020 08:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=9oTFchzvih9EYK+ui6JQ9pAeZY8ayia5Jsa/aZ6qwIA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmD/yqc6v2Iye9uGck39VufgybQGwWEaiHu7ZD1doNtsea+HyIGf1+dRej1TjSqun
         7KZDd1Rd3zHJlNylzQ+FWRSuxoEh5uYQ/ms8jAMtMqXJ49A5Z0UKtDNgRZ+XpniD6C
         4KI+dfhSLHtrGfybd7Q34FYdwL0Y50fZANIgeqlg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003wn-0y; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 02/42] docs: scsi: include SCSI Transport SRP diagram at the doc body
Date:   Mon,  2 Mar 2020 09:15:35 +0100
Message-Id: <419c455fb40c9a1e85cc9a654a7fdb07aeeccf71.1583136624.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583136624.git.mchehab+huawei@kernel.org>
References: <cover.1583136624.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having a separate makefile, and be alone, group
it at the SCSI documentation and make it being built as part
of docs makefile.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/scsi/index.rst                             | 2 +-
 .../scsi/scsi_transport_srp/{Makefile => figures.rst}    | 9 ++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)
 rename Documentation/scsi/scsi_transport_srp/{Makefile => figures.rst} (1%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 16baf8b0f11f..3ef7ad65372a 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -7,4 +7,4 @@ Linux SCSI Subsystem
 .. toctree::
    :maxdepth: 1
 
-
+   scsi_transport_srp/figures
diff --git a/Documentation/scsi/scsi_transport_srp/Makefile b/Documentation/scsi/scsi_transport_srp/figures.rst
similarity index 1%
rename from Documentation/scsi/scsi_transport_srp/Makefile
rename to Documentation/scsi/scsi_transport_srp/figures.rst
index 5f6b567e955c..6c8f8dd6301b 100644
--- a/Documentation/scsi/scsi_transport_srp/Makefile
+++ b/Documentation/scsi/scsi_transport_srp/figures.rst
@@ -1,7 +1,6 @@
-all: rport_state_diagram.svg rport_state_diagram.png
+.. SPDX-License-Identifier: GPL-2.0
 
-rport_state_diagram.svg: rport_state_diagram.dot
-	dot -Tsvg -o $@ $<
+SCSI RDMA (SRP) transport class diagram
+=======================================
 
-rport_state_diagram.png: rport_state_diagram.dot
-	dot -Tpng -o $@ $<
+.. kernel-figure:: rport_state_diagram.dot
-- 
2.21.1

