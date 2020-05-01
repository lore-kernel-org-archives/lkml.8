Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC79C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92CCA20857
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588344501;
	bh=qoesf/pikHW5qumVbLYfFVF8BO0lhg2hToZMNW2/WYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LfiCQt/2OQimy+x79d53y2HrBt0/XzNTK2A7zdSFUpwGUuO2thF/Hq4nTB0/k310n
	 CiHNcAU0kqR16S0JbU8xD/TDKbY4w2H8Z5rS2nyYXlcM8+koTj7Z/yvXIFGSp0vOHO
	 ghupwVGufswvVtrPfUbo+2ZJ9NC22kLiFeZyYnQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730474AbgEAOsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:48:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729429AbgEAOpI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:45:08 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDDBA24984;
        Fri,  1 May 2020 14:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344306;
        bh=qoesf/pikHW5qumVbLYfFVF8BO0lhg2hToZMNW2/WYY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1IK3gHy0D0n8UNJ3VhvGaAePgymDzKvpkMLHAOsFFqg7sRN380hN1bqFDaS2ywSHa
         maVfamgBbyk3GP+AXlSxwMm3n3tp+h555xuXR5MXqut0iajv8PUtRUM1SdA0JsUXaB
         SNr6Kd9h/junPAB2H2AJ6UcfrHIvfWjP4leYYW00=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jUWuT-00FCdE-Fe; Fri, 01 May 2020 16:45:01 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH 10/37] docs: networking: convert xfrm_sysctl.txt to ReST
Date:   Fri,  1 May 2020 16:44:32 +0200
Message-Id: <2c800246ef016f9a3773bcc1617ed55c8da37e37.1588344146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1588344146.git.mchehab+huawei@kernel.org>
References: <cover.1588344146.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not much to be done here:

- add SPDX header;
- add a document title;
- add a chapter's markup;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst                         | 1 +
 .../networking/{xfrm_sysctl.txt => xfrm_sysctl.rst}        | 7 +++++++
 2 files changed, 8 insertions(+)
 rename Documentation/networking/{xfrm_sysctl.txt => xfrm_sysctl.rst} (52%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index ec83bd95e4e9..1630801cec19 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -120,6 +120,7 @@ Contents:
    xfrm_device
    xfrm_proc
    xfrm_sync
+   xfrm_sysctl
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/xfrm_sysctl.txt b/Documentation/networking/xfrm_sysctl.rst
similarity index 52%
rename from Documentation/networking/xfrm_sysctl.txt
rename to Documentation/networking/xfrm_sysctl.rst
index 5bbd16792fe1..47b9bbdd0179 100644
--- a/Documentation/networking/xfrm_sysctl.txt
+++ b/Documentation/networking/xfrm_sysctl.rst
@@ -1,4 +1,11 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============
+XFRM Syscall
+============
+
 /proc/sys/net/core/xfrm_* Variables:
+====================================
 
 xfrm_acq_expires - INTEGER
 	default 30 - hard timeout in seconds for acquire requests
-- 
2.25.4

