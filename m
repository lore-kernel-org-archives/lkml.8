Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE02DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96530246A1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583134719;
	bh=4uAsxGGUcqUWD/COuQVojB5OTTc8bDuMT4ZGz9MSG9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LpALi40K1a3Ez5pxLYbBNsdsbrnozziWKUI+F6iEZanbfNdn6PNVgPvjPGY0s+kq+
	 b2M4IbnfdmTaLtkFA8s2bhQSg5DcM0x66Zze8WYh+78aK4NAMXVmpCRcSLPQ6WlhqW
	 74lDxIZ2H0HIWsa09bXaX2scNQYK7rLDxNF0nyEo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCBHiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:38:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:44686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbgCBHiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:38:15 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 70280246BF;
        Mon,  2 Mar 2020 07:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583134694;
        bh=4uAsxGGUcqUWD/COuQVojB5OTTc8bDuMT4ZGz9MSG9c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DroSkeJpB0zHiDpXSFIGonVn1/BcR3QNlVJNL2X1qV6+aLPE9ARbe0fulx7ywkzm4
         w3nTQordNzMA/Fl5BT3Js+puaHTM8yfcTqZdM720A8vQLQ0KKK6AKMZbjJxbDpVluo
         1IF5VmQ82R7ZPOCvEyOtFS41dsE1AuxoePtHExxM=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8feW-0003Vy-0g; Mon, 02 Mar 2020 08:38:12 +0100
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 09/12] docs: dt: minor adjustments at writing-schema.rst
Date:   Mon,  2 Mar 2020 08:38:04 +0100
Message-Id: <b1e47ef85472a9a98aae12911c76c0e45a557cf4.1583134242.git.mchehab+samsung@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583134242.git.mchehab+samsung@kernel.org>
References: <cover.1583134242.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

There are two literal blocks that aren't mark as such. Mark them,
in order to make the document to produce a better html output.

While here, also add a SPDX header to it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/devicetree/writing-schema.rst | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/writing-schema.rst b/Documentation/devicetree/writing-schema.rst
index 7635ab230456..6b3ef308c59f 100644
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
2.21.1

