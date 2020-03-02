Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC15C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E233246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583137049;
	bh=TedJRCCkSL0w21M1N2Y8vbZhKIe2wnJsDAcEp4djbEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Gw8leahi96m2xgjOo4drj+UZ2/xG6goD3o52G3Qdj+5+V+j4Fp4dkJEyPN8HupU7f
	 qtNAy+6dx96DOeDeXwRzQTHh5HW4s7R/GifxNt2JG/CqOH6o+TnYpCrx01s+o/FSIG
	 tPTh9QnFajFGsCzSLeJtpxa6Irn1TceZjKlE5vbE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCBIR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:17:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:57366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727336AbgCBIQY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 03:16:24 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B57A1246FC;
        Mon,  2 Mar 2020 08:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583136979;
        bh=TedJRCCkSL0w21M1N2Y8vbZhKIe2wnJsDAcEp4djbEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YhOovMWcOI8RcurY0dZyqY8dPSA7Of74Tt2SkKN9Q826an4TSJB8OAGKd6hiaey+i
         ENjSsf/UWEE7vrC/9an17e5EmsMs9R0HiiRcp9PXwpslOsu3DQR1VAxOFas0Sl3sjH
         VtopjO/61/xngAsVEWZ9vCvsefoH5/35liQ0ntV4=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8gFN-0003zK-Tg; Mon, 02 Mar 2020 09:16:17 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 34/42] docs: scsi: convert sd-parameters.txt to ReST
Date:   Mon,  2 Mar 2020 09:16:07 +0100
Message-Id: <8d0b75b0faf13a2e81373570d6ce601b629fb22a.1583136624.git.mchehab+huawei@kernel.org>
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
 Documentation/scsi/index.rst                  |  1 +
 .../{sd-parameters.txt => sd-parameters.rst}  | 21 ++++++++++++-------
 2 files changed, 14 insertions(+), 8 deletions(-)
 rename Documentation/scsi/{sd-parameters.txt => sd-parameters.rst} (37%)

diff --git a/Documentation/scsi/index.rst b/Documentation/scsi/index.rst
index 97276e425f25..6805e157b6e8 100644
--- a/Documentation/scsi/index.rst
+++ b/Documentation/scsi/index.rst
@@ -38,5 +38,6 @@ Linux SCSI Subsystem
    scsi_mid_low_api
    scsi-parameters
    scsi
+   sd-parameters
 
    scsi_transport_srp/figures
diff --git a/Documentation/scsi/sd-parameters.txt b/Documentation/scsi/sd-parameters.rst
similarity index 37%
rename from Documentation/scsi/sd-parameters.txt
rename to Documentation/scsi/sd-parameters.rst
index 8e5af00d88e7..87d554008bfb 100644
--- a/Documentation/scsi/sd-parameters.txt
+++ b/Documentation/scsi/sd-parameters.rst
@@ -1,3 +1,6 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
 Linux SCSI Disk Driver (sd) Parameters
 ======================================
 
@@ -5,18 +8,20 @@ cache_type (RW)
 ---------------
 Enable/disable drive write & read cache.
 
- cache_type string          | WCE RCD | Write cache | Read cache
-----------------------------+---------+-------------+------------
- write through              | 0   0   | off         | on
- none                       | 0   1   | off         | off
- write back                 | 1   0   | on          | on
- write back, no read (daft) | 1   1   | on          | off
+===========================   === ===   ===========   ==========
+ cache_type string            WCE RCD   Write cache   Read cache
+===========================   === ===   ===========   ==========
+ write through                0   0     off           on
+ none                         0   1     off           off
+ write back                   1   0     on            on
+ write back, no read (daft)   1   1     on            off
+===========================   === ===   ===========   ==========
 
-To set cache type to "write back" and save this setting to the drive:
+To set cache type to "write back" and save this setting to the drive::
 
   # echo "write back" > cache_type
 
 To modify the caching mode without making the change persistent, prepend
-"temporary " to the cache type string. E.g.:
+"temporary " to the cache type string. E.g.::
 
   # echo "temporary write back" > cache_type
-- 
2.21.1

