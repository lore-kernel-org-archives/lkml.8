Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A93C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB26246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137037;
	bh=YvAjHwKLIU8fwa8sAcXw6vbwjPTX7BjWDutbucnWHrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=saMv93pS9DtwADNBPJCu1QprBTtscEjNkCYViRj1Lq+xDBa6NnRRgahDq/LcsUyz0
	 zVGeWnD1WZOrH5ck3zacIFJBfYEdj9nfdLU1jdAwLN15DsAElarKUeOfpbugPeRIj/
	 kwTpP+Hh1jAzhDeZVKp9KniIB+hCMbfP1LMgk6MM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727605AbgCBIRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727363AbgCBIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:24 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C981324700;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136980;
        bh=YvAjHwKLIU8fwa8sAcXw6vbwjPTX7BjWDutbucnWHrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ujPRb9lhai6dBjo+hmh1HOTUOY6vyBc2qkBxAuNf8pUdcTjYJWFwfMxtc5gBHXjGq
         ZPci3TxxH4k4yZ8ldBYUZRTNP3siO8/XTDJEgRGtvkGVSNLRQefunUDxys+PKD+npv
         oABLnX7b9ESFQMQCaMe/4SsEdiYt4O0UG5o5s4zU=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFO-0003zZ-0K; Mon, 02 Mar 2020 09:16:18 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 37/42] docs: scsi: convert sym53c500_cs.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:10 +0100
Message-Id: <eff6166b3442ddb37b934bca46e7f9ef25ebc2a4.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/scsi/index.rst                              | 1 +
 Documentation/scsi/{sym53c500_cs.txt => sym53c500_cs.rst} | 8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)
 rename Documentation/scsi/{sym53c500_cs.txt => sym53c500_cs.rst} (89%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 0cc2cfca7474..00584fb0588c 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -41,5 +41,6 @@ Linux SCSI Subsystem
    sd-parameters
    smartpqi
    st
+   sym53c500_cs
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/sym53c500_cs.txt b/Documentation/scsi/sym53c500_cs.rst
similarity index 89%
rename from Documentation/scsi/sym53c500_cs.txt
rename to Documentation/scsi/sym53c500_cs.rst
index 75febcf9298c..55464861bbd5 100644
--- a/Documentation/scsi/sym53c500_cs.txt
+++ b/Documentation/scsi/sym53c500_cs.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=======================
+The sym53c500_cs Driver
+=======================
+
 The sym53c500_cs driver originated as an add-on to David Hinds' pcmcia-cs
 package, and was written by Tom Corner (tcorner@via.at).  A rewrite was
 long overdue, and the current version addresses the following concerns:
@@ -20,4 +26,4 @@ Through the years, there have been a number of downloads of the pcmcia-cs
 version of this driver, and I guess it worked for those users.  It worked
 for Tom Corner, and it works for me.  Your mileage will probably vary.
 
---Bob Tracy (rct@frus.com)
+Bob Tracy (rct@frus.com)
-- 
2.21.1

