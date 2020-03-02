Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D97C3F2D6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19DFE246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583136025;
	bh=hAwgYv9I6N9FUJGWAzMXgm110Nj2KkkEzJ/96xJ9rhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZHSJJYgJbud/2gnPz67YeKKTSojiIXbKnZOelVzKONkwHEhaHSk5MuvxuadzftA8s
	 0HZmBuoDCyVcgiDFUgPpJQFdm87gh3p1z1E4CGuHpaSueWCWlWAQnRp1gLQibbokp4
	 E2o8UIvmBV8qN6pjRU8mltTa+KcGas7NyeBVnwtM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCBIAX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 03:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:51254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbgCBH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:42 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 508F2246B4;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135981;
        bh=hAwgYv9I6N9FUJGWAzMXgm110Nj2KkkEzJ/96xJ9rhA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DtuRZwDZzTHdH/U/FoYolrNitNUpxrn358lOut/uaRSo6czfCfN2aLgwGYT+B1X5z
         M3dwITItj3TmJy217CsbiyX26YYesBbkZOHcS9o/Nal6jFVu0F6c1O5FQMf/NgWb89
         ckIM7ZIVAotsJRga2Pt3cNy48Q7Eh4Hvq36YJtgo=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003gd-45; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 05/12] docs: dt: convert changesets to ReST
Date:   Mon,  2 Mar 2020 08:59:30 +0100
Message-Id: <b03ed74ccc14d1a9710702fda9b9a6d7d0a7d136.1583135507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add a SPDX header;
- Add a document title;
- Some whitespace fixes and new line breaks;
- Add it to devicetree/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../{changesets.txt => changesets.rst}        | 24 ++++++++++++-------
 Documentation/devicetree/index.rst            |  1 +
 2 files changed, 16 insertions(+), 9 deletions(-)
 rename Documentation/devicetree/{changesets.txt => changesets.rst} (59%)

diff --git a/Documentation/devicetree/changesets.txt b/Documentation/devicetree/changesets.rst
similarity index 59%
rename from Documentation/devicetree/changesets.txt
rename to Documentation/devicetree/changesets.rst
index cb488eeb6353..c7fd8cd6a270 100644
--- a/Documentation/devicetree/changesets.txt
+++ b/Documentation/devicetree/changesets.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=============
+DT Changesets
+=============
+
 A DT changeset is a method which allows one to apply changes
 in the live tree in such a way that either the full set of changes
 will be applied, or none of them will be. If an error occurs partway
@@ -15,17 +21,17 @@ The sequence of a changeset is as follows.
 1. of_changeset_init() - initializes a changeset
 
 2. A number of DT tree change calls, of_changeset_attach_node(),
-of_changeset_detach_node(), of_changeset_add_property(),
-of_changeset_remove_property, of_changeset_update_property() to prepare
-a set of changes. No changes to the active tree are made at this point.
-All the change operations are recorded in the of_changeset 'entries'
-list.
+   of_changeset_detach_node(), of_changeset_add_property(),
+   of_changeset_remove_property, of_changeset_update_property() to prepare
+   a set of changes. No changes to the active tree are made at this point.
+   All the change operations are recorded in the of_changeset 'entries'
+   list.
 
 3. of_changeset_apply() - Apply the changes to the tree. Either the
-entire changeset will get applied, or if there is an error the tree will
-be restored to the previous state. The core ensures proper serialization
-through locking. An unlocked version __of_changeset_apply is available,
-if needed.
+   entire changeset will get applied, or if there is an error the tree will
+   be restored to the previous state. The core ensures proper serialization
+   through locking. An unlocked version __of_changeset_apply is available,
+   if needed.
 
 If a successfully applied changeset needs to be removed, it can be done
 with of_changeset_revert().
diff --git a/Documentation/devicetree/index.rst b/Documentation/devicetree/index.rst
index 6b4daf252375..64c78c3ffea6 100644
--- a/Documentation/devicetree/index.rst
+++ b/Documentation/devicetree/index.rst
@@ -10,3 +10,4 @@ Open Firmware and Device Tree
    usage-model
    writing-schema
    booting-without-of
+   changesets
-- 
2.21.1

