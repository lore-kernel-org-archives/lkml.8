Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B60CC3F2D6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5701124699
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583135998;
	bh=2/DNAapS2UOdSVGxm+XzjadCyyFdTsbsMdhV6JX9eVk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mr6aIfWYCnwCyTKzW6bm3jUF7kCPBtEAr6kJ62cUJmlBYXjikxAyUcgmdgczYxtn3
	 Q3z2Gb4GE7FuS7hBmIwpu6nHv8Bf954YmusDbMGQKLKN1Rb+acD5+ysbb/YLAbpTa2
	 5/dyB/arrwHwLdA9aFi9norKUo1TZIQIO0m1pMaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727250AbgCBH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgCBH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:42 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C2C5246C0;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135981;
        bh=2/DNAapS2UOdSVGxm+XzjadCyyFdTsbsMdhV6JX9eVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u9joVP2T5KLYLdFWkyDwgZHFxLQK1nSfLm6W3LdAt7HvOYiRGQ61XtPtrNt4RjI9g
         lee1I1e4653bVCPWsX8bH88hzvzAwJzDoz/ow69+bIoYXPaECf2Y0fnaqlQwGrfDwz
         BJ8j08m2hyftr5wGaWZqMGtNw6JF+YS+yoQtvBCw=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003gv-7l; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 09/12] docs: dt: minor adjustments at writing-schema.rst
Date:   Mon,  2 Mar 2020 08:59:34 +0100
Message-Id: <b1e47ef85472a9a98aae12911c76c0e45a557cf4.1583135507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
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

