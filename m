Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D300C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C0E20739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 06:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592203710;
	bh=WD3XDwk3XqKTIwsDmt007pD/1JtEI2aiQpZ+KnRFd4Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h5UPAcXfNFBW3yVYCUMF9C1nhxswUQwa/5WQ026B4kBfkPOeC924/gNoQ5h3uemal
	 0EoFj8pzTNSHB5qozb+szuqZtuzOyoxX8fd9v5G3PKN2aB1X4jXY6rU1nree9W+lAK
	 tLx+6N1yRiL2doik/10gDd86phFGf+uBz159NMEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgFOGs2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 02:48:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728482AbgFOGrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 02:47:14 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EF6521475;
        Mon, 15 Jun 2020 06:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592203632;
        bh=WD3XDwk3XqKTIwsDmt007pD/1JtEI2aiQpZ+KnRFd4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOarKqjRszvDRsLiwYmZ0O5c1SK4VnSOniA/tgnh58gIXI15aJ1QBz/A6VXKmCiKY
         Z4YGBobU0c0/m+FeHhrOzZzv6twuSZw5ap5gNYlAe48Z5v6POtir95iMVbGWJnCfxK
         xFQzezr3yyFgaN6w8CBeyMRbhSFLfXj0DZv8UiQk=
Received: from mchehab by mail.kernel.org with local (Exim 4.93)
        (envelope-from <mchehab@kernel.org>)
        id 1jkiti-009nnz-92; Mon, 15 Jun 2020 08:47:10 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH 27/29] docs: dt: minor adjustments at writing-schema.rst
Date:   Mon, 15 Jun 2020 08:47:06 +0200
Message-Id: <14fc680fd6596b277f94bb5a240cc9dfc41d59bf.1592203542.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1592203542.git.mchehab+huawei@kernel.org>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two literal blocks that aren't mark as such. Mark them,
in order to make the document to produce a better html output.

While here, also add a SPDX header to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 220cf464ed77..8c74a99f95e2 100644
--- a/Documentation/devicetree/writing-schema.rst
+++ b/Documentation/devicetree/writing-schema.rst
@@ -1,4 +1,4 @@
-:orphan:
+.. SPDX-License-Identifier: GPL-2.0
 
 Writing DeviceTree Bindings in json-schema
 ==========================================
@@ -124,9 +124,12 @@ dtc must also be built with YAML output support enabled. This requires that
 libyaml and its headers be installed on the host system. For some distributions
 that involves installing the development package, such as:
 
-Debian:
+Debian::
+
   apt-get install libyaml-dev
-Fedora:
+
+Fedora::
+
   dnf -y install libyaml-devel
 
 Running checks
-- 
2.26.2

