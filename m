Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC722C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9659F246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583135996;
	bh=BvAP2+Ac5CWWQg9jSEg7U2i0Y3l0kjbn/dseft/RE1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FJ9kZypEt621dXZZbti/duHRr+D5vtmdUoRKuIjhHoO833YRW/mxU6HWcL07W1Kze
	 u5J5LRJHSV801VZpoe9Az6ErIB0YYu55YXcKUPZLk9KKJhhye4MR1vfIIQGsmgTxnu
	 bHNXkuSmIqF5NBgCCRnTXi3OImBNfkSTjdW5EpJk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727299AbgCBH7p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:59:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:51270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgCBH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:42 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57CC1246BE;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135981;
        bh=BvAP2+Ac5CWWQg9jSEg7U2i0Y3l0kjbn/dseft/RE1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qkiVT40kBDYyGK6jVNqv49p+9wIidRO/I78aXwpVI+57QAT5jitPaOEYJjfY3zjon
         sNwEo6Ecr9Q37bIEksSsNpUPBHtCGnZoUFHBssotyXeQ67VdJVpxsj9t3eiQE75RSt
         JpP4scvPdEBHgyrmCEZvddHgRg5NusLIXyMxNibg=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003gN-0u; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 01/12] docs: dt: add an index.rst file for devicetree
Date:   Mon,  2 Mar 2020 08:59:26 +0100
Message-Id: <535a508f48d223b4e9632117e96db18265ab6c7b.1583135507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some device tree documentation under
Documentation/devicetree. Add a top index file for it and
add the already-existing ReST file on it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/index.rst | 10 ++++++++++
 Documentation/index.rst            |  3 +++
 2 files changed, 13 insertions(+)
 create mode 100644 Documentation/devicetree/index.rst

diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
new file mode 100644
index 000000000000..a11efe26f205
--- /dev/null
+++ b/Documentation/devicetree/index.rst
@@ -0,0 +1,10 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============================
+Open Firmware and Device Tree
+=============================
+
+.. toctree::
+   :maxdepth: 1
+
+   writing-schema
diff --git a/Documentation/index.rst b/Documentation/index.rst
index e99d0bd2589d..b63d117aea15 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 
 .. The Linux Kernel documentation master file, created by
    sphinx-quickstart on Fri Feb 12 13:51:46 2016.
@@ -46,6 +48,7 @@ platform firmwares.
    :maxdepth: 2
 
    firmware-guide/index
+   devicetree/index
 
 Application-developer documentation
 -----------------------------------
-- 
2.21.1

